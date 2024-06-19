Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416757C9F
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776541; cv=none; b=Frgpm3W2/eA1stimWFhifpk21OuPfNsjqFUUiMvtBxvAoGIpLn+As8YL66zzjTym1u8t1q3W4zbVXzns1O5wSFWP/3AwmYnJzLs3ZMAvsBpu1C2/0k/x9zV8gFdZEkfgpMwEdVeS4t7Ldob+Qm6Ke6FCQGDq+iwtZdKwRb5WCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776541; c=relaxed/simple;
	bh=9LKiJhAER8IyUkMaYL5UU33jlsUXRB9uNIa4LXzcIpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cLTClDqurnrhFRiEUEyI8c7wHZdC/tZ7MwCNlo3dVekXnvU6dRLfF6uCp1L2VMv7m5G6mau7tQmUxfcxQ79yRF8vUpxKOyv/WxhxBMPeQpLY771Vne4EV62dCdUBTxMdmRsAbBRswnlOLauuTRxCG2zgkBrWmoioZztTr7jMdGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pLuJuqRj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pLuJuqRj"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J5e2qZ017729;
	Wed, 19 Jun 2024 05:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	aWLpJvKPFMLuZkTndck8JEqEtdHEJz2quZwro6g7Nrw=; b=pLuJuqRjOp8vXWR/
	g3TvhDaq7Y9eYvqfhIDII+62b3WDBxMPULisDZPAvekd9PYSOqH4UUDlgXgzc3Nq
	NjQS+MXcFdFph/ZkmODuXo7azxSq12o9FYgiixZbdTzKOmcvYAaW87xek2I3IBE+
	AsvPiVqdhTN3M/w+0HpRoG/MPreaTaj6xHC3COKq/qmwey7ZepHSlRChfpb/GtpU
	VciDe0gXsV7VtdncSTD0RqVqE7rrZMXqlKGgO+h18jJw2UOqDCMPWALzfEY0SvFu
	Kly9IWZmsHjMnwWueeA+NLxuZLGVMSn5EF7yipkcBW6u2356uYi/Y6ho9hj5zTBx
	+/wfMg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yuscf00rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 05:55:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45J5iKPm023957;
	Wed, 19 Jun 2024 05:53:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9q9j0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 05:53:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45J5rV3m17891944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 05:53:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A15258059;
	Wed, 19 Jun 2024 05:53:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 322B65806C;
	Wed, 19 Jun 2024 05:53:27 +0000 (GMT)
Received: from [9.43.48.107] (unknown [9.43.48.107])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 05:53:26 +0000 (GMT)
Message-ID: <33d8ab45-6fa5-4868-8e34-e31fbda04e24@linux.ibm.com>
Date: Wed, 19 Jun 2024 11:23:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] loop: add test for creating/deleting file-ns
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "venkat88@linux.vnet.ibm.com" <venkat88@linux.vnet.ibm.com>,
        "sachinp@linux.vnet.com" <sachinp@linux.vnet.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20240617092035.2755785-1-nilay@linux.ibm.com>
 <d0f6e41a-4cd3-42b9-865d-df75d3ffd2af@nvidia.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d0f6e41a-4cd3-42b9-865d-df75d3ffd2af@nvidia.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ftetkdtu4sPRrUrLrseZBJgki7y1rWjc
X-Proofpoint-GUID: Ftetkdtu4sPRrUrLrseZBJgki7y1rWjc
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190041



On 6/18/24 07:05, Chaitanya Kulkarni wrote:
> On 6/17/24 02:17, Nilay Shroff wrote:
> 
> I think subject line should start with nvme ?
> 
> nvme: add test for creating/deleting file-ns
Ok will do.

