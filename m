Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABCA29B795;
	Tue, 25 Nov 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069268; cv=none; b=bn0MCpxfdtDE0Cq7aIIkp2Zf7GONfB860ka6wexVy9qdIplt3aQsLfokN4Z0XA41vaemz3+GQC0zF0Za4YPx4uBBTMRBvWAIH9I8uS6couBup7WZNBFj7Do6wX4M2f/jA2vTXtOK6HRM0XlNI2o3fRuKxPyaW0/1FcUyB6vvoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069268; c=relaxed/simple;
	bh=qbUUhkHMMS6TzCWYjcxYyy4qDl0GXU1qI+8Zc1eZChQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEY+8AhHWSYFcTgfy/lqlYJziGFB8eGWUbz0Vy03wI7shoBRqkVnG2kmCRMxYf+9eZGmKg8WPaD8LMGIsJMns/dWIwQVRDwSdj4Km6XDcOYMANGuU5P/nbe9l2qew3qmj2qdXEkoHN8CcGfvXiEPV3iaD14+W9ijgAh/BOnjIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Apw6PckY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Apw6PckY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5APAbBGs021895;
	Tue, 25 Nov 2025 11:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iTzCQ0
	JY9WXcpFe0GcHNAFxfP6m3HtlAT1T4iO9Gfcc=; b=Apw6PckY3rnC5B0WdNF3QA
	/ptC56UYvJSOj5XRkR6SmKG+NhyZ3OViL2gm3tI/Igdcws3g9lZM0CFHvD9/Bozh
	jMsiS3CvQw/b19mvM+89kLAOi0mZsDkF3qfwTu1rSehCpZlp4+Iq5Mm3Hs2asvgc
	YUMia3aBaZ+p8cMqXR2MhXVK7Ajz4g6IZwJu8rpLxTYLV2IEw/yHYsFqqd7ZGrEq
	DcmnAxEW5/Pa4LJKyjq00ZALFDDg/XJWdbq4BCwLm+3cfizkpb+gUvr2Fb8lrnQD
	CiFH4RaE1AWYbNe/p2Zt8NuBkBZ/z1p+K1ILPSO5JKNxRH3mp4ABZu7px+72z/Rg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kjvg64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:13:38 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5APB8fNn004514;
	Tue, 25 Nov 2025 11:13:37 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kjvg60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:13:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5APAkiV9025097;
	Tue, 25 Nov 2025 11:13:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71b152-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:13:36 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5APBDaAK26870436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 11:13:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05DD958055;
	Tue, 25 Nov 2025 11:13:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7258158066;
	Tue, 25 Nov 2025 11:13:27 +0000 (GMT)
Received: from [9.109.198.169] (unknown [9.109.198.169])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Nov 2025 11:13:27 +0000 (GMT)
Message-ID: <0caa9d00-3f69-4ade-b93b-eea307fe6f72@linux.ibm.com>
Date: Tue, 25 Nov 2025 16:43:25 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "hare@suse.de" <hare@suse.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "dlemoal@kernel.org"
 <dlemoal@kernel.org>,
        "wagi@kernel.org" <wagi@kernel.org>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "xni@redhat.com"
 <xni@redhat.com>,
        "linan122@huawei.com" <linan122@huawei.com>,
        "bmarzins@redhat.com" <bmarzins@redhat.com>,
        "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "kuniyu@google.com" <kuniyu@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org"
 <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20251125061142.18094-1-ckulkarnilinux@gmail.com>
 <aSVMXYCiEGpETx-X@infradead.org>
 <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vkxy-U0qUoUhomun77kqQwsiNtCzPsru
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=69258f62 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BI5xwJ-P1ppPWS6GoS0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tBWR1YSg00FE8aDfNrJdzyEipIN7sKvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX9xZSQ1PTRjtO
 ic95MvoVhO6juL1TXjxsTkTU+27vS6PN7JrpUzce+o2uteOlicsg9mOwFZPDu6ZiAUWWVwdYG37
 3N+QHBbeIz9GL4UAe/R6AFyPXSACa70XLN0/x7rBj+uoNMc/lkvQAG0Xho1x9cpMbWUwY3aunc0
 L01MPVGLCzQhbdl5eBDtkntGRnOJPUuFw68/rVph+7KecViWhPuebCI1EZgKtxxS7X7/DLW6eiq
 5Iqu4UC7Tnz4lj5nEPbxNGxpcnBQpJdkwG7aJmC5JqvfIHrJUkFa2H1DOX7kyUEmAwEX8HXz7m/
 duvITe/zSGq8RYgSuu8LMBqlM/9X/A62I7XmT+iJGmtw7qZhK1NZSYHK8GCJz+Rc4eXdgbbIIck
 BXhDs3PdPVN2HjJD4c9F+wkWcc9N/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008



On 11/25/25 12:58 PM, Chaitanya Kulkarni wrote:
> On 11/24/25 22:27, Christoph Hellwig wrote:
>> I don't think GFP_ATOMIC is right here, you want GFP_NOIO.
>>
>> And just use the scope API so that you don't have to pass a gfp_t
>> several layers down.
>>
>>
> are you saying something like this ?
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 29ad4735fac6..56d0a3777a4d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1438,17 +1438,28 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>   	unsigned int noreclaim_flag;
> +	unsigned int noio_flag;
>   
>   	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>   		return;
>   
>   	page_frag_cache_drain(&queue->pf_cache);
>   
> +	/**
> +	 * Prevent memory reclaim from triggering block I/O during socket
> +	 * teardown. The socket release path fput -> tcp_close ->
> +	 * tcp_disconnect -> tcp_send_active_reset may allocate memory, and
> +	 * allowing reclaim to issue I/O could deadlock if we're being called
> +	 * from block device teardown (e.g., del_gendisk -> elevator cleanup)
> +	 * which holds locks that the I/O completion path needs.
> +	 */
> +	noio_flag = memalloc_noio_save();
>   	noreclaim_flag = memalloc_noreclaim_save();
>   	/* ->sock will be released by fput() */
>   	fput(queue->sock->file);
>   	queue->sock = NULL;
>   	memalloc_noreclaim_restore(noreclaim_flag);
> +	memalloc_noio_restore(noio_flag);
>   
>   	kfree(queue->pdu);
>   	mutex_destroy(&queue->send_mutex);

The memalloc_noreclaim_save() above shall already prevent filesystem reclaim,
so if the goal is to avoid fs_reclaim, we should not need an additional
memalloc_noio_save() here. That makes me wonder whether we are looking at the
correct code path. If this teardown path (nvme_tcp_free_queue()) is indeed executed,
it should already be avoiding filesystem reclaim in the first place.

Thanks,
--Nilay
