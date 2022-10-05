Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E78AC433FE
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 10:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJEKBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJEKBL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 06:01:11 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019855724C
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 03:01:08 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 295A0VQ3008740;
        Wed, 5 Oct 2022 19:00:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Wed, 05 Oct 2022 19:00:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 295A0U79008735
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Oct 2022 19:00:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <15c6e51f-a2a4-38ff-15a4-9efee32824d3@I-love.SAKURA.ne.jp>
Date:   Wed, 5 Oct 2022 19:00:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: lockdep WARNING at blktests block/011
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <20221004104456.ik42oxynyujsu5vb@shindev>
 <63e14e00-e877-cb5a-a69a-ff44bed8b5a5@I-love.SAKURA.ne.jp>
 <20221004122354.xxqpughpvnisz5qs@shindev>
 <20221005083104.2k7nqohqcqcrdpn4@shindev>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20221005083104.2k7nqohqcqcrdpn4@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/10/05 17:31, Shinichiro Kawasaki wrote:
> @@ -5120,11 +5120,27 @@ EXPORT_SYMBOL_GPL(nvme_start_admin_queue);
>  void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_ns *ns;
> +	LIST_HEAD(splice);
>  
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	/*
> +	 * blk_sync_queues() call in ctrl->snamespaces_rwsem critical section
> +	 * triggers deadlock warning by lockdep since cancel_work_sync() in
> +	 * blk_sync_queue() waits for nvme_timeout() work completion which may
> +	 * lock the ctrl->snamespaces_rwsem. To avoid the deadlock possibility,
> +	 * call blk_sync_queues() out of the critical section by moving the
> +         * ctrl->namespaces list elements to the stack list head temporally.
> +	 */
> +
> +	down_write(&ctrl->namespaces_rwsem);
> +	list_splice_init(&ctrl->namespaces, &splice);
> +	up_write(&ctrl->namespaces_rwsem);

Does this work?

ctrl->namespaces being empty when calling blk_sync_queue() means that
e.g. nvme_start_freeze() cannot find namespaces to freeze, doesn't it?

  blk_mq_timeout_work(work) { // Is blocking __flush_work() from cancel_work_sync().
    blk_mq_queue_tag_busy_iter(blk_mq_check_expired) {
      bt_for_each(blk_mq_check_expired) == blk_mq_check_expired() {
        blk_mq_rq_timed_out() {
          req->q->mq_ops->timeout(req) == nvme_timeout(req) {
            nvme_dev_disable() {
              mutex_lock(&dev->shutdown_lock); // Holds dev->shutdown_lock
              nvme_start_freeze(&dev->ctrl) {
                down_read(&ctrl->namespaces_rwsem); // Holds ctrl->namespaces_rwsem which might block
                //blk_freeze_queue_start(ns->queue); // <= Never be called because ctrl->namespaces is empty.
                up_read(&ctrl->namespaces_rwsem);
              }
              mutex_unlock(&dev->shutdown_lock);
            }
          }
        }
      }
    }
  }

Are you sure that down_read(&ctrl->namespaces_rwsem) users won't run
when ctrl->namespaces is temporarily made empty? (And if you are sure
that down_read(&ctrl->namespaces_rwsem) users won't run when
ctrl->namespaces is temporarily made empty, why ctrl->namespaces_rwsem
needs to be a rw-sem rather than a plain mutex or spinlock ?)

> +
> +	list_for_each_entry(ns, &splice, list)
>  		blk_sync_queue(ns->queue);
> -	up_read(&ctrl->namespaces_rwsem);
> +
> +	down_write(&ctrl->namespaces_rwsem);
> +	list_splice(&splice, &ctrl->namespaces);
> +	up_write(&ctrl->namespaces_rwsem);
>  }
>  EXPORT_SYMBOL_GPL(nvme_sync_io_queues);

I don't know about dependency chain, but you might be able to add
"struct nvme_ctrl"->sync_io_queue_mutex which is held for serializing
nvme_sync_io_queues() and down_write(&ctrl->namespaces_rwsem) users?

If we can guarantee that ctrl->namespaces_rwsem => ctrl->sync_io_queue_mutex
is impossible, nvme_sync_io_queues() can use ctrl->sync_io_queue_mutex
rather than ctrl->namespaces_rwsem, and down_write(&ctrl->namespaces_rwsem)/
up_write(&ctrl->namespaces_rwsem) users are replaced with
  mutex_lock(&ctrl->sync_io_queue_mutex);
  down_write(&ctrl->namespaces_rwsem);
and
  up_write(&ctrl->namespaces_rwsem);
  mutex_unlock(&ctrl->sync_io_queue_mutex);
sequences respectively.

