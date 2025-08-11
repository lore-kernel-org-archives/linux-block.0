Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1BC13B
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928710; cv=none; b=QbHcJTIaFgRjbwVJfMCRJPqQM6oeO2KeoP37zBfJZY/m/36yXa70G6N4a4XI3id5RFv6Q8ndMZ0L8/C6i/CbGJm651QJ4MwP4DvIPIFBhO+OZd60KQBEY+WEb/i8/Sxx7hc4hxVwGTyswulOEJdV5QrtsPHDC7lCyl3RuIgeq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928710; c=relaxed/simple;
	bh=461NNFqYW8vODRa0XMCntP+Ns1i3I4ZKfkLc857RMH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ij/D5Q7uiLRlfHZxUKTmqsTwzIBOO5WN3AVFTHRViIn/2UXkkpH6fKgpb49jXqe24d7HFXG+NPnyNEXBr+Nk8am7LGx4ZyqyGkyUUVzeWgzdfdyXjGkwo8aEu+7e8QwS64mqJM7Jf9wk2pkwWI15C7L22r8Ao0X7+pngACINMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=p0JGKHXI; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p0JGKHXI"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250811160141epoutp016c2fd3f4f7a3ea3cdf7f6522ae945ace~awc97U1MY1655416554epoutp01V
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 16:01:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250811160141epoutp016c2fd3f4f7a3ea3cdf7f6522ae945ace~awc97U1MY1655416554epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754928101;
	bh=siDTiZ6gWv1WxIEz0y8F28ABhtxOu/ZHxQzHFfxxSQw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=p0JGKHXIoRK9Jo5nqWQGCZ2V+3tdSJ7qEH3oFtgKM5PGO/8xEmLigUsxbEEj7oRpM
	 RL0ZqmGhyuf6ILnNN+wwX49QKqqUl6FniwSGPYKRxQmw6bDIBagJ6IEbxchYu9JHGv
	 oaCk03xUFL+UvMuAhtE8FC3v46vGwPdEviPYdnNc=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250811160141epcas5p340f005116258fb45253e6137cbc0368e~awc9gfiao0546305463epcas5p3i;
	Mon, 11 Aug 2025 16:01:41 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.86]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c0zsJ23Mnz6B9m5; Mon, 11 Aug
	2025 16:01:40 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250811110308epcas5p22aed87bfd44b4efbe5714e7b9da42924~asYTaD7su1955319553epcas5p2E;
	Mon, 11 Aug 2025 11:03:08 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811110307epsmtip14f77183b7991d75fbef00a41a527ebc0~asYSODvPG1637416374epsmtip1o;
	Mon, 11 Aug 2025 11:03:07 +0000 (GMT)
Message-ID: <c1d4d4b6-ef17-4726-bfbc-0ac1cd04c1ed@samsung.com>
Date: Mon, 11 Aug 2025 16:33:03 +0530
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
In-Reply-To: <v23bumua6pdez2kizqihersvyp4c5i6d5mecagtddwl426aaec@wfnq7zumao5n>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250811110308epcas5p22aed87bfd44b4efbe5714e7b9da42924
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250805061730epcas5p4ae7a8eda6d1d11cc90317a80738eb2ea
References: <CGME20250805061730epcas5p4ae7a8eda6d1d11cc90317a80738eb2ea@epcas5p4.samsung.com>
	<20250805061655.65690-1-anuj20.g@samsung.com>
	<v23bumua6pdez2kizqihersvyp4c5i6d5mecagtddwl426aaec@wfnq7zumao5n>

On 8/8/2025 5:10 PM, Shinichiro Kawasaki wrote:
> On Aug 05, 2025 / 11:46, Anuj Gupta wrote:
>> This test verifies end-to-end support for integrity metadata via the
>> io-uring interface. It uses the FS_IOC_GETLBMD_CAP ioctl to query the
>> logical block metadata capabilities of the device. These values are then
>> passed to fio using the md_per_io_size option.
>>
>> io_uring PI interface: https://lore.kernel.org/all/20241128112240.8867-1-anuj20.g@samsung.com/
>> fio support for interface: https://lore.kernel.org/all/20250725175808.2632-2-vincent.fu@samsung.com/
>> ioctl: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.17.integrity
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> 
> Anuj, thank you for the patch.
> 
> I wonder which test group this test case should go into, block or nvme. IIUC,
> this test case runs only for nvme devices. Said that, block group looks good for
> me since the test target ioctl interface belongs to the block layer.
> 
> I tried to run the test case using QEMU NVME emulation devices with some
> ms=X,pi=Y options, but the test runs failed. The kernel reported a number of
> "protection error"s. Can we run the test case with QEMU NVME emulation device?
> If so, could you share the recommended set up of the device?

Could you please share/paste the errors that you encountered?

The issue occurs because setting ms and pi in the QEMU command line is
not enough, the namespace still needs to be formatted. Could you please
run the test again after running the nvme format command on device with 
the desired LBA format (PI enabled).

Thanks,
Anuj




