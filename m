Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF42749D1
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745910987; cv=none; b=bzMcbVy+Ff0wm4KhrbQmgVtrZWn9NiYHoyKCKYB2w5IJ4JXlYDGzXqDYzys63UtOhCnsvPwUt9unuRigvLS+9SB8SXMHrRObB6dNXGKr8IYy+44oIHSyenFXy3ITebDHx14/7r1kELHNN7z9kQD6SuY2pGgaE8f99ZkDjQrnRNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745910987; c=relaxed/simple;
	bh=kOzKzvvzdFt5iVkuDhSag7oXVj0Q2NLamVaB148hBTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXiHq8Szcib2lsYPRFa5d6OSGbm9E+1NMnivoQ18J10sv4VdZT1jy28JISUp6vmjXNG/CcDA9IkWWw54kp44dfZDQCNoImx71QA73Qzbx0RO3HOlo1cyibGs5u3zEK7ZY1ZRx7fzKRDncx8jzsbWUXo7/Cu88tiHmpVuyG1bjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e0QjWCjj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e0QjWCjj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4EShX006492;
	Tue, 29 Apr 2025 07:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7aV03G
	QwtdoYoVExI6iFcE8tGIHoJ5rouNEh9AQYfK4=; b=e0QjWCjj8SjrU0luhHqgIn
	/4DkFA+9mLNDhN93lovypz4/ublhcm7UQLVKLQSrqxhTKxj4+C/abBgFJcDQJ6UB
	ThNd9npmXB+oyg4ikenxsIyp1pJr7RCm7pXJmHddL4rHfueP+dKL4Q/qQADduRDi
	/Gey8Ii+4KyNOpWdXVpdLND9r1g4Q2EgS1QiLYTZMkXHHsYIBcLVVtmbSK7tWXqR
	7K0lTQxhh0FMdHSZj72zlr9lEU8vz0eNMOYPWd4xpIEqo/KRo44xtH1JoCSOJ2yx
	QnzNFIRHV9dhkdCn0Vn9lIO0tFzb84vkY35k1o/cWHkwacKjYW2stXwPU+GsSAnw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahs99rms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 07:15:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T53O8f001791;
	Tue, 29 Apr 2025 07:15:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bamj222-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 07:15:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53T7FsUb10551976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 07:15:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 554355805A;
	Tue, 29 Apr 2025 07:15:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA8BD58052;
	Tue, 29 Apr 2025 07:15:50 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 07:15:50 +0000 (GMT)
Message-ID: <b9bb4b91-a4a0-4cbd-85ae-969efffe0951@linux.ibm.com>
Date: Tue, 29 Apr 2025 12:45:49 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 2/3] nvme: introduce multipath_head_always module
 param
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-3-nilay@linux.ibm.com>
 <38a93938-8a9c-4d6a-9f74-af1aa957fd74@suse.de>
 <a33c691a-d4f6-4cd8-96e0-17e2e4078d37@linux.ibm.com>
 <89f3680d-442e-47cc-822e-f00f474dd597@suse.de>
 <cdbd9209-420e-4c1b-a0f4-30b2c7e9cfb3@linux.ibm.com>
 <10ba7fa9-15e9-48b9-a8ac-e7c3982a211c@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <10ba7fa9-15e9-48b9-a8ac-e7c3982a211c@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LuKSymdc c=1 sm=1 tr=0 ts=68107cac cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=suXFO0RFTPWXlh4RyD0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZmxwjD5ODKJdn-BgocbfxI1kII73leZd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA1MiBTYWx0ZWRfX9/POqAjCvvWr hmBZLK6cPmAVT7rALa09TiWMZX6RU5zOhxL8ycnTC8DrAuUQOHq5hJTnwOmCJkEZ7KCt8T1PEX+ smQIeEqQNZO8DG5Ow+pDOKir2WH3ZikWTmj6BgKwckp5kQbujN0qMQuaRcxCUPYxjERo2RMuGuG
 fk7M6qtU3R+4vIHy90zKsN2gZKCSrRO0J2ygv5N1DenrTj/tHQKl44z8PzYmzoSujqR6YqGyGil AWG2RfBm4zkurz/FyKwbTmM0ngnw3SXg5/EMrcYACvd+UInBqhr5ByO3mMBRMBLLzAJYGou1rll 11WYbL3VbZA+0McX1N9MPbKYD1njG3dR8qExf5pMyQGn3BShRj+6lOlrfFCPSCyRmAFkYw2gpTz
 1O+/P/7C7E3kJFO2IosTz+eyOCgKjniKgk3tVGHXHya48OOOExRA0XwyM3hWatw1QAzcXCr4
