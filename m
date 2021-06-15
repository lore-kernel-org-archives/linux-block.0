Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20595C49361
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 18:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09717610F7
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 18:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhFOSgO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhFOSgO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 14:36:14 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EFBC061574
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 11:34:08 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u14so181788qvq.6
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ci8pTDsI4+1dl8hd8DPpx4lfE/2PNymYi+7s+L/rCno=;
        b=PK99xqIi4vOJCiwjyFx7sp/rvE4QciQ9VOYWadYlda8ip8BShy10QYGLAjNTlX6yj4
         NpuPKMftibD60GvE085PX/7Drph1xMAHMwToXAmI5pJhp1P0RgnZCkkOHwQ3/vJaU+1W
         ctUknv+wA4Cnp1nbxaQurmpCYJZtTHdtSBrJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ci8pTDsI4+1dl8hd8DPpx4lfE/2PNymYi+7s+L/rCno=;
        b=TQnwbSB0wCbcksRP51N5onHwnCuqdAE1ZBabl5RC8ACVy99pHvPY9lUAgxONCUGbg6
         OkLx0ZOnp2tDpqqxATiuB11Pl2BTC1AiG2QcKxL2eJgeREkGxQZumYM/mOC1jVZ1vrFe
         /vj0rMeGAKxnSBTRHxMowjcs4vSn2JSky+/kHRE6Jrogn2QRKB9RB1mIh+J2V/sCdVAq
         4dMjQYSQx10WM9mdvVdMpy2PPC9uCz8RaL4NSgoQyWJSXn/stP+umqnxzoZ2UpijDdJU
         GCUD9ypGuJEgesvJIgS7ZlP1NBEBa86pGlvxIc7gIgdnMgCawZPdNUEdp+0/8IjT8K4I
         omCQ==
X-Gm-Message-State: AOAM533U9ZQP55fbZLw7ZnoVgzzDgZYB9Ii4OtcEMUACjcle6QTdtnQA
        nLlGxzCMQUYsKny8EnzF6Vvt0w==
X-Google-Smtp-Source: ABdhPJyHWGn07W9hcHEIH999jGrYf+wW2jw6aRdNw2u5boIr2c5TmIFSEKWlZQrl7KeRgxw5C3vtRg==
X-Received: by 2002:a0c:e8cd:: with SMTP id m13mr6841876qvo.52.1623782047319;
        Tue, 15 Jun 2021 11:34:07 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id g24sm11940010qts.60.2021.06.15.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:34:06 -0700 (PDT)
Date:   Tue, 15 Jun 2021 14:34:05 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg KH <greg@kroah.com>, Christoph Lameter <cl@gentwo.de>,
        Theodore Ts'o <tytso@mit.edu>, Jiri Kosina <jikos@kernel.org>,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Maintainers / Kernel Summit 2021 planning kick-off
Message-ID: <20210615183405.rchiaaybuhx244qa@nitro.local>
References: <YLEIKk7IuWu6W4Sy@casper.infradead.org>
 <YH2hs6EsPTpDAqXc@mit.edu>
 <nycvar.YFH.7.76.2104281228350.18270@cbobk.fhfr.pm>
 <YIx7R6tmcRRCl/az@mit.edu>
 <alpine.DEB.2.22.394.2105271522320.172088@gentwo.de>
 <YK+esqGjKaPb+b/Q@kroah.com>
 <c46dbda64558ab884af060f405e3f067112b9c8a.camel@HansenPartnership.com>
 <1745326.1623409807@warthog.procyon.org.uk>
 <e47706ee-3e4b-8f15-963f-292b5e47cb1d@metux.net>
 <YMjxqEY25A6bm47s@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMjxqEY25A6bm47s@casper.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 07:30:00PM +0100, Matthew Wilcox wrote:
> > Wouldn't just taking prophylatic meds like CDS or HCQ and/or hi-dose
> > vitamins (C, D3+K2) be way more cost effective and flexible than to
> > charter a whole plane ?
> 
> Why don't you just shine a bright light up your arse?  It'll have the
> same effect.

Please stop.

I do not have ability to ban people across all cc'd lists, but I will for sure
start adding people to block filters on the infra to which I have access if
this wildly off-topic discussion continues and especially if things continue
to deteriorate into name-calling.

-K
