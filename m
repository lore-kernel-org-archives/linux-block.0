Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305E28DB46;
	Thu, 31 Jul 2025 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945523; cv=none; b=p+RgKFCZ35oS9BY+rns/qS86TXGP+KrCFXX5HE/owk6jHfTurrfYfb+An1rH73dwd1Hzit95dLjAnq1zkMZpnP1Uht95sy6z/khAs/Y8K2a6pjU1yrwazordyZ164/yueCw0vR95q5dG3YuXACfpeUoQROTwCvNMC8jGOvHPb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945523; c=relaxed/simple;
	bh=hC+ZYRMClws5PB0cmKfh3SCEf5GnTVWE0dC7wQpM/6c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NwCLvYwHEGYlRHFNxWNlE9B5lAY3v+9FOb40XfIMAkT/rfjrqJquFsoE9xA9STxxozeCp0kTMcWQp2fDNilAhE8WdWu0E9QoNNGKgQLQvD7g+jKIqVo3PTpB0Bi8mRdDv4pEHtpBdI+mYGxtKMnVaGzurti6prtsTeBP/qumUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bt0TT2vt1zYQv52;
	Thu, 31 Jul 2025 15:05:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 17E881A092F;
	Thu, 31 Jul 2025 15:05:16 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXkxOrFYto8udOCA--.37069S3;
	Thu, 31 Jul 2025 15:05:15 +0800 (CST)
Subject: Re: [PATCH] block: Fix default IO priority if there is no IO context
To: Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250731044953.1852690-1-linux@roeck-us.net>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a97c3d4d-4b69-ed64-154b-4329e94a703a@huaweicloud.com>
Date: Thu, 31 Jul 2025 15:05:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250731044953.1852690-1-linux@roeck-us.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXkxOrFYto8udOCA--.37069S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1fZw47Jw18KFWfCr15urg_yoW8JFWDpF
	18Ca4q9r48ZF1Ik3WUWas5uasY93Z3GryUGrZ8WrWru3s5Gw10gr15K3Za9F1Yyr4kWr4f
	Ww4qk3yfCa45ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
	CzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/07/31 12:49, Guenter Roeck Ð´µÀ:
> Upstream commit 53889bcaf536 ("block: make __get_task_ioprio() easier to
> read") changes the IO priority returned to the caller if no IO context
> is defined for the task. Prior to this commit, the returned IO priority
> was determined by task_nice_ioclass() and task_nice_ioprio(). Now it is
> always IOPRIO_DEFAULT, which translates to IOPRIO_CLASS_NONE with priority
> 0. However, task_nice_ioclass() returns IOPRIO_CLASS_IDLE, IOPRIO_CLASS_RT,
> or IOPRIO_CLASS_BE depending on the task scheduling policy, and
> task_nice_ioprio() returns a value determined by task_nice(). This causes
> regressions in test code checking the IO priority and class of IO
> operations on tasks with no IO context.
> 
> Fix the problem by returning the IO priority calculated from
> task_nice_ioclass() and task_nice_ioprio() if no IO context is defined
> to match earlier behavior.
> 
> Fixes: 53889bcaf536 ("block: make __get_task_ioprio() easier to read")
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   include/linux/ioprio.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Thanks

