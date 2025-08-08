Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3DA26463B;
	Fri,  8 Aug 2025 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680352; cv=none; b=X/8G02ZyWvWeazzUTxdZDFIeh4Q4G4apXJGyO7IwI6ngNWzuwLZq3xjpU9+eXXQkBNkI6uBkP1qx4b2uQBJ6LDCWUXz+lApL5wLzQQdwQ7GR5YKOGK8eyQay9KZzjwuJsucd3DOqYp8wNAtvxvJsBvtZ62CQkoafJJl8r0UPGoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680352; c=relaxed/simple;
	bh=AuopC4jchsoBGwjeSawr7SKwoz70Y5DvaUCOAFpKArU=;
	h=Date:To:Subject:Cc:MIME-Version:Content-Type:Message-Id:From; b=W6l2wtbZh3IGstG+4i0CciPqPWUF0hCGZP6OxUphkMz5UJca+v5UpIJOHXgAgyYYTjl946Tv3QsMAT7NuAdtZ9yItIjwqg5E17SmXevUZgzZIHC6G0ah/x4QTcWk+0TXuCPBzpiYz85E9eoRmPYtA15CRXCScIzotNiwBM46IL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=o/ZN5vJI; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="o/ZN5vJI"
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578G2eKe009195;
	Fri, 8 Aug 2025 19:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=5gIYayUr0BtCcIvar4Jy0y0P
	rJEmZ99nwodw23zUavE=; b=o/ZN5vJIOxXVskxERb14QHQ+XKxLKN+tbBUkhNaP
	lLBHf2uKuUo2YEOapgYPq7WI4NVIUn3E4GkhT2t61hZgHwKA9qrFcCt7AeOo7nT/
	H920StRH6l4nu/yfx9oOj9h3oMtV0VICHoyghXWVhzr2Wi5FyHb/kXptGUcJaUr0
	+3rFjgQGX0i+YithMLqm8DmcMbdJuhcmpHsGtq9oDepCA1mCf5hsl98ih50A0Dhd
	wXj7x8AjWLVPqNYplGyJR/82SNjhqa3+0gBJka5t9PZ0c09bUIvEm1yfjwNqZhAc
	z/NEsKoCA2sBB5Rt000TmIZ6dGPugNhnIjZrXRHQagsbyw==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 48cxa85vsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 19:12:15 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 28B12800342;
	Fri,  8 Aug 2025 19:12:13 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id C66C58800130; Fri,  8 Aug 2025 19:03:24 +0000 (UTC)
Date: Fri, 08 Aug 2025 19:03:24 +0000
To: yukuai1@huaweicloud.com
Subject: Re: [PATCH 1/1] loop: sync filesystem cache before getting file size
 in get_size()
Cc: yukuai3@huawei.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
User-Agent: Heirloom mailx 12.5 7/5/10
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20250808190324.C66C58800130@test-build-fcntl.hpe.com>
From: Cloud User <rajeevm@hpe.com>
X-Proofpoint-ORIG-GUID: uYUQEmc05IA664PfeKGAahhuogg87Ke3
X-Proofpoint-GUID: uYUQEmc05IA664PfeKGAahhuogg87Ke3
X-Authority-Analysis: v=2.4 cv=RZ+QC0tv c=1 sm=1 tr=0 ts=68964c0f cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=AiHppB-aAAAA:8 a=MvuuwTCpAAAA:8
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=ZV1I0oPp85mWpSob3hMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE1NiBTYWx0ZWRfX+igXJsjpFP/A
 48KimB85cnoC00cQkqAY34yNpcegQ4Z99Q5bAc2MblZkCBCDlVSAE813DKCqB6hj5T2BxYRcnB8
 ms6AhRdYW2HU9lz3iT+8Amym4nNEcSVqq6kIH0XbNqpcgwrDi2olK2FXXKPjekIFeMpt20dtQYT
 pp+C2VmNjYnsEw7JvWBGCRYLZsjaQIzlbNDlulQvM4My0aIsU0YN2d8WhPf+Yoj3rSv+9iUCCaw
 a/uOefNl8uyZAKyIebwdQqrWpNJZm8rrVx+SeznX25dXztV+oM5L3oGgaAdMioT/jO/VmqDq3Ad
 B02U6kQZ3TSWHaWj9dfkd6VQPvmIG2baT7+B1/5Ks9dzQkd2Bn/Ely+8GHSYqdd6YeLOBF7M8ut
 qMSHR7YMC9FErpdBxql6z5jg3JzWZglzPe1DF+4INTmWUkPsYbWbVPrz8TkFTz40hsyWDl0H
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080156

