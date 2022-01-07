Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A411C433EF
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 14:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347934AbiAGO6z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jan 2022 09:58:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58664 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbiAGO6z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jan 2022 09:58:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 41582212C6;
        Fri,  7 Jan 2022 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641567534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+M3OTlcNIhKbjyMggTY5uMxWt3ZZp8965loljHciE0=;
        b=SeGpPiRRR6vTyNLaOomxMq6iudO2Fo4nMmpGkuvPuycFbakKjI179WnXG3tq6SxxSBmD8W
        4Vl8FRkPUZ+hdXMX5qNWbL6Uvia/bQzFJ8Lw8i9GLRla8kXxqs4YLGLUb9W/wgGug+abbP
        dwzzXIE8NZIL9vIp4F3Gly5jdyuIK2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641567534;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+M3OTlcNIhKbjyMggTY5uMxWt3ZZp8965loljHciE0=;
        b=gSI3f/cmp9WUxUxMP1EuF5U5BQvmB7Rb81zJ2qGJAKUGTAa91d4oCuAdGFJ98O5emyYFOA
        pT0WoXntuVyHz7Ag==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 36972A3B8E;
        Fri,  7 Jan 2022 14:58:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EDE03A05D7; Fri,  7 Jan 2022 15:58:53 +0100 (CET)
Date:   Fri, 7 Jan 2022 15:58:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/5 v2] bfq: Avoid use-after-free when moving processes
 between cgroups
Message-ID: <20220107145853.jvgupijrq2ejnhdt@quack3.lan>
References: <20220105143037.20542-1-jack@suse.cz>
 <527c2294-9a53-872a-330a-f337506cd08b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <527c2294-9a53-872a-330a-f337506cd08b@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 07-01-22 17:15:43, yukuai (C) wrote:
> 在 2022/01/05 22:36, Jan Kara 写道:
> > Hello,
> > 
> > here is the second version of my patches to fix use-after-free issues in BFQ
> > when processes with merged queues get moved to different cgroups. The patches
> > have survived some beating in my test VM but so far I fail to reproduce the
> > original KASAN reports so testing from people who can reproduce them is most
> > welcome. Thanks!
> > 
> > Changes since v1:
> > * Added fix for bfq_put_cooperator()
> > * Added fix to handle move between cgroups in bfq_merge_bio()
> > 
> > 								Honza
> > Previous versions:
> > Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
> > .
> > 
> 
> Hi,
> 
> I repoduced the problem again with this patchset...

Thanks for testing! 

> [   71.004788] BUG: KASAN: use-after-free in
> __bfq_deactivate_entity+0x21/0x290
> [   71.006328] Read of size 1 at addr ffff88817a3dc0b0 by task rmmod/801
> [   71.007723]
> [   71.008068] CPU: 7 PID: 801 Comm: rmmod Tainted: G        W
> 5.16.0-rc5-next-2021127
> [   71.009995] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> ?-20190727_073836-4
> [   71.012274] Call Trace:
> [   71.012603]  <TASK>
> [   71.012886]  dump_stack_lvl+0x34/0x44
> [   71.013379]  print_address_description.constprop.0.cold+0xab/0x36b
> [   71.014182]  ? __bfq_deactivate_entity+0x21/0x290
> [   71.014795]  ? __bfq_deactivate_entity+0x21/0x290
> [   71.015398]  kasan_report.cold+0x83/0xdf
> [   71.015904]  ? _raw_read_lock_bh+0x20/0x40
> [   71.016433]  ? __bfq_deactivate_entity+0x21/0x290
> [   71.017033]  __bfq_deactivate_entity+0x21/0x290
> [   71.017617]  bfq_pd_offline+0xc1/0x110
> [   71.018105]  blkcg_deactivate_policy+0x14b/0x210
...

> Here is the caller of  __bfq_deactivate_entity:
> (gdb) list *(bfq_pd_offline+0xc1)
> 0xffffffff81c504f1 is in bfq_pd_offline (block/bfq-cgroup.c:942).
> 937                      * entities to the idle tree. It happens if, in some
> 938                      * of the calls to bfq_bfqq_move() performed by
> 939                      * bfq_reparent_active_queues(), the queue to move
> is
> 940                      * empty and gets expired.
> 941                      */
> 942                     bfq_flush_idle_tree(st);
> 943             }
> 944
> 945             __bfq_deactivate_entity(entity, false);

So this is indeed strange. The group has in some of its idle service trees
an entity whose entity->sched_data points to already freed cgroup. In
particular it means the bfqq_entity_service_tree() leads to somewhere else
than the 'st' we called bfq_flush_idle_tree() with. This looks like a
different kind of problem AFAICT but still it needs fixing :). Can you
please run your reproducer with my patches + the attached debug patch on
top? Hopefully it should tell us more about the problematic entity and how
it got there... Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
