Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7194EC7618B
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 16:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4401C22BF5
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 16:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir8ythaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfGYQxb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:53:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41290 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfGYQxb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 12:53:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so23538336pls.8;
        Thu, 25 Jul 2019 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=In7FvxuJSL3nD+oAuTVZBinyIAwT8H4rTKstMSgDT6k=;
        b=Ir8ythaTdYfmhG6ThebrvPMDl6Or+u2JFZT2YGgHeTyemmRXmccljqmFK4CYCsFVu4
         b0obGx93qGpsIIm5LIyXE6vG7aOY/mtqok+8OuZbnEuUJQgD8kVZ4cOWX0Fbc/EK5b7U
         cBLe1gONSrxZDK4rSdj2iqlQqvWzc7bL+PwOJ06TTJIoFZ8/51euqd/vjVH5WMdfHGPa
         WEkR5xccCYN6KFevS0FdvtROl0rzmIujbWB63A0oDjuFhPOAOPpN4cmGihpjABbdeRUl
         2mU/YhQ7YtU+bSdUiEcCqXr6uP0dII213cspLlDHHvkg7ShzRQdV/mwu6N8XaGDHL7fQ
         fO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=In7FvxuJSL3nD+oAuTVZBinyIAwT8H4rTKstMSgDT6k=;
        b=cNv3uSi9tgsU47D2rxN6/WsZKQ+HeT5tzK0z9CefUJ/TQrd4Ir0eTVAVX4k+l0E8tu
         ojxt6zlEwII+JwaLLAvJgor8sK88IKu/8I9L7pPxKjHOz6Tt1sJNE+dLwsnISV1zcFOk
         DqT44kz6ZS+epH5alhpdVK5CY6XbyNcakj49LqArJSSYJoqkCVTMriPIAjoz/CXI8Kl6
         5/zmWujTZlOscND+UwRcL6cP+Ly3qnsQAH3mfS9U9L54dYAQ+8dsvqq/2g2ARVf61Eth
         7ddwdWeu5zgMv2shg/e7yfhHO065q6Sa/gw3X9mt23ohqF6iSKM8ghKapCakBqFDt/g+
         KYzA==
X-Gm-Message-State: APjAAAW62aKSGLBwE/U26h9ueqbFDlq6kP8X40XO9UUU2AzlhLHfmGlV
        wXv8lyk69UcVvzPBX6rK9SU=
X-Google-Smtp-Source: APXvYqyGN37PGpgWry3wj5md3YEsS6cW6xq7SrPkHtyUxnRKecWuxvpMKzZuTLCreZ2GPKr2WEy9uQ==
X-Received: by 2002:a17:902:f216:: with SMTP id gn22mr89782294plb.118.1564073610528;
        Thu, 25 Jul 2019 09:53:30 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id i15sm54516319pfd.160.2019.07.25.09.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 09:53:29 -0700 (PDT)
Date:   Fri, 26 Jul 2019 01:53:27 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     Hannes Reinecke <hare@suse.de>, minwoo.im@samsung.com,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Euihyeok Kwon <eh81.kwon@samsung.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH V2] mpt3sas: support target smid for [abort|query] task
Message-ID: <20190725165327.GA3081@minwoo-desktop>
References: <CGME20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
 <20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
 <860cc8cf-6419-c649-b2d9-19b82f6ebc99@suse.de>
 <CAK=zhgocY3Ute_6RiowaWsOROx3+Nzq6+WvkobmR_SB0Rt9_1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK=zhgocY3Ute_6RiowaWsOROx3+Nzq6+WvkobmR_SB0Rt9_1g@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-23 16:57:49, Sreekanth Reddy wrote:
> On Mon, Jul 15, 2019 at 11:43 AM Hannes Reinecke <hare@suse.de> wrote:
> > I think this is fundamentally wrong.
> > ABORT_TASK is used to abort a single task, which of course has to be
> > known beforehand. If you don't know the task, what exactly do you hope
> > to achieve here? Aborting random I/O?
> > Or, even worse, aborting I/O the driver uses internally and corrupt the
> > internal workflow of the driver?
> >
> > We should simply disallow any ABORT TASK from userspace if the TaskMID
> > is zero. And I would even argue to disabllow ABORT TASK from userspace
> > completely, as the smid is never relayed to userland, and as such the
> > user cannot know which task should be aborted.
> 
> Hannes,
> 
> This interface was added long time back in mpt2sas driver and I don't
> have exact reason of adding this interface at that time.
> But I know that this interface is still used by BRCM test team & few
> customers only for some functionality and regression testing.

Sreekanth, and Hannes,

Could you please give some review points on this?

Thanks,
