Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B61A3037
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174780; cv=none; b=ADPyLrtTU/GQc0GBbqCaFqe2fqYvM/FvHD+9EQ29pUy0kjtzvAyab3iRdsFT/qqgBlR4cGp+/yy2o8MGwA47rcey5dSYi+zr7t2rX3kA1jT0w3gxRmipCOxKgKTL7QRIqz6dhU2ch6EKeQgVP46NSLozEgv+I7c18yfYJq8qJcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174780; c=relaxed/simple;
	bh=G54obQZIcC67sGikegICP6BpX/1sIpFRi1R+Ah/feIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzE1CeofR+fcb3bspbMK+K9+3WRSiim6FZUmk8LOc/2mA4oC0gLHFgx9xAme3Z3ejK7NZn+Lz6c69hl3ibn5hmXpFmo3M4DTcWQf11ubuBM2SrqCvvJWYTQgDK+FJgrjSc1ThACPIxffa7GT8j8Xbj7+HUSt0uhtomClgQ15o+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3787f30d892so3089147f8f.0
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 03:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727174776; x=1727779576;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxIELkZ4DgTNwQYPSMC0C0SeXDsANQR2qM9X6w8Q4s0=;
        b=QAwN1zJ35uCGOrGYMbX+rW9pigvZ7bzUPT+0oCSoqpszo6IP3qsbFwZw7vDf+qOzOB
         a3Y1xnOm1XMGttODXzD8AweaBbNg9cGBkdhGmghVIixUcbgULmtTZXfoivddAHfROV8c
         XXBXz2pQz0Y7lH8IsGvcD3Z3gLoL41e/rYFGdw0+b7A5dXgFsO9OOci0kWlxO9QH424V
         UVOjLZlsAlitdbekZkHVK+zN6VMNeyTpBDI0u/+nWxsWzVxQFcqRNlSOvJrhPSIm6XLF
         b82+jYlc4YZ54K++epskfL9yzNlvJt9BwVPlODtH7+bruBxJUx7UKiCkDHtIZGzouchZ
         ctpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyTXf+1XPZ/FaMSuDZQMHLDFhyyDCEcH9rgHtbUFEguQ1jxKIUNn/wX6egrvLIIj5I48WKIyGVAgMkNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2rTg/d/sW5+KXbIYGRhafdaZrPywWROJ3+Vmegf2nJ+/A+DY0
	RYVFKWLI51vvE0jhsrbp0p/zY1o7443xhRn36ml1L4JmHCzxtu2w
X-Google-Smtp-Source: AGHT+IHfpoIbBiHbtzJElRTAVpLYHoG45kAyQRUKora9DnJuM2oOaXWGg+e9N9FmfCU0s/zaJmZ5MA==
X-Received: by 2002:a05:6000:1961:b0:368:7fbc:4062 with SMTP id ffacd0b85a97d-37a422c77c6mr8995413f8f.33.1727174776021;
        Tue, 24 Sep 2024 03:46:16 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2a8b09sm1242044f8f.18.2024.09.24.03.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 03:46:15 -0700 (PDT)
Message-ID: <e30fe828-0786-40d7-9da9-4f570d261542@kernel.org>
Date: Tue, 24 Sep 2024 12:46:13 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Prevent deadlocks when switching elevators
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
 Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240908000704.414538-1-dlemoal@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240908000704.414538-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08. 09. 24, 2:07, Damien Le Moal wrote:
> Commit af2814149883 ("block: freeze the queue in queue_attr_store")
> changed queue_attr_store() to always freeze a sysfs attribute queue
> before calling the attribute store() method, to ensure that no IOs are
> in-flight when an attribute value is being updated.
> 
> However, this change created a potential deadlock situation for the
> scheduler queue attribute as changing the queue elevator with
> elv_iosched_store() can result in a call to request_module() if the user
> requested module is not already registered. If the file of the requested
> module is stored on the block device of the frozen queue, a deadlock
> will happen as the read operations triggered by request_module() will
> wait for the queue freeze to end.
> 
> Solve this issue by introducing the load_module method in struct
> queue_sysfs_entry, and to calling this method function in
> queue_attr_store() before freezing the attribute queue.
> The macro definition QUEUE_RW_LOAD_MODULE_ENTRY() is added to define a
> queue sysfs attribute that needs loading a module.
> 
> The definition of the scheduler atrribute is changed to using
> QUEUE_RW_LOAD_MODULE_ENTRY(), with the function
> elv_iosched_load_module() defined as the load_module method.
> elv_iosched_store() can then be simplified to remove the call to
> request_module().

Hi,

