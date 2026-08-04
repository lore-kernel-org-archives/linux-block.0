Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9543849B
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785842890; cv=none; b=itsN2UE0elfIVHiekFZSJBPONtrHtgEmKk1O0reojJxgWpW0uo2nnPjrXqwiI68cO2g8QT/mntntJiCxu5pieHpgnaBwH2KF1eSwwNg6GbSTjDPKe795teNCGkbvoDtNcL9s8FYlWUxGH6U7wIvbHqTwDe/9WsaCAHfB347G/88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785842890; c=relaxed/simple;
	bh=JdQJTtBTCam4wGP79Ro/+e7lW4JGPIIgX5MzYEI25SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6ln+J7vmGBVSB1EAimw/XCn2BZ9mw7eWiCspZSbPPnO0uG/xLyoJMZ5ecEwuksVH7osyDLWEH70JsZCDAzp+c+hql4GykMCoVRK5PvFw9yM92C8rd3cn0au79fQgPJvpxxNd0lddzhg3oN2VEbzrbiQ1EhSHNuzqy1crd77h1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cwg3aRNy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cwg3aRNy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748I1va383559;
	Tue, 4 Aug 2026 11:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8Y7okS
	JsRC8FAKXGI0FLnorNx7KNC8a9bfSDsdQ4rhk=; b=Cwg3aRNyHGNRvOrIRwH2aa
	q0RBlK7AVZqGazQ+Mz5z8ZcZoNvZhn9yCZOPKjipwxdPLwP34hsVjrG468eQZIAA
	cBa9y1YpcTpTl1Egj4l5ezE8LY/EBZt8pj/olEI+JGwT37ymH2BPXDb9XQquO2kT
	C7diLLve0aDk5YPMfcEooT2JcdIfoE9ZU8ZtA4/JK7GgcbTSM8Y08gQj4dVo7+5M
	/sQNxQoStKrImpopc5i6WlfgbxJGURSC3lbxEHOrAA5gQv0GlBvMi2Hrgys5giJ+
	2JwzFLi6vHT2z8jt8lvWpaS9yV1TaPw6XZZk6jTHRlcDwzPXaVnTl2SpvsWJL/Ow
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eun3yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 11:27:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674BQGSA025525;
	Tue, 4 Aug 2026 11:27:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qhuej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 11:27:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674BRuTw22086150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 11:27:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2118A5805E;
	Tue,  4 Aug 2026 11:27:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39E7558056;
	Tue,  4 Aug 2026 11:27:53 +0000 (GMT)
Received: from [9.43.105.125] (unknown [9.43.105.125])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 11:27:52 +0000 (GMT)
Message-ID: <e8e1b137-9f18-48ec-a8d7-0b3c5655b210@linux.ibm.com>
Date: Tue, 4 Aug 2026 16:57:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] nbd: Enable lock context analysis
To: Marco Elver <elver@google.com>, Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1785440858.git.bvanassche@acm.org>
 <5e1f54d3826b0d479242a9886ca2c7b6eb8cedaf.1785440858.git.bvanassche@acm.org>
 <a438f0ba-e2b0-4fa5-920c-bdbf49769674@linux.ibm.com>
 <7d5c9498-c471-4715-a264-17a4df4c2559@acm.org>
 <CANpmjNM3-WQNo9djX+P3bWxg24x7jrymiFGJMyJuRrzXBLUHOQ@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CANpmjNM3-WQNo9djX+P3bWxg24x7jrymiFGJMyJuRrzXBLUHOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: eFYCy8p5TNLautJhxZveQ0Kz1DSOeFqX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5MCBTYWx0ZWRfX7RttQaIQ1XWg
 yWLtFqKExXdFmeBkmqsz3Urat4jl6P0AB26Jdr8vDLNJyZ/78KvZUf8TpHDMXTWUXCPtzgzJffP
 pQOF+e4y5MUZkMlGkCO7MI1E14lKoj4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5MCBTYWx0ZWRfXyDSi3zlKtp6i
 NHeaXtQOyP3xW/ozYVPp0zbm85zXMAxpcyECY/xWxwEnUcl5oF+6edXi7ILiIY4egG4czyUZ0Th
 1e10O0krbkIcIElgx8XO97a95yz1L7ovQn69PyY+EG/ibvoBuTI7pLGd4kpWMRJQG6xidxvmc0J
 ZXoaPVa5rWf+TbyW5eLyCTzDp3/3tcxx7ZGK34Y/KrQglwbE+9U5JdQ8bH1++OAoOLVs7+yUYne
 QY4W48WwCE/tbrFVz98ma1ynTVa/eHaTm4kiIQhpW7r6tQTEYd24DW6pD70tMy2pqb93N6HMEL6
 C3MbRgYVe6bLQC7T9yQGLkegLh66bOWa+HRIvWDRIUn1nufYPRvZVlK1t1n9axYZ0K/Q6eps1cd
 vUbTzNs1W6A82TQEFrmw9fJ9qatc3/Mh6/lZBFjFKKOgav4i4pt/ETDKUhfAupVgZOJb67ghfTm
 U10/Cqkk5QuI4xOLJMQ==
X-Proofpoint-GUID: CBr6qj97xEkKt4Fpd-dW9zLWiu0GdOZ3
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a71ccbe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=N54-gffFAAAA:8
 a=n_xAAr3WSj_bsut-N4kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040090

On 8/4/26 2:55 PM, Marco Elver wrote:
> On Mon, 3 Aug 2026 at 20:03, Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 8/3/26 6:26 AM, Nilay Shroff wrote:
>>> On 7/31/26 1:28 AM, Bart Van Assche wrote:
>>>> @@ -2773,7 +2776,11 @@ static void __exit nbd_cleanup(void)
>>>>        /* Also wait for nbd_dev_remove_work() completes */
>>>>        destroy_workqueue(nbd_del_wq);
>>>> -    idr_destroy(&nbd_index_idr);
>>>> +    {
>>>> +        __assume_ctx_lock(&nbd_index_mutex);
>>>> +        idr_destroy(&nbd_index_idr);
>>>> +    }
>>>> +
>>>
>>> Could we instead introduce a scoped __assume_ctx_lock() helper so we
>>> don't need the explicit scope here? Alternatively, would annotating
>>> nbd_cleanup() with __context_unsafe be a better fit?
>> There is code in nbd_cleanup() that must be protected by a mutex so I
>> think that we shouldn't annotate nbd_cleanup() with __context_unsafe().
> 
> Just 'context_unsafe(idr_destroy(&nbd_index_idr)); /* comment */'
> would be fine here I think. I've used that elsewhere for destructors.
> It makes sure that the rest of the code is still checked and is as
> simple as it gets.
> 
>> Introducing a scoped __assume_ctx_lock() might be overkill.
> 
> Agree. Note that __assume_ctx_lock() leaks outside the scope, so a
> real scoped __assume_ctx_lock() would just do no-op __acquire() and
> __release() using the cleanup.h infrastructure (similar to the init
> guards I suppose).

Yes correct, I think if we ever implement scoped __assume_ctx_lock() then
it should just do no-op acquire capability and then release capability
like init guard.

Thanks,
--Nilay
