Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B821C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 16:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbiCKQUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350219AbiCKQUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 11:20:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70E051D0878
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 08:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647015541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AJnh/WTVytD4QJ+LQjSrAhkCQ4EpEF75dMKosoE5+jw=;
        b=Qapvkj8nB3XF3032JRKfvEvpCV003SsTsL+WgjfwoLsWP8X96NPP0TIMpxFZEw5jDVuK9B
        DUxLZ2ooXcFhyCJQWHDG6c3erIgdgmCU/d2ljqqbTD8TiKNd+ptU/DxVXd5td/cZmCqAzG
        h5jGOqhZZLB1WsSaJZ/YXpCGTg2SUzA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-Xl-Hg9K6MTSrvjWMgyOw_A-1; Fri, 11 Mar 2022 11:19:00 -0500
X-MC-Unique: Xl-Hg9K6MTSrvjWMgyOw_A-1
Received: by mail-wr1-f69.google.com with SMTP id h11-20020a5d430b000000b001f01a35a86fso2972287wrq.4
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 08:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AJnh/WTVytD4QJ+LQjSrAhkCQ4EpEF75dMKosoE5+jw=;
        b=QQ1iPsXM7v+XRi69JntEuDVk5GSTEGy0eviNOlk5rpndtuJFXIsXVpzt4P23VWP1Nd
         vdNa6UD4WjXZToAunvNRtk9YBWA1Azz9tLwTGkTNfbbzE8m5U18nMN7eRHBKBLzJe1ZD
         JMh8e8z7Asr8aDVMhGuRsznn5TRU/m0OdYK3+16v+Z2Jg9cfjO55GMMs0BiWrWhrCbMO
         wC785muoGZiXI/2dYGvYzXoJUdnoiJ+Rkj8E2CxKTnlHd4BWR2T2o8PcD7LdCsz2utff
         Kuqz3VRyY9I8GE8OwG8ieTb+eMOBb671xR3KaGdG3jMNctxp40JWFdapGSlZzGppQElq
         V9OQ==
X-Gm-Message-State: AOAM5332IFobprJieAcEUELB/JHYW6yALtdhh4tlMjzAb/pLwokTiXm7
        ItImPAUo6ji1ESndMQmhL7fuBckX3SRfsjC0vKLf+7l17oEWoCsrmWtwFjrs5LKLRV5maFxe7yN
        hIQmAvkMvAnfLsv888cPBlPM=
X-Received: by 2002:a5d:49c9:0:b0:1f0:16b2:584f with SMTP id t9-20020a5d49c9000000b001f016b2584fmr7904052wrs.710.1647015538981;
        Fri, 11 Mar 2022 08:18:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyl/ZBDUcyVD5pvPIubD+ihVN6dxnz+tjurlLQCrzXPmvl14giKcpyIB02nshY5MQ84ii1LTA==
X-Received: by 2002:a5d:49c9:0:b0:1f0:16b2:584f with SMTP id t9-20020a5d49c9000000b001f016b2584fmr7904034wrs.710.1647015538767;
        Fri, 11 Mar 2022 08:18:58 -0800 (PST)
Received: from redhat.com ([2.53.27.107])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b00387369f380bsm11873652wmq.41.2022.03.11.08.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:18:58 -0800 (PST)
Date:   Fri, 11 Mar 2022 11:18:54 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, suwan.kim027@gamil.com
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220311111815-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YitzuxYHywdCRKVO@localhost.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 12, 2022 at 01:07:23AM +0900, Suwan Kim wrote:
> On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> > On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > > index d888f013d9ff..3fcaf937afe1 100644
> > > --- a/include/uapi/linux/virtio_blk.h
> > > +++ b/include/uapi/linux/virtio_blk.h
> > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > >  	 * deallocation of one or more of the sectors.
> > >  	 */
> > >  	__u8 write_zeroes_may_unmap;
> > > +	__u8 unused1;
> > >  
> > > -	__u8 unused1[3];
> > > +	__virtio16 num_poll_queues;
> > >  } __attribute__((packed));
> > 
> > Same as any virtio UAPI change, this has to go through the virtio TC.


Notice this pls.  Remember to copy one of the TC mailing lists.

> > In particular I don't think gating a new config field on
> > an existing feature flag is a good idea.
> 
> Did you mean that the polling should be based on a new feature like
> "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
> and features[]? If then, I will add the new feture flag and resend it.
> 
> Regards,
> Suwan Kim

