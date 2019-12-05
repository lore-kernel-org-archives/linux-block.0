Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB23C43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 08:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4A2464F
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 08:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJZACnMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfLEIJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:09:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48791 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726032AbfLEIJa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Dec 2019 03:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575533369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CCv+WLID+s0Qs837GBHsonwja0cpeDTvjDqFZCEgbo=;
        b=FJZACnMDvDdwbg2CH5Y2KA/Ov4XAzh4XKqSxZ8QjgaPYPGIi1BLrYoKe9IclvP804RFVbk
        PcHuy+dpZ++KpNfUAvMvSdUJvoSX905dsFJUk7s4a1aI8gmf2iue6fkH04vYcXFeBos6HJ
        9BDng5bnWz0T/PztNmulCGxh/Vj/gis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-5j_1D3l1Oh2YdRDADPiR_Q-1; Thu, 05 Dec 2019 03:09:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE02F107ACCC;
        Thu,  5 Dec 2019 08:09:24 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D15855D9C5;
        Thu,  5 Dec 2019 08:09:19 +0000 (UTC)
Date:   Thu, 5 Dec 2019 16:09:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Justin Tee <justin.tee@broadcom.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: fix memleak of bio integrity data
Message-ID: <20191205080915.GB21955@ming.t460p>
References: <20191205020901.18737-1-ming.lei@redhat.com>
 <CAAmqgVN6huL60c9aw41yC6wz6fG0w-T4xR0Tuoz0PqX2BqwKDA@mail.gmail.com>
 <20191205074932.GA21955@ming.t460p>
MIME-Version: 1.0
In-Reply-To: <20191205074932.GA21955@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 5j_1D3l1Oh2YdRDADPiR_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 05, 2019 at 03:49:32PM +0800, Ming Lei wrote:
> On Wed, Dec 04, 2019 at 09:41:24PM -0800, Justin Tee wrote:
> > Hi Ming,
> >=20
> > I understand the patch, but I have a concern.
> >=20
> > Is it possible to come across a double-free?  from bio_endio ->
> > bio_integrity_endio -> __bio_integrity_endio -> bio_integrity_free;  An=
d
> > then, resuming in bio_endio -> bio_uninit -> bio_integrity_free;.  Mayb=
e
> > it's even possible queue_work  bio_integrity_verify_fn was scheduled an=
d
> > called bio_integrity_free from there as well.  So, should also remove
> > bio_integrity_free from bio_integrity_verify_fn and __bio_integrity_end=
io
> > routines?
>=20
> Yeah, double-free could be caused for READ between bio_integrity_verify_f=
n()
> and bio_uninit().

ooops, the above race doesn't exist because __bio_integrity_endio()
returns false and bio_endio() won't call bio_uninit(). And bio_uninit()
is only called from bio_endio() when bio_integrity_verify_fn() exits.

Also we can't remove the bio_integrity_free() from bio_integrity_verify_fn(=
),
otherwise this bio may never be ended because bio_integrity_endio() will
schedule the verify_fn again if bio_integrity_verify_fn() won't clear
REQ_INTEGRITY.

So bio_integrity_free() is always called serially, and the flag of REQ_INTE=
GRITY=20
guarantees that it is only freed once.

I think there isn't such double free you mentioned.

Thanks,
Ming

