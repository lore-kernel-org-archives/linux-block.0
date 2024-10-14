Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31E1153812
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895410; cv=none; b=DohxVbQhpuVteyQmGtd3cWjsXIbI6YufmwddSEQh1sPfFMqoWVpLjJ/MuHHyadg/3Mw/4V9hm7gO7LKIignKLlJ+VecagP76cT8aP4pTg0A/ttp6CwyvJnx4m+WE0HOggGRLSsQwmfK0sDZP0tX6tHBiPmBixDIx6w3WwkE1BEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895410; c=relaxed/simple;
	bh=kAUb7QD13WNfvqEHR8qiq/cr7cPliVb+BdN9aSE3d8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEY2klXkA3XblewqUsFiU7gC/cEs9NbBvJGrFdxDA/NXQqiqOumvZD7LGuucEQcY4Dhchj7RObz+LwEhs8lHY6uav5ZCUQicvMldE+rYuwuH+cZEqnipE92OfYnJUND1rADKKSZi+LlS99NOyvjeKwzc31PWzVVMt/kQjHXzSjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c5D2Y+mO; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c5D2Y+mO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728895406; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pk/cIx4lL+V3Pcxsjkos1iArKVqfXGKQPEaz9DMkrCQ=;
	b=c5D2Y+mOi5qF0JW8Hk/CWpIvK2reXrZgiNyb2p+iQNam/yOofeb+LHrpSaBkUwOQXEyExF5hriO6RAAOsxefvg1K8k0xxRbihlr3+pWV+fU9kmhX9Z3vJJl2EBOEHj9f6TpB1ER9by7K1VwG8aa+Ir1oUX8k5ILbGUK7gdvkX64=
Received: from 30.178.81.252(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH3kfbt_1728895405 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 16:43:26 +0800
Message-ID: <d70e2172-6305-4ec9-ab09-f2421e536cbd@linux.alibaba.com>
Date: Mon, 14 Oct 2024 16:43:24 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH blktests v3 2/2] nvme: test the nvme reservation feature
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
 <20241012111157.44368-3-kanie@linux.alibaba.com>
 <4f6fac7b-2ef7-4255-94d1-9387f4110765@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <4f6fac7b-2ef7-4255-94d1-9387f4110765@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/10/14 15:23, Daniel Wagner 写道:
> On Sat, Oct 12, 2024 at 07:11:57PM GMT, Guixin Liu wrote:
>> +requires() {
>> +	_nvme_requires
>> +}
> It's probably a good idea to test if the reservation feature is
> available, otherwise this test just fails on older kernels.

I checked the exists of resv_enable,

"if [[ -f "${ns_path}/resv_enable" ]] ; then", if not exist, skip this

test case.

>> +Running nvme/054
>> +Register
>> +
>> +NVME Reservation status:
>> +
>> +gen       : 0
>> +rtype     : 0
>> +regctl    : 0
>> +ptpls     : 0
>> +
>> +NVME Reservation  success
> I think this is a bit fragile, because the output of the nvme command
> might be extended or reformatted (obviously not on purpose but happens).
> I'd recommend to explicitly check for the expected values in the test.

OK, I will add a "grep -E "xxx|xxx|xxx" " to filter the result we cared now.

Best Regards,

Guixin Liu

