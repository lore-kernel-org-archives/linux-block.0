Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A784215C0;
	Thu, 20 Mar 2025 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742442748; cv=none; b=d3mYqPQCA8Y4Rcjd8sc6+J/H8+W465nJiScuSm9FcdySIwksQxG5bFB5sjJvDbWtUw/E1xbMJBZdj9hbT4gWcfXQIXzl2+wcFcxX82+BcHTfxMyXCoWG/6q3s1ICRrSeGeWr/WbICfvEYDBKSeZPVtY/KpVxITCJOY+GgL/PYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742442748; c=relaxed/simple;
	bh=HJ/vMab4PTkcnszSovI+heK7l9hGV3Ds6Ib1jmzauC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=qUQU1pAxF2yvPPoYj9ug/7BDQVVb9QBBX9fD6IcouRt3/V/AwjkKbqE5cq+2CQaGbTiEmvTjV1nMHARgMzwux5T2GqyHi7BscYvivv63f2CAjvVx8xT9eKaDJql6HyU2x1HgeC/fNCzOm9u5Lx+MCvTb2SQEdfEbovVVGWGHIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZJBQ62SCfzCsJl;
	Thu, 20 Mar 2025 11:48:46 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B22A180103;
	Thu, 20 Mar 2025 11:52:22 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 20 Mar
 2025 11:52:21 +0800
Message-ID: <180d8a88-52d9-4b83-83de-0184ed7cb4a5@huawei.com>
Date: Thu, 20 Mar 2025 11:52:20 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression found in memory stress test with stress-ng
To: AceLan Kao <acelan.kao@canonical.com>
References: <CAFv23QnqgTVoB-XRe5yNndRz4-Z_3y38+QpKRxQMeZ2xQTg=gw@mail.gmail.com>
Content-Language: en-US
CC: <linux-block@vger.kernel.org>, <axboe@kernel.dk>, Christoph Hellwig
	<hch@infradead.org>, "Linux-Kernel@Vger. Kernel. Org"
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	<yukuai3@huawei.com>, Dirk Su <dirk.su@canonical.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CAFv23QnqgTVoB-XRe5yNndRz4-Z_3y38+QpKRxQMeZ2xQTg=gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/3/20 10:49, AceLan Kao wrote:
> Hi all,
>
> We have found a regression while doing a memory stress test using
> stress-ng with the following command
>     sudo stress-ng --aggressive --verify --timeout 300 --mmapmany 0
>
> This issue occurs on recent kernel versions, and we have found that
> the following commit leads to the issue
>     4e63aeb5d010 ("blk-wbt: don't throttle swap writes in direct reclaim")
>
> Before reverting the commit directly, I wonder if we can identify the
> issue and implement a solution quickly.
> Currently, I'm unable to provide logs, as the system becomes
> unresponsive during testing. If you have any idea to capture logs,
> please let me know, I'm willing to help.
Hi AceLan,

I cannot reproduce this issue. The above command will trigger OOM.
Have you enabled panic_on_oom? (You can check by sysctl vm.panic_on_oom).
Or are there more kernel Oops reports in dmesg?


Regards,
Baokun
>
> Best regards,
> AceLan Kao.
>

