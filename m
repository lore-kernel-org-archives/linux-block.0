Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13CE446855
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695998; cv=none; b=CoqDwhG++PRjWP0EQTATbzGFw4AVD7CZAf6+u3LS+wsMOkGomriz1434yScr4ubrUFLZxjKA2rWjTLufpyDETbF03vnqXbP0EUnUHDF6euj1LzcEerUkX8yvD2Qn4l4sUtYEeAdkuiD92NWIsPkbyPcwW0QmjHteFh/4chcSFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695998; c=relaxed/simple;
	bh=Ame5cjoO59O55wzym8HyjdPZVeVWGDrYd5P+qO58PQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIsMaNz8laJswCCfu1naByGND9Y4sn/BcOmC2KkVPbKANMqLYsGToFDA0jksrx31LZhETEExWRx3pnFPLouM2F0OanH9O3Io1rFeE9j7Q/3YlKF55zJC5lcJk3wZm/zdHoqGvHFhibiEuR46I9kdplUsIOgJlbFDTSHTWDuDKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLaUyJJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLaUyJJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAA11F00A3A;
	Fri, 14 Aug 2026 08:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786695993;
	bh=ZH7ot2O/zBuXdjmCvjAddC4rA6F6DZnad7AnQyEXkqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MLaUyJJ5uRfs/p13Dv4ne8846DM+EwQoEz0T9oLVE73XLmywLB2eH+dU8frtmT5jC
	 8GC2WhkC2Acpn98nkx9D6f5z0kRdUtZPIieTaszoiotaaMWQP2btvlEirKXc6iSfcC
	 oUmOn39cm9tnfysCZiS4ehWX4xV9IWcuGX9hV6pk1+SEkCnC1cVznEagF36f4srMI3
	 4uNmetR34SwNUViYgKWhiGJsYwTObWAfcy17jjuaChEtHcQR1Y9EA2mO9R9nyJ+0Vj
	 fjfIlD+5oBOm+5dlZ+KgJBRz6bGHVXG/QZ6HwdK0+/Y5dE/0y0XUYFDz1wvqQTq1pk
	 HT2zfM2QUWqCg==
Message-ID: <b91cdca3-4d54-454f-888a-0685a50b854b@kernel.org>
Date: Fri, 14 Aug 2026 17:26:31 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] block: flag zoned disks with GENHD_FL_NO_PART
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260814063201.1762743-1-dlemoal@kernel.org>
 <20260814063201.1762743-14-dlemoal@kernel.org>
 <20260814081205.GH12566@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260814081205.GH12566@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 17:12, Christoph Hellwig wrote:
> On Fri, Aug 14, 2026 at 03:32:01PM +0900, Damien Le Moal wrote:
>> Zoned block devices do not support partitions. However, the partition
>> table is nevertheless still inspected, and any partition found ignored
>> with a warning in add_partition(). While this is generally not a problem,
>> and in fact beneficial to the user as it indicates an invalid use of a
>> zoned block device, scanning for a partition table on the device may
>> result in issuing read operations to offline zones (e.g. after a disk head
>> is depopulated for disks that support head management operations).
>>
>> Since partitions are ignored anyway, completely disable partition scanning
>> for zoned gendisks by setting the flag GENHD_FL_NO_PART in __add_disk().
>> The existing check in add_partition() is left as-is to ensure that we
>> still get a warning if for whatever reason, despite GENHD_FL_NO_PART, we
>> still endup trying to add partitions.
>>
>> Flagging zoned disks with GENHD_FL_NO_PART also has the benefit to expose
>> through sysfs the ext_range attribute with the value of 1 instead of the
>> default DISK_MAX_PARTS, thus correctly advertizing the fact that zoned
>> disks do not support partitions.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> 
> This really should get a Fixes for my original patch that skipped
> partitions and go to -stable (and into 7.3 even if Jens won't take
> the whole series) as it causes totally pointless I/O.  I also suspect
> the partition scanning and blkid interaction might be related to some
> of the weirdo xfstests failure I see where blkid doesn't detect
> xfs file systems in synthetic devices.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Will add the fixes tag.

-- 
Damien Le Moal
Western Digital Research
