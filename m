Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453F33345B;
	Fri, 31 Oct 2025 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904464; cv=none; b=lcPM21gTYc+KU3lOoISEmjTbAFcjCTs9EHhW81PLxSEwwPhd0ANlhatMd/S8WcIsrn87SPldYRZZR77ipHWVtP29s3jbF9Iv6X3cqOTYCakxONNKc2WwC1uNJ5Fa6cPpj8SvOywEQce7TPJFfEPHpjQSHU119Lfm0otwehi4R4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904464; c=relaxed/simple;
	bh=Qs4ggnpyC8OpSAy9Yb0bJBsNO13Eq7G/g14GI+pEqSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkEMKubS9DIh68V7/wtXv78wXf52LGRimK85YqmoufJML+zGG8uKvliy/elNWyZlXDAZnkRdEyvfac64FXFaudJKcpjch0rcsap9QrntKRUs6wjZKoisG6qPOrqpt47B5kql3NS7g1N7SrMHpeoYTC5mttxRxA3YV2IFi4S1pQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HnV2yq7M; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HnV2yq7M"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761904452; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V6KM2FGZe0yUHDU7WK2IN28Yp5FlE7rIbHcELeToGpw=;
	b=HnV2yq7MxaTKvRIgjGFBWt18PHFF/TTrCgCXVNBs6c6M9BNji76zzuWJbrfAOyWs94rKMZCQHzrjmzoeNwGLd46XK4kbk8YezEXhkwHmV7GpHdr6JY+qXvAkv5VAMS6lE/HgPdY/gjr2PXQqAuwK0XTnElLRnHKAgh4n+ncyVDw=
Received: from 30.221.132.210(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrOUk-u_1761904451 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Oct 2025 17:54:12 +0800
Message-ID: <7d0d8480-13a2-449f-a46d-d9b164d44089@linux.alibaba.com>
Date: Fri, 31 Oct 2025 17:54:10 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: question about bd_inode hashing against device_add() // Re:
 [PATCH 03/11] block: call bdev_add later in device_add_disk
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>, guanghuifeng@linux.alibaba.com,
 zongyong.wzy@alibaba-inc.com, zyfjeff@linux.alibaba.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-4-hch@lst.de>
 <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com>
 <20251031090925.GA9379@lst.de>
 <ae38c5dc-da90-4fb3-bb72-61b66ab5a0d2@linux.alibaba.com>
 <20251031094552.GA10011@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251031094552.GA10011@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/31 17:45, Christoph Hellwig wrote:
> On Fri, Oct 31, 2025 at 05:36:45PM +0800, Gao Xiang wrote:
>> Right, sorry yes, disk_uevent(KOBJ_ADD) is in the end.
>>
>>>   Do you see that earlier, or do you have
>>> code busy polling for a node?
>>
>> Personally I think it will break many userspace programs
>> (although I also don't think it's a correct expectation.)
> 
> We've had this behavior for a few years, and this is the first report
> I've seen.
> 
>> After recheck internally, the userspace program logic is:
>>    - stat /dev/vdX;
>>    - if exists, mount directly;
>>    - if non-exists, listen uevent disk_add instead.
>>
>> Previously, for devtmpfs blkdev files, such stat/mount
>> assumption is always valid.
> 
> That assumption doesn't seem wrong.

;-) I was thought UNIX mknod doesn't imply the device is
ready or valid in any case (but dev files in devtmpfs
might be an exception but I didn't find some formal words)...
so uevent is clearly a right way, but..

> But why does the device node
> get created earlier?  My assumption was that it would only be
> created by the KOBJ_ADD uevent.  Adding the device model maintainers
> as my little dig through the core drivers/base/ code doesn't find
> anything to the contrary, but maybe I don't fully understand it.

AFAIK, device_add() is used to trigger devtmpfs file
creation, and it can be observed if frequently
hotpluging device in the VM and mount.  Currently
I don't have time slot to build an easy reproducer,
but I think it's a real issue anyway.

Thanks,
Gao Xiang

