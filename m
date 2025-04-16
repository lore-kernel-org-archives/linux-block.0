Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D322D4D1
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784853; cv=none; b=SvM0mlefLxZdwEctVvQINT1Hq96OB4E2kSgNB9VsfUB61eLIehr4OmSBD/cNhtXllBTqmsZKw3sSxqd4qZSQnVwFcKAmp30WUmkeR6F4FvOsrmIExDBJ2WoPXSfz3wpY+WtgUl3zfB/idwBe1OuBjhSpeXkJZHfYVr7x3FPZIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784853; c=relaxed/simple;
	bh=KjFq3ynfOWjZNsyInKkKjA/dyH3wqhE4YtixTLTY+4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s12GtMbLyJOXIdP9OEbHZcQLdjl5CwULHKrbWgqM0zOaH4t5b2JOr436Ss05L68YBjCzAsybJqLYp7iH2dNuq6joYYJw3ePzP52w6+pSabC2WSxYKZ3lsnT4hmKZvJ6gLmgNwP3hTebpi3vCPgn/relOzDB1keDOP/1kkJp9czg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQYhh9TI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQYhh9TI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744784850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTqsEaqfQoRzUYlJ/wtXYrZAFHrCEWxlQ9NWGQ3mbUg=;
	b=RQYhh9TIoaVREtkQuXg4QOycspXJ0KvIIPg/jfYdEKUYkxY9TyUmmK294Qznr0aoWOwijV
	/sVE37RCYJJejo2CWP3loNewh4YXSjTvZVT8p/BKaqoUnd+/ZnE0cLR3Lj6auAX6n6Qrsy
	GIBn716WqZtZsY132dnO0mkcISih2oI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-R8wRRH-ANS693dv6MFA-Nw-1; Wed, 16 Apr 2025 02:27:28 -0400
X-MC-Unique: R8wRRH-ANS693dv6MFA-Nw-1
X-Mimecast-MFC-AGG-ID: R8wRRH-ANS693dv6MFA-Nw_1744784847
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-af9b25da540so3883555a12.2
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 23:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744784847; x=1745389647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LTqsEaqfQoRzUYlJ/wtXYrZAFHrCEWxlQ9NWGQ3mbUg=;
        b=VXvbG2SMPhFSa9nOhC43jZuGeDCQLkSZkK9NAoC5yw1SXkJcszJWcuM+Qj6gm1dMpr
         Qm0FBKrSAKQ6jPl8UImCqPjo6i4zV2RF4zaRwlMZ3e6KgkVPjLGLE0Lm1hqxakL+Ly2n
         3cg7/zXDEy6upArIgVN9RuvkM+MjiLNL721ibtvSP/SZdGFcppOQ0fmhvfxpjr4W64oX
         1W92XBBMm/Dt81gyjoC9IUped8LxxnU4QfrqPaTbwIyQU2SvxD17zvE8HVSekd20WaG2
         XT5ta3UyCn5rFXIT8zU7edltJuDwcXRmrxgAgOZxsYZxLT/IO3ZvqYtPv6hHtS3oe+1n
         z/zA==
X-Gm-Message-State: AOJu0YxLbo4xKxNeUkKal1AdtmzrgqHuoyixOyG6mRrJigzw+x2VUfYL
	QqTAnMZZwbveZRqDITcLCKwEBTgo+0eruwjTMyd7WPqpMzEGWAesGjozg+WBoauaNwjdzoKkgD6
	T30yi8IWZ9CWbzCTIsTQBskYAL930Ld/y7bKctQAfxjIEHGxmizhvoAaN7EDF
