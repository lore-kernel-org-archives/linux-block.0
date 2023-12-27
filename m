Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E10C46529
	for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xFgA0qoW"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7baf436cdf7so12959539f.0
        for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 09:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703699211; x=1704304011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+If+HunTPb2STqDRL5ZV3vwWo19h9SxoGRvmexcJqUA=;
        b=xFgA0qoWrPI6FIJBO/iotlT6CoReyjUYjjgV6kwuWz5OKLEqgY8muOyfekZHe4TB07
         VkZfpRopSqBmLczNwI/lyoebPsC8KF0IZ47dw5VQTcqnWrE0isvWsSFCANWr6WK+Sex9
         nhXwhzLzycFu+C+9X3rtFrGRmjHGivq5bEPuCztEsjQc9MTIdfzVWdfCgeWCOW8DsiKc
         eW0BmK22n/p3UfUb6VNdrrA3SYOtLT14tK0xPyG9jzkRoNZo8WX5QXYG045OagQ0iNG9
         W3+xOypdi5PLNkKewA76r7nwHkrqGpM2xn8uZh5RlbVDdq3I5o63OfNDuSKbidyBze92
         deEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703699211; x=1704304011;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+If+HunTPb2STqDRL5ZV3vwWo19h9SxoGRvmexcJqUA=;
        b=ToF+jOIsU3i1d/Oqq99qRLtvxA32+jWOKYyT8WdLfi85LiVemdTHU8/RIFtwDtbYsc
         YGr+ZzU71I3E8bX7n229NYaWYP10vKA8IQPHV8RBVTRRZ3LumXNxmAHcctVq/VlJ19rh
         l2r0lyGijoWAHHlgFbFdDBW3vgGDxthcIGVDnTkJzv81x8tIExNlDT9rimB+4MvNeCxy
         bXBQ4FXLxN80fqD5p2fAsCmmDHwLYLDyloQ1csnqQqX7k3nKTWao2xJNISyntgodiBNc
         6oHs+ZKg4cIWNXdcbo+WQqGYzBt+HbDwThfomxeOph04VhG8UkfUJS+iCMF1u6UiaNgi
         jgeg==
X-Gm-Message-State: AOJu0YzMz/UrY3DhxGHqQ3ZlND2LI8aYYEs6LWOeJ9EFf/xiqu2fCNLY
	YEs1uWdvSm2+KqE+ys35sfEXkZcxw2YPtLKdxTTkc9kZIr5ZyQ==
X-Google-Smtp-Source: AGHT+IGGiYtlDQK/7dPAmMMeyUIN7BN+AN0MxMxMOHlsBvzJvEZcn/McLWg5cY4CknMi/hoN12iO+g==
X-Received: by 2002:a6b:3e46:0:b0:7ba:90e2:2b1 with SMTP id l67-20020a6b3e46000000b007ba90e202b1mr13711336ioa.0.1703699211062;
        Wed, 27 Dec 2023 09:46:51 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bb34-20020a0566383b2200b0046b4e38a630sm3829433jab.109.2023.12.27.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 09:46:50 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Justin Sanders <justin@coraid.com>, 
 Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
In-Reply-To: <20231227092305.279567-1-hch@lst.de>
References: <20231227092305.279567-1-hch@lst.de>
Subject: Re: make BLK_DEF_MAX_SECTORS less confusing
Message-Id: <170369920983.1390332.446180085116419615.b4-ty@kernel.dk>
Date: Wed, 27 Dec 2023 10:46:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Wed, 27 Dec 2023 09:23:01 +0000, Christoph Hellwig wrote:
> this series removes a few abuses of BLK_DEF_MAX_SECTORS and then renames
> and documents that constant to make it's use clear.
> 
> Diffstat:
>  block/blk-settings.c          |    2 +-
>  block/blk-sysfs.c             |    2 +-
>  drivers/block/aoe/aoeblk.c    |    3 ++-
>  drivers/block/loop.c          |    3 ++-
>  drivers/block/null_blk/main.c |   12 ++----------
>  drivers/scsi/sd.c             |    2 +-
>  include/linux/blkdev.h        |    9 ++++++++-
>  7 files changed, 17 insertions(+), 16 deletions(-)
> 
> [...]

Applied, thanks!

[1/4] null_blk: don't cap max_hw_sectors to BLK_DEF_MAX_SECTORS
      commit: 9a9525de865410047fa962867b4fcd33943b206f
[2/4] aoe: don't abuse BLK_DEF_MAX_SECTORS
      commit: 3888b2ee6262616dbcbf902bc171963fe345da87
[3/4] loop: don't abuse BLK_DEF_MAX_SECTORS
      commit: 3d77976c3a8586ab1fb6845e2061588b7d04934f
[4/4] block: rename and document BLK_DEF_MAX_SECTORS
      commit: d6b9f4e6f7fb589d8024a31cc4883d15d0c8def4

Best regards,
-- 
Jens Axboe



