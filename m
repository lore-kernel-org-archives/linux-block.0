Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B0C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 06:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1A5222D3
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 06:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOQnlbaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfKMGzj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 01:55:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44281 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725866AbfKMGzi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 01:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573628136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4jRJtugazVNbSekrSPkf2Vjo2+aeKZ7KkZuOoMO1v0=;
        b=MOQnlbaN+drsvkO1wpw/tbSLYFQZLM+iIlTkKPeeiSBpSz5sD4fetFV834uMVKEzrZ7VP7
        0hz/4SYsurD7NM4mgNOgb+ek4x8EEPMlVcHHx7yF63glmYiP8RrE7Wb8OE2vZRXqGPueeX
        FLMd6VML998+o64MeKEg2zhHt4SXZpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-HbE0x8uXP9Cx5JCfiZ1CNg-1; Wed, 13 Nov 2019 01:55:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85501800EBE;
        Wed, 13 Nov 2019 06:55:34 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFB1C6019C;
        Wed, 13 Nov 2019 06:55:28 +0000 (UTC)
Date:   Wed, 13 Nov 2019 14:55:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bob Liu <bob.liu@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Bail out iteration functions upon SIGKILL.
Message-ID: <20191113065523.GA1985@ming.t460p>
References: <000000000000c52dbf05958f3f3a@google.com>
 <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
 <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
 <8fde32da-d5e5-11b7-9ed7-e3aa5b003647@i-love.sakura.ne.jp>
 <BYAPR04MB58165EC2C792CE26AAAF361FE7770@BYAPR04MB5816.namprd04.prod.outlook.com>
 <272e3542-72ab-12ff-636b-722a68a2589c@i-love.sakura.ne.jp>
 <BYAPR04MB5816D18E6F6633030265B06EE7760@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816D18E6F6633030265B06EE7760@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HbE0x8uXP9Cx5JCfiZ1CNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 13, 2019 at 01:54:14AM +0000, Damien Le Moal wrote:
> On 2019/11/12 23:48, Tetsuo Handa wrote:
> [...]
> >>> +static int blk_should_abort(struct bio *bio)
> >>> +{
> >>> +=09int ret;
> >>> +
> >>> +=09cond_resched();
> >>> +=09if (!fatal_signal_pending(current))
> >>> +=09=09return 0;
> >>> +=09ret =3D submit_bio_wait(bio);
> >>
> >> This will change the behavior of __blkdev_issue_discard() to a sync IO
> >> execution instead of the current async execution since submit_bio_wait=
()
> >> call is the responsibility of the caller (e.g. blkdev_issue_discard())=
.
> >> Have you checked if users of __blkdev_issue_discard() are OK with that=
 ?
> >> f2fs, ext4, xfs, dm and nvme use this function.
> >=20
> > I'm not sure...
> >=20
> >>
> >> Looking at f2fs, this does not look like it is going to work as expect=
ed
> >> since the bio setup, including end_io callback, is done after this
> >> function is called and a regular submit_bio() execution is being used.
> >=20
> > Then, just breaking the iteration like below?
> > nvmet_bdev_execute_write_zeroes() ignores -EINTR if "*biop =3D bio;" is=
 done. Is that no problem?
> >=20
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/bio.h>
> >  #include <linux/blkdev.h>
> >  #include <linux/scatterlist.h>
> > +#include <linux/sched/signal.h>
> > =20
> >  #include "blk.h"
> > =20
> > @@ -30,6 +31,7 @@ int __blkdev_issue_discard(struct block_device *bdev,=
 sector_t sector,
> >  =09struct bio *bio =3D *biop;
> >  =09unsigned int op;
> >  =09sector_t bs_mask;
> > +=09int ret =3D 0;
> > =20
> >  =09if (!q)
> >  =09=09return -ENXIO;
> > @@ -76,10 +78,14 @@ int __blkdev_issue_discard(struct block_device *bde=
v, sector_t sector,
> >  =09=09 * is disabled.
> >  =09=09 */
> >  =09=09cond_resched();
> > +=09=09if (fatal_signal_pending(current)) {
> > +=09=09=09ret =3D -EINTR;
> > +=09=09=09break;
> > +=09=09}
> >  =09}
> > =20
> >  =09*biop =3D bio;
> > -=09return 0;
> > +=09return ret;
>=20
> This will leak a bio as blkdev_issue_discard() executes the bio only in
> the case "if (!ret && bio)". So that does not work as is, unless all
> callers of __blkdev_issue_discard() are also changed. Same problem for
> the other __blkdev_issue_xxx() functions.
>=20
> Looking more into this, if an error is returned here, no bio should be
> returned and we need to make sure that all started bios are also
> completed. So your helper blk_should_abort() did the right thing calling
> submit_bio_wait(). However, I Think it would be better to fail
> immediately the current loop bio instead of executing it and then
> reporting the -EINTR error, unconditionally, regardless of what the
> started bios completion status is.
>=20
> This could be done with the help of a function like this, very similar
> to submit_bio_wait().
>=20
> void bio_chain_end_wait(struct bio *bio)
> {
> =09DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
>=20
> =09bio->bi_private =3D &done;
> =09bio->bi_end_io =3D submit_bio_wait_endio;
> =09bio->bi_opf |=3D REQ_SYNC;
> =09bio_endio(bio);
> =09wait_for_completion_io(&done);
> }
>=20
> And then your helper function becomes something like this:
>=20
> static int blk_should_abort(struct bio *bio)
> {
> =09int ret;
>=20
> =09cond_resched();
> =09if (!fatal_signal_pending(current))
> =09=09return 0;
>=20
> =09if (bio_flagged(bio, BIO_CHAIN))
> =09=09bio_chain_end_wait(bio);
> =09bio_put(bio);
>=20
> =09return -EINTR;
> }
>=20
> Thoughts ?

DISCARD request can be quite big, and any sync bio submission may cause
serious performance regression.

Not mention blkdev_issue_discard() may be called in non-block context.

Thanks,
Ming

