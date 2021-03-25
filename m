Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F0DC433C1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 09:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232DC61A14
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 09:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCYJe4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 05:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhCYJer (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 05:34:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BC4C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 02:34:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m11so1426387pfc.11
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3UP5h4Op4BS3+R9UjmCX7Iew5IlZCzw4jgGGElWFIiw=;
        b=Jf/yRSukhVIRqFkNYmlTBkc40E/7lajmaPL9ojpAVetkvA4Uwugf2ZDCE5f3Nj4yCv
         6c/K2DzcIRkQtMof/r5AFRMBssCfxvIn9U5VVvdL0Qyt+W5wBSTg+Uy4DbY99US0NQZh
         /VI6XaoS7NplB583G5okyi2+YGwRbIQkyVojK1wUIUHSltHHHrfu9JrNydyNAEH0RMaN
         VVrWVh7WmAf4V29Lo+ZOVZc73iIthB3KC3QrpJb6HIHdRkChRK+yecb39HFliZN0+XiV
         P3TWmjhzZNIiveFB1gTXu55iVrg+wM69xs5lOpjR6+SIFVSfOrY2rDFkCN1/pJ17rUJf
         7FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3UP5h4Op4BS3+R9UjmCX7Iew5IlZCzw4jgGGElWFIiw=;
        b=o0lEMKU5nZ0ebH72BlbYBmcovG4mhYJnux0Kx5COUcHor6/cD8YVfaxoGeMb3tMnKI
         L1NWKIZfSrCen5tJWyTy3arZE9rzn+zFbglwGWPJNEo3cHSm95p1TFmiczBa/YO7Vq/4
         +Srza/9OgW1FMGUDkNS5KLvQQ4ZjTQhx91V7RxF0Hsu0OMH48kKn8hpz/RXInmLsrJnE
         66SV649f0+z4AnYRo84dQb0F546+s1QP03LWEjDxzr5TIhkBM/t4gudLbDqNM6b/mUaH
         vES2eP6KUYMBZUiIX7fh2ksjB7GvFgm9C220X4k2Sdqs48kkmb3LWe1mCdwYMBveWyam
         lPTA==
X-Gm-Message-State: AOAM532nKSfhpQpRdXmB8ryjSQ1d76ZpnoPwzuOhH4UVw0u0wnBSq3F/
        3EtEgYarC9fKI6yU4cUWo48=
X-Google-Smtp-Source: ABdhPJx977jhtcCNFqgWpF7+d4rUgjNf4nUwxM3nC9DVW0sGqrwEHtGkogVa1tnu7fgQp3whOSMNTw==
X-Received: by 2002:a62:52d7:0:b029:1f5:c33e:811c with SMTP id g206-20020a6252d70000b02901f5c33e811cmr7501049pfb.50.1616664886612;
        Thu, 25 Mar 2021 02:34:46 -0700 (PDT)
Received: from localhost ([58.127.46.74])
        by smtp.gmail.com with ESMTPSA id n24sm4820914pgl.27.2021.03.25.02.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 02:34:46 -0700 (PDT)
Date:   Thu, 25 Mar 2021 18:34:44 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210325093444.GA4330@localhost>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <YFswq8pgzg9y00GO@x1-carbon.lan>
 <20210325020951.GA2105@localhost>
 <20210325082647.GA27622@lst.de>
 <YFxMSzjJMqdUiqxm@x1-carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFxMSzjJMqdUiqxm@x1-carbon.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21-03-25 08:39:40, Niklas Cassel wrote:
> On Thu, Mar 25, 2021 at 09:26:47AM +0100, hch@lst.de wrote:
> > On Thu, Mar 25, 2021 at 11:09:51AM +0900, Minwoo Im wrote:
> > > > I was still allowed to write to NSID2:
> > > > 
> > > > sudo nvme zns report-zones -d 1 /dev/nvme0n2
> > > > SLBA: 0x0        WP: 0x1        Cap: 0x3e000    State: IMP_OPENED   Type: SEQWRITE_REQ   Attrs: 0x0
> > > > 
> > > > Should this really be allowed?
> > > 
> > > I think this should not be allowed at all.  Thanks for the testing!
> > 
> > It should not be allowed, but it seems like a pre-existing problem
> > as nvme_user_cmd does not verify the nsid.
> > 
> > > > I was under the impression that Christoph's argument for implementing per
> > > > namespace char devices, was that you should be able to do access control.
> > > > Doesn't that mean that for the new char devices, we need to reject ioctls
> > > > that specify a nvme_passthru_cmd.nsid != the NSID that the char device
> > > > represents?
> > > > 
> > > > 
> > > > Although, this is not really something new, as we already have the same
> > > > behavior when it comes ioctls and the block devices. Perhaps we want to
> > > > add the same verification there?
> > > 
> > > I think there should be verifications.
> > 
> > Yes.
> 
> Thanks Minwoo, Christoph,
> 
> I'll cook up a patch based on nvme/nvme-5.13.

Just FYI: Actually Javier and I am working on this patch of the next
version and have plan to post it on this weekend maybe :)

Thanks!

> 
> 
> Kind regards,
> Niklas
