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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392AAC433E6
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 11:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6BC20754
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 11:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhA0LfS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 06:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbhA0LdX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 06:33:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB682C061573;
        Wed, 27 Jan 2021 03:33:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so1561738wrz.0;
        Wed, 27 Jan 2021 03:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=h84pFDoLCjfau/PGG6U/duVJD99Ziish/tcHcC6ql6g=;
        b=gZf7MNLVPYE1Df8fyBEYhn/T3vdUO6+ahRc1RJ4ZhmJ3VW2PqGshchOk1M3djdIRVB
         gASwt1JBTtjHEgewSzqFq7bUhG5ED0Od5xPjwMQf0nanF/ulKoY8cJhEIYZdVFbKatVa
         6PTtu8Vkq/mcX+GDOt90ArvJb6+FnSzAd2BGUvZAyMtaLqhpkCj4NZia+kBhs7CnGrmT
         9p+kSFhfM+i3FD08lJg22wBRb1pOdZUcNoCNUrrKgwalrLJAqu99j/XyiXdseSYmNmNP
         0DWqnnqYebOkIw8L1l84y1FldQQEj8qOjCx6AkTw4SKU4H0ps1f8gId6U8M2tjzphGeO
         iyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
         :subject:date:message-id:mime-version:content-transfer-encoding
         :thread-index:content-language;
        bh=h84pFDoLCjfau/PGG6U/duVJD99Ziish/tcHcC6ql6g=;
        b=btnd+AKcMBMReoTi6pZcVM2BF0gppU+hPXU+tVb6kFbZ3da3N0CplKoH9PHrofE/sW
         101ef7TsDvwaOacTWTmFqK0/QvAg0RAAkWCQ/viQqqdF5nRNcqtDU/b9Fmio1aXZCC5W
         vNzmIyvhhN6TCfCdz0BDLicSx1vogj3BP9oobn2+HpNOkg3MxBSuqmj3angkAvJpyW+P
         9tN3TB4pQAd/6Ugz6FnHwAeNqBg+8JFUrQ6k7aUzMpTQHLRLa8NDSHTh83n6FQuKqmlt
         1c/OYTND51uPnsMMp+qU6LKlE/U4kpp4kTe4jj5NZTZK0zADvTBRsE2EdqOhZeQdXKw6
         R6rQ==
X-Gm-Message-State: AOAM533EY5M/cb2iZaLD7tPr8Cyv3OB09rWFU6raUhW41JB/VpwIQt0H
        rbvMSk/iego+iFNKHDbIeIQ=
X-Google-Smtp-Source: ABdhPJwzeMIDQ017+Opjc21Kts9L12GnI+Be206OBitFuBrWwKbV1HJyBaRBDrkebcU/BPO1xqrWjw==
X-Received: by 2002:adf:d20c:: with SMTP id j12mr10719501wrh.407.1611747186716;
        Wed, 27 Jan 2021 03:33:06 -0800 (PST)
