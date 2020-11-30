Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD44C64E7B
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 19:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555DC20659
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 19:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvYDTMfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgK3TbY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 14:31:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgK3TbX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 14:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606764596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/so2ouL6ltBEJcoXx9EjSsxKsg8hMEWjbNj1WX9KX4=;
        b=CvYDTMfloosNkDALCtRg2gzDFX698JUXIaQ2CU73jT3ysYykh3CZGRYY6wcpsqC139GRYY
        Uwv6kZE7YvNeRwTlEmrn8xxG9RRFPNjolZzatKhuqJ3fxYzBsHu6G8EAOUnpiNLZt3ylTR
        GMH/W7B+GWYRnheB/oUA1M7aI1Mj1jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527--Dob06rGMzGena5bowxScA-1; Mon, 30 Nov 2020 14:29:53 -0500
X-MC-Unique: -Dob06rGMzGena5bowxScA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB2683E747;
        Mon, 30 Nov 2020 19:29:52 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2F3060C67;
        Mon, 30 Nov 2020 19:29:52 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8CAC94BB7B;
        Mon, 30 Nov 2020 19:29:52 +0000 (UTC)
Date:   Mon, 30 Nov 2020 14:29:52 -0500 (EST)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Message-ID: <1212579999.19835613.1606764592454.JavaMail.zimbra@redhat.com>
In-Reply-To: <cki.DBF986CEF7.1DN2XEHOVP@redhat.com>
References: <cki.DBF986CEF7.1DN2XEHOVP@redhat.com>
Subject: =?utf-8?Q?Re:_=E2=9D=8C_FAIL:_Test_report_for_kernel_5.10.0-rc5_(block)?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.40.195.39, 10.4.195.19]
Thread-Topic: =?utf-8?B?4p2MIEZBSUw6?= Test report for kernel 5.10.0-rc5 (block)
Thread-Index: C/iCR0CVKITizvoJyEzsh82n4v2qbw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



----- Original Message -----
> From: "CKI Project" <cki-project@redhat.com>
> To: linux-block@vger.kernel.org, axboe@kernel.dk
> Sent: Monday, November 30, 2020 8:27:49 PM
> Subject: =E2=9D=8C FAIL: Test report for kernel 5.10.0-rc5 (block)
>=20
>=20
> Hello,
>=20
> We ran automated tests on a recent commit from this kernel tree:
>=20
>        Kernel repo:
>        https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.=
git
>             Commit: cd8ae268840e - Merge branch 'for-5.11/block' into
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
refix=3Ddatawarehouse-public/2020/11/30/618887
>=20
> We attempted to compile the kernel for multiple architectures, but the
> compile
> failed on one or more architectures:
>=20
>            aarch64: FAILED (see build-aarch64.log.xz attachment)
>            ppc64le: FAILED (see build-ppc64le.log.xz attachment)
>              s390x: FAILED (see build-s390x.log.xz attachment)
>             x86_64: FAILED (see build-x86_64.log.xz attachment)
>=20

Hi,

looks to be introduced by

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commi=
t/?h=3Dfor-next&id=3D1076736138841d8516555f352ae0426a99ae9f92


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

