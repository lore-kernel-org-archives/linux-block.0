Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6DFC432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 02:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C048622316
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 02:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="be11StNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKSCi2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:38:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36146 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726996AbfKSCi1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 21:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574131106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQQK+dd+C6x1UYB7rg17UnNndtIRhUCCfcUEwZB60rA=;
        b=be11StNcer/EYPAUbip0sAa64adc4tzF5DCHVACZnbAZVeI5OUPjy08J53pStbqxBPBv94
        BjrupDiQENImVwA/kxnqFFUQwZt9agn76fkXLsiBfJSzUCh1GMYba1sOipVEg2KFOpY9dU
        J0FnpNmuypdp85VlpEISEi1jiTL2OLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-eo5gnpnAMOyNhPqheNAh5Q-1; Mon, 18 Nov 2019 21:38:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66D13107ACC5;
        Tue, 19 Nov 2019 02:38:21 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F5B35E251;
        Tue, 19 Nov 2019 02:38:13 +0000 (UTC)
Date:   Tue, 19 Nov 2019 10:38:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
Message-ID: <20191119023809.GD391@ming.t460p>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
 <20191119003437.GA1950@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20191119003437.GA1950@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: eo5gnpnAMOyNhPqheNAh5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 19, 2019 at 09:34:37AM +0900, Keith Busch wrote:
> On Mon, Nov 18, 2019 at 04:05:56PM -0800, Sagi Grimberg wrote:
> >=20
> > I'm starting to think we maybe need to get the connect out of the block
> > layer execution if its such a big problem... Its a real shame if that i=
s
> > the case...
>=20
> We still need timeout handling for connect commands, so bypassing the
> block layer will need to figure out some other way to handle that.
>=20
> This patch proposal doesn't really handle the timeouts very well either,
> though: nvme_rdma_timeout() is going to end up referncing the wrong
> queue rather than the one the request was submitted on. It doesn't
> appear to really matter in the current code since it just resets the
> entire controller, but if it ever wanted to do something queue specific..=
.

I am not sure it is an issue.

Given timeout handler needs the queue for transporting the request
exactly for handling timeout, right?

Or when/what do you need the original submission queue for handling
connect request timeout?


Thanks,
Ming

