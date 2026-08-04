Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F21A5B8C
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 07:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826991; cv=none; b=MuUlEZpw11EZIOV0f3A0NJIgyTqadfKwHug6TwYVvokFT1ZNlTgItZVRpsr1LnDFg3MGoJiOlCCrHTz7090I6FsJaPtBMUXEbTO42k/W/bECHA3V6HK1X9eXIlrjABDrILrdHDkkkXxVfqxNSjfMivk6hIoY+s70el5/vvLVoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826991; c=relaxed/simple;
	bh=RnKE325XRBMYNaTSq28on7DV+uykXZH5M+1+VrLxbxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cfr1fWDqAaK+CvMIPvJ8ucqXpGQ3JajISCFD3UPRdAZ30nyAQJi1rTDYe99hiFQV2Tt6GZkNvyvCV+jj+Zq+a0u+uBJFpyldWUVW5gYg1rx4mo6Yey6iioUBbtulfjDekGF/PyPYCjqC6kkcV9NwyMZaa7O8nKgXB5n1VyanoPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HW/oyJd+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HW/oyJd+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HxPa3656474;
	Tue, 4 Aug 2026 07:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yKLw6S
	Nh3AiCMyrkebW2F2qkc3cEoFPoE11fCSggqXA=; b=HW/oyJd+cS5idu3D53wjqC
	GbhMo/xGrKhmOUJVJ58inO8l46iZxaBi//KUBUIJDtLDx+tHrzdUu3HlM2Fw3U3z
	q60JA0wkd2CJVJZlNBtkSR11fX/xWN9GSQZioq2XFC4zsWP9LAgHfJ876YLbVz99
	1MfXh+s9syDHsEzJ6cqED/utehQRg4Cabur357N8L/PdH2bdNoGJggLmy6AsK8vP
	Fj+6ksfuFHiUdhOxAfRPwq/n2I86r0NUQqHymxsFvG5mu8vzkoUrl+FZb9h+JNKM
	k3Cg6g8ojOmg1U2dDVurvYb09mO1tJZeL9lKA/Vg0AQzHKLU4xYXzFtW5asS7dRA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4vjxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:02:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6746uHaw012688;
	Tue, 4 Aug 2026 07:02:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw0xwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:02:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67472vP330605978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:02:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DC0658065;
	Tue,  4 Aug 2026 07:02:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CB3158052;
	Tue,  4 Aug 2026 07:02:52 +0000 (GMT)
Received: from [9.43.105.125] (unknown [9.43.105.125])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 07:02:52 +0000 (GMT)
Message-ID: <84f608a9-8f2e-4ce8-b23d-e07c133297fe@linux.ibm.com>
Date: Tue, 4 Aug 2026 12:32:50 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] loop: Add lock context annotations
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>
References: <cover.1785440858.git.bvanassche@acm.org>
 <db7c5b870df403fe97229f6bb59144122e16aa41.1785440858.git.bvanassche@acm.org>
 <a41ebd1f-f115-477b-a3b0-5ca9247ce465@linux.ibm.com>
 <3f42cecd-98e1-4db7-b026-f673e38d54d3@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <3f42cecd-98e1-4db7-b026-f673e38d54d3@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfXyrRoSeM0wZrp
 TPLExmF6lMeTpxUxVROTU3/9g4Z9ImES/5L6slTtR0BxX01k7FUcb2sPnjHgdBDKJhmuVoupdc6
 W3pR4z1jo++5Ap9S24S2ic3cFVcZrSk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfX6QSLkFMKv7yF
 W9Q6UdlX4KPViJILLSW62RUxfgufCj2hlPXe36HWzgOuq221DdfgHKjfk5GBRuivl6oe3F1uoUW
 EZVshle00X0hFcEscD/neOTJWTKbjJRPQhS/0rEfEBHb2I2HRe/jw7S2hgTaNybgRIfHr3YIOKl
 YNr2SaHlP1mGHKO7C++9d6ASTcVFFlQaGMqfed2KSDNLNtPIAZx3d3Vhp/fSClRaYaScAJuTSig
 dlOaudsobLmT0NapENNYfokaRc8M/oTQe4RlI7nWsRrvQPI/tk8TfMPhK/FsVDuviGSvg42kAwq
 3alDJiaMCGkc+yXSpJTbpcxcvcUDRVo9slwP46FL4lD9gHtpgTVeWv3C0rmMv8O5GpEIdFA9hbm
 ALffJSpaxtqNhy3HxXrviaBQj6QsXPJYMiPfgQ0ag6+TgrPpSzN0nWl2Dlli+DFanE9vy4J2uGZ
 8raszXdS/CxZs6o77Cw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a718ea3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=N54-gffFAAAA:8 a=cAVbNgA2QUCpr7qhOzgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TCXW1fE5BhYTYtj9EOEseCTj7-Zq4phv
X-Proofpoint-GUID: 243P8l3jVk7amOqdwFcMeVV_0ZJCwu_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040052

On 8/3/26 11:13 PM, Bart Van Assche wrote:
> On 8/3/26 6:11 AM, Nilay Shroff wrote:
>> On 7/31/26 1:28 AM, Bart Van Assche wrote:
>>> Add lock context annotations that are compatible with Clang. Swap the
>>> loop_ctl_mutex and loop_index_idr declarations such that __guarded_by()
>>> can be used.
>>>
>>> Cc: Nilay Shroff <nilay@linux.ibm.com>
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>>   drivers/block/loop.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>>> index a71fe763c933..e2ac19de11f4 100644
>>> --- a/drivers/block/loop.c
>>> +++ b/drivers/block/loop.c
>>> @@ -90,8 +90,8 @@ struct loop_cmd {
>>>   #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
>>>   #define LOOP_DEFAULT_HW_Q_DEPTH 128
>>> -static DEFINE_IDR(loop_index_idr);
>>>   static DEFINE_MUTEX(loop_ctl_mutex);
>>> +static __guarded_by(&loop_ctl_mutex) DEFINE_IDR(loop_index_idr);
>>
>> Can we define helper macro here, which is more readable?
>>
>> # define DEFINE_IDR_GUARDED(name, lock)\
>>          __guarded_by(&(lock)) DEFINE_IDR(name);
>>
>> This is similar to what we have defined for guarded LIST_HEAD here:
>> https://lore.kernel.org/all/20260713115444.465704-2-nilay@linux.ibm.com/
> 
> Maybe I missed something but it's not clear to me how such a short macro
> helps? It doesn't seem to improve code readability to me?
> 
I think the helper makes the relationship between the IDR and its protecting
lock a little more explicit, so this is mostly a matter of readability/style.

I'm fine either way. Let's see if others have a preference.

Thanks,
--Nilay

