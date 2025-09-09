Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0C352FC9
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436324; cv=pass; b=Pw9Ap9BlO4+AviQfKckxdrrnBYaravkaonMcWGVjilnR1zMRftlJ/TYEnpxnFKnwpPvFyNVQt+lliHo9kC9jhJ/NT6PzPdbSH2GGGItREN8qe60f2vfZzX1UYgp8G3HTsTCxdy7J0ysWifGWy1BGhZqpqvqwRObqFRpLrtMZIPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436324; c=relaxed/simple;
	bh=TXOiokrLocIx7qPneDTyz+FSVC0xN4R+SOjN66zfSy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzpDke3/k9I7Xgpp/Mbt00WZw0sX5mVBIfdkX9AEROGF28mQC+9snrwVXUN7cZf7yEdPoUMHZfKSKSrK/I30xc8KHm8x/08tFSUN/xS0OshLJXS06G2DLrHhkPPal2C7UmLUE+mUFN0qeopnPtnRuMRVC9Go7jJpHYGcK2TFyes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=NjdYgX7Y; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="NjdYgX7Y"
ARC-Seal: i=1; a=rsa-sha256; t=1757436306; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HWU6ToGJKQRF6UKb1zHM9DzbeTxwCyTHGxK8ArzN7cRWrv4+NmXoam3A7vd+WNV5uiRavlPoEe4cCjziiogw1/fwqGkGCzbzwn3sa2cDp7IaM2IoRGq87qq6bC6RQtna8sWqz4v8TELaFWq2Tq1ZkgcXsMBnj7D/E1OEyGh5/kM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757436306; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QO+PHToivfbCFgzyPDuOup7gA+mFZZnp1xAvWfXBfkY=; 
	b=KDK+kX/2Ao9mH98DihF4Y/05d/C/awQeT5gTcXhDr5WgVyi1WH0DVTQ6xi+EtaenVK6K4I/3UfDpFewBcEximOTheJR/qGgPhY+SKXMArudFM5l2YxtFPHAI9cwS+MAYq7jBwlR9hzCZH+2FzpnCpKWHCdmtDOWcxb8FIT9BAGs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757436306;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QO+PHToivfbCFgzyPDuOup7gA+mFZZnp1xAvWfXBfkY=;
	b=NjdYgX7YZiSUk1Fgl3d1nleLDwtVdYJGGwIl/Szgiq3NzJmD5jfm3/liJ0ZrEHco
	xgHLAXqu32+zNkJP9Kz5GyTL2Yl2S8SyJ8dX7G/KmWpzczK2o9DFa4MUODeCkJp4k/z
	qC1QjUzbyjBFtchKiDASb9GvMXVnMjG11AyeQOXE=
Received: by mx.zohomail.com with SMTPS id 1757436303989744.4267274827305;
	Tue, 9 Sep 2025 09:45:03 -0700 (PDT)
Message-ID: <fdfcb000-916b-4599-b75c-1b4680accca7@yukuai.org.cn>
Date: Wed, 10 Sep 2025 00:44:57 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250909
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org, inux-raid@vger.kernel.org, song@kernel.org
Cc: linan122@huawei.com, xni@redhat.com, colyli@kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250909082005.3005224-1-yukuai1@huaweicloud.com>
 <a56b2c76-e254-48bc-86a6-8beb47ac79ff@kernel.dk>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <a56b2c76-e254-48bc-86a6-8beb47ac79ff@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/9 21:26, Jens Axboe 写道:
> On 9/9/25 2:20 AM, Yu Kuai wrote:
>> Hi, Jens
>>
>> Please consider pulling following changes on your for-6.18/block branch,
>> this pull request contains:
>>
>>   - add kconfig for internal bitmap;
>>   - introduce new experimental feature lockless bitmap;
> Can you write a bit of a better pull request letter? It'd be nice to get
> an actual description of what the "lockless bitmap" is, and why it makes
> sense to have it. This is pretty sparse...

Of course, details in be found in the patch 0 of the thread. I'll send a v2.

>
>>    https://kernel.googlesource.com/pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.18-20250909
>>
> and this is a new source for you, is the above tag signed?

I thought they are the same, I'll switch back in v2.

Thanks,
Kuai

