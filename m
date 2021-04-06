Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B094BC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F032613C0
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhDFIwh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbhDFIwg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 04:52:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEE9C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 01:52:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so5415739wrs.1
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 01:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3BgNDMl40dnCwKRmhOLm+B9cf4ULCtKCWabOrS4ebcw=;
        b=Asdziv4oEb1GmkAaeVVDLWI3Znln2RaErCLNpsXLzuYFdOjFmI+wtm1ABBb8Qzrhny
         TcmAdlweTBezZn6bLWI5bxAO6sixQ1qoRcBGyyLqdiQLPIYhlFyN1h+5meYfiH4JkWto
         p6pFe2LqKb8alZFUYIMjJAMVfORnDXryC0wNScdPtyGiNK6QyfD0bVL+lTSMwej9pLcV
         iQzMPvscomIPMUzjFxPNO4iPBn4L4vhotDqv492YkhoERqcLIfLNP5vCfCnxSMMP6sSJ
         KcvhK8JYrWbX7nPWHQ5J91FkPJXnbjYB6Ap1ZgdEBSg2YwCnF2NloEpC1gpS/cLHXxVn
         QScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3BgNDMl40dnCwKRmhOLm+B9cf4ULCtKCWabOrS4ebcw=;
        b=IuFS+IjnETWFd2+NlsPRkUqX5ZeWwZvVJIel7d/V4O67XW5TLeImOGZDLNRul9g/iQ
         6KLD4EAURKDz31mh89pJqer5DPjaayE3lhfiy4zWycVFHft9UGA3nCtMUvbz38+If47B
         YNqNJNHGdh0lI2/kEJqLWLl5eTjPwJyEm1f/UGCJxTRG4G+01PKvnK0eNXGHWY1fmQ1U
         hHtsER5b6Y5VGmBhB3mnQyhI/CrRHkFPxwS5y51mekUL0wa45r5EpzV4heupeYQLK8UE
         kOa6TTGih/Yzp2yVsCR9q7kJZq8jTlX/WbNme88ksab3OT1avCqZ1n8Fch/vyo7/a2fG
         NmKA==
X-Gm-Message-State: AOAM532RXB7CIVnxefOhbWN+RblKf1fnKTr39BM+DtU0FlD6L7Kf6CbE
        QE8MfzpelQk9zozg/lBwJwlnvA==
X-Google-Smtp-Source: ABdhPJyxLFG0M7WFSnkeNEm7vMCed81i1TOhAivLtyeLJw56m312VuEzXAMWCWyLobQLxSOjXKutyg==
X-Received: by 2002:adf:90f0:: with SMTP id i103mr32839523wri.318.1617699146143;
        Tue, 06 Apr 2021 01:52:26 -0700 (PDT)
Received: from dell ([91.110.221.193])
        by smtp.gmail.com with ESMTPSA id i8sm32058595wrx.43.2021.04.06.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 01:52:25 -0700 (PDT)
Date:   Tue, 6 Apr 2021 09:52:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        drbd-dev@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 00/11] Rid W=1 warnings from Block
Message-ID: <20210406085223.GR2916463@dell>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
 <20210330132130.GK2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210330132130.GK2916463@dell>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 30 Mar 2021, Lee Jones wrote:

> On Fri, 12 Mar 2021, Lee Jones wrote:
> 
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > Lee Jones (11):
> >   block: rsxx: core: Remove superfluous const qualifier
> >   block: drbd: drbd_interval: Demote some kernel-doc abuses and fix
> >     another header
> >   block: mtip32xx: mtip32xx: Mark debugging variable 'start' as
> >     __maybe_unused
> >   block: drbd: drbd_state: Fix some function documentation issues
> >   block: drbd: drbd_receiver: Demote non-conformant kernel-doc headers
> >   block: drbd: drbd_main: Remove duplicate field initialisation
> >   block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit
> >   block: drbd: drbd_main: Fix a bunch of function documentation
> >     discrepancies
> >   block: drbd: drbd_receiver: Demote less than half complete kernel-doc
> >     header
> >   block: xen-blkfront: Demote kernel-doc abuses
> >   block: drbd: drbd_nl: Demote half-complete kernel-doc headers
> 
> Would you like me to resubmit these?

It's been 3.5 weeks since these were submitted.

We are now at -rc6, so these should be merged soon.

Is there anything you'd like me to do to help?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
