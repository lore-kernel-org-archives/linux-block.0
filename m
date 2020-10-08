Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAC7C04EBE
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B75F21927
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPf4TxAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgJHOVn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730491AbgJHOVn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 10:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602166902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2fWJHo/dK+G43EvaSxtbG1r4dyqHA3cY0K5AShuU7w=;
        b=MPf4TxAPiJgikccA7ruPfTxlxGQpb4U95yEoOxLbs/qlWd7BLE5FEmVxDFb4D8zYRCDATy
        iSIDAy9xvm3a2s+2Y3TVZtI18Zd6PcfaDnRJg5abWyIjHMwfxyVOxlz7hekF1088DIQQjw
        xWHvOWK74dzucQcNKCIf7uSXrejm3t4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-5eY_MNJgPV-aetyuqWcKrQ-1; Thu, 08 Oct 2020 10:21:40 -0400
X-MC-Unique: 5eY_MNJgPV-aetyuqWcKrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C97F19080A1;
        Thu,  8 Oct 2020 14:21:38 +0000 (UTC)
Received: from gondolin (ovpn-113-82.ams2.redhat.com [10.36.113.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7E8E5C1D0;
        Thu,  8 Oct 2020 14:21:36 +0000 (UTC)
Date:   Thu, 8 Oct 2020 16:21:35 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 06/10] s390/dasd: Store path configuration data
 during path handling
Message-ID: <20201008162135.5d82b026.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-7-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-7-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu,  8 Oct 2020 15:13:32 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> Currently, the configuration data for a path is retrieved during a path
> verification and used only temporarily. If a path is newly added to the
> I/O setup after a boot, no configuration data will be stored for this
> particular path.
> However, this data is required for later use and should be present for
> a valid I/O path anyway. Store this data during the path verification so
> that newly added paths can provide all information necessary.
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> [sth@linux.ibm.com: fix conf_data memleak]
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_eckd.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

