Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7722429025
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130778; cv=none; b=MCinCiE8OD9oLe4vYPlltTTUaoHwri2axB9IQhjR1VmSNfjapvn8oa4SUIehNPtDz+hMXxYI694z7eS7C52yMX4O2j1UVM9wNOXVzvueBin32AmeT2Hc6mmgzvJCQz0OUJfd9lf9+vYzwROXtSQRigc/DUmUSX167/jDeiU/dZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130778; c=relaxed/simple;
	bh=gOjdiylxj3dI6IB0RjlmP4RldcoL9z4Tuq7n9c7WLzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Td4FZSRG1shH27UBntj508587v2dtdOr7shAFb5JgtAnNJuQi0/cfzRMKV8jwCKqtcBe+AlpwdIjRw8fKvsc8bhqJRnN0ImoBHPITDCeMfUl8rLv205fIkEhymIGHGZIVrdBTbYlTZ1Oe765tcEMCNHlxhjzq5dPpzhA7D4qvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rECOOIVN; arc=none smtp.client-ip=91.218.175.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rECOOIVN"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gOjdiylxj3dI6IB0RjlmP4RldcoL9z4Tuq7n9c7WLzE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787130770; v=1; x=1787735570;
 b=rECOOIVN4Z6feZp4ZBhhdJVwPqT4amqW2Vr33U3a6hPW4KocmxUy6aRZRiV/j3HNMfQgPLVi
 Qk0bJoo8yNH8fQeDBa+73KpiL+PvmQpuRwwIi0dgqvN/cRjjna+U2KrXjdjn74S6/vxzwRToNqu
 m5Zwe8HoKuqGfhbXM6UGNawo=
X-Envelope-To: linux-block@vger.kernel.org
Received: from [192.168.68.106] (80.176.231.63)
	by mta12.migadu.com with ESMTPS id 6310ff676a0e951b;
	Wed, 19 Aug 2026 09:12:50 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <a967a7ef-02be-4dc4-9bc2-b11a242c7912@linux.dev>
Date: Wed, 19 Aug 2026 10:12:50 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] block: scan partitions for hidden disks
To: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260818120854.3151628-1-john.g.garry@oracle.com>
 <20260818120854.3151628-2-john.g.garry@oracle.com>
 <20260819090050.GA9267@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260819090050.GA9267@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/26 10:00, Christoph Hellwig wrote:
> On Tue, Aug 18, 2026 at 12:08:53PM +0000, John Garry wrote:
>> From: John Garry<john.garry@linux.dev>
>>
>> If a disk is hidden (GENHD_FL_HIDDEN flags set), we currently do not scan
>> the disk partition table.
>>
>> GENHD_FL_HIDDEN is used in NVMe multipath support to hide the per-path
>> disk.
> It also is used for giving a handle to NVMe devices that we can't support
> as block devices and for which we only want a handle to issue passthrough
> commands.  For those attempting a partition scan is rather suboptimal.

We could set GENHD_FL_NO_PART in that case (as well as the hidden flag).

> 
> As is in general doing an extra scan per controller when we know it must
> give the same results.  Wouldn't it make more sense to just propagate
> the partition table from the ns_head to each individual path?

So you mean that we would have something which can clone the head 
gendisk partitions onto the per-path gendisk by itering  >part_tbl and 
calling something like blk_add_partition(), right?
