Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42512C7E3
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718235903; cv=none; b=IzwqxF3xA0k5aEB+dkrguchHaZQ9vxJtAL39zgk5jpDpci34HCVAmJr7srzr/IZeqdrYCOvp3eMJGcf3Eu+4tv+WfYDPm6o7Z/eu9NHzHJ9XjAReaptoCCxmw+OEu9x3IQh3Ty2XhcCgAn/zwMyTGZN8WKkDOGrqdypptYRkmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718235903; c=relaxed/simple;
	bh=Sh9ulWfA76UQ5/XkxUkJzP0NCX20AqyT35ulJ2oiuZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I32MD0fx0bB0UZ3V47X7tjW+tD1aab/LISCUL6WgPC0gq3aW71jGzDuzvFWtL0sCm9VUqsjqN8V+HUu5zPJX1lHhW1gUrPgHhiXslSpLuMbWynGwrpcUofSgJquJT4EA3mCa63rP3bUiSqJ9gItRJRZAFp570F6LoyVTSBlwJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq+WFruF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq+WFruF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A14C116B1;
	Wed, 12 Jun 2024 23:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718235903;
	bh=Sh9ulWfA76UQ5/XkxUkJzP0NCX20AqyT35ulJ2oiuZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sq+WFruFjpKDb0oE6wkQZBsx1E44rgLBCycoUzMiVAHToxmy2rbTVIPdVdr4lxjbW
	 dW6w4UGoCJ5a4lHHWwnY0LpRUwDg97HxXfDeObK/L3LbRzaI7ODNCY1jeRZMTBlItf
	 evggIHZCK1zA04rSwJlt57cXGQcpAYjdrTISycs0uHVnBhkn7omlr38tfo9m6fNMM4
	 AGiNAW52YlIfqhWK14Occb3NVxG/x9/vorYdFsfoK+pgd8lPVltdtvGtNihHHTHo87
	 jtSJcOPXZoFn+KgexpQIsB+mfjhvX3NonTH+0F5oJK37DJHuKe3kyVCX55dkyEIV3r
	 NByuiXe2WmUxg==
Message-ID: <5e04760e-1334-4514-b2d0-be0d7df33865@kernel.org>
Date: Thu, 13 Jun 2024 08:45:00 +0900
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
 <c9e43ba8-616a-4c60-9cf9-c99c5b7a4979@kernel.org>
 <715e7a9b-83a5-4df9-8d47-9cdc92b4c173@oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <715e7a9b-83a5-4df9-8d47-9cdc92b4c173@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/24 17:37, John Garry wrote:
> On 10/05/2024 02:40, Damien Le Moal wrote:
> 
> Hi Damien,
> 
>>> block/bdev.c:377:17: warning: symbol 'blockdev_mnt' was not declared.
>>> Should it be static?
>>> block/blk-settings.c:263:9: warning: context imbalance in
>>> 'queue_limits_commit_update' - wrong count at exit
>>> block/blk-cgroup.c:811:5: warning: context imbalance in
>>> 'blkg_conf_prep' - wrong count at exit
>>> block/blk-cgroup.c:941:9: warning: context imbalance in
>>> 'blkg_conf_exit' - different lock contexts for basic block
>>> block/blk-iocost.c:732:9: warning: context imbalance in 'iocg_lock' -
>>> wrong count at exit
>>> block/blk-iocost.c:743:28: warning: context imbalance in 'iocg_unlock'
>>> - unexpected unlock
>>> block/blk-zoned.c:576:30: warning: context imbalance in
>>> 'disk_get_and_lock_zone_wplug' - wrong count at exit
>>> block/blk-zoned.c: note: in included file (through include/linux/blkdev.h):
>>> ./include/linux/bio.h:592:9: warning: context imbalance in
>>> 'blk_zone_wplug_handle_write' - unexpected unlock
>>> block/blk-zoned.c:1721:31: warning: context imbalance in
>>> 'blk_revalidate_seq_zone' - unexpected unlock
>>> block/bfq-iosched.c:5498:9: warning: context imbalance in
>>> 'bfq_exit_icq' - different lock contexts for basic block
>>>
>>> Actually most pre-date v6.9 anyway, apart from the zoned stuff. And the
>>> bdev.c static warning is an outstanding patch, which I replied to.
>> I will have a look at the zone stuff. This is all from the new addition of zone
>> write plugging, so all my bad (I did run with lockdep but did not compile test
>> with sparse).
>>
> Can you confirm that you looked to solve these zoned device sparse 
> warnings and they are difficult to solve?

Yes, I had a look but failed to see any way to remove these. Annotations did not
help, at best only changing these warnings into other warnings.


-- 
Damien Le Moal
Western Digital Research

