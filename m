Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBD423B63E
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751853; cv=none; b=nSPiKCPkor9lbNIwX2RK1H1E/W62V6e332xZPdnZehDzux7yLZmka2fpaXia621Cphwdp2QGpWa4kiMrXhz6bZcHr7k8tmJmDg08M93l2ArGhHvO2dcGE/vQZS2Yw3Gb32D4KUF9bedNTuQPG75yec+Webv9z6tBAxfY6Li0JT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751853; c=relaxed/simple;
	bh=Y6aoXvhkuzefcMF+xpGyKWRJm8HL9kXnxHq8SAp9htw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pSkTWqQJmXjpCDZvdi7vM1YqSOv/FJb/l1PWa9XiIDVAvLimMV73zVyUCFmFN14PRfyTKuHKNu4AQW2+Q+OEt18Pw/IP9FJ8bDu8LwRoaRPC19/N7PUO82ZCMRUbyw6AM3JIoGZ058BRJUrM7xwD088hDl8zRATEQi9Spr2N8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uGJI6l7+; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uGJI6l7+"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c75b829eb6so1027523a34.1
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 18:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767751849; x=1768356649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBY9MOF7X02eCGV6DsJdXa4mypeE3yc/SmqnqMel/o8=;
        b=uGJI6l7+gUiPEbldkT0vyt5AWu4IwtYOjzhduFT4oMUHWo3B7YR6xy13c+AsVt0DKk
         fypVu0y/QsLnJFqZdwsuCIxIlIXA9wktW1MySh5KEWNfl9GHrN6Kt6myQkMJDzgYk2z+
         lHEFudXKS8PGAtBU43OvP0IkeojQTX43/DKxBBFsR4S87elQfXxIPzxoNFriUqiXeOEB
         IUmRp4AVXRtLYdsHykLX99CK41M4Y64hGdyaCOUPHpstDBZekbnWUmal34prvWUQ3Lza
         1RPCly7OofpeQdu7dG8h3PJLud2l3RRG9beSF3Y6B07/W9lAzC/tdlDy40X+Skd3Y3us
         3GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767751849; x=1768356649;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zBY9MOF7X02eCGV6DsJdXa4mypeE3yc/SmqnqMel/o8=;
        b=EzzcwRfo1iFUPsIfYoka9ZY33Fk8Fosv+8DSPT6U2kCOFfMs+dz3Sgchk1bEs2kGtP
         YktYju09uxralhjc/W1UaaBxhSveAEoh1rNCg5kZPvJ0H91+es8UYU/Ll0jkmWeJZowJ
         0sat/RkHm7w4Oq15Az4Zi8yT6smBfyDqJQwW8zC8Yp8AnyQ8t88jAp7I2iDfAu68nVee
         VWMTPG65BJWRGjVxMc2p213Ca6XQnyT+rB2BkC1HMgz7rhGKRufraobVf7MujzPPo2pe
         0KLnHRHxDje+tUr/WRTY1ICKPh/fmMTVUnzTqPjQV1VRAN6KrcTDNf9MC3AOIuMGC6xn
         6AcA==
X-Gm-Message-State: AOJu0YwXqDxT9v63P7FlZcBizFaOaSAKUSFU3Mwv60vq/ioOoUMZEtfG
	mQOInixVSKwRhnNS6rhN2wCVWZRdbY3LNQTw4CKWiYNrKUZlFLYpyweRv//s88iGxeYsdX5VXaL
	da5Mx
X-Gm-Gg: AY/fxX6hLH0ASwKp2nAwURWeziEG4N6D/m2jaWuASrdsWCqiBkbgb3VT8VffFCtVGua
	YmED1n5kK9Cwk2OqctmR8JFbwjdRMS+Z02nndBrbkkoUG0zDgMLPG2wrxBX7J79mbiME+/hO5P6
	Rtnt7V+BIXGU23eH6BHv8BSqfvjHZeav6/l9oiBexTHmwHfz3a1Q4U9RR4VNtw5bED/6wgtn1Ql
	8SvjcnClLNTK3dQf3GGv2f6S/91u4NvMughIr/8AZOoBVqBv1wRSzxHe8CudprpsJJTeQploYwd
	2JEYGmCgeFCoG/SWXNC2IaDr9Ms40q5gobsOM0SModOdCVU2o2fF5mzYjc1w53CgeZfA+diWLAl
	69r0LBUt9N8v9K0osUGE96It2tAiMwcPlNdQ14+39Wn5KGz6y3uy++i9sGTxjhXfkdwIH7KkfTo
	dTlbQ=
X-Google-Smtp-Source: AGHT+IH3gvX9TnXoXnHti1TWOwB44yPm4rVX7GJbCS04VaUh9KGb8dHR+lT4lcVjzAr72S76fur4Lw==
X-Received: by 2002:a05:6830:230e:b0:7ca:ee2d:fd8d with SMTP id 46e09a7af769-7ce508d7fb0mr685570a34.9.1767751848795;
        Tue, 06 Jan 2026 18:10:48 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af8besm2460657a34.14.2026.01.06.18.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 18:10:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tj@kernel.org, josef@toxicpanda.com, kernel-team@meta.com
In-Reply-To: <20260106-blk_unlikely-v1-1-90fb556a6776@debian.org>
References: <20260106-blk_unlikely-v1-1-90fb556a6776@debian.org>
Subject: Re: [PATCH] blk-rq-qos: Remove unlikely() hints from QoS checks
Message-Id: <176775184768.14145.3891847681300037489.b4-ty@kernel.dk>
Date: Tue, 06 Jan 2026 19:10:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 06 Jan 2026 06:26:57 -0800, Breno Leitao wrote:
> The unlikely() annotations on QUEUE_FLAG_QOS_ENABLED checks are
> counterproductive. Writeback throttling (WBT) might be enabled by
> default, mainly because CONFIG_BLK_WBT_MQ defaults to 'y'.
> 
> Branch profiling on Meta servers, which have WBT enabled, confirms 100%
> misprediction rates on these checks.
> 
> [...]

Applied, thanks!

[1/1] blk-rq-qos: Remove unlikely() hints from QoS checks
      commit: 7d121d701d58a92f26decb10da1d04a88b74519d

Best regards,
-- 
Jens Axboe



