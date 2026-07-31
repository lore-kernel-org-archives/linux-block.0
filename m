Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5B39DBF7
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484995; cv=none; b=LDab3NmMhdGzXACK8wrSa0SkNXbELO74XkxWMmX/GC0xBYl/sJqG/XUgnhI+TRPQGKbo+aT7LDrWP9EDEeavlzmiH/3tUcpsoSYmcgkKEpalkiO46t6DEBEaJ3jJCF0AjN5+EtHO1hYBUw7oOjavHJ8gwa3DJHpc/09GFdVi5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484995; c=relaxed/simple;
	bh=+PLsJymyDepIFqSdajbGlENI7KTuz6uA4fv8ik5VCn8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type:References; b=WR/GYE2yvpRuEvM8/dTE8QIPX9nBmHqHiDotTFsqBwnNLr3zkQZ1UpTM+Ztj9sqAwLm6T8ViESmO4mfqOV/v/xNKqPmv56duxxqzJXpfD5SJDmE7k6g4Xxz8Z7F3w1nr4S86BwwQBQGPdvmDefKmMdqH4iqo6HRqSMZXBM1KSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bpI1GzMS; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bpI1GzMS"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260731080310epoutp016402a7d557f932798e79e0ccdcefc69d~HUSOsjcZ61224712247epoutp01m
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 08:03:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260731080310epoutp016402a7d557f932798e79e0ccdcefc69d~HUSOsjcZ61224712247epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785484990;
	bh=gIGqoPkNWcLe5XP9GwkSBC+FobXWmh4FjS+CZoj4bGE=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=bpI1GzMSEdWt6NsJDtX0nR9ZeizQFtxGVHiqpcNbVCYVx/7WhFvNPPduY0KAPgAdL
	 rzYehS1iPQSjkSV4l+xs35GImipsmiOxNOsvIHPCCclB23EhVbL6GoBp4UQ+7PJsI5
	 aUe5SlOtT/QKTtOWNrsk0tGSchOyIXKCNGyKK2U0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260731080309epcas5p1d1998c712d72a87477ac9393256aabb3~HUSNWeAAz1669316693epcas5p1r;
	Fri, 31 Jul 2026 08:03:09 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.86]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4hBJTm3YN7z3hhTQ; Fri, 31 Jul
	2026 08:03:08 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260731080308epcas5p4bff37f97ead4d35834e8606f1cc483e9~HUSMCwKIl0618806188epcas5p44;
	Fri, 31 Jul 2026 08:03:08 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260731080306epsmtip140fc8faa05cd1bd04154650630830184~HUSKHLFYv2553725537epsmtip1S;
	Fri, 31 Jul 2026 08:03:05 +0000 (GMT)
Message-ID: <00f6099f-91ae-4685-951d-2ea0ee9a7b11@samsung.com>
Date: Fri, 31 Jul 2026 13:33:04 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 3/6] xfs: implement write-stream management support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, dgc@kernel.org, jack@suse.cz,
	cem@kernel.org, axboe@kernel.dk, kbusch@kernel.org, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj1072538@gmail.com>, Anuj Gupta <anuj20.g@samsung.com>
Content-Language: en-US
In-Reply-To: <20260721030810.GV7380@frogsfrogsfrogs>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260731080308epcas5p4bff37f97ead4d35834e8606f1cc483e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260717125633epcas5p3f433c8acd83824bb60828af4c5ab110c
References: <20260717125538.508925-1-joshi.k@samsung.com>
	<CGME20260717125633epcas5p3f433c8acd83824bb60828af4c5ab110c@epcas5p3.samsung.com>
	<20260717125538.508925-4-joshi.k@samsung.com>
	<20260721030810.GV7380@frogsfrogsfrogs>

On 7/21/2026 8:38 AM, Darrick J. Wong wrote:
>> Write streams, filestreams, and write-life-time hints are mutually exclusive;
>> combining any two of them returns -EINVAL:
>>    - GET_MAX reports 0 whenever xfs_inode_is_filestream() is true,
>>      covering both mount-wide filestreams and the per-inode chattr
>>      flag. Also when the file is on the realtime device.
>>    - SET refuses to bind a stream to a file that already has a
>>      write-life-time hint (fcntl F_SET_RW_HINT), is filestream, or is
>>      on the realtime device.
>>    - chattr refuses to set the filestream or realtime flag on a file
>>      that already has a write stream set.
> These special "files" that represent stream ids could be generic code
> instaed of in xfs.  AFAICT the only thing you need from xfs is a pointer
> from struct xfs_inode to struct (xfs_)write_stream, right?

