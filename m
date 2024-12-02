Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC81C6F56;
	Mon,  2 Dec 2024 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140697; cv=none; b=CjmQBjEs+Z7IF/SAigXdrixC4UagqVjZ968qsmSbWpAP4y2dQPgiKKYvjEUTC5C7/KC5FGhg8/c+E2kJR/U/mf+tQ/UwFWqeX+KVtRj+QNTOHsyVt/UdWDF1WXZThNm035qcL8rmRux0MmHZAZKg2PJhro28vKPA6IjHewy8qoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140697; c=relaxed/simple;
	bh=nt2Tmw4acNhBvqp54ikRBIsjEOifONNaZ1ZCyxPboEA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XNQjf8kc04kB3lts9hAOHXH0jcFkk/bthDWAQnJnZreA0WQCMFJ+ld7/BxMFXvOpYkO57pCigK9Z8IbdAxqOu5VsDwqqCA9zpfe+Xo5REaf11mZ4nJbswiuCZsfIKVJglmv1hoenHbVb+Z2+RZXzq4+Z2syBjWfgj11I/mHC+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y22NJ3gnVz4f3jsC;
	Mon,  2 Dec 2024 19:57:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 71D001A0568;
	Mon,  2 Dec 2024 19:58:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4fRoE1n8wvMDQ--.33316S3;
	Mon, 02 Dec 2024 19:58:11 +0800 (CST)
Subject: Re: [PATCH] block, bfq: fix bfqq uaf in bfq_limit_depth()
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241129091509.2227136-1-yukuai1@huaweicloud.com>
 <20241202112936.winpwxd5sbouczhj@quack3>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1070a675-36f4-53ef-2414-07edf9e5153a@huaweicloud.com>
Date: Mon, 2 Dec 2024 19:58:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202112936.winpwxd5sbouczhj@quack3>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4fRoE1n8wvMDQ--.33316S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYg7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
	CY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0S
	jxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r
	1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi!

ÔÚ 2024/12/02 19:29, Jan Kara Ð´µÀ:
> I can see Jens has already picked up the patch but FWIW the patch looks
> good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara<jack@suse.cz>

Tt's always welcome to review patches, even if they're picked up.

And thanks for the review.
Kuai

