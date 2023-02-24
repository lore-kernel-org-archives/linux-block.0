Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8614C64ED8
	for <linux-block@archiver.kernel.org>; Fri, 24 Feb 2023 08:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBXI3U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Feb 2023 03:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXI3T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2023 03:29:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F0B1557B
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2023 00:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677227320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V/rYIyd+ET1V0znrPeHdfSOETtV3jwHrAc6ouywm8Ko=;
        b=Gy87+mDBw+8h3yxS8iGaxZegrHplotEcSpp2QDelOmek5U0asIvU3R1mLUNl7CnCDbndLr
        bPRqVX7xt2jcGwcM7yQrtTPNmUl4cQsFCYJFR3V9l9JGNOqOwomLb6k2PmvccRgN5ql26K
        funK8H1dynnR7JPA6KyJa7lTvMVafZA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-nc76GJW9PHiD3d7-1o5w8Q-1; Fri, 24 Feb 2023 03:28:38 -0500
X-MC-Unique: nc76GJW9PHiD3d7-1o5w8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26D1F830F4F;
        Fri, 24 Feb 2023 08:28:38 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BA9B440D8;
        Fri, 24 Feb 2023 08:28:34 +0000 (UTC)
Date:   Fri, 24 Feb 2023 16:28:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v3 1/2] src: add mini ublk source code
Message-ID: <Y/h1LQbf+brRw1mo@T590>
References: <20230220034649.1522978-1-ming.lei@redhat.com>
 <20230220034649.1522978-2-ming.lei@redhat.com>
 <a20a449a-73c1-c7dd-b100-89e346c35828@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a20a449a-73c1-c7dd-b100-89e346c35828@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 24, 2023 at 03:52:28PM +0800, Ziyang Zhang wrote:
> On 2023/2/20 11:46, Ming Lei wrote:
> 
> [...]
> 
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  src/.gitignore |    1 +
> >  src/Makefile   |   18 +
> >  src/miniublk.c | 1376 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1395 insertions(+)
> >  create mode 100644 src/miniublk.c
> > 
> > diff --git a/src/.gitignore b/src/.gitignore
> > index 355bed3..df7aff5 100644
> > --- a/src/.gitignore
> > +++ b/src/.gitignore
> > @@ -8,3 +8,4 @@
> >  /sg/dxfer-from-dev
> >  /sg/syzkaller1
> >  /zbdioctl
> > +/miniublk
> > diff --git a/src/Makefile b/src/Makefile
> > index 3b587f6..81c6541 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -2,6 +2,10 @@ HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
> >  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
> >  		else echo "$(3)"; fi)
> >  
> > +HAVE_C_MACRO = $(shell if echo "#include <$(1)>" |	\
> Hi Ming,
> 
> It should be "\#include", not "#include". You miss a "\".

"\#include" won't work for checking the macro of IORING_OP_URING_CMD.

[root@ktest-36 linux]# echo "\#include <liburing.h>" | gcc -E -
# 0 "<stdin>"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "<stdin>"
\#include <liburing.h>



Thanks,
Ming

