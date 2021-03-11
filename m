Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5096FC433DB
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 00:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC55D64FC0
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 00:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCKA7X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:59:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhCKA7J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 19:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615424348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MKJWdQZ9xVwyf7XoR6K/eDY0UWy7RkCHbwONKzeZFqY=;
        b=hfjlzuAYCpskiBG3eA1k3zMpBgMXo5vM5rl3u454nCDUPopCTifEq/mqmUUM8hTZR7rj6X
        wfJJm/Lj+MgfzAPrqixW8kmeSZkmys4RKVD6s8TW0tUPj8HDyl0TDz4R9kpUnSn4yZsLKd
        0RmTbItp4dqNfFKe6Ko7IfcgKjvLQL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-HI68m85zPqid4GvSdDfaiw-1; Wed, 10 Mar 2021 19:59:04 -0500
X-MC-Unique: HI68m85zPqid4GvSdDfaiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FDB88015BD;
        Thu, 11 Mar 2021 00:59:02 +0000 (UTC)
Received: from T590 (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC80810013D6;
        Thu, 11 Mar 2021 00:58:53 +0000 (UTC)
Date:   Thu, 11 Mar 2021 08:58:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     hare@suse.de, bvanassche@acm.org, axboe@kernel.dk, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pragalla@codeaurora.org, kashyap.desai@broadcom.com,
        yuyufen@huawei.com
Subject: Re: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for
 tagset in elevator_exit()
Message-ID: <YElrSFGyim3rjDN+@T590>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614957294-188540-3-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 05, 2021 at 11:14:53PM +0800, John Garry wrote:
> A use-after-free may occur if blk_mq_queue_tag_busy_iter() is run on a
> queue when another queue associated with the same tagset is switching IO
> scheduler:
> 
> BUG: KASAN: use-after-free in bt_iter+0xa0/0x120
> Read of size 8 at addr ffff0410285e7e00 by task fio/2302
> 
> CPU: 24 PID: 2302 Comm: fio Not tainted 5.12.0-rc1-11925-g29a317e228d9 #747
> Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018 
>  Call trace:
> dump_backtrace+0x0/0x2d8 
> show_stack+0x18/0x68
> dump_stack+0x124/0x1a0
> print_address_description.constprop.13+0x68/0x30c
> kasan_report+0x1e8/0x258 
> __asan_load8+0x9c/0xd8
> bt_iter+0xa0/0x120 
> blk_mq_queue_tag_busy_iter+0x348/0x5d8
> blk_mq_in_flight+0x80/0xb8
> part_stat_show+0xcc/0x210
> dev_attr_show+0x44/0x90
> sysfs_kf_seq_show+0x120/0x1c0
> kernfs_seq_show+0x9c/0xb8
> seq_read_iter+0x214/0x668
> kernfs_fop_read_iter+0x204/0x2c0
> new_sync_read+0x1ec/0x2d0
> vfs_read+0x18c/0x248
> ksys_read+0xc8/0x178
> __arm64_sys_read+0x44/0x58
> el0_svc_common.constprop.1+0xc8/0x1a8
> do_el0_svc+0x90/0xa0
> el0_svc+0x24/0x38
> el0_sync_handler+0x90/0xb8
> el0_sync+0x154/0x180
> 
> Indeed, blk_mq_queue_tag_busy_iter() already does take a reference to its
> queue usage counter when called, and the queue cannot be frozen to switch
> IO scheduler until all refs are dropped. This ensures no stale references
> to IO scheduler requests will be seen by blk_mq_queue_tag_busy_iter().
> 
> However, there is nothing to stop blk_mq_queue_tag_busy_iter() being
> run for another queue associated with the same tagset, and it seeing
> a stale IO scheduler request from the other queue after they are freed.
> 
> To stop this happening, freeze and quiesce all queues associated with the
> tagset as the elevator is exited.

I think this way can't be accepted since switching one queue's scheduler
is nothing to do with other request queues attached to same HBA.

This patch will cause performance regression because userspace may
switch scheduler according to medium or workloads, at that time other
LUNs will be affected by this patch.


-- 
Ming

