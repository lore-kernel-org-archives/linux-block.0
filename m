Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA97BC10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 02:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F22206F7
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 02:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwYqiEf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgCMCcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:32:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39572 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726114AbgCMCcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 22:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584066732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jy7ru2lhZyV4XD4AwVfLYwfxqoUBvsmiFz87nnoF0Og=;
        b=fwYqiEf5eQQINrt/q22IODmKN8HbPf3zsZHqOWM+xfPbSF2ATeqx12139GeYjLy+xefmmr
        S6QPrM/6Hlrg9NVThx8yasLrIjST40rFjOiawN77hiqa+82BP58GtgR46qTCQ8xXyrJyNp
        NF+zG/4LOguPi2vGrNmbZ94jILvAq1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-W7_0KUXdOiWOMh2L-3ygpA-1; Thu, 12 Mar 2020 22:32:07 -0400
X-MC-Unique: W7_0KUXdOiWOMh2L-3ygpA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C62113F8;
        Fri, 13 Mar 2020 02:32:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-37.pek2.redhat.com [10.72.8.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6175F909FB;
        Fri, 13 Mar 2020 02:32:01 +0000 (UTC)
Date:   Fri, 13 Mar 2020 10:31:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Feng Li <lifeng1519@gmail.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [Question] IO is split by block layer when size is larger than 4k
Message-ID: <20200313023156.GB27275@ming.t460p>
References: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
 <20200312123415.GA7660@ming.t460p>
 <CAEK8JBAiBwghR5hXiDPETx=EGNi=OTQQz7DOaSXd=96QkUWTGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEK8JBAiBwghR5hXiDPETx=EGNi=OTQQz7DOaSXd=96QkUWTGg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 12, 2020 at 09:21:11PM +0800, Feng Li wrote:
> Hi Ming,
> Thanks.
> I have tested kernel '5.4.0-rc6+', which includes 07173c3ec276.
> But the virtio is still be filled with single page by page.

Hello,

Could you share your test script?

BTW, it depends if fs layer passes contiguous pages to block layer.

You can dump each bvec of the bio, and see if they are contiguous
physically.

Thanks,
Ming

>=20
> Ming Lei <ming.lei@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8812=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:34=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Mar 12, 2020 at 07:13:28PM +0800, Feng Li wrote:
> > > Hi experts,
> > >
> > > May I ask a question about block layer?
> > > When running fio in guest os, I find a 256k IO is split into the pa=
ge
> > > by page in bio, saved in bvecs.
> > > And virtio-blk just put the bio_vec one by one in the available
> > > descriptor table.
> > >
> > > So if my backend device does not support iovector
> > > opertion(preadv/pwritev), then IO is issued to a low layer page by
> > > page.
> > > My question is: why doesn't the bio save multi-pages in one bio_vec=
?
> >
> > We start multipage bvec since v5.1, especially since 07173c3ec276
> > ("block: enable multipage bvecs").
> >
> > Thanks,
> > Ming
> >
>=20

--=20
Ming

