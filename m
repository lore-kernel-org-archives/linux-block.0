Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925EEEDE
	for <linux-block@vger.kernel.org>; Sat, 22 Feb 2025 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740193322; cv=none; b=us/hdrWAAaQjorLntEDMY4BuH5YHL0T5HGsZLpSBrerUfY6vloHiKbVV0jX7DMIbQAnSVQpR6NVIj4I5YGwy6rOybEAghPio3NaUh8jbdjsJiSapwBhjkGLI/AfloNdM9GbtXlpIoS23teCi6yPLIdfTVsipo+8i01toItTTYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740193322; c=relaxed/simple;
	bh=HPqeS08ExIf1Kd19Kk/hyxqYQ38XnU+gd+8H6kTmXrU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LdEKvA+r6TGJFdq/zAfjxJyCO1UX8LL/ynkfq82mTS6FTT/LceAlBYLDgKzjVZRZXadITH4622f18c/sTJwabfAl5/1FE3bXES17WeAqPerTrjiv3eUXIuLI2jU5hF4yHGthmpiwnzh/hs555bdaIGFXquAoQh1inBEyrupsfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z0Bbc60zpz4f3jXd
	for <linux-block@vger.kernel.org>; Sat, 22 Feb 2025 11:01:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 861601A06DC
	for <linux-block@vger.kernel.org>; Sat, 22 Feb 2025 11:01:54 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3m18gPrlnU1gpEg--.21346S3;
	Sat, 22 Feb 2025 11:01:54 +0800 (CST)
Subject: Re: [PATCH] block: throttle: don't add one extra jiffy mistakenly for
 bps limit
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250220111735.1187999-1-ming.lei@redhat.com>
 <a8f10a51-c9c8-0d1a-296d-f1f542bf8523@huaweicloud.com>
 <Z7frGxuMCTLwH9BW@fedora>
 <83147b4b-9be8-3a50-6a4f-2ec9b37c8ab8@huaweicloud.com>
 <Z7f-jx9LRXUrj_ao@fedora>
 <7a113162-a2c1-fad4-3395-7bc39d05b5c4@huaweicloud.com>
 <Z7hAauGfBrwNBRkz@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8dcc11e4-0cc5-6df9-5fda-83fd61afb216@huaweicloud.com>
Date: Sat, 22 Feb 2025 11:01:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z7hAauGfBrwNBRkz@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3m18gPrlnU1gpEg--.21346S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw48XrW5GryUCr4kWFy5CFg_yoW3Zwc_ur
	ZFkrZ3W3y8K3ZIyFWfKw13ursaqr48Wry7ArW0ga1UtrW7Jr48JFZI934Sqw4rAay5CFnx
	ZFsxXrWFyr17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUf8nOUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/02/21 16:59, Ming Lei 写道:
>> And if the tg idle for a long time before dispatching the next IO,
>> tg_trim_slice() should handle this case and avoid long slice end. This
>> is not quite handy, perhaps it's better to add a helper like
>> tg_in_debt() before throtl_start_new_slice() to hande this case.
>>
>> BTW, we must update the comment about carryover_bytes/ios, it's alredy
>> used as debt.
> Indeed, the approach is similar with the handling for
> bio_issue_as_root_blkg().
> 
> 
> Tested-by: Ming Lei<ming.lei@redhat.com>

While cooking the patch, I found a better way than tg_in_debt() before
throtl_start_new_slice(), by making sure the current slice has 1 more
jiffies to repay the debt. I'll send the patch soon, let me know if you
don't want me to kee the test tag.

Thanks,
Kuai