this broke udev rules for loop in 6.11:
 > loop1: /usr/lib/udev/rules.d/60-io-scheduler.rules:25 Failed to write 
ATTR{/sys/devices/virtual/block/loop1/queue/scheduler}="none", ignoring: 
No such file or directory
 > loop0: /usr/lib/udev/rules.d/60-io-scheduler.rules:25 Failed to write 
ATTR{/sys/devices/virtual/block/loop0/queue/scheduler}="none", ignoring: 
No such file or directory
 > loop5: /usr/lib/udev/rules.d/60-io-scheduler.rules:25 Failed to write 
ATTR{/sys/devices/virtual/block/loop5/queue/scheduler}="none", ignoring: 
No such file or directory
 > loop3: /usr/lib/udev/rules.d/60-io-scheduler.rules:25 Failed to write 
ATTR{/sys/devices/virtual/block/loop3/queue/scheduler}="none", ignoring: 
No such file or directory
 > loop2: /usr/lib/udev/rules.d/60-io-scheduler.rules:25 Failed to write 
ATTR{/sys/devices/virtual/block/loop2/queue/scheduler}="none", ignoring: 
No such file or directory
 > loop7: /usr/lib/udev/rules.d/60-io-scheduler.rules:25 Failed to write 
ATTR{/sys/devices/virtual/block/loop7/queue/scheduler}="none", ignoring: 
No such file or directory
 > loop4: /usr/lib/udev/rules.d/60-io-scheduler.rules:25 Failed to write 
ATTR{/sys/devices/virtual/block/loop4/queue/scheduler}="none", ignoring: 
No such file or directory
 > loop6: /usr/lib/udev/rules.d/60-io-scheduler.rules:25 Failed to write 
ATTR{/sys/devices/virtual/block/loop6/queue/scheduler}="none", ignoring: 
No such file or directory


60-io-scheduler.rules:
>      1  # Set optimal IO schedulers for HDD and SSD
>      2  # Copyright (c) 2021 SUSE LLC
>      3
>      4  # ## DO NOT EDIT. ##
>      5  # To modify the rules, copy this file to /etc/udev/rules.d/60-io-scheduler.rules
>      6  # and edit the copy.
>      7  # Please read the section "Tuning I/O performance" in the System Analysis and Tuning Guide
>      8  # from the SUSE Documentation.
>      9
>     10  # --- DO NOT EDIT THIS PART ----
>     11  SUBSYSTEM!="block", GOTO="scheduler_end"
>     12  ACTION!="add|change", GOTO="scheduler_end"
>     13  ENV{DEVTYPE}!="disk", GOTO="scheduler_end"
>     14  TEST!="%S%p/queue/scheduler", GOTO="scheduler_end"

It apparently exists here ^^^.

>     15
>     16  # For dm devices, the relevant events are "change" events, see 10-dm.rules
>     17  ACTION!="change", KERNEL=="dm-*", GOTO="scheduler_end"
>     18  # "none" with no brackets means scheduler isn't configurable
>     19  ATTR{queue/scheduler}=="none", GOTO="scheduler_end"
>     20  # keep our hands off zoned devices, the kernel auto-configures them
>     21  ATTR{queue/zoned}!="none", GOTO="scheduler_end"
>     22  # Enforce "none" for multipath components.
>     23  ENV{DM_MULTIPATH_DEVICE_PATH}=="1", ATTR{queue/scheduler}="none", GOTO="scheduler_end"
>     24  # Enforce "none" for loop devices
>     25  KERNEL=="loop[0-9]*", ATTR{queue/scheduler}="none", GOTO="scheduler_end"

But cannot be written to ^^^ because it does not exist. What the heck?

>     26
>     27  # --- EDIT BELOW HERE after copying to /etc/udev/rules.d ---
>     28
>     29  # Uncomment these if you want to force virtual devices to use no scheduler
>     30  # KERNEL=="vd[a-z]*", ATTR{queue/scheduler}="none", GOTO="scheduler_end"
>     31  # KERNEL=="xvd[a-z]*", ATTR{queue/scheduler}="none", GOTO="scheduler_end"
>     32
>     33  # Leave virtual devices untouched
>     34  KERNEL=="vd[a-z]*", GOTO="scheduler_end"
>     35  KERNEL=="xvd[a-z]*", GOTO="scheduler_end"
>     36
>     37  # 1. BFQ scheduler for single-queue HDD
>     38  ATTR{queue/rotational}!="0", TEST!="%S%p/mq/1", ATTR{queue/scheduler}="bfq", GOTO="scheduler_end"
>     39
>     40  # 2. BFQ scheduler for every HDD, including "real" multiqueue
>     41  # ATTR{queue/rotational}!="0", ATTR{queue/scheduler}="bfq", GOTO="scheduler_end"
>     42
>     43  # 3. For "real" multiqueue devices, the kernel defaults to no IO scheduling
>     44  # Uncomment this (and select your scheduler) if you need an IO scheduler for them
>     45  # TEST=="%S%p/mq/1", ATTR{queue/scheduler}="kyber", GOTO="scheduler_end"
>     46
>     47  # 4. BFQ scheduler for every device (uncomment if you need ionice or blk-cgroup features)
>     48  # ATTR{queue/scheduler}="bfq", GOTO="scheduler_end"
>     49
>     50  # 5. mq-deadline is the kernel default for devices with just one hardware queue
>     51  # ATTR{queue/scheduler}="mq-deadline"
>     52
>     53  # --- EDIT ABOVE HERE after copying to /etc/udev/rules.d ---
>     54  LABEL="scheduler_end"


