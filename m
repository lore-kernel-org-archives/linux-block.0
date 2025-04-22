Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063BF207DEF
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315575; cv=none; b=c6YzUCPnuUeYeMNZeC9WFL/afvWI6Ld6NhSjaa0whpFo0Q2s0M4i1XIbQlhBNEPpoFBetUSsMJQxZ3TGsQVVASxMT/ABGnJ78LyFaJwNIUWCaR1zwlO7ZbW80BzcYp7hdDp5TG4jdhkrKuith1UBSBTidIoKB19Xvrnus0lAnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315575; c=relaxed/simple;
	bh=/AJie5u6EbsWFvxkXjCimj1qjaoloQOUdY78lCSZxUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjnML0J68Gii/BmKgaSCLfgPPJxwNNJ3op5ucLmhC9E30KlBNx8q2YMkS2TEgVT4/gwiaAp0ImfTBKYMTiECTbABOOfZD/YMTFLCtTYfEK+pgEa5J5BNs5XkvNC2QqQ+P+71dcMXi9L8gbB2T3DmIVhHFgdO96+kuLOAX1/4GJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DS/M568R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DS/M568R"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M8bY9d007716;
	Tue, 22 Apr 2025 09:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TzQsfq
	rqZUC+j2kc+7gJ1TbtLFTAtUUAK08SBEDTU8M=; b=DS/M568RyxabSn16/T03Ew
	ExFs/0Q/+ZHHGEHyKsrSiweuhbwoEYURUjmIWCcxFkLlbKTPb/1zaee00GjZilTa
	WKRglZNrujmIen0o1YD14zbZdyV6xxVolTTXRaKC0xfPfZQUMuO5UtQq8Sqz/HGI
	uc2sZ2JA9IBG2Fsy9Q0b4MMHzi2loWhGR9tIsQhsYEro2iLpaWIn8jWAQBuSj823
	jWTVYZ3aBqOZV1hrxvOV//Bz9IdLQR1ZWq9gSH7cyAtVCDn0pWYNwD1XrzDEdEYY
	oF24SUFgOe/UzBkVs/kMMRbBGE6lsFhvqjbYeQXTF/qy2ZtV8plzMoD7ikMp2r/A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4667rq8bgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 09:52:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M7R2UF015450;
	Tue, 22 Apr 2025 09:52:28 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464qnkj61b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 09:52:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53M9qR758782438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 09:52:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5042E58056;
	Tue, 22 Apr 2025 09:52:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48B3958054;
	Tue, 22 Apr 2025 09:52:23 +0000 (GMT)
Received: from [9.43.46.43] (unknown [9.43.46.43])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Apr 2025 09:52:22 +0000 (GMT)
Message-ID: <3ae885c1-b72b-4c5e-80cf-fe54d66c1fb3@linux.ibm.com>
Date: Tue, 22 Apr 2025 15:22:20 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of the
 multipath head node
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, hare@suse.de, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250321063901.747605-1-nilay@linux.ibm.com>
 <20250321063901.747605-2-nilay@linux.ibm.com> <20250407144413.GA12216@lst.de>
 <5db5ab7b-fdf2-4b40-86fc-3ab4ccff9a41@linux.ibm.com>
 <20250409104326.GA5359@lst.de>
 <385cbcd5-fcb1-4f98-bdf7-80b16d4f5f8e@linux.ibm.com>
 <20250422073607.GA31849@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250422073607.GA31849@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w-uW46tXJDVbfbopZlCixQdN9FPH6Q6A
X-Proofpoint-ORIG-GUID: w-uW46tXJDVbfbopZlCixQdN9FPH6Q6A
X-Authority-Analysis: v=2.4 cv=D59HKuRj c=1 sm=1 tr=0 ts=680766dd cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=Wu5T-vUgRJGWpmTwq_gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=771 mlxscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220067



On 4/22/25 1:06 PM, Christoph Hellwig wrote:
> On Fri, Apr 18, 2025 at 04:15:55PM +0530, Nilay Shroff wrote:
>>         }
>> +
>> +       if (head->delayed_shutdown_sec)
>> +               return true;
>> +
> 
> Please add a comment explaining this check, but otherwise that sounds
> fine.  Your text below is a good start for that.
> 
yup, this will be added in the next version of the patch.

Thanks,
--Nilay
