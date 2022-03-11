Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04702C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 16:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349800AbiCKQIf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244637AbiCKQIf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 11:08:35 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AB9656F
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 08:07:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b8so8516916pjb.4
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 08:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zOr0gtbof65XNroSB9aEBciJ4KkjYPwwOkSUsRsEepE=;
        b=emB88YbGT0sZsUp7coJlchCe+NUtcegKtEQiriyr2guYzQP8S3y5rDJDxVr8ppZpDv
         ubhJ/SQFLtOvGOI6fUe/QZHs9LxV5VhcKXsmlH7dcRgtH180h1rolYRXTnglPFjMWKSj
         ZQJUpJOcSZ35FCFcTnKaWhhq1UORsYIK3Bd8uEhgkGMGaro1M/+DFqZthRY4boRFTyKB
         TOHcwGiFLZKrn1iJWSleztP7Ehdns6Ea6fIHHyNzSDKu8+uS/cCETosOKlpiNNgbpMt2
         t2FO+u7Y0G43ovq8o0uiFgSG1rGA0/PqbG9IJg7rMFt3RihFso6pV4NAdO0DAQGhHrXD
         Wdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zOr0gtbof65XNroSB9aEBciJ4KkjYPwwOkSUsRsEepE=;
        b=4MGI7k7ybstCvCW4HOdrpKV9IJTS9GtMnNPhPv8x6jGC+hSh1fbv3GYCLEG868idIq
         8aj+cX/FoCXe0xmOV8dOpG+U2sM/vh1aHJldI5qK0/JXItDkn0vx9zFw1+c6VzKSGEvN
         fkyUeoj3NfVonu0bz66m3zk+xeBXi0j+8GSnHvVtEmWQxciyGiDTMwPvsGlNW9h3A8PS
         rpKYyAtXHPVvSkqe+0mCHSNUHGB78UetS5Pb7Wz5LJtWAT9KB/8BKuFLAkmciNa7+Dnr
         YC7Kx+UKH1nHMQqE1gTOLkcpCi+MgqZKVVz5SmKnyyLDNjGodNXJWXtvNOD/telM1vMg
         QtUw==
X-Gm-Message-State: AOAM531Xqj7I3sg3z89Y7eLJXjQMowTbbPaM9IRPfhhDb/j69rlnmckN
        p8yCjdjUctEj9LZf7LYYO8ofcMZgURYzgA==
X-Google-Smtp-Source: ABdhPJyNv38QG6tid0BJr6V9M0gsQr5YQ7L0aKHgoC63IPZjfrwsLHmTGFiL9SDX4aRJ39xKiJrDIQ==
X-Received: by 2002:a17:902:aa0c:b0:150:15ed:3cd2 with SMTP id be12-20020a170902aa0c00b0015015ed3cd2mr11415059plb.131.1647014849159;
        Fri, 11 Mar 2022 08:07:29 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm11745744pfj.112.2022.03.11.08.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:07:28 -0800 (PST)
Date:   Sat, 12 Mar 2022 01:07:23 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, suwan.kim027@gamil.com
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <YitzuxYHywdCRKVO@localhost.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311103549-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > index d888f013d9ff..3fcaf937afe1 100644
> > --- a/include/uapi/linux/virtio_blk.h
> > +++ b/include/uapi/linux/virtio_blk.h
> > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> >  	 * deallocation of one or more of the sectors.
> >  	 */
> >  	__u8 write_zeroes_may_unmap;
> > +	__u8 unused1;
> >  
> > -	__u8 unused1[3];
> > +	__virtio16 num_poll_queues;
> >  } __attribute__((packed));
> 
> Same as any virtio UAPI change, this has to go through the virtio TC.
> In particular I don't think gating a new config field on
> an existing feature flag is a good idea.

Did you mean that the polling should be based on a new feature like
"VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
and features[]? If then, I will add the new feture flag and resend it.

Regards,
Suwan Kim
