Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C474C92
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089644; cv=none; b=BQMNEKrRzWH5EYBLW3g2VH7AP/roC/E9UFLmO045m75O+HjPHrDfXK69auyf/zW1qaZQ3gZrlCmT28a+QBUPJzI3VJ8mQ1ky+SET2BtbpQWC/NzxVmG2wu5lOIRMs2+yYVYxTEQr+X7jrsk7VekSrhcm6CoCtPFW5tMAcCPEjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089644; c=relaxed/simple;
	bh=ioJcawFZkmt42f7xGokM145SqH4kR8Zq0wybAkkGWF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHFFX/tCF0ljBslVUANpBEhBmGVzwlt0GInCRnn86x8iQDgDhFsymIgpwzg6gDjAtEOhBth/LxEnsatqZmm/Xr1jax4NYGGvM9ObwFt2oCZ8jjeKqu8XHugijJ1hMBqZj3MI/Mbah7a6+54A7eq+YFV90qNx1oewMEPNRUOlXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YkZoeuPs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YkZoeuPs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OFYwAV028164;
	Mon, 25 Aug 2025 02:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WAzBIX
	+NClB9lqxIXgLkbA5mOFeKdbkh+dn/Ycc0ZqQ=; b=YkZoeuPsY7KU2GajlmbgIX
	eHqYEVMbBtMFs/ov1BSgbWbVCEW6AULhe3zNdZ9bBWAMPi98SXVkMI4947WcIYCL
	eq68WzN7okftgFzDNNb+Y+PrRTYlYMRWwkMCuro0wopiqQWwiiXMmxaLc+g+o+9f
	hP9nGPdkbVwIw6lxubg9GD01JbjJdU836w4cMgT03O4pAVTlLU2gaeO4z00JKV+9
	q49ENsao/KwnAgU0LXwtXPp9iwZ/5gM1mx/zR/qx/zBW38ew5VZ1aybsVXFpH1/O
	NeYblfworfgaFcTXRj95CpgP+UVYhcNJN33kTfk+GyNWwCOhmtLAqwMZMyKxwwmg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42hpmj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 02:40:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57P21d0g017981;
	Mon, 25 Aug 2025 02:40:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp33j49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 02:40:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57P2eHjx57278722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 02:40:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D4AD58067;
	Mon, 25 Aug 2025 02:40:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E26458052;
	Mon, 25 Aug 2025 02:40:15 +0000 (GMT)
Received: from [9.43.95.74] (unknown [9.43.95.74])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Aug 2025 02:40:15 +0000 (GMT)
Message-ID: <8fc2a2d7-bead-4d9e-9de8-3af6a64e7003@linux.ibm.com>
Date: Mon, 25 Aug 2025 08:10:13 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Move a misplaced comment in queue_wb_lat_store()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20250822200157.762148-1-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250822200157.762148-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMCBTYWx0ZWRfX1I4I0Dzb15XE
 g3jloVeHWUXe3U6dVrjvEQUUzaBFTng9VuPr/yRZr08BCcWYiWCpQQEx2zQJGtnYYXN9+Slw9vz
 ESKK9sjO/lmSoPaEKOTkeiT3QFPGtgJADpwACGwqcdot6LyZ7xoXwji/4UxI8U89lTqrMNj72po
 NlWh7/ozVldMCn5/iR/o9UOInf5er0ZHPLDpxXPClERJweEsO9NYePsTxVLjVhMAOBkcE3ioE1B
 VJlXF7V+J+tvU519hCj6n+BdPCcPzut6tc8ZC1sFLXCoF6OjDncD6cSl3wJlSFxC12TWeGRTMFV
 4btnwYexLOvTxozuGcKVM3fvCU3lpg5IjHpzhBUbFpDqcqRyCFlStIyW5Uk9hO7Ptkc7SmCffXO
 epOw2C97
X-Proofpoint-ORIG-GUID: Oczq8IgzNzKuvjnYxMOcbjZeGIcDItG-
X-Proofpoint-GUID: Oczq8IgzNzKuvjnYxMOcbjZeGIcDItG-
X-Authority-Analysis: v=2.4 cv=evffzppX c=1 sm=1 tr=0 ts=68abcd12 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=N54-gffFAAAA:8
 a=BM4iouFTzF-huzC_6qMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230010



On 8/23/25 1:31 AM, Bart Van Assche wrote:
> blk_mq_quiesce_queue() does not wait for pending I/O to finish. Freezing
> a queue waits for pending I/O to finish. Hence move the comment that
> refers to waiting for pending I/O above the call that freezes the
> request queue. This patch moves this comment back to the position where
> it was when this comment was introduced. See also commit c125311d96b1
> ("blk-wbt: don't maintain inflight counts if disabled").
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

