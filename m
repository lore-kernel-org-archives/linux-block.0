Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E631D10A05
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TDfZt6GJYz4f3lfy
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 14:42:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ECEEC1A016E
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 14:42:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFrJaZlAxb0Aw--.65493S3;
	Tue, 16 Jan 2024 14:42:52 +0800 (CST)
Subject: Re: [PATCH 1/2] block: add blk_time_get_ns() helper
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240115215840.54432-1-axboe@kernel.dk>
 <20240115215840.54432-2-axboe@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a67e7a44-5ac4-b18d-b0c8-b0a4b42e1224@huaweicloud.com>
Date: Tue, 16 Jan 2024 14:42:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240115215840.54432-2-axboe@kernel.dk>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFrJaZlAxb0Aw--.65493S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw43KrWfXFW7XF1Dtr43ZFb_yoWxZFcEk3
	4Fvas7J345uFsYyrn2gw43Gayvvr9rWw4xXws8KFZxXrW8Xw1UAFs5Wr45Gr17Xw15ZFn8
	CrW5Cry5AF98tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/01/16 5:53, Jens Axboe Ð´µÀ:
>   
> @@ -2810,7 +2810,7 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
>   		return;
>   	}
>   
> -	on_q_ns = ktime_get_ns() - rq->alloc_time_ns;
> +	on_q_ns = blk_time_get_ns() - rq->alloc_time_ns;

Just notice that this is from io completion path, and the same as
blk_account_io_done(), where plug does not exist. Hence ktime_get_ns()
will still be called multiple times after patch 2.

Do you think will this worth to be optimized? For example, add a new
field in request so that each rq completion will only call
ktime_get_ns() once. Furthermore, we can optimize io_tices precision
from jiffies to ns.

Thanks,
Kuai

