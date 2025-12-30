Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78394469D
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767072972; cv=none; b=qs10sSmB7ECBvmJPUP1SQ81ZmLjTr4QPD8VWgIUb11fnQigEP5clL5LojrhQrEIQ/A1Whx6KQVU9B+Vbqi7yzPmUCy4Hqar5HUKIFIdgjJiU1YGArPzlxM8zIdFafz8nCoAPX4MIAYtvxI5uYLJafXEHJ9WpqNb4zrF76DNNmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767072972; c=relaxed/simple;
	bh=opxGb6SHCKTkFX8iN5WTpmQaW2H2fh+jMlha5hpwfug=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kbmE3CPf0oIBodxsbCG2U0jTCnljdPTivUGxKLdva+KX87WvnNetd9c82zEIhCPcWc1/rizvNLSZ4+tTG1KObPBpV0a7lgcIiPMe8hZiFmGgeBZM8srzphj6wRgf0cXUb7H7OqqTx8W/WmSMoIXYNxt3eHHgmUDiGpMM6jS8fD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eSciE2TE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eSciE2TE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTBeY5e013365;
	Tue, 30 Dec 2025 05:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vUJhS2
	QS0u8fnc2fligc4VCFu5d4a/XGeLJG/KoQPWo=; b=eSciE2TEy8b5NBNEBQzi77
	K4cWG4WhWAmUsT+ImZr90V/5EOAIWv8WEvjrS+VAszbMQ32J6zCgpW1vD7901hUy
	D2kQRPstL07S5j0KmRGcdY8OBbUuPu01qZismoSdBmUOSLk+LjqkI28OPcBLy0h0
	Rhvo4eTfIZ3WJuMzc9ERhdfw2rOb35hw5UOW6WJg7EcQIqRd7gAek5aO4C9887K6
	CP/kI3dmPMr/dUx4GPBDMxhJgmE+Q2vBS9th/NlfEoW6IRKFnpjKJ9m/7lYOBRUv
	nqajPcQPib52PC7Cy25/XCy9RHmkvByA7oxQNM3Y4PzG8k2S4UQVsZ01S4BBWlgw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba5vf15x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 05:35:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU1HaJG023939;
	Tue, 30 Dec 2025 05:35:56 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bat5y8nta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 05:35:56 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BU5ZuPb27918972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 05:35:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 190725803F;
	Tue, 30 Dec 2025 05:35:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC5EB5804E;
	Tue, 30 Dec 2025 05:35:53 +0000 (GMT)
Received: from [9.111.47.194] (unknown [9.111.47.194])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Dec 2025 05:35:53 +0000 (GMT)
Message-ID: <adb48c62-968e-4eef-9174-5b2d7cc23b9b@linux.ibm.com>
Date: Tue, 30 Dec 2025 11:05:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/13] blk-rq-qos: fix possible debugfs_mutex deadlock
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251225103248.1303397-1-yukuai@fnnas.com>
 <20251225103248.1303397-5-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251225103248.1303397-5-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a9k9NESF c=1 sm=1 tr=0 ts=695364bd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=rTDWk-x5bkgnBn-qG3IA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-GUID: 7jv_HYzi37ho1iH-TfRI1X8HtwFqLEQj
X-Proofpoint-ORIG-GUID: 7jv_HYzi37ho1iH-TfRI1X8HtwFqLEQj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA0NiBTYWx0ZWRfXxb3Ivs/OdW96
 wPo38R6YCPa16pfkpNqw1ozcDMS5dzrcPphu0YPu4iIBDKyUTIntTG0+ZBptuF6NvQjYXHC77ay
 jmTruvhrTh/CJbfLnrxflL0/ChtVGi4Fcpj3xn6EcomRh2ZPXM7O1ns9J6BoP54be+aKClUDeeG
 GnTt3vpYxcbfKoZv8VWYUeSDoOrN6vU1ww0zK0vOk8qWsiwTEDhJEPOenkfJxZEfK8WfqLhuSdn
 MsIqh3Tl3aIsz2TvOhNA0WtNFQCRdn9TfVgbI6HlL6/lK/Foh1kFmDhWn7NUnctg9qO9czCPFxn
 8rhou9JtMxufqn53ZONQqpOevKBDfe8W7I62WDpHsG6BKdpCiBzThEmgf9RLzJiumUKDnpTu+UL
 QzZZ1JRbeNddvsHO3heZ1r4ZYHcBexfNRvOrDMbxD4YmoNer8YCvOC84lhRMRF8i3jqFcbfEkzh
 Entti+X36xQkc3ngIDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512300046



On 12/25/25 4:02 PM, Yu Kuai wrote:
> Currently rq-qos debugfs entries are created from rq_qos_add(), while
> rq_qos_add() can be called while queue is still frozen. This can
> deadlock because creating new entries can trigger fs reclaim.
> 
> Fix this problem by delaying creating rq-qos debugfs entries after queue
> is unfrozen.
> 
> - For wbt, 1) it can be initialized by default, fix it by calling new
>   helper after wbt_init() from wbt_init_enable_default(); 2) it can be
>   initialized by sysfs, fix it by calling new helper after queue is
>   unfrozen from wbt_set_lat().
> - For iocost and iolatency, they can only be initialized by blkcg
>   configuration, however, they don't have debugfs entries for now, hence
>   they are not handled yet.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
