Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691740;
	b=aZdSAOGVrweC2Kpf58N8uWYKhaGKPGiioqGWffSyr8WzAmD6TFb7HskExa9G3MZTA+Jh
	 mdAtjqiFrPsE7WVwlXORg4+jMmoDkaHhw4GpR+T1BK5BaWkTdoHRdGn2n++3p6zVrc3S3
	 a8CQNJnvCQypQkr5/nKZKtBGSOGhNfHcWoDlRL7783pLlb0lArOUO7fV529NBQULtgm9J
	 nXmsKLNE85K/RnP+PUxuxGqRA48PhWBnkZoQZqtQiuQv3i9RfUxxDRF4nTPYj5DVvyqS1
	 b/YjkIgl6AQCCM+tn3Yg5ha/SBr/B1B+hUh8AwIfzxcEy+TExbtRE4oxW0WgKXdkoZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691740;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AsebL0SV4JIm5nAIq/dekHuEghxm2nhQQ3cBE8OMrZU=;
	b=2pKtP2b51TYQfGez1EySYjo+k0tojzjUnb+20zSrnKGFUx6MeQP2aFn8xazjK4wqjGc1
	 ymsstOKzqxUxhQ5GdV+Yvsw8Dp7WduJixX4V7gSqFfFA0sR3+FjFs+8a5jrREXcsXowQN
	 TVg2jXiS7B2t0pBRzG2SO7BMcDe9mHQmABlJ5QhkcAzhJxcaxuPl+xkDWX6QODi7CFKgn
	 vq3tZg/ktAOyUrYIXSzEpFJeVqe6ZwDGuuIfOwVaXD5PDpT+s2sOyIWHjmq33g/3X6W4Q
	 /90N8AcjG8HEKcV95+pBEtWMMdEPLUd6LpizS+SaSOn9Hip76GJUJWDNt5KvyD5T9Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PsNTm2JC;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4D606A32C;
	Tue,  3 Nov 2026 07:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CF4D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PsNTm2JC
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31iLcm293279;
	Tue, 3 Nov 2026 07:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AsebL0
	SV4JIm5nAIq/dekHuEghxm2nhQQ3cBE8OMrZU=; b=PsNTm2JCXHL5YWNc2HA7nu
	3ekSgWyiqAG997E0KV30e+DyzXirMhDHId9tUD268U1AATG59FlgtdC/3kLRJ7MD
	rU+y0SefBlOI6WJmHD2Aek8S5trz+bpXzzTFDierBdoq60q2FiuUbM/Ngvu1xdK7
	w3NfXQ8MFzkAuURQEDTdrEy843xdt2VVJ+i5PCjpFC4lOYLuRr1YI32hajsoRJcf
	pliKkNzyxYCT3L88QRvUPE8z+li/SS31XGo7DgXcVImM8bxX7QDBQemuf9PNiUey
	gqMs/r7zhSpprbXiXt8zhAJn5dZbJAhWxcD3LKOCEqkqIWhd/O+Hc6rD4+7sGR1w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826md1d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:41:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A37V22w1870698;
	Tue, 3 Nov 2026 07:41:46 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gs8ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:41:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A37evjo25625244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 07:40:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9A1158065;
	Tue,  3 Nov 2026 07:41:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEE4B58057;
	Tue,  3 Nov 2026 07:41:39 +0000 (GMT)
Received: from [9.61.129.51] (unknown [9.61.129.51])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 07:41:39 +0000 (GMT)
Message-ID: <3ea92a26-9374-479e-a693-b59de26f647c@linux.ibm.com>
Date: Tue, 3 Nov 2026 13:11:38 +0530
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: remove namespaces in parallel
To: Qiliang Yuan <odys.yuan@gmail.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@kernel.org>,
        Ming Lei <tom.leiming@gmail.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
References: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 09poGoz4s45RTlUea7cRuyvGgAS341yE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyOCBTYWx0ZWRfXwXKM3om4gZiG
 8SC0bjUbPcrtVRh8TV8zi5mEq5QEsOE0z+V9q46/MNJH2hUr6qBPqsFQshUUMcbCKbbFRu8dkHg
 G6TqDL12SvXF4xzVTuMN3OrgUWEDzLnM6FMpQUGgfpRIhPNdCQdOCwzXmOPFZwKJVjOm1ta7sLb
 YVVGV83Jh1naXh1duGKEi7MDdiuibALRB6gYvnqIIxWIviyS5yjwEtiruLf+PhbQFJ2H+UUpeeP
 AwD91qbGlH2owCSzH/pa4IzogrbvGvTJqvShInVV5RDvutDp/CZYSePMpTHz7vpJBBSzy8a6cpi
 3LQk0tInwEZ27RKaPWZFx6LodVNYnNUgkU++OBs25655DOSn4brGzy9IGtx3ysgjKiucOzC+IR1
 xtFx+3KDyUwBImmLwjS6yA0Wmoe1+EkTSazPFf9gir1OFVlro20UAKC2D8hqGFkxGuz5FjOy7RG
 zV9A/KVTErzA6QQD+0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyOCBTYWx0ZWRfX5XPEleUDtoGU
 Vg/4DcDMT0AuRfqUmGM0yhRjFiTvxrAHTXJuWL8XKQQ1eOU2skJktcyBJHMx0D7Cu1jwfw9uyGE
 WeQOD3yJvm6hShxrqAvR29DZAhiXPFI=
X-Proofpoint-GUID: 1zObZRFC-CnTTc3J-Vl8yX7INanH0aN5
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae9903b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=5cS5l0lNN1-yX1iPpGsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030028

On 11/3/26 11:58 AM, Qiliang Yuan wrote:
> nvme_remove_namespaces() removes the namespaces of a controller one
> after another. Each removal waits for RCU grace periods in
> del_gendisk() for the namespace and for its multipath head, about
> 20 ms in all.
> 
> Deleting a controller, such as disconnecting from a fabrics target,
> thus takes time proportional to its namespace count, over a second for
> 64 namespaces. Scanning had the same problem until commit 4e893ca81170
> ("nvme_core: scan namespaces asynchronously") made it add namespaces
> in parallel.
> 
> Remove the namespaces through an async domain the same way, and wait
> for all of them before returning. Each removal still waits about
> 20 ms, but the waits now overlap: a grace period is system-wide, so
> removals that wait at the same time are released by the same grace
> periods instead of each needing its own.
> 
> Disconnect time from a target on the same host, over tcp to 127.0.0.1
> and over nvme-loop, with 4 I/O queues, median of 3 runs on each of two
> boots per kernel:
> 
>    namespaces  transport  before              after
>             8  tcp         170 /  171 ms        85 /   91 ms
>            32  tcp         628 /  628 ms       294 /  293 ms
>            64  tcp        1201 / 1308 ms       533 /  550 ms
>            64  loop       1988 / 1913 ms      1283 / 1200 ms
> 
> Signed-off-by: Qiliang Yuan<odys.yuan@gmail.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
