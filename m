Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8394C433DB
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 17:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A4722CAD
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 17:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407036AbhARRcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 12:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393609AbhARRbr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 12:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610991019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHxs6Cnwftt0lFLGJnl0K9RDZpS8tR+YPpQa7alFW5g=;
        b=c9flOCviGqIlJSIAbc+Ip04PTMKwtpOlkc/4PtS4tCLMkXd0Jq5Wtdy7aw1HUTGb+JggG/
        cEB1viv8TJ+s716ZWzOfXWAaHBJ7sS3wZ9+ukbrW6aNHRpF3XORM8KDynve912yx+MY7Nr
        3f5EIHb87GfsAFAC6MQTMJt/Ph+fxVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-EgK-sjARNTKjr0aufeudTw-1; Mon, 18 Jan 2021 12:30:15 -0500
X-MC-Unique: EgK-sjARNTKjr0aufeudTw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25D6AAFA81;
        Mon, 18 Jan 2021 17:30:14 +0000 (UTC)
Received: from gondolin (ovpn-114-2.ams2.redhat.com [10.36.114.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27DAE60C67;
        Mon, 18 Jan 2021 17:30:11 +0000 (UTC)
Date:   Mon, 18 Jan 2021 18:30:09 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: Fix inconsistent kobject removal
Message-ID: <20210118183009.43f5c037.cohuck@redhat.com>
In-Reply-To: <20210118165518.14578-2-sth@linux.ibm.com>
References: <20210118165518.14578-1-sth@linux.ibm.com>
        <20210118165518.14578-2-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Jan 2021 17:55:18 +0100
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> Our intention was to only remove path kobjects whenever a device is
> being set offline. However, one corner case was missing.
>=20
> If a device is disabled and enabled (using the IOCTLs BIODASDDISABLE and
> BIODASDENABLE respectively), the enabling process will call
> dasd_eckd_reload_device() which itself calls dasd_eckd_read_conf() in
> order to update path information. During that update,
> dasd_eckd_clear_conf_data() clears all old data and also removes all
> kobjects. This will leave us with an inconsistent state of path kobjects
> and a subsequent path verification leads to a failing kobject creation.
>=20
> Fix this by removing kobjects only in the context of offlining a device
> as initially intended.
>=20
> Fixes: 19508b204740 ("s390/dasd: Display FC Endpoint Security information=
 via sysfs")
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_devmap.c | 20 ++++++++++++++------
>  drivers/s390/block/dasd_eckd.c   |  3 ++-
>  drivers/s390/block/dasd_int.h    |  2 +-
>  3 files changed, 17 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