Received: from CBGR90WXYV0 ([2a00:23c5:5785:9a01:ad9a:ab78:5748:a7ec])
        by smtp.gmail.com with ESMTPSA id w7sm2480436wru.56.2021.01.27.03.33.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 03:33:06 -0800 (PST)
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
References: <20210127103034.2559-1-paul@xen.org> <cd70ae5e-a389-7521-8caf-15650a276152@suse.com> <026001d6f49c$eab982b0$c02c8810$@xen.org> <ed1988d9-131a-daf1-787f-3f49269b91aa@suse.com>
In-Reply-To: <ed1988d9-131a-daf1-787f-3f49269b91aa@suse.com>
Subject: RE: [PATCH] xen-blkback: fix compatibility bug with single page rings
Date:   Wed, 27 Jan 2021 11:33:05 -0000
Message-ID: <026101d6f4a0$2e3de000$8ab9a000$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH8tEXaaRm8hTZRIcgVeZub79k21gHW+9qTAdEPDm8C4a9si6m7hw/A
Content-Language: en-gb
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -----Original Message-----
> From: Jan Beulich <jbeulich@suse.com>
> Sent: 27 January 2021 11:21
> To: paul@xen.org
> Cc: 'Paul Durrant' <pdurrant@amazon.com>; 'Konrad Rzeszutek Wilk' =
<konrad.wilk@oracle.com>; 'Roger Pau
> Monn=C3=A9' <roger.pau@citrix.com>; 'Jens Axboe' <axboe@kernel.dk>; =
'Dongli Zhang'
> <dongli.zhang@oracle.com>; linux-kernel@vger.kernel.org; =
linux-block@vger.kernel.org; xen-
> devel@lists.xenproject.org
> Subject: Re: [PATCH] xen-blkback: fix compatibility bug with single =
page rings
>=20
> On 27.01.2021 12:09, Paul Durrant wrote:
> >> -----Original Message-----
> >> From: Jan Beulich <jbeulich@suse.com>
> >> Sent: 27 January 2021 10:57
> >> To: Paul Durrant <paul@xen.org>
> >> Cc: Paul Durrant <pdurrant@amazon.com>; Konrad Rzeszutek Wilk =
<konrad.wilk@oracle.com>; Roger Pau
> >> Monn=C3=A9 <roger.pau@citrix.com>; Jens Axboe <axboe@kernel.dk>; =
Dongli Zhang <dongli.zhang@oracle.com>;
> >> linux-kernel@vger.kernel.org; linux-block@vger.kernel.org; =
xen-devel@lists.xenproject.org
> >> Subject: Re: [PATCH] xen-blkback: fix compatibility bug with single =
page rings
> >>
> >> On 27.01.2021 11:30, Paul Durrant wrote:
> >>> From: Paul Durrant <pdurrant@amazon.com>
> >>>
> >>> Prior to commit 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() =
to avoid
> >>> inconsistent xenstore 'ring-page-order' set by malicious =
blkfront"), the
> >>> behaviour of xen-blkback when connecting to a frontend was:
> >>>
> >>> - read 'ring-page-order'
> >>> - if not present then expect a single page ring specified by =
'ring-ref'
> >>> - else expect a ring specified by 'ring-refX' where X is between 0 =
and
> >>>   1 << ring-page-order
> >>>
> >>> This was correct behaviour, but was broken by the afforementioned =
commit to
> >>> become:
> >>>
> >>> - read 'ring-page-order'
> >>> - if not present then expect a single page ring
> >>> - expect a ring specified by 'ring-refX' where X is between 0 and
> >>>   1 << ring-page-order
> >>> - if that didn't work then see if there's a single page ring =
specified by
> >>>   'ring-ref'
> >>>
> >>> This incorrect behaviour works most of the time but fails when a =
frontend
> >>> that sets 'ring-page-order' is unloaded and replaced by one that =
does not
> >>> because, instead of reading 'ring-ref', xen-blkback will read the =
stale
> >>> 'ring-ref0' left around by the previous frontend will try to map =
the wrong
> >>> grant reference.
> >>>
> >>> This patch restores the original behaviour.
> >>
> >> Isn't this only the 2nd of a pair of fixes that's needed, the
> >> first being the drivers, upon being unloaded, to fully clean up
> >> after itself? Any stale key left may lead to confusion upon
> >> re-use of the containing directory.
> >
> > In a backend we shouldn't be relying on, nor really expect IMO, a =
frontend to clean up after itself.
> Any backend should know *exactly* what xenstore nodes it=E2=80=99s =
looking for from a frontend.
>=20
> But the backend can't know whether a node exists because the present
> frontend has written it, or because an earlier instance forgot to
> delete it. It can only honor what's there. (In fact the other day I
> was wondering whether some of the writes of boolean "false" nodes
> wouldn't better be xenbus_rm() instead.)

In the particular case this patch is fixing for me, the frontends are =
the Windows XENVBD driver and the Windows crash version of the same =
driver (actually built from different code). The 'normal' instance is =
multi-page aware and the crash instance is not quite, i.e. it uses the =
old ring-ref but knows to clean up 'ring-page-order'.
Clearly, in a crash situation, we cannot rely on frontend to clean up so =
what you say does highlight that there indeed needs to be a second patch =
to xen-blkback to make sure it removes 'ring-page-order' itself as =
'state' cycles through Closed and back to InitWait. I think this patch =
does still stand on its own though.

  Paul

>=20
> Jan

