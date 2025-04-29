Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24C7405A
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907921; cv=none; b=ahVBLtDXkEXlWWUeg9ZXS127mXHZ7UVPc+HLJOjZkmE2IUYbUkm//GF3CPGhAyUhecRMbOjlTFWwGBgm36IeFWsANeGcvRTrRlmwsCGKb2hFA3JY2H/oHpArLzyvYeAFEuZob8w2dnn6V0TKUyB4UKeHs/8vjSgqjHdX0XhLK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907921; c=relaxed/simple;
	bh=bKcNvkurb0C53xVtt7pncvlCwYNwPh2zE66ifzcQoik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4Fqe4eRIxpctpfD24lIvAFXnbOTPFnHFGYLGjhNkfvDipIPCE1TPkZEFgskyBMMjwTKWhmrADobMN7FR4wkgNY7vQoAmjvyfrqa0BIDBn7WtFUUZyN/vWjSLvR6IHaH0WXL5WASmF3V9If28s8n4UAbxz3EqhHn5fF/gRZcRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V7iFANtx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V7iFANtx"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4EOjP015214;
	Tue, 29 Apr 2025 06:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tndWkq
	H9+u9g4zJKS7PWKHzNDZe1A2u9eX1ScL08R7w=; b=V7iFANtxuLYX17/8Fjv6zR
	ZX20cKuNIfn0SH7Go1zNF66mShRYTVT8T7LiL3huuIaIE9GO2u8PS7Vu+H6NtA5A
	paalLbR5wiHpN9TkLCZV9Fz4GuY+HlHMVxAEBYVvmMnmbZSiGZ7srCgcJHjPzAMs
	y0ZSsVW4jvP0fcbYtQsNhytj+aJy9mGYvkcy5gpZF9Itf4vzQJD44xYCTUKJqKNx
	4RQM8dxqCVGXB1cQeQkk1X7XDhlC3W5e1/LECNqIq1awDVPpJFrEx+f2JAPM7Mrd
	vPyOea4Oyd4mIJoZVwCt6+efFcO7n5sAiVDZwBBfAqAihUFNuaHMXpvHHHZAuOeQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46a7kk4n8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 06:24:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T3nPdp031617;
	Tue, 29 Apr 2025 06:24:56 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4699tu24b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 06:24:56 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53T6OtiQ29622950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 06:24:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C6125805E;
	Tue, 29 Apr 2025 06:24:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7363358062;
	Tue, 29 Apr 2025 06:24:52 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 06:24:52 +0000 (GMT)
Message-ID: <cdbd9209-420e-4c1b-a0f4-30b2c7e9cfb3@linux.ibm.com>
Date: Tue, 29 Apr 2025 11:54:50 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <89f3680d-442e-47cc-822e-f00f474dd597@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OYSYDgTY c=1 sm=1 tr=0 ts=681070b9 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=d1kF6yshcwiWocLH8UsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nDqAAM4u93ES7YrUxDpiNRyskpLZeipq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA0NSBTYWx0ZWRfX94ByyJ0k5SZ0 442ix56FoLz/myUlg/UhZUlPRiSaqXp1Wp9xUdBMgshv2hr03ADiVEUeOVsHBAHe50zZ7LvakZV tEzzXrFvXAAarhpId2aASyl9VqQLI6A6yxa+YrGKuqCLoX0Dz/BzwCn9DQnL45nfLHZHcTWcmjU
 mjCynqQ7ibfnFVCKay/n+TCWF6uBri3Ldd2JfrBGTgkukLXDoRpFxqbHVjeftvJFkOdYzaM2XKG tptX4KKbOolBXfB7PKCDiWhj6vRRxoSVcrmtH3fG1bYbFxprOOxsWhBSDnrWBqIUL3NDB9AI2Zh I87T8ABgPx4v8aTOSci1Jt+CoeGKUu3hplVSlJRy/WpheKUlXLZRE1nfxGl0Rosz6L37WAJGGL3
 U3JeXQK51BortwufZgmnSnHR7luigSWxW/09TLruxyY6teCk/Tcbcu6sGghDrL+ifSoddJVq
X-Proofpoint-ORIG-GUID: nDqAAM4u93ES7YrUxDpiNRyskpLZeipq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290045



On 4/29/25 11:19 AM, Hannes Reinecke wrote:
> On 4/28/25 09:39, Nilay Shroff wrote:
>>
>>
>> On 4/28/25 12:27 PM, Hannes Reinecke wrote:
>>> On 4/25/25 12:33, Nilay Shroff wrote:
>>>> Currently, a multipath head disk node is not created for single-ported
>>>> NVMe adapters or private namespaces. However, creating a head node in
>>>> these cases can help transparently handle transient PCIe link failures.
>>>> Without a head node, features like delayed removal cannot be leveraged,
>>>> making it difficult to tolerate such link failures. To address this,
>>>> this commit introduces nvme_core module parameter multipath_head_always.
>>>>
>>>> When this param is set to true, it forces the creation of a multipath
>>>> head node regardless NVMe disk or namespace type. So this option allows
>>>> the use of delayed removal of head node functionality even for single-
>>>> ported NVMe disks and private namespaces and thus helps transparently
>>>> handling transient PCIe link failures.
>>>>
>>>> By default multipath_head_always is set to false, thus preserving the
>>>> existing behavior. Setting it to true enables improved fault tolerance
>>>> in PCIe setups. Moreover, please note that enabling this option would
>>>> also implicitly enable nvme_core.multipath.
>>>>
>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>> ---
>>>>    drivers/nvme/host/multipath.c | 70 +++++++++++++++++++++++++++++++----
>>>>    1 file changed, 63 insertions(+), 7 deletions(-)
>>>>
>>> I really would model this according to dm-multipath where we have the
>>> 'fail_if_no_path' flag.
>>> This can be set for PCIe devices to retain the current behaviour
>>> (which we need for things like 'md' on top of NVMe) whenever the
>>> this flag is set.
>>>
>> Okay so you meant that when sysfs attribute "delayed_removal_secs"
>> under head disk node is _NOT_ configured (or delayed_removal_secs
>> is set to zero) we have internal flag "fail_if_no_path" is set to
>> true. However in other case when "delayed_removal_secs" is set to
>> a non-zero value we set "fail_if_no_path" to false. Is that correct?
>>
> Don't make it overly complicated.
> 'fail_if_no_path' (and the inverse 'queue_if_no_path') can both be
> mapped onto delayed_removal_secs; if the value is '0' then the head
> disk is immediately removed (the 'fail_if_no_path' case), and if it's
> -1 it is never removed (the 'queue_if_no_path' case).
> 
Yes if the value of delayed_removal_secs is 0 then the head is immediately
removed, however if value of delayed_removal_secs is anything but zero 
(i.e. greater than zero as delayed_removal_secs is unsigned) then head 
is removed only after delayed_removal_secs is elapsed and hence disk 
couldn't recover from transient link failure. We never pin head node 
indefinitely.  

> Question, though: How does it interact with the existing 'ctrl_loss_tmo'? Both describe essentially the same situation...
> 
The delayed_removal_secs is modeled for NVMe PCIe adapter. So it really
doesn't interact or interfere with ctrl_loss_tmo which is fabric controller
option.

Thanks,
--Nilay

