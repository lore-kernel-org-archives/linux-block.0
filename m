Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED7C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 14:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiCBOVk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiCBOVj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 09:21:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BEA54EA25
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646230855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xXim42TJKU27OyH+BSZTgjOWimXDKZehMWC+KI8pm6Y=;
        b=KOwbegfhweaPRrDXNpS/z6YNg068FWOKryTHyivsPSIickxKjjxhcipxfLwn9DLaNy2Ob0
        RdjWIxDAo/7eWdmylEtKiYqqjULnTw6cxnhJQyBTwN6W5TPxFoW959ZTZCOVe2ccu3Kong
        wyZTB0tJ+0v+msOJg0dXMTiAwNDkTh8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-zm8MnJV-MTmdMqNHNUfVLw-1; Wed, 02 Mar 2022 09:20:54 -0500
X-MC-Unique: zm8MnJV-MTmdMqNHNUfVLw-1
Received: by mail-wm1-f70.google.com with SMTP id 187-20020a1c19c4000000b0037cc0d56524so1983077wmz.2
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 06:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xXim42TJKU27OyH+BSZTgjOWimXDKZehMWC+KI8pm6Y=;
        b=fkktGGFPwEwjh1WpXpsnyrlVdG2kZ/kN7ayq+5kzb1ufwU1q1+iYvcaLFO0MJbUYOt
         IAm7bDRvLJmw1Pwt6i82I5qYADnKWSvMDcdZu/3qijraEgiL1OG4KMlj++ShWpoTS0px
         FZ4nO/qO/VzC3Y2Mr2H1s1v1t77EPP2tS8SEFDl5CdsPUeoVUn0lieNJb0M+lJ/PlqB4
         XZ0U/HLq+mMNoWCyZz90FSJ8stEP0AX/H0Uafb17GQNmDnzuja5qKjjAUXuXmynFPaqU
         vAY7Ro8+pHpWKKxQOnTFk80WGLAUg7qND1Vts+VaMEwFFAW4k9xLJr/vDJ4eXMnBeB/q
         SDaA==
X-Gm-Message-State: AOAM531zI8FELCk0GgsDIvjSE9JI1aSbwbipBqVAHqsMQbbNvxh3lYKW
        YtsGu34qwhC6uvJruEBPKYO8pVDaBg5GJIKHfWb/P5QsvCFOAgpojugUqHpIEFkcaPmb70Lt05f
        l9XIPkxHl0X8aB6O5zlVPqTs=
X-Received: by 2002:a5d:4bd0:0:b0:1f0:47bf:a267 with SMTP id l16-20020a5d4bd0000000b001f047bfa267mr973225wrt.365.1646230852342;
        Wed, 02 Mar 2022 06:20:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTefzp7aRoe3n8o6oVzsK0I5X5zIbqmrG9s5jxJgTHQBiVDpIOpGQq9JlRPOvYkyN8POLAmQ==
X-Received: by 2002:a5d:4bd0:0:b0:1f0:47bf:a267 with SMTP id l16-20020a5d4bd0000000b001f047bfa267mr973215wrt.365.1646230852139;
        Wed, 02 Mar 2022 06:20:52 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm5743985wms.10.2022.03.02.06.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:20:40 -0800 (PST)
Date:   Wed, 2 Mar 2022 09:20:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220302091629-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com>
 <20220302081542-mutt-send-email-mst@kernel.org>
 <bd53b0dc-bef6-cd1a-ac5c-68766089a619@nvidia.com>
 <20220302083112-mutt-send-email-mst@kernel.org>
 <CACycT3uJFNof7UNTdrEK2dVB-W9q4VVkVWnjos6TJawSRF+EDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3uJFNof7UNTdrEK2dVB-W9q4VVkVWnjos6TJawSRF+EDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 02, 2022 at 09:53:17PM +0800, Yongji Xie wrote:
> On Wed, Mar 2, 2022 at 9:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Mar 02, 2022 at 03:24:51PM +0200, Max Gurtovoy wrote:
> > >
> > > On 3/2/2022 3:17 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 02, 2022 at 11:51:27AM +0200, Max Gurtovoy wrote:
> > > > > On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
> > > > > > On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > > > > > > Currently we have a BUG_ON() to make sure the number of sg
> > > > > > > list does not exceed queue_max_segments() in virtio_queue_rq().
> > > > > > > However, the block layer uses queue_max_discard_segments()
> > > > > > > instead of queue_max_segments() to limit the sg list for
> > > > > > > discard requests. So the BUG_ON() might be triggered if
> > > > > > > virtio-blk device reports a larger value for max discard
> > > > > > > segment than queue_max_segments().
> > > > > > Hmm the spec does not say what should happen if max_discard_seg
> > > > > > exceeds seg_max. Is this the config you have in mind? how do you
> > > > > > create it?
> > > > > I don't think it's hard to create it. Just change some registers in the
> > > > > device.
> > > > >
> > > > > But with the dynamic sgl allocation that I added recently, there is no
> > > > > problem with this scenario.
> > > > Well the problem is device says it can't handle such large descriptors,
> > > > I guess it works anyway, but it seems scary.
> > >
> > > I don't follow.
> > >
> > > The only problem this patch solves is when a virtio blk device reports
> > > larger value for max_discard_segments than max_segments.
> > >
> >
> > No, the peroblem reported is when virtio blk device reports
> > max_segments < 256 but not max_discard_segments.
> > I would expect discard to follow max_segments restrictions then.
> >
> 
> I think one point is whether we want to allow the corner case that the
> device reports a larger value for max_discard_segments than
> max_segments. For example, queue size is 256, max_segments is 128 - 2,
> max_discard_segments is 256 - 2.
> 
> Thanks,
> Yongji

So if device specifies that, then I guess it's fine and from that POV
the patch is correct.  But I think the issue is when device specifies 0
which we interpret as 256 with no basis in hardware.

-- 
MST

