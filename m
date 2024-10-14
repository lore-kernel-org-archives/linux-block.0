Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725F1487D6
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894861; cv=none; b=Au4JbCoQkpJBhsT3jOl1mAb/HECr4jEsiXnWk6NFUWmeRqTJQi5i9Xd8TcpNYcvGmYvdKzXudidGlJX9sWs0ZhFIxEpHkrDJvx8cHxVSXAcv9HgQi4gEUnE9EoyV8dB38EXDZLp//Cxn7ljsyyT5eA7aCOV2m7/V0k5TZzkzqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894861; c=relaxed/simple;
	bh=sjwFt+D6aNELegNe3XomwGZpvF4BkxGE64lh855YL4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kd3cDwd29K/W20WYOjewKgb7pQRPccpMYhvCfFKxWdvtEdu2Qk+QaXbCEizOn8krUkwnoeWBgQgx6e5kYZQfX2DAOnTladbFoV2pk3TieF4eJz8ZiUnZ8MbaSWAHWHDq6ovyjlnxd5zu0WedR2RZmqd+QgEnt8HSrqu5VfI/u+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GGG6KeOF; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GGG6KeOF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728894850; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nU/qU2kG8hi5utisxU99hecTxyvs2URAxnwqBBRt48M=;
	b=GGG6KeOFyCyyk0zInUdYsjPkVrPMtawDUKptkHQNcgqDyqpGGm4dF+Soq0izk6V1vVGEv/oMSOukVNG6hqVYUZmn5DYLGYQhgEBV/UbEdlNT0YINVDKEua+k8KyL+RsCQtblJ8AnVuDpN4BFk4QzciJECoY6D5LiAetFKYSGMak=
Received: from 30.178.81.252(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH3msgf_1728894848 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 16:34:09 +0800
Message-ID: <2091bf64-12d7-480f-acc7-55bca77fbf3e@linux.alibaba.com>
Date: Mon, 14 Oct 2024 16:34:08 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH blktests v3 2/2] nvme: test the nvme reservation feature
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
 "dwagner@suse.de" <dwagner@suse.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
 <20241012111157.44368-3-kanie@linux.alibaba.com>
 <6e1e4df5-ccee-4a92-80ac-64976a526003@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <6e1e4df5-ccee-4a92-80ac-64976a526003@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/10/14 14:43, Chaitanya Kulkarni 写道:
> On 10/12/24 04:11, Guixin Liu wrote:
>> Test the NVMe reservation feature, including register, acquire,
>> release and report.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>    tests/nvme/054     |  99 +++++++++++++++++++++++++++++++++++++++++
>>    tests/nvme/054.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
>>    2 files changed, 207 insertions(+)
>>    create mode 100644 tests/nvme/054
>>    create mode 100644 tests/nvme/054.out
>>
>> diff --git a/tests/nvme/054 b/tests/nvme/054
>> new file mode 100644
>> index 0000000..f352c73
>> --- /dev/null
>> +++ b/tests/nvme/054
>> @@ -0,0 +1,99 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Guixin Liu
>> +# Copyright (C) 2024 Alibaba Group.
>> +#
>> +# Test the NVMe reservation feature
>> +#
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="Test the NVMe reservation feature"
>> +QUICK=1
>> +nvme_trtype="loop"
>> +
>> +requires() {
>> +	_nvme_requires
>> +}
>> +
>> +resv_report() {
>> +	local nvmedev=$1
>> +	local report_arg=$2
>> +
>> +	nvme resv-report "/dev/${nvmedev}n1" "${report_arg}" | grep -v "hostid"
>> +}
>> +
>> +test_resv() {
>> +	local nvmedev=$1
>> +	local report_arg="--cdw11=1"
>> +
>> +	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
>> +		report_arg="--eds"
>> +	fi
>> +
>> +	echo "Register"
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Replace"
>> +	nvme resv-register "/dev/${nvmedev}n1" --crkey=4 --nrkey=5 --rrega=2
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Unregister"
>> +	nvme resv-register "/dev/${nvmedev}n1" --crkey=5 --rrega=1
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Acquire"
>> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
>> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Preempt"
>> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --racqa=1
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Release"
>> +	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --rrela=0
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Clear"
>> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
>> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rrela=1
>> +}
>> +
>> +
> make it easier to debug totally untested :-
>
> test_resv() {
>           local nvmedev=$1
>           local report_arg="--cdw11=1"
>           test_dev="/dev/${nvmedev}n1"
>
>           if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
>                   report_arg="--eds"
>           fi
>
>           echo "Register"
>           resv_report "${nvmedev}" "${report_arg}"
>           nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Replace"
>           nvme resv-register "${test_dev}" --crkey=4 --nrkey=5 --rrega=2
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Unregister"
>           nvme resv-register "${test_dev}" --crkey=5 --rrega=1
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Acquire"
>           nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>           nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Preempt"
>           nvme resv-acquire "${test_dev}" --crkey=4 --rtype=2 --racqa=1
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Release"
>           nvme resv-release "${test_dev}" --crkey=4 --rtype=2 --rrela=0
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Clear"
>           nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>           nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
>           resv_report "${nvmedev}" "${report_arg}"
>           nvme resv-release "${test_dev}" --crkey=4 --rrela=1
> }
>
Thanks, changed in v4, and also change resv_report()'s firt param to

test_dev instead of nvmedev.

Best Regards,

Guixin Liu

> irrespective of that looks good :-
>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>
> -ck
>
>
