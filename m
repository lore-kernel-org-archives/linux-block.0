Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925B3C6FA82
	for <linux-block@archiver.kernel.org>; Sun, 18 Sep 2022 21:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIRVLO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Sep 2022 17:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIRVLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2022 17:11:13 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB4EE084
        for <linux-block@vger.kernel.org>; Sun, 18 Sep 2022 14:11:12 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id ml1so20632926qvb.1
        for <linux-block@vger.kernel.org>; Sun, 18 Sep 2022 14:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=UFsuxA6/C4rSRdMsXNxuwZ9ga1EMJaW1urs2eGrYQJA=;
        b=OV1fvONaztx1a28mzQTfh14ez+xCms2Govf+yuKsKMB8IDqCsTV/bjHRVM0mhKwI4u
         WWhxoqTA779MErMThIhFdmtW1/1TxPbV0CYCjmJyD0RZBG4Va4O/vrGJpTBjrIe5zsI8
         Tj3UP1kd4z22YtLf6HW8lzBu0o6VTYTxDeeZTwvImQQF+ziupyV/nzsC9pRN7xXSGWK2
         bUEkAsu/TWZvhznNk85UuWULXPchXUzZZps4ht+EsPcV7KowADHN742CTmdpSP2h4dt+
         8pI56Im+bS7VLw0LDkUdbM6p3Qi8HZQB4QJ9YTUVQ+rS7GU9tLC1UG2mknz4BzCwhqfe
         uRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=UFsuxA6/C4rSRdMsXNxuwZ9ga1EMJaW1urs2eGrYQJA=;
        b=qzueg1X5VlTuFhRTytJnzJf249EUvkEcxA+GH1aq1ZMer6ETTPQmW1SRs7WyhVmAh9
         +/zK5/y3vimlpkTe/D8L8nVHQrZddCayrhcGZNs+jb6viDU7kTPfmwttl1+WDPLd/c56
         +kN78e7jE35o8w2oQ51RQEc2yPDelQSaXB9xvwdcbxAhXcJ+pJB6XTYj4pIhL3oGFUji
         oTwFZa+emrXlf6/zpsjd6+AguX3j3KrM2WE90D+ALv0rNxYpcUzE2QkeTGMIZALpDjcc
         W+hRrc7fXutiJQ5lh+QQaCsi4of6rzhBoHKuOaPTwW8rj/d3jVeuiWqiNboZvLcBZN0G
         BnnQ==
X-Gm-Message-State: ACrzQf1yiq30GtsrnsQuPN/5bXVZlAkH8wHClBykeMRMYqfS8Z1zhVL8
        5dsEcgVzYnr6cO945ZcyoYTgNg==
X-Google-Smtp-Source: AMsMyM6jHQBpInd4lV3PaaiLpUIDzeted7VKGkRIgrsFZO6D6wwxbxqMtO/dA30jYiaG9UaGKjasnA==
X-Received: by 2002:a05:6214:e69:b0:4ac:93e7:62f0 with SMTP id jz9-20020a0562140e6900b004ac93e762f0mr12350535qvb.40.1663535471096;
        Sun, 18 Sep 2022 14:11:11 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c8-20020a05620a268800b006ce60296f97sm10907958qkp.68.2022.09.18.14.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 14:11:10 -0700 (PDT)
Date:   Sun, 18 Sep 2022 14:10:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jens Axboe <axboe@kernel.dk>
cc:     Keith Busch <kbusch@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
        Jan Kara <jack@suse.cz>, Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH next] sbitmap: fix lockup while swapping
Message-ID: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com>
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

I have almost no grasp of all the possible sbitmap races, and their
consequences: but using the same !waitqueue_active() check as used
elsewhere, fixes the lockup and shows no adverse consequence for me.

Fixes: 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 lib/sbitmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -620,7 +620,7 @@ static bool __sbq_wake_up(struct sbitmap
 		 * function again to wakeup a new batch on a different 'ws'.
 		 */
 		if (cur == 0)
-			return true;
+			return !waitqueue_active(&ws->wait);
 		sub = min(*nr, cur);
 		wait_cnt = cur - sub;
 	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
