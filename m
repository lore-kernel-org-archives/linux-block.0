Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B13C198A;
	Wed, 24 Jun 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310901; cv=none; b=sfaM6k52FaThGzZnpffxIrkSCa86q5tRk4Rs2AmOCVYYLNRSO0ZD5tv2pWAHa7EgPMTD+sZf/PLZcE06fcz8Y/RworCjMhmBqKS647M1blVA2o8qeQCnBT0xPggSBAVIRzex+jE92HhdAtDv299W2rnzJWvixUZrb/7JmsVHVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310901; c=relaxed/simple;
	bh=YT97DR1R5OmLB6pYwyRkwAqwkYz4n3pSfx5Dc/GQikc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW7gS7YjYw3o5klg9NO3+cs9bewRtG8GSMbUnJj5qSnCjqsP9+lI9+GZKAwoEf4FAU2lMLxzC3nzuRkwMI09RV8NjSHO1WKMgBiUOvCyVKLpbxWxIhp0YWeM7Kn3ysdeS8OleszUwDziiVI0zUlhsu0U3M3JJb5Ce9m3wpcnD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N651IvM1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N651IvM1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmC6w865981;
	Wed, 24 Jun 2026 14:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cha4/V
	dkvEHHd1SciHHPTgoTtph2V+DxDWJLQK4JypA=; b=N651IvM1mP5Lkd1dcjHXTg
	FxxkXj8DuMqwPhWrKgL1R9jOj6zJxDfI3lh7dKg4mktVGGFN2TldF8ublxq3PV2l
	js1K9qJBaQBWSknDKufVB0bH4BohjXAaGlomUG1wyAFgC0XCwOIgR3j1jA5majS7
	jXkt5TMn6GInVZFhFtxZmYlDbO/O7Hc496Gq61oCKGH9s/MWiTpYgvICRehsui88
	ZplLE762JDvhAAbj1XhdN2X9fkkRrFQltO66Y5sT89ZaZ/1PVICRFkqqB2QLQMDJ
	QSTOCLyBSJembA4uqskDk8kfHJKNgEjuuwZ8tQxEyIGDn+Nv2xNqSrPOsWIdE/CA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqvjge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 14:21:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OEJfbb027340;
	Wed, 24 Jun 2026 14:21:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qh7vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 14:21:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OELHwZ15270424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 14:21:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D03A5805D;
	Wed, 24 Jun 2026 14:21:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D594058056;
	Wed, 24 Jun 2026 14:21:11 +0000 (GMT)
Received: from [9.43.75.139] (unknown [9.43.75.139])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 14:21:11 +0000 (GMT)
Message-ID: <f7919c52-1217-4a64-9e89-d03b70f49d65@linux.ibm.com>
Date: Wed, 24 Jun 2026 19:51:10 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: cancel bw_timer on add-device error unwind
To: Cen Zhang <zzzccc427@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Hans Holmberg <hans.holmberg@wdc.com>, Kees Cook <kees@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kyungchan Koh <kkc6196@fb.com>, Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com
References: <20260624071825.357098-1-zzzccc427@gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260624071825.357098-1-zzzccc427@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3be7de cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=69x5WEd-yEzwNFSAJsQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfXwOuQtr+0Xr7j
 qKvF8+CUgbZq+pnYa8YFAOp36JhrOpsScNlHOy4AdLnANrT+syb4yg+mV/ISTuO+yn+iHBMs0Gy
 iQvP+jUtE7itBEit7rLET7sHCt7MROr0nwhQ3tA50Hx36dsYVTjXbqhYH/Pse/6WwoviCHUTM4W
 QgOFz7d7C92TA77blHoFSgIygmsaFCc9V6AFki+zlJlMsQvh6cEe8nM07WIqcZDZNdxk6C3PpQ8
 FDQqtEnxE+MFlT28p/iZMlDVXg0bcs5J+10u+d21lYuMQg3swF1Ck7OiIi/q0OvbkYyoA5MqWSO
 TcuL0U9tNdDP0WW+L4dfKvdDJGnhVlS80RnY1R791Z+ls8N/EenqJnomB6w9GfV/OP5saI3mz3n
 FO8FOI7ALLVSb2qg3g/E2urCr00AlQ==
X-Proofpoint-GUID: 4aX1a0fftmsitd28-Wypkh-OrUBkLk66
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX9HOK/m60DZeS
 CgeE+Dp3r1tt4TJ9c5z002W82Iia4qtQJvuF88eVe80u/qegwiq3ZQ4E3NG+h+PbWm8uE+Xj9se
 s8VZ8I/BgFoCm9StRhy0QKl8syOOF5g=
X-Proofpoint-ORIG-GUID: W2wlyhpBFGJ4AaP6mnBsaYqGcy5dQZbi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240119

On 6/24/26 12:48 PM, Cen Zhang wrote:
> null_blk starts the bandwidth hrtimer before the later add_disk/device_add
> failure points. If setup fails after the timer is queued, the shared error
> unwind frees struct nullb without draining bw_timer, so the callback can
> run on freed owner state.
> 
> The buggy scenario involves two paths, with each column showing the order
> within that path:
> 
> null_add_dev() error unwind:        nullb_bwtimer_fn() callback path:
> 1. Start bw_timer for a throttled   1. The hrtimer expires after the free.
>     device.                          2. nullb_bwtimer_fn() recovers the
> 2. Hit a later add_disk/device_add     embedded owner.
>     failure.                         3. The callback reads nullb->dev and
> 3. Free struct nullb.                  nullb->q.
> 4. Release the remaining queue and   4. The stale owner storage is used
>     disk resources.                     after free.
> 
> Cancel bw_timer in the shared error unwind before put_disk() and the
> remaining frees. The normal delete path already uses the same
> hrtimer_cancel() drain.

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
