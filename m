Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015BB1388;
	Tue, 12 Aug 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991304; cv=none; b=GgSqStRIK9qucyKDW2OGwlSDZAFgyc6arzBp4z9LgHoPzoOcM7EIepQO9pW51ZfjDonh1K0OV/liZ1L7qO2FipLj232gUznm6XnKhO/dgQ7q5igkU+q2fwRou8sDb0fqiMlBad4lzWKlMztW3Q43BapofH/GhvF4UMzeYB9CHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991304; c=relaxed/simple;
	bh=XzVQikg6eVnr6+fdjiHmLEY2s0a2gcTyAxBsjBwO6AE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f8EpHi/GQDF3OxWQebsQ4Ugo31QCBzTRSv/XEA9VsKkP0s4ltrRc3ZqDx1FAZ/yhkXLoqxzmj62xgXud/nSxGrjr4KjXqrqNf4PhkkRnv4mDO35CGdaS96mdMgxR/WU9s4gvh4BBq7Zwatn9riw9hNRD1Vq+F8EHMFZ0RgwRtuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1RDh0BsqzKHMwg;
	Tue, 12 Aug 2025 17:35:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 417DE1A06E6;
	Tue, 12 Aug 2025 17:34:59 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXIBHBCptoJTywDQ--.7024S3;
	Tue, 12 Aug 2025 17:34:59 +0800 (CST)
Subject: Re: [PATCH v2] loop: use vfs_getattr_nosec() for accurate file size
To: Christoph Hellwig <hch@infradead.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Rajeev Mishra <rajeevm@hpe.com>,
 axboe@kernel.dk, yukuai1@huaweicloud.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <a8041180-03f2-3342-b568-867b3f295239@huaweicloud.com>
 <20250812033201.225425-1-rajeevm@hpe.com>
 <34624336-331d-4047-822f-8091098eeebc@kernel.org>
 <20250812042826.GU222315@ZenIV>
 <a7cb5d59-8af5-47b2-8549-05c9322971e5@kernel.org>
 <aJr9UKtIJ74XExf-@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e2a5550d-fb55-99c1-82b1-5b6c174f7cfc@huaweicloud.com>
Date: Tue, 12 Aug 2025 17:34:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aJr9UKtIJ74XExf-@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXIBHBCptoJTywDQ--.7024S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4fZF1DWFyrZr47try5Arb_yoW3KFbE9r
	Wavr4qywnruw4rtF4Utr4Yvr95trZxtr18X393KFsrJw18XFWDCFW09r95urs3Jw1rJwsa
	9w12kw4DGay3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/12 16:37, Christoph Hellwig Ð´µÀ:
> On Tue, Aug 12, 2025 at 02:17:01PM +0900, Damien Le Moal wrote:
>> And indeed, that:
>>
>> 	/* size of the new backing store needs to be the same */
>>          if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
>>                  goto out_err;
>>
>> Will need some massaging.
> 
> Why?  get_loop_size just derives the first arguments to get_size
> from the passed in loop device in the same way the only other caller
> to get_size does.  So we can just:
> 
>    1) convert loop_set_status to use get_loop_size
>    2) Fold get_size into get_loop_size
>    3) Maye rename get_size to lo_calculate_size to have a descriptive
>       name while we're touching it?
>    4) switch to vfs_getattr

This looks good, it's better to refactor a bit before switch to getattr,
and I agree still return 0 on failue is fine.

Thanks,
Kuai

> 
> 
> .
> 

