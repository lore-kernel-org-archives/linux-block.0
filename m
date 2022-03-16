Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76DCC433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 13:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiCPNd2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 09:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiCPNd1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 09:33:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB9C56412
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 06:32:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n2so1815253plf.4
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YVChYeirSMvk6WLQkZtn9ajaKz7rCJw116bT5Oh15Xk=;
        b=cQEa9On7kfOpLC8cqw9NKLYtKkzM5AMgu0DjI9KFW4hcJdO4OQrOZ8jVl4Mrn2+Pby
         CmL10SXjxk5WIihbWzfOWvWTeDJ0FgzNvFGfwBOpLg1Ot1NTEqwM+qhlY+KNdLPDBZCo
         4/gET4OU6TAGyTFL91rFmlKWTfMUZOi0xOzY5vGO9W56YFWgcKHw9TLmzv2MmgN7j7B5
         i/ZICQ0tR7b8Kv2PA21jEVB9l22ZS0WlJstDZx3cY2iNcDF3u7UQpWu5o9iCQP4BOlGB
         l5XuoyNwSPswMz9KhplX5Vh71byIkMO/b5+vFTr3E5PWE+FxYrcK/suQjlmBdXUuKwXZ
         xMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YVChYeirSMvk6WLQkZtn9ajaKz7rCJw116bT5Oh15Xk=;
        b=M4KJZBEH4OXEIekuESUvIuVTHM/9SzFJ2B2bsA+lH/m3hvuyqY9JHByPKh+exZJkEp
         k4D5wzoVicQd/jIqkUTfmLwnJfX1P65PI1+1iJ/Xuzw2KVJ21Z11FojMRat5tbFEkb4O
         lAhWzglTUL5Fu11v9AUORoQ6jfvw2VCF5062CAiQS5E2g/jQ8XwxibVvHHI3W1N55rUw
         BmSMNxTAqZdHjqdt+qQgxOtrFmhUc8CXSD4FVDSn1D4deV6G9J3sr2qYtSIkLEPgb3Qx
         oLb9MV4aoQrZMxlhnsvwlJifRVTvsanC/KNqgUbthsD24qP3VOJJoJ5NOd/jM3ub9kj1
         sDyQ==
X-Gm-Message-State: AOAM533h9zAEzeAp2MvmlnOP3Mw5rq7xd2RAh/T8SFbF/k0CSIA5AHWd
        L5SQKHQIBlv2mPfL/TgJpuJwwgUyk3XcTQ==
X-Google-Smtp-Source: ABdhPJyQaa6xCWCCDvQZYOEwJUfioSMdndlJPf7qaYr+NeBsB43Wi2I3u0sr89oMCyvA8VOXOr9zTg==
X-Received: by 2002:a17:90a:ea83:b0:1bc:2cb6:78e0 with SMTP id h3-20020a17090aea8300b001bc2cb678e0mr10294257pjz.20.1647437528064;
        Wed, 16 Mar 2022 06:32:08 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm3220354pfu.120.2022.03.16.06.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 06:32:07 -0700 (PDT)
Date:   Wed, 16 Mar 2022 22:32:02 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, pbonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org, mgurtovoy@nvidia.com
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <YjHm0lCP+0CcxBvg@localhost.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
 <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
 <YjCmBkjgtQZffiXw@localhost.localdomain>
 <CACGkMEtxadf1+0Db06nE3SuQZhvyELq7ZwvKaH8x_utj91dRdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtxadf1+0Db06nE3SuQZhvyELq7ZwvKaH8x_utj91dRdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 16, 2022 at 10:02:13AM +0800, Jason Wang wrote:
> On Tue, Mar 15, 2022 at 10:43 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
> >
> > On Tue, Mar 15, 2022 at 04:59:23PM +0800, Jason Wang wrote:
> > > On Mon, Mar 14, 2022 at 8:33 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
> > >
> > > > On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
> > > > >
> > > > > 在 2022/3/11 下午11:28, Suwan Kim 写道:
> > > > > > diff --git a/include/uapi/linux/virtio_blk.h
> > > > b/include/uapi/linux/virtio_blk.h
> > > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > > >      * deallocation of one or more of the sectors.
> > > > > >      */
> > > > > >     __u8 write_zeroes_may_unmap;
> > > > > > +   __u8 unused1;
> > > > > > -   __u8 unused1[3];
> > > > > > +   __virtio16 num_poll_queues;
> > > > > >   } __attribute__((packed));
> > > > >
> > > > >
> > > > > This looks like a implementation specific (virtio-blk-pci) optimization,
> > > > how
> > > > > about other implementation like vhost-user-blk?
> > > >
> > > > I didn’t consider vhost-user-blk yet. But does vhost-user-blk also
> > > > use vritio_blk_config as kernel-qemu interface?
> > > >
> > >
> > > Yes, but see below.
> > >
> > >
> > > >
> > > > Does vhost-user-blk need additional modification to support polling
> > > > in kernel side?
> > > >
> > >
> > >
> > > No, but the issue is, things like polling looks not a good candidate for
> > > the attributes belonging to the device but the driver. So I have more
> > > questions:
> > >
> > > 1) what does it really mean for hardware virtio block devices?
> > > 2) Does driver polling help for the qemu implementation without polling?
> > > 3) Using blk_config means we can only get the benefit from the new device
> >
> > 1) what does it really mean for hardware virtio block devices?
> > 3) Using blk_config means we can only get the benefit from the new device
> >
> > This patch adds dedicated HW queue for polling purpose to virtio
> > block device.
> >
> > So I think it can be a new hw feature. And it can be a new device
> > that supports hw poll queue.
> 
> One possible issue is that the "poll" looks more like a
> software/driver concept other than the device/hardware.
> 
> >
> > BTW, I have other idea about it.
> >
> > How about adding “num-poll-queues" property as a driver parameter
> > like NVMe driver, not to QEMU virtio-blk-pci property?
> 
> It should be fine, but we need to listen to others.
> 
> >
> > If then, we don’t need to modify virtio_blk_config.
> > And we can apply the polling feature only to virtio-blk-pci.
> > But can QEMU pass “num-poll-queues" to virtio-blk driver param?
> 
> As Michael said we can leave this to guest kernel / administrator.
> 
> >
> >
> >
> > 2) Does driver polling help for the qemu implementation without polling?
> >
> > Sorry, I didn't understand your question. Could you please explain more about?
> 
> I mean does the polling work for the ordinary qemu block device
> without busy polling?
 

Yes. The test result in the patch description was done on the normal
qemu without polling. QEMU just passes 'num-poll-queues' to a guest
without any additional settings.
It improves guest I/O performance.

Regards,
Suwan Kim
