Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117E4A1D
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 06:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776975; cv=none; b=A1tOFEBAfzW43G7pHVFkHZrGDfluzIEQQv2niiKm2PILiX9eLrDdyz8jmTb1I/HMJrXZxpctttah2tQZFTopm8htbB2oTeMehT1Xh+VNdzGWN6oLPXMWtek0GEb9lCKuBpvKp2CTNBW/Lc+f5p9jJNql0xFXrQFlegENq1txIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776975; c=relaxed/simple;
	bh=tgRzNP72zy3s7ubo7bWFkqaXrWpybEPmvBDFnDsTODI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UWEQ0/VDZZNXH2OKblmQd1UqsV9Nyam9ToWuZ14PoLhWSKaaWdiXlxIypptozQdKBqcQkwIAFK2vMDF4wwjnSOtwuTgQmsQAvKPXrRUmVcupSMOm43t51vBEGTBbwDwsVYfMc4QMnAsvsLWEKs2KcYem7e8ZS3t1qLFQk2Umo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AFWI53Df; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AFWI53Df"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J5NsiB025729;
	Wed, 19 Jun 2024 06:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	way1/l4P69aY4mTpwNKMc/Ob2jHq3H+EKszMjO9nRAs=; b=AFWI53DfT7ZLbQCW
	T0BXkvnXSolB4zz2xoSzIGC7iL9wksEGheXy4L1PRO5e3ov/dHw9zega+YFW6tYZ
	9noQ4c5UT7HoTVz/lTbL5PEZqtZ1JCMJa5k1AllS0ylPwVOVihIEgpB0lcBDMEp9
	bdIqfn8oL3kzXTrsRuZW9X7CZmjhuMp+dKysud0CW6wsMTozzxpQeipF1Zra6ywE
	HCDgZdITRYOgR+NjRL2SVO5e1+IopK52eEsP3FMGUtki8WJO5wgheh+sDAbomuxU
	JPyLPwPxpHKxaj07uaI4Iud0b4ckgx5TOq0Pn3VBa3lVbopSE5EUOeNTk310VovT
	ZZdBLw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yus4yr2ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 06:02:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45J56Fgn019506;
	Wed, 19 Jun 2024 06:02:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp19s1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 06:02:31 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45J62SOV19727014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 06:02:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19CAF5806C;
	Wed, 19 Jun 2024 06:02:28 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9D8258060;
	Wed, 19 Jun 2024 06:02:23 +0000 (GMT)
Received: from [9.43.48.107] (unknown [9.43.48.107])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 06:02:23 +0000 (GMT)
Message-ID: <7a535eb9-150d-49c2-8df3-95867d1ff901@linux.ibm.com>
Date: Wed, 19 Jun 2024 11:32:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] loop: add test for creating/deleting file-ns
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, hch <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "venkat88@linux.vnet.ibm.com" <venkat88@linux.vnet.ibm.com>,
        "sachinp@linux.vnet.com" <sachinp@linux.vnet.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20240617092035.2755785-1-nilay@linux.ibm.com>
 <d0f6e41a-4cd3-42b9-865d-df75d3ffd2af@nvidia.com>
 <6jp45jz6ms42ue7eeto4ogjt5c3rdrlzc2bxmxk5myqg4x2hek@bir7rijdnw6c>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <6jp45jz6ms42ue7eeto4ogjt5c3rdrlzc2bxmxk5myqg4x2hek@bir7rijdnw6c>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p-PbqiSZ1NknLERoJpgRV0h0HrdpM24D
X-Proofpoint-ORIG-GUID: p-PbqiSZ1NknLERoJpgRV0h0HrdpM24D
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190041



