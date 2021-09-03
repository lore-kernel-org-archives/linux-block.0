Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2C2C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 09:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56C7610A1
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 09:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348581AbhICJFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 05:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348580AbhICJFt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Sep 2021 05:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630659886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a35OZamz4FhULMDWjA+MIpzd8IbhFlUnBRFIx65TG18=;
        b=Zt4azUur3K5JP76jjkcBUcrgj6sagIWwhRb0BV5U+R5pIrRdRakAjFcJI1tzEXaapHvLrl
        TbnOMZcS6p3bMn2mO24JsecV+eewtVDR/gSXmRtT/smdc3ZMOvZXNuwlfORkVw6ScxSkVI
        UkHHszdLfi+GH1LqODC/M0yQe2JJy7g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-9XnlTQRiPRCwoxssEmIx_g-1; Fri, 03 Sep 2021 05:04:44 -0400
X-MC-Unique: 9XnlTQRiPRCwoxssEmIx_g-1
Received: by mail-wm1-f72.google.com with SMTP id j33-20020a05600c48a100b002e879427915so1668697wmp.5
        for <linux-block@vger.kernel.org>; Fri, 03 Sep 2021 02:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a35OZamz4FhULMDWjA+MIpzd8IbhFlUnBRFIx65TG18=;
        b=FxapZJV9IWvDitgRoG5O4PyErG0QaCUvbxdK7ILRqnGJ9DLDg64AZNwNtYox4ELCAY
         ao+k0dUOWxT9zPOPcGApimo0g4YTI5BL/66charvTOdIbmzY73LK+n/WkqjgbYlAEr25
         1odheloywNV3QeWPg/HLiYLG91Qho+IkkYCZQiGLznCfemM2z/iEIrZ35KI8g3La0zSE
         xURL5yhN1iriedWVBFVGCFnzQT7wyN+5e6esa+4M0FYqU/kbXE/Bj3icnuSTR/GPzBDQ
         2Mr9fSXx623OjB+wJXiVJndt6/bKcuwiTAHKfNMp+6j0q0aWbrM0GX3vGoUQFoW0PUAP
         Oz9A==
X-Gm-Message-State: AOAM533hrHv+oaZa6Ldp70K9NCF9fGTTI8pel8b+XRg3FYO+nUNOAeUm
        XdMYfNICwKcAEC4YpT4pgA/okX8kd4i+JDEKERJ08bp2sZt62SUyMGJJfkzenp7aCHx+3DyhVrU
        utJeWvhIiGipj6u7Ad8FqG0Y=
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr7316060wmj.4.1630659883833;
        Fri, 03 Sep 2021 02:04:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxq1o45OPMNe+RtszcnJRaHC5co9mJquGrSZkuN/bgyyco2U6W6QjJBBk7GWQODKEhxLdyBqQ==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr7316037wmj.4.1630659883591;
        Fri, 03 Sep 2021 02:04:43 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207f:7f47:ccd3:7600:6a2d:c5a])
        by smtp.gmail.com with ESMTPSA id h8sm3665497wmb.35.2021.09.03.02.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 02:04:42 -0700 (PDT)
Date:   Fri, 3 Sep 2021 05:04:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        oren@nvidia.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH 1/1] virtio-blk: remove unneeded "likely" statements
Message-ID: <20210903050418-mutt-send-email-mst@kernel.org>
References: <20210830120111.22661-1-mgurtovoy@nvidia.com>
 <YTDnD1c8rk3SWcx9@stefanha-x1.localdomain>
 <6800aad7-038a-b251-4ad5-3dc005b0a8a1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6800aad7-038a-b251-4ad5-3dc005b0a8a1@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 02, 2021 at 10:13:04PM +0300, Max Gurtovoy wrote:
> 
> On 9/2/2021 6:00 PM, Stefan Hajnoczi wrote:
> > On Mon, Aug 30, 2021 at 03:01:11PM +0300, Max Gurtovoy wrote:
> > > Usually we use "likely/unlikely" to optimize the fast path. Remove
> > > redundant "likely" statements in the control path to ease on the code.
> > > 
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   drivers/block/virtio_blk.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > It would be nice to tweak the commit description before merging this. I
> > had trouble parsing the second sentence. If I understand correctly the
> > purpose of this patch is to make the code simpler and easier to read:
> > 
> >    s/ease on the code/simplify the code and make it easier to read/
> 
> I'm ok with this change in commit message.
> 
> MST,
> 
> can you apply this change if you'll pick this commit ?
> 
> -Max.


Just repost with a fixed commit log pls, easier for me.
Thanks!

> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

