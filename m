Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895C8820
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994749; cv=none; b=ep+6CiZZ1zRKluL9+bzfTI9RN9KaF9gyEXkOESG2unBFp5ubbc03qAZ8alqlqZ2kJivYLBdVwGUd4wZ/Qf4IZgPKGYlUfGltoQiVyqp6YqkQOkti+AyQ0AF5uagfUPCTJO/M7ZvRnF2jX2LrcV1cB/FT8HCovpmnnI8demSLGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994749; c=relaxed/simple;
	bh=2c77VU/e3/SuQyQgzwBKphKfyHWf/3imnf0xwuhcI14=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mBuUsdiIwjIHgQCKKl8gHOcXpdi9/wKkDz0u9VXw/bRL95892PjLsPUEYYgQkev9xNq1bcbzC0O3rj5wco1qKwFG+U5KH8t/mR1Ba2lw8eKxuZlBzspX1InvnqLG0DfQdZJIFMApVcaKVwLSHgewbL713EvYofbAPoTjprL5ImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VqQzak4V; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VqQzak4V"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f96064f38cso130496a34.0
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718994745; x=1719599545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2xJkIuTRUfA3qQBx4g1t4rY2WPCKSWoIC96tcIr0dU=;
        b=VqQzak4VJDY6V3xnO+q9XwE7Y2VTRwQk9zbpohnD8FsLvj5bmLphfrhzlk2WDU8ymr
         wiF46ZBDPENE816RCQ00nwFtT98XeCrgqcwWTGJnDQp7KhCgwBKxJdyQDpDKQGPD+5Sa
         rA35eisZy3/Bw/FB3ovjJ/AYiGpZ3YeyzNLmDWHU3t3dLEjftu0Y4N3dwrzHE/nubj8f
         9kzbyJpBY8+yNpyw76usJB3yKmZlciBrltSNI5ot1ATP5Stt1NSinjEoX3gjj9WFaTqI
         PQNWVwenF92bOyaOH/rx0JqYrWD7yGS0EMFO+5g1bWAbgz/8y5xpBYP79PKXqRIYrp4r
         TwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718994745; x=1719599545;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2xJkIuTRUfA3qQBx4g1t4rY2WPCKSWoIC96tcIr0dU=;
        b=T76jepVsMQYZ/ZUdK0JTG95ATPUCU3UIW7NPAoo5QICLmGPViom2h+CqezcCCB+Y6y
         HCJ9MdWhVrxeugOEd69tWQbU5/36zrtmGRodmd0mBCcTa69QbJWjugY3yk2iMAgUPoyR
         OCUGnVREN5kPCCxU7UMc9R8fHlaDhMckT5RRj1JBoDI4ALchEEU12DeswB/EkFEpLtIu
         LHnViUCs5ORbNpK2GiEiFAS87yjMIsLRgB7iDYoMWOTXV6ND86mK8dmHr+Los6MxAYL5
         8NPXwf9OE2aull4foFfWnjHwzUmzGEqNr3lmjjsquKwru7NRonxdtOGit85u7tAmfocS
         GB9A==
X-Gm-Message-State: AOJu0YyZogXmuZ028fVy48+lNTHateWvypUa6glcW2ImLc3oiMWYF4Lt
	qEF8O0ohhzgzDa3t9i8WB4uvSHnkOtQp6HMsvoDEcZ9QZKf/n28PiNWR2GA/3cC3rwAeZGIOrB8
	c
X-Google-Smtp-Source: AGHT+IE0i2aXPXCCra04Q/lh1AF5tZnq6Co2qZzDHNNhVLGwjlkkW63jvFsbOJRNxAHzx5vdHd2KYw==
X-Received: by 2002:a05:6870:1714:b0:258:4ae8:4aec with SMTP id 586e51a60fabf-25c94d411damr10051704fac.3.1718994744667;
        Fri, 21 Jun 2024 11:32:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4c040f0sm504037fac.50.2024.06.21.11.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:32:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240621031506.759397-1-dlemoal@kernel.org>
References: <20240621031506.759397-1-dlemoal@kernel.org>
Subject: Re: [PATCH 0/3] Cleanup blkdev zone helpers
Message-Id: <171899474362.173167.8449362939215457619.b4-ty@kernel.dk>
Date: Fri, 21 Jun 2024 12:32:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Fri, 21 Jun 2024 12:15:03 +0900, Damien Le Moal wrote:
> The first patch removes a useless initialization of the number of zones
> of a zoned null_blk device. The following 2 patches rework the zone
> related inline helper functions in blkdev.h to simplify their
> definition, removing uneeded code.
> 
> Damien Le Moal (3):
>   null_blk: Do not set disk->nr_zones
>   block: Define bdev_nr_zones() as an inline function
>   block: Cleanup block device zone helpers
> 
> [...]

Applied, thanks!

[1/3] null_blk: Do not set disk->nr_zones
      commit: 4ac9056e4bd787f1ba2001167c5acc2b5a75ddf9
[2/3] block: Define bdev_nr_zones() as an inline function
      commit: b6cfe2287df6e26d685af8a8a96ed1bf87bdde28
[3/3] block: Cleanup block device zone helpers
      commit: caaf7101c01a91a882d3da2f566579dda692367d

Best regards,
-- 
Jens Axboe



