Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495F418A46
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827475; cv=none; b=otRBkv2WgUbpsDSR/y5Bt/p95l5nvgKHdBaSVIkoQk1PT5MW+UJ4aTTgsnOtWZBP0ve0/hdpv+A1xfd0ZkZ8djR86QEyukPJCOiC7Y3Sm5oz5XHAFnhFZP8m3IBVd3CXSPptPPcLEOOzijXor6J9rCKWdEzwJl9A6IpSoj0TO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827475; c=relaxed/simple;
	bh=Z+FzHFxytDRM7xHiP3VOyGj6DOdt/cHxturthpvQJAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAIU29XSCPTa8TPyfBrqLAI6TybOjekJEIhc3aQvSV0InG5d19wBcTcRWK3LAbz38I5jYuVUXJkpzCQgVz+p5S4Ur+SAkEaS9nXsB+iwNHpYqK+27Ux3N2FficIpOIK401j/ffrDte4wvBWJHNC6yp63kXBDe/pU+TW/XYacjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iXbyfstx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iXbyfstx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HjcS3656285;
	Tue, 4 Aug 2026 07:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PVcO6I
	jQ0i4ilbaOz14g5O3YRFZHs7jsgNQs9bTIeR0=; b=iXbyfstx0sUOIVRSG7pl9N
	tsPfzWoqDSRTjz3/eFhUbWGX6aG7y891nzP+C77Ov6dhZe2BUuVOslBLvJyFCvl/
	SQYEvIFlan5FBeol6uCEVyVw+tSKftdaVtx8tij43B7FmnnNugaJrTxhdUrd+Zwf
	OJHFmPRRk3GU67DsLFWIOaC17zLt63V2FikENUQKPP8+DHY7NdEInBdX+m3n/xF0
	niyqCPXU+XUNbP4YDdg4WGDKQJ1c6JAEARoma+BWkz/5xNb57nK/t0zY8V924TKC
	MJftJZCSdB1dYobdpqMTKChgW6+WlT3mvrtoWhbRKWGd6JZoNHGha6miTGjc4HWg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4vm24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:11:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6746uG0t029573;
	Tue, 4 Aug 2026 07:11:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtygn8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:11:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747AOiE32309608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:10:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B6F05805E;
	Tue,  4 Aug 2026 07:11:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCD5458056;
	Tue,  4 Aug 2026 07:10:57 +0000 (GMT)
Received: from [9.43.105.125] (unknown [9.43.105.125])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 07:10:57 +0000 (GMT)
Message-ID: <e9e782ea-1bd5-4aa0-879b-923772f4cc5d@linux.ibm.com>
Date: Tue, 4 Aug 2026 12:40:55 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] nbd: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1785440858.git.bvanassche@acm.org>
 <5e1f54d3826b0d479242a9886ca2c7b6eb8cedaf.1785440858.git.bvanassche@acm.org>
 <a438f0ba-e2b0-4fa5-920c-bdbf49769674@linux.ibm.com>
 <7d5c9498-c471-4715-a264-17a4df4c2559@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <7d5c9498-c471-4715-a264-17a4df4c2559@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfXzD71qWgOM/Ix
 bOTgJ4szDCDn22Of7NJKnttjIfe86JBRxpd9a9bqM6Lp+BzfY8qwOSXmYa0iNBA5YEcfa6tKdA+
 m9dYX0uF1OIBxQvFOyaqFUjog5DwTv8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfXwBxcKIGt+Isl
 seHNypy/DerEvUm1fyJpt33Zc5fXo+eZYFPkpLAMOGHyfnH2hacvn9Sgq0gP24FhB+hjEaHYirS
 PSLjTgFEplFrzuGxC5VKew6Xvd+lHA9JQKv7zD2W9KgxtglF7rfvC08odE3mErg+VXWInHZbYXq
 VmMJE9D00BYyMpl+3JD3AyQzsDsfkkRBlIk8ITWcWOwu0SY2SIISdD/4XxMj9PcV4NrVua8L214
 Nlpz5hSen6NxilgHCJnV+tfz1U6EklBxD+n4pBYsodF+bYe1AlmhITsDQ59DG5N/D5L8KVndr75
 3jDlwKY5fKMrkJYdoFu5cu2TwBP8uiy938ItySFeniX9phFSZU2qxdo82k9/cZ4hv1tJrq5DbgF
 NPLAU+7ejyOmfxuRk9tZ95o4PPyiGdextBK3nUTJb2WAFkU41zWQliGNVgvvVGH5iaTeozlIGQv
 1sq6VORhJOUi7AWHUyA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a719087 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=3OkR0YcW-PD--22fjUkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eweIiqiiSj5-GNWuB4uPXvEpcK5CFBaS
X-Proofpoint-GUID: NXcbVltgNpLgEggoml5Via_SZ4C0dqMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040052

On 8/3/26 11:33 PM, Bart Van Assche wrote:
> On 8/3/26 6:26 AM, Nilay Shroff wrote:
>> On 7/31/26 1:28 AM, Bart Van Assche wrote:
>>> @@ -2773,7 +2776,11 @@ static void __exit nbd_cleanup(void)
>>>       /* Also wait for nbd_dev_remove_work() completes */
>>>       destroy_workqueue(nbd_del_wq);
>>> -    idr_destroy(&nbd_index_idr);
>>> +    {
>>> +        __assume_ctx_lock(&nbd_index_mutex);
>>> +        idr_destroy(&nbd_index_idr);
>>> +    }
>>> +
>>
>> Could we instead introduce a scoped __assume_ctx_lock() helper so we
>> don't need the explicit scope here? Alternatively, would annotating
>> nbd_cleanup() with __context_unsafe be a better fit?
> There is code in nbd_cleanup() that must be protected by a mutex so I
> think that we shouldn't annotate nbd_cleanup() with __context_unsafe().
> 
That's fair enough.

> Introducing a scoped __assume_ctx_lock() might be overkill.
> 
Adding an explicit scope around __assume_ctx_lock() just to suppress a
false-positive context warning still looks a bit awkward to me. At this
point we know that the IDR is being destroyed and that there can no longer
be any concurrent users, so holding nbd_index_mutex is unnecessary.
If a scoped __assume_ctx_lock() helper is considered overkill, perhaps we
should have an IDR teardown helper for this case, e.g. idr_destroy_unlocked()
or similar, with the implementation annotated with __context_unsafe. That
would make the teardown semantics explicit without having individual callers
pretend that the protecting lock is held.

Thanks,
--Nilay
