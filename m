Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1627EC7C;
	Mon, 17 Nov 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374281; cv=none; b=UhL7FYtpwhyZWwVivuowONukV5oMjvNpqZ37fC8Z1JupqdEisgyQfvrSakrZA82ZqzdyFk91yhFwI8h/8iEH4I+dcldjgdjxMm6rTWONsbA2T2+X0Q1Ok8aEeiAphfawchFPP9pCd9Ov+XljtdxlMD3R91kupE2soGUm4KGinHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374281; c=relaxed/simple;
	bh=yDHrQOP1F0wxTvoppOAKnwaqWfvb/MwEAtUOtBPNOmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ndzr/acN6TyQqyPRfQqRJodITvvezrgGVUm1exX9whH/55g2teMmjBXku7Gnp0zOXrTs1SCRSmSP/XLULwttkq4sZsz1yqWxdB8Oe9C/iJpijuZEVjbUnGp4YEsXT40tfrq8i7nBt0miJ7fyhmXMktg1asAKOMCS7sXYaBAlr8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iggmGSL4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iggmGSL4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGMToFH012148;
	Mon, 17 Nov 2025 10:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S+3CRZ
	FfdtN0NiyRo0oSzH6a3gO7NCEK+Ap7XVSx2vw=; b=iggmGSL4/6Lzq2tv4MWU/p
	pmCfzCMfmoqiF2u0qdCAsa1dfJC+bS2ihbIAFEJSFyURLa3Pr7fLIXupsjvcPfcI
	dTsGCW61L5vxH5ZV2pF9jmMMfhgmlZWMuAOfkfFV6g6AptZl1saiaXOE6AJmM3GM
	Wdc5MYhF/y47USuCfQLspTQrEhoZ1xtcyjA1w/qmuv11+cGuf3B4o4+kka9FM67V
	CufQpJT3huPaoAjfS5UMHtk1if6zBGs3DWxIkGbjKqpvFGoF73LXPO6vzMFVbSoN
	LufwxxTSBp2eKSW46LIBR36DuVBx1iz5DkUNjP+uO2ZCBMV4Bv2QkrwUwYOL1F/g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk15hpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 10:11:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH81hWM005133;
	Mon, 17 Nov 2025 10:11:07 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bjw4qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 10:11:07 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AHAB6S27013332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 10:11:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E4F65805A;
	Mon, 17 Nov 2025 10:11:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A199358052;
	Mon, 17 Nov 2025 10:11:04 +0000 (GMT)
Received: from [9.61.140.236] (unknown [9.61.140.236])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 10:11:04 +0000 (GMT)
Message-ID: <8bb140e5-ac13-4947-98e4-6e35cdf5fc75@linux.ibm.com>
Date: Mon, 17 Nov 2025 15:41:03 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/5] blk-wbt: fix incorrect lock order for
 rq_qos_mutex and freeze queue
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, ming.lei@redhat.com
References: <20251116041024.120500-1-yukuai@fnnas.com>
 <20251116041024.120500-3-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251116041024.120500-3-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691af4bc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=L4sSNPb1VJOVPSNS_QsA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=H0xsmVfZzgdqH4_HIfU3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: TOU6647_dogJ0XJmGBaRwIBWdYRyx1L9
X-Proofpoint-ORIG-GUID: TOU6647_dogJ0XJmGBaRwIBWdYRyx1L9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXy49Fa6/W0YQI
 WzpgCdEMMJlU5D1CKSge5fWLBNlyQJC0GSxRP31bluhd08u8yF3rovuw7TVUGn1J/3RllGg82bZ
 TpdbNbITdtlcbNKGSwu7UI3GAfbjkXT/zv0OUgKG0/gzRSsPFNMp7E7s8k6pqws2As25pdNcRas
 QXg0KA5sOUwgXuSkxlHaRrb2u83FhzYlGmlWep2XtzGpfWHzpJsp8uTtPzt1IweBbil7vcWNTfn
 Fxe/fXDPoAkV6zb+dOuY/sPFx781PkCaUeCh9aW5Hh63g5yUfSi+86fdamoBIkSaozAmEHP+fUd
 cIrn12G+zy9MPrmxR2s6YdH85XT16wLXdpjCkjezgQ7ATLf+I4BM894gax2SDe+kuenW4vFuf/1
 3iPqYlcuLiuEq7nTa7ZbjlyOUMtdkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032



On 11/16/25 9:40 AM, Yu Kuai wrote:
> wbt_init() can be called from sysfs attribute and wbt_enable_default(),
> however the lock order are inversely.
> 
> - queue_wb_lat_store() freeze queue first, and then wbt_init() hold
>   rq_qos_mutex. In this case queue will be freezed again inside
>   rq_qos_add(), however, in this case freeze queue recursivly is
>   inoperative;
> - wbt_enable_default() from elevator switch will hold rq_qos_mutex
>   first, and then rq_qos_add() will freeze queue;
> 
> Fix this problem by converting to use new helper rq_qos_add_freezed() in
> wbt_init(), and for wbt_enable_default(), freeze queue before calling
> wbt_init().
> 
> Fixes: a13bd91be223 ("block/rq_qos: protect rq_qos apis with a new lock")
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
