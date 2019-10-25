Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20301CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA97C21D81
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 22:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLI37wRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfJYWUT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:20:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32356 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725801AbfJYWUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 18:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572042017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Zsbl6jnWDXGCBXQBzO05E0GImJlmuG12r7dJpWpf1g=;
        b=fLI37wRZch2eXkq7ou2Wxwvyrx4mO1Q61wJPcLxy2TGJ6GpuZUqQLbBTJ4HRjWsvEBpLz/
        TYOdn731OXsYzx7YnfRwfgpB9dxMcNKaPw6QRL978YbLBFY75Qwmiy3kYie+AHQ6Xzwk7+
        SBlyX2XEsnqR3r0GySP9qTbqjg2pWBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-JaQr87guNWCa3LzTejJ-ug-1; Fri, 25 Oct 2019 18:20:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A92A80183E;
        Fri, 25 Oct 2019 22:20:12 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBEB679B4;
        Fri, 25 Oct 2019 22:20:05 +0000 (UTC)
Date:   Sat, 26 Oct 2019 06:20:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     James Smart <jsmart2021@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Shagun Agrawal <shagun.agrawal@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: Fix cpu indexing error in
 blk_mq_alloc_request_hctx()
Message-ID: <20191025222000.GC7076@ming.t460p>
References: <20191023175700.18615-1-jsmart2021@gmail.com>
 <CACVXFVN+xXL9EJbrCPC50vOD0sG1pX1npUFSNZSNGBLyutLh0w@mail.gmail.com>
 <cd913d58-1b06-69df-3b4e-7d00f2d4074f@kernel.dk>
 <810e40ce-a111-f56a-84d1-03f0e74f14e3@gmail.com>
 <20191025072220.GA7197@ming.t460p>
 <60f569f8-688c-4b8a-86b4-48456253473a@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <60f569f8-688c-4b8a-86b4-48456253473a@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: JaQr87guNWCa3LzTejJ-ug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 25, 2019 at 01:26:46PM -0700, Sagi Grimberg wrote:
>=20
> > > hctx is specified specifically, it is the 1st command on a new nvme
> > > controller queue. The command *must* be issued on the queue it is to
> > > initialize (this is different from pci nvme).  The hctx is specified =
so the
> > > correct nvme queue is selected when the command comes down the reques=
t path.
> > > Saying "don't do that" means one of the following: a) snooping every =
rq on
> > > the request path to spot initialization ios and move them to the righ=
t
> > > queue; or b) creating a duplicate non-blk-mq request path for this 1
> > > initialization io. Both of those are ugly.
> >=20
> > In nvmf_connect_io_queue(), 'qid' has been encoded into instance of 'st=
ruct
> > nvme_command', that means the 'nvme controller' should know the
> > specified queue by parsing the command. So still not understand why you
> > have to submit the command via the specified queue.
>=20
> The connect command must be send on the queue that it is connecting, the
> qid is telling the controller the id of the queue, but the controller
> still expects the connect to be issued on the queue that it is designed
> to connect (or rather initialize).
>=20
> in queue_rq we take queue from hctx->driver_data and use it to issue
> the command. The connect is different that it is invoked on a context
> that is not necessarily running from a cpu that maps to this specific
> hctx. So in essence what is needed is a tag from the specific queue tags
> without running cpu consideration.

OK, got it.

If nvmf_connect_io_queue() is only run before setting up IO queues, the
shared tag problem could be solved easily, such as, use a standalone
tagset?


Thanks,
Ming

