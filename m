Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE911D0BA6
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033218; cv=none; b=LPD0QXcXN8LKU5VUXKSjwLjH5fgtnubMfRNIfYL5gOwHKdyswQ/YR3I1vrIfKotzvDIrGTDSUKRHE9CWc33VnvGVwH0apZF1kvaI48JEcHPUO++PVACq6iH7KEUvMFq488se2vtAATA6aiOfX4RMtRlIRVLmzsmb8E41D8GDJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033218; c=relaxed/simple;
	bh=OdIfCpg1AbVHgB2T9ispri3GwOHonibskh7udt0tJSk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IzINTM9GZ96KnYERmMqHhFbBGhO9LX6At9qHU66rob7VbTc2EQpgdptnsY5Pn0dqMNDio8RF25qLRwV1vxooPUuPVDUnYfCLr8w/qCu2tk5Xlt4I5LDvt1SlalhRhfL/zSqPpiGfVsEmxz81THY9hyu+Hr+sJT7PD4VZmeuoSAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yvmoqkUK; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yvmoqkUK"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29685066b8dso1287321fac.1
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 08:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732033215; x=1732638015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/Ft9aR9yRqj3mw2lSDRrmazp16w7rI4C6akOruFlLg=;
        b=yvmoqkUK4R2/JO3S/Gl7TzLvr/fR0uP7B5AswRkbupwIzK5pZ2ZazZ8j19TJbEWilU
         yqNheA3JwVWg3FHTlgZ8g8yqJlUX6R21p/MDEN5tDcXySREt/odX07g4h323DUB6asse
         6WVUcgDkDlQlm+TrmOMdXnQ8+yklOF0iGhUmrc7ugHxVg7mYBo4c1W0+dgOL5S+bOrr6
         q2mCBBU4i3dADEv3xJ9YHM9mjCHxu0sG02316e2wDNYth5gLAhtyNQc+G2pwRchO6ljW
         YNdtz3NwQrZP7/ccji5Hy+XdGFhyhMmqOPGOWt7WyhoZ4mPz+EtJ3naVpAGvtgUVFv2T
         Q1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732033215; x=1732638015;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/Ft9aR9yRqj3mw2lSDRrmazp16w7rI4C6akOruFlLg=;
        b=o1H2d4SSYjGzUiMtRkjU3wnQ6FCfnP1IUNLcrS5HUvFPqVe+b/w1VH5hAYrX+GY+sZ
         ZE6trQLhSF56pYt7RpTBnD8JNTqU8gaXCrISzYydE/cDu/y8ATOqi7O1uFxJIwlrQkmB
         0CuHf12focb2GltNWNrWmXHBqfKqBJz95fjLsf3Q/ZouYfd0q/AYksq1fNLIl2MXECtk
         o/gexvzXDU4e/911R4jHep4lASkisL/Cpgi9JbP1bE5Tn+v7uaw6HKt1qYOzyds+c0yi
         tk4b8coz55Mec5GaNkKfZ52igsr3eZQ80X1udKvggFoY/gmkzdG8rnMi7zuYpKRdTCE/
         bxCQ==
X-Gm-Message-State: AOJu0YxZIXVtX+U84SX3IMOHcebhKckYwwzQajHaclqlLodeTZ3UxWPX
	ujL6hC+5HVKiZdY5+zz1nISDQesG+qgC5DgI2NPcdnOAhA6CPcK58YjVjoR9qQQdiDezc7CST5k
	kaEU=
X-Google-Smtp-Source: AGHT+IHUSAcx5cc3Rj7yHOAXiycIRvr9L9h13LXraWwRqkP6IfzKdhaJyzOX6qpSjqqWjmH+Y1RfDg==
X-Received: by 2002:a05:6870:bacd:b0:296:1e98:6846 with SMTP id 586e51a60fabf-2962e34d157mr13773103fac.40.1732033215025;
        Tue, 19 Nov 2024 08:20:15 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac449bsm3588807fac.37.2024.11.19.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 08:20:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20241119030646.2319030-1-ming.lei@redhat.com>
References: <20241119030646.2319030-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: fix error code for unsupported command
Message-Id: <173203321410.117382.14501473576821099671.b4-ty@kernel.dk>
Date: Tue, 19 Nov 2024 09:20:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 19 Nov 2024 11:06:46 +0800, Ming Lei wrote:
> ENOTSUPP is for kernel use only, and shouldn't be sent to userspace.
> 
> Fix it by replacing it with EOPNOTSUPP.
> 
> 

Applied, thanks!

[1/1] ublk: fix error code for unsupported command
      commit: 34c1227035b3ab930a1ae6ab6f22fec1af8ab09e

Best regards,
-- 
Jens Axboe



