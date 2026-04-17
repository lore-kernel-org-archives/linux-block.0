Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4403358B0
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458369; cv=none; b=R6zNyuLGbzbWR/NSALc/Zc3Zf7QkXbol1ApEHbd6JsllekdLWme1OX9ks9TK2/54owmpZGqkoBqKci60wPq7WtgWOeWbbFqIT3Yepn8iEvtP3+M7SLJp1KSegGj7AA0vGxlJqp8IEX4Gr8k1T8NnhSzuB73nYukKq2TWwb6swas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458369; c=relaxed/simple;
	bh=QYmKPZ5u/6MDW8voyINPo8MxBXRPsCZP02IXVl+yo60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BYUZFOvrFvU+MCLMxswD3IAgE+RImGxUVhelvEKIDCFp713p9t+QbKZvNdptn0e1i4M19d3jeqDbDrWjoXWwxekGKFIEXvBwt0WE4eRMUy0FYGj1dwqMyImPZ6MWp4t3itgSwnvKCtjL4bipG0LCX/mmS8AZCQYpN17+fR9nr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=eK3U4RI6; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="eK3U4RI6"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4645dde00a7so1768749b6e.1
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776458367; x=1777063167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8T8fhnGDggKVoWa5C5JOmcQbWxbtuCBK3biN6O1EZQ=;
        b=eK3U4RI6hD8c14vJUmIIMgalhfxuQs8eJiZ7JP64Jv1RJIipF8bmJ/orcVZfYr44IB
         ERRrp47rfGklvIv7bzuJaX9a1jWExK/INAxOWGCoW5oN7dErjtdRrm/+WV7sXC8QplbA
         gKkt69ZoB6t1Djtq0CkfV8j04lskguJ7skvoAdhO9pmiqnXETtGeT/CbozJG1H8KhLvm
         qF1GKSxUPp96owlDQ1/zqluf9QJQ9TCD4EToAp4YSIsbVXjACTPKOxJ6EipZYBpwy7rv
         PQIqcqp3RJxMmW/CoNMMxXQaGRniYTGTfVGnsklupPHad8/STXoUbPzIUuz0b9dS7th0
         hL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776458367; x=1777063167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H8T8fhnGDggKVoWa5C5JOmcQbWxbtuCBK3biN6O1EZQ=;
        b=fZDomPTNJ/waJcfX4d3ZuQet5bGzH2BF68H1zRer+sw7Ec+ULFzs68monrvdQOWrWV
         0cjdPJu02A4BvHB/mehGP40/qRpl79jKi27XWMqUIvmciDevsQadd5H+vQI0zF09qAiI
         zI6uuoc9pmMdSZoX58Ii0B362NekfVy8iXCIgDjIy5Z7kIMLFYcnjYjZuKFycehAdsG1
         Ck8NG6MBiulEmMnZgpH0pO3g5r1xNkSt+lmY3Fk2M7c4bgGRLZEacRKEkkh0c4uH9Hn5
         eFHbkTVuIUX6hKp9+PBBFTb8/VsmH3RUklL4mxLZE2qP0aGfdPhA0q44WWiGHMnQGsxM
         70hw==
X-Forwarded-Encrypted: i=1; AFNElJ+wTiYCDoABM275B3+COk/pDuLaySRK16VwJzeVb8rBu8zrK2YgzE2xgpQ5sJuyAdJhj+Z1HRQXsxj10A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1JpIrbsWOprPGAHUYdZBC9mXJ6BNN//scjH0Uw/DrMYUX8O0T
	PxtrFCMmX5UZxwORSHJEBFC38om57n/r7tmouzG+ra/40lNKSYpEkIzI8s7ylbw/gKo=
X-Gm-Gg: AeBDieuheJgDX1NfnScAQEYZgrMg13l9jDcFxfw8ehE4jMzUQzrYpqsBu0QnOwLjeGd
	l+9Tqpo0mWTjWEr7xnitjBeFss3l93GfXHGjYM1yh93+sodpLXH9AR25gN4twyFdRfDF8FDNeFa
	4FwTW4epCeg29VmPMZTbKXY7ORkYF7wAAyU0Wb1jgmHjtgZ+Zd7a6L6StIiOwxlcOZxWF8/05QL
	PlRk5hqioPlCU+SCDj25fSqWea74t3rTFfeu3kfVg6ORrSHDW9/ZRLQxCD6uqqGA2VbOi2O3LQ7
	vwFU9fIeIBQc4s5AFjGSRIsRJjeGAm4eadFeI04iuUQLoKKt/SF+vIlG3ZAggcR86YPQIDOzb15
	nJQ+xTBjmH1NHmOutWLCrUiUPh0buoAB420chbOyLssEMcx1yQD6GlN3Trg9p8PAur2TpiQQrxU
	HXtApAiP/2lmpTDEtGOr+BGAP4B/9kRI9hmHqOajc3XYGSScjzuMz+PZQ7DESqEPu+Zsg5xN/cR
	krLFCFfvhLHy1U=
X-Received: by 2002:a05:6808:50a2:b0:471:6b89:b72c with SMTP id 5614622812f47-4799bd624b6mr2093291b6e.13.1776458367186;
        Fri, 17 Apr 2026 13:39:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9759bfa3sm1926469a34.13.2026.04.17.13.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:39:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Efremov <efremov@linux.com>, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260415145708.3331818-1-lgs201920130244@gmail.com>
References: <20260415145708.3331818-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH v2] floppy: fix reference leak on
 platform_device_register() failure
Message-Id: <177645836617.906013.5675762942401997007.b4-ty@b4>
Date: Fri, 17 Apr 2026 14:39:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 15 Apr 2026 22:57:08 +0800, Guangshuo Li wrote:
> When platform_device_register() fails in do_floppy_init(), the embedded
> struct device in floppy_device[drive] has already been initialized by
> device_initialize(), but the failure path jumps to out_remove_drives
> without dropping the device reference for the current drive.
> 
> Previously registered floppy devices are cleaned up in out_remove_drives,
> but the device for the drive that fails registration is not, leading to
> a reference leak.
> 
> [...]

Applied, thanks!

[1/1] floppy: fix reference leak on platform_device_register() failure
      commit: e784f2ea0b4fd0e7b70028ff8218f22456c5dcf8

Best regards,
-- 
Jens Axboe