X-Proofpoint-GUID: ZmxwjD5ODKJdn-BgocbfxI1kII73leZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290052



On 4/29/25 12:31 PM, Hannes Reinecke wrote:
> On 4/29/25 08:24, Nilay Shroff wrote:
>>
>>
>> On 4/29/25 11:19 AM, Hannes Reinecke wrote:
>>> On 4/28/25 09:39, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 4/28/25 12:27 PM, Hannes Reinecke wrote:
>>>>> On 4/25/25 12:33, Nilay Shroff wrote:
>>>>>> Currently, a multipath head disk node is not created for single-ported
>>>>>> NVMe adapters or private namespaces. However, creating a head node in
>>>>>> these cases can help transparently handle transient PCIe link failures.
>>>>>> Without a head node, features like delayed removal cannot be leveraged,
>>>>>> making it difficult to tolerate such link failures. To address this,
>>>>>> this commit introduces nvme_core module parameter multipath_head_always.
>>>>>>
>>>>>> When this param is set to true, it forces the creation of a multipath
>>>>>> head node regardless NVMe disk or namespace type. So this option allows
>>>>>> the use of delayed removal of head node functionality even for single-
>>>>>> ported NVMe disks and private namespaces and thus helps transparently
>>>>>> handling transient PCIe link failures.
>>>>>>
>>>>>> By default multipath_head_always is set to false, thus preserving the
>>>>>> existing behavior. Setting it to true enables improved fault tolerance
>>>>>> in PCIe setups. Moreover, please note that enabling this option would
>>>>>> also implicitly enable nvme_core.multipath.
>>>>>>
>>>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>>>> ---
>>>>>>     drivers/nvme/host/multipath.c | 70 +++++++++++++++++++++++++++++++----
>>>>>>     1 file changed, 63 insertions(+), 7 deletions(-)
>>>>>>
>>>>> I really would model this according to dm-multipath where we have the
>>>>> 'fail_if_no_path' flag.
>>>>> This can be set for PCIe devices to retain the current behaviour
>>>>> (which we need for things like 'md' on top of NVMe) whenever the
>>>>> this flag is set.
>>>>>
>>>> Okay so you meant that when sysfs attribute "delayed_removal_secs"
>>>> under head disk node is _NOT_ configured (or delayed_removal_secs
>>>> is set to zero) we have internal flag "fail_if_no_path" is set to
>>>> true. However in other case when "delayed_removal_secs" is set to
>>>> a non-zero value we set "fail_if_no_path" to false. Is that correct?
>>>>
>>> Don't make it overly complicated.
>>> 'fail_if_no_path' (and the inverse 'queue_if_no_path') can both be
>>> mapped onto delayed_removal_secs; if the value is '0' then the head
>>> disk is immediately removed (the 'fail_if_no_path' case), and if it's
>>> -1 it is never removed (the 'queue_if_no_path' case).
>>>
>> Yes if the value of delayed_removal_secs is 0 then the head is immediately
>> removed, however if value of delayed_removal_secs is anything but zero
>> (i.e. greater than zero as delayed_removal_secs is unsigned) then head
>> is removed only after delayed_removal_secs is elapsed and hence disk
>> couldn't recover from transient link failure. We never pin head node
>> indefinitely.
>>
>>> Question, though: How does it interact with the existing 'ctrl_loss_tmo'? Both describe essentially the same situation...
>>>
>> The delayed_removal_secs is modeled for NVMe PCIe adapter. So it really
>> doesn't interact or interfere with ctrl_loss_tmo which is fabric controller
>> option.
>>
> Not so sure here.
> You _could_ expand the scope for ctrl_loss_tmo to PCI, too;
> as most PCI devices will only ever have one controller 'ctrl_loss_tmo'
> will be identical to 'delayed_removal_secs'.
> 
> So I guess my question is: is there a value for fabrics to control
> the lifetime of struct ns_head independent on the lifetime of the
> controller?
> 
The ctrl_loss_tmo option doesn't actually controls the lifetime of
ns_head. In fact, the ctrl_loss_tmo allows the fabric I/O commands to
fail fast so that I/O commands don't get stuck while host NVMe-oF 
controller is in reconnect state. User may not want to wait longer
while the fabric controller enters into reconnect state when it
loses connection with the target. Typically, the default reconnect
timeout is 10 minutes which is way longer than the expected timeout
of 30 seconds for any I/O command to fail. 
You may find more details in this commit 8c4dfea97f15 ("nvme-fabrics:
reject I/O to offline device") which implements the ctrl_loss_tmo.

Thanks,
--Nilay
