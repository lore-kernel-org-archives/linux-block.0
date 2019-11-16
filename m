Return-Path: <SRS0=wO3m=ZI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F98EC432C3
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 07:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DAB20728
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 07:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0KySZP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfKPHSQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Nov 2019 02:18:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38262 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726034AbfKPHSP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Nov 2019 02:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573888694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iF8Nu5xQV2DOoMLANoogmWICSnIYFII+kCs4jg6qoQ8=;
        b=K0KySZP0ddVUo2u/n7FtNUiLFXFLES95IWrvjjslqd8VV6cZJo6WvqNaFoXWafL1MsC2om
        s0Bwc2yaF1lw3y+Pf7s8Cm3gqt8ehac7qrgGiP4HDUxcRW1a64tmLy1QoPHrxo3uWLcafT
        zyiSoIyWNXNO5HhTUFpT+4xHlKevwg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-3YxTDElzOgSqa9G0CbmcVw-1; Sat, 16 Nov 2019 02:18:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6C9A593A8;
        Sat, 16 Nov 2019 07:18:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BED835D6D2;
        Sat, 16 Nov 2019 07:18:00 +0000 (UTC)
Date:   Sat, 16 Nov 2019 15:17:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
Message-ID: <20191116071754.GB18194@ming.t460p>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3YxTDElzOgSqa9G0CbmcVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi,

On Fri, Nov 15, 2019 at 02:38:44PM -0800, Sagi Grimberg wrote:
>=20
> > Hi,
>=20
> Hey Ming,
>=20
> > Use blk_mq_alloc_request() for allocating NVMe loop, fc, rdma and tcp's
> > connect request, and selecting transport queue runtime for connect
> > request.
> >=20
> > Then kill blk_mq_alloc_request_hctx().
>=20
> Is it really so wrong to have an API to allocate a tag that belongs to
> a specific queue? Why must the tags allocation always correlate to the
> running cpu? Its true that NVMe is the only consumer of this at the
> moment, but does this mean that the interface should be removed because
> it has one (or rather four) consumer(s)?

Now blk-mq takes a static queue mapping between CPU and hw queues, given
CPU hotplug may happen any time, so the specified hw queue may become
inactive any time.

Queue mapping from CPU to hw queue is one core model of blk-mq which
relies a lot on the fact that hw queue active or not depends on
request's submission CPU. And we always can retrieve one active hw
queue if there is at least one online CPU.

IO request is always mapped to the proper hw queue via the submission
CPU and queue type.

So blk_mq_alloc_request_hctx() is really weird from the above blk-mq's
model.

Actually the 4 consumer is just one single type of usage for submitting
connect command, seems no one explain this special usage before. And the
driver can handle well enough without this interface just like this
patch, can't it?

>=20
> I would instead suggest to simply remove the constraint that
> blk_mq_alloc_request_hctx() will fail if the first cpu in the mask
> is not on the cpu_online_mask.. The caller of this would know and
> be able to handle it.

Of course, this usage is very special, which is different with normal
IO or passthrough request.

The caller of this still needs to rely on blk-mq for dispatching this
request:

1) blk-mq needs to run hw queue in round-robin style, and different
CPU is selected from active CPU masks for running the hw queue.

2) Most of blk-mq drivers have switched to managed IRQ, which may be
shutdown even though there is still in-flight requests not completed
on the hw queue. We need to fix this issue. One solution is to free
the request and remap the bios into proper active hw queue according to
the new submission CPU.

3) warning will be caused when dispatching one request on inactive hw queue

If we are going to support this special usage, lots of blk-mq needs to
be changed for covering the so special case.

>=20
> To me it feels like this approach is fundamentally wrong. IMO, having
> the driver select a different queue than the tag naturally belongs to
> feels like a backwards design.

The root cause is that the connection command needs to be submitted via
one specified queue, which is fundamentally not compatible with blk-mq's
queue mapping model.

Given the connect command is so special for nvme, I'd suggest to let driver
handle it completely, since blk-mq is supposed to serve generic IO function=
.


Thanks,
Ming

