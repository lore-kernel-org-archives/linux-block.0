Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14976C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 09:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67C024650
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 09:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyqBu60I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLSJag (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:30:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34156 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726622AbfLSJag (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 04:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576747834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4W1nVu6HoVx2/JVZRR4HsxUE6nQRjs8uPBJtvq2dkI=;
        b=gyqBu60IQTyCuugDl0crjosKdEeKmQbTT5fUs/1X6BY/QC6c7PXoVDNyF1Qw+mUxLBYi57
        K6Kvvj42I91Zqty3o3gbYHyPFGO/t98Lxl7V1x6DHjAUlF5zDNp751QNbfmGC6NYI0ME6+
        crI3GRNxUzsaRvh0/eq0ZN6QpSW5Hqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-e0mFFv--Moqdqmz9b2FV0A-1; Thu, 19 Dec 2019 04:30:33 -0500
X-MC-Unique: e0mFFv--Moqdqmz9b2FV0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 158C5801E6D;
        Thu, 19 Dec 2019 09:30:31 +0000 (UTC)
Received: from gondolin (ovpn-117-134.ams2.redhat.com [10.36.117.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1483D6889A;
        Thu, 19 Dec 2019 09:30:28 +0000 (UTC)
Date:   Thu, 19 Dec 2019 10:30:26 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH 3/3] s390/dasd: fix typo in copyright statement
Message-ID: <20191219103026.75037abe.cohuck@redhat.com>
In-Reply-To: <20191219084352.75114-4-sth@linux.ibm.com>
References: <20191219084352.75114-1-sth@linux.ibm.com>
        <20191219084352.75114-4-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 19 Dec 2019 09:43:52 +0100
Stefan Haberland <sth@linux.ibm.com> wrote:

> coypright -> copyright
> 
> Reported-by: Kate Stewart <kstewart@linuxfoundation.org>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_fba.h  | 2 +-
>  drivers/s390/block/dasd_proc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_fba.h b/drivers/s390/block/dasd_fba.h
> index 8f75df06e893..45ddabec4017 100644
> --- a/drivers/s390/block/dasd_fba.h
> +++ b/drivers/s390/block/dasd_fba.h
> @@ -2,7 +2,7 @@
>  /*
>   * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
>   * Bugreports.to..: <Linux390@de.ibm.com>

No comment on the actual patch; but do you really still want people to
send bug reports to that address?

(A quick grep shows that it is mostly present in the dasd code, but also
in some other code parts.)

> - * Coypright IBM Corp. 1999, 2000
> + * Copyright IBM Corp. 1999, 2000
>   *
>   */
>  
> diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
> index 1770b99f607e..8d4d69ea5baf 100644
> --- a/drivers/s390/block/dasd_proc.c
> +++ b/drivers/s390/block/dasd_proc.c
> @@ -5,7 +5,7 @@
>   *		    Carsten Otte <Cotte@de.ibm.com>
>   *		    Martin Schwidefsky <schwidefsky@de.ibm.com>
>   * Bugreports.to..: <Linux390@de.ibm.com>
> - * Coypright IBM Corp. 1999, 2002
> + * Copyright IBM Corp. 1999, 2002
>   *
>   * /proc interface for the dasd driver.
>   *

