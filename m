Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F376CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 07:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362A02070B
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 07:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvMHSLTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391424AbfJYHXM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:23:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30854 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391415AbfJYHXM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 03:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571988190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x70SrBGHlcdVa7joYasOu8to/QO61SnJemtezo1rnws=;
        b=WvMHSLTIRLb79MRyzQ7aBt+qSq28Sx9uh2bQbLeIkMwNLYTdV6sMAwwbbkIKLj0LYUMIpg
        sRc/mmhSNlFFUoDuE5ejBxTNnx/L37luvH0XtxUp9isGviQSX95I7A10rtDy7di2RuTxcP
        KQvrTRYjfWCzg7Pnphb9hKQGZJvwaqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-nE4lUqGINVaE6_-FRbLWow-1; Fri, 25 Oct 2019 03:23:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33B2180183D;
        Fri, 25 Oct 2019 07:23:06 +0000 (UTC)
Received: from ming.t460p (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8AE15D713;
        Fri, 25 Oct 2019 07:22:57 +0000 (UTC)
Date:   Fri, 25 Oct 2019 15:22:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     James Smart <jsmart2021@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Shagun Agrawal <shagun.agrawal@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: Fix cpu indexing error in
 blk_mq_alloc_request_hctx()
Message-ID: <20191025072220.GA7197@ming.t460p>
References: <20191023175700.18615-1-jsmart2021@gmail.com>
 <CACVXFVN+xXL9EJbrCPC50vOD0sG1pX1npUFSNZSNGBLyutLh0w@mail.gmail.com>
 <cd913d58-1b06-69df-3b4e-7d00f2d4074f@kernel.dk>
 <810e40ce-a111-f56a-84d1-03f0e74f14e3@gmail.com>
MIME-Version: 1.0
In-Reply-To: <810e40ce-a111-f56a-84d1-03f0e74f14e3@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: nE4lUqGINVaE6_-FRbLWow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 24, 2019 at 11:53:26AM -0700, James Smart wrote:
> On 10/24/2019 6:02 AM, Jens Axboe wrote:
> > On 10/24/19 3:28 AM, Ming Lei wrote:
> > > The normal usage is that user doesn't specify the hctx for allocating
> > > request from, since blk-mq
> > > can figure out which hctx is used for allocation via queue mapping.
> > > Just wondering why NVMe
> > > FC/RDMA can't do that way?
> >=20
> > Fully agree, it'd be much nicer if that weird interface could just
> > die.
> >=20
>=20
> Well.  All depends on what you think a hctx corresponds to, which relates=
 to
> why the caller originally set nr_hw_queues to what it did. I think it is
> reasonable for the caller to say - this must be via this specific context=
.

Usually MQ is only for handling IO efficiently, and we seldom use
MQ for management purpose, such as, so far all admin queue is SQ.

>=20
> To the nvme fabric transports (rdma, fc, tcp) the hctx corresponds to the
> nvme controller queue to issue a request on. In the single case where the

Could you explain a bit about what the purpose of nvme controller is ?

> hctx is specified specifically, it is the 1st command on a new nvme
> controller queue. The command *must* be issued on the queue it is to
> initialize (this is different from pci nvme).  The hctx is specified so t=
he
> correct nvme queue is selected when the command comes down the request pa=
th.
> Saying "don't do that" means one of the following: a) snooping every rq o=
n
> the request path to spot initialization ios and move them to the right
> queue; or b) creating a duplicate non-blk-mq request path for this 1
> initialization io. Both of those are ugly.

In nvmf_connect_io_queue(), 'qid' has been encoded into instance of 'struct
nvme_command', that means the 'nvme controller' should know the
specified queue by parsing the command. So still not understand why you
have to submit the command via the specified queue.

Thanks,
Ming

