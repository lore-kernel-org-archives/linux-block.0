Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A039DC433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 09:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbiCNJox (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 05:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiCNJow (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 05:44:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7241FE0B9
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 02:43:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b8so13993873pjb.4
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 02:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j0csP/ie2PCD7vyyosbKH7s1Y4gbhaiRFYIEX+vyAV0=;
        b=oTfS94QWomJ0NstLPMLDuyKtAC3pnunh6hPDlX1PEGp7lUjb2IHR/RFSmU44OMhgkx
         b2DDqUCpen/7QZys2QlxNtkGdr6qPiGltKA3DKVLHJvzNDFFM0kz8uejFcpl0/Sxb9US
         6Gu0sAgZkpjisR7Qo7yAqJpPTBJRsUpyjIMQYTRq8TPhZ6EZzAmgUo2nCjlZho2YAFx7
         wNYGEL95LFEPuvoOk+ZTCKrFCaS8gfADVWJAfBOGoujCIXeGxgO+p0Hosz4EhmkldbCT
         YgBBDwOkHPR9rc9uEUEF61O1T3LouVeg7GsgqH9MHp74+tgg101Pkz9E+A0W0KmbVElb
         PWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j0csP/ie2PCD7vyyosbKH7s1Y4gbhaiRFYIEX+vyAV0=;
        b=Xx1SOjB4F31/iFQklIbmuZogSqMYMofJPY2Jqo1NPNSbPwKVlMr0eOO8okVQSWDutk
         7MaonP90/zdMMeNMF1xeBl+CuVL+NLjL1/3jxwfeiuPyWi4rzBEyWRYab19Mr34/uFAa
         hIaJAaaKzh+mXV6v72NQDwexYlDgoKSQyJmdOOdD+WaYko23gnE8v8jzHUx43opOctsz
         aJrlPk1a5SsQDg1m6HVLeZxe5RCuFk90bpqEVjtuLPc0CtUotRXMTfjqkqXlatrf0G/t
         mAF2SGQVJQa9qCylHrlNUsq7xaRl9oGDuR+3WAWVuT/bLFNRlEQvYbJrYsKNJMM2i5Qq
         SQ+w==
X-Gm-Message-State: AOAM533CA8I4JC3TUCh6jpO5ueD2Oa/PizUYZnferYqv85ryz9hL01NO
        7kjlXd8YH2sK8YQWNR3SmtQ=
X-Google-Smtp-Source: ABdhPJzGIJgwIj/Wo+qdqrF2mPhHOqdjNkKkorQQQo8vyL4+43ePkoyPJCgXqHlX667Nyl5Dr4QIGA==
X-Received: by 2002:a17:902:c086:b0:153:56:da0e with SMTP id j6-20020a170902c08600b001530056da0emr22566271pld.146.1647251021784;
        Mon, 14 Mar 2022 02:43:41 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id s30-20020a056a001c5e00b004f73f27aa40sm19046708pfw.161.2022.03.14.02.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:43:40 -0700 (PDT)
Date:   Mon, 14 Mar 2022 18:43:36 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, suwan.kim027@gmail.com
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <Yi8OSE2hYoS8rSEo@localhost.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 13, 2022 at 12:37:21PM +0200, Max Gurtovoy wrote:
> 
> On 3/11/2022 6:07 PM, Suwan Kim wrote:
> > On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> > > On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > --- a/include/uapi/linux/virtio_blk.h
> > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > >   	 * deallocation of one or more of the sectors.
> > > >   	 */
> > > >   	__u8 write_zeroes_may_unmap;
> > > > +	__u8 unused1;
> > > > -	__u8 unused1[3];
> > > > +	__virtio16 num_poll_queues;
> > > >   } __attribute__((packed));
> > > Same as any virtio UAPI change, this has to go through the virtio TC.
> > > In particular I don't think gating a new config field on
> > > an existing feature flag is a good idea.
> > Did you mean that the polling should be based on a new feature like
> > "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
> > and features[]? If then, I will add the new feture flag and resend it.
> 
> Isn't there a way in the SPEC today to create a queue without interrupt
> vector ?

It seems that it is not possible to create a queue without interrupt
vector. If it is possible, we can expect more polling improvement.

Regards,
Suwan Kim
