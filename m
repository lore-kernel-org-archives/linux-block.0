Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2555CA9ECF
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 15:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C4221835
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 15:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpQi41Xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfKAPjO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:39:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26232 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727100AbfKAPjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Nov 2019 11:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572622753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHv6A+h/Dq+ReB2buZXJaNywCF6LwXpddH9bma5MoT0=;
        b=JpQi41XtIjXk13n+kVPeh1xTklckwATC/cyhm1kw3UfJDMLdJ7+E37s8rLlcpmGTGb1eWj
        35ed93jPF0B7+JzO79g9nAREYA/xHYNbDb4lyBxNkZEu1vmpDEbHFeZeEtCzjKGR5ZqbN1
        jQ694sINfsMrXHzGJQrf0f+xjM8zSf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-tkS-tnEbNJuwIoKMtCvYvg-1; Fri, 01 Nov 2019 11:39:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E60BD1800D67;
        Fri,  1 Nov 2019 15:39:07 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FFA85C3FD;
        Fri,  1 Nov 2019 15:39:07 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iocost: don't nest spin_lock_irq in ioc_weight_write()
References: <20191031105341.GA26612@mwanda>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 01 Nov 2019 11:39:06 -0400
In-Reply-To: <20191031105341.GA26612@mwanda> (Dan Carpenter's message of "Thu,
        31 Oct 2019 13:53:41 +0300")
Message-ID: <x49d0ebd2sl.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: tkS-tnEbNJuwIoKMtCvYvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> This code causes a static analysis warning:
>
>     block/blk-iocost.c:2113 ioc_weight_write() error: double lock 'irq'
>
> We disable IRQs in blkg_conf_prep() and re-enable them in
> blkg_conf_finish().  IRQ disable/enable should not be nested because
> that means the IRQs will be enabled at the first unlock instead of the
> second one.

Can you please also add a comment stating that irqs were disabled in
blkg_conf_prep?  Otherwise future readers will surely be scratching
their heads trying to figure out why we do things two different ways in
the same function.

Thanks!
Jeff

>
> Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  block/blk-iocost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 2a3db80c1dce..a7ed434eae03 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2110,10 +2110,10 @@ static ssize_t ioc_weight_write(struct kernfs_ope=
n_file *of, char *buf,
>  =09=09=09goto einval;
>  =09}
> =20
> -=09spin_lock_irq(&iocg->ioc->lock);
> +=09spin_lock(&iocg->ioc->lock);
>  =09iocg->cfg_weight =3D v;
>  =09weight_updated(iocg);
> -=09spin_unlock_irq(&iocg->ioc->lock);
> +=09spin_unlock(&iocg->ioc->lock);
> =20
>  =09blkg_conf_finish(&ctx);
>  =09return nbytes;

