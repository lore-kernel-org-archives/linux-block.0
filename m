Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560137;
	b=JfPWpUYX71FB9Tk9j6P9HxbjN/WEghbvgnTzgim3sblepoNNpdAWR8I2XMJus0UYRJa0
	 QGc0Fo85B9e8g0jjt8bRP74kbM0mw8TQXQoRprB2YXdO91LUVpKBlbx1okrSb8pABD4lY
	 al7qYCPMyX1SLm1XYUiYFZ2cAgHC/pQvCeaUgFtWUzif3z6yOSsKW3e820950+RtRVE4n
	 5LxYODMkU9mlO6q7nY+Lkf5urMPEFs7FCcpGkRFC32N6gcKJfIB6895L0wJVdU1z4Z4LM
	 D226VQ7wV0XqE3bDmrKG5109ljp/voyyudKQnAx2dj0P1Dfc+vfatkcbf2cPzYDQ6+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560137;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=v9/tYwHSh5mv9FFKewWYgQVl7NNeNpfbP2xOdgLHoAo=;
	b=TM0Jhwwk02oYCAkAvxOMeVR66FtOZCauniJ6JiPJCV4LBFqdIAR4RyvQz5ov+Cj1KYa8
	 LP+putXPILNKOXeeVq4Bb5sex1TQbYrvYyE49VinJunCxjOYrI2hZufnEx6Dx27ul5w4K
	 RqKzcRweNgs8NhIvnMtMx4Vp8fDOdI7OqXqvUy9Plii1X7UvXArMcMZXdWnxnDI01l+4H
	 8ooVQXcMqReRbNub3Js0utJ9oiPbwWh7yklIrDwgWesp/69dwnnAfmkHS8FvN1HRBxAz9
	 xNJ8/R125jUhHBEPIVQNPv/GOLwH8iHpAQMgpNwNdRQJV10WtARe4rNGnz/2ZT9tmNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YWI4otQt;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA92606B366;
	Fri, 13 Nov 2026 08:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EA92606B366
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YWI4otQt
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8jEp72574133;
	Fri, 13 Nov 2026 08:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v9/tYw
	HSh5mv9FFKewWYgQVl7NNeNpfbP2xOdgLHoAo=; b=YWI4otQtKssrPiLAhRP9zZ
	H+ixPxEmoN08FHaWXLk3gQ/XM6XgKkYBs+GS0+dO3LhO1DvYo53Ox0yyTMzkFPSP
	QHtEfiTax6Vd7t1X6VEcftoFntSV73yEfGiYs7GPzCkyf8je4fRNTgtDF8sNb/2e
	HyAODMs+yVS4SYd405YvByDcbZUAoZWvzXC1Gi+wUy1M8FhCP6ozCbPGT6AxVwMa
	tHgJlx1pu29D1G+18qGPOj8uwkXGyJ1E9X8subWyQCwVMTRvb464/ekC72PVEu8+
	pXuLplLEPR50YmoL/7vlEhKE/Ha8+qagnLIyuy9Ikzb6nzX2pO8tCHmKJlSB1lpQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6jm4r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 08:55:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8ZAUe2009295;
	Fri, 13 Nov 2026 08:55:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd85bbxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 08:55:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AD8tQHJ10814208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 08:55:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1143358058;
	Fri, 13 Nov 2026 08:55:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD68B58061;
	Fri, 13 Nov 2026 08:55:23 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 08:55:23 +0000 (GMT)
Message-ID: <0975a9ae-d73f-4592-a715-55a52b6e143c@linux.ibm.com>
Date: Fri, 13 Nov 2026 14:25:22 +0530
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
Subject: Re: [PATCH 1/2] block: don't request a module for the none elevator
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261111-bug-block-elevator-unchanged-v1-0-583198bd4e21@linux.dev>
 <20261111-bug-block-elevator-unchanged-v1-1-583198bd4e21@linux.dev>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261111-bug-block-elevator-unchanged-v1-1-583198bd4e21@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qFdREogmOjTAFe1sL-GsdHCjrDoMFa-I
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af6d080 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=loaMudsPnU6qzrEnzdwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Fgx7GP9KWKvkNyFWcFy9V4nxM4FttGEE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX5HQxlKiJR/iB
 w79RuluHNHy2gYTf8egkUsPcVXbl3QS54IxSH3bOSZWJ9OWjOoRdsDlca5niRZK51r5tBK7o9W/
 aM4ieKCE/Il0LaAKmzGprVZrbqexVXzF0s7Hk88OVR21Zep/wKuCXQTBWMroFr6iTuvLhtUg3Xj
 h8ZVu0klPp1sqfnbH+FiH9xdVMC6HKmX/aDjydWSq8JNkUQHmoA7pNNau357Qj7T59P87w0c2Ia
 kmUfIymoUb1d0eDckO/4F0m0TgQILAEwIz6o63Xwu/PYW9vthErFO1Oojc5VAy+Tlv5ru9HXKfr
 j7nXxoMadYL/8A7fLo4SRvTqWFLqbQ92gwkt/Z3QaBMW3FZb6Ac3afecTuUp2oNpX2KEZWsTOHA
 +KdKufnIot19z1Kvdzbczd8VCY7lz5iA64Y7YMqhU+OwP6vH8gYZHh8vYAK8amxF3DU56JCHJ0t
 gx8l2WZJRAiqbkX5mvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX0ErzZ6ce/1JS
 H754sx9EOHifSw+MfD09q4wh2tdDLeFuwb3iX0Vr1C7kVLYXSERv2L88GhJ6a8ADxs0iC6Zmnii
 vRGHb3AjsMi2WOl3FUu7C97S4wuz0m4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130034

On 11/12/26 8:30 AM, Qiliang Yuan wrote:
> elv_iosched_store() calls elv_iosched_load_module() for the requested
> name before anything else, and loads "<name>-iosched" if no elevator
> type of that name is registered. "none" never is, so every write of
> "none" to queue/scheduler ends up in request_module("none-iosched").
> 
> That runs a modprobe helper which can never find the module, and adds
> several milliseconds to every switch to "none", including rewrites of
> it by udev rules or tuning tools that set the scheduler on each disk.
> 
> Return early for "none", like elevator_change() did before the module
> loading moved into elv_iosched_load_module().
> 
> Writing queue/scheduler of a null_blk disk 20 times takes (median):
> 
>    operation             before (ms)  after (ms)  change
>    none -> none                13.09        9.06    -31%
>    mq-deadline -> none         11.99        7.96    -34%
> 
> Fixes: 734e1a8603128 ("block: Prevent deadlocks when switching elevators")
> Signed-off-by: Qiliang Yuan<qiliang.yuan@linux.dev>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
