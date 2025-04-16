Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C04221550
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784450; cv=none; b=uF7pqMgO2JSS4k8QKr9GYwqGs+Uojmtr04vhV/manv2ug/oHvKLNYhwFgzA8+Jwrbs+m5+A+vrAOYhTomlb5RdlhlWvbWh0MpHJEaMlyf0WxhWcJsclQcEUfsJkSg4R9EERJmPuvRQTpra8iz9NKGv4bFku55poDPoR5VZVO00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784450; c=relaxed/simple;
	bh=fyG+LaseEinJvqb//NskO7ifw3ffsowMbdAO1r2wBKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNLtf/ql3IE23jln285DfPbWZmMhUYNagNNNbtVIaCEHHJbnbt6aTDPyp6gwwW+GbYxUdDwirg+n6oJMcSMkVzmkVbonHb3+Bzgc93D6XlgIo2s83AiQS8fTMIIyjALlP0DWaHYDRKeSYvJ7NhpYsI6LLhcOv4qakEjsNOL9QRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExCgcx1l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExCgcx1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744784446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+BW6iWIahJ+rhQddgpmJQKYvgTYkSD9xoLOew31lvo=;
	b=ExCgcx1lOBW2CS60/PP62balCyYgTl+8zJM6HGcqul5GGjPJHaPqyAihYK7aTCR0e9+krL
	yc6HYDNs70yfPDBEmBaBzAgy67hnkyVgRkXEJ+815CpzgSHiAboSMgwjB0mXfbelmV4qY5
	XUwNqAB8/Joo22irOBYDvMW6prN0HgI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Poaubu41MqCgdHUQUT-Mng-1; Wed, 16 Apr 2025 02:20:45 -0400
X-MC-Unique: Poaubu41MqCgdHUQUT-Mng-1
X-Mimecast-MFC-AGG-ID: Poaubu41MqCgdHUQUT-Mng_1744784444
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7398d70abbfso8017539b3a.2
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 23:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744784443; x=1745389243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+BW6iWIahJ+rhQddgpmJQKYvgTYkSD9xoLOew31lvo=;
        b=l1MCl7Gd4ab+BYB6xq6ymlRWaXm+1ys5Y421fXGQ/4EQI7IMzgFPtNk53zeB9LZK7h
         jJPIEwRUkASGskBVOiDDK7jlQK/+bgxYIqTPv2MeJzSUObaT3jkFByIe7HPFGZGUKQTG
         Lq0ah3BKR4yHVCX44vO12E/SUIHUAM5DIkQJ7eMUPIkYve/neHS9Nc7i4QG3u3OuIP0e
         AN/mMN1NNusXaEunIJTbFLJhDT4wrzuAi7+AHGPVZigoGR4BzWj8xV5Z+mM90FURnQyh
         ZuMobnYokflnrxJAHZ0wqGfVhPhToZrSFzDkvV+U+6cxo3DQeREntb1VeJ72XDpVc5pv
         PPKg==
X-Gm-Message-State: AOJu0YwydeVmrLvFvOy2bt+9wTMhuSeqqMx8guedhIMvTB+5b0bqZ9zq
	Hb9CzAQlcmVWUF8xVFphpAItDmnautj2mWkd0N7lJyJkfaajgtVzLltWjl/3nNtpQTAyLTUSYMd
	UskfFvzUGad61PMBiwRrpKEpYqTmxZCnW4D+wUgY1lqvqW6wI8NpXx9MG7CtrgeW3hB/kYkw=
X-Gm-Gg: ASbGncvsKxmE4CerI8rO7HtnlaorrVckO0iLXGi+/oKSbEGGfUuHWOMdsDSLRzewBc0
	nq9vaKwT8tA1HG0J1ltVT9xT0Jxk12A/vuOxVDajXS+wKqvHTF6wEBHiaoahP0zgJmUMa8JGYXW
	D1fxjebScav/ejCCPdVwrQ+vO+v2cGIAEtPtPtaaMhYqqdToATZrhuhiMQ/oapkcEnaHrujpv4a
	a+bf2sXbUF0vngA2n35PM1w5gNQdBgh5TF3Kmsee0sBKWE0Whq7d/5DeyvkiBA0kEuR3ZVnTUfC
	pyg7fDH+6XIhI5Vl+A==
X-Received: by 2002:aa7:9302:0:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-73c267e1dbdmr1016273b3a.19.1744784443196;
        Tue, 15 Apr 2025 23:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3R2utvbukFLf5ifeN6o3lR+TH28DYbeWRxgoNX0sGxz/3SFKLXAqlAmsfGtjTkNyu+W2+lg==
X-Received: by 2002:aa7:9302:0:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-73c267e1dbdmr1016252b3a.19.1744784442786;
        Tue, 15 Apr 2025 23:20:42 -0700 (PDT)
Received: from [10.72.120.8] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198b6dsm9610728b3a.26.2025.04.15.23.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 23:20:42 -0700 (PDT)
Message-ID: <c085664e-3a52-4a1c-b973-8d2ba6e5d509@redhat.com>
Date: Wed, 16 Apr 2025 14:20:35 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] md: fix is_mddev_idle()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, song@kernel.org,
 yukuai3@huawei.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20250412073202.3085138-1-yukuai1@huaweicloud.com>
 <20250412073202.3085138-4-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
