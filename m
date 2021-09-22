Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B083CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 09:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CAD6136F
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 09:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhIVJXn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 05:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234290AbhIVJXm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 05:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632302532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3Q68iPY2i1vTKFIBJAwvjKbsdFYrmn07/rm3Ve2c6E=;
        b=Z3HmL5RjRDlfRR+o7hsqNf8VdDtQLFH72VOhbmVyxk8UaPr7iin73AnnOUIltHzb1/QKzj
        j3fRGOv/qvEUy/7xhCcNbMQPEiZmVu7zxaKLDUUhjnG8dtSBVWqhfSv4VC2VBvrrdW6wCC
        GThfIRWo3DskePgusz7+apIpmR2vPX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-j1dwDayBO225cQshvljKnw-1; Wed, 22 Sep 2021 05:22:09 -0400
X-MC-Unique: j1dwDayBO225cQshvljKnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07D1B1006B10;
        Wed, 22 Sep 2021 09:22:08 +0000 (UTC)
Received: from T590 (ovpn-8-35.pek2.redhat.com [10.72.8.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C39D385;
        Wed, 22 Sep 2021 09:21:56 +0000 (UTC)
Date:   Wed, 22 Sep 2021 17:22:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [patch v8 3/7] nbd: check sock index in nbd_read_stat()
Message-ID: <YUr1v8zylPOFFXTO@T590>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
 <20210916093350.1410403-4-yukuai3@huawei.com>
 <7e2913ca-1089-9ab7-cfdb-5e8837d36034@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e2913ca-1089-9ab7-cfdb-5e8837d36034@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 19, 2021 at 06:34:28PM +0800, yukuai (C) wrote:
> On 2021/09/16 17:33, Yu Kuai wrote:
> > The sock that clent send request in nbd_send_cmd() and receive reply
> > in nbd_read_stat() should be the same.
> > 
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >   drivers/block/nbd.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 614c6ab2b8fe..c724a5bd7fa4 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -746,6 +746,10 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
> >   		ret = -ENOENT;
> >   		goto out;
> >   	}
> > +	if (cmd->index != index) {
> > +		dev_err(disk_to_dev(nbd->disk), "Unexpected reply %d from different sock %d (expected %d)",
> > +			tag, index, cmd->index);
> > +	}
> >   	if (cmd->cmd_cookie != nbd_handle_to_cookie(handle)) {
> >   		dev_err(disk_to_dev(nbd->disk), "Double reply on req %p, cmd_cookie %u, handle cookie %u\n",
> >   			req, cmd->cmd_cookie, nbd_handle_to_cookie(handle));
> > 
> 
> Hi, Ming
> 
> Any suggestions about this patch?

I think this one relies on nbd protocol between server and client, and
does the protocol require both request and reply xmitted via same
socket?


Thanks,
Ming

