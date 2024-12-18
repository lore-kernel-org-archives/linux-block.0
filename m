Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED51B0422
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734525523; cv=none; b=rd5ied3H38bxsdXo41hA97uVbWDV6cnOW/voz4AHcnLGP9sacK2RP4POaB960mi80vfsfw51gmyMQoOCJG1ersWtoKR2jx6Q23F2WlzjFOZ1FjMry2WX3gI7l8SlGaA/sj5QXfdQWZC3IxKd9dcv/CtsvPTDqz14XZuEEiBC534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734525523; c=relaxed/simple;
	bh=pEbRiltQ1IxFTE8ZvlUnQgJKtylb0CUfXrii+QVYhKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2a/2Q8yXsdi20EU8cEhio4Kp2XyJM1YWI3XK2BrDP11T275NWZMgH0RGDboNm0+xBmCrsy/+fyRA5FufmqY+IVG3A354QK5IzZryu4laMpiyIAcxNyXMkOz2E7+NgPrJw6pE8073kHQx3SQBx0Kf+Oahp7/QJYtFM2XpEUfBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dLz3PK1L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLz3PK1L"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIBixdn020991;
	Wed, 18 Dec 2024 12:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zIDnCL
	4Ob+G6awuT8JPYHDatEOsbTCUFYi5ZZ3C+wkQ=; b=dLz3PK1L6WSvkRo8GPhqnK
	TI+49BQfq1rSHji71zk/0xPvHl80lfQzgxCB5wKOjp+KXd04eXbXF5nvWIO0MUPp
	hXl1P/0wEWNv4V2p7VB3qvCfugnHP+OvSN4AczVTe9LxmVIFvcwDU9eTLv8IBHKW
	8uxbCBtmUOHmBAOdHk9o/O+fpvR8NE1xQOc5G7UAlTYP9fKYIdTg0ydOAOHRrL6C
	KUOxVaf86xe/PJUOqmsOnz4DiXBKNDDTVo1W6PEC7crBEfetXlSU/Fh8OxJJS5Iv
	c0autHZ7NiStzA5TxihDuCYybCxHoWzvj/VbvPAn39mg7UuHGw/0FpjKKpY6EneA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kas4wcu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 12:38:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI9ClhD024015;
	Wed, 18 Dec 2024 12:38:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnukfqk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 12:38:26 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BICcPh129753878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 12:38:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFC3258043;
	Wed, 18 Dec 2024 12:38:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBCE058055;
	Wed, 18 Dec 2024 12:38:23 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 12:38:23 +0000 (GMT)
Message-ID: <41dfcc42-bf25-494e-9ec9-e22bd5e38ef0@linux.ibm.com>
Date: Wed, 18 Dec 2024 18:08:22 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/2] throtl: fix the race between submitting IO
 and setting cgroup.procs
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "yukuai (C)"
 <yukuai3@huawei.com>, Gregory Joyce <gjoyce@ibm.com>
References: <20241217131440.1980151-1-nilay@linux.ibm.com>
 <20241217131440.1980151-3-nilay@linux.ibm.com>
 <d2b28360-259a-8938-47eb-b14b5b4df754@huaweicloud.com>
 <1cf36d9b-235e-4747-9c1d-ba2363800369@linux.ibm.com>
 <w4x77ozo6sf6g237mpifsgev76kwj3cyuscx4byircemr3zohs@mcqmfvkbqyrg>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <w4x77ozo6sf6g237mpifsgev76kwj3cyuscx4byircemr3zohs@mcqmfvkbqyrg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XHv09X0DAeAyRttZXHD9TvUALiHIffKi
X-Proofpoint-GUID: XHv09X0DAeAyRttZXHD9TvUALiHIffKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180101



On 12/18/24 17:12, Shinichiro Kawasaki wrote:
> On Dec 18, 2024 / 15:20, Nilay Shroff wrote:
>>
>>
>> On 12/18/24 07:54, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2024/12/17 21:14, Nilay Shroff 写道:
>>>> This commit helps fix the above race condition by touching a temp file. The
>>>> the existence of the temp file is then polled by the background process at
>>>> regular interval. Until the temp file is created, the background process
>>>> would not forward progress and starts submitting IO and from the main
>>>> thread we'd touch temp file only after we write PID of the background
>>>> process into cgroup.procs.
>>>
>>> It's right sleep 0.1 is not appropriate here, and this can work.
>>> However, I think reading cgroup.procs directly is better, something
>>> like following:
>>>
>>>  _throtl_test_io() {
>>> -       local pid
>>> +       local pid="none"
>>>
>>>         {
>>>                 local rw=$1
>>>                 local bs=$2
>>>                 local count=$3
>>>
>>> -               sleep 0.1
>>> +               while ! cat $CGROUP2_DIR/$THROTL_DIR/cgroup.procs | grep $pid; do
>>> +                       sleep 0.1
>>>                 _throtl_issue_io "$rw" "$bs" "$count"
>>>         } &
>>
>> Thank you for your review and suggestion!
>>
>> However, IMO this may not work always because the issue here's that the @pid is local 
>> variable and when the shell starts the background job/process, typically, all local 
>> variables are copied to the new job. Henceforth, any update made to @pid in the parent 
>> shell would not be visible to the background job. 
>> I think, for IPC between parent shell and background job, we may use temp file,
>> named pipe or signals. As file is the easiest and simplest mechanism, for this 
>> simple test I preferred using file. 
> 
> How about to refer to $BASHPID in the background job sub-shell? It shows the PID
> of the background job, so we don't need IPC to pass the PID.
> 
> I think the hunk like below can do the trick, hopefully. If it works, it would
> be cleaner to factor out the while loop to a helper function, like
> _throtl_wait_for_cgroup_procs() or something.
> 
> 
> diff --git a/tests/throtl/004 b/tests/throtl/004
> index 6e28612..0a16764 100755
> --- a/tests/throtl/004
> +++ b/tests/throtl/004
> @@ -22,6 +22,10 @@ test() {
> 
>         {
>                 sleep 0.1
> +               while ! grep --quiet --word-regexp "$BASHPID" \
> +                       "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"; do
> +                       sleep 0.1
> +               done
>                 _throtl_issue_io write 10M 1
>         } &

I like the idea of using $BASHPID. I just tried it and it works!!

In fact, I have now further simplified the logic such that we don't need
IPC between parent and child sub-shell:) Please find below the diff:

diff --git a/tests/throtl/004 b/tests/throtl/004
index 44b33ec..d1461b9 100755
--- a/tests/throtl/004
+++ b/tests/throtl/004
@@ -21,22 +21,13 @@ test() {
        _throtl_set_limits wbps=$((1024 * 1024))
 
        {
-                while true; do
-                        if [[ -e "$TMPDIR/test-io" ]]; then
-                                break
-                        fi
-                        sleep 0.1
-                done
+               echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
                _throtl_issue_io write 10M 1
        } &
 
-       local pid=$!
-       echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
-       touch "$TMPDIR/test-io"
-
        sleep 0.6
        echo 0 > "/sys/kernel/config/nullb/$THROTL_DEV/power"
-       wait "$pid"
+       wait $!


As shown above, we could now directly write the PID of the background 
job into the cgroup.procs and submit IO. So we don't require IPC between 
parent and child sub-shell. 

I'd spin a new patch with the above change and submit.

Thanks,
--Nilay
