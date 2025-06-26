Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7116A94A
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923541; cv=none; b=o3YtVlHbqiKPNuOnz11z9rH9vRwaoxSHYEYwy67qdPLwCpp+zsVkHwPwg2JdcPTgKC1aTGsK+/dY5eI2dT2rZ2GHFZuo/7jY2iTCCQa696q+FR+2a2LuKEO/iIX/1WVcIVMRuaghGNaWBn39B7sKDpBsB+mHD0d9R+7P1J2cNjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923541; c=relaxed/simple;
	bh=YXNBOHA3xl1/Te3/Jlxp/wRZkf39qNTEMXa1KXB6p+0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=daQ2IepthzgEtzsx4UdSPHTlMOYtc/JfTjbTRRosDwgj0DLzCGvhIUOmtOA2FJbPjN4Kchs4FFKG564Qh7N4jLdVuw/TBYFHmwZps/O1ul7v1RBaIog3+uciUAvTjNWpDRlmUG6XoK/j5LWcKt1HvCDX5JENVqCyHQMOElHvqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bSVtL4SdJzYQv9f
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 15:38:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 829541A0F10
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 15:38:49 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8H+VxoqrPIQg--.21494S3;
	Thu, 26 Jun 2025 15:38:49 +0800 (CST)
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
To: Calvin Owens <calvin@wbinvd.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Breno Leitao <leitao@debian.org>, Yi Zhang <yi.zhang@redhat.com>,
 linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 axboe@kernel.dk, Christoph Hellwig <hch@infradead.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
 <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
 <aFTfQpsUiD1Hw3zU@mozart.vkv.me>
 <f320c94e-3a94-d645-8f7b-80f958c50fbe@huaweicloud.com>
 <aFtUXy-lct0WxY2w@mozart.vkv.me>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <49536e03-ba8d-8b15-413c-968c2147b81d@huaweicloud.com>
Date: Thu, 26 Jun 2025 15:38:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aFtUXy-lct0WxY2w@mozart.vkv.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl8H+VxoqrPIQg--.21494S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYy7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0
	xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw
	0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/06/25 9:43, Calvin Owens 写道:
> I can confirm it's what you expected, I've reproduced the original
> warning with your patch while not seeing any of the new ones.
> 
> If you like, for the revert:
> 
> Tested-By: Calvin Owens<calvin@wbinvd.org>

Thanks for the test, I'll send the revert with your tag.

Kuai