X-Gm-Gg: ASbGncum5YpjnOWEaygfOA8g0trDDufMudbQH2YwkYy4hfKbNzcfGnrEW37OZ/6t7yJ
	XNIUiD9mjvInVP5M50HZJh/uICQ13fcFtgy4ZWnZRlFU3v8RapqfqhKEHrZbybTIx6wlhwH2h28
	bbdvETruqM6fT06FGvcI1vPZxpJcmRBwsXfcGlVSwccP+RX1H7XX45VijilD1c+YSqS2RsU3hJU
	r/IU1fgmVgNWeo0WM+KIhF9xJwtK3vrJs1dIeE3jMyknaSxBAaObR5kYaB7WhcAuPcy5N8W1YHk
	OodEIhr10JnlU/Q17w==
X-Received: by 2002:a17:902:ce88:b0:21f:4b01:b978 with SMTP id d9443c01a7336-22c3597436cmr11166255ad.36.1744784847371;
        Tue, 15 Apr 2025 23:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH65SPAk/t8wIySGFu6g6N8vPfjCaLNMJi9CRSCpVVdQZvYfu4SCB2iJn99ol3s5Ctog3UPcQ==
X-Received: by 2002:a17:902:ce88:b0:21f:4b01:b978 with SMTP id d9443c01a7336-22c3597436cmr11166055ad.36.1744784847063;
        Tue, 15 Apr 2025 23:27:27 -0700 (PDT)
Received: from [10.72.120.8] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33feb339sm6113475ad.257.2025.04.15.23.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 23:27:26 -0700 (PDT)
Message-ID: <a2444c8a-7c76-44de-a8e8-4023dbdaeb4b@redhat.com>
Date: Wed, 16 Apr 2025 14:27:21 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] md: cleanup accounting for issued sync IO
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, song@kernel.org,
 yukuai3@huawei.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20250412073202.3085138-1-yukuai1@huaweicloud.com>
 <20250412073202.3085138-5-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
