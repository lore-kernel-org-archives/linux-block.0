Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F312FF69
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544790; cv=none; b=Z+id6QWwoTvfgR/laMM8TTRiZYTx6s0k6K1AgaapF3gZn9Kw1N/jicJKmKFuGAs9j/oaflHvVylF8FiKBgFKVQK2ANMbcHMVOt/Kx6lLR0gvvvH+mZO+ATb+MLjm0bQuiCbeP4EDMmmWPuDjwlseuqooyddNxNC0x04OjEWO0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544790; c=relaxed/simple;
	bh=m78mCAbGvqE7uDa2sSpQf4K4yC7T3uPKmT0HPpEJQPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uS7YlBoqKNNWrrOGBlhxaodX+HR4CCVON8IW11XX6O7Hz3eCsK5BWEIS4QrfOUlUWvZSjgJycMlTlgl1cEGkJ86B31CQRDYHUSXEA7c9eczTo/lduYHohNHLA98tZTi3EJDhooI5ljHszVYsUPyHCXoQhsGERav3IN6GGuMsGBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VBrRtCJp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VBrRtCJp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6044eWt0003502;
	Sun, 4 Jan 2026 16:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l9hfHi
	uuWABXOdpDZhh2xKVUytePlNLOpn1hB8ypbMM=; b=VBrRtCJpKnJWFzspAJZA5f
	63KmqXnyMXNmM5B0A3lOQare1KW5MHnO4POuE9lwxBc12mvk6SFQo5WqKY9q0vBV
	kpiyWe4rtieb1OFdB5a2JWmrzKvz7UOb71kfOtQ2zVgzGavVovZYoYjdSlwM6+N1
	qANly8hB5Le1YcOn8uUCzjmmWuOR0rLpxxUVvHYZ/AKngPzOhPIwHOgEydQNMXak
	3ToZZK7EiUKFGCE5RKn90H++i6XX8Ij3JoxsCQfAT5Xp/k3aX3mxyL+yY7AXu8zR
	q/J2TjJstg7ubWi4CqkILcXCTDJF6seIS1LeP7UhijWc0dx1JGCNgMUS5zW6ibCQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu5v40a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:39:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604DYBCK029636;
	Sun, 4 Jan 2026 16:39:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfdtxj66h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:39:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604GdYZR50397564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 16:39:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C307058053;
	Sun,  4 Jan 2026 16:39:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 312B358043;
	Sun,  4 Jan 2026 16:39:32 +0000 (GMT)
Received: from [9.87.141.48] (unknown [9.87.141.48])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 16:39:31 +0000 (GMT)
Message-ID: <550b4282-9850-48b3-8428-4519c68ca5af@linux.ibm.com>
Date: Sun, 4 Jan 2026 22:09:30 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/16] blk-wbt: fix incorrect lock order for
 rq_qos_mutex and freeze queue
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-12-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251231085126.205310-12-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695a97c8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=sVn0Sq3BUQtChHf1ZOIA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-ORIG-GUID: Y1yDetNcfr3Gg7pP3U8jRIytjo97cbE0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfX48gL8UbJ+T1x
 FneRQEs4FGCiw5ikjXx1v9ZlhtdEQHsPOMPucqcU3E7YFECY7TaF7TIRJWBboaX1zGMI8DZu0qD
 fvDFX21f+AuviIN10zxnh5BR4RwFwJHX87uk/UC+XjDiYztLA8Vw9GsAHKXMuNUlhiHhcOIPjn2
 /nssUhjkb/mOkFjjs1VPgAvksy6TXwINmeec3X+tMmgLD6mhPc+C+BEesPKreFU2wujNSfH+pvi
 cy6++GyP8Mq89ylHT1tpWiuWx7OcgqrbMVXM1rW9B/4ps1Q3y63j2sCDcB+dtgLxo/1LigUxdvk
 iUVvLwNR/5WUJpaQtQNLTXfF1YxRJ5ZefIIbDHEd/y3iOGm+iRWNX6M0VMssnGLqhQAPFB9nxdz
 T2WP4d8aFx+SFzHZVZ1Ehe/TyimQ2inL6Xwst/yel/f4uxM1k9k2GWurubopW7JV4cYzkEqBAPm
 O7rZTu+DFauoJhsu5Ow==
X-Proofpoint-GUID: Y1yDetNcfr3Gg7pP3U8jRIytjo97cbE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040151



On 12/31/25 2:21 PM, Yu Kuai wrote:
> wbt_init() can be called from sysfs attribute and
> wbt_init_enable_default(), however queue_wb_lat_store() can freeze queue
> first, and then wbt_init() will hold rq_qos_mutex.
> 
> Fix this problem by converting to use new helper rq_qos_add_frozen() in
> wbt_init(), and freeze queue before calling wbt_init() from
> wbt_init_enable_default().
> 
> Fixes: a13bd91be223 ("block/rq_qos: protect rq_qos apis with a new lock")
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
