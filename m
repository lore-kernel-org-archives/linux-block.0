Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8008BC4167B
	for <linux-block@archiver.kernel.org>; Mon, 26 Dec 2022 01:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLZBRW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Dec 2022 20:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLZBRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Dec 2022 20:17:21 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D6CD92
        for <linux-block@vger.kernel.org>; Sun, 25 Dec 2022 17:17:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NgKdQ4fxrz4f3pF4
        for <linux-block@vger.kernel.org>; Mon, 26 Dec 2022 09:17:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLMc9qhjwzQaAg--.47209S3;
        Mon, 26 Dec 2022 09:17:17 +0800 (CST)
Subject: Re: [bug report]BUG: KFENCE: use-after-free read in
 bfq_exit_icq_bfqq+0x132/0x270
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs-MzFV6WTfveRXTARsik9wTGgado2U4vnT8oH6vmfFjzQ@mail.gmail.com>
 <b480e35d-5171-425b-31c6-3a7fe5b8a666@kernel.dk>
 <20221222144949.sqmrmycfg2hg5ymq@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a33dd515-b771-f400-ce49-e01f4ab31ad7@huaweicloud.com>
Date:   Mon, 26 Dec 2022 09:17:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221222144949.sqmrmycfg2hg5ymq@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLMc9qhjwzQaAg--.47209S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW7GFW5urW8Cry3tr1fJFb_yoWrZr18pr
        yvqFZ2gw48Jry5Jw47Aw1qqryfCF4vvF4UGF4kG34UGr4DZ347J3WjkF45WryUGwn8CF17
        Jr95JwnFvr1kGwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Jan!

在 2022/12/22 22:49, Jan Kara 写道:
> Thanks for report and the CC!
> 
> On Mon 19-12-22 10:52:57, Jens Axboe wrote:
>> On 12/19/22 12:16 AM, Yi Zhang wrote:
>>> Below issue was triggered during blktests nvme-tcp with for-next
>>> (6.1.0, block, 2280cbf6), pls help check it
>>>
>>> [  782.395936] run blktests nvme/013 at 2022-12-18 07:32:09
>>> [  782.425739] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>> [  782.435780] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>>> [  782.446357] nvmet: creating nvm controller 1 for subsystem
>>> blktests-subsystem-1 for NQN
>>> nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0042-3910-8039-c6c04f544833.
>>> [  782.460744] nvme nvme0: creating 32 I/O queues.
>>> [  782.466760] nvme nvme0: mapped 32/0/0 default/read/poll queues.
>>> [  782.479615] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
>>> 127.0.0.1:4420
>>> [  783.612793] XFS (nvme0n1): Mounting V5 Filesystem
>>> [  783.650705] XFS (nvme0n1): Ending clean mount
>>> [  799.653271] ==================================================================
>>> [  799.660496] BUG: KFENCE: use-after-free read in bfq_exit_icq_bfqq+0x132/0x270
>>> [  799.669117] Use-after-free read at 0x000000008c692c21 (in kfence-#11):
>>> [  799.675647]  bfq_exit_icq_bfqq+0x132/0x270
>>> [  799.679753]  bfq_exit_icq+0x5b/0x80
>>> [  799.683255]  exit_io_context+0x81/0xb0
>>> [  799.687015]  do_exit+0x74b/0xaf0
>>> [  799.690256]  kthread_exit+0x25/0x30
>>> [  799.693758]  kthread+0xc8/0x110
>>> [  799.696904]  ret_from_fork+0x1f/0x30
>>> [  799.701991] kfence-#11: 0x00000000f1839eaa-0x0000000011c747a1,
>>> size=568, cache=bfq_queue
>>> [  799.711549] allocated by task 19533 on cpu 9 at 499.180335s:
>>> [  799.717218]  bfq_get_queue+0xe0/0x530
>>> [  799.720884]  bfq_get_bfqq_handle_split+0x75/0x120
>>> [  799.725592]  bfq_insert_requests+0x1d15/0x2710
>>> [  799.730045]  blk_mq_sched_insert_requests+0x5c/0x170
>>> [  799.735021]  blk_mq_flush_plug_list+0x115/0x2e0
>>> [  799.739551]  __blk_flush_plug+0xf2/0x130
>>> [  799.743479]  blk_finish_plug+0x25/0x40
>>> [  799.747231]  __iomap_dio_rw+0x520/0x7b0
>>> [  799.751070]  btrfs_dio_write+0x42/0x50
>>> [  799.754832]  btrfs_do_write_iter+0x2f4/0x5d0
>>> [  799.759112]  nvmet_file_submit_bvec+0xa6/0xe0 [nvmet]
>>> [  799.764193]  nvmet_file_execute_io+0x1a4/0x250 [nvmet]
>>> [  799.769349]  process_one_work+0x1c4/0x380
>>> [  799.773361]  worker_thread+0x4d/0x380
>>> [  799.777028]  kthread+0xe6/0x110
>>> [  799.780174]  ret_from_fork+0x1f/0x30
>>> [  799.785252] freed by task 19533 on cpu 9 at 799.653250s:
>>> [  799.790584]  bfq_put_queue+0x183/0x2c0
>>> [  799.794344]  bfq_exit_icq_bfqq+0x129/0x270
>>> [  799.798442]  bfq_exit_icq+0x5b/0x80
>>> [  799.801934]  exit_io_context+0x81/0xb0
>>> [  799.805687]  do_exit+0x74b/0xaf0
>>> [  799.808920]  kthread_exit+0x25/0x30
>>> [  799.812413]  kthread+0xc8/0x110
>>> [  799.815561]  ret_from_fork+0x1f/0x30
>>> [  799.820648] CPU: 9 PID: 19533 Comm: kworker/dying Not tainted 6.1.0 #1
>>> [  799.827181] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
>>> 2.15.1 06/15/2022
>>> [  799.834746] ==================================================================
>>> [  823.081364] XFS (nvme0n1): Unmounting Filesystem
>>> [  823.159994] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> 
> Can you use addr2line to find which dereference is exactly causing the
> problem? Hum, it seems to point to some strange issue because we've just
> freed bfqq in this exit_io_context() invocation and seeing you are testing
> linux-block tree I think the problem might be caused by 64dc8c732f5c
> ("block, bfq: fix possible uaf for 'bfqq->bic'"). Kuai, I think we've
> messed up bfq_exit_icq_bfqq() and now bic_set_bfqq() can access already
> freed 'old_bfqq'. So we need something like:
> 
> 
>                  spin_lock_irqsave(&bfqd->lock, flags);
>                  bfqq->bic = NULL;
> -               bfq_exit_bfqq(bfqd, bfqq);
>                  bic_set_bfqq(bic, NULL, is_sync);
> +               bfq_exit_bfqq(bfqd, bfqq);
>                  spin_unlock_irqrestore(&bfqd->lock, flags);
> 
> so free bfqq only after it is removed from the bic...

Sorry for the delay, and you're right, that's definitely a problem. 😒

Thanks,
Kuai
> 
> 								Honza
> 

