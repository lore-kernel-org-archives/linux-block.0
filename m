Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3339D
	for <linux-block@vger.kernel.org>; Sun, 14 Jan 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VAS/XAeN"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cdf90e5cdeso1041188a12.1
        for <linux-block@vger.kernel.org>; Sun, 14 Jan 2024 06:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705243089; x=1705847889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEKbKDFHot41pQiM8MjoGhMNSQ5QdRpDJOOXMEReY94=;
        b=VAS/XAeNUfBNoH+npK9voWBV3u+i32oaPKy3mBs8/iApQz8YPFOvLG8Mjy1D8ZyCY6
         y4dft5IFTXQw3p4zkFZ3lkKWPPRIzbH+Bn3YgGP6BBKdoWCkXmhW+o8hj11tZYDnSMp+
         bJgIl5XOAh9HWHrH4vHXRAdrVJdNyWzsdDWoJpqyPzjSqyY3zaejYbAX+TiWTs+pjGVK
         Eqhvd71AfP7BSggzCwShWL4/o31J3AqE9Be5U8TOsP4VVusWwCmsYkEpvme7+oc1Z7hC
         DRUByIr+H/N6yO4OmJMdza/mdpgHBkFXBoE1BujFG3F6DIDExrmwPkjwZW0Y+ZFeAIYV
         eI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705243089; x=1705847889;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEKbKDFHot41pQiM8MjoGhMNSQ5QdRpDJOOXMEReY94=;
        b=JtuOAa8awb468o4s+uV4zugm8Y9KDyOTkNomJxmFrQBQKqyQsvNjBnLC9OUqTX6/l1
         eThNuAk3q2ZvMpXUkcZCSb5l41JXenDJoBj7EUZUBT8D4HVHa2moxkAZSqCAB5A67lFp
         wBoMDbmeVb/8W2tX/tY8jycKGmpR1ANBZp8pyJqcgPdChYkpds1DgTPy9fS0oZ0F/4L+
         tU2LbEoazyoHMuo3MLV9mp/bxdZR1FR2yjBj954sw0GQ+O1SrRWmvpcQgUdCvSDqlmdY
         moJSvGdn736T/T0yyFWSEV0VpdZ3ok3Jp1K5ScSOI8LQpfGTFIbXZ0SIdlVPUAbPXzky
         1lPg==
X-Gm-Message-State: AOJu0YwhkDrcIPj0RKt89Gq6nY1EvhiM9WnM5Cmy6CGH3E4t/Ns9w5id
	CqT79+nivh5V8ea5PzG5JtxOl3/H8p45tw==
X-Google-Smtp-Source: AGHT+IFjdEmYlD25pdHEft2yJsVwIqyNS/GQEwSmncdQ+Ndl3PCz3S24bOEwaVgRQjZExMBC4V85Sg==
X-Received: by 2002:a17:90b:4d90:b0:28e:425d:8420 with SMTP id oj16-20020a17090b4d9000b0028e425d8420mr1720336pjb.4.1705243089633;
        Sun, 14 Jan 2024 06:38:09 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090b004300b0028ceeca04a1sm8026694pjt.19.2024.01.14.06.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 06:38:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
In-Reply-To: <20240111135705.2155518-1-hch@lst.de>
References: <20240111135705.2155518-1-hch@lst.de>
Subject: Re: (subset) ensure q_usage_counter is held over bio splits
Message-Id: <170524308868.2428903.13088116635304418534.b4-ty@kernel.dk>
Date: Sun, 14 Jan 2024 07:38:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 11 Jan 2024 14:57:03 +0100, Christoph Hellwig wrote:
> current blk_submit_bio can call into the bio splitting code without
> q_usage_counter held, which can lead to inconsistent limits beeing
> applied for drivers that change the limits at runtime.
> 
> The first patch in the series is a small comment and naming cleanup,
> and the second one ensures we always hold q_usage_counter before
> even entering blk_mq_submit_bio.
> 
> [...]

Applied, thanks!

[1/2] blk-mq: rename blk_mq_can_use_cached_rq
      commit: 309ce6741430b5a7b5e85cd1a7569647f8d9dfa6

Best regards,
-- 
Jens Axboe



