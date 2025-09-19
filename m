Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7A2F83BA
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276776; cv=none; b=nzxXpJSrna3XlYXrstQsyFLd03eGRrJtcO9AmC6/SunTou0bmvgDbhdKU13aIniCPjKyfHJ1sy7fF1kyipZndjHvRlpWfYh+p/wahRfaCrIj7QgEVrnvXWQmR7LMNLVukADSG04v2oOn904Fj4Hud6gYCGGkH8D5m+6tPboCvmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276776; c=relaxed/simple;
	bh=qcvu0aO6LRpErMguLBYWwo+jauUJu91JyQkoIjpkWRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Nv5VwEcHu8xV4GwEzdzqFJwTt2GBKxuqwVhvK5f3lyPMJqB1KpLsNg2WIEzWcmjPyvlWTrKgeHn5yFdJom79lxvOQC6NTUWZicVQSv9RcpuHR0t+F4tS/HGAcMTjDVcIAvA5BBtABlS+QezJIaB0Td0KPZI+URfP+n2Dh2OxNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RsU6mOoh; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RsU6mOoh"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250919101246epoutp04c612a748e5736c74255dcd51febac505~mp2cxsja73047830478epoutp04M
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 10:12:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250919101246epoutp04c612a748e5736c74255dcd51febac505~mp2cxsja73047830478epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758276766;
	bh=eeX78Yt3/Bxv7pKXNw3EaTPipK1XEg7HWlWrPSBMjtE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=RsU6mOohLqbIkXPf5HFtY24B+sAK/qk8Txaa0DGwu4UvoIpGdMpuLLehVG6dDsMuS
	 rYB4wF7fO9CsbaxYoh7l3M4rqli3O9qxqm3sssx0ZOe+IkHEWtpc8fd+Wsk3Pb9pKm
	 noqCfhQn1iEfBlpEwayHyOMqMZUanFsUJJdS9WkU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250919101245epcas5p212495c0ce3fef4358ce8863661b53cad~mp2cZ7IfG0305303053epcas5p2G;
	Fri, 19 Sep 2025 10:12:45 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cSpGh62Wrz6B9m5; Fri, 19 Sep
	2025 10:12:44 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250919101244epcas5p15b3e52542634660f1482f1ec453ce798~mp2bDgRUM0162701627epcas5p1z;
	Fri, 19 Sep 2025 10:12:44 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250919101242epsmtip2c23b11aac1fcf4b19b2edaabe97ff83e~mp2ZuW5Me2867028670epsmtip2N;
	Fri, 19 Sep 2025 10:12:42 +0000 (GMT)
Message-ID: <efe392a5-0634-4774-9db3-b10ae2bd9cf8@samsung.com>
Date: Fri, 19 Sep 2025 15:42:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests v1] block: add test for io_uring Protection
 Information (PI) interface using FS_IOC_GETLBMD_CAP
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
	"anuj1072538@gmail.com" <anuj1072538@gmail.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hch@infradead.org" <hch@infradead.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>, "gost.dev@samsung.com"
	<gost.dev@samsung.com>
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <odm6y33y4fhk3tqtxtnldvqmw4l37mbuhztauofsttj4y5i7dt@a5wogxejzpki>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250919101244epcas5p15b3e52542634660f1482f1ec453ce798
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250805061730epcas5p4ae7a8eda6d1d11cc90317a80738eb2ea
References: <CGME20250805061730epcas5p4ae7a8eda6d1d11cc90317a80738eb2ea@epcas5p4.samsung.com>
	<20250805061655.65690-1-anuj20.g@samsung.com>
	<v23bumua6pdez2kizqihersvyp4c5i6d5mecagtddwl426aaec@wfnq7zumao5n>
	<c1d4d4b6-ef17-4726-bfbc-0ac1cd04c1ed@samsung.com>
	<odm6y33y4fhk3tqtxtnldvqmw4l37mbuhztauofsttj4y5i7dt@a5wogxejzpki>

> The errors were as follows:
> 
> block/041 => nvme1n1 (io_uring read with PI metadata buffer on block device) [failed]
>      runtime    ...  0.354s
>      --- tests/block/041.out     2025-08-13 19:56:15.487074413 +0900
>      +++ /home/shin/Blktests/blktests/results/nvme1n1/block/041.out.bad  2025-08-13 20:06:23.199291948 +0900
>      @@ -1,2 +1,12 @@
>       Running block/041
>      +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte or wide character: read offset=12288, buflen=4096
>      +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte or wide character: read offset=688128, buflen=4096
>      +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte or wide character: read offset=630784, buflen=4096
>      +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte or wide character: read offset=905216, buflen=4096
>      +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte or wide character: read offset=233472, buflen=4096
>      +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte or wide character: read offset=540672, buflen=4096
>      ...
>      (Run 'diff -u tests/block/041.out /home/shin/Blktests/blktests/results/nvme1n1/block/041.out.bad' to see the entire diff)
> 
>>
>> The issue occurs because setting ms and pi in the QEMU command line is
>> not enough, the namespace still needs to be formatted. Could you please
>> run the test again after running the nvme format command on device with
>> the desired LBA format (PI enabled).
> 
> Ah, thanks. I ran "nvme format -i 1 /dev/nvme0n1" for the QEMU NVME device
> prepared with QEMU NVME option "ms=8,pi=1", then the test case passes. The
> test case looks working as expected :)

Hi Shinichiro,

Thanks a lot for your detailed review comments. Sorry for the delay in 
re-spinning - I had a few conflicting deadlines.
I have addressed your feedback and sent out a v2 here:
https://lore.kernel.org/linux-block/20250919101028.14245-1-anuj20.g@samsung.com/

Thanks,
Anuj Gupta

