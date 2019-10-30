Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699DBCA9EAE
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 00:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B84A20874
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 00:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQJbIYv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfJ3AVn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 20:21:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfJ3AVn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 20:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572394902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjdvnhncfNi/W+JuJj98kwA7XrsWnHo1724kW93jlUo=;
        b=CQJbIYv/AKfGERbYwKBwfjV4g9wRnHqND4QxqIX6UIOx9U4VOuq3Ob2Kco32vkxnEtrWK4
        8KDmxiBBj7e3a9nPAZz3HQUiJJg7/XU9ZTXMJEeZmrM8dba/rqdOs2dBLM0zjDxXylsfaz
        6PphWQ3RgqnukIDjYkAAfDTPqnI5Ayo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-eKE4v4OgMmGUjrGEwm7oaw-1; Tue, 29 Oct 2019 20:21:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 403591800D7B;
        Wed, 30 Oct 2019 00:21:37 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB53A5D6D4;
        Wed, 30 Oct 2019 00:21:30 +0000 (UTC)
Date:   Wed, 30 Oct 2019 08:21:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>, Keith Busch <kbusch@kernel.org>,
        linux-bcache@vger.kernel.org
Subject: Re: [PATCH V3] block: optimize for small block size IO
Message-ID: <20191030002126.GA14423@ming.t460p>
References: <20191029105125.12928-1-ming.lei@redhat.com>
 <20191029110425.GA4382@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20191029110425.GA4382@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: eKE4v4OgMmGUjrGEwm7oaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 29, 2019 at 04:04:25AM -0700, Christoph Hellwig wrote:
> I still haven't seen an explanation why this simple thing doesn't work
> just as well:
>=20
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 48e6725b32ee..f3073700166f 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -309,6 +309,11 @@ void __blk_queue_split(struct request_queue *q, stru=
ct bio **bio,
>  =09=09=09=09nr_segs);
>  =09=09break;
>  =09default:
> +=09=09if ((*bio)->bi_vcnt =3D=3D 1 &&
> +=09=09    (*bio)->bi_io_vec[0].bv_len <=3D PAGE_SIZE) {
> +=09=09=09*nr_segs =3D 1;
> +=09=09=09return;
> +=09=09}
>  =09=09split =3D blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
>  =09=09break;
>  =09}

This bio(*bio) may be a fast-cloned bio from somewhere(DM, MD, ...), so the=
 above
check can't work sometime.


thanks,
Ming

