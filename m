Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9802AE96
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745058529; cv=none; b=DhcELFAG1tVy6uT41hQ4OMOeiFer0ju1KQCbnE4SRkV4WXgC+7x9LTnFwcOiRjf23uwv0UyQ7+67+dWVVmSm7nTQC1HA27RYrh+J8VxhhOAo6JJJ3lYLHcvlKJYjCED8QMZ4JZOSbFvUroauWYMhcGiF04GsCgjl3WrnoaWUIrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745058529; c=relaxed/simple;
	bh=p7j7WqnNb7wD5W9EuL4Z2c0aHeU+fswZzQgCB3zm3zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2Nv1TwWiTJk3WzK6YfrOJ6WofEKTp4WptVborC/DhJoNbDIgJo4uRKrGIqgljerNupvLtM1PM33PQAYhzIh/pgKA2y1/9yhnIG9gy3c05obd8hLxan37cIbU35K5fhN8XwgQcKy4kIRRYoFKyCu1J4FagE4fkwVTu3lbY89O6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HtouHoXB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HtouHoXB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J3Wah4005956;
	Sat, 19 Apr 2025 10:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NtuGR3
	tQL1wYj8wUH/SX6KRMc1Gn9yTctJHB9ixhwRc=; b=HtouHoXBQ/Pl8B4MDwE1Mq
	HZitk6u3Kaaw5euMGV1DoUWOLbjV7Ikm5UXoY5gk3nCc/fHUhLP41dqQqZWftjUS
	f+dHUHVKv9u4oeMIutBA0JQJrKZqd/nauuFdlK+87qH0I6Vw4fnz0Npc5Mk+ifRR
	nBX7Umcrb9+2XtVZ9nh8kJ9vavfXHwMcWVCGllOCWZM3zJoTMx+sAC2Y7hVlS+3e
	k2IXEv5VmxFt7GRlDMcm+tCN2kNcKos0JRnEY87WkpyqwYlVK48r4jijvhJRuz2z
	yIBrxOOAjJNRCUF/x+CXQpu6o0PGm20JOVsnm4ZrBEGb43W+LZc9c3y1906lPABg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4643gxs1s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 10:28:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53J8Bv3f004526;
	Sat, 19 Apr 2025 10:28:38 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46483trc00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 10:28:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JASZZo8847978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 10:28:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28A0858059;
	Sat, 19 Apr 2025 10:28:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45AE658058;
	Sat, 19 Apr 2025 10:28:36 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 10:28:35 +0000 (GMT)
Message-ID: <b64d57ad-1cff-4766-8093-376a0b5c7f1b@linux.ibm.com>
Date: Sat, 19 Apr 2025 15:58:35 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/20] block: move sched debugfs register into
 elvevator_register_queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-6-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BBRgcgdH0LlH3eZH_yk7DYUqi3e6nYVm
X-Proofpoint-ORIG-GUID: BBRgcgdH0LlH3eZH_yk7DYUqi3e6nYVm
X-Authority-Analysis: v=2.4 cv=I8llRMgg c=1 sm=1 tr=0 ts=68037ad7 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=3WJq5k5j5P8G6F8AOQ0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=954
 impostorscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504190080



On 4/18/25 10:06 PM, Ming Lei wrote:
> sched debugfs shares same lifetime with scheduler's kobject, and same
> lock(elevator lock), so move sched debugfs register/unregister into
> elevator_register_queue() and elevator_unregister_queue().
> 
> Then we needn't blk_mq_debugfs_register() for us to register sched
> debugfs any more.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks goot to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

