Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA180C2D0A3
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 16:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD912074F
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 16:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAT3YvyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgKIQNw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:13:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729935AbgKIQNw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Nov 2020 11:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604938430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s3SZCh4hwtMb1y6sDwI+o5bu4QOOqbehBdeufwmkn8g=;
        b=IAT3YvyVTw1NFO6U9lnRdYwSLitaLBaKm5aPaOiX09bxqW3ZtZtIUSKJFQY9nt9ZhUjeGN
        LyKdcFJCWzJVWojmSOccpwvoj2TIC8zwLyRvXT9AE8u2QUYTQSS+/Zlyq9sSvzbF6Z3Mjl
        5OKyZOE2y26AJYXlFKbaBAMdNChiOLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-sacdlrDrMjSQwaRrbVj0Eg-1; Mon, 09 Nov 2020 11:13:48 -0500
X-MC-Unique: sacdlrDrMjSQwaRrbVj0Eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35B5E801AC3;
        Mon,  9 Nov 2020 16:13:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B8426EF6A;
        Mon,  9 Nov 2020 16:13:47 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 1E60918095FF;
        Mon,  9 Nov 2020 16:13:47 +0000 (UTC)
Date:   Mon, 9 Nov 2020 11:13:43 -0500 (EST)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Message-ID: <449460775.17920557.1604938423946.JavaMail.zimbra@redhat.com>
In-Reply-To: <cki.F35EC3202F.1TPV9ZC6SF@redhat.com>
References: <cki.F35EC3202F.1TPV9ZC6SF@redhat.com>
Subject: =?utf-8?Q?Re:_=E2=9D=8C_FAIL:_Test_report_for_kernel_5.10.0-rc3_(block)?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.40.195.100, 10.4.195.13]
Thread-Topic: =?utf-8?B?4p2MIEZBSUw6?= Test report for kernel 5.10.0-rc3 (block)
Thread-Index: Zf52MC6isQHu+yF/+0oxlIFJEs8COw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



----- Original Message -----
> From: "CKI Project" <cki-project@redhat.com>
> To: linux-block@vger.kernel.org, axboe@kernel.dk
> Sent: Monday, November 9, 2020 5:11:45 PM
> Subject: =E2=9D=8C FAIL: Test report for kernel 5.10.0-rc3 (block)
>=20
>=20
> Hello,
>=20
> We ran automated tests on a recent commit from this kernel tree:
>=20
>        Kernel repo:
>        https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.=
git
>             Commit: c91882ba0790 - Merge branch 'tif-task_work.arch' into
>             for-next
>=20
> The results of these automated tests are provided below.
>=20
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: FAILED
>=20
> All kernel binaries, config files, and logs are available for download he=
re:
>=20
>   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?p=
refix=3Ddatawarehouse-public/2020/11/09/617345
>=20
> We attempted to compile the kernel for multiple architectures, but the
> compile
> failed on one or more architectures:
>=20
>             x86_64: FAILED (see build-x86_64.log.xz attachment)
>=20

Hi, we're seeing the following errors with the last two git pushes
(the other one being commit dd8da1a825a9ba9ad3c7d0e707db9441c9182349):

00:00:10 In file included from ./arch/x86/include/asm/atomic.h:5,
00:00:10                  from ./include/linux/atomic.h:7,
00:00:10                  from ./include/linux/crypto.h:15,
00:00:10                  from arch/x86/kernel/asm-offsets.c:9:
00:00:10 ./include/linux/sched/signal.h: In function =E2=80=98signal_pendin=
g=E2=80=99:
00:00:10 ./include/linux/sched/signal.h:368:39: error: =E2=80=98TIF_NOTIFY_=
SIGNAL=E2=80=99 undeclared (first use in this function)
00:00:10   368 |  if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
00:00:10       |                                       ^~~~~~~~~~~~~~~~~
00:00:10 ./include/linux/compiler.h:78:42: note: in definition of macro =E2=
=80=98unlikely=E2=80=99
00:00:10    78 | # define unlikely(x) __builtin_expect(!!(x), 0)
00:00:10       |                                          ^
00:00:10 ./include/linux/sched/signal.h:368:39: note: each undeclared ident=
ifier is reported only once for each function it appears in
00:00:10   368 |  if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
00:00:10       |                                       ^~~~~~~~~~~~~~~~~
00:00:10 ./include/linux/compiler.h:78:42: note: in definition of macro =E2=
=80=98unlikely=E2=80=99
00:00:10    78 | # define unlikely(x) __builtin_expect(!!(x), 0)
00:00:10       |                                          ^
00:00:10   HDRINST usr/include/linux/thermal.h
00:00:10   HDRINST usr/include/linux/time.h
00:00:10 make[3]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offs=
ets.s] Error 1
00:00:10   HDRINST usr/include/linux/time_types.h
00:00:10   HDRINST usr/include/linux/timerfd.h
00:00:10 make[2]: *** [Makefile:1200: prepare0] Error 2



Veronika

> We hope that these logs can help you find the problem quickly. For the fu=
ll
> detail on our testing procedures, please scroll to the bottom of this
> message.
>=20
> Please reply to this email if you have any questions about the tests that=
 we
> ran or if you have any suggestions on how to make future tests more
> effective.
>=20
>         ,-.   ,-.
>        ( C ) ( K )  Continuous
>         `-',-.`-'   Kernel
>           ( I )     Integration
>            `-'
> _________________________________________________________________________=
_____
>=20
> Compile testing
> ---------------
>=20
> We compiled the kernel for 4 architectures:
>=20
>     aarch64:
>       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
>=20
>     ppc64le:
>       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
>=20
>     s390x:
>       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
>=20
>     x86_64:
>       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
>=20
>=20
>=20

