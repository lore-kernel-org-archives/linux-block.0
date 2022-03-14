Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B4C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 15:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiCNPOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiCNPOI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 11:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6AC3E50
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647270777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xm5VItqmMeZ6zs2ROdtREMMlUCtcYW6wNdINQGNfwNM=;
        b=TQuv7wTeFM56xiFtqtZrfXy3HP9qra5+64JDSMheFlDQzx+27ctkREUT+aPd8J89R7wzSb
        qcmxtJ9O/m1SIV/10OwV7wVhlVnQbbewMOTds4ycuLKAk8VrEm5/xNom9Mp+THFu00fDw2
        6k+NhaEnuamgJxQBin98wmo+1lEC/AE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-mbAzPj-MMfy0bWXIYSFLMA-1; Mon, 14 Mar 2022 11:12:55 -0400
X-MC-Unique: mbAzPj-MMfy0bWXIYSFLMA-1
Received: by mail-wr1-f71.google.com with SMTP id b9-20020a05600003c900b00203647caa11so4480570wrg.5
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 08:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xm5VItqmMeZ6zs2ROdtREMMlUCtcYW6wNdINQGNfwNM=;
        b=r12+C1FLuJl9xuJrVha4hyZ+zw6+9VdXXxj7DLdKGQL97eavpkr7+E0XLYVPNrqlI3
         kJO2BlSURIn6en8C3jjsdQCePRMWzA36ngtQRE0LdwvGM0pOxTfXE597J0AHvjEzQKvT
         21gwDuB+SwOR4JTBcEsoZTd4bAOOp52QJcQP5d0v3qNMXY3HUEj1voRgMxz/lk2Om75h
         MCrR1+E71a4Wuds5LCzAKppnE5P/KL2v9FdZFKBfPKKkcS5Qq+2L64XNGc/9IJuLBuQk
         kEVxnywgWAN6Er5E9+tAVxcb6sqCi6moirBR6NFk2hltgqmf3UAlN8zg4WC3Zz4bDev+
         SEew==
X-Gm-Message-State: AOAM530FdxORb+11D/Nsh4c1oGPuNb/vPleGjgEtMDNpczLWsK3DpltX
        t5W9O4xvqdmiRoaFSMhzEf0Sbxs0T3xxOn3Ft7qiwoDME8vj4tbnE3yYEEG71utCIaNYgzGWNpB
        OO5VOVRsBgVlTr9tQtSV64+s=
X-Received: by 2002:a5d:62cd:0:b0:1f0:23d2:b38c with SMTP id o13-20020a5d62cd000000b001f023d2b38cmr17563840wrv.82.1647270774507;
        Mon, 14 Mar 2022 08:12:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXqZHlp62TJ7mYscv84hghthLLQrKhjSIjAq6n5pdy+N/m2JFUJhUTeMR6qQTGPLmhq1InIw==
X-Received: by 2002:a5d:62cd:0:b0:1f0:23d2:b38c with SMTP id o13-20020a5d62cd000000b001f023d2b38cmr17563826wrv.82.1647270774280;
        Mon, 14 Mar 2022 08:12:54 -0700 (PDT)
Received: from redhat.com ([2.55.155.245])
        by smtp.gmail.com with ESMTPSA id c2-20020a056000184200b002037b40de23sm13481923wri.8.2022.03.14.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 08:12:53 -0700 (PDT)
Date:   Mon, 14 Mar 2022 11:12:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, jasowang@redhat.com,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220314111239-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
 <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
 <20220314071222-mutt-send-email-mst@kernel.org>
 <Yi9BeVK3GbFrxIgB@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi9BeVK3GbFrxIgB@localhost.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 10:22:01PM +0900, Suwan Kim wrote:
> On Mon, Mar 14, 2022 at 07:15:18AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Mar 14, 2022 at 12:25:08PM +0200, Max Gurtovoy wrote:
> > > 
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
> > > > > > > >    	 * deallocation of one or more of the sectors.
> > > > > > > >    	 */
> > > > > > > >    	__u8 write_zeroes_may_unmap;
> > > > > > > > +	__u8 unused1;
> > > > > > > > -	__u8 unused1[3];
> > > > > > > > +	__virtio16 num_poll_queues;
> > > > > > > >    } __attribute__((packed));
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
> > 
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
>  
> Thanks for the information.
> 
> Then, in function vp_find_vqs_msix() at virtio_pci_common.c, it sets
> VIRTIO_MSI_NO_VECTOR if vritqueue->callback is NULL as below code.
> 
> static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
> ...
> 		if (!callbacks[i])
> 			msix_vec = VIRTIO_MSI_NO_VECTOR;
> ...
> 
> In oder to create poll queue in virtio-blk, I set NULL callback for
> poll virtqueues and it will create queue without irq.
> 
> Regards,
> Suwan Kim

Yes, it will.

-- 
MST

