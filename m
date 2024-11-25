Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679387FD
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732502202; cv=none; b=Oad5hkJpiYyJlwAmvM/VYLkDv79hsJs/rlR1AxNgWXpwZw9pzPDsFFfy3TicCe4gM5LHXkiA9M2n1dfGvr2qzS7hGtShL+Ct0tG7EEsUTkdDtHDX0jKWkiIuvlHfI9cjm/v5rQ1FYShanszO4vhGGwqz7EEV+2YPA/pQiM8kLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732502202; c=relaxed/simple;
	bh=bxdS2VWEHX7/s5aWm8JFDGqqmI4olLS2+JiurWQBgkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUiA/7O6ekeQJPj7S6tB51QT/aF33YWz6vXDNjW4lABfLmXSFyHJ2XQFHwWdYhMqZlmhH6btzfX148kXnFnmduEOlkBjpeqgf9ThyKjucvM2gwO0OFvmVTG7Ia/8vdZg7gbEsgzovYyBp6aFZeTchACPM7NyxABaxqKOKue2U6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmAW3YJP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmAW3YJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966B7C4CED1;
	Mon, 25 Nov 2024 02:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732502202;
	bh=bxdS2VWEHX7/s5aWm8JFDGqqmI4olLS2+JiurWQBgkE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KmAW3YJPk9b7AtYoCKsLgXuD/kpWv8cUSQQXZpV644//ugvp5T7q+Xyv1hDsttOBd
	 TGRJTxdTFlevwNMdKBIkHzn61nuP5dYy1nHT/hZl8U6q3eouHkFblvBvCnuTeqq+ao
	 bjKvkMPsVbSwpzrxUO1scI+CFYdjr/G3u4aChuQ+G5q5Kon1/FaFt8z0CrKmOTQWcP
	 5aWT9yaCKSTo9FmEPeeDPwgWECsFOL0FmRl2PnTiehhieyfx/mCHkT9KUQIwQ/EDn6
	 ZL0Hqr5NZJQAP5e0vCcRU2Xc6fogjjqvwOa/RBwNWdnSnDkoMm1Sc1yMRH1lJv74b9
	 ijWWGNSb+LXgA==
Message-ID: <73427797-9620-4cb7-bc9e-3f073eaa57fe@kernel.org>
Date: Mon, 25 Nov 2024 11:36:27 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zone write plugging and the queue full condition
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <33753e7a-d38c-4a5e-9a8e-c2e27000337c@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <33753e7a-d38c-4a5e-9a8e-c2e27000337c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/23/24 12:08 PM, Bart Van Assche wrote:
> Hi Damien,
> 
> If I run the following shell commands:
> 
> modprobe -r scsi_debug
> modprobe scsi_debug delay=0 dev_size_mb=256 every_nth=2 max_queue=1 \
>   opts=0x8000 sector_size=4096 zbc=host-managed zone_nr_conv=0 zone_size_mb=4
> while true; do
>     bdev=$(cd /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block
> && echo *) 2>/dev/null
>     if [ -e /dev/"${bdev}" ]; then break; fi
>     sleep .1
> done

Running this script, I never get out of this loop... Weird. I changed the
script to this:

...
while true; do
	bdev="$(lsscsi -g | grep scsi_debug | cut -d'/' -f3)"
	if [ ! -z "${bdev}" ]; then
		break;
       	fi
	sleep .1
done
dev="/dev/${bdev}"
[ -b "${dev}" ]
...

and then it runs, but I do not see anything blocked. All is fine. Could you
share your kernel config to see what I am missing may be ?

> dev=/dev/"${bdev}"
> [ -b "${dev}" ]
> fio --direct=1 --filename=$dev --iodepth=1 --ioengine=io_uring \
>     --ioscheduler=none --gtod_reduce=1 --hipri=0 --name="$(basename "${dev}")" \
>     --runtime=30 --rw=rw --time_based=1 --zonemode=zbd &
> sleep 2
> echo w > /proc/sysrq-trigger
> 
> then the following appears in the kernel log:
> 
>     sysrq: Show Blocked State
>     task:(udev-worker)   state:D stack:0     pid:3121  tgid:3121 ppid:2191   fl
> ags:0x00000006
>     Call Trace:
>      <TASK>
>      __schedule+0x3e8/0x1410
>      schedule+0x27/0xf0
>      blk_mq_freeze_queue_wait+0x6f/0xa0
>      queue_attr_store+0x60/0xc0
>      kernfs_fop_write_iter+0x13e/0x1f0
>      vfs_write+0x25b/0x420
>      ksys_write+0x65/0xe0
>      do_syscall_64+0x82/0x160
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Do you agree that the above indicates that blk_mq_freeze_queue_wait()
> hangs? I think it is waiting for a q_usage_counter reference that is
> held by a bio on a zwplug->bio_list.
> 
> Do you agree that the best way to solve this is to modify
> blk_mq_submit_bio() by moving the blk_zone_plug_bio() call after the
> blk_crypto_rq_get_keyslot() call and also to change the zwplug bio list
> into a request list?

I am not following... blk_zone_plug_bio() acts on BIOs, not on requests, but
blk_crypto_rq_get_keyslot() is a request operation. Also, a requeue list is a
list of requests, not BIOs. One of the main point of zone write plugs is to
operate on BIOs so that:
1) we have code that is common for regular block devices and for BIO based
device-mapper devices.
2) Blocking writes to preserve per-zone write ordering does not result in
device resources (TAGS !) being held for nothing and potentially
delaying/starving read accesses or other operations that do not need ordering.

How can a requeue list help ? Please provide details.

-- 
Damien Le Moal
Western Digital Research
