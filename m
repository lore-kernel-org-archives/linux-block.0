Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12E6C48BE0
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 18:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB8B613FF
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 18:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhFJS0S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:26:18 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:41983 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJS0S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 14:26:18 -0400
Received: by mail-qt1-f176.google.com with SMTP id o20so577730qtr.8
        for <linux-block@vger.kernel.org>; Thu, 10 Jun 2021 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gi/arimkSHwydb+IRl+gsdmHypvcrITgoc6X6YtJlzo=;
        b=CrpNFLANQtl2GqFCm/Mz6BQVoy4o0fpyIY/77ZSfpYBaIeULYm8mLaFcXsUWOrAoLX
         fUyrO2xKcER0ZP1XfghZP9dAZMU0rPFSlongJWsbBnFZR486z2lfsjXFwJ1ObzDnlAxH
         UbJ5ykLFkF8nMeTFIWNH6jwuqEHk1CbSzdh0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gi/arimkSHwydb+IRl+gsdmHypvcrITgoc6X6YtJlzo=;
        b=Oy3i+J3yN1nv7w9YbRVB3DZcN0qHe/4GzM/of20P1IARZ0ZbBs/V07AjbwCGm2rkcM
         CG3p9F/1xmbbdgJni8/Dv1SCCrHHn8H7DYyqsHNa67YqkTPMq6Xe9pj0QCJYukDhXQn2
         K57I9X3zFKJydF12YBjyhhLqn4tDZng1uIPMyqnoFYYIek/Gx5fepuCUAiK/jRByum2x
         ZmcwNkXW+gArLHHHkCb2zwabZnqsBO4Xqgv2mOIkTHQoex+BFx0tdywqSnSYHSBnxlVO
         IUy1Wm4pcbXLgS9Y0HpyVshC9rGDgQzNbb5XxKBtUNcxTzhRIdt2Z4CC7f2zVXzVm+mb
         v0fQ==
X-Gm-Message-State: AOAM532HobeQgjf199+IIdj0Ey3jaKFhkxhHGMNw2JRxWCABSC2eCFiz
        zYJhwV9ATZLDseqEUQMTBE2vWg==
X-Google-Smtp-Source: ABdhPJzr/jg7uCK65jVADwAaDfKz6xQnTjHNB4oz9W8d9VnSPRV6hubXEEk8+XcP16M7322WdLinRQ==
X-Received: by 2002:a05:622a:1495:: with SMTP id t21mr98910qtx.63.1623349401115;
        Thu, 10 Jun 2021 11:23:21 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id k9sm2770435qkh.11.2021.06.10.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 11:23:20 -0700 (PDT)
Date:   Thu, 10 Jun 2021 14:23:18 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     David Hildenbrand <david@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg KH <greg@kroah.com>, Christoph Lameter <cl@gentwo.de>,
        Theodore Ts'o <tytso@mit.edu>, Jiri Kosina <jikos@kernel.org>,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Maintainers / Kernel Summit 2021 planning kick-off
Message-ID: <20210610182318.jrxe3avfhkqq7xqn@nitro.local>
References: <YH2hs6EsPTpDAqXc@mit.edu>
 <nycvar.YFH.7.76.2104281228350.18270@cbobk.fhfr.pm>
 <YIx7R6tmcRRCl/az@mit.edu>
 <alpine.DEB.2.22.394.2105271522320.172088@gentwo.de>
 <YK+esqGjKaPb+b/Q@kroah.com>
 <c46dbda64558ab884af060f405e3f067112b9c8a.camel@HansenPartnership.com>
 <b32c8672-06ee-bf68-7963-10aeabc0596c@redhat.com>
 <5038827c-463f-232d-4dec-da56c71089bd@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5038827c-463f-232d-4dec-da56c71089bd@metux.net>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 10, 2021 at 08:07:55PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 09.06.21 12:37, David Hildenbrand wrote:
> > On 28.05.21 16:58, James Bottomley wrote:

*moderator hat on*

I'm requesting that all vaccine talk is restricted solely to how it would
impact international travel to/from ksummit.

-K