In-Reply-To: <20250412073202.3085138-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/4/12 下午3:32, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
>
> If sync_speed is above speed_min, then is_mddev_idle() will be called
> for each sync IO to check if the array is idle, and inflihgt sync_io
> will be limited if the array is not idle.
>
> However, while mkfs.ext4 for a large raid5 array while recovery is in
> progress, it's found that sync_speed is already above speed_min while
> lots of stripes are used for sync IO, causing long delay for mkfs.ext4.
>
> Root cause is the following checking from is_mddev_idle():
>
> t1: submit sync IO: events1 = completed IO - issued sync IO
> t2: submit next sync IO: events2  = completed IO - issued sync IO
> if (events2 - events1 > 64)
>
> For consequence, the more sync IO issued, the less likely checking will
> pass. And when completed normal IO is more than issued sync IO, the
> condition will finally pass and is_mddev_idle() will return false,
> however, last_events will be updated hence is_mddev_idle() can only
> return false once in a while.
>
> Fix this problem by changing the checking as following:
>
> 1) mddev doesn't have normal IO completed;
> 2) mddev doesn't have normal IO inflight;
> 3) if any member disks is partition, and all other partitions doesn't
>     have IO completed.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c | 78 ++++++++++++++++++++++++++-----------------------
>   drivers/md/md.h |  3 +-
>   2 files changed, 43 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 8966c4afc62a..19da93f8912c 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8619,50 +8619,54 @@ void md_cluster_stop(struct mddev *mddev)
>   	put_cluster_ops(mddev);
>   }
>   
> -static int is_mddev_idle(struct mddev *mddev, int init)
> +static bool is_rdev_idle(struct md_rdev *rdev, bool init)
> +{
> +	unsigned long last_events = rdev->last_events;
> +
> +	if (!bdev_is_partition(rdev->bdev))
> +		return true;


For md array, I think is_rdev_idle is not useful. Because 
mddev->last_events must be increased while upper ios come in and idle 
will be set to false. For dm array, mddev->last_events can't work. So 
is_rdev_idle is for dm array. If member disk is one partition, 
is_rdev_idle alwasy returns true, and is_mddev_idle always return true. 
It's a bug here. Do we need to check bdev_is_partition here?

Best Regards

Xiao

> +
> +	rdev->last_events = part_stat_read_accum(rdev->bdev->bd_disk->part0,
> +						 sectors) -
> +			    part_stat_read_accum(rdev->bdev, sectors);
> +
> +	if (!init && rdev->last_events > last_events)
> +
> +	return true;
> +}
> +
> +/*
> + * mddev is idle if following conditions are match since last check:
> + * 1) mddev doesn't have normal IO completed;
> + * 2) mddev doesn't have inflight normal IO;
> + * 3) if any member disk is partition, and other partitions doesn't have IO
> + *    completed;
> + *
> + * Noted this checking rely on IO accounting is enabled.
> + */
> +static bool is_mddev_idle(struct mddev *mddev, int init)
>   {
>   	struct md_rdev *rdev;
> -	int idle;
> -	int curr_events;
> +	bool idle = true;
>   
> -	idle = 1;
> -	rcu_read_lock();
> -	rdev_for_each_rcu(rdev, mddev) {
> -		struct gendisk *disk = rdev->bdev->bd_disk;
> +	if (!mddev_is_dm(mddev)) {
> +		unsigned long last_events = mddev->last_events;
>   
> -		if (!init && !blk_queue_io_stat(disk->queue))
> -			continue;
> +		mddev->last_events = part_stat_read_accum(mddev->gendisk->part0,
> +							  sectors);
>   
> -		curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
> -			      atomic_read(&disk->sync_io);
> -		/* sync IO will cause sync_io to increase before the disk_stats
> -		 * as sync_io is counted when a request starts, and
> -		 * disk_stats is counted when it completes.
> -		 * So resync activity will cause curr_events to be smaller than
> -		 * when there was no such activity.
> -		 * non-sync IO will cause disk_stat to increase without
> -		 * increasing sync_io so curr_events will (eventually)
> -		 * be larger than it was before.  Once it becomes
> -		 * substantially larger, the test below will cause
> -		 * the array to appear non-idle, and resync will slow
> -		 * down.
> -		 * If there is a lot of outstanding resync activity when
> -		 * we set last_event to curr_events, then all that activity
> -		 * completing might cause the array to appear non-idle
> -		 * and resync will be slowed down even though there might
> -		 * not have been non-resync activity.  This will only
> -		 * happen once though.  'last_events' will soon reflect
> -		 * the state where there is little or no outstanding
> -		 * resync requests, and further resync activity will
> -		 * always make curr_events less than last_events.
> -		 *
> -		 */
> -		if (init || curr_events - rdev->last_events > 64) {
> -			rdev->last_events = curr_events;
> -			idle = 0;
> -		}
> +		if (!init && (mddev->last_events > last_events ||
> +			      part_in_flight(mddev->gendisk->part0)))
> +			idle = false;
>   	}
> +
> +	rcu_read_lock();
> +	rdev_for_each_rcu(rdev, mddev)
> +		if (!is_rdev_idle(rdev, init))
> +			idle = false;
>   	rcu_read_unlock();
> +
>   	return idle;
>   }
>   
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 63be622467c6..95cf11c4abc6 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -132,7 +132,7 @@ struct md_rdev {
>   
>   	sector_t sectors;		/* Device size (in 512bytes sectors) */
>   	struct mddev *mddev;		/* RAID array if running */
> -	int last_events;		/* IO event timestamp */
> +	unsigned long last_events;	/* IO event timestamp */
>   
>   	/*
>   	 * If meta_bdev is non-NULL, it means that a separate device is
> @@ -519,6 +519,7 @@ struct mddev {
>   							 * adding a spare
>   							 */
>   
> +	unsigned long			last_events;	/* IO event timestamp */
>   	atomic_t			recovery_active; /* blocks scheduled, but not written */
>   	wait_queue_head_t		recovery_wait;
>   	sector_t			recovery_cp;

