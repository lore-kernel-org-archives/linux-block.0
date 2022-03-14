Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CB1C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 15:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiCNPQz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbiCNPQy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 11:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 744396365
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647270942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SvxQBenhY0K2tHuSKRLu17L4DvLSraMyryG81r/SsG8=;
        b=cdWpw1RO79FSQ7zKZcRJbrnSh4dvr0zACwxLbVVf4dqJXfkT2d26rlyFVVUJhBGIiIp8Fu
        Z0lil7/NG/DGs7puMDYcOJjkqShhG90aflLXMMsY3B0uuNnHqGwEoPPHn0TcXtVUUTpcLa
        HnIE1BPbLzFOfwvwUb4p3QysO7sjWM0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-XT3XVSD1MsaBo_PVqe7znw-1; Mon, 14 Mar 2022 11:15:41 -0400
X-MC-Unique: XT3XVSD1MsaBo_PVqe7znw-1
Received: by mail-wm1-f70.google.com with SMTP id 3-20020a05600c230300b00384e15ceae4so9751383wmo.7
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 08:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SvxQBenhY0K2tHuSKRLu17L4DvLSraMyryG81r/SsG8=;
        b=74c0GfuGiCqhAcY6QMP6QpkyRJKHA++RAHLr7eBZJAOuMrrgAQcYN3iprCAH2hofuY
         P5uCXWpGCtA13WxPuYwe45/385wcAvGlMXuZUuAALvdu+Tuf4QbircTJDtjr26m+QHAr
         CFiFcGkQxXGVw0/TWiF1Z1vhmgxgxSRXm9zOdvzcaNHdyJx9dDF7hr3ZGcE6FpggayVZ
         MufTJXOXm8kYllEOZE0BB1b0AIfJD8GSaVXtxvEV4EU6nzVracpl0X2YOnBKgH/T1J4q
         n6xubxxKHu4OztYz0u6jiNs+DopyNZgI06D9wOcO2ApYbH0+stCFFEWZhLk2qWZ1linH
         O/lQ==
X-Gm-Message-State: AOAM5324cQVPXM61LG9T6yTBtD0rE4UEWRy66wq/q3j3Yad77bQ+IvRi
        LBT3VlxeLh6Jpqe7r5zdBmlYYqVhiAijycUAbq0DvqCYRPclo0vKB8z0xighlIWFZ022JK+bxHY
        sSK2e1hTI9YigkcTkOtWXqjs=
X-Received: by 2002:a05:600c:3590:b0:389:f1c5:fd10 with SMTP id p16-20020a05600c359000b00389f1c5fd10mr12013117wmq.76.1647270939755;
        Mon, 14 Mar 2022 08:15:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2JUgYXrReL9oDX4OetYT3pAzApLUMhnT7wy2uiAQTaGcAYO4gYWtQTf+/ly9jGC4djagRlg==
X-Received: by 2002:a05:600c:3590:b0:389:f1c5:fd10 with SMTP id p16-20020a05600c359000b00389f1c5fd10mr12013100wmq.76.1647270939561;
        Mon, 14 Mar 2022 08:15:39 -0700 (PDT)
Received: from redhat.com ([2.55.183.53])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d6745000000b001f1e4e40e42sm13479732wrw.77.2022.03.14.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 08:15:39 -0700 (PDT)
Date:   Mon, 14 Mar 2022 11:15:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Suwan Kim <suwan.kim027@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, jasowang@redhat.com,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220314111306-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
 <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
 <20220314071222-mutt-send-email-mst@kernel.org>
 <d9121e3c-abe5-fe4d-8088-8339c418c7a8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9121e3c-abe5-fe4d-8088-8339c418c7a8@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 03:26:13PM +0200, Max Gurtovoy wrote:
> 
> On 3/14/2022 1:15 PM, Michael S. Tsirkin wrote:
> > On Mon, Mar 14, 2022 at 12:25:08PM +0200, Max Gurtovoy wrote:
> > > On 3/14/2022 11:43 AM, Suwan Kim wrote:
> > > > On Sun, Mar 13, 2022 at 12:37:21PM +0200, Max Gurtovoy wrote:
> > > > > On 3/11/2022 6:07 PM, Suwan Kim wrote:
> > > > > > On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> > > > > > > On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > > > > > > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > > > > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > > > > >     	 * deallocation of one or more of the sectors.
> > > > > > > >     	 */
> > > > > > > >     	__u8 write_zeroes_may_unmap;
> > > > > > > > +	__u8 unused1;
> > > > > > > > -	__u8 unused1[3];
> > > > > > > > +	__virtio16 num_poll_queues;
> > > > > > > >     } __attribute__((packed));
> > > > > > > Same as any virtio UAPI change, this has to go through the virtio TC.
> > > > > > > In particular I don't think gating a new config field on
> > > > > > > an existing feature flag is a good idea.
> > > > > > Did you mean that the polling should be based on a new feature like
> > > > > > "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
> > > > > > and features[]? If then, I will add the new feture flag and resend it.
> > > > > Isn't there a way in the SPEC today to create a queue without interrupt
> > > > > vector ?
> > > > It seems that it is not possible to create a queue without interrupt
> > > > vector. If it is possible, we can expect more polling improvement.
> > Yes, it's possible:
> > 
> > Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
> > \field{config_msix_vector}/\field{queue_msix_vector} maps interrupts triggered
> > by the configuration change/selected queue events respectively to
> > the corresponding MSI-X vector. To disable interrupts for an
> > event type, the driver unmaps this event by writing a special NO_VECTOR
> > value:
> > 
> > \begin{lstlisting}
> > /* Vector value used to disable MSI for queue */
> > #define VIRTIO_MSI_NO_VECTOR            0xffff
> > \end{lstlisting}
> > 
> > 
> > 
> > > MST/Jason/Stefan,
> > > 
> > > can you confirm that please ?
> > > 
> > > what does VIRTQ_AVAIL_F_NO_INTERRUPT supposed to do ?
> > This is a hint to the device not to send interrupts.
> 
> Why do you need a hint if the driver implicitly wrote 0xffff to disable MSI
> for a virtqueue ?


VIRTIO_MSI_NO_VECTOR is an expensive write into config space, followed
by an even more expensive read. Reliable and appropriate if you turn
events on/off very rarely.

VIRTQ_AVAIL_F_NO_INTERRUPT is an in-memory write so it's much cheaper,
but it's less reliable. Appropriate if you need to turn events on/off a
lot.



> 
> > 
> > > > Regards,
> > > > Suwan Kim

