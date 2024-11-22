Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295622081
	for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256960; cv=none; b=XvfyApf+Dszt9+hSoZZZwqT38BWd5UAk3+LPIHonlqcJXqLGBf2F4rFPHNkKjPz4KZ+R5HT+4cYUsfm2TlzZsFZ6nAnqi5+9PR+HDoKk/AHJa7QLiuR+PjZDpcd92U3j+egd9xAMVvV33AlsxBRzHnO+hMxMZ+kNzqnG6pnK7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256960; c=relaxed/simple;
	bh=64peS0qAKFAytmjCddXz3L3iuw+S71l9YBW6QT2WOGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZnPix1cMTcfe7RLj8Jwda5p50rFQ+9DqT7REMSTU4UP2HoNWtxEY6OWE9bSywBtxDdfBeLY19JM2DoBdJcGD/Vw2flgjk6NOfFV1lWpe7UtkTw2kVFtc1bKJAuS4OGb4kWZn++htUV7g04Ttd6IUAAD659nHcVwIe3Fvrvsews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FMwKBhFn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FMwKBhFn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1qLAv029093;
	Fri, 22 Nov 2024 06:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ht3m6s
	XcbBdl5F0tn9MAuTu02EJBxzGRGQC4zcm+lnk=; b=FMwKBhFn716SPdgIMlt1uJ
	yReNCZDdDO6xP1smliVmduVZmggP7sMqGflPy5DjZNDldx1+fHKM/ME4jxcb0kzH
	xENkwDSYYqQFJ5PHSaBiDtHU0J5ukwccCA0LHYEh6hqjale7tP+KGmcTBMvr4jfZ
	ndWHErGoX4lamsbtP5P1RhASdVetYidg8RgVIh7P3c4cDOpmvCm38pC2Wl0ZSfhB
	f4aXn7Fa6xtsHF65Y0jkv5zD5/tzWgCbbpBFZbgu1nnaTRPsBOJYIulrfuGK1zOZ
	iKl33aDI4yhUwARe4W2jJROxZNDZZ/IG8D4UKPAqTSrVY4p8O1IMzmGgsE7xzuHw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtk6y9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 06:29:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM24B8K021788;
	Fri, 22 Nov 2024 06:29:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y6qn2b97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 06:29:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AM6T8TL50594196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 06:29:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7E8458066;
	Fri, 22 Nov 2024 06:29:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C219D5805A;
	Fri, 22 Nov 2024 06:29:05 +0000 (GMT)
Received: from [9.109.198.240] (unknown [9.109.198.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Nov 2024 06:29:05 +0000 (GMT)
Message-ID: <e9923dc4-6ee4-45c2-97dc-2e5f2c686018@linux.ibm.com>
Date: Fri, 22 Nov 2024 11:59:04 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest
 linux-block/for-next
To: Yi Zhang <yi.zhang@redhat.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Maurizio Lombardi <mlombard@redhat.com>
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
 <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com>
 <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
 <9ea5ac64-283c-40e6-a70d-285b81c55c06@linux.ibm.com>
 <CAHj4cs_nbdbzo_Rc+LDp9NS_Ffi1FTmk-9XKw-6TAav9LM4__Q@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs_nbdbzo_Rc+LDp9NS_Ffi1FTmk-9XKw-6TAav9LM4__Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7sPm3TCHMIdmd2H72mX3fBCWLSEayj0H
X-Proofpoint-GUID: 7sPm3TCHMIdmd2H72mX3fBCWLSEayj0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411220052



On 11/22/24 11:08, Yi Zhang wrote:
> On Thu, Nov 21, 2024 at 7:10 PM Nilay Shroff <nilay@linux.ibm.com> wrote:
>>
>>
>>
>> On 11/21/24 08:28, Yi Zhang wrote:
>>> On Wed, Nov 20, 2024 at 10:07 PM Nilay Shroff <nilay@linux.ibm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 11/19/24 16:34, Yi Zhang wrote:
>>>>> Hello
>>>>>
>>>>> CKI recently reported the blktests nvme/029 failed[1] on the
>>>>> linux-block/for-next, and bisect shows it was introduced from [2],
>>>>> please help check it and let me know if you need any info/test for it, thanks.
>>>>>
>>>>> [1]
>>>>> nvme/029 (tr=loop) (test userspace IO via nvme-cli read/write
>>>>> interface) [failed]
>>>>>     runtime    ...  1.568s
>>>>>     --- tests/nvme/029.out 2024-11-19 08:13:41.379272231 +0000
>>>>>     +++ /root/blktests/results/nodev_tr_loop/nvme/029.out.bad
>>>>> 2024-11-19 10:55:13.615939542 +0000
>>>>>     @@ -1,2 +1,8 @@
>>>>>      Running nvme/029
>>>>>     +FAIL
>>>>>     +FAIL
>>>>>     +FAIL
>>>>>     +FAIL
>>>>>     +FAIL
>>>>>     +FAIL
>>>>>     ...
>>>>>     (Run 'diff -u tests/nvme/029.out
>>>>> /root/blktests/results/nodev_tr_loop/nvme/029.out.bad' to see the
>>>>> entire diff)
>>>>> [2]
>>>>> 64a51080eaba (HEAD) nvmet: implement id ns for nvm command set
>>>>>
>>>>>
>>>>> --
>>>>> Best Regards,
>>>>>   Yi Zhang
>>>>>
>>>>>
>>>> I couldn't reproduce it even after running nvme/029 in a loop
>>>> for multiple times. Are you following any specific steps to
>>>> recreate it?
>>>
>>> From the reproduced data[1], seems it only reproduced on x86_64 and
>>> aarch64, and from the 029.full[2], we can see the failure comes from
>>> the "nvme write" cmd.
>>> [1]
>>> https://datawarehouse.cki-project.org/issue/3263
>>> [2]
>>> # cat results/nodev_tr_loop/nvme/029.full
>>> Reference tag larger than allowed by PIF
>>> NQN:blktests-subsystem-1 disconnected 1 controller(s)
>>> disconnected 1 controller(s)
>>>
>>> I also attached the kernel config file in case you want to try it, thanks.
>>>
>> Thanks for the additional information!
>> Now I could understand the issue and have a probable fix. If possible, can you try
>> the below patch and check if it help resolve this issue?
> 
> Yes, the issue was fixed now.
> 
Thank you for trying out the patch! I will send out the formal patch later today with the fix.
>>
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>> index 934b401fbc2f..7a8256ae3085 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -901,12 +901,14 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
>>  static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>>  {
>>         u16 status;
>> +       void *zero_buf;
>>
>>         status = nvmet_req_find_ns(req);
>>         if (status)
>>                 goto out;
>>
>> -       status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
>> +       zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
>> +       status = nvmet_copy_to_sgl(req, 0, zero_buf,
>>                                    NVME_IDENTIFY_DATA_SIZE);
>>  out:
>>         nvmet_req_complete(req, status);
>>
>> Thanks,
>> --Nilay
