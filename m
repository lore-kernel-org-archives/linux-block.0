Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B466CC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 11:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbiCNLQh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbiCNLQf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 07:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 596F433370
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647256525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vRM52XfMFpa+GGYk7qRe4D8nr6y9mk+cexYCZkh1YuM=;
        b=FOju9wiVM954Y/YZYRgGLDxw39hzOmXvWwwKIOpkjjlKppnixwnXE8kiSXXKxrhLnHigkr
        Yi9fnDMDAYHtfCa89Ah2gdtCg7ckiHPHDRjvqTFu9RZ851gEnOwbtSKrP2XFWgJNJvpST3
        do36pJEeRtdG0iGUAxaBh3eQoD3ToZI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-xLSUfPNdPpe8vQ39csflnw-1; Mon, 14 Mar 2022 07:15:24 -0400
X-MC-Unique: xLSUfPNdPpe8vQ39csflnw-1
Received: by mail-wm1-f71.google.com with SMTP id c19-20020a05600c0ad300b00385bb3db625so9481552wmr.4
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 04:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vRM52XfMFpa+GGYk7qRe4D8nr6y9mk+cexYCZkh1YuM=;
        b=toitmIzBcbMqcqxpB2qRCCmj5M8pZ+/CUuwPhWkkNVPAhVN6C8cD4N1WoQ0CfrSXqW
         klaObtEmVF0Uce8VdKrQR4W/CMT5jyZSuJo2vO3A5jTjrnueOZ75ct7K6MEHDCB6CQBd
         FwLOo9dVS4pra5dpuGFGeE4CN6bV08VceMhm1Lg581MuexY+eG4E3nLyKiFMHOO0M+M9
         HuDkZJKK2ZWALPNtuYoVilm2ZXnpfqVG/ZSJ+GfYDnauVMmhHSqN7U/+YX4n/fMxgBnQ
         RFSm8LIY43bA8qg8pNpQ5Byr7FlkGVljtN2LDK7vppN0ICgGX0k5nmsEugZpukg51TIK
         b2aQ==
X-Gm-Message-State: AOAM530zef7xDiCnqOS0+Fhs9fEtmwwu5kKoL/QuY1c2qBDjOoNi92z+
        5lRpOpYu5e8/128cVDaOhHoVQJBrigxxiRifrFBbIkpXiBEY+e3jkBRPUGBvHDgA0nav3PN7EBR
        HipIGEBqr20TdY9dEDkCJ8nk=
X-Received: by 2002:a5d:63d2:0:b0:203:aa78:b80c with SMTP id c18-20020a5d63d2000000b00203aa78b80cmr5559949wrw.593.1647256523100;
        Mon, 14 Mar 2022 04:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgV5YKM6coB4lOg5TcFTzl+9eWgz47tpTOZwXZmQhnPdteRXRixkC02+1snXHeRpooHr/O1w==
X-Received: by 2002:a5d:63d2:0:b0:203:aa78:b80c with SMTP id c18-20020a5d63d2000000b00203aa78b80cmr5559930wrw.593.1647256522883;
        Mon, 14 Mar 2022 04:15:22 -0700 (PDT)
Received: from redhat.com ([2.55.183.53])
        by smtp.gmail.com with ESMTPSA id g1-20020a1c4e01000000b003899c8053e1sm20888382wmh.41.2022.03.14.04.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 04:15:22 -0700 (PDT)
Date:   Mon, 14 Mar 2022 07:15:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Suwan Kim <suwan.kim027@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, jasowang@redhat.com,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220314071222-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
 <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 12:25:08PM +0200, Max Gurtovoy wrote:
> 
> On 3/14/2022 11:43 AM, Suwan Kim wrote:
> > On Sun, Mar 13, 2022 at 12:37:21PM +0200, Max Gurtovoy wrote:
> > > On 3/11/2022 6:07 PM, Suwan Kim wrote:
> > > > On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> > > > > On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > > > > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > > >    	 * deallocation of one or more of the sectors.
> > > > > >    	 */
> > > > > >    	__u8 write_zeroes_may_unmap;
> > > > > > +	__u8 unused1;
> > > > > > -	__u8 unused1[3];
> > > > > > +	__virtio16 num_poll_queues;
> > > > > >    } __attribute__((packed));
> > > > > Same as any virtio UAPI change, this has to go through the virtio TC.
> > > > > In particular I don't think gating a new config field on
> > > > > an existing feature flag is a good idea.
> > > > Did you mean that the polling should be based on a new feature like
> > > > "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
> > > > and features[]? If then, I will add the new feture flag and resend it.
> > > Isn't there a way in the SPEC today to create a queue without interrupt
> > > vector ?
> > It seems that it is not possible to create a queue without interrupt
> > vector. If it is possible, we can expect more polling improvement.

Yes, it's possible:

Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
\field{config_msix_vector}/\field{queue_msix_vector} maps interrupts triggered
by the configuration change/selected queue events respectively to
the corresponding MSI-X vector. To disable interrupts for an
event type, the driver unmaps this event by writing a special NO_VECTOR
value:

\begin{lstlisting}
/* Vector value used to disable MSI for queue */
#define VIRTIO_MSI_NO_VECTOR            0xffff
\end{lstlisting}



> MST/Jason/Stefan,
> 
> can you confirm that please ?
>
> what does VIRTQ_AVAIL_F_NO_INTERRUPT supposed to do ?

This is a hint to the device not to send interrupts.

> 
> > Regards,
> > Suwan Kim