Any ideas?





> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Reported-by: Jiri Jaburek <jjaburek@redhat.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219166
> Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-sysfs.c | 22 +++++++++++++++++++++-
>   block/elevator.c  | 21 +++++++++++++++------
>   block/elevator.h  |  2 ++
>   3 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 60116d13cb80..e85941bec857 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -23,6 +23,7 @@
>   struct queue_sysfs_entry {
>   	struct attribute attr;
>   	ssize_t (*show)(struct gendisk *disk, char *page);
> +	int (*load_module)(struct gendisk *disk, const char *page, size_t count);
>   	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
>   };
>   
> @@ -413,6 +414,14 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
>   	.store	= _prefix##_store,			\
>   };
>   
> +#define QUEUE_RW_LOAD_MODULE_ENTRY(_prefix, _name)		\
> +static struct queue_sysfs_entry _prefix##_entry = {		\
> +	.attr		= { .name = _name, .mode = 0644 },	\
> +	.show		= _prefix##_show,			\
> +	.load_module	= _prefix##_load_module,		\
> +	.store		= _prefix##_store,			\
> +}
> +
>   QUEUE_RW_ENTRY(queue_requests, "nr_requests");
>   QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
>   QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
> @@ -420,7 +429,7 @@ QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
>   QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
>   QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
>   QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
> -QUEUE_RW_ENTRY(elv_iosched, "scheduler");
> +QUEUE_RW_LOAD_MODULE_ENTRY(elv_iosched, "scheduler");
>   
>   QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
>   QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
> @@ -670,6 +679,17 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>   	if (!entry->store)
>   		return -EIO;
>   
> +	/*
> +	 * If the attribute needs to load a module, do it before freezing the
> +	 * queue to ensure that the module file can be read when the request
> +	 * queue is the one for the device storing the module file.
> +	 */
> +	if (entry->load_module) {
> +		res = entry->load_module(disk, page, length);
> +		if (res)
> +			return res;
> +	}
> +
>   	blk_mq_freeze_queue(q);
>   	mutex_lock(&q->sysfs_lock);
>   	res = entry->store(disk, page, length);
> diff --git a/block/elevator.c b/block/elevator.c
> index f13d552a32c8..c355b55d0107 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -698,17 +698,26 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
>   		return 0;
>   
>   	e = elevator_find_get(q, elevator_name);
> -	if (!e) {
> -		request_module("%s-iosched", elevator_name);
> -		e = elevator_find_get(q, elevator_name);
> -		if (!e)
> -			return -EINVAL;
> -	}
> +	if (!e)
> +		return -EINVAL;
>   	ret = elevator_switch(q, e);
>   	elevator_put(e);
>   	return ret;
>   }
>   
> +int elv_iosched_load_module(struct gendisk *disk, const char *buf,
> +			    size_t count)
> +{
> +	char elevator_name[ELV_NAME_MAX];
> +
> +	if (!elv_support_iosched(disk->queue))
> +		return -EOPNOTSUPP;
> +
> +	strscpy(elevator_name, buf, sizeof(elevator_name));
> +
> +	return request_module("%s-iosched", strstrip(elevator_name));
> +}
> +
>   ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>   			  size_t count)
>   {
> diff --git a/block/elevator.h b/block/elevator.h
> index 3fe18e1a8692..2a78544bf201 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -148,6 +148,8 @@ extern void elv_unregister(struct elevator_type *);
>    * io scheduler sysfs switching
>    */
>   ssize_t elv_iosched_show(struct gendisk *disk, char *page);
> +int elv_iosched_load_module(struct gendisk *disk, const char *page,
> +			    size_t count);
>   ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
>   
>   extern bool elv_bio_merge_ok(struct request *, struct bio *);

thanks,
-- 
js
suse labs

