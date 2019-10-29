Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99ECCA9EB9
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 06:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E8820862
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 06:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5i+LY79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfJ2G1a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 02:27:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55088 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbfJ2G13 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 02:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572330448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LS16ruN7b0zodEnYBkZTB4tlXfQQNSVJhH9hV14tKRQ=;
        b=h5i+LY79E9uykgFPyd5+VGsahsTcOmNJzdfMz2Lv0AYApLkaHExGLSZriJkY7NMlPAu0ki
        vHyKfTUgCTG8Zu70cmdaJ/o0WxO/Z8T/aAXDTG6RI9SEzjq345ezkzzPipImrM2Z0daDyw
        Xfd6r6G5dPE+WotZE12Y8E21A5Z2oK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-ZgGthT2oNKmDjcF4YPNnFw-1; Tue, 29 Oct 2019 02:27:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A828E107AD28;
        Tue, 29 Oct 2019 06:27:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63CCB5D6C3;
        Tue, 29 Oct 2019 06:27:19 +0000 (UTC)
Date:   Tue, 29 Oct 2019 14:27:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Subject: Re: [PATCH] block: optimize for small BS IO
Message-ID: <20191029062715.GA20854@ming.t460p>
References: <20191029041904.16461-1-ming.lei@redhat.com>
 <20191029043024.GA9410@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20191029043024.GA9410@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ZgGthT2oNKmDjcF4YPNnFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 29, 2019 at 01:30:24PM +0900, Keith Busch wrote:
> On Tue, Oct 29, 2019 at 12:19:04PM +0800, Ming Lei wrote:
> > @@ -309,6 +309,10 @@ void __blk_queue_split(struct request_queue *q, st=
ruct bio **bio,
> >  =09=09=09=09nr_segs);
> >  =09=09break;
> >  =09default:
> > +=09=09if (!bio_flagged(*bio, BIO_MULTI_PAGE)) {
> > +=09=09=09*nr_segs =3D 1;
> > +=09=09=09return;
> > +=09=09}
> >  =09=09split =3D blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs)=
;
> >  =09=09break;
> >  =09}
>=20
> Is there anything to gain by clearing this new flag if the result of
> blk_bio_segment_split() creates single page bio's?

That may save nothing except for one bio split for stacking devices.

thanks,
Ming

