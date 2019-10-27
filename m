Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5324CA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 07:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755382064A
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 07:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuHlcfab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfJ0HXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 03:23:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27735 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725977AbfJ0HXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 03:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572161014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAtSSssvajVEWgYWSy7q2UmHJQF3QpK/85mlpDKVIJ0=;
        b=DuHlcfaba+R3q6Ng48P9boiGc+6PTZh/RmsR4OpTDKRIMeKwnzzKiAu7plMSqXVqPR6ZBO
        d0N+8R8R+/8RqpcV/N231R2WLKCQwJmGPhQyjXjqFmJ3tz8CnEVa6ipnMacSW2VIMKG3e3
        m81LWJMWghpCIL6SfJQFqGJTUMxQXyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-XVqUn6xrOgCDqXOAcuBGKQ-1; Sun, 27 Oct 2019 03:23:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D830080183E;
        Sun, 27 Oct 2019 07:23:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D962F5D712;
        Sun, 27 Oct 2019 07:23:22 +0000 (UTC)
Date:   Sun, 27 Oct 2019 15:23:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     James Smart <jsmart2021@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Shagun Agrawal <shagun.agrawal@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: Fix cpu indexing error in
 blk_mq_alloc_request_hctx()
Message-ID: <20191027072315.GA16704@ming.t460p>
References: <20191023175700.18615-1-jsmart2021@gmail.com>
 <CACVXFVN+xXL9EJbrCPC50vOD0sG1pX1npUFSNZSNGBLyutLh0w@mail.gmail.com>
 <cd913d58-1b06-69df-3b4e-7d00f2d4074f@kernel.dk>
 <810e40ce-a111-f56a-84d1-03f0e74f14e3@gmail.com>
 <20191025072220.GA7197@ming.t460p>
 <60f569f8-688c-4b8a-86b4-48456253473a@grimberg.me>
 <20191025222000.GC7076@ming.t460p>
 <ed9cf494-143a-409e-cd73-1d410eb81430@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <ed9cf494-143a-409e-cd73-1d410eb81430@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: XVqUn6xrOgCDqXOAcuBGKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 25, 2019 at 03:33:15PM -0700, Sagi Grimberg wrote:
>=20
> > > > > hctx is specified specifically, it is the 1st command on a new nv=
me
> > > > > controller queue. The command *must* be issued on the queue it is=
 to
> > > > > initialize (this is different from pci nvme).  The hctx is specif=
ied so the
> > > > > correct nvme queue is selected when the command comes down the re=
quest path.
> > > > > Saying "don't do that" means one of the following: a) snooping ev=
ery rq on
> > > > > the request path to spot initialization ios and move them to the =
right
> > > > > queue; or b) creating a duplicate non-blk-mq request path for thi=
s 1
> > > > > initialization io. Both of those are ugly.
> > > >=20
> > > > In nvmf_connect_io_queue(), 'qid' has been encoded into instance of=
 'struct
> > > > nvme_command', that means the 'nvme controller' should know the
> > > > specified queue by parsing the command. So still not understand why=
 you
> > > > have to submit the command via the specified queue.
> > >=20
> > > The connect command must be send on the queue that it is connecting, =
the
> > > qid is telling the controller the id of the queue, but the controller
> > > still expects the connect to be issued on the queue that it is design=
ed
> > > to connect (or rather initialize).
> > >=20
> > > in queue_rq we take queue from hctx->driver_data and use it to issue
> > > the command. The connect is different that it is invoked on a context
> > > that is not necessarily running from a cpu that maps to this specific
> > > hctx. So in essence what is needed is a tag from the specific queue t=
ags
> > > without running cpu consideration.
> >=20
> > OK, got it.
> >=20
> > If nvmf_connect_io_queue() is only run before setting up IO queues, the
> > shared tag problem could be solved easily, such as, use a standalone
> > tagset?
>=20
> Not sure what you mean exactly...
>=20
> Also, keep in mind that this sequence also goes into reconnects, where
> we already have our tagset allocated (with pending requests
> potentially).

I just found the connect command is always submitted via the unique reserve=
d
tag 0, so it is nothing to do with IO requests any more.

You can use the reserved tag 0 for connect command as before just by not
sharing tagset between connect queue and IO queues.

Follows the detailed idea:

1) still reserve 1 tag for connect command in the IO tagset.

2) in each driver, create a conn_tagset for .connect_q only, and create
the .connect_q from this 'conn_tagset', and sets conn_tagset.nr_hw_queues
as 1, and sets conn_tagset.queue_depth as 'ctrl.queue_count - 1'

3) in .queue_rq of conn_tagset.ops:

- parse index of queue to be connected from nvme_command.conn.qid
- set the connect command's tag as 0
- then do every other thing just like before


Thanks,
Ming

