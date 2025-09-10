Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08BF2BEC26
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503804; cv=none; b=V/Z/76Oi4Nlnsya/Q5jIPoohldSFMad3JEu4N9p0mdfvb1M5uZr5Cwd870grMNgFNrstKtG4XmdJB/fUxe+SdMQIjDlDoIy92Y+342ViM6WQC2e+nCRauplbDmj/lYkPtCtFi/CBEK7Rkauz8lYOtVRLob2V7cTmpn2WEvZ6AoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503804; c=relaxed/simple;
	bh=iU3g6YqT3iBhtM4Qx6LE4jyqmLa5j7vhy7FFkAC+vbY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=irVWZhja/7SpVA5pOz8vPBETtZ8rAhdrRAwho8PEN00WS9/FE657zCkHTMSd6lfkMwe2BHShPFPKeRxmAzRT75a0MHP7qk9w/2Q/JVaivDCneTaXZ8yVCJD3asFG7uJz9DwbseGWqoRf9KT+cdpTpELFad7jQA0LFvY5bD9bjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rB3nbBiG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rB3nbBiG"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77256e75eacso5976407b3a.0
        for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757503802; x=1758108602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHog35fdZul65rJ2KSFV2eXJRn1rF30zkol6ZT3v8ug=;
        b=rB3nbBiGCCmUq5GzWvTdIf3pbOGPTQHXycuWNkfM6XjrU0bKY5pbZ8viPOo2jCHobj
         1lzHzpEgfB5r/gdwtboudIQXpL7M8N1yswrMTWnHhCwcXg6qjJv0Y+5tlfhjX/K9lFvG
         cSoepf/cgsc4hQogO+/wQAzge5GZicpLIQYFoCMHR6jJWgScpSZPSWVoYfG+oDY8Kd59
         RaDxUIyCNMVTo81on34pnnNrzFN6u/+ZB9rfKuvyC5m6hjb3lHJ0iSjNv/QV8mHuiuav
         7cOVevZE/SmRKsqhkz5+PssfDDXnr9Z6PnxkSEIYgX9xLHQyIod32Ekb/9dbGpxd2ELF
         uUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503802; x=1758108602;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHog35fdZul65rJ2KSFV2eXJRn1rF30zkol6ZT3v8ug=;
        b=ZlouoiVoIBqd0EcEySUJ3MLpAvOv059GSm+E5BhlA+Yt0660xLB/rTiW92+RFRiGUi
         CGs0TnBGQXHGnKN4RgxTGVpDabjPG/Jie0cCDjnrsx3MAjIvzeaOmhhKw8xPCH9ppOex
         hcC52CMJnuOfc4l7xMUdrSaD+lAqvLjrjDU1PdwE3KEt3d4kDIhxE6DEkzH1z4slsG51
         oS0A1nY2Rd7bo/Ay4jjOqmj4HMyEfhUxku4Klq//b1J3jddIuvAz0U3m1MGdF9Ykgg9f
         81qAlwhTWWyQk2NRbM2/SawYAH1Hwj8FORfusuOsr7kTltv9ZBkXcgoELaIQA0A6gTa+
         gl3Q==
X-Gm-Message-State: AOJu0YxpdQh4HOIomaCNgxMYUmDwCDBD3CZr1K37L4EYh8uTIU6Eyg9r
	dndUEI5I7xbitXDp43dBrDihJsQkfK77WlD8SdmPkPFu17gmvUi7fg724/C9gO6wPOE=
X-Gm-Gg: ASbGncsNG0zBCMh38Hizf87Rd8iesUFv4ETFhid151r7Gi6+kFYlZk2uFiMzRMfSx38
	XN4Az3xwH1lpRzkvJgyOblG42EFTAN6fi6QriEtXq3m2Yu3Lk5yfHo5/DOiwykSWBcD6qxaLveC
	xohNDeTVmIJ7Vt3ahcOQv8d4nKTSM61hDTntyyf+IymWu7vnNxaJ1YP53a32IpkyG9FumyQz6E3
	OarDEqPgFPeXPJxsB5+Y2WR7yjFqWe0kUskONKI8yn7spQxr5dw1pqwsCE0yS13VwIWnPtsUqyQ
	mJJyJkBLEFi/PIU26VW4tPP0FWAnB8WrM4kWJFxE+4VhpMU7KiRKdQCqaMNZLuQ6Oer7NKkTZN6
	MsyT9g5UO8dca0bk=
