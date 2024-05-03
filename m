Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB157C84
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748757; cv=none; b=dZybmuXI0lo4knNfq8yfQnX0wTwkgD6VE4UQvMfNlYqBKvkWd/1PGB3NRR1Zq+eMOUZVVCuqsq9jRClY9ydybIHxTRofHi1bz13mkdacP9TOrJhAePJ0RkHQYxmkIxN7BO30ZWsqCymX4+l1Id86ZKgv/9UsPSadc4Tv9pcwMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748757; c=relaxed/simple;
	bh=aPKuY60LYb8djueqbspXvDA/fp7HMWrUuOnGy+bGaQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aw48AWuvhiIB60vWV0hZiESlA7X90Pygi5QvY2kiAL7gPZ3OfR3kYnnw97VzL8sUHgbXx1XZ9znnwGKTx4KoP3kiSgIGrWzo1lrzqOwNaj76gH8eESYDDH124dkjP1SX6x/OGpy1k7zvzA66H9nFPMDwlUbb53p8ZYlfQeRXWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AHHzS+VX; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AHHzS+VX"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7dee044afe7so4571939f.2
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714748755; x=1715353555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rMaRlN91jTTFNhl3+24cdskOndxFw8DNZxZaaue9Vc=;
        b=AHHzS+VX3OyqyQ4g7ZvpQHuPPlKs20QJc96q4YeJQB6tem4TbnzPd7dhGVH4sAMFjr
         AtCsaMXVSQxnOYIQSi7zBBoni+J36arcz/oVBMlVM3J7VRud1fmqqQ4FJKedfgdNjyiB
         vKtuM+g5zORQVn2ZeCk8OtLABuqB54cm5xHt+PyvcUuBpWMfRjdUCmg64seK4ZDEHThg
         vHM6d0YUQmqeDHVxz2wjgJ7qFd1E68uIg+X5Ov337NAN+j47wY5+OBzK/EFzdvCjBHuV
         PGzcT8uhAXLFTt11Fi7zTHCKzc/GToPpgIynLckvr6vV/obH3XntOXRMbRkk3jkfFu17
         bqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714748755; x=1715353555;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rMaRlN91jTTFNhl3+24cdskOndxFw8DNZxZaaue9Vc=;
        b=G7tJwZ+2XYK1bNRKYQXPF9dcSTSQJuuP/EBtzDmrPZPqSOVYwIeBGpa4bDwevUrrjV
         PggvErHn9oR0sJTolXQrGG6ZPha2LzDfKxgnAp17tLbNeSc+1w8nJcplf9gzruDzmGsV
         vZIkzIvVrE5nKI1B0zz5xENpz5DaMDAjcJCoDrYkjVVdyGT7YVRY/sSwHnHzcihSRyOb
         pFkbYqpfUqVIaUCnnKGd+mB+D87QLocZZL4KNHO9faUHOgz5jBQElBFTFZpf9GsCujqJ
         Z87HNo8mkW5YirqW02Sryx7KSQ4jy4RfBmq/vqrbNTrqR0TZVUxs39eApzcaVYSkg7WY
         dt0A==
X-Gm-Message-State: AOJu0YyEgFcJ7WMpDhP6A+dpb6WkLd8jK7F5F3/uV03ztasNTdzXuxHB
	Uci7G0awERqr5E3aL9y7N8ZrJLUPYUDxRm9Mn+GRdZPNr/i2G78RMMUbA3UIHlI=
X-Google-Smtp-Source: AGHT+IHsgxYjwfisljAlgiytiGBCEg/h/caWKTB9yHrYbIPuYPCYMgLcpshOrfv+Twi+rqTg5ZfYJA==
X-Received: by 2002:a5d:94c7:0:b0:7de:b4dc:9b8f with SMTP id y7-20020a5d94c7000000b007deb4dc9b8fmr2862572ior.2.1714748754672;
        Fri, 03 May 2024 08:05:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ix20-20020a056638879400b00487cf11342fsm822055jab.102.2024.05.03.08.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:05:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, 
 syzbot+0a3683a0a6fecf909244@syzkaller.appspotmail.com
In-Reply-To: <20240503081042.2078062-1-hch@lst.de>
References: <20240503081042.2078062-1-hch@lst.de>
Subject: Re: [PATCH] block: refine the EOF check in blkdev_iomap_begin
Message-Id: <171474875400.33279.6512906060593711937.b4-ty@kernel.dk>
Date: Fri, 03 May 2024 09:05:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 03 May 2024 10:10:42 +0200, Christoph Hellwig wrote:
> blkdev_iomap_begin rounds down the offset to the logical block size
> before stashing it in iomap->offset and checking that it still is
> inside the inode size.
> 
> Check the i_size check to the raw pos value so that we don't try a
> zero size write if iter->pos is unaligned.
> 
> [...]

Applied, thanks!

[1/1] block: refine the EOF check in blkdev_iomap_begin
      commit: 0c12028aec837f5a002009bbf68d179d506510e8

Best regards,
-- 
Jens Axboe



