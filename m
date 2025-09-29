Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330F1CAA79;
	Mon, 29 Sep 2025 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759108271; cv=none; b=f37OwsjqUBEN77wTxFX5odC4Ea8BnuRkr1T3RtVWnsTxlDVKDIOs/FudQBfVmpydnmHWQQt1HWaAEauC2C8rjO/x0zvhXMg6+B41lturpYuN397qG0S+AkIvf5twJ4KjOQEWr+oqzFb0gMxnqGHZQcX1NEhjPCpzS4ty6Oaolbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759108271; c=relaxed/simple;
	bh=zK+peQS50yshv5/8hVeXqEq7UD+wV8fEUWoRCT8jRwM=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PK9uvEghna3IariGl5Y+J4NSPOkxiKQLtYRb57IUE/NEXCMbq75rohI/Ej050Bggy+KyoLm6q/jyezR92gLiZRbYh5EAPz2J18409T+3tVFlHzX9MOcmk6n9JCOdN6t+D5xh9euSBc5D1myIyc9l0U5dj7QPOpDD7AFmWzV1xoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZjmp2HsJzYQv6b;
	Mon, 29 Sep 2025 09:10:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7475C1A12C9;
	Mon, 29 Sep 2025 09:11:05 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCHS2Oo3Nlo5HWqBA--.20175S3;
	Mon, 29 Sep 2025 09:11:05 +0800 (CST)
Subject: Re: [PATCH] loop: fix backing file reference leak on validation error
To: Li Chen <me@linux.beauty>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250926121231.32549-1-me@linux.beauty>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <68aebe91-4dcd-925f-4232-1c432fe6899d@huaweicloud.com>
Date: Mon, 29 Sep 2025 09:11:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250926121231.32549-1-me@linux.beauty>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHS2Oo3Nlo5HWqBA--.20175S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1xJFWUWFyfKw4xGFykXwb_yoW8GF1DpF
	45Gas0yFWDKF4rKanFq393uw15Z3WxKrWS9a4DC3W09r1rArZakryrCr90gr1qqrWDGa4a
	q3WUKFyDuF1UCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwz
	uWDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/09/26 20:12, Li Chen Ð´µÀ:
> loop_change_fd() and loop_configure() call loop_check_backing_file()
> to validate the new backing file. If validation fails, the reference
> acquired by fget() was not dropped, leaking a file reference.
> 
> Fix this by calling fput(file) before returning the error.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>   drivers/block/loop.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 053a086d547e..94ec7f747f36 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -551,8 +551,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>   		return -EBADF;
>   
>   	error = loop_check_backing_file(file);
> -	if (error)
> +	if (error) {
> +		fput(file);
>   		return error;
> +	}
>   
>   	/* suppress uevents while reconfiguring the device */
>   	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
> @@ -993,8 +995,10 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   		return -EBADF;
>   
>   	error = loop_check_backing_file(file);
> -	if (error)
> +	if (error) {
> +		fput(file);
>   		return error;
> +	}
>   
>   	is_loop = is_loop_device(file);
>   
> 

The changes look correct, however, I'll prefer to change the error path
to the reverse order and add a new error tag.

Thanks,
Kuai

