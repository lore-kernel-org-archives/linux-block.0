Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F00C54EBD
	for <linux-block@archiver.kernel.org>; Thu, 12 Jan 2023 11:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbjALL7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbjALL7G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2023 06:59:06 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1308637C
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 03:53:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nt2xJ2Nw5z4f3lKl
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 19:53:08 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R+m9L9j4_HGBQ--.31554S3;
        Thu, 12 Jan 2023 19:53:10 +0800 (CST)
Subject: Re: [bug report] BUG: KASAN: use-after-free in bic_set_bfqq
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230112113833.6zkuoxshdcuctlnw@shindev>
 <6933fa2d-014c-8773-39d9-680ad9fca98c@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3cbab38c-5b8d-131a-d80a-886a0febc692@huaweicloud.com>
Date:   Thu, 12 Jan 2023 19:53:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6933fa2d-014c-8773-39d9-680ad9fca98c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R+m9L9j4_HGBQ--.31554S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy8Wr4kKr4DKr4rKF1DGFg_yoW8tFWfpr
        1ktr47JryUJFnYqr1UJw1UXFy8JF18Jw1Utr1jq3W7Ar17Jw12qFs0vr1jgr18Xr4rGr45
        Xr1jvryUZr1UWrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aP
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2023/01/12 19:47, Yu Kuai 写道:
> Thanks for the report, is the problem easy to reporduce? If so, can you
> try the following patch?
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 1b2829e99dad..81d2f401fa3f 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -771,8 +771,8 @@ static void __bfq_bic_change_cgroup(struct bfq_data 
> *bfqd,
>                                   * request from the old cgroup.
>                                   */
>                                  bfq_put_cooperator(sync_bfqq);
> -                               bfq_release_process_ref(bfqd, sync_bfqq);
>                                  bic_set_bfqq(bic, NULL, true);
> +                               bfq_release_process_ref(bfqd, sync_bfqq);
>                          }
>                  }
>          }
> 
Just in case you hit the problem in another place, please using the
following patch:

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 1b2829e99dad..81d2f401fa3f 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -771,8 +771,8 @@ static void __bfq_bic_change_cgroup(struct bfq_data 
*bfqd,
                                  * request from the old cgroup.
                                  */
                                 bfq_put_cooperator(sync_bfqq);
-                               bfq_release_process_ref(bfqd, sync_bfqq);
                                 bic_set_bfqq(bic, NULL, true);
+                               bfq_release_process_ref(bfqd, sync_bfqq);
                         }
                 }
         }
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 16f43bbc575a..687285612e57 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5425,9 +5425,10 @@ static void bfq_check_ioprio_change(struct 
bfq_io_cq *bic, struct bio *bio)

         bfqq = bic_to_bfqq(bic, false);
         if (bfqq) {
-               bfq_release_process_ref(bfqd, bfqq);
+               struct bfq_queue *old_bfqq = bfqq;
                 bfqq = bfq_get_queue(bfqd, bio, false, bic, true);
                 bic_set_bfqq(bic, bfqq, false);
+               bfq_release_process_ref(bfqd, old_bfqq);
         }

         bfqq = bic_to_bfqq(bic, true);

