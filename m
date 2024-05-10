Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3E137928
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715305240; cv=none; b=FGwm7q/uwMIfK/UWwkrqoISi86vifcpGIc9Kd2QI6bem9gKCFawwKZRQBajJQ2XTz6UgUJ4YLhdtEnds+fVpEuI3W+jK/JzHauc73p64/eToGzURnweyk33VK6ixqVlIwWF7YV2Zy6AzWvmLb8rblzOAstHrQanKcMWIGSeXBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715305240; c=relaxed/simple;
	bh=tmWEnz9UjIow/kUQIQ2LrnMH8Og8DugePVyTmK8VGGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUwwpJEnhJ7JBysS+cv69MIb1SJatcDlME6+daPM+8gcNhaTaUcZv45bVxai2UbNUgFTQ6BFwSyIJ9SNnKPl0GJxHnxJ/4pIfzqllqSL3hEKudtw/CaGov2CFihwadCDycw0Ov4GuNA4rgl6xgyc84zVyQrGvmue9Tc3YLz0POQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feUmQhcg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feUmQhcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EE7C116B1;
	Fri, 10 May 2024 01:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715305239;
	bh=tmWEnz9UjIow/kUQIQ2LrnMH8Og8DugePVyTmK8VGGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=feUmQhcgZUnMWQZsH9uGY4zcSfLyAQ7DJsFnaCxwQ7GLrI/0ApN/8PfVNPnmtNyqZ
	 JjZKmvfvi1Ujh5cVsZKD/oGSIn02iNcdSQG7bW9Z1LXhzZ6M8OCGqMjDAXC0T8A3gW
	 Fgqu3mfZ1uh4WaSEE75fvKuUuSDf418f4gO3N5s7K8nnFSTyej2xLFwToX+NPihs78
	 KhVd06Oflz18J58wknZLoVVuuRKakZHeZUyI3ug8aHpUC0HjMX/kSxktaTtdLroti2
	 E0jz5fysqXCOYAfWihEdEBIA7Xp0NQdM8a8xJSm1CfBmnDbd6n7XXLoaoe9wt/ws+u
	 Q+Qrt4x2AQTLg==
Message-ID: <c9e43ba8-616a-4c60-9cf9-c99c5b7a4979@kernel.org>
Date: Fri, 10 May 2024 10:40:38 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
To: John Garry <john.g.garry@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20240405085018.243260-1-hch@lst.de>
 <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com>
 <20240405143856.GA6008@lst.de>
 <343cc769-b318-4c2d-b08a-0bc752f41f78@oracle.com>
 <20240405171330.GA16914@lst.de>
 <293dbd7b-9955-48f4-9eb4-87db1ec9335a@oracle.com>
 <20240509125856.GB12191@lst.de>
 <4bc6ab52-31b0-4e1c-96d1-2568a43af7b5@oracle.com>
 <e2181429-3f0b-4999-87b7-8fbc8aea3765@kernel.dk>
 <65430500-14bc-4e71-ba40-024ef293bc4a@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <65430500-14bc-4e71-ba40-024ef293bc4a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 00:04, John Garry wrote:
> On 09/05/2024 15:00, Jens Axboe wrote:
>>> But, uggh, now I see more C=1 warnings on Jens' 6.9 branch. It's quite
>>> late to be sending fixes for those (for 6.9)...
>>>
>>> I'll send then anyway.
>> Send it for 6.10.
> 
> ok, fine.
> 
> JFYI, Here's what I found on the 6.10 queue in block/:
> 
> block/bdev.c:377:17: warning: symbol 'blockdev_mnt' was not declared.
> Should it be static?
> block/blk-settings.c:263:9: warning: context imbalance in
> 'queue_limits_commit_update' - wrong count at exit
> block/blk-cgroup.c:811:5: warning: context imbalance in
> 'blkg_conf_prep' - wrong count at exit
> block/blk-cgroup.c:941:9: warning: context imbalance in
> 'blkg_conf_exit' - different lock contexts for basic block
> block/blk-iocost.c:732:9: warning: context imbalance in 'iocg_lock' -
> wrong count at exit
> block/blk-iocost.c:743:28: warning: context imbalance in 'iocg_unlock'
> - unexpected unlock
> block/blk-zoned.c:576:30: warning: context imbalance in
> 'disk_get_and_lock_zone_wplug' - wrong count at exit
> block/blk-zoned.c: note: in included file (through include/linux/blkdev.h):
> ./include/linux/bio.h:592:9: warning: context imbalance in
> 'blk_zone_wplug_handle_write' - unexpected unlock
> block/blk-zoned.c:1721:31: warning: context imbalance in
> 'blk_revalidate_seq_zone' - unexpected unlock
> block/bfq-iosched.c:5498:9: warning: context imbalance in
> 'bfq_exit_icq' - different lock contexts for basic block
> 
> Actually most pre-date v6.9 anyway, apart from the zoned stuff. And the 
> bdev.c static warning is an outstanding patch, which I replied to.

I will have a look at the zone stuff. This is all from the new addition of zone
write plugging, so all my bad (I did run with lockdep but did not compile test
with sparse).

> 
> At a glance, some of those pre-v6.9 issues looks non-trivial to fix, 
> which may be the reason that they have not been fixed...

Yeah. The context imbalance warnings are sometimes hard to address depending on
the code. Let's see.

-- 
Damien Le Moal
Western Digital Research

