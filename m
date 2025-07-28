Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0ED2AD2C;
	Mon, 28 Jul 2025 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753666133; cv=none; b=CoyBZkIwiIQJs0h5O3bXvuiYnwGzwSYDoa9PtK137oQMPbKYzYNBXotfWb5Kx108FNe9u84WgtL/K91bOQ70Fdq3H+AIT15YYex3PH/JZTfltEY7ZLWlbXbnFVGjbu6tb5sM1+quFiBnGzeUX9QqkvUvP6vKAASsc9cZAmN0iU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753666133; c=relaxed/simple;
	bh=vsogK7pzd+evlCJKCSPpNo8RkQYBo7VJzrlns11qvSk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cbVQh7cFVFDHih4LPES98WPqsfx3393ClnmpkT9BE7HYi7fQHdV31PAiL5+1gNT54UgCpTYJ0x8hBO6R+iRisEcASTa/zVfqNqZQSZiNx2IgB00pHXv3+2eXWGMUGSa9J000SLu7NBfP74En58lKGWjiVnqhWOd8qPOguoC08zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4br18d5n8szYQvCW;
	Mon, 28 Jul 2025 09:28:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7AD5D1A11D5;
	Mon, 28 Jul 2025 09:28:48 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhNP0oZoKk7jBg--.34104S3;
	Mon, 28 Jul 2025 09:28:48 +0800 (CST)
Subject: Re: [PATCH v3 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec
 interface
To: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, hch@lst.de,
 jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 tangyeechou@gmail.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250727173959.160835-1-yizhou.tang@shopee.com>
 <20250727173959.160835-4-yizhou.tang@shopee.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <61c5b01f-37b6-5c02-2b12-fdb7216e4888@huaweicloud.com>
Date: Mon, 28 Jul 2025 09:28:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250727173959.160835-4-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhNP0oZoKk7jBg--.34104S3
X-Coremail-Antispam: 1UD129KBjvJXoWrtr4ruFW8KrWUtF1ftF48Crg_yoW8JrWDpa
	yfK34I9FyDCry7CF18CFn2kF129FW8uF48Zr4DJF1UKFn8JwnY9Fs2qrWFga1DArWfXFWj
	qr4DKryrKa1jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
	CzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/07/28 1:39, Tang Yizhou Ð´µÀ:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> The symbol wb_window_usec cannot be found. Update the doc to reflect the
> latest implementation, in other words, the debugfs interface
> 'curr_win_nsec'.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>   Documentation/ABI/stable/sysfs-block | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Thanks

> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 4ba771b56b3b..a3cf841ebdff 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -731,7 +731,7 @@ Contact:	linux-block@vger.kernel.org
>   Description:
>   		[RW] If the device is registered for writeback throttling, then
>   		this file shows the target minimum read latency. If this latency
> -		is exceeded in a given window of time (see wb_window_usec), then
> +		is exceeded in a given window of time (see curr_win_nsec), then
>   		the writeback throttling will start scaling back writes. Writing
>   		a value of '0' to this file disables the feature. Writing a
>   		value of '-1' to this file resets the value to the default
> 

