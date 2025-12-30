Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD41469D
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767073049; cv=none; b=R0BjFbrs6ImbM+kyHVZaQrJWDy+OgU17T5ATLiGZ5Xnuv08uBel56JOi87fw8/hsEg5QFYM2dDYST4cs657FuGNARIVcOkTEibW8zVijBortg/vfCja4eg24XV8jyE21LgA6TYudTcO1TtNHEvRgkdXIHk4jv9dHSGQ3rHjUuHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767073049; c=relaxed/simple;
	bh=r3yoP4JZLthLec8MdgvRLMCp0JrpB1UT+nPJdKzrlTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fWS+jgcCskMjdFAMz8FBH7ymiCCH0TqWDAMWp0B1u0iWeB/RUx05nZza1yJwNU1JY7JIAXu42LsWL1XVJ9cd633ruDdet6Jn3rLuAC0Ka4ShQVom2fEIvpfzdYaUxmGiTKbpr/3/37np4DDH9/pv9KUEROwUX53ykuepUZ46luo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OS88WRSi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OS88WRSi"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU25AHx006156;
	Tue, 30 Dec 2025 05:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p9/Z7G
	csK1TmqaiOFUofPjdpLKHQqdw4qLPOzpvFYXc=; b=OS88WRSicaAiV5Xg3TsdU1
	7Aly6NPHQZA/68vpJG7Qkio+ziK9IWLQ5wGWAbtN5DPf5iUu6mED27nELOdbdPgZ
	6fHgy0dJ25SAwAvIpZ6R/SdMvSHl8CdStncPS/0wAfCAkfU3vssnZoExUcvpfevW
	DD81jgR8B5rYCnhPp3o74i2/ymjD56CMSve/T0MmUUR5gcSBJo7cYVW6y1DmSwkr
	thfvrCT+efArzf8vVJ37i5kzKh92qKID4Me5THaPuWom1Oooa/EAKbv0uFtVzZ1U
	uXr733gCMoS77sCuR+pVOjeWMrB71/WwM0x2sYhS8MioRVGlYqWbgSDhFHfHTbxQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba5vf160q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 05:37:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU1YO1R026013;
	Tue, 30 Dec 2025 05:37:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4batsn8hrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 05:37:15 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BU5bEwY25952818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 05:37:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9394458058;
	Tue, 30 Dec 2025 05:37:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 121585805D;
	Tue, 30 Dec 2025 05:37:12 +0000 (GMT)
Received: from [9.111.47.194] (unknown [9.111.47.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Dec 2025 05:37:11 +0000 (GMT)
Message-ID: <0f8a8879-5cfc-4db8-840a-1c53449723d6@linux.ibm.com>
Date: Tue, 30 Dec 2025 11:07:10 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/13] blk-mq-debugfs: warn about possible deadlock
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251225103248.1303397-1-yukuai@fnnas.com>
 <20251225103248.1303397-8-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251225103248.1303397-8-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a9k9NESF c=1 sm=1 tr=0 ts=6953650b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=qc6UVlPAxpYNRbjD3rAA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-GUID: 84aFD5_-HKx6hEvSPTQZA3Mt0fV-muQp
X-Proofpoint-ORIG-GUID: 84aFD5_-HKx6hEvSPTQZA3Mt0fV-muQp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA0NiBTYWx0ZWRfX5KUPIj51DFcR
 w4It1EuAAfMMvLPLfqTUTmt/fq3RowCXrmRFf9o/+Ah9ID9CANXRYPSoNHZH2nrB8eUgo6Hb/2o
 tpoucDmjQjl0B4zC/P8lLv9uXsmBLEVdJHcfc6LhR2ISSNapWBDBGmi8WYxHNifFZeN17N80wrr
 zlTnjdOSkjEtOnpV5zPcxMxGQTlTyT7dESE2THcB1+vGPFdejJYIop+7UEH8MFDj6yQSREL/rt1
 oild1/yzcJLv6vHlwHqzpSKmS1mjpxVtMu42TIqKorVqhtUakLWzmNGqzzzNP0TVCMBkhXasywn
 c18ZQOqi2XxThljUBSI9c7zgX22u2a+B9dppjdmgjZ+rMM7ILUHGOA0yBD87IyiYvqVmMj2Pvuh
 ZJXddUVoIurJLuibF76jEtF/OxCjf0RdZVL7krPDwZyopKRofcTMiysnOUkUulGA2xScLk1oPvh
 80gDpVAe0rACkSLm4SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512300046



On 12/25/25 4:02 PM, Yu Kuai wrote:
> Creating new debugfs entries can trigger fs reclaim, hence we can't do
> this with queue frozen, meanwhile, other locks that can be held while
> queue is frozen should not be held as well.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