X-Google-Smtp-Source: AGHT+IHkihz9yFR54R0EvSFdM+hx3ztjH6FzLB6hWLgclGcjkfYrDxszfqHbE5NQHR7E0043fCmspg==
X-Received: by 2002:a05:6a00:13a0:b0:771:f951:16c6 with SMTP id d2e1a72fcca58-7742de60a43mr17847732b3a.15.1757503802237;
        Wed, 10 Sep 2025 04:30:02 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662920b1sm4964965b3a.52.2025.09.10.04.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:30:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: nilay@linux.ibm.com, ming.lei@redhat.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250910080445.239096-1-yukuai1@huaweicloud.com>
References: <20250910080445.239096-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2 for-6.18/block 00/10] blk-mq: cleanup and fixes for
 updating nr_requests
Message-Id: <175750380136.204398.548203762682278830.b4-ty@kernel.dk>
Date: Wed, 10 Sep 2025 05:30:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 10 Sep 2025 16:04:35 +0800, Yu Kuai wrote:
> Changes from v1:
>  - add comments explaining accessing q->elevator without holding
>    elevator_lock in patch 4;
>  - add non-shared checking in patch 8;
>  - add review tag by Nilay, patch 1-5,7,9,10;
> 
> Yu Kuai (10):
>   blk-mq: remove useless checking in queue_requests_store()
>   blk-mq: remove useless checkings in blk_mq_update_nr_requests()
>   blk-mq: check invalid nr_requests in queue_requests_store()
>   blk-mq: convert to serialize updating nr_requests with
>     update_nr_hwq_lock
>   blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
>   blk-mq: split bitmap grow and resize case in
>     blk_mq_update_nr_requests()
>   blk-mq-sched: add new parameter nr_requests in
>     blk_mq_alloc_sched_tags()
>   blk-mq: fix potential deadlock while nr_requests grown
>   blk-mq: remove blk_mq_tag_update_depth()
>   blk-mq: fix stale nr_requests documentation
> 
> [...]

Applied, thanks!

[01/10] blk-mq: remove useless checking in queue_requests_store()
        commit: dc1dd13d44fa4e4d466476c0f3517c1230c237e4
[02/10] blk-mq: remove useless checkings in blk_mq_update_nr_requests()
        commit: 8bd7195fea6d9662aa3b32498a3828bfd9b63185
[03/10] blk-mq: check invalid nr_requests in queue_requests_store()
        commit: b46d4c447db76e36906ed59ebb9b3ef8f3383322
[04/10] blk-mq: convert to serialize updating nr_requests with update_nr_hwq_lock
        commit: 626ff4f8ebcb7207f01e7810acb85812ccf06bd8
[05/10] blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
        commit: 7f2799c546dba9e12f9ff4d07936601e416c640d
[06/10] blk-mq: split bitmap grow and resize case in blk_mq_update_nr_requests()
        commit: e63200404477456ec60c62dd8b3b1092aba2e211
[07/10] blk-mq-sched: add new parameter nr_requests in blk_mq_alloc_sched_tags()
        commit: 6293e336f6d7d3f3415346ce34993b3398846166
[08/10] blk-mq: fix potential deadlock while nr_requests grown
        commit: b86433721f46d934940528f28d49c1dedb690df1
[09/10] blk-mq: remove blk_mq_tag_update_depth()
        commit: 9784041145796994f2b21f4c7e628d7c9db762f4
[10/10] blk-mq: fix stale nr_requests documentation
        commit: a75fe12fa2e2f96b619f25b8cda1fdef6d616ab1

Best regards,
-- 
Jens Axboe



