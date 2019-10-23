Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54947CA9EB9
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 18:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189AC20663
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 18:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qs2fV92O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfJWSmL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:42:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34695 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727446AbfJWSmL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 14:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571856129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9zHl115ZAGn0SiSUJ9KJFb3zp5zrPP5Ce+bU1dboBU=;
        b=Qs2fV92OsRG1Vy0pafe7MHdG7DuZ4hicAulIG62fhZ4xWFkcE9rLWx1qMMcuZv+L6zFbF1
        KptxsXu5LV2+Nwihr8GrZVh3kGJul6WUpIkiugKTV0JrqXvfBoUepxcp94wAE6HNO282mg
        VYX8+FaOJlQBghY/RQ0DWBXTR5N2PKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-wRC_W2mUNtK-3qobDeADbA-1; Wed, 23 Oct 2019 14:42:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EB6080183E;
        Wed, 23 Oct 2019 18:42:03 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D026A1001DE0;
        Wed, 23 Oct 2019 18:42:02 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] io_uring: ensure cq_entries is at least equal to or greater than sq_entries
References: <1571795864-56669-1-git-send-email-liuyun01@kylinos.cn>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 23 Oct 2019 14:42:01 -0400
In-Reply-To: <1571795864-56669-1-git-send-email-liuyun01@kylinos.cn> (Jackie
        Liu's message of "Wed, 23 Oct 2019 09:57:44 +0800")
Message-ID: <x49d0ennw1y.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: wRC_W2mUNtK-3qobDeADbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jackie Liu <liuyun01@kylinos.cn> writes:

> If cq_entries is smaller than sq_entries, it will cause a lot of overflow
> to appear. when customizing cq_entries, at least let him be no smaller th=
an
> sq_entries.
>
> Fixes: 95d8765bd9f2 ("io_uring: allow application controlled CQ ring size=
")
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  fs/io_uring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index b64cd2c..dfa9731 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -3784,7 +3784,7 @@ static int io_uring_create(unsigned entries, struct=
 io_uring_params *p)
>  =09=09 * to a power-of-two, if it isn't already. We do NOT impose
>  =09=09 * any cq vs sq ring sizing.
>  =09=09 */
> -=09=09if (!p->cq_entries || p->cq_entries > IORING_MAX_CQ_ENTRIES)
> +=09=09if (p->cq_entries < p->sq_entries || p->cq_entries > IORING_MAX_CQ=
_ENTRIES)

What if they're both zero?  I think you want to keep that check.

-Jeff

