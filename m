Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F740C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 08:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42AA61372
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 08:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhHWIgL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 04:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbhHWIgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 04:36:11 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFF2C061575
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 01:35:29 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id v16so16328451ilo.10
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tx8bMR+lOBd3awFoR8CVCTlGLN+f7fEbT8oVJPyVcwE=;
        b=wB2fZ7WIH8cS/s5QYqSkhN1A1R05CYxpfXGOZ6Q9GX4SPnyavyRgNjLtejPrSFfv8i
         2gcTeRqoX3sd5/543IQ9Ir9RL+iQWkFIFCa6/SLb8SU2COeWbXisaL9W4P/rMrqe7D5X
         dJwy+yRwkcqPDfMI1960O03TgtU+E+iDBdJOPMbkN2PtpGaJ24e5Ss51RQgBQgM1ezAN
         OOrorPMHkCCCtmue4vjKfozHobJmsJK3d+w2XNFNhZ4SF/0LPJDunmpjwBU4+1f4OWRi
         UYswgxDhbqt7WxMMVLOOIiLPRzrJ3H4IVdgyvP8PS5fGNTnAF/d5eonouGqGd7RRA3It
         6WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tx8bMR+lOBd3awFoR8CVCTlGLN+f7fEbT8oVJPyVcwE=;
        b=RxlEkNGM9iKfAQD4kff6mOJvVP7VsfgYcESvuLDziY6CeCGjQuHVSpHe5ttaYOnmyY
         nPTZ+TEzTeDCH/NBwHsTyLRlOy66dqLkcTAvAK9c/0LD2RyDuMq5i+95nDGrl/nfsp72
         0LCs/qGxFEf4CyjBt9bNm5XRsmU3Q8v/9XNOd8vnhyeKWqwtXJwdYAQQH3vpX8RHZHsZ
         RnzVxRA03mcCIQUgIMM2ElaM+p4OQtwoRGDuihZ82bKatLFZoMkuIbZreyrm3IyYDLG4
         6BpXV8uKj/GI6IRO7zXYlSqCL188VHjG9TL0VYfmfrQl6zMPZ1W/Sn2E4pzLwxiJrIye
         Egig==
X-Gm-Message-State: AOAM531+6izn6XuXcFSYLJyzFryrGzcUDlwYLb4pd3+iMfxhwl66var7
        iybfzYxp9TkL3z4adGQt4XzuH8Y6W75r+S2ejEVl
X-Google-Smtp-Source: ABdhPJw0ZmW0dfx4FroLX5jChLmPb98AUNjMizR5s7Juwr0xoX1wJm0RFwAjxQCpfMfS8TLzBw+DT+expp8kywb95Us=
X-Received: by 2002:a92:c887:: with SMTP id w7mr10433450ilo.129.1629707728687;
 Mon, 23 Aug 2021 01:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com> <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com>
In-Reply-To: <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 23 Aug 2021 16:35:17 +0800
Message-ID: <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 23, 2021 at 4:07 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 8/23/2021 7:31 AM, Yongji Xie wrote:
> > On Mon, Aug 23, 2021 at 7:17 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 8/9/2021 1:16 PM, Xie Yongji wrote:
> >>> An untrusted device might presents an invalid block size
> >>> in configuration space. This tries to add validation for it
> >>> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> >>> feature bit if the value is out of the supported range.
> >> This is not clear to me. What is untrusted device ? is it a buggy device ?
> >>
> > A buggy device, the devices in an encrypted VM, or a userspace device
> > created by VDUSE [1].
> >
> > [1] https://lore.kernel.org/kvm/20210818120642.165-1-xieyongji@bytedance.com/
>
> if it's a userspace device, why don't you fix its control path code
> instead of adding workarounds in the kernel driver ?
>

VDUSE kernel module would not touch (be aware of) the device specific
configuration space. It should be more reasonable to fix it in the
device driver. There is also some existing interface (.validate()) for
doing that.

And regardless of userspace device, we still need to fix it for other cases.

Thanks,
Yongji
