Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE057CA9EA0
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 11:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB83D21D7F
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 11:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bD7OxtAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfKDL7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:59:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53449 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727663AbfKDL7j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 06:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572868778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/s3YEvh2xEz6f1xfLOfcSC2xtpmsXL9FCggxTE73dE=;
        b=bD7OxtAOHJ8nqQsSxGqmTbHu9mmiSSde3c9W9d1xdn/bRR1aabFqvWgwV8IRdvtd8mrdoM
        AZnh8JSGWjU10JarFaEi3HxXF/xCIvmrGeQD7lkwo2J9bpW/enmvO76lETgtAOs0Qgkwee
        b2WhLKz39rtW6Oe1aar4s6637ZEwSos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-wGlYFAqDPFWTCF1rJvLJaQ-1; Mon, 04 Nov 2019 06:59:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBA6E1005500;
        Mon,  4 Nov 2019 11:59:33 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (unknown [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51BF560C88;
        Mon,  4 Nov 2019 11:59:33 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iocost: add a comment about locking in ioc_weight_write()
References: <20191104101811.GA20821@mwanda>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 04 Nov 2019 06:59:32 -0500
In-Reply-To: <20191104101811.GA20821@mwanda> (Dan Carpenter's message of "Mon,
        4 Nov 2019 13:18:11 +0300")
Message-ID: <x491runq2cb.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wGlYFAqDPFWTCF1rJvLJaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> It wasn't very clear that blkg_conf_prep() disables IRQ and that they
> are enabled in blkg_conf_finish() so this patch adds a comment about it.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Thanks, Dan!

> ---
> I don't know if it's too late to fold this in with the previous patch?
>
>  block/blk-iocost.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index a7ed434eae03..c5a8703ca6aa 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2095,6 +2095,7 @@ static ssize_t ioc_weight_write(struct kernfs_open_=
file *of, char *buf,
>  =09=09return nbytes;
>  =09}
> =20
> +=09/* blkg_conf_prep() takes the q->queue_lock and disables IRQs */
>  =09ret =3D blkg_conf_prep(blkcg, &blkcg_policy_iocost, buf, &ctx);
>  =09if (ret)
>  =09=09return ret;
> @@ -2115,6 +2116,7 @@ static ssize_t ioc_weight_write(struct kernfs_open_=
file *of, char *buf,
>  =09weight_updated(iocg);
>  =09spin_unlock(&iocg->ioc->lock);
> =20
> +=09/* blkg_conf_finish() unlocks the q->queue_lock and enables IRQs */
>  =09blkg_conf_finish(&ctx);
>  =09return nbytes;

