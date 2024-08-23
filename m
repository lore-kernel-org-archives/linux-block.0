Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02BF18594A
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420406; cv=none; b=gcg4VOTP5N0ReYTxhSwA3nrnLJOUm/nBv7B4crAr10krI6GwCBTdhgPMdnnGBwqvZ2/Dbgdo0hYmRzz6+M+Z7qgJmomBFz8lgZWtJ8+Bvq1M9BY6tA0oADfjWL5T+L5Za9Ezm+CD72t90sSRBVZXILiLN1s3YjNKZaC8M1c8WUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420406; c=relaxed/simple;
	bh=85tDuC+QL0xG83BFD5xiuZXGJ/NXmqqUWvHW0m2TjSE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kPyTd/xYnfHsfaioeEye0DRBvLbghxBNeqUIpv2puVXRNcGAwInpL8gtaCUqKpS5xJp3x3pjcbMbUbI/rD/3BmU/JvHoAMIkK8uO+Se6G3J+swBUh2d9AZ6Pn/6TkzFsIR6mQaeT6qfJEimi8ftaDT2ahTZtjp99uS/WwhFQ0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i6wtZcH5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i6wtZcH5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N8PjPN011130;
	Fri, 23 Aug 2024 13:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=m
	l8aME6CkcZn0CiUXBYWpDsskLSscE04s646w9nv9sI=; b=i6wtZcH5bHOIZQoRE
	+clsI11dICrWEOJ6P4KggEKbdSpgBHhYgjIJxfUktgqpFacUajxd6mrl7xLcr50V
	GJYd1z3ml8qFLmb0B4lsoswX7t3Ht7P5AIWmYRgGD3BG2JQN5PoVZ5Ln6kdLsWtj
	Q7OwYGrXSQZrDPGa9w8GzLRYQ7WgeODjIUl+LSicuTLRZJNJbgXJrgOnT9OZMuwx
	N+8w0oKpRGBIqnIxUpXvxbjBinK8hzsaDIfTainUQppuo+R1yHwkO512oT3mdBeA
	DjlCoD8uGiUILMxv33wAQBKnZ9XK8bCEPXVJkexRPZfORb/k+I/rtCiKmREAA1Nb
	6IyzA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc547mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:39:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47NBHcdI019050;
	Fri, 23 Aug 2024 13:39:55 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376qa3km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:39:55 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47NDdqR812386912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:39:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2AF658067;
	Fri, 23 Aug 2024 13:39:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8971C58065;
	Fri, 23 Aug 2024 13:39:49 +0000 (GMT)
Received: from [9.171.23.201] (unknown [9.171.23.201])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 13:39:49 +0000 (GMT)
Message-ID: <d3d56275-b88b-4f95-941d-6f4a0d2e2868@linux.ibm.com>
Date: Fri, 23 Aug 2024 19:09:47 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: add test for controller rescan under I/O load
From: Nilay Shroff <nilay@linux.ibm.com>
To: Martin Wilck <martin.wilck@suse.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Martin Wilck <mwilck@suse.com>
References: <20240822193814.106111-1-mwilck@suse.com>
 <20240822193814.106111-3-mwilck@suse.com>
 <9c260acf-48c1-4b4e-8e02-594bff222af3@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <9c260acf-48c1-4b4e-8e02-594bff222af3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 641EkEgyRCZL65KGt3sICMd-kOf1tNZM
X-Proofpoint-GUID: 641EkEgyRCZL65KGt3sICMd-kOf1tNZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230099



