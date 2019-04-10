Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ADFC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 12:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DAC20818
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 12:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="RuhaXpaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfDJMxB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:53:01 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36090 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbfDJMxB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 08:53:01 -0400
Received: by mail-vk1-f195.google.com with SMTP id w140so527318vkd.3
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RrVNfDqjgIN2g5iPNbjQcpAH2KmlBTnI6OFAGpNZsRI=;
        b=RuhaXpaBaUXsAch31PfmdWMfzIe8KpMmaKt4FyzRw1saPcrxcCXdzpeL9y+TEnNPJW
         +7slG5m7ncYwWJSMwOaM0EAmdRI+NCL0yPWu7VVJJR+BDG4ZPQo9fwgew1iqVS0zFV/d
         3qMEg5wg7d89g3wOApHz8RZDrT2mfox6M9eodEH/TETyHoGi5gz2UZTYsMuCCSI2Zjxl
         rZyiS9z0S2pS6S8BV4ByOsJ9RjbGMb6VKU+n7TB800+xwZFUMSi03S3OYoY1H87cxhpN
         efOXgctoP1xAkMPOpPCELFYsWNdLB/QBHd2dF1CAiK8zID6NmRimRQkd0qzBn/ulUAwb
         bWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RrVNfDqjgIN2g5iPNbjQcpAH2KmlBTnI6OFAGpNZsRI=;
        b=f+qjlW/5XZ4Cnh2jn42TmsH8PmvEwO2SMlkdlaLcsXo/rwiug/dNuvNkzRFpBcTilq
         n9caT1rRCHPcc7sQrRTuIvPTubInKSvEUORyiZU5joqjS5+D4rk9W3wh1HI/dX8+aT+Q
         q3Y5z0VuUZen3V/KyfqZwJnjjXz9qWTbf+K0b3fuMcClndVRjJsAFxLmPh44GGJzO1H5
         YbbblP89+DV9ViPibdeJviYGGc5oGRox3f/usBaM8kHrSm/NStIWw/FWg7PGNOQEYIDQ
         2PagSz1RgnS5hA0CJ/M/tWb9bIsvRMYP+MTdku/Kmsr0mmFaOaawCRZZj4QAqvySh6gZ
         UdMA==
X-Gm-Message-State: APjAAAXWBg/4DnGYOIN5DvyaDrG5iCJ2p2fZKuQPpC4e/6fsnF33Njs3
        35ckh9hjx9YOsT42/h51/8t2LP08o7TGodeWhPkcfg==
X-Google-Smtp-Source: APXvYqyJyHqe7nMs9WlN+RSvm8n4BO6drOx3CHPRbJnH1lAqiwWfNSsnf6UkkIHCRIh9OhofiuPJyHzQiHc3VcoaYd8=
X-Received: by 2002:a1f:3644:: with SMTP id d65mr21233271vka.34.1554900780431;
 Wed, 10 Apr 2019 05:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190408073308.3082-1-hans@owltronix.com> <5D5705F7-C0D7-4303-82A2-965320560220@javigon.com>
In-Reply-To: <5D5705F7-C0D7-4303-82A2-965320560220@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 10 Apr 2019 14:52:49 +0200
Message-ID: <CANr-nt2oJhHvK8SydTQgKkPj_bPuN1VJx1k+z2A3Dfotxdghvg@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: fix crash in pblk_end_partial_read due to
 multipage bvecs
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 10, 2019 at 2:22 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
> > On 8 Apr 2019, at 09.33, hans@owltronix.com wrote:
> >
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > Ever since '07173c3ec276 ("block: enable multipage bvecs")' we
> > need to handle bios with multipage bvecs in pblk.
> >
> > Currently, a multipage bvec results in a crash[1].
> > Fix this by using bvec iterators in stead of direct bvec indexing.
> >
> > Also add a dcache flush, for the same reasons as in:
> > '6e6e811d747b ("block: Add missing flush_dcache_page() call")'
> >
> > [1] https://github.com/OpenChannelSSD/linux/issues/61
> >
> > Reported-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> >
> > It ain't pretty, but let's fix the breakage while waiting for Igor's
> > partial read cleanup to be ready.
> >
>
> I would prefer to have the real fix, but it is good to have this fixed fo=
r
> 5.2. Can we agree on a revert if Igor sends the patch within the 5.2
> window?

yeah! please chuck this patch out of the window when we have a nicer fix re=
ady.

Thanks,
Hans
