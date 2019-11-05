Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65E3C17460
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 13:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96FA21928
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 13:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yl6uyvJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbfKENJx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:09:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51033 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388008AbfKENJx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 08:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572959392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsuwC0t0v7m4AvGasFs0fl2Hj3Em1xgbuROOym1LkXo=;
        b=Yl6uyvJBWlxWgDkg7M00BfQk691q6V9cZZsv8INQsK52tXPtL1+EoT9mqK9TYpzENWG7Y2
        dFBEz/wfdupukgMh9qb5lsGX66gBqRYLqrCUshLcAWC2t5j+ugUZYHE/APvgM4nQ8a0zrj
        YfhjdcYUPxdnwVNbdXnOqFLNenGx8gE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-CxyEWPogNkq-rnkgTOsw1w-1; Tue, 05 Nov 2019 08:09:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5A14800C73;
        Tue,  5 Nov 2019 13:09:45 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (unknown [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 124EB5D726;
        Tue,  5 Nov 2019 13:09:39 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Julia Suvorova <jusual@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH liburing v3 0/3] Fedora 31 RPM improvements
References: <20191105073917.62557-1-stefanha@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 05 Nov 2019 08:09:38 -0500
In-Reply-To: <20191105073917.62557-1-stefanha@redhat.com> (Stefan Hajnoczi's
        message of "Tue, 5 Nov 2019 08:39:14 +0100")
Message-ID: <x494kzibhbh.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: CxyEWPogNkq-rnkgTOsw1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> v3:
>  * Remember to commit my changes ;-).  The changelog now contains user-vi=
sible
>    changes in 0.2 and the https git.kernel.dk URL.
>
> v2:
>  * Wrap commit description to 72 characters
>  * Put user-visible changes into 0.2 RPM changelog
>  * Use https git.kernel.dk URL for tar.gz
>
> Jeff Moyer and I have been working on RPMs for liburing.  This patch seri=
es
> contains fixes required to build Fedora 31 RPMs.
>
> I have also tested on openSUSE Leap 15.1 to verify that these changes wor=
k on
> other rpm-based distros.
>
> Jeff Moyer (1):
>   spec: Fedora RPM cleanups
>
> Stefan Hajnoczi (2):
>   spec: update RPM version number to 0.2
>   Makefile: add missing .pc dependency on .spec file
>
>  Makefile      |  2 +-
>  liburing.spec | 59 ++++++++++++++++++++++++++-------------------------
>  2 files changed, 31 insertions(+), 30 deletions(-)

For the series:
Acked-by: Jeff Moyer <jmoyer@redhat.com>

