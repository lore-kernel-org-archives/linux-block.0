Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A917BC2
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127803; cv=none; b=Xe5b5TpYZrNHR6UW+gt/xzzrPAWnzW8J0s/7WecKG7xSr7gZIZb/jnKhM6XXyTAaKRw7AdtUGa9CtZKs3DMagp1FTI+BQLWAX7A4gUgNp5UcPZuoysueiYa9XWLNlfdFN9xC6hbQibwBPVPCxXczoxsIUcLTmZvjYUHxM9gy2U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127803; c=relaxed/simple;
	bh=YBylnFIrRYTYF2c6lCVlnmZSgPH3NUn+uUMcAmwRAVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5UCGlhYYigfIhHSM6beBjv2JqhGCCPsTjWdxYPP7idJeEFpudj+Q61GKstbOYlPCSHwuW5IJ9JET6UmD9QMMlNBAxeoCXckZduyvV0+fgMkiDDFs/BDQ/vOVt+2QjOGWhllqCy0KIy9moxxNcPjjC94uTFNuV45V//CvjnFB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZZqenvK2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZZqenvK2"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43370Rvp016397;
	Wed, 3 Apr 2024 07:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hQZxVUExsv+856nPD5Ou3ZQ1TBRAOMCLVmmsu+x3CWY=;
 b=ZZqenvK2ICo/6xRVSFpfnIZzte/h2duLCl+bBu7FFWBHquP/YRB1zOB0qxSto2K3o+YU
 Fvczg/bMcskjjC3UH1rzqfdkKyCRwo010xkLE4WBfOGti+Ooltuiosq/70xcBQ65MSdC
 soTJkNqihs/J8F6436w8eycCuvLc9z2H7J//gQudHxcjEN/8akTGx/7hRCEGhzVHSNwG
 UC1pklXxOA7g4wI7KdfqgXHVmgkA99U0hhojHJ73mBt4NqYQFbvC+h1Ge3DL7jkgUGD+
 2V9FizGO+PgHFvF0Fl9qulHcjXoq2C17lUpjkBSkLe8X7Aw7dhN/oM4Q2PvKMwFLBWSD mQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x927m00nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 07:03:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4334YXOO027151;
	Wed, 3 Apr 2024 07:03:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6wf0bxb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 07:03:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4337389C16122524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 07:03:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85B1558078;
	Wed,  3 Apr 2024 07:03:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 783C95807A;
	Wed,  3 Apr 2024 07:03:06 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 07:03:06 +0000 (GMT)
Message-ID: <ff149ec9-9664-4d72-bbe5-1db2520df33b@linux.ibm.com>
Date: Wed, 3 Apr 2024 12:33:05 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node and
 print error
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@fb.com,
        Gregory Joyce <gjoyce@ibm.com>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
 <20240402150446.GB1916@lst.de>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240402150446.GB1916@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: scVKc_ct3q5yfhkq6_EyU8j4pav3UnDH
X-Proofpoint-ORIG-GUID: scVKc_ct3q5yfhkq6_EyU8j4pav3UnDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030047


Hi Christoph,

On 4/2/24 20:34, Christoph Hellwig wrote:
> Hi Nilay,
> 
> can you see if this patch makes a different for your weird controller
> with the listed but zero capacity namespaces?
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3b0498f320e6b9..ad60cf5581a419 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2089,7 +2089,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  	if (id->ncap == 0) {
>  		/* namespace not allocated or attached */
>  		info->is_removed = true;
> -		ret = -ENODEV;
> +		ret = -ENXIO;
>  		goto out;
>  	}
>  	lbaf = nvme_lbaf_index(id->flbas);
> 
I have just tested the above patch on my controller which has zero 
capacity namespaces. The patch works as expected and I don't encounter
any errors while using nvme-cli commands. Please note that I am using 
here the old version of nvme-cli (nvme version 2.6 / libnvme version 1.6).

Furthermore, with this patch, I no longer find any hidden disk nodes 
(i.e. nvmeXcYnZ or nvmeXnY) created for namespaces with zero capacity 
under /sys/block. So the behavior is similar to that of kernel v6.8.

IMO, we should upstream this patch.

Thanks,
--Nilay


 
