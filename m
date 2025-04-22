Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7C22B5A3
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303716; cv=none; b=eilyjynq/yEeCD8pNh1KS3OiOpToelg2kGl0rHA+MS5CW8qE+3Im8GQGCe2PGenBY+YDoViQaTqT2jynMHfmOIKaglkQEACRh7+tX5atpa6wLZlqQiHnOez0czC53tCxUBHSYioiIycSWNBf0VFoNrIYuhXNSEnCgVBg100WZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303716; c=relaxed/simple;
	bh=Fq7AilgiTM+sNlg8wggbnA+8TeVQf/YvMrN25uU1sO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxLRxzguRaBWbSnw5LILsseNKguTFZc7TDl27BmzZWPaIvgt2LIiq8BrqYeM00BcemPrir+NKFi1De5UxmoC2nl1dDvnLArjiANVI9BQSAAq8aJ2U6zkJpEUdJk+mY8pxGg9SV5hN7opsz6TQ6DT1l9lPMy66oPcGCtTFuveoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZhXXH0VRbz4f3lDq
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 14:34:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 81F371A0359
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 14:35:04 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgB32l6WOAdoFlzZKA--.8287S3;
	Tue, 22 Apr 2025 14:35:04 +0800 (CST)
Message-ID: <2c8bb20c-2268-47b4-8d60-cfdc36a1b9ae@huaweicloud.com>
Date: Tue, 22 Apr 2025 14:35:02 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/7] blk-throttle: Introduce flag
 "BIO_TG_BPS_THROTTLED"
To: Christoph Hellwig <hch@infradead.org>
Cc: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, yangerkun@huawei.com, yukuai3@huawei.com,
 ming.lei@redhat.com, tj@kernel.org
References: <20250418040924.486324-1-wozizhi@huaweicloud.com>
 <20250418040924.486324-5-wozizhi@huaweicloud.com>
 <aAY0GNzcJH28OEtA@infradead.org>
 <818c7a4b-50b7-4933-ae01-e6fbb93417b9@huawei.com>
 <aAY9jhJr1VOh0sMm@infradead.org>
 <a5d1f436-9d31-407a-9653-5fd48f3dc80f@huawei.com>
 <aAcjDvCvmSiLd4zx@infradead.org>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <aAcjDvCvmSiLd4zx@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB32l6WOAdoFlzZKA--.8287S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYz7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAI
	w28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/4/22 13:03, Christoph Hellwig 写道:
> On Mon, Apr 21, 2025 at 08:53:10PM +0800, Zizhi Wo wrote:
>> Yes, otherwise they will interfere with each other. We can currently
>> ensure that this flag is cleared in the throttle process.
> 
> Can you explain that a bit better in the comment?
> 
Okay, I will explain it in more detail in the comments.

Thanks,
Zizhi Wo

