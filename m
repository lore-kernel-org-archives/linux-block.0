Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DD1C3054
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896138; cv=none; b=U5Bc5PB23ixyPbyycsQCSyptzpdPVvEhlvWmQMiVOE2zwuD7v16NtJhLnb7xNbiDpoWSvdcuHgVS0QVeU6PdiDAYWJoxo7L0aYZNUXmk8feQuSElbokf/IkI8LtjQpduZrtlDQfnezULGE8izsgvBIw7H/DNRBDenqTb7rb+uNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896138; c=relaxed/simple;
	bh=ZLqIegwy/9OPkRJFz9LymatoR8kXczOAXBYPAKt34o4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z/f+PF9Wd69xC8TKyu0LwbUfDWr7mXE0mCQIq2HtVVkyYaJMT/Yx2vZWKKTpPyBTEQReVG1O6lzA7ML3YQKjqi4sTyOUztkiq5nGvJFtFsrJryBN2/obktN3smZoRjXK1P27MsyXr+9rcXqHEuXdHORlz1ZuBPrCi2s/68wXlRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GhmZXsNZ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GhmZXsNZ"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so18674345ab.2
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739896135; x=1740500935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZSFheZSQhhD9BZXFMBQVD0TW1CBXyU0mBPRkFUDMV8=;
        b=GhmZXsNZb/zuvVBqj8z3udk6yxnzpr0z51JAWAZWUgah1OMpyMuUp5O+cxnLPj0IUA
         1VY0h2t5q6mu3xM31cdhRr8Uul54gKUgiFm+M92aDgdYV36r6b98mh1OEUO8Mi2YJWBh
         K3MdLPG25wwwH8eAkvGDycb6USnzwrV8FxCJaLyi8xMCmdkcOSDXArfPq3+UxBDhiOOu
         Embpmu57d49VSBj5dfnBzFhCGPEy+VhKNcRsLeiZ/WSyIxzMwA9U+OsINBhVjI+erUbj
         jwVkBFLdEtvi+q583DR+pl1wgO7X1cyJ68qQsX/q/zbl7Gr0RcrhO6Z2IcIvl71xHqxc
         /zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739896135; x=1740500935;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZSFheZSQhhD9BZXFMBQVD0TW1CBXyU0mBPRkFUDMV8=;
        b=nhosptSt20Q3cNmQeFNueSIloBAj1a2BahNn3zHYbGitrYpEghtgIiPcigxYTNWnbf
         eDtVS7h+Ni3Zq72tCeWLGquztpwFPfRIYID5cSenecTsm6UNUpWYFrNRxHFQSN3NvzvN
         VC5ttdnpWd4S+n4tMg5e47fvMSxoH4da6avAQ1MLJ6gQeyYxuulvwFGxXsv0hDZ/URIF
         IhT5v47cK/Fct2CLqEydMAthBk5S6UOG/3rUNyxpuTadTl6kF1AR6v1MXstuWM+l230c
         2WIpgcteVH9nARPGFmHCzVVgUo6LmnFD339J1V98trvXxMpInolUckbQqMSwQVg5SY1I
         TXeA==
X-Forwarded-Encrypted: i=1; AJvYcCUVrcl8EOZ4+OgIYQ5OvDq5ZNuaCJnGUuwtKhNafQiNzgdJStD89mKijk6mp9AfbqtI+pJxPheWJkFXkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9M/kV6XNbGUBjYZoSXXASk+qZKHc03LHyafFxZE3HNhdUQuQ+
	Bs34hXnYAhrsUfsgMVr0A2VmE/Rbudtxut/anzRRL1FiWBB/X5meBO7Gbw9HNlI=
X-Gm-Gg: ASbGncsLEjN98bAIWtktLFXgZkcCrSAByIVUC0eXQfnZyz0Fc4SDzqzyf82McaiECsm
	r6kvpTColrbLX4epmlBBCFaDLeXNF4YzTuFkMvQt+DpVg0fa+sVHcS/WC0ndYcIXi+xYuWjN6eU
	Yq34fqruhyNAmAEIY/kBsVz0Em0LSWyzgRx2LxbVi14LoribDDrRCTRUAaRuoW4n7aT8MxqgJAB
	urfbYFLBacU2hWm8wuU9j3FA6Axn3nkNiO75gieFz3/ECIIqlQRSKWQTouEfeWtAmoqulrD/bkm
	pR2N2pw=
X-Google-Smtp-Source: AGHT+IFxS7BlF0CZIeMaviLLRr7C3mH9hEBNvjEDhDAhT5him999heZnOoe+++OGaPF1UldwWm0gGA==
X-Received: by 2002:a05:6e02:3103:b0:3d0:443d:a5ad with SMTP id e9e14a558f8ab-3d280771825mr144713065ab.2.1739896135029;
        Tue, 18 Feb 2025 08:28:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea175b566sm827823173.137.2025.02.18.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:28:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Dan Schatzberg <schatzberg.dan@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>, 
 steve.kang@unisoc.com, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
In-Reply-To: <20250218065835.19503-1-zhaoyang.huang@unisoc.com>
References: <20250218065835.19503-1-zhaoyang.huang@unisoc.com>
Subject: Re: [PATCH] Revert "driver: block: release the lo_work_lock before
 queue_work"
Message-Id: <173989613412.1451056.13330550436881172975.b4-ty@kernel.dk>
Date: Tue, 18 Feb 2025 09:28:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Tue, 18 Feb 2025 14:58:35 +0800, zhaoyang.huang wrote:
> This reverts commit ad934fc1784802fd1408224474b25ee5289fadfc.
> 
> loop_queue_work should be strictly serialized to loop_process_work since
> the lo_worker could be freed without noticing new work has been queued
> again.
> 
> 
> [...]

Applied, thanks!

[1/1] Revert "driver: block: release the lo_work_lock before queue_work"
      commit: 02b3c61aab443d8c1cc7d7eb0ae0a8d86b547224

Best regards,
-- 
Jens Axboe



