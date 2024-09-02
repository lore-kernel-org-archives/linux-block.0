Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032E41CB51D
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291624; cv=none; b=cXbbUtENLW/3l/MHIUl1WvvhedM6fD2kVGT67xPsFg92JOut98odwmTuYKv/GvMg521uCk2SmTEaenATu4VlSrM+adH/6fFy52NynrniqKs7DfUkC5Pw53GHT/XsPdl5+hEeZANVYTwLCWiuctxcvwJ1BYUfQxWcRsFzY6ltnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291624; c=relaxed/simple;
	bh=dXzIVlW1iE5kL52BvkJf61CB5Dqr8BAtaeEzn6vZyq8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ey/I/YBZbTsB7GpurMSV9lf1PO2iaD4bJ73tchi1WvRoEXgFq+29OXF+1i3rg5sLXgMsT4T0Y8Px89nE/9oiN5DqmGlkVVo6NbisIxPP5E2kHa9PpqgIgcr9aQPM8qYgrGeEJbzfM46ooL3LAIxtVTKl7Xp0U2ve3Ls7cMPTv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MdLGjMi3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MdLGjMi3"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d679b094ffso3137175a91.1
        for <linux-block@vger.kernel.org>; Mon, 02 Sep 2024 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725291619; x=1725896419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhqUFwlMLIHt6BkcfEhvdfh4DWFHk5bzhcaQ7ExZGGU=;
        b=MdLGjMi3Aozmdo8o9AXNs/iJzDh+/d0YfJ3ja2aCimO4W3W2CymDoEo6QQQb7wRUZg
         vSU95/2pcamZzDR2ehJMpS27IIRWLhqkMwzymoaYS/97CT/p0+8vqNUfjQNXPOCO4bPu
         45xA6zM7TGi4bHzOgsMeO/wAyQG6xl4y0DoHBOk4HtZsKKtaUAUUFB7v0JSJ7/iBAdik
         AXdmOliLAkuPhU2LjhoVJrYxi8l96h4WG9F2kEFt9nyAa2/UTxfhhpj/zUGvxwrbZANl
         p9yzKEUnh6xyFoDZwd665ROYwU0oRiJ8I/1dTvK+9f9PLCAXYmpTSWjKEVxat7HCVy8X
         UJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725291619; x=1725896419;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhqUFwlMLIHt6BkcfEhvdfh4DWFHk5bzhcaQ7ExZGGU=;
        b=o4Xe5mf6eB9iNWyeVKZJAcrBOn9YJng/ZpMhRIuUohLiBv/o6NIaiqA9pH/sx1V3nv
         SKrtB1GUkIaF3yx/FeyunhJnEjJvLTlDxKiX/fAbGB6MVqZzQFnFZHk/ZhNCDBKfGc6z
         6yVEG4gZeCcvUji7bw9gJSpeSz3uaVz4MDRVLrevcn7f12u+rwoTv+4jM4b60KAAED7I
         C7gJpOpsHHPNrypvyRGbOs2EbruZ3kLj+Iapytgv0VzWB5JObNDadi5xNPgN0Y1SLBqt
         M0dvxU+kVtgC3vkggP4pFWxF9flxPwtYkR7iKkTlooBcqqHAw2ROWYkfVlP+BMIIrnfo
         tDYA==
X-Gm-Message-State: AOJu0YzI9XORyPKiaej9OdlIq4Vg/mKHgBXVGNl2riGBF1vXSfKYZAHK
	ekysAyh669WoPC4P36CmRCwEFvOcchixWAfLnbBHOplrrPTBwbE0w+8rdwTrPLoyoqk7wB1VBKB
	x
X-Google-Smtp-Source: AGHT+IGjynHfbafG1Omc2xlm9BLr57YCDac3wUMwPdI3+8mM0dfbPLF1K8oW97h3N94WJOy8h4/tug==
X-Received: by 2002:a17:90b:4ac4:b0:2d8:ea11:1c68 with SMTP id 98e67ed59e1d1-2d8ea111cbfmr2351692a91.31.1725291619453;
        Mon, 02 Sep 2024 08:40:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8e77590c7sm1899850a91.6.2024.09.02.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:40:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai3@huawei.com>
In-Reply-To: <20240830034145.1827742-1-ming.lei@redhat.com>
References: <20240830034145.1827742-1-ming.lei@redhat.com>
Subject: Re: [PATCH] nbd: fix race between timeout and normal completion
Message-Id: <172529161819.4471.16974485070803844903.b4-ty@kernel.dk>
Date: Mon, 02 Sep 2024 09:40:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 30 Aug 2024 11:41:45 +0800, Ming Lei wrote:
> If request timetout is handled by nbd_requeue_cmd(), normal completion
> has to be stopped for avoiding to complete this requeued request, other
> use-after-free can be triggered.
> 
> Fix the race by clearing NBD_CMD_INFLIGHT in nbd_requeue_cmd(), meantime
> make sure that cmd->lock is grabbed for clearing the flag and the
> requeue.
> 
> [...]

Applied, thanks!

[1/1] nbd: fix race between timeout and normal completion
      commit: c9ea57c91f03bcad415e1a20113bdb2077bcf990

Best regards,
-- 
Jens Axboe