> 
>> This is regression test for commit be647e2c76b2
>> (nvme: use srcu for iterating namespace list)
>>
>> This test uses a regulare file backed loop device
>> for creating and then deleting an NVMe namespace
>> in a loop.
> 
> 
> s/regulare/regular/ ?
yes will correct the spelling.
> 
> nit:- commit log looks a bit short :-
> 
> This is regression test for commit be647e2c76b2
> (nvme: use srcu for iterating namespace list)
> 
> This test uses a regulare file backed loop device for creating and
> then deleting an NVMe namespace in a loop.
> 
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>> This regression was first reported[1], and now it's
>> fixed in 6.10-rc4[2]
>>
>> [1] https://lore.kernel.org/all/2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com/
>> [2] commit ff0ffe5b7c3c (nvme: fix namespace removal list)
> 
> it will be helpful in long run to add above information
> into the commit log, Shinichiro any thoughts ?
> 
yes I will add more information in the commit log.
>> ---
>>   tests/nvme/051     | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/051.out |  2 ++
>>   2 files changed, 67 insertions(+)
>>   create mode 100755 tests/nvme/051
>>   create mode 100644 tests/nvme/051.out
>>
>> diff --git a/tests/nvme/051 b/tests/nvme/051
>> new file mode 100755
>> index 0000000..0de5c56
>> --- /dev/null
>> +++ b/tests/nvme/051
>> @@ -0,0 +1,65 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Nilay Shroff(nilay@linux.ibm.com)
> 
> not sure we need to have email address here as it's a part of
> commit log anyways ...
> 
I saw in some test cases email address was added and so I also 
included mine. But anyways, I will remove the email address as 
you suggested.
>> +#
>> +# Regression test for commit be647e2c76b2(nvme: use srcu for iterating
>> +# namespace list)
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="Test file-ns creation/deletion under one subsystem"
>> +
>> +requires() {
>> +	_nvme_requires
>> +	_have_loop
>> +	_require_nvme_trtype_is_loop
>> +}
>> +
>> +set_conditions() {
>> +	_set_nvme_trtype "$@"
>> +}
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	_setup_nvmet
>> +
>> +	local subsys="blktests-subsystem-1"
>> +	local iterations="${NVME_NUM_ITER}"
> 
> no need for above var, I think direct use of NVME_NUM_ITER is
> clear here ...
Alright, accepted. 
> 
>> +	local loop_dev
>> +	local port
>> +
>> +	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
>> +
>> +	loop_dev="$(losetup -f --show "$(_nvme_def_file_path)")"
>> +
>> +	port="$(_create_nvmet_port "${nvme_trtype}")"
>> +
>> +	_nvmet_target_setup --subsysnqn "${subsys}" --blkdev "${loop_dev}"
>> +
>> +	_nvme_connect_subsys --subsysnqn "${subsys}"
>> +
>> +	for ((i = 2; i <= iterations; i++)); do {
> 
> small comment would be useful to explain why are starting at 2 ...
Yes I will add the relevant comment.
> 
>> +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
>> +		_create_nvmet_ns "${subsys}" "${i}" "$(_nvme_def_file_path).$i"
>> +
>> +		# allow async request to be processed
>> +		sleep 1
>> +
>> +		_remove_nvmet_ns "${subsys}" "${i}"
>> +		rm "$(_nvme_def_file_path).$i"
>> +	}
>> +	done
>> +
>> +	_nvme_disconnect_subsys --subsysnqn "${subsys}" >> "${FULL}" 2>&1
>> +
>> +	_nvmet_target_cleanup --subsysnqn "${subsys}" --blkdev "${loop_dev}"
>> +
>> +	_remove_nvmet_port "${port}"
>> +
>> +	losetup -d "$loop_dev"
>> +
>> +	rm "$(_nvme_def_file_path)"
>> +
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/nvme/051.out b/tests/nvme/051.out
>> new file mode 100644
>> index 0000000..156f068
>> --- /dev/null
>> +++ b/tests/nvme/051.out
>> @@ -0,0 +1,2 @@
>> +Running nvme/051
>> +Test complete
> 
> thanks for the test, I think this is much needed test especially with
> recent reported issues ...
> 
Thank you for your review and comments! Much appreciated...
I will send v2 with above comments incorporated.

Thanks,
--Nilay
