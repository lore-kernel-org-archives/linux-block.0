Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F88C43334
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 00:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiGEAtt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 20:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiGEAts (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 20:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B871FCB
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656982186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1A0DNvpOU5CiU6rMLgfvUJNzaDDHxbYayOGIRyqRYo=;
        b=bOuaJFJTXLFV92tsePeUmbVOPqPp8pP7Ip0/UtWQyQvynz8bEV2vQZJn50gJtt5B8azGX9
        8myqjiGjRClv+ikqFu1ByG1pH9PCKpwxUsxca86mvKRD2KQi+7ERbVKbAIjwRzdQy6FZFW
        abthHq+kDv5aZXqx0CgFCp6SZGJNEXQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-A1KXb6U8MpGM_fvL501Qjw-1; Mon, 04 Jul 2022 20:49:43 -0400
X-MC-Unique: A1KXb6U8MpGM_fvL501Qjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D310185A79C;
        Tue,  5 Jul 2022 00:49:43 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 93DB71415309;
        Tue,  5 Jul 2022 00:49:39 +0000 (UTC)
Date:   Tue, 5 Jul 2022 08:49:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [bug report] nvme/rdma: nvme connect failed after offline one
 cpu on host side
Message-ID: <YsOKnb7MWLCeJxBE@T590>
References: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
 <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
 <2c42c70a-8eb4-a095-1d2b-139614ebd903@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c42c70a-8eb4-a095-1d2b-139614ebd903@grimberg.me>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 05, 2022 at 02:04:53AM +0300, Sagi Grimberg wrote:
> 
> > update the subject to better describe the issue:
> > 
> > So I tried this issue on one nvme/rdma environment, and it was also
> > reproducible, here are the steps:
> > 
> > # echo 0 >/sys/devices/system/cpu/cpu0/online
> > # dmesg | tail -10
> > [  781.577235] smpboot: CPU 0 is now offline
> > # nvme connect -t rdma -a 172.31.45.202 -s 4420 -n testnqn
> > Failed to write to /dev/nvme-fabrics: Invalid cross-device link
> > no controller found: failed to write to nvme-fabrics device
> > 
> > # dmesg
> > [  781.577235] smpboot: CPU 0 is now offline
> > [  799.471627] nvme nvme0: creating 39 I/O queues.
> > [  801.053782] nvme nvme0: mapped 39/0/0 default/read/poll queues.
> > [  801.064149] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
> > [  801.073059] nvme nvme0: failed to connect queue: 1 ret=-18
> 
> This is because of blk_mq_alloc_request_hctx() and was raised before.
> 
> IIRC there was reluctance to make it allocate a request for an hctx even
> if its associated mapped cpu is offline.
> 
> The latest attempt was from Ming:
> [PATCH V7 0/3] blk-mq: fix blk_mq_alloc_request_hctx
> 
> Don't know where that went tho...

The attempt relies on that the queue for connecting io queue uses
non-admined irq, unfortunately that can't be true for all drivers,
so that way can't go.

So far, I'd suggest to fix nvme_*_connect_io_queues() to ignore failed
io queue, then the nvme host still can be setup with less io queues.

Otherwise nvme_*_connect_io_queues() could fail easily, especially for
1:1 mapping.


Thanks,
Ming

