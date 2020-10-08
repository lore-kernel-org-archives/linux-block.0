Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F47C4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BAF21927
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqsuCtPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgJHOyh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730550AbgJHOyh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 10:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602168876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bNEK1yELQiY+VzrYEuOVhxvQHzGcuw43m+na/2pY2A=;
        b=IqsuCtPPLceBcsOzN2vwtMg9mh+/f7rrlhBwGzq1niZeYcssIqVXNzHppFUKq4Xs0J7WOP
        Lwy5WwfEOzNWkavR4eN6QiC7Urb0NwIxoe5V3dH+jJW8ZG/Bq5RryVbIdKWHqvJ2qqUha3
        bokC8xyGWDOfTiZpx/Zsnbr2Pp85QR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-YP1iBjBiO1GPPWD9qXbRtg-1; Thu, 08 Oct 2020 10:54:34 -0400
X-MC-Unique: YP1iBjBiO1GPPWD9qXbRtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74C1118BE171;
        Thu,  8 Oct 2020 14:54:32 +0000 (UTC)
Received: from gondolin (ovpn-113-82.ams2.redhat.com [10.36.113.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B14A06EF6D;
        Thu,  8 Oct 2020 14:54:30 +0000 (UTC)
Date:   Thu, 8 Oct 2020 16:54:28 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 10/10] s390/dasd: Process FCES path event
 notification
Message-ID: <20201008165428.40044398.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-11-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-11-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu,  8 Oct 2020 15:13:36 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> If the Fibre Channel Endpoint-Security status of a path changes, a
> corresponding path event is received from the CIO layer.
>=20
> Process this event by re-reading the FCES information.
>=20
> As the information is retrieved for all paths on a single CU in one
> call, the internal status can also be updated for all paths and no
> processing per path is necessary.
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd.c      | 19 +++++++++++----
>  drivers/s390/block/dasd_eckd.c | 12 +++++++---
>  drivers/s390/block/dasd_int.h  | 42 +++++++++++++++++++++++++++++++++-
>  3 files changed, 64 insertions(+), 9 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

