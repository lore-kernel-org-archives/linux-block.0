Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C581581F9
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586382; cv=none; b=Waz8SQQC4fEfyVI3W4QKi/24GZC0TRqARv0samTsrERjCXQhvbqjCXxGcpmTh5BxWkFdwZaAhKzx99YPgFFU3jEs1psBIzbg1u4Nagg1DN8sfHSBEBv6j5JYolviMjyVbwCaW10VdsQu1BU5BxqVrHo6y+HEI3CtBrHCrXRGIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586382; c=relaxed/simple;
	bh=sJkokpM3b74UQ8U4Xi49j4VDcQ6i6Ms9Bcrv8UexAdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mm3YNREd9cMY2rUvwDUVzPHwJLgzn1Lg/+7J6vKaRrWp7PaJCUG4uErrFlHwitfA6JLHU8Wemc7FlEzS161AVeYWKjKwNHFBXgRiB0+N89GRF2zFoztWwX7Hi3vfCjjTMHjCg9nlnV0+bYu6t0L76aiowDMuO2kyjs78bYatZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dHjgDaNE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dHjgDaNE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PBRNOk026368;
	Fri, 25 Apr 2025 13:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YxYmLC
	vEQvwjGnkPJPetZeLM8scqjRHfXtpUsrhx3zU=; b=dHjgDaNEsWcc0IZ5b/Shyr
	BMnOZA2gG2Dp+GXsBQMtP6I4w242X3YmP6YYujXGPi0snYAFInuGLen5UgPAUjMu
	EwNQo4/D3qmAlOP1x1v92Fb80G4MmyeXWMoQgo+1om5Lb3GdDY4A+0KKeM5Crco7
	QzriC7FUNe8GzSgfIXG4cg62xkpzdLu27je4T9UY344uPY638YLELinycGBXsruR
	eLk6LKeFGrSDQO6Bfdite9LzgICxkz7EfD5oF/UvE35U4YNSBCO7zWIbl/UqKCI/
	hd+Lz6sCHzkcEVETqC33GghLzQ4a6eK2zMW0ZKLvdHdtOq+pqgDVnkLDCLXXEWHg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467y90twq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 13:06:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCMl16004157;
	Fri, 25 Apr 2025 13:05:58 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jg05a6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 13:05:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PD5vYu26215006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 13:05:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BEC358064;
	Fri, 25 Apr 2025 13:05:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DF7F58057;
	Fri, 25 Apr 2025 13:05:54 +0000 (GMT)
Received: from [9.43.102.9] (unknown [9.43.102.9])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 13:05:54 +0000 (GMT)
Message-ID: <1bb8ed25-e447-4ee8-8fc1-d795663f5225@linux.ibm.com>
Date: Fri, 25 Apr 2025 18:35:52 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 16/20] block: move elv_register[unregister]_queue out
 of elevator_lock
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-17-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250424152148.1066220-17-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aZRhnQot c=1 sm=1 tr=0 ts=680b88c5 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=J7OKO6jKvhcvylUQB7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PIXxXE134LXnTwpLq9hayVsWMm3XKuMm
X-Proofpoint-ORIG-GUID: PIXxXE134LXnTwpLq9hayVsWMm3XKuMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5NCBTYWx0ZWRfX+E2/APJpX1JB w3Sku7swhvdZ1/nlAUpzzEnfgrGYAOcwdiVHeUs5OTYsVHC0uYVUy91MQU4l0rXPPS+JxpXFq9u eYG9XfS9zMsOqwKFO4pD0vtaGkPM7RzF3KKdy7ELx/Qo7cvRLCaZUzYjRic3a0KLrnOD8i+27aY
 L+9rFIhPY9Utjo/326fwJzWOT9RvOuK5VXPAS/ViPeu8MUZVhoE8UxC2zxx3jzLpgNGfkbkwhBN Tj/GWnClei60b75IApPg+8EGYKrD+Rr9qRdMPDwpazmGPUgfll5T5Bg26alFCSqdyyRNdcZ8Q1m lO6I0nmAZ2neYLo0Das5OOSkmq7nsMgaeersJWk3Sc7RVNP3nhNwHx+yKXP+cH0vDR6bhYb/KJL
 DdzsLdiDP1CnhWAXKQ3wXQgw2oy6GqOU6Tzu7KtSwOVYsmaipUlHvvwYsLtLa/quv9ppbYYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250094



On 4/24/25 8:51 PM, Ming Lei wrote:
> Move elv_register[unregister]_queue out of ->elevator_lock & queue freezing,
> so we can kill many lockdep warnings.
> 
> elv_register[unregister]_queue() is serialized, and just dealing with sysfs/
> debugfs things, no need to be done with queue frozen.
> 
> With this change, elevator's ->exit() is called before calling
> elv_unregister_queue, then user may call into ->show()/store() of elevator's
> sysfs attributes, and we have covered this issue by adding `ELEVATOR_FLAG_DYNG`.
> 
> For blk-mq debugfs, hctx->sched_tags is always checked with ->elevator_lock by
> debugfs code, meantime hctx->sched_tags is updated with ->elevator_lock, so
> there isn't such issue.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
