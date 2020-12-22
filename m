Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A79C433DB
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 13:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B648E23133
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 13:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgLVN0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Dec 2020 08:26:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbgLVN0M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Dec 2020 08:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608643485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0CdssNXtolY/0xYUDMExZliyMsWlcG2nRZfwv4H7qI=;
        b=f6eBJyT7Ok+2GeMLHBYJ9bYLdHIuD2PjBdpDHN0IYq7LCAWvJQcwVzx+N0Sfo8ohs+zXRB
        CuwtWVhTpiHqT0ZnG6kiVjxnKdmxYFlD1evi6uBbZfL1zkJNUsx/NS6w57bBzno5SA22Z9
        L2IgHEye1wzzvqvDSSdNONzxgSXzeuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-bViHCkLyOM68OxpeBYxKSw-1; Tue, 22 Dec 2020 08:24:43 -0500
X-MC-Unique: bViHCkLyOM68OxpeBYxKSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E98D3107ACE6;
        Tue, 22 Dec 2020 13:24:41 +0000 (UTC)
Received: from T590 (ovpn-13-66.pek2.redhat.com [10.72.13.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D661E5C8A7;
        Tue, 22 Dec 2020 13:24:33 +0000 (UTC)
Date:   Tue, 22 Dec 2020 21:24:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, hare@suse.de, kashyap.desai@broadcom.com,
        linuxarm@huawei.com
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
Message-ID: <20201222132428.GA2938310@T590>
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
 <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
 <31de2806-bbc1-dcc3-b9eb-ce9257420432@acm.org>
 <b2edab2b-8af7-816d-9da2-4720d19b96f8@huawei.com>
 <e97a0603-f9e3-1b00-4a09-c569d4f73d7b@acm.org>
 <2d985fbd-7a22-6399-e214-8052604a2a65@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d985fbd-7a22-6399-e214-8052604a2a65@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 22, 2020 at 11:22:19AM +0000, John Garry wrote:
> Resend without ppvk@codeaurora.org, which bounces for me
> 
> On 22/12/2020 02:13, Bart Van Assche wrote:
> > On 12/21/20 10:47 AM, John Garry wrote:
> >> Yes, I agree, and I'm not sure what I wrote to give that impression.
> >>
> >> About "root partition", above, I'm just saying that / is mounted on a
> >> sda partition:
> >>
> >> root@ubuntu:/home/john# mount | grep sda
> >> /dev/sda2 on / type ext4 (rw,relatime,errors=remount-ro,stripe=32)
> >> /dev/sda1 on /boot/efi type vfat
> >> (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
> > Hi John,
> >
> 
> Hi Bart, Ming,
> 
> > Thanks for the clarification. I want to take back my suggestion about
> > adding rcu_read_lock() / rcu_read_unlock() in blk_mq_tagset_busy_iter()
> > since it is not allowed to sleep inside an RCU read-side critical
> > section, since blk_mq_tagset_busy_iter() is used in request timeout
> > handling and since there may be blk_mq_ops.timeout implementations that
> > sleep.
> 
> Yes, that's why I was going with atomic, rather than some synchronization
> primitive which may sleep.
> 
> >
> > Ming's suggestion to serialize blk_mq_tagset_busy_iter() and
> > blk_mq_free_rqs() looks interesting to me.
> >
> 
> So then we could have something like this:
> 
> ---8<---
> 
>  -435,9 +444,13 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q,
> busy_iter_fn *fn,
>     if (!blk_mq_hw_queue_mapped(hctx))
>             continue;
> 
> +    while (!atomic_inc_not_zero(&tags->iter_usage_counter));
> +
>     if (tags->nr_reserved_tags)
>         bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
>     bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
> 
> +    atomic_dec(&tags->iter_usage_counter);
> }

Then it is just one spin_lock variant, and you may have to consider
lock validation.

For example, scsi_host_busy() is called from scsi_log_completion()<-scsi_softirq_done(),
which may be run in irq context, then dead lock can be triggered when the irq
is fired during freeing request.

thanks,
Ming

