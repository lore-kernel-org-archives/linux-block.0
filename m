Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C621D3FE
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580430; cv=none; b=enNFYKHnp6+cd0+2tmaMz/iyc6eXHrntddLl95rYvdl3R3T66KFBbFYtl+qUUB2XskIgb2mGnLMDX4eU2XDKvk47ELE2Sg8xhx6hu5dbxuVw/LKLF55p51wFqb4+VKurr/YlIuPA8IcG9lcjrx3W5zYs2xGwtQEpNi7/AqWELVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580430; c=relaxed/simple;
	bh=prWiZbnGcwJTlqT7tRnT+lT82MX8tKvsOTrWPuZQYYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DcABGIHg8kVErVi7K0PvZTD07bxsnm0Bq36ikhe2PdjZjOWCFKHyIG0NYduKqQqXHcsu5yY3cSBwt/i/e6/aItvyFefL9LQD8V4A5CI6bfr6tqK/fu/hLUYIhPHIIiD4NWXL4eq8QD59SOVHlD8FfFnZLvPT0R2j7K1Z0hkVjbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1+7cEk71; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1+7cEk71"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d3db3b682fso527385ab.1
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740580427; x=1741185227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIsK2qAwqiQqZ7mCWulg5zaGHbluZh4C7orSxuEv/2g=;
        b=1+7cEk71qxoUKuBemt8rc4QMNNkydYGMeJI+lqJnx1NaD7B8Dp4kwVMt57E+f91UXT
         gO6HREXKKAuRsD9rCT1ozzMl3ZNvmLj/qXs39cPpONsBYUDMtrTdB/HKGoQ/jfNOmPcT
         6z9qKwK0rjO7tEQ+Fm3l8KU0qjGQvwWjUfr/MTmsqVzg7I9dwwJYDnVoDLW+OjovXcLW
         fNOa3O730CzLr1x2t732ZuB7LzMsppKyozo4HDn6Vi2CUEpBkTrwRrqUL0mChSAwClae
         3VD9TJKlOxYBw8LszRHazxiCOFJKzsm/4KVs7WxoDbi/vbs9RHy0nYToqtHsLeaUPRW4
         VdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580427; x=1741185227;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIsK2qAwqiQqZ7mCWulg5zaGHbluZh4C7orSxuEv/2g=;
        b=gcAnkiakCwZS6DvNjRIF4u3wq3RkJ8JKfm301Wt0lkh23/dd5YuNNPfGozkSxXkbDC
         xo6aTh3xCOFIcQ/P1/BNl8IDfTtjf0T0f4/pzHwNnYD+0QA9BBtbZoRzcALZshRIQJ0Q
         5nipBMv505hmOOC1nOjRmwBORz50KNikYhQji/Cvc0qINrD6D0tEMr083ZJuXeuTpRSb
         26QCJpwl59J2IoU+q5OzwyKREFSRb8qka9EjlTGnqifMVqsSuxvbhh4EUcNAAS2dW9Pt
         6vAhYoO9j8wEl1ZPGtOJnPu7JlT483sxW5rS5IKIsl3wblYn8XhsJ+BzQnkkfEtFMtNl
         t+6w==
X-Gm-Message-State: AOJu0Yx3icqP6SUsN5avLNW7E8VsGfpo96FPv8TpXLEPBIqVY6NBsQF2
	6YU8z8uqNkUZMT8pIKo9Jg23JH/KeZQWRAaDtPfJ7cdhQwCoi8qwuC4WAKKfNjA=
X-Gm-Gg: ASbGncvvYrXAXARLJDjyiS4iTlUJvZXxXuixgK7EZ7yOYUBopFLyQF2fi3yDnB9XF5m
	gdlBoHqod+JkHTHMUdTw7yaZAIokuF8F1NmRSm4jdQpKuzOqW+/MmitwReB3d7HNZhhswCBALtN
	O6kzGb242EZv0yblSPqA+p4pYUXylerVsKLe2qqgB0/qjolrxe0g8rKpGoQwHzR4n8CdRJi+3cC
	i7roiSjpvSSTkrN1G/2+UQcEocSbOW4bKLpO225G4bw8O7Dolm7+I/jvc52W/eVtBbsOX7a19D8
	OLnF72487Njs5tU9
X-Google-Smtp-Source: AGHT+IGJt0tpQESzSIamlIYHMziTHyVu1L4KxVd0NUmitmwxYdveN2F+h6RN6Jyvemvc+p66HHOxCw==
X-Received: by 2002:a05:6e02:b4d:b0:3d0:101e:4609 with SMTP id e9e14a558f8ab-3d3d1fa689amr40214985ab.15.1740580427607;
        Wed, 26 Feb 2025 06:33:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04752e026sm901059173.107.2025.02.26.06.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:33:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
 Bart Van Assche <bvanassche@acm.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20250226100613.1622564-1-shinichiro.kawasaki@wdc.com>
References: <20250226100613.1622564-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH for-next v7 0/5] null_blk: improve write failure
 simulation
Message-Id: <174058042665.2231223.3462421622003797911.b4-ty@kernel.dk>
Date: Wed, 26 Feb 2025 07:33:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Wed, 26 Feb 2025 19:06:08 +0900, Shin'ichiro Kawasaki wrote:
> Jens, please consider to apply this series to v6.15/block.
> 
> Currently, null_blk has 'badblocks' parameter to simulate IO failures
> for broken blocks. This helps checking if userland tools can handle IO
> failures. However, this badblocks feature has two differences from the
> IO failures on real storage devices. Firstly, when write operations fail
> for the badblocks, null_blk does not write any data, while real storage
> devices sometimes do partial data write. Secondly, null_blk always make
> write operations fail for the specified badblocks, while real storage
> devices can recover the bad blocks so that next write operations can
> succeed after failure. Hence, real storage devices are required to check
> if userland tools support such partial writes or bad blocks recovery.
> 
> [...]

Applied, thanks!

[1/5] null_blk: generate null_blk configfs features string
      commit: d8ae0061afb8bbdb0cf6b2cd4b5be5c54e42b228
[2/5] null_blk: introduce badblocks_once parameter
      commit: 6b87fa3245a93913efb3d8b858f6750d655d5db9
[3/5] null_blk: replace null_process_cmd() call in null_zone_write()
      commit: 7859d042b0954f843d2e97c1324bb04bf28df2f6
[4/5] null_blk: pass transfer size to null_handle_rq()
      commit: 6d9725d1000a0bc4e41fbe2db51181e80e4260eb
[5/5] null_blk: do partial IO for bad blocks
      commit: 386d7f4be4cdfb0b3a937f26fe674818394f795e

Best regards,
-- 
Jens Axboe



