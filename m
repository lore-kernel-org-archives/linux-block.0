Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A5CC433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 11:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3D02073A
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 11:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhA0LLf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 06:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbhA0LK0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 06:10:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F76C061574;
        Wed, 27 Jan 2021 03:09:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q7so1431463wre.13;
        Wed, 27 Jan 2021 03:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=TYd2bFtaI19oguKQYB2YgEjLBART3/4JhdhOtLWWdVk=;
        b=mTKZqgVsrQGsM2t8H/CppzkvI06bI5qPngQDfGn4QFi58r/gH6aFQpbtOuaDGUMZNL
         8B1aG9/ndr+pm+bTiYmEt5U+hSs5l5KfmT0dzOUBZqqwSopKt0If6gHiWIhkTF1bVucs
         2YAdPsivwlddhFvggUdeFIO6IxDuqfCNLyGEP/xlbPQ7FEWxdXqdhgS6MGXHlHLPIQqo
         osW45a4eZybJfWknyj9XPQYm31Z7Qzhx0ab85TkNInV76zfH6Ijf9mX9PNUp0K7hherv
         M/FXQvvdZ/kxLqTMSm4QiRx9Sm+G0/Weg7so3w8TbdXdELTBcxA29HilRKGjL4CExNwc
         lgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
         :subject:date:message-id:mime-version:content-transfer-encoding
         :thread-index:content-language;
        bh=TYd2bFtaI19oguKQYB2YgEjLBART3/4JhdhOtLWWdVk=;
        b=OT+go9F9cCZRCkrfLj4+o+Ca79mF58yWJSwCmEG1QE8s+mDYGn5DyHNS9PtuEVqxbv
         QKaXV+khJLyUW2/AlFEDvJ7s8K+2HydV1tq9iZxR/mAH0mzn9tWuE7rKMRALv+BJRNP6
         YZVmc9s5TUa/sBg+X6aOtPYlh8+1RKFNzMp/AKmsk75TM/O3+1GBdsa3xzZG3++Ipw7w
         FNNFgfdXJuHYGCy0FHymihuIqfJ1q8MfGXfkL0k7BmTFTle0bfdrHbbxViGMclXziz+p
         1knMsUXvNZuGkX10WgwNLxMDMI6J42oFFfRv8FAoHpdhdXho4P03HZthaMLGijmCbVpu
         0IKQ==
X-Gm-Message-State: AOAM532lR9bCvStmzBrf3CcivbDTk/y7JWcswuNxORKNKFrNpHvs/Yzw
        uz+Z8Ad3d/KUAowddUSL540=
X-Google-Smtp-Source: ABdhPJzO1ImJR9OkOxsts1a9dI5nzf2ctrN2ObzgYu40ha+E+GH4dL85Ui26OPSjVqLc/rnPQsuGGg==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr10458485wrw.120.1611745784980;
        Wed, 27 Jan 2021 03:09:44 -0800 (PST)
Received: from CBGR90WXYV0 ([2a00:23c5:5785:9a01:ad9a:ab78:5748:a7ec])
        by smtp.gmail.com with ESMTPSA id j4sm2487477wru.20.2021.01.27.03.09.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 03:09:44 -0800 (PST)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
Reply-To: <paul@xen.org>
To:     "'Jan Beulich'" <jbeulich@suse.com>
Cc:     "'Paul Durrant'" <pdurrant@amazon.com>,
        "'Konrad Rzeszutek Wilk'" <konrad.wilk@oracle.com>,
        =?utf-8?Q?'Roger_Pau_Monn=C3=A9'?= <roger.pau@citrix.com>,
        "'Jens Axboe'" <axboe@kernel.dk>,
        "'Dongli Zhang'" <dongli.zhang@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
References: <20210127103034.2559-1-paul@xen.org> <cd70ae5e-a389-7521-8caf-15650a276152@suse.com>
In-Reply-To: <cd70ae5e-a389-7521-8caf-15650a276152@suse.com>
Subject: RE: [PATCH] xen-blkback: fix compatibility bug with single page rings
Date:   Wed, 27 Jan 2021 11:09:43 -0000
Message-ID: <026001d6f49c$eab982b0$c02c8810$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH8tEXaaRm8hTZRIcgVeZub79k21gHW+9qTqeEYq8A=
Content-Language: en-gb
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -----Original Message-----
> From: Jan Beulich <jbeulich@suse.com>
> Sent: 27 January 2021 10:57
> To: Paul Durrant <paul@xen.org>
> Cc: Paul Durrant <pdurrant@amazon.com>; Konrad Rzeszutek Wilk =
<konrad.wilk@oracle.com>; Roger Pau
> Monn=C3=A9 <roger.pau@citrix.com>; Jens Axboe <axboe@kernel.dk>; =
Dongli Zhang <dongli.zhang@oracle.com>;
> linux-kernel@vger.kernel.org; linux-block@vger.kernel.org; =
xen-devel@lists.xenproject.org
> Subject: Re: [PATCH] xen-blkback: fix compatibility bug with single =
page rings
>=20
> On 27.01.2021 11:30, Paul Durrant wrote:
> > From: Paul Durrant <pdurrant@amazon.com>
> >
> > Prior to commit 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() to =
avoid
> > inconsistent xenstore 'ring-page-order' set by malicious blkfront"), =
the
> > behaviour of xen-blkback when connecting to a frontend was:
> >
> > - read 'ring-page-order'
> > - if not present then expect a single page ring specified by =
'ring-ref'
> > - else expect a ring specified by 'ring-refX' where X is between 0 =
and
> >   1 << ring-page-order
> >
> > This was correct behaviour, but was broken by the afforementioned =
commit to
> > become:
> >
> > - read 'ring-page-order'
> > - if not present then expect a single page ring
> > - expect a ring specified by 'ring-refX' where X is between 0 and
> >   1 << ring-page-order
> > - if that didn't work then see if there's a single page ring =
specified by
> >   'ring-ref'
> >
> > This incorrect behaviour works most of the time but fails when a =
frontend
> > that sets 'ring-page-order' is unloaded and replaced by one that =
does not
> > because, instead of reading 'ring-ref', xen-blkback will read the =
stale
> > 'ring-ref0' left around by the previous frontend will try to map the =
wrong
> > grant reference.
> >
> > This patch restores the original behaviour.
>=20
> Isn't this only the 2nd of a pair of fixes that's needed, the
> first being the drivers, upon being unloaded, to fully clean up
> after itself? Any stale key left may lead to confusion upon
> re-use of the containing directory.

In a backend we shouldn't be relying on, nor really expect IMO, a =
frontend to clean up after itself. Any backend should know *exactly* =
what xenstore nodes it=E2=80=99s looking for from a frontend.

  Paul

>=20
> Jan

