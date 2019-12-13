Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42322C5ED79
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7719424748
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZ+vB+gV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfLMP7e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:59:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51919 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728001AbfLMP7e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 10:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576252773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BoYH2dN+d+OPTlIiZKP3wf2JnR3H8TCTQB2aVmVmUc8=;
        b=hZ+vB+gVURFFTmUwV5AptSXT3nmtLf35KXCROfc1uUKvSpmz6M0VU3/Rl4hp3RinX05yso
        8xtt3IERDURE4dilQUZHK/nIJx4hX7xvOvXa8kXMp8j0HvfVtm+lUl9aXsjuampwxWHVMK
        DQtULaPf6P6Z3Sea7YTJ5BCMClyWuEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-8hh-eXS6Ot2tdBenEMvDgw-1; Fri, 13 Dec 2019 10:59:31 -0500
X-MC-Unique: 8hh-eXS6Ot2tdBenEMvDgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70326593AF;
        Fri, 13 Dec 2019 15:59:30 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2CBE60BF3;
        Fri, 13 Dec 2019 15:59:27 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH liburing] spec: additional Fedora RPM cleanups
References: <20191213101640.1180590-1-stefanha@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 13 Dec 2019 10:59:26 -0500
In-Reply-To: <20191213101640.1180590-1-stefanha@redhat.com> (Stefan Hajnoczi's
        message of "Fri, 13 Dec 2019 10:16:40 +0000")
Message-ID: <x49lfrg2p41.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Cole Robinson made some more suggestions:
>
>  * Use %set_build_flags before ./configure to get the default compiler
>    flags.
>
>  * Use '%license COPYING' instead of %doc.
>
>  * Do not ship the static library.  This is distro policy and Fedora
>    would ship a separate -static package if static libraries are
>    desired.
>
>  * Source: should be the URL to the sources.  URL: should be the URL of
>    the website or git repo.
>
>  * The devel package needs
>    Requires: %{name}%{?_isa} = %{version}-%{release}
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

LGTM

Acked-by: Jeff Moyer <jmoyer@redhat.com>

