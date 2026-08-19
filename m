Received: from mta1.migadu.com (out-159.mta1.migadu.com [95.215.58.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7A43E07E
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132644; cv=none; b=hWixnF3jEEWQYJKZAt8wCRjc2qAB8K1P6Bj/JNuzvaeoR0klN9VO5gX3n4Q19GijKMCFbRToXvgKF55E0MlWJP5FefpSCKCvERYe5ezNmpMHjA+nb+/U0Fq6hRwVL6tHrYP4k0hxlEemasUwayceifsUxdbMcmLWKUTkeka09+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132644; c=relaxed/simple;
	bh=vi6K1Mgx+fZIvgXzENIjHfOngQ5Nx2T8UVV7jOpIREw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAMVhhzcY/oJNw+d7qlNTDoyoi+R6SocLfk5FWuqWZpvDO7opNFd3NsfryZQ3mnKgUuHpc7F5TOsFRoEOyW8CwNKXzrrgvLb8cuPri5HmJkvZPUkL8v0dxUmfbAhbY319NFCn/leu6Gv7emKlpmQtMNTvHDcWcRfK5KQcTgJ+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GFcLilbZ; arc=none smtp.client-ip=95.215.58.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GFcLilbZ"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vi6K1Mgx+fZIvgXzENIjHfOngQ5Nx2T8UVV7jOpIREw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787132639; v=1; x=1787737439;
 b=GFcLilbZP+rONlknbNdr+XfvB3BeNDasBR20rjlzUOV2VsBvwPeAfgmGnNU9/JuEIZnj9kgd
 pxlPNBfNC7pqGMO9kxa3bx66SvV9J0L9I0OANhfzS29ulQ/TJxmgALJtMtJHxuTeIsZV12ORcDX
 zLvBtLv+7vVllqsl46x2fqTs=
X-Envelope-To: linux-block@vger.kernel.org
Received: from [192.168.68.106] (80.176.231.63)
	by mta12.migadu.com with ESMTPS id bf42fb00cf31c670;
	Wed, 19 Aug 2026 09:43:49 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <188916f8-45e2-434c-a466-376854c7fa4c@linux.dev>
Date: Wed, 19 Aug 2026 10:43:48 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] block: scan partitions for hidden disks
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 sagi@grimberg.me, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260818120854.3151628-1-john.g.garry@oracle.com>
 <20260818120854.3151628-2-john.g.garry@oracle.com>
 <20260819090050.GA9267@lst.de>
 <a967a7ef-02be-4dc4-9bc2-b11a242c7912@linux.dev>
 <20260819091350.GA10298@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260819091350.GA10298@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/26 10:13, Christoph Hellwig wrote:
> On Wed, Aug 19, 2026 at 10:12:50AM +0100, John Garry wrote:
>>> It also is used for giving a handle to NVMe devices that we can't support
>>> as block devices and for which we only want a handle to issue passthrough
>>> commands.  For those attempting a partition scan is rather suboptimal.
>>
>> We could set GENHD_FL_NO_PART in that case (as well as the hidden flag).
> 
> I guess we could do that.  It still feels wrong, though :

Maybe we just don't change the GENHD_FL_HIDDEN behavior. As long as 
/proc/diskstats and /proc/partitions don't show those per-path partitions.

It seems to me that we need to have a dedicated function to clone the 
partitions, and it would be called per NS after nvme_mpath_set_live() -> 
device_add_disk(). I am not sure if that works, though. We may get 
nvme_ns_head_submit_bio() looking up the per-path partition before they 
are available. In that case I would need to keep the path disabled until 
after the partition table is available.

> 
>>> As is in general doing an extra scan per controller when we know it must
>>> give the same results.  Wouldn't it make more sense to just propagate
>>> the partition table from the ns_head to each individual path?
>>
>> So you mean that we would have something which can clone the head gendisk
>> partitions onto the per-path gendisk by itering  >part_tbl and calling
>> something like blk_add_partition(), right?
> 
> Yes.

ok
