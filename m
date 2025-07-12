Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DA1E260D
	for <linux-block@vger.kernel.org>; Sat, 12 Jul 2025 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752288008; cv=none; b=uUSWPjY4dAcNINU0Shvy8q7qjk8rF/WcIk7uoNpXqdvpSxAzzZEGWebAbOdAJmrT7LLwouGEtnW7Uv7gVFzWsHwPBrcrbajiDfXOL5dt38GsruE82dOthKARbT2LoUp/RjTg08ksZovwbjynnz9Wo+rop4fDHNnfG0B+X4dumoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752288008; c=relaxed/simple;
	bh=2m+6X0VPNiU/NUe1sUd+j4JsRt1PlFoB7dSjkMIRlSY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rrEMFjvfPogGCX97zKVKXMsEhrLiC0o7bdMD1I3GUpPtLHo2AbHWCq1COjqMJXqa/TDrDqZzunkEZ7W3g0KKPYgfmqSXWA2Ch5/+54XHqJl6frYGMhp9TNrGaii97Y3stOAEZwOTPXwnS2T4WOmMxgfWGmzEMf+VjAaR83fMQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=216oRf16; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="216oRf16"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-87640a9e237so221621939f.2
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 19:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752288004; x=1752892804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFgFaKapqqeDGdQAyet3S4gcpObJE1uGZIgPENqJ6Qw=;
        b=216oRf16HQYXQKWFt68EaFyw3BDpUsVuCBqkXhji1DUgdu23LSdOUpkKF8XhC3Ac93
         R4ld2pLbjK8QqtT8OpBxUv0XGDWQZ0mPyHZiz1xQ5NaByHt3KfJ7hqr/ztWfqTPaHw1h
         aM4CC1cU1+90XtefhRZ+zELpQGkKZhPhMpVK/VnIue6BIqg3lvGScCbrBq8WIokk3KmC
         p5DIHei3RsOWLh+829APYxy3jAGxMCBrNujufJEN+eOByQa6JPwQi3Pa6+m+pEg0RqUI
         ZVpUrVxFcUd6GpDpSPK/wLMjZrRl0tbKr1GrdJ61S372O0Q2bHKP/7IzJ3Xp9oHYF5ik
         nqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752288004; x=1752892804;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFgFaKapqqeDGdQAyet3S4gcpObJE1uGZIgPENqJ6Qw=;
        b=CbrP9a9cVqzyJRcA+4eomcLJQ/YRb9edGUOD2EqZnxf3mhV6GiEFVm2o3oC7ZgZZMZ
         Vj9OzlX1iXJSRa/w7tB4jRYgluGBtGI0+vqUz7Fs0a7O26D3Y4/AscGfKp6A3x51Z0du
         0l0w/BFB4kBZ5azdJtGo2wkx3jp1zbGv8Tj4lgaNbCBTRelAZdBfVaP2WQMHukf5tQ/H
         gJxERYpSKl5KneI1Rtsq7DeseMtlFBjbChP0QMUQEj9YLAhc8iNup12H0GmOdwg2tzp8
         XgDBUuCi4wri94Um/3KT/owyrBgqP1/u/c7qdqkE8tHBxtrM/XQ4+wMyXbFyLuFHDW7u
         Lf3A==
X-Gm-Message-State: AOJu0Yw/ksZHdorkdzwyq6Y4z+Z+fJ4RDTCMa8Tq9bE8ExcSmYKlA4G/
	0gJMfejqtIMD6gvzNYyXcOriPXz5SHHILUrqKcKQ+m+mc5xC6p5zhsx73i068ufdajU=
X-Gm-Gg: ASbGnctfH0fg4kf7Tc/UJskKPfLdGiiigH7App9gn4KHFNx+hIZMtThrsGDaN9BxiOB
	l5jI6e8b1SEyHb3Tp6vHDd98qQvCG8zG3ovty36Ao6/njZifmqjX9OYVC/rRnmUSwsgJphAQ6rU
	1IV4SYUT+hVddwUPMW7im/FHQBnnujQ5f4Ycabp6dFKrU/PFRupuf0ukxf/cUXt4BJpdHZ58I9P
	3PZKS9S7/BP+jT9NOIi+0139PD2+QVqYVj7VpBBLZ5gWJNGXQpV7ooj6YR3YDT7F/wVTeNPDp11
	9kjOGdmslBe5X/KIA5jcamBKkzvSAFrJO6nhtZ3/Ktj+flJe7lsE/Mg1WQuKTf6cP0vCyMGfMEy
	ylDCrQK90BKJ5Lw==
X-Google-Smtp-Source: AGHT+IGOuxgrEegWqgCh+uOnfW39X49Ls0tE5MHZmtiH0CuCOsyobaA+AbupyGwMJSjEJQ3RYjDj8g==
X-Received: by 2002:a05:6602:7207:b0:875:b8b7:7864 with SMTP id ca18e2360f4ac-87977f7f5b7mr822930539f.6.1752288004135;
        Fri, 11 Jul 2025 19:40:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8796bc34395sm126333739f.32.2025.07.11.19.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 19:40:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20250711083009.2574432-1-ming.lei@redhat.com>
References: <20250711083009.2574432-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix kobject leak in blk_unregister_queue
Message-Id: <175228800299.1597338.9364384111369193524.b4-ty@kernel.dk>
Date: Fri, 11 Jul 2025 20:40:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 11 Jul 2025 16:30:09 +0800, Ming Lei wrote:
> The kobject for the queue, `disk->queue_kobj`, is initialized with a
> reference count of 1 via `kobject_init()` in `blk_register_queue()`.
> While `kobject_del()` is called during the unregister path to remove
> the kobject from sysfs, the initial reference is never released.
> 
> Add a call to `kobject_put()` in `blk_unregister_queue()` to properly
> decrement the reference count and fix the leak.
> 
> [...]

Applied, thanks!

[1/1] block: fix kobject leak in blk_unregister_queue
      (no commit info)

Best regards,
-- 
Jens Axboe