In-Reply-To: <20250412073202.3085138-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/4/12 下午3:32, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
>
> It's no longer used and can be removed, also remove the field
> 'gendisk->sync_io'.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.h        | 11 -----------
>   drivers/md/raid1.c     |  3 ---
>   drivers/md/raid10.c    |  9 ---------
>   drivers/md/raid5.c     |  8 --------
>   include/linux/blkdev.h |  1 -
>   5 files changed, 32 deletions(-)
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 95cf11c4abc6..6233ec9f10a3 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -716,17 +716,6 @@ static inline int mddev_trylock(struct mddev *mddev)
>   }
>   extern void mddev_unlock(struct mddev *mddev);
>   
> -static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
> -{
> -	if (blk_queue_io_stat(bdev->bd_disk->queue))
> -		atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
> -}
> -
> -static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
> -{
> -	md_sync_acct(bio->bi_bdev, nr_sectors);
> -}
> -
>   struct md_personality
>   {
>   	struct md_submodule_head head;
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index de9bccbe7337..657d481525be 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -2382,7 +2382,6 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
>   
>   		wbio->bi_end_io = end_sync_write;
>   		atomic_inc(&r1_bio->remaining);
> -		md_sync_acct(conf->mirrors[i].rdev->bdev, bio_sectors(wbio));
>   
>   		submit_bio_noacct(wbio);
>   	}
> @@ -3055,7 +3054,6 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
>   			bio = r1_bio->bios[i];
>   			if (bio->bi_end_io == end_sync_read) {
>   				read_targets--;
> -				md_sync_acct_bio(bio, nr_sectors);
>   				if (read_targets == 1)
>   					bio->bi_opf &= ~MD_FAILFAST;
>   				submit_bio_noacct(bio);
> @@ -3064,7 +3062,6 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
>   	} else {
>   		atomic_set(&r1_bio->remaining, 1);
>   		bio = r1_bio->bios[r1_bio->read_disk];
> -		md_sync_acct_bio(bio, nr_sectors);
>   		if (read_targets == 1)
>   			bio->bi_opf &= ~MD_FAILFAST;
>   		submit_bio_noacct(bio);
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index ba32bac975b8..dce06bf65016 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2426,7 +2426,6 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
>   
>   		atomic_inc(&conf->mirrors[d].rdev->nr_pending);
>   		atomic_inc(&r10_bio->remaining);
> -		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(tbio));
>   
>   		if (test_bit(FailFast, &conf->mirrors[d].rdev->flags))
>   			tbio->bi_opf |= MD_FAILFAST;
> @@ -2448,8 +2447,6 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
>   			bio_copy_data(tbio, fbio);
>   		d = r10_bio->devs[i].devnum;
>   		atomic_inc(&r10_bio->remaining);
> -		md_sync_acct(conf->mirrors[d].replacement->bdev,
> -			     bio_sectors(tbio));
>   		submit_bio_noacct(tbio);
>   	}
>   
> @@ -2583,13 +2580,10 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
>   	d = r10_bio->devs[1].devnum;
>   	if (wbio->bi_end_io) {
>   		atomic_inc(&conf->mirrors[d].rdev->nr_pending);
> -		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(wbio));
>   		submit_bio_noacct(wbio);
>   	}
>   	if (wbio2) {
>   		atomic_inc(&conf->mirrors[d].replacement->nr_pending);
> -		md_sync_acct(conf->mirrors[d].replacement->bdev,
> -			     bio_sectors(wbio2));
>   		submit_bio_noacct(wbio2);
>   	}
>   }
> @@ -3757,7 +3751,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   		r10_bio->sectors = nr_sectors;
>   
>   		if (bio->bi_end_io == end_sync_read) {
> -			md_sync_acct_bio(bio, nr_sectors);
>   			bio->bi_status = 0;
>   			submit_bio_noacct(bio);
>   		}
> @@ -4880,7 +4873,6 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
>   	r10_bio->sectors = nr_sectors;
>   
>   	/* Now submit the read */
> -	md_sync_acct_bio(read_bio, r10_bio->sectors);
>   	atomic_inc(&r10_bio->remaining);
>   	read_bio->bi_next = NULL;
>   	submit_bio_noacct(read_bio);
> @@ -4940,7 +4932,6 @@ static void reshape_request_write(struct mddev *mddev, struct r10bio *r10_bio)
>   			continue;
>   
>   		atomic_inc(&rdev->nr_pending);
> -		md_sync_acct_bio(b, r10_bio->sectors);
>   		atomic_inc(&r10_bio->remaining);
>   		b->bi_next = NULL;
>   		submit_bio_noacct(b);
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 6389383166c0..ca5b0e8ba707 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -1240,10 +1240,6 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
>   		}
>   
>   		if (rdev) {
> -			if (s->syncing || s->expanding || s->expanded
> -			    || s->replacing)
> -				md_sync_acct(rdev->bdev, RAID5_STRIPE_SECTORS(conf));
> -
>   			set_bit(STRIPE_IO_STARTED, &sh->state);
>   
>   			bio_init(bi, rdev->bdev, &dev->vec, 1, op | op_flags);
> @@ -1300,10 +1296,6 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
>   				submit_bio_noacct(bi);
>   		}
>   		if (rrdev) {
> -			if (s->syncing || s->expanding || s->expanded
> -			    || s->replacing)
> -				md_sync_acct(rrdev->bdev, RAID5_STRIPE_SECTORS(conf));
> -
>   			set_bit(STRIPE_IO_STARTED, &sh->state);
>   
>   			bio_init(rbi, rrdev->bdev, &dev->rvec, 1, op | op_flags);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index e39c45bc0a97..f3a625b00734 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -182,7 +182,6 @@ struct gendisk {
>   	struct list_head slave_bdevs;
>   #endif
>   	struct timer_rand_state *random;
> -	atomic_t sync_io;		/* RAID */
>   	struct disk_events *ev;
>   
>   #ifdef CONFIG_BLK_DEV_ZONED


Looks good to me.

Acked-by: Xiao Ni <xni@redhat.com>

