Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA855C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 06:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFFC6115C
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 06:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbhINGqN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 02:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239015AbhINGqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 02:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631601894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fYK5sEmID0j5qcEt2Vje6PqJTkmVq5tCDNx2hY9LSLA=;
        b=Kj3spxuk2/aeM5oEAIJxphkxXIWI8NLZiLXITHByrXUwIvG8N8DJRUJFl78ORtkPforNmc
        XC6YLrPpGX+Mv9mvw5ldjz1HbHVnvUAwDI8anXNujhAxVbJN6rgQb/8Ba6RCQ5DLzbiTDP
        5VTGO3xO/YiKuG9GCjwobdvyh+ogl8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-h85728iKOd6eWWcC3sOHSA-1; Tue, 14 Sep 2021 02:44:52 -0400
X-MC-Unique: h85728iKOd6eWWcC3sOHSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2524835DE0;
        Tue, 14 Sep 2021 06:44:50 +0000 (UTC)
Received: from T590 (ovpn-13-174.pek2.redhat.com [10.72.13.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD6EB10016F5;
        Tue, 14 Sep 2021 06:44:42 +0000 (UTC)
Date:   Tue, 14 Sep 2021 14:44:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v5 5/6] nbd: convert to use blk_mq_find_and_get_req()
Message-ID: <YUBE4BJ7+kN1c4l8@T590>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-6-yukuai3@huawei.com>
 <YT/2z4PSeW5oJWMq@T590>
 <c6af73a2-f12d-eeef-616e-ae0cdb4f6f2d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6af73a2-f12d-eeef-616e-ae0cdb4f6f2d@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 14, 2021 at 11:11:06AM +0800, yukuai (C) wrote:
> On 2021/09/14 9:11, Ming Lei wrote:
> > On Thu, Sep 09, 2021 at 10:12:55PM +0800, Yu Kuai wrote:
> > > blk_mq_tag_to_rq() can only ensure to return valid request in
> > > following situation:
> > > 
> > > 1) client send request message to server first
> > > submit_bio
> > > ...
> > >   blk_mq_get_tag
> > >   ...
> > >   blk_mq_get_driver_tag
> > >   ...
> > >   nbd_queue_rq
> > >    nbd_handle_cmd
> > >     nbd_send_cmd
> > > 
> > > 2) client receive respond message from server
> > > recv_work
> > >   nbd_read_stat
> > >    blk_mq_tag_to_rq
> > > 
> > > If step 1) is missing, blk_mq_tag_to_rq() will return a stale
> > > request, which might be freed. Thus convert to use
> > > blk_mq_find_and_get_req() to make sure the returned request is not
> > > freed.
> > 
> > But NBD_CMD_INFLIGHT has been added for checking if the reply is
> > expected, do we still need blk_mq_find_and_get_req() for covering
> > this issue? BTW, request and its payload is pre-allocated, so there
> > isn't real use-after-free.
> 
> Hi, Ming
> 
> Checking NBD_CMD_INFLIGHT relied on the request founded by tag is valid,
> not the other way round.
> 
> nbd_read_stat
>  req = blk_mq_tag_to_rq()
>  cmd = blk_mq_rq_to_pdu(req)
>  mutex_lock(cmd->lock)
>  checking NBD_CMD_INFLIGHT

Request and its payload is pre-allocated, and either req->ref or cmd->lock can
serve the same purpose here. Once cmd->lock is held, you can check if the cmd is
inflight or not. If it isn't inflight, just return -ENOENT. Is there any
problem to handle in this way?


Thanks,
Ming

