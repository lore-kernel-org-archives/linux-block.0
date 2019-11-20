Return-Path: <SRS0=usZV=ZM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EAEC432C0
	for <linux-block@archiver.kernel.org>; Wed, 20 Nov 2019 06:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138052245B
	for <linux-block@archiver.kernel.org>; Wed, 20 Nov 2019 06:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUe9rfAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKTGgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:36:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56870 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726685AbfKTGgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Nov 2019 01:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574231767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsXkh/VQI3KB8Zl4hHKe473v7riRmv/Z4J6X27T5pmM=;
        b=QUe9rfAmppkJgxvhdrcdMU7NgM/qdYNMed76LaRZUbqoAXZJjGwP2s1ePb5h9zDwnHdIJ1
        zzfbgv2Vc0rTTFkIzD4wafmxIEducxnbGjJy9imI6UYwVGIydnm6oIaHh7NB5nk++Rfe27
        JmbYW1AZSpnNJu+78/HCvTwdasCAY2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-TZ6SJJfHPPCktfDD586oLw-1; Wed, 20 Nov 2019 01:36:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60D021005500;
        Wed, 20 Nov 2019 06:36:02 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78B055C1B2;
        Wed, 20 Nov 2019 06:35:55 +0000 (UTC)
Date:   Wed, 20 Nov 2019 14:35:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     James Smart <james.smart@broadcom.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
Message-ID: <20191120063550.GA3664@ming.t460p>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
 <fda43a50-a484-dde7-84a1-94ccf9346bdd@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <fda43a50-a484-dde7-84a1-94ccf9346bdd@broadcom.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: TZ6SJJfHPPCktfDD586oLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 19, 2019 at 09:56:45AM -0800, James Smart wrote:
> On 11/18/2019 4:05 PM, Sagi Grimberg wrote:
> >=20
> > This is a much simpler fix that does not create this churn local to
> > every driver. Also, I don't like the assumptions about tag reservations
> > that the drivers is taking locally (that the connect will have tag 0
> > for example). All this makes this look like a hack.
>=20
> Agree with Sagi on this last statement. When I reviewed the patch, it was
> very non-intuitive. Why dependency on tag 0, why a queue number squirrell=
ed
> away on this one request only. Why change the initialization (queue point=
er)
> on this one specific request from its hctx and so on. For someone without
> the history, ugly.
>=20
> >=20
> > I'm starting to think we maybe need to get the connect out of the block
> > layer execution if its such a big problem... Its a real shame if that i=
s
> > the case...
>=20
> Yep. This is starting to be another case of perhaps I should be changing
> nvme-fc's blk-mq hctx to nvme queue relationship in a different manner.=
=A0 I'm
> having a very hard time with all the queue resources today's policy is
> wasting on targets.

Wrt. the above two points, I believe both are not an issue at all by
this driver specific approach, see my comment:

https://lore.kernel.org/linux-block/fda43a50-a484-dde7-84a1-94ccf9346bdd@br=
oadcom.com/T/#mb72afa6ed93bc852ca266779977634cf6214b329


Thanks,
Ming

