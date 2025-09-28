Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F81ADC97
	for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759072184; cv=none; b=phzOb+5i+D8FTV4YzxaZ3EDmHjxRcJrQok54/n7A0MT1jy2er5Bir7bf81wj1fyqXwTqUbWTwmlEe/VAJaXdweVtwNhhyh2E8eJLhfqnuD5wJiZ4SQIbLCi7tV8XXXqBarAfZ99eKjqkkz8AzsA5VwlpYAU+pUjLlZNm90KiXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759072184; c=relaxed/simple;
	bh=0Di0pr/Zg1D96T9Yo31r9mpw4j/uSvia4tTYhzGVfVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OH4URfw+MAe+fz+o/7lPAeXCRLmOuzOTm5S9kHjn/cy1B/YK1XbseasAkxQunU97tInVe2xmOKVpo/KZvmDC5lmCq+PV90sA/mr9M4MHuimeseL4/gfB0fIb/nrSLaPXlW33k9AOmLkJWaPjgPuIou43VlTu6OO9SybRtVUBMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gg4EgO6D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gg4EgO6D"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S7U4t2026791;
	Sun, 28 Sep 2025 15:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JNpeYR
	+IfQUFp0FlIyW2XW1Up7YQWvi6w8S3hBXfZ0Q=; b=Gg4EgO6DgbVe6ofWZakAQF
	z4nxx0jfYGogJddxFPpBL2fm/ntBC8aWHuye7HTJunxC5SxziH2k9lrBxxwywh6S
	vS4vLitQNTFxjK/tpvvfYhFfzw05r580deVaVoJ6argfAi1fcqb/Ld7DwbTU2jjh
	r9rsX6fGlWS1Yv/BlSKpcA/XxI5AC2+Kb2XxOrlLiABr+s66GJHaTtZYkDSJKATP
	R8bQU1JhIHt3GUMXXV90kC99uu1EdcKn2WQqBORmiUlSlzDAuga3sGAOQlTece/f
	49XWqgDxK+DsHNkkIqFrfT4xArJCwak99qKpbHiHOwX3vNqvhwvkqcPfN79P+7SQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ktx0d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 15:09:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SCCvRv003314;
	Sun, 28 Sep 2025 15:09:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmxj80x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 15:09:29 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58SF9T6N27656782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Sep 2025 15:09:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CE0358045;
	Sun, 28 Sep 2025 15:09:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C56C158052;
	Sun, 28 Sep 2025 15:09:23 +0000 (GMT)
Received: from [9.43.71.234] (unknown [9.43.71.234])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 28 Sep 2025 15:09:23 +0000 (GMT)
Message-ID: <d9548c38-9e33-48c2-9ecc-b942a84dcfaa@linux.ibm.com>
Date: Sun, 28 Sep 2025 20:39:20 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Double-free in blk_mq_free_sched_tags() after commit
 f5a6604f7a44
To: Ming Lei <ming.lei@redhat.com>, Niklas Fischer <niklas@niklasfi.de>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org, vbabka@suse.cz,
        akpm@linux-foundation.org, axboe@kernel.dk
References: <37087b24-24f7-46a9-95c4-2a2f3dced09b@niklasfi.de>
 <CAFj5m9K+ct=ioJUz8v78Wr_myC7pjVnB1SAKRXc-CLysHV_5ww@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAFj5m9K+ct=ioJUz8v78Wr_myC7pjVnB1SAKRXc-CLysHV_5ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68d94faa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=BNlTfnLp_OdMHRcVVn4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: OUPLr9phSgYtTV7jg1Aq2OZUhzGes3_m
X-Proofpoint-ORIG-GUID: OUPLr9phSgYtTV7jg1Aq2OZUhzGes3_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXx2ileBIFQfyt
 MTweuzUniWlioSf9ptg9rzOr3DPcLp5rnPZ1DxGjR4YOHVg8n8okNlzreGYIjTB/vueABS0ay1u
 I914xBZFgQvKlpan6zDV03iPgcUozEIHx+D/SS2SI7EgJ/nIMggaa3Dhmdiw92fv49L9rqURoWT
 Xqj/+9ZkmZhhqBq+6fyz/Ug6K6qvEEdsuLnqJcJjmLKDCqZNsNNA5MS6svlFZa1nun2W4PrKL03
 v5n5hx3gR4r6SKoDtd8b/cGm8E0/a4XtOOOsnFTVbN7XGq5o6Wl2cd6Utv6XMbY1720wwaEdne+
 gz79d0+jczXD2EP6syUfv1HMFsOagLfnntVggC0lqh+RoxfmiRNcforXgl12mzLfEbMV6GGsbmF
 8e1oTYDknkPigXYoovbz3kOJn2jGCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_05,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025



On 9/28/25 6:48 PM, Ming Lei wrote:
> On Sun, Sep 28, 2025 at 8:18 PM Niklas Fischer <niklas@niklasfi.de> wrote:
>>
>> Hello,
>>
>> I'm reporting a kernel crash that occurs during boot on systems with
>> multiple storage devices. The issue manifests as a double-free bug in
>> the SLUB allocator, triggered by block layer elevator switching code.
>>
>> === Problem Summary ===
>>
>> The system crashes during early boot when udev configures I/O schedulers
>> on multiple storage devices. The crash occurs in mm/slub.c with a
>> double-free detection, traced back to blk_mq_free_sched_tags().
>>
>> === Crash Details ===
>>
>> Multiple crashes occur during boot, showing a severe race condition.
>> Seven separate kernel oops/panics are observed:
>>
>> * Oops #1 (CPU 13, PID 928): General protection fault in
>> kfree+0x69/0x3b0 - corrupted address 0x14b9d856a995288
>> * Oops #2-4, #6-7 (multiple CPUs/PIDs): kernel BUG at mm/slub.c:546 in
>> __slab_free+0x111/0x2a0 - SLUB double-free detection
>> * Oops #5 (CPU 1, PID 952): General protection fault in kfree+0x69/0x3b0
>>     - corrupted address 0x2480af562995288
>>
>> All crashes share the same call stack pattern:
>>
>> elv_iosched_store+0x149/0x180
>> elevator_change+0xdb/0x180
>> elevator_change_done+0x4a/0x1f0
>> blk_mq_free_sched_tags+0x34/0x70
>> blk_mq_free_tags+0x4b/0x60
>> kfree+0x334/0x3b0  <-- crash here
>>
>> === Bisection Results ===
>>
>> I bisected the issue to this commit:
>>
>> commit f5a6604f7a4405450e4a1f54e5430f47290c500f
> 
> It should be solved by the following commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-6.18/block&id=ba28afbd9eff2a6370f23ef4e6a036ab0cfda409
> 
> Thanks,
> 
Oh, I hadn’t noticed this message before sending my previous email.
It’s quite possible that this could address the observed symptom, though 
I didn’t see any traces of nr_request being modified in the provided 
dmesg.txt. Nonetheless, this change could be a potential fix and may be
worth trying out in a custom kernel.

Thanks,
--Nilay

