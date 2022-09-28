Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88885C04A95
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 04:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiI1EIB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 00:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiI1EIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 00:08:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919021EE763
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 21:07:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a20so7281310qtw.10
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 21:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=KFhIIG6fJJ5RGEpipB0mjh9TDPsM/a9pejZ+fKWNIZo=;
        b=Z+nlbg+X9WIz1FSazuhzTGocc2sPX7jq94+AS2ZO8vTzTIc2yduBJwUi6mwaxel2Pw
         MOt9ryt3ecU+5CSIsNdGtzFOMSuoCByPBgOYJAqWHDzbnOYHX6s1Vc55k3AF409Br6sN
         Un3KJUUin+AKlxoKonhYbl6gal9QxjMrkci0F8v1SinVdJg9uH2vtdXHjg5C+GLzpbbR
         Lm14/TZYnt1kNLWWWEVjj5F6iP1GCg6wixc5bRjNWElGCdMI2S8K689tWl1/MRu+q70p
         j9jJl1GsRc1O0EVYU1ACgjwRNZyjreWuQmKdDwnDAxXLAw+5MA9borOCZQFO+YbaHAub
         L30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=KFhIIG6fJJ5RGEpipB0mjh9TDPsM/a9pejZ+fKWNIZo=;
        b=ny9bNjVg9x3OphmGqKZRbQIrQ5NLeyBRjP3MtKCXj6oanJWZ90jtZatdFOZeRXlTFo
         cv6NKUhrpVoavV6t3jIXkl5rH5cYI8weSQrJQ7sOLEJt6Q2ibQLilondHsjsPSm0oOM7
         wHi5001lgbreWl97EB9ag3cxkieViU1iOmf87xEf2HKFS39jGOMq+s8eMsMMsrny1nqX
         HvcmYan8eEi+lGUhsjjr1GvjKc9VRrYFourVcvB2haunbM+vcP4cC0TBP56hnDJqxa+k
         58raByZSn6p1Fh3tExbU5wmcrbahfl4cXdVVYcrGwjo87XdcBcimyMl9xpTaZGvLtYsW
         yPEw==
X-Gm-Message-State: ACrzQf20Shd3zswsTYnnPtl0OnjryuX6rQw1j74PcTrfmA9tZ5R8jBhl
        PtR1zXafFkSt7x+HO54K7idJQQ==
X-Google-Smtp-Source: AMsMyM4808P3ZIq1U/9vwWonPoq/gEyol9QgJRzv7Q5uzWYzlDfcbcke8/J2EJo1x/3Huj4eDaBLQw==
X-Received: by 2002:ac8:5786:0:b0:35c:aa82:303 with SMTP id v6-20020ac85786000000b0035caa820303mr25655385qta.343.1664338078579;
        Tue, 27 Sep 2022 21:07:58 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w12-20020ac843cc000000b0035bb6c3811asm2034432qtn.53.2022.09.27.21.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 21:07:58 -0700 (PDT)
Date:   Tue, 27 Sep 2022 21:07:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jens Axboe <axboe@kernel.dk>
cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Keith Busch <kbusch@kernel.org>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v2] sbitmap: fix lockup while swapping
In-Reply-To: <f975dddf-6ec-b3cb-3746-e91f61b22ea@google.com>
Message-ID: <9f68731-e699-5679-6a71-77634767b8dd@google.com>
References: <YyjdiKC0YYUkI+AI@kbusch-mbp> <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com> <20220921164012.s7lvklp2qk6occcg@quack3> <20220923144303.fywkmgnkg6eken4x@quack3> <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com> <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
 <391b1763-7146-857-e3b6-dc2a8e797162@google.com> <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com> <20220926114416.t7t65u66ze76aiz7@quack3> <4539e48-417-edae-d42-9ef84602af0@google.com> <20220927103123.cvjbdx6lqv7jxa2w@quack3> <2b931ee7-1bc9-e389-9d9f-71eb778dcf1@google.com>
 <f975dddf-6ec-b3cb-3746-e91f61b22ea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
is a big improvement: without it, I had to revert to before commit
040b83fcecfb ("sbitmap: fix possible io hung due to lost wakeup")
to avoid the high system time and freezes which that had introduced.

Now okay on the NVME laptop, but 4acb83417cad is a disaster for heavy
swapping (kernel builds in low memory) on another: soon locking up in
sbitmap_queue_wake_up() (into which __sbq_wake_up() is inlined), cycling
around with waitqueue_active() but wait_cnt 0 .  Here is a backtrace,
showing the common pattern of outer sbitmap_queue_wake_up() interrupted
before setting wait_cnt 0 back to wake_batch (in some cases other CPUs
are idle, in other cases they're spinning for a lock in dd_bio_merge()):

sbitmap_queue_wake_up < sbitmap_queue_clear < blk_mq_put_tag <
__blk_mq_free_request < blk_mq_free_request < __blk_mq_end_request <
scsi_end_request < scsi_io_completion < scsi_finish_command <
scsi_complete < blk_complete_reqs < blk_done_softirq < __do_softirq <
__irq_exit_rcu < irq_exit_rcu < common_interrupt < asm_common_interrupt <
_raw_spin_unlock_irqrestore < __wake_up_common_lock < __wake_up <
sbitmap_queue_wake_up < sbitmap_queue_clear < blk_mq_put_tag <
__blk_mq_free_request < blk_mq_free_request < dd_bio_merge <
blk_mq_sched_bio_merge < blk_mq_attempt_bio_merge < blk_mq_submit_bio <
__submit_bio < submit_bio_noacct_nocheck < submit_bio_noacct <
submit_bio < __swap_writepage < swap_writepage < pageout <
shrink_folio_list < evict_folios < lru_gen_shrink_lruvec <
shrink_lruvec < shrink_node < do_try_to_free_pages < try_to_free_pages <
__alloc_pages_slowpath < __alloc_pages < folio_alloc < vma_alloc_folio <
do_anonymous_page < __handle_mm_fault < handle_mm_fault <
do_user_addr_fault < exc_page_fault < asm_exc_page_fault

See how the process-context sbitmap_queue_wake_up() has been interrupted,
after bringing wait_cnt down to 0 (and in this example, after doing its
wakeups), before advancing wake_index and refilling wake_cnt: an
interrupt-context sbitmap_queue_wake_up() of the same sbq gets stuck.

I have almost no grasp of all the possible sbitmap races, and their
consequences: but __sbq_wake_up() can do nothing useful while wait_cnt 0,
so it is better if sbq_wake_ptr() skips on to the next ws in that case:
which fixes the lockup and shows no adverse consequence for me.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
v2: - v1 to __sbq_wake_up() broke out when this happens, but
      v2 to sbq_wake_ptr() does better by skipping on to the next.
    - added more comment and deleted dubious Fixes attribution.
    - and apologies to Mr Axboe and all for my axbod typo

 lib/sbitmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -587,7 +587,7 @@ static struct sbq_wait_state *sbq_wake_p
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
-		if (waitqueue_active(&ws->wait)) {
+		if (waitqueue_active(&ws->wait) && atomic_read(&ws->wait_cnt)) {
 			if (wake_index != atomic_read(&sbq->wake_index))
 				atomic_set(&sbq->wake_index, wake_index);
 			return ws;
