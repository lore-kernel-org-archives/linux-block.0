Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A078F33
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667746; cv=none; b=iAn1cPcmR7WkPXH4jknBA8HQPxzTE8w8T6oC72RTtgMLpF7FAdwoy1nG2mbbuBgLyT7jeHGnRf05pWLQiaCzClDO1O5eNfKYnNq3VkIJfEyok446Kc3ssJ0tR8+MmupqL78FmED61Bqc/5Tbp+tnRms3U9IGbRrzJywB2F5tySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667746; c=relaxed/simple;
	bh=x60o6deVVHc12hCYDfySaRdOPNuHNTbJqlOo8TdMAwo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RhoH6ZjX42DC4ssvQ8/8F8o6TRtZig4vNliG7ky7zfCe8ayIz9QCgMBF23y+fyupbMv+kqGd/05n+7HCVet96vvCDr3tldU/ePkoX73tKT817iXET2YlRrAvG0OnwQE8dbkhTxxw9JZBYLsobPdfgs7ytxIYkIjx2jC2f1PGuW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B9P2EKIm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9P2EKIm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436a39e4891so37265725e9.1
        for <linux-block@vger.kernel.org>; Tue, 04 Feb 2025 03:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738667742; x=1739272542; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DakOrByytElZi/oVtJhwSWg7prdrnPB86xyIOI0Q1o=;
        b=B9P2EKImp1hKJ92r1vklVozmt6fXIDVvyJCMfVZNqhKeX43osqK718PR6GHCzZ8xbe
         ZJRY18hkmmStnFals+jsDEPjaqh2KXn3I8HmfdPqGWItwSX2EAOCFQXgILG4p8z3H1AR
         ymefglCY4bgf9RsblKfUoYiuIVoxRFb0Ec8CII3ueofbLLVEMG1fhfod1f/XXhOfkIwc
         lTnzkX/A3e0X+JD/MJVNPzajP7W/5rGweX7pPIXe66NFliP1/tvSpy9b6Z3pwaPnqjPd
         PO6aihA8ekmN6C39DfMpUYidq7OFva4GFfNUP67jok1yQMZYhL637o9vxRJnz10I00TF
         Avgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738667742; x=1739272542;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DakOrByytElZi/oVtJhwSWg7prdrnPB86xyIOI0Q1o=;
        b=fndg4WexxLBlODPl/xrN9cnsJmxZ0V1pMz/Z/EM4E3a1/0O1mWTqR9CwiAEUg+4pFf
         GATV8shl1YqiyjJGGiRCJU4raLnv8a7aYNPIHPzuSbe2d9nCuhUKjTfHMHWm7fBsbOMT
         peRJAE79iOcGxopQ+21fvqhbE4GmJYAt6/li35aebM0lixuQTsPnGJne2YtunocfEm5a
         sQY5aITGDun1pH42TET+RRj5CDSMrvpYeUfMqeTMp/846fhDyAZb/gp43uqYIGJwnENJ
         FtMQV1Ey4fu7plzS/XqlSMqFalEqbUPFycOcp00xOc9qxmsPss79uda/xugFt4IWOfkz
         g1Yw==
X-Gm-Message-State: AOJu0Yws/TqEfWogPuEde4GqAQNcgzOkCGgAjRGVlQJz90jw8yVKKXtF
	8uAR5MVl6AxhjyIFQCcDjXv9xXC7Z3dSGHQcnnaOu77ceUK6dpq8R5reK9hVp6Sc3I4j5gzhrG6
	Z
X-Gm-Gg: ASbGnctr6cjz6/PBhTyB7G3Hfj5/s3VYCTUi5TpHX7Zivw7hlfd4naVup8aENlMIhWT
	5phmdEmFKbE4XhwhyJZpoNhJOk5F80EZWbY1hAN4Xcwj4oYlnlV6XXXK+lBxOBFI3b2dTPfvwTm
	ud2x4did5LRhEBAly5JaGZ9t04qbPi4jDyogwH5iU/PO17mvmqiy7YcGne5j57o8Avtvbon0+Px
	mwqUnKO2W19yG6fFEn8gXT9uP+ap+XlReZ7OiF1u75DCCIxeell2q8sddy0DK/99XzFpxCk1Q7M
	4nbJiX9UAs6+syop7xp5
X-Google-Smtp-Source: AGHT+IHeUeQEaL5FagUlSlyLKQXf9U7wSGwVVirJ+eLWcylRLHx460Rs2jElSjNil9H/GsbQtqU+Tw==
X-Received: by 2002:a5d:6d88:0:b0:38d:ae6f:baa1 with SMTP id ffacd0b85a97d-38dae6fbb83mr1032221f8f.27.1738667742389;
        Tue, 04 Feb 2025 03:15:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dab853236sm1477716f8f.54.2025.02.04.03.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:15:41 -0800 (PST)
Date: Tue, 4 Feb 2025 14:15:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Subject: [bug report] block: force noio scope in blk_mq_freeze_queue
Message-ID: <46e5676f-742e-4c18-8140-a3e249235a4f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Christoph Hellwig,

Commit 1e1a9cecfab3 ("block: force noio scope in
blk_mq_freeze_queue") from Jan 31, 2025 (linux-next), leads to the
following Smatch static checker warning:

	include/linux/blk-mq.h:910 blk_mq_freeze_queue()
	warn: sleeping in atomic context

include/linux/blk-mq.h
    905 static inline unsigned int __must_check
    906 blk_mq_freeze_queue(struct request_queue *q)
    907 {
    908         unsigned int memflags = memalloc_noio_save();
    909 
--> 910         blk_mq_freeze_queue_nomemsave(q);
    911         return memflags;
    912 }

The call tree is:

rexmit_timer() <- disables preempt with spin_lock_irqsave(&d->lock, flags);
-> aoedev_downdev()
   -> blk_mq_freeze_queue()

regards,
dan carpenter
