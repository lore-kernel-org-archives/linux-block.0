Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFD4C4320A
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7756138F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 12:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbhHWMOo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237028AbhHWMOX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 08:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629720821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JT+bCKc38JLNC9Va4YKqVGOJW8N9pOWm+qNgeILEytE=;
        b=YwZ3v4NepPpR5DvgJ0oMHzBNqV4/W0sQPte60wcwWwQZ8DhP3Yfbe4JolFjlogSyZUqupH
        TB6QZVIk9v1Ymxm/HLhstubWF/OcCRhElvUm+LMn2RForOP9qlk8Rwuj49ngmeR59ZAWqi
        QWIc4Z+V7FbulmwICP3gXlu0GY5TkXk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-rC4GXGNXN3qdy9vBDY7bvg-1; Mon, 23 Aug 2021 08:13:40 -0400
X-MC-Unique: rC4GXGNXN3qdy9vBDY7bvg-1
Received: by mail-ed1-f72.google.com with SMTP id eg56-20020a05640228b8b02903be79801f9aso8582504edb.21
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 05:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JT+bCKc38JLNC9Va4YKqVGOJW8N9pOWm+qNgeILEytE=;
        b=XFnxhtQOLXmgqg6fHUk61i5AzdtMRLFsLRcyFLBMm4MGyceYyt/i+gHy7vbyejX+DG
         grXiws9SHoqdhWGYOlhfXTHoM64w7vR/0Z5Xylsb67wY7mpdyo4ITcRR1/jK/Fl7tH1l
         bagG5zQQ+vPV0XY3ubfOAK9HALQKF/L7W6BW4rWd+CROUhX6USF2Wyze4CxOWgFedN1p
         L8GNwf4Pup7o8qVDfvHpwrK7G3Vi5vES59LmFf8yR8w2o0Wpf5rJi12W6VxjnLl6f/rp
         1QK73LoYCWJT0VVdMDjND6y4UnaRRfhib0N8ePwVdrw+sHpQMtdGlsAHLim2Ymx2VFjh
         Uf8w==
X-Gm-Message-State: AOAM530qMmf88bOPRezAeFZxqgZPnrygDwyKHtLi31QC+qvpHqCXL+3g
        s/rgQt4ZSsigefgpnTZ/0EYcu7/TUa3zlGRS+CRwGbfkypYyV4dPUENfSshCcstgMVdYtqJwcNZ
        LnhE6dCulrMSfcLO1g0aXRIM=
X-Received: by 2002:a17:907:9602:: with SMTP id gb2mr36019881ejc.354.1629720818843;
        Mon, 23 Aug 2021 05:13:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxs3MgLnvPcrpYfGFxBWk9K8vF4MlQe2baF1pKyG/R6hpM154XvcXcuHF9RIJJddLpwSfuBWw==
X-Received: by 2002:a17:907:9602:: with SMTP id gb2mr36019860ejc.354.1629720818703;
        Mon, 23 Aug 2021 05:13:38 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
        by smtp.gmail.com with ESMTPSA id y32sm155000ede.22.2021.08.23.05.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:37 -0700 (PDT)
Date:   Mon, 23 Aug 2021 08:13:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Yongji Xie <xieyongji@bytedance.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210823080952-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com>
 <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com>
 <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com>
 <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
 <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
> It helpful if there is a justification for this.
> 
> In this case, no such HW device exist and the only device that can cause
> this trouble today is user space VDUSE device that must be validated by the
> emulation VDUSE kernel driver.
> 
> Otherwise, will can create 1000 commit like this in the virtio level (for
> example for each feature for each virtio device).

Yea, it's a lot of work but I don't think it's avoidable.

> > 
> > > > > > And regardless of userspace device, we still need to fix it for other cases.
> > > > > which cases ? Do you know that there is a buggy HW we need to workaround ?
> > > > > 
> > > > No, there isn't now. But this could be a potential attack surface if
> > > > the host doesn't trust the device.
> > > If the host doesn't trust a device, why it continues using it ?
> > > 
> > IIUC this is the case for the encrypted VMs.
> 
> what do you mean encrypted VM ?
> 
> And how this small patch causes a VM to be 100% encryption supported ?
> 
> > > Do you suggest we do these workarounds in all device drivers in the kernel ?
> > > 
> > Isn't it the driver's job to validate some unreasonable configuration?
> 
> The check should be in different layer.
> 
> Virtio blk driver should not cover on some strange VDUSE stuff.

Yes I'm not convinced VDUSE is a valid use-case. I think that for
security and robustness it should validate data it gets from userspace
right there after reading it.
But I think this is useful for the virtio hardening thing.
https://lwn.net/Articles/865216/

Yongji - I think the commit log should be much more explicit that
this is hardening. Otherwise people get confused and think this
needs a CVE or a backport for security.

-- 
MST

