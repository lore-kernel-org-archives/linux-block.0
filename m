Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148046AA6B
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542144; cv=none; b=FUWS0wgYsnqfEhQwtrnPo5goNkLhvl+Pqw28aYaukn1Mu3g2oLt/kYmaA0lRR5neDfbL8QkcMEp1TuQCE8MXpISJOfLaDvZ8cos5mrZCDYAl9WOMsu/PmRu1XmlpGfFNsZveIryrS2z5Q9b0ZE3xc4vMrC15xPH3YvI3nJd4AtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542144; c=relaxed/simple;
	bh=wG5D40/Lu2nFYK2vM4/wbzyQ/E5JdLxxUYwVq3fVHcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSs1nSMKm9rkkLM/GiEbCXU70t+MMOrl8f/sIye+GKjj6A+ruAIGNZDBaOXRaA4lRB8X6bwkq/iiiHohSqTo4xmLMqDJIBiTNguuZ0JH637Dzwvz260T/b3Q6qMgS+Mg2Z68vMmJgJqsvx90TI+KsSmGL5p9V3TuH+RPDTDRl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Uo15toe0; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Uo15toe0"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VMZlFL3010079
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 19:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=KPIA
	GymP6/Pepnye/+rZrmO39/Nbpf2QPPAXtg/RPwQ=; b=Uo15toe0rPDAPWwZwVeJ
	n4E2aKPhzCtlbJaIPoOEk9oRKi29yWUd6bKSiKw2/UEDTT8IEoVnM0DWGZyllyTD
	40GpyfJ7ynehv56/EO+/jPUwA4CByxejxRy47r6xIde4zro2qbznQsk1f3dywHQu
	wWe/OeeuDrb/CAZQvA482658TGeu20X/PI6Kw1A+xglVLpQoL80+fmUhRsCQSdex
	hBfukncjUKNjTuWp4rZ1AdX9RDFeDZK1825QXT+td5WsnXaq10PJ+COGZwtnliH8
	5iqQ8kshUmIgCn4Ssedi1QZ6CFkegXN0zS0YJNWRRYNyK7IbH/AyMNUtzTFSMG47
	Gg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fry1ythjc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 19:55:41 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5276aa86d00so15908071cf.2
        for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 16:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542140; x=1786146940;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KPIAGymP6/Pepnye/+rZrmO39/Nbpf2QPPAXtg/RPwQ=;
        b=W9g3nJE44T3JzZ5T96cvSEm/HnxC0ReBBtiUEDuV8WRLq+CbidmANhDuPFxquuiRWH
         ia91G7L45Ijlyv0WGMpJOljf4U+5SjAAi1N1UEeFJb76YgDn7QZRYUV3czKZbCU+oqAG
         qx7E8G0aVbsfTzI+cz5wtJ90tarahTYq72FAvEtLYjPx3lOiugMQkBfJRw+60qkQOlYZ
         sG+wqzIWkMOVig2Wkq54movRG/79jA+hCw4RRnwKNSRzptRXsJNe+cxYfHmRNDILnR4z
         HlAHV+YXoo2dOS0xkbZl/DEGdqYNfJ5AD1LuP1jQmwMT7AwCaCNNg8IjwpSuiBpeV4n9
         daLg==
X-Forwarded-Encrypted: i=1; AHgh+RrW5FG9KbJ3ojH+uHJRmMKpFUFun/5DJyOJPrh42NsIU4EWwktMAxdb3NJmZOWC+a6qkBDjJIwpmBngqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn103WLR6EMKUjRuoPvnGquCHeowrqoG3VY5pTiQ9w3YxLmfhQ
	04/e4oGNqXYJ1u+wSC0WgA1VBSqCNAqd4F8mG1iQavEaxxbh58HLzl0KZ3qTy9GPN+2IfdCymWS
	Jq+NCrktHG6T7qu6x+En7YTeQoD4mZ2HGOFQnyAacBDUXiR2fq2C8UQWgVKpA
X-Gm-Gg: AR+sD10TMG01+gGOgkuu2nvu/kA9zKBjUtmQSzlLGmSvbR1HnA41BfNnbnHgaquaOqz
	tsP8dcepp2aN/SlkF0ped1/WuA7Yqd/fWY6Lf7mQUz8rfZUzTSoqg24Ctnw8y8ay5VOxeoYmRTn
	vwI4Iwj0m5ONy7XdBNzLAnPY2Z13/tafJwaR4iDqt2uzlSs0jXIHcpYUTmoVXp5uqLPA/GQlaDt
	47br6ECMC8p7IpSKOmlb4x0mKZOr5Oif95NayAZAnWkr74+J75TKwcB5e0vjU//H5acXb06ngHs
	HcHA8e/Wgx1DEwiKimDNArPw0ETtyjBMB3AvCUMbR2eIVpf78knngLTCQOXp6m2sxleFE5Zd3Lj
	VF0I/4P5SOBljVg==
