Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3664184F
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955165; cv=none; b=kIoyJxzc2j3+x1NOXtIIgvnqbNhsH7Ic4AT6zfPNMneD9OZ4N+ZYBnIOjBWDmhyaFZ/33LWMZi9wPWRHeb1J+htoHlaugApU2wh6RtXux45cE/AgGZsOLpBy4wi6QWOsnSuxlw+ZKwzfqGj/Iw0IV9WiDR32ceQ6yYA4iGv9XLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955165; c=relaxed/simple;
	bh=nVyY9hHsRl46sxkTWpGuP1a7hNr9XgzCvBLMAztf+fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jU6qzq6eX34Q9QRYyvRPv33kIYUipgAj3t4UCIRVqP+uOjvqvSVILMtOdc08jukK3BtukAPbAm7je6lu4kRSVhET9DS22FyHclHoIMJ530/NOqmDKZ2JOaWGPlsqxBJjfFHBik/ZbSuE5V0/1ifhQA4aXeBp/VBxuDdCFs6iWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qnLj3Zqp; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qnLj3Zqp"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728955160; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qlcCM9c/L9Ltc/2G/77Td84iubHBB5fkLEkKeDJVhFE=;
	b=qnLj3Zqp9jIGGmaZaYeOM4yUoqsMdsjtfUUs+OTvZ2NLGHcjVZbgcVENeJ4+fShzEGjma3PeW6SrJ5Xg1qSZO5R0Qt6pjSjuk4ECwGP2eFklP0tu4/MZapxcWPVBUKacBDnTfKhB/sIb8T17/+gdXimR4HW4HFe1umwO57QWsdo=
Received: from 30.178.81.198(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHBCQb7_1728955158 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 09:19:19 +0800
Message-ID: <9a14bfe8-320b-468c-aba1-4c57e35fb3da@linux.alibaba.com>
Date: Tue, 15 Oct 2024 09:19:17 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH blktests v4 2/2] nvme: test the nvme reservation feature
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20241014090116.125500-1-kanie@linux.alibaba.com>
 <20241014090116.125500-3-kanie@linux.alibaba.com>
 <a34131bd-3ff8-4531-9131-1dc35843fb36@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <a34131bd-3ff8-4531-9131-1dc35843fb36@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/10/14 19:44, Daniel Wagner 写道:
> On Mon, Oct 14, 2024 at 05:01:16PM GMT, Guixin Liu wrote:
>> +resv_report() {
>> +	local test_dev=$1
>> +	local report_arg=$2
>> +
>> +	nvme resv-report "${test_dev}" "${report_arg}" | grep -v "hostid" | \
>> +		grep -E "gen|rtype|regctl|regctlext|cntlid|rcsts|rkey"
> okay, let's see how this goes.
>
>> +test_resv() {
>> +	local nvmedev=$1
>> +	local report_arg="--cdw11=1"
>> +	test_dev="/dev/${nvmedev}n1"
> Please use the namespace lookup helper and don't hardcode the namespace
> id.
>
OK, changed in v5, thanks.

Best Regards,

Guixin Liu

>> +
>> +	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
>> +		report_arg="--eds"
>> +	fi
>> +
>> +	echo "Register"
>> +	resv_report "${test_dev}" "${report_arg}"
>> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Replace"
>> +	nvme resv-register "${test_dev}" --crkey=4 --nrkey=5 --rrega=2
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Unregister"
>> +	nvme resv-register "${test_dev}" --crkey=5 --rrega=1
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Acquire"
>> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Preempt"
>> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=2 --racqa=1
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Release"
>> +	nvme resv-release "${test_dev}" --crkey=4 --rtype=2 --rrela=0
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Clear"
>> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
>> +	resv_report "${test_dev}" "${report_arg}"
>> +	nvme resv-release "${test_dev}" --crkey=4 --rrela=1
>> +}
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	_setup_nvmet
>> +
>> +	local nvmedev
>> +	local skipped=false
>> +	local subsys_path=""
>> +	local ns_path=""
>> +
>> +	_nvmet_target_setup --blkdev file --resv_enable
>> +	subsys_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
>> +	ns_path="${subsys_path}/namespaces/1"
> Again here, it's better not to hardcode the nsid.
