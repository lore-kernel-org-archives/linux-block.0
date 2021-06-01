Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E311BC47080
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 13:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD2360C3E
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 13:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhFANnS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:43:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55944 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhFANnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Jun 2021 09:43:18 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 51A3B1FD2A;
        Tue,  1 Jun 2021 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622554896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6GnZ67hvwfub3i576yXgkqNR8+ZAzFSY3dzkZnZmeI=;
        b=BtLVtDUM+A+vs5eTv02sPPkdaQGfHCylM0edVAk68M1AQjXNSHznlybwb0atBcQszKwk0W
        huu6ogaD4LG3wp1xAdqZNNEDiHjXtbmZ2lHU/2FXOz/8THupF1YDylsMqdii0IarSeVnqt
        P8WB/8QjagkzwjY4eGSPyTUUd5674eU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622554896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6GnZ67hvwfub3i576yXgkqNR8+ZAzFSY3dzkZnZmeI=;
        b=EPZQush8dbsRRZbeJ91xasGoKVkXzXaK5M3hSLMGKUH8R8hN1kEIjLit4oSiZGJ1AI5gRs
        7pWO58PFnmWK9IBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2E635118DD;
        Tue,  1 Jun 2021 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622554896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6GnZ67hvwfub3i576yXgkqNR8+ZAzFSY3dzkZnZmeI=;
        b=BtLVtDUM+A+vs5eTv02sPPkdaQGfHCylM0edVAk68M1AQjXNSHznlybwb0atBcQszKwk0W
        huu6ogaD4LG3wp1xAdqZNNEDiHjXtbmZ2lHU/2FXOz/8THupF1YDylsMqdii0IarSeVnqt
        P8WB/8QjagkzwjY4eGSPyTUUd5674eU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622554896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6GnZ67hvwfub3i576yXgkqNR8+ZAzFSY3dzkZnZmeI=;
        b=EPZQush8dbsRRZbeJ91xasGoKVkXzXaK5M3hSLMGKUH8R8hN1kEIjLit4oSiZGJ1AI5gRs
        7pWO58PFnmWK9IBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id e7bQChA5tmBNDwAALh3uQQ
        (envelope-from <hare@suse.de>); Tue, 01 Jun 2021 13:41:36 +0000
Subject: Re: [PATCH] block/genhd: use atomic_t for disk_event->block
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20210601110145.113365-1-hare@suse.de> <YLY1V/dTMeo3RGZd@T590>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <73783f6f-a3ec-907f-ea19-966e9d1457dc@suse.de>
Date:   Tue, 1 Jun 2021 15:41:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YLY1V/dTMeo3RGZd@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/1/21 3:25 PM, Ming Lei wrote:
> On Tue, Jun 01, 2021 at 01:01:45PM +0200, Hannes Reinecke wrote:
>> __disk_unblock_events() will call queue_delayed_work() with a '0' argument
>> under a spin lock. This might cause the queue_work item to be executed
>> immediately, and run into a deadlock in disk_check_events() waiting for
>> the lock to be released.
> 
> Do you have lockdep warning on this 'deadlock'?
> 
> Executed immediately doesn't mean the work fn is run in the current
> task context, and it is actually run in one wq worker(task) context, so
> __queue_work() usually wakes up one wq worker for running the work fn,
> then there shouldn't be the 'deadlock' you mentioned.
> 

That's what I thought, too, but then we have a customer report
complaining about a stuck installation, and this kernel message:

> [  990.305908] INFO: task init:1 blocked for more than 491 seconds.
> [  990.311904]       Not tainted 5.3.18-22-default #1
> [  990.316682] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
> [  990.324483] init            D    0     1      0 0x00000000
> [  990.329950] Call Trace:
> [  990.332396]  __schedule+0x28a/0x6d0
> [  990.335876]  ? work_busy+0x80/0x80
> [  990.339267]  schedule+0x2f/0xa0
> [  990.342399]  schedule_timeout+0x1dd/0x300
> [  990.346399]  ? check_preempt_curr+0x29/0x80
> [  990.350569]  ? ttwu_do_wakeup+0x19/0x150
> [  990.354480]  ? work_busy+0x80/0x80
> [  990.357869]  wait_for_completion+0xba/0x140
> [  990.362040]  ? wake_up_q+0xa0/0xa0
> [  990.365430]  __flush_work+0x177/0x1d0
> [  990.369080]  ? worker_detach_from_pool+0xa0/0xa0
> [  990.373682]  __cancel_work_timer+0x12b/0x1b0
> [  990.377940]  ? exact_lock+0xd/0x20
> [  990.381329]  ? kobj_lookup+0x113/0x160
> [  990.385067]  disk_block_events+0x78/0x90
> [  990.388979]  __blkdev_get+0x6d/0x7e0
> [  990.392542]  ? blkdev_get_by_dev+0x40/0x40
> [  990.396627]  do_dentry_open+0x1ea/0x380
> [  990.400450]  path_openat+0x2fc/0x1520
> [  990.404103]  do_filp_open+0x9b/0x110
> [  990.407667]  ? kmem_cache_alloc+0x3d/0x250
> [  990.411749]  ? do_sys_open+0x1bd/0x250
> [  990.415486]  do_sys_open+0x1bd/0x250
> [  990.419052]  do_syscall_64+0x5b/0x1e0
> [  990.422701]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Which does vanish with this patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
