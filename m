Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A6481DB
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998259; cv=none; b=HdE4JatsetWt1M/Tm6dGnDaqOTQnyPQkcUKwdxmBL9xmRKdfiFgKoELnVMS+jIBV2QiIzxyNMLZvVEuCklPgolzzQSW8QLdsMHWTChyGqIkRY/tkWGNJB1RTNBHwjBpZ6vIvkMt/3k9k7BTwOAn7172oURpeV92Eqe6PlA2BStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998259; c=relaxed/simple;
	bh=fjld/ywwPgA/jXb9WymxYP3xIuhD4tjcU1MPQrZWC0Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PkEi5OHXLwTpPsZ71iDQ+52VT75oVJ/oCZxz/wK9niAyjs3IESBfM72MxTAZRFjKhiHgntXuFq4vKkuII/ok2+8fhpHm8H7O4RqucRpuhR0PSbl2QIdD+255Hq7edr7caInBkApEaUPZjoxthSrh/5sDa7eWZm4FptFESBVWBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ww7712vWCz4f3kvw
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 14:10:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F310D1A1125
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 14:10:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBXzIJrYtFmXNx5DA--.12750S3;
	Fri, 30 Aug 2024 14:10:52 +0800 (CST)
Subject: Re: [PATCH] nbd: fix race between timeout and normal completion
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240830034145.1827742-1-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <71e7603a-1068-ff50-56b6-0a60aa392dd6@huaweicloud.com>
Date: Fri, 30 Aug 2024 14:10:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240830034145.1827742-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXzIJrYtFmXNx5DA--.12750S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15tr1rtF47WF4DArWrXwb_yoW8AFWUpF
	4UGan0kr18WrsrZFWkZ34xuFW3K392gry2gFyxtr10krZ8Zr929r18Ka45WF1fJrWkA39I
	gFn0gFs8A3WjqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/08/30 11:41, Ming Lei Ð´µÀ:
> If request timetout is handled by nbd_requeue_cmd(), normal completion
> has to be stopped for avoiding to complete this requeued request, other
> use-after-free can be triggered.
> 
> Fix the race by clearing NBD_CMD_INFLIGHT in nbd_requeue_cmd(), meantime
> make sure that cmd->lock is grabbed for clearing the flag and the
> requeue.
> 
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Fixes: 2895f1831e91 ("nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Thanks!

>   drivers/block/nbd.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 41a90150b501..69b9851b6798 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -181,6 +181,17 @@ static void nbd_requeue_cmd(struct nbd_cmd *cmd)
>   {
>   	struct request *req = blk_mq_rq_from_pdu(cmd);
>   
> +	lockdep_assert_held(&cmd->lock);
> +
> +	/*
> +	 * Clear INFLIGHT flag so that this cmd won't be completed in
> +	 * normal completion path
> +	 *
> +	 * INFLIGHT flag will be set when the cmd is queued to nbd next
> +	 * time.
> +	 */
> +	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
> +
>   	if (!test_and_set_bit(NBD_CMD_REQUEUED, &cmd->flags))
>   		blk_mq_requeue_request(req, true);
>   }
> @@ -488,8 +499,8 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
>   					nbd_mark_nsock_dead(nbd, nsock, 1);
>   				mutex_unlock(&nsock->tx_lock);
>   			}
> -			mutex_unlock(&cmd->lock);
>   			nbd_requeue_cmd(cmd);
> +			mutex_unlock(&cmd->lock);
>   			nbd_config_put(nbd);
>   			return BLK_EH_DONE;
>   		}
> 