On 8/23/24 15:48, Nilay Shroff wrote:
> 
> 
> On 8/23/24 01:08, Martin Wilck wrote:
>> Add a test that repeatedly rescans nvme controllers while doing IO
>> on an nvme namespace connected to these controllers. The purpose
>> of the test is to make sure that no I/O errors or data corruption
>> occurs because of the rescan operations.
>>
>> Signed-off-by: Martin Wilck <mwilck@suse.com>
>> ---
>>  tests/nvme/053 | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/nvme/rc  | 18 ++++++++++++++++
>>  2 files changed, 74 insertions(+)
>>  create mode 100755 tests/nvme/053
>>
>> diff --git a/tests/nvme/053 b/tests/nvme/053
>> new file mode 100755
>> index 0000000..41dc8f2
>> --- /dev/null
>> +++ b/tests/nvme/053
>> @@ -0,0 +1,56 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Martin Wilck, SUSE LLC
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="test controller rescan under I/O load"
>> +TIMED=1
>> +: "${TIMEOUT:=60}"
>> +
>> +rescan_controller() {
>> +	local finish
>> +
>> +	[[ -f "$1/rescan_controller" ]] || {
>> +		echo "cannot rescan $1"
>> +		return 1
>> +	}
>> +
>> +	finish=$(($(date +%s) + TIMEOUT))
>> +	while [[ $(date +%s) -le $finish ]]; do
>> +		# sleep interval between 0.1 and 5s
>> +		usleep "$(((RANDOM%50 + 1)*100000))"
>> +		echo 1 >"$1/rescan_controller"
>> +	done
>> +}
> I think here usleep may not be available by default on all systems.
> For instance, on fedora/rhel I don't have usleep installed in the 
> defualt configuration and so I have to first install it. So you may
> want to add "usleep" as per-requisite for this test. Moreover, after 
> I installed usleep on fedora and ran the above test I see this warning:
> 
> warning: usleep is deprecated, and will be removed in near future!
> 
> Due to above warning the test fails. So is it possible to replace 
> usleep with sleep?
>  
>> +
>> +test_device() {
>> +	local -a ctrls
>> +	local c
>> +
>> +	echo "Running ${TEST_NAME}"
>> +	ctrls=($(_nvme_get_ctrl_list))
>> +
>> +	_run_fio_verify_io --filename="$TEST_DEV" --time_based &> "$FULL" &
>> +
>> +	for c in "${ctrls[@]}"; do
>> +		rescan_controller "$c" &
>> +	done
>> +
>> +	while true; do
>> +		wait -n &>/dev/null
>> +		st=$?
>> +		case $st in
>> +			127)
>> +				break
>> +				;;
>> +			0)
>> +				;;
>> +			*)
>> +				echo "child process exited with $st!"
>> +				;;
>> +		esac
>> +	done
>> +
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index e7d2ab1..93b0571 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -192,6 +192,24 @@ _test_dev_nvme_nsid() {
>>  	cat "${TEST_DEV_SYSFS}/nsid"
>>  }
>>  
>> +_nvme_get_ctrl_list() {
>> +	local subsys
>> +	local c
>> +
>> +	subsys=$(readlink  "${TEST_DEV_SYSFS}/device/subsystem")
>> +	case $subsys in
>> +		*/nvme)
>> +			readlink -f "${TEST_DEV_SYSFS}/device"
>> +			;;
>> +		*/nvme-subsystem)
>> +			for c in "${TEST_DEV_SYSFS}"/device/nvme*; do
>> +				[[ -L "$c" ]] || continue
>> +				[[ -f "$c/dev" ]] && readlink -f "$c"
>> +			done
>> +			;;
>> +	esac
>> +}
>> +
> I don't know if I am missing anything here but just curious to know 
> for which case $subsys would point to link ending in */nvme?
> I think that for all cases $subsys shall point to link which ends 
> in */nvme-subsystem, isn't it? I assume here that $TEST_DEV_SYSFS would 
> always resolve to a nvme block device.
> 
I think I got the answer for the above query, when I disabled the nvme 
multipath in the kernel config, I could see we hit the first case when 
$subsys would point to the link ending in */nvme, so this is not an issue.

> And the last point: I don't see 053.out file in your patchset. Did you forget
> to add this file?
> 
> Thanks,
> --Nilay
> 
> 
> 
> 
> 