X-Received: by 2002:a05:622a:2618:b0:51a:8f3a:13b9 with SMTP id d75a77b69052e-52b566b184dmr44464651cf.16.1785542140297;
        Fri, 31 Jul 2026 16:55:40 -0700 (PDT)
X-Received: by 2002:a05:622a:2618:b0:51a:8f3a:13b9 with SMTP id d75a77b69052e-52b566b184dmr44464271cf.16.1785542139795;
        Fri, 31 Jul 2026 16:55:39 -0700 (PDT)
Received: from [10.1.46.221] ([217.192.152.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm6127465e9.3.2026.07.31.16.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 16:55:38 -0700 (PDT)
Message-ID: <adf05cdf-0c73-4cf1-b1f7-9d063c891eaf@columbia.edu>
Date: Sat, 1 Aug 2026 01:55:36 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] block: enable RWF_DONTCACHE for block devices
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale
 <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Christoph Hellwig <hch@lst.de>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
 <20260730-blk-dontcache-v7-5-3e8e6850068d@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260730-blk-dontcache-v7-5-3e8e6850068d@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TY1zNM8gSd8XooQ243edYvSLTa_urzjp
X-Proofpoint-ORIG-GUID: TY1zNM8gSd8XooQ243edYvSLTa_urzjp
X-Authority-Analysis: v=2.4 cv=aObAb79m c=1 sm=1 tr=0 ts=6a6d35fd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=NgQitlhRlW+MZLNskBD3Jw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=c92rfblmAAAA:8 a=jDzJYAX_DjbP0Cb_QUIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE3NyBTYWx0ZWRfX8eOgN375MfN6
 bMBuL/kzEIYcUFa7+0B/vS9RsYtkunMXpYuklazIZX6pcY+jwC6+yGXY74TE02YgKP3oovoyB5J
 G6C6vKo4cuBPCSvi2QHHZ0+bKgZ6BCsKOZ0X7osT3LVsmrQggafi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE3NyBTYWx0ZWRfX9kMR2CiTvvVQ
 vUnaCFPZnI6UV+wjuevZaJ7XFOXzSbxC4pAd95PUDVszSqOMnYN1n43ujkI9swKEh+/lvJZmcmW
 DX/3sEYlRp+IUhNACfIHg6/9AmvEahSsOQM6EI9jd5Zv0WA33cCLgseaaCEz7/57H4/u0czHBDF
 t/Rs38cLL1vPUpbbjvrHXNdrOPnhYajBcoL9eG7Ag8xB577m9pi05B0KB0G9q51CEuqIgHsHOfh
 vBl0SDsySivFg9gbWkNnimpesiKi44tpJzx4UXxlt8oJxKkvDqhouWtYeyKD7NzaGN7srt5GNnP
 M6RFDMryca2MflvkxOhmBGnCdvBmv/h86mK9phe0JNywgrPLrsXTd0rmNT/9cZiZ8/7YxSmv+FS
 xN1yo19ZBMhQQDRZq+7NNZPtVXpbO2/4DI/eHTKjbnCIi13FldGv0h49Cc1sHd3w2/w/sVRs4Hi
 0kig1rrfMSK1ZZlteBQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11861
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 adultscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310177

On 7/30/26 2:57 AM, Tal Zussman wrote:
> Block device buffered reads and writes already pass through
> filemap_read() and iomap_file_buffered_write() respectively, both of
> which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
> by setting FOP_DONTCACHE in def_blk_fops.
> 
> For CONFIG_BUFFER_HEAD=y, writeback goes through buffer_head's
> __bh_submit() which sets BIO_COMPLETE_IN_TASK on dropbehind folios. For
> CONFIG_BUFFER_HEAD=n, writeback goes through iomap which handles it via
> BIO_COMPLETE_IN_TASK on the ioend bio.
> 
> This support is useful for databases that operate on raw block devices,
> among other userspace applications.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  block/fops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 15783a6180de..8b39c53b6393 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -941,7 +941,7 @@ const struct file_operations def_blk_fops = {
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= blkdev_fallocate,
>  	.uring_cmd	= blkdev_uring_cmd,
> -	.fop_flags	= FOP_BUFFER_RASYNC,
> +	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
>  };
>  
>  static __init int blkdev_init(void)
> 

It looks like Sashiko found a couple pre-existing issues in this file [1].
I've reproduced the first and looking into the second. Will send patches
once confirmed.

(FWIW the other issues Sashiko reported seem overblown.)

[1]: https://sashiko.dev/#/patchset/20260730-blk-dontcache-v7-0-3e8e6850068d%40columbia.edu?part=5
