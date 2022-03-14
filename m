Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11167C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 22:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbiCNWXi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 18:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiCNWXh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 18:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F3C23D4B7
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647296546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=448GABWMYqDQxarVEaCkpTgjvImz20CTRUQciGD2cbU=;
        b=gjD4KdG+cn4QQvrn0f6VvPXDN20Qm6oze4ZdzYilGtObtTc2WWygxxjntrF45lTxHGZ4aB
        OrlPUrV9jxJ3jeCxhp+pEXHodbhK9GtwaTRwo+pPbYENXNxUaEehEhEUMWvoOTI+XjP8h2
        Ej9Q04kLPMK2UdDlcNlxj3YX/5BiFrc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-60R5_pO9NhGCYFfP5MV6xQ-1; Mon, 14 Mar 2022 18:22:25 -0400
X-MC-Unique: 60R5_pO9NhGCYFfP5MV6xQ-1
Received: by mail-ed1-f72.google.com with SMTP id x5-20020a50ba85000000b004161d68ace6so9508044ede.15
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 15:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=448GABWMYqDQxarVEaCkpTgjvImz20CTRUQciGD2cbU=;
        b=m0up3aaPJDfzkSIi0s8k5NhtRYiEBkx6SbX6Jb8Fzyk0hWNfbv8ct8joX6bCGP1K/5
         q928G/LTOFfgkEIRGDZB3SwuC2qeqry8In8agpmXDozKVQn/F2jaj+c1RBzd8HFmUFf/
         pbE0exnwaW1SfAAX2qfzaoknv6orN6x4+7dT2d1eY5V94TTQpgmo5ptX+ttvILUTnpCG
         joC3jsuMuiIUBtjflvuebrRLfLpYRgGfpAJ5lCdj9bYV+ZVyX4d5kqETT2tvxjBttzT4
         RMb9xrq+MG0sLLLaqLZs2L992XnM+R9JtBUMds87HbgvUA9G1z+9yMFwR++krr6f2uKF
         MuTw==
X-Gm-Message-State: AOAM531Gi9g0hmMdJRexwWJEN+UPt/EMZ6VYY6zLmXfASmF2nXjEd6PC
        4QWBQRoyMTgUVYyty/Q/sijLyPJv9XS5bhDdXFu/ErOlq+qH9+cNP+/5JsYr1TVnNzkYZzTPgVn
        f5D7V0Nqb8ihHv7eugi6GlhI=
X-Received: by 2002:a17:907:94cd:b0:6d9:89e1:3036 with SMTP id dn13-20020a17090794cd00b006d989e13036mr21208053ejc.231.1647296544138;
        Mon, 14 Mar 2022 15:22:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTESGPdMCjU7Jvr1WtD2xxT/v+GSQHRJ65ip+MO0R/5zTFOd1YnfN3O5Oeqw3yqAVrM+g/Qw==
X-Received: by 2002:a17:907:94cd:b0:6d9:89e1:3036 with SMTP id dn13-20020a17090794cd00b006d989e13036mr21208038ejc.231.1647296543907;
        Mon, 14 Mar 2022 15:22:23 -0700 (PDT)
Received: from redhat.com ([176.12.250.92])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm7408819ejc.197.2022.03.14.15.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 15:22:23 -0700 (PDT)
Date:   Mon, 14 Mar 2022 18:22:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Suwan Kim <suwan.kim027@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, jasowang@redhat.com,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220314182148-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
 <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
 <20220314071222-mutt-send-email-mst@kernel.org>
 <d9121e3c-abe5-fe4d-8088-8339c418c7a8@nvidia.com>
 <20220314111306-mutt-send-email-mst@kernel.org>
 <332c35ec-734b-d2bd-dd0f-c577b1c6174b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332c35ec-734b-d2bd-dd0f-c577b1c6174b@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 06:33:06PM +0200, Max Gurtovoy wrote:
> 
> On 3/14/2022 5:15 PM, Michael S. Tsirkin wrote:
> > On Mon, Mar 14, 2022 at 03:26:13PM +0200, Max Gurtovoy wrote:
> > > On 3/14/2022 1:15 PM, Michael S. Tsirkin wrote:
> > > > On Mon, Mar 14, 2022 at 12:25:08PM +0200, Max Gurtovoy wrote:
> > > > > On 3/14/2022 11:43 AM, Suwan Kim wrote:
> > > > > > On Sun, Mar 13, 2022 at 12:37:21PM +0200, Max Gurtovoy wrote:
> > > > > > > On 3/11/2022 6:07 PM, Suwan Kim wrote:
> > > > > > > > On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> > > > > > > > > On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > > > > > > > > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > > > > > > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > > > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > > > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > > > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > > > > > > >      	 * deallocation of one or more of the sectors.
> > > > > > > > > >      	 */
> > > > > > > > > >      	__u8 write_zeroes_may_unmap;
> > > > > > > > > > +	__u8 unused1;
> > > > > > > > > > -	__u8 unused1[3];
> > > > > > > > > > +	__virtio16 num_poll_queues;
> > > > > > > > > >      } __attribute__((packed));
> > > > > > > > > Same as any virtio UAPI change, this has to go through the virtio TC.
> > > > > > > > > In particular I don't think gating a new config field on
> > > > > > > > > an existing feature flag is a good idea.
> > > > > > > > Did you mean that the polling should be based on a new feature like
> > > > > > > > "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
> > > > > > > > and features[]? If then, I will add the new feture flag and resend it.
> > > > > > > Isn't there a way in the SPEC today to create a queue without interrupt
> > > > > > > vector ?
> > > > > > It seems that it is not possible to create a queue without interrupt
> > > > > > vector. If it is possible, we can expect more polling improvement.
> > > > Yes, it's possible:
> > > > 
> > > > Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
> > > > \field{config_msix_vector}/\field{queue_msix_vector} maps interrupts triggered
> > > > by the configuration change/selected queue events respectively to
> > > > the corresponding MSI-X vector. To disable interrupts for an
> > > > event type, the driver unmaps this event by writing a special NO_VECTOR
> > > > value:
> > > > 
> > > > \begin{lstlisting}
> > > > /* Vector value used to disable MSI for queue */
> > > > #define VIRTIO_MSI_NO_VECTOR            0xffff
> > > > \end{lstlisting}
> > > > 
> > > > 
> > > > 
> > > > > MST/Jason/Stefan,
> > > > > 
> > > > > can you confirm that please ?
> > > > > 
> > > > > what does VIRTQ_AVAIL_F_NO_INTERRUPT supposed to do ?
> > > > This is a hint to the device not to send interrupts.
> > > Why do you need a hint if the driver implicitly wrote 0xffff to disable MSI
> > > for a virtqueue ?
> > 
> > VIRTIO_MSI_NO_VECTOR is an expensive write into config space, followed
> > by an even more expensive read. Reliable and appropriate if you turn
> > events on/off very rarely.
> > 
> > VIRTQ_AVAIL_F_NO_INTERRUPT is an in-memory write so it's much cheaper,
> > but it's less reliable. Appropriate if you need to turn events on/off a
> > lot.
> 
> An "expensive" operation in the ctrl path during vq creation is fine IMO.

Yes.

> I see that nobody even used VIRTQ_AVAIL_F_NO_INTERRUPT in-memory write in
> Linux.

Because it's called VRING_AVAIL_F_NO_INTERRUPT there.

> > 
> > 
> > > > > > Regards,
> > > > > > Suwan Kim