Right. Is it fine if we come to it when everything else is settled.
I was hoping to lift common things up when write-stream is applied on 
another FS.
> 
>> Suggested-by: Christoph Hellwig<hch@lst.de>
>> Co-developed-by: Kanchan Joshi<joshi.k@samsung.com>
>> Signed-off-by: Anuj Gupta<anuj20.g@samsung.com>
>> Signed-off-by: Kanchan Joshi<joshi.k@samsung.com>
>> ---
>>   fs/xfs/xfs_icache.c |   1 +
>>   fs/xfs/xfs_inode.c  | 155 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/xfs/xfs_inode.h  |   8 +++
>>   fs/xfs/xfs_ioctl.c  |  69 ++++++++++++++++++++
>>   fs/xfs/xfs_iomap.c  |   1 +
>>   fs/xfs/xfs_mount.h  |   3 +
>>   fs/xfs/xfs_super.c  |  12 ++++
>>   7 files changed, 249 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
>> index 9d8dd30bd927..7b9dda74122f 100644
>> --- a/fs/xfs/xfs_icache.c
>> +++ b/fs/xfs/xfs_icache.c
>> @@ -129,6 +129,7 @@ xfs_inode_alloc(
>>   	spin_lock_init(&ip->i_ioend_lock);
>>   	ip->i_next_unlinked = NULLAGINO;
>>   	ip->i_prev_unlinked = 0;
>> +	ip->i_write_stream = 0;
>>   
>>   	return ip;
>>   }
>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> index 15279d22a894..aafc3ffa6e0a 100644
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -4,6 +4,7 @@
>>    * All Rights Reserved.
>>    */
>>   #include <linux/iversion.h>
>> +#include <linux/anon_inodes.h>
>>   
>>   #include "xfs_platform.h"
>>   #include "xfs_fs.h"
>> @@ -47,6 +48,160 @@
>>   
>>   struct kmem_cache *xfs_inode_cache;
>>   
>> +int
>> +xfs_inode_max_write_streams(
>> +	struct xfs_inode	*ip)
>> +{
>> +	struct block_device	*bdev;
>> +	bool			is_filestream, is_realtime;
>> +
>> +	xfs_ilock(ip, XFS_ILOCK_SHARED);
>> +	is_filestream = xfs_inode_is_filestream(ip);
>> +	is_realtime = XFS_IS_REALTIME_INODE(ip);
>> +	bdev = xfs_inode_buftarg(ip)->bt_bdev;
>> +	xfs_iunlock(ip, XFS_ILOCK_SHARED);
>> +
>> +	if (!bdev || is_filestream || is_realtime)
> Would be nice if realtime worked, or someone at least adds a comment
> about why it isn't (e.g. "we have something more exciting for rt/zoned
> filesystems") etc.

Will add, and that possibility is there.

Since each allocator (default,filestream, rt, zoned) has a different 
logical placement, a single write-hint based scheme does not fit all.

For non-zoned RT device: write-stream based physical placement can just 
work, it's mostly about lifting the checks that we have now. And adding 
logical placement (use write-stream to choose RTG similar to how we pick 
AG) is straight. But would you prefer that over default round-robin rotor?

For zoned RT device: two options
- Do nothing as write-hint based zone selection is already in place.
- Or publish N write-streams (corresponds to N isolation buckets over >N 
open zones), and use file's write-stream value for zone selction.

Current write-hint based scheme, based on xfs_zoned_hint_score[][] 
matrix, supports 4 isolation buckets. An application may need more, say 
6. And two such applications will require 12. Zoned-RT can care more 
isolation buckets, but write-hints don't allow to publish that.

Also, two unrelated applications that both pick WRITE_LIFE_SHORT bucket 
may land in the same zone. This goes back to FD based interface for 
write-steam.

Not having enough buckets, and having multi-tenant mixing - both can 
improved with the write-stream.
But I might be missing many zoned-xfs details; Maybe Christoph could 
weigh in?
