Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193020551C
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097790; cv=none; b=XAkYQ0z7KEZSq3XNTwOuMAzetTOgEtWodji2OEKsL1X9BE0e6dgWvKdVByJhpKMD0nCQUrb3gEkPmD/G1k59Sr0YsX/kQyXrC138P40nmKHJEKgn79DRFew6qtF1tVeraaCH6W2GhqXIZP5wh16DkhKzX4m8SMMYc9ln1z7VYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097790; c=relaxed/simple;
	bh=ZZ+tUxCQ5Vq6r5SZVC9DDT1JjV/LpKtO0cS1gMILap8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g74rXz5Ln/PLozF/G6fQ6ve/e/iXj2gzhdEwVt/ZAF8IBt0v29xd3xkmYcWxLzOibVjv9Mb/GcvxLBtP/qForZ6CJnQzpHbB/T8LXEsaSgY2BXVHaL3cieAwDBzUyHFP1GU88YRA35LvOwe9FuKOiqkqiOZ3cG3vmUpkTYT4WKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2lSlfADE; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2lSlfADE"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d191bfeafbso22354175ab.0
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 06:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741097787; x=1741702587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMyl+oxcOIKmILwJnWXb5CChyFyffMt+pqOQjpq2JwQ=;
        b=2lSlfADEvmqLIr7E45M9jUEpVQIJtOMqq+yklTgdHvLx9ui7E92bCxWZI4cVXGleGJ
         GOsST3UPyZizVXjJ54Dyu5AfnHwIJ6F8NUSFOnW40XssUKOjhA1Obg0DgLEJTVjfoMcU
         MweqQubqEc1kI1nnYNmgG3nb32JhAqSQfJEQigq8BegjiMGF6zHk81ow7i13hbzcHh+g
         h5xKyP54t3LZLxvynULrNtM3cyt5kKF8OPpjEWdSt8gn0mF4E5Yr39OLjL2t//8bcPby
         SGsTYU9fheDKopR4cAKiZch3x8fZ15DcUuSBsl6p1wL8Rtr/jLxRxxAesuU9YfxYVEIy
         Gs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741097787; x=1741702587;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMyl+oxcOIKmILwJnWXb5CChyFyffMt+pqOQjpq2JwQ=;
        b=YtXUwaOjNLlW2OQ5cXtC17GIPEcImTN7al3EIGdm5ZTIlWzufjTYdbk4JmyuqfRB0W
         fPNsnLfXitSHrfEp1JEQxH7IjMPItDtIw6xtmT03EYvpHjNvvEd8jcnZlKHc5IrB2ygF
         dyyYmt6F1LDl9C2EMBmO8dZ0tcuysb43lG8lf9D2eZkn4fUOHu30JwmZNFsZJ1vpIy18
         5nVNCrR+MZZsEh8moyZx50uq85JHXDGwJry26ivuFi0inqGpEdB1K+H80w8CM+Yz+gR2
         XHgOscSbwakpmlTNtcOcp0jYQArDUD8CMR0um6Jlxm8eeDdoAC4nCrwArKcg5ux/8m7o
         r/Fw==
X-Gm-Message-State: AOJu0YzmH0k0M0XWfoIvzRH9xGGTvrrNcACYuPsuadhmX9oZATcy7gaY
	IxWnzAMTOwN0L9+CU0Fjyd0YSEnujI7IJ73P53iWmu/AMucoyJpCE5J/VrgEFOXlvtjScJfEuRw
	/
X-Gm-Gg: ASbGncv+zZyB+pNryOmdfx/Csp2Nzb58xEwHlgMvzaRNFl4bEjgfht05UGGDqQIaAiq
	OGFvAV3K76Sps/Nfvg8cbQvsXmm/2zPTD89wgeWd0CKZTUivgZ4kUZ0QfdXj05z5Y7rg337il4i
	Bz1duQNoTL0mqzIXiq4k2PKIb0BLeqQoAgS5jJH+kjrlju3nAuRyOVbX/zR63bBNbVqKI60ZozF
	7sWUpO91QxHXyRyhKVWsY9EEMqufj8if3gFEbmgeEBdLjN36JC4q2iWoOOqj+Rv5+nf7rLnZo12
	aU9dhVDfjG8gZ4sQcpHaB/Kldreb4NfPwNs=
X-Google-Smtp-Source: AGHT+IFj8V1lrVTGX1aEmcbIsZIMETt6qEL+1ROpr16ZBa8ONvS9TQnQWeQjOnuK1GtqqTDzWub/ww==
X-Received: by 2002:a92:c8c9:0:b0:3d3:f5fe:fea3 with SMTP id e9e14a558f8ab-3d3f5feff37mr88813775ab.9.1741097787069;
        Tue, 04 Mar 2025 06:16:27 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f1e668e5ddsm712422173.140.2025.03.04.06.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:16:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250301190317.950208-1-csander@purestorage.com>
References: <20250301190317.950208-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: don't cast registered buffer index to int
Message-Id: <174109778621.2730103.3690369290810043076.b4-ty@kernel.dk>
Date: Tue, 04 Mar 2025 07:16:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Sat, 01 Mar 2025 12:03:16 -0700, Caleb Sander Mateos wrote:
> io_buffer_register_bvec() takes index as an unsigned int argument, but
> ublk_register_io_buf() casts ub_cmd->addr (a u64) to int. Remove the
> misleading cast and instead pass index as an unsigned value to
> ublk_register_io_buf() and ublk_unregister_io_buf().
> 
> 

Applied, thanks!

[1/1] ublk: don't cast registered buffer index to int
      commit: 9e12d09cfdaf89db894abdad392bb8dcd6c0f464

Best regards,
-- 
Jens Axboe



