Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF53E5A2D
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281762; cv=none; b=NNsWo6hAbI+vzWmwxItjALfWYDhxzyyMg/XWx/TQ3xxyL0W0NuHCu32H3WG0Fpggp/jWlbKNIIPLkXTZR4r9U8jdhuT/6tS+Tg270errgCoqbqlmiYRCz0eOKwan41gCheAv8/ZPtSY11LOuy+caoeaY0qcILAEQwQiPPvhFgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281762; c=relaxed/simple;
	bh=OtjQOHWNlzSWCrNa0SnSape8Ed5EuYdqNcVhAHpgC20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJu+LyNJ+zdVBiFnRiXNhEB6Q8YNbDcnVi7+eSeLUlUQIOqquNxx93jdNpLTwCzJb1nqLu087/hk4wFU623LnHFCrXWtcPSHTod+0gAcmStcEoOU7PbJWjfZgo7af0R/jRdEM+2NE567odHFhua0TY22/mnE2eHfqWGv3hJvwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AmbjVpNA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AmbjVpNA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6gRVg1279635;
	Fri, 17 Jul 2026 09:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jxNnfq
	vIKw34B2xIKrEtjKVLc0TAsbQJv6LrQ2KIZ5Q=; b=AmbjVpNAGGZp08IWsEdbjJ
	N+AblvzDUsaNRhcy1y7vn4UxPVWUjRB2pgUjzU5PwWQ4H/ZJSufnw/r3cIgMkNv8
	yfwdC9dPY1h4DZznmr3o7FxRljJ2cqLJLd5L2PqMKN0ILlxDvxYto8nUvwDB8Sns
	Gx4qJUIPGVgSFUFoMrVv5aRukOCPItk7kSiqcwDkP99ox15e6eRKgDEoD9ebimPk
	cUIbtwEiTm4ze4D+z8uwBOJR1ERMr1w1yxY9nm+BdtQ/m+dzjxOtGgT0lbvOfyzs
	GeQM6Yf7NyaUVvjuFzdQAUdWjBb4PSqUwUSgLTOiiVpaeF8wVKc0znFdb+TnXUig
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc4t8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:49:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H9Yb43025824;
	Fri, 17 Jul 2026 09:49:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgrwpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:49:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H9n6Le21758700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 09:49:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2A5E58043;
	Fri, 17 Jul 2026 09:49:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 226A558055;
	Fri, 17 Jul 2026 09:49:04 +0000 (GMT)
Received: from [9.43.55.154] (unknown [9.43.55.154])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 09:49:03 +0000 (GMT)
Message-ID: <b8bfb51d-81f1-4bfd-b83b-5cd764473718@linux.ibm.com>
Date: Fri, 17 Jul 2026 15:19:02 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme/069: add a test for multipath cdev lifetime
To: John Garry <john.g.garry@oracle.com>, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
        John Garry <john.garry@linux.dev>
References: <20260716082927.4053505-1-john.g.garry@oracle.com>
 <a4f4f444-967f-43a8-becf-465a3007ade8@linux.ibm.com>
 <ae3a2f44-b26d-4040-b9a4-cd6122dca29a@oracle.com>
 <99842431-3ffa-412a-af57-e284888342a7@linux.ibm.com>
 <4a7868c2-a67c-4bfd-bf61-58131a98c97a@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <4a7868c2-a67c-4bfd-bf61-58131a98c97a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a59fa94 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=rQewcHpba3w_WFlePm4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5NiBTYWx0ZWRfX0a2Rlmq4ogIv
 TBwKb1ClBCsjpVgKX66yF3sBQqYF5YtfIfpYWxhADvNSDwPRR4fMhDbq25o+LYYEAprURFf+oiP
 6EGeZ8ZOdyMrqyUFhqDGgjm6Ae0GdHRuGB42Db/A2B3vRqr7Xymh57cXRMKCGoHsqKnWr7kSsSz
 0at5QvsthFsf3BXiZOHAZE5JM4Glg5TXpoJR1SXlxEcm/d9wZeqduDY2eeTY1JZEPFGVFpX6Nlt
 aRtb7E8z0nXV0qHZdhVP17ynxZSBC+gufn5nZvxkTffvhP9Z26Zaj1TLBHvSgw5GC1ZsJWjdlE4
 L7K7ttX++YMNkSLoA0mJEez6PtE3Xr0UbXD8YEVYR/PHexx7IXJhQHIqylZNm2TsQ2ni5j8Z2ey
 GDXAk51/eUpaPcQ9soGXDsD3oxqiM2RQIzTUcnX8CcIfReOmR7jY2TfmRKxqV0SRci+ZWjLrKHc
 ajy36vEBwJ2o2MMWX8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5NiBTYWx0ZWRfX+e8tclNh4Ke3
 pQAHEiyhc80ScB1hnKAVsyUnk4V4VrJIVqUwNlYJbcdFZfl/VGqIjnONJmmwqc3FeRYZNbqWSTw
 KKV39DTDL3nGK3tqOCP9h811VTnv/Rw=
X-Proofpoint-GUID: nx3zChGdrfD9Gh1ql-2iFgXywdFfP7lF
X-Proofpoint-ORIG-GUID: nx3zChGdrfD9Gh1ql-2iFgXywdFfP7lF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170096

On 7/17/26 2:36 PM, John Garry wrote:
> On 17/07/2026 08:00, Nilay Shroff wrote:
>> On 7/16/26 10: 06 PM, John Garry wrote: > On 16/07/2026 16: 16, Nilay Shroff
>> wrote: >>> +    kill(getppid(), SIGUSR2); >>> +    count = 0; >>> +    for (;;)
>> { >>> +        fd1 = open(argv[1], O_RDONLY); >>>
>>
>>
>> On 7/16/26 10:06 PM, John Garry wrote:
>>> On 16/07/2026 16:16, Nilay Shroff wrote:
>>>>> +    kill(getppid(), SIGUSR2);
>>>>> +    count = 0;
>>>>> +    for (;;) {
>>>>> +        fd1 = open(argv[1], O_RDONLY);
>>>>> +        usleep(500000);
>>>>> +        if (fd1 < 0)
>>>>> +            break;
>>>>
>>>> Does it make sense to check for errno set to ENODEV or ENOENT
>>>> before breaking out here?
>>>
>>> ehh, if the errno is not ENODEV or ENOENT, then how to handle? Would it to fail the test due to unexpected errno?
>>
>> I think yes, something like below:
>>
>> for (;;) {
>>            fd1 = open(argv[1], O_RDONLY);
>>            if (fd1 < 0) {
>>                    if (errno == EINTR)
>>                            continue;
>>
>>                    if (errno == ENOENT || errno == ENODEV)
>>                            break;
>>
>>                    perror("open");
> 
> if fd1 < 0, how is it open? Or maybe this message is too vague...
> 
Yes, if fd1 < 0 then it implies errno is non-zero and device is not
opened. Later we evaluate the error code and take necessary
action.

>>                    return EINVAL;
> 
> So are ENOENT, ENODEV, and EINTR the only expected error codes? Others are just unsupported and we fail the test (if and when we get them), right?

Yes. My thinking is that, apart from EINTR, any failure from open() is an error.
For this particular test, we're specifically waiting until the device node
disappears, so ENOENT or ENODEV indicate the expected condition and we can
break out of the loop and issue the ioctl() on the original fd. Any other
errno would be unexpected, so I'd treat it as a test failure by logging the
error and exiting.

Thanks,
--Nilay