Thanks, Kuai, for the quick review—I really appreciate it.
Please feel free to reach out if you have any questions or
if I missed addressing anything.

My responses to your queries are included inline below.
Rajeev
 
From: Yu Kuai <yukuai1@huaweicloud.com>
Date: Thursday, August 7, 2025 at 9:48 PM
To: Mishra, Rajeev <rajeevm@hpe.com>, axboe@kernel.dk <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, yukuai (C) <yukuai3@huawei.com>
Subject: Re: [PATCH 1/1] loop: sync filesystem cache before getting file size in get_size()

Hi,

在 2025/08/08 7:25, Rajeev Mishra 写道:
> The get_size() function now uses vfs_getattr_nosec() with AT_STATX_SYNC_AS_STAT

With a quick code review, I didn't found how can that flag ensure
filesystem cache is synchronized, can you explain in detail? Or Do you
mean getattr for filesystem like fuse to get latest data from server?

Response ---

>> Thanks for the quick review. The AT_STATX_SYNC_AS_STAT flag tells

>>the VFS layer to synchronize cached metadata before returning file attributes.

>>This is particularly important for distributed/network filesystems where

>>the local cache may not reflect the current file size on the server.

---

> to ensure filesystem cache is synchronized before retrieving file size. This
> provides more accurate size information, especially when:
>
> - The backing file size has been changed by another process
> - The file is on a network filesystem (NFS, CIFS, etc.)
> - The file is being modified concurrently

I don't think this make sense in real world. If a file is already used
by loop device, then user should avoid modifying this file directly. For
a file in fuse, I feel it's not good to use it as loop device.

Response---

>>I encountered this issue specifically with Lustre filesystem during testing
>> I did following --

>>1. File was created on Lustre

>>2. dd was done to write data on the file

>>3. ls confirmed the size

>>4. Loop device setup was done on the file immediately

>>5. write was issued with less space

>>6.above happened as file size was not correctly captured by loop device

>>I agree that network/distributed filesystems aren't ideal for loop devices,

>>but they are used in practice (container images on shared storage, diskless

>>systems, etc.). The fallback to i_size_read() ensures no performance penalty

>>for local filesystems while improving reliability for network filesystems.

____


> - The most accurate size is needed for loop device setup
> > The implementation gracefully falls back to i_size_read() if
vfs_getattr_nosec()
> fails, maintaining backward compatibility.

Response –

___

>>> you mean using the flag sync has backward compatibility issue ? or using function itself ?

___


>>
> Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
> ---
>   drivers/block/loop.c | 31 +++++++++++++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1b6ee91f8eb9..15d5edbc69ce 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -137,12 +137,39 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
>   static int max_part;
>   static int part_shift;
>  
> +/**
> + * get_size - calculate the effective size of a loop device
> + * @offset: offset into the backing file
> + * @sizelimit: user-specified size limit
> + * @file: the backing file
> + *
> + * Calculate the effective size of the loop device
> + *
> + * Returns: size in 512-byte sectors, or 0 if invalid
> + */
>   static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
>   {
> +     struct kstat stat;
>        loff_t loopsize;
> +     int ret;
> +
> +     /*
> +      * Get file attributes for validation. We use vfs_getattr() to ensure
> +      * we have up-to-date file size information.
> +      */
> +     ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE,
> +                             AT_STATX_SYNC_AS_STAT);
> +     if (ret) {
> +             /*
> +              * If we can't get attributes, fall back to i_size_read()
> +              * which should work for most cases.
> +              */
> +             loopsize = i_size_read(file->f_mapping->host);
> +     } else {
> +             /* Use the size from getattr for consistency */
> +             loopsize = stat.size;
> +     }

I'm ok switch from i_size_read() to getattr, however, the commit message
is confusing for me :(


Response --
>> I will make the commit message clear and simple. Just wanted to understand

>> if using this will be good “vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);”

>> is good I will replace i_size_read() with above code

>> do let me know if this will have any backward compatibility issue

>>Thanks again for your help

 


Thanks,
Kuai
>  
> -     /* Compute loopsize in bytes */
> -     loopsize = i_size_read(file->f_mapping->host);
>        if (offset > 0)
>                loopsize -= offset;
>        /* offset is beyond i_size, weird but possible */
>
