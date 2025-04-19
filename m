Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B9C1C84D3
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745058370; cv=none; b=KFT7xCMbQFOBDXRSfnfIiLP/KAoK3ebUnHUtRueaqxnietIsggqn2rqbLM7GglzWFtLCfVOScYm4hpRCO5m3kXpaYGW2dpZZU4HDG22JpeSwzEl5pJ151PqljWW4yRp56qLM2Yv9/J5h0HXhgKAKKg7l/qa7qlW6AaFSXfPVZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745058370; c=relaxed/simple;
	bh=fvoU2+hFR2LWE9LjVErt6oBDTHoHojVitnjzUdnD9I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZL9iW3zv/TFFzEZZuD36OyVJ9yRWCxGLQkhs6CXsGQD/6yq618cTr/sT70k9EtnKRPgRFK98WOdpgGSWJC9aQ76eWh77vE6L8yE2E9WscG0S9wVy0f45ip/MaGRk1waW2x8RBzhXZ5n94Yij+Avb1aMVWVZCjVIsUHo1VXuEZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c9FmTWpA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c9FmTWpA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J8fgoX002290;
	Sat, 19 Apr 2025 10:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CyFw1H
	Y2Y3xJOxBNM/2W/GbRgOoRf0YRfkQFHO1sH88=; b=c9FmTWpAtQAW/B7GA60dqS
	NXrG5QLOVHRyDJD1NHjG3j57vajPojxt3pG6PIw0yiHK4knmRUcKHsHbpZgTnwhN
	7JIvbAWD5jxG7LrYBFF/ROXwQD0P4hqAzKZgvg8q01+e8m+r8YIk2DlahtjylE/a
	ePMncuTqmm5MwT/cODvQo1fx3al4aUkmTO3Un+y/ct7SYmGhODfJdPdNsAndutgM
	2H3QS4bfl1ETx2bM1QnkwEdvGSmqHeed2kdVWku7aebTi9iZ4sLKTj+NpD0pn5QD
	5P3/1vQyZmhqT6h3mtJ4sOIn178a0riw3tdvHj0r3wEIPQ3/k7Xzfrg3g3Ln+nmQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4643g08ya2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 10:25:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53J80Rbf001258;
	Sat, 19 Apr 2025 10:25:58 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602w0f881-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 10:25:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JAPvqm21824060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 10:25:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 179455805B;
	Sat, 19 Apr 2025 10:25:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2217058058;
	Sat, 19 Apr 2025 10:25:55 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 10:25:54 +0000 (GMT)
Message-ID: <30d8b5c2-cfe1-4429-aee2-0850088c58d9@linux.ibm.com>
Date: Sat, 19 Apr 2025 15:55:53 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/20] block: move blk_mq_add_queue_tag_set() after
 blk_mq_map_swqueue()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-2-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RLFmI7YtTaRymMGXlwip5kqZynLI7Lf9
X-Proofpoint-GUID: RLFmI7YtTaRymMGXlwip5kqZynLI7Lf9
X-Authority-Analysis: v=2.4 cv=cPHgskeN c=1 sm=1 tr=0 ts=68037a36 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=UyflODbOQmMwyKyjKxcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 mlxlogscore=938 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190080



On 4/18/25 10:06 PM, Ming Lei wrote:
> Move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue(), and publish
> this request queue to tagset after everything is setup.
> 
> This way is safe because BLK_MQ_F_TAG_QUEUE_SHARED isn't used by
> blk_mq_map_swqueue(), and this flag is mainly checked in fast IO code
> path.
> 
> Prepare for removing ->elevator_lock from blk_mq_map_swqueue() which
> is supposed to be called when elevator switch isn't possible.
> 
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-block/567cb7ab-23d6-4cee-a915-c8cdac903ddd@linux.ibm.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