On 6/18/24 14:58, Shinichiro Kawasaki wrote:
> On Jun 18, 2024 / 01:35, Chaitanya Kulkarni wrote:
>> On 6/17/24 02:17, Nilay Shroff wrote:
>>
>> I think subject line should start with nvme ?
>>
>> nvme: add test for creating/deleting file-ns
>>
>>> This is regression test for commit be647e2c76b2
>>> (nvme: use srcu for iterating namespace list)
>>>
>>> This test uses a regulare file backed loop device
>>> for creating and then deleting an NVMe namespace
>>> in a loop.
>>
>>
>> s/regulare/regular/ ?
>>
>> nit:- commit log looks a bit short :-
>>
>> This is regression test for commit be647e2c76b2
>> (nvme: use srcu for iterating namespace list)
>>
>> This test uses a regulare file backed loop device for creating and
>> then deleting an NVMe namespace in a loop.
>>
>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>> ---
>>> This regression was first reported[1], and now it's
>>> fixed in 6.10-rc4[2]
>>>
>>> [1] https://lore.kernel.org/all/2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com/
>>> [2] commit ff0ffe5b7c3c (nvme: fix namespace removal list)
>>
>> it will be helpful in long run to add above information
>> into the commit log, Shinichiro any thoughts ?
> 
> Agreed. It is helpful to record the kernel side fix commit and the link to the
> discussion threads in the blktests side commit log.
Yeah I am going to updated the commit message with relevant information as suggested
in the next patch.
> 
>>
>>> ---
>>>   tests/nvme/051     | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>>>   tests/nvme/051.out |  2 ++
>>>   2 files changed, 67 insertions(+)
>>>   create mode 100755 tests/nvme/051
>>>   create mode 100644 tests/nvme/051.out
>>>
>>> diff --git a/tests/nvme/051 b/tests/nvme/051
>>> new file mode 100755
>>> index 0000000..0de5c56
>>> --- /dev/null
>>> +++ b/tests/nvme/051
>>> @@ -0,0 +1,65 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-3.0+
>>> +# Copyright (C) 2024 Nilay Shroff(nilay@linux.ibm.com)
>>
>> not sure we need to have email address here as it's a part of
>> commit log anyways ...
>>
>>> +#
>>> +# Regression test for commit be647e2c76b2(nvme: use srcu for iterating
>>> +# namespace list)
> 
> It is also good to enrich this header comment section. Especially, the kernel
> side fix commit will be helpful.
> 
>>> +
>>> +. tests/nvme/rc
>>> +
>>> +DESCRIPTION="Test file-ns creation/deletion under one subsystem"
>>> +
>>> +requires() {
>>> +	_nvme_requires
>>> +	_have_loop
>>> +	_require_nvme_trtype_is_loop
>>> +}
>>> +
>>> +set_conditions() {
>>> +	_set_nvme_trtype "$@"
>>> +}
>>> +
>>> +test() {
>>> +	echo "Running ${TEST_NAME}"
>>> +
>>> +	_setup_nvmet
>>> +
>>> +	local subsys="blktests-subsystem-1"
>>> +	local iterations="${NVME_NUM_ITER}"
>>
>> no need for above var, I think direct use of NVME_NUM_ITER is
>> clear here ...
> 
> I ran this test case on my baremetal test node and QEMU test node using the
> kernel without the fix. On the baremetal test node, the kernel Oops was
> created soon. Good. On the QEMU test node, the Oops was not recreated, and
> the test case passed. For this pass case, it took more than 15 minutes to
> complete the test case. I think the default NVME_NUM_ITER=1000 is too much.
> Can we reduce it to 10 or 20?
> 
I also tested this case on my baremetal machine and I could recreate this crash 
on the first iteration. However I didn't test it on QEMU. But agrees the default 
iteration value of 1000 is too big and I think it's reasonable to make it 20. I 
will change it in the next patch.
>>
>>> +	local loop_dev
>>> +	local port
>>> +
>>> +	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
>>> +
>>> +	loop_dev="$(losetup -f --show "$(_nvme_def_file_path)")"
>>> +
>>> +	port="$(_create_nvmet_port "${nvme_trtype}")"
>>> +
>>> +	_nvmet_target_setup --subsysnqn "${subsys}" --blkdev "${loop_dev}"
>>> +
>>> +	_nvme_connect_subsys --subsysnqn "${subsys}"
>>> +
>>> +	for ((i = 2; i <= iterations; i++)); do {
>>
>> small comment would be useful to explain why are starting at 2 ...
>>
>>> +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
>>> +		_create_nvmet_ns "${subsys}" "${i}" "$(_nvme_def_file_path).$i"
>>> +
>>> +		# allow async request to be processed
>>> +		sleep 1
>>> +
>>> +		_remove_nvmet_ns "${subsys}" "${i}"
>>> +		rm "$(_nvme_def_file_path).$i"
>>> +	}
>>> +	done
>>> +
>>> +	_nvme_disconnect_subsys --subsysnqn "${subsys}" >> "${FULL}" 2>&1
>>> +
>>> +	_nvmet_target_cleanup --subsysnqn "${subsys}" --blkdev "${loop_dev}"
>>> +
>>> +	_remove_nvmet_port "${port}"
>>> +
>>> +	losetup -d "$loop_dev"
>>> +
>>> +	rm "$(_nvme_def_file_path)"
>>> +
>>> +	echo "Test complete"
>>> +}
>>> diff --git a/tests/nvme/051.out b/tests/nvme/051.out
>>> new file mode 100644
>>> index 0000000..156f068
>>> --- /dev/null
>>> +++ b/tests/nvme/051.out
>>> @@ -0,0 +1,2 @@
>>> +Running nvme/051
>>> +Test complete
>>
>> thanks for the test, I think this is much needed test especially with
>> recent reported issues ...
> 
> I also appreciate this patch. Thanks!
> 
> One more request, recent commit added a test case to the nvme group and it has
> the number nvme/051. Could you renumber this test case to nvme/052?

Yes I will rebase my tree to the latest and update the test case to nvme/052.

And thank you for testing my test case on your machine and your review comments!
Much appreciated.... 

I will soon post the patch v2.

Thanks,
--Nilay
