Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA01C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 16:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiCKQkM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350387AbiCKQkJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 11:40:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A95F1D0D7F
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 08:39:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so8621232pjb.3
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QxWL1axODILGcRqFL6OhnIU3kbTvHdaRebsz0lDJ+VA=;
        b=M3FE6J+scP79OQkryFNBmXrH7d3rb2eWY4ro5EIqONopy5Bz4bSNarAwVdm5QJCwGp
         36pmslFvRCGf8+w/vXH2dnHALGWRHjelNpmOVzl1u+bSlqFYM9goOk8vGBLo4amrgrkv
         JN3JnJO5fLSPz9crc61gV+Lp/Ms36+Uutbf9APA3QzcTeFd6iM+WWVylehkVlqiBoiiU
         DNrmDfr7ib7p5BqvBjFDIdrcZ5zNj2Plbgc7tnjSn4lSZtThQRYbRKTNMdX99LHSwdLI
         WbkhUwW/udKJFpHnZALPB9wSVRCoXneazqtx9gqzOevMVUkphVUYvTBX+PAdPRBxhbuF
         hhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QxWL1axODILGcRqFL6OhnIU3kbTvHdaRebsz0lDJ+VA=;
        b=idZacZezTrKuZVTCE2QygEBmO0c7TzC1qToXR1yEVNo8LhBXkRD2j6YzndFSORZqzh
         c6j1GJFA83ur1oyu6lhJFipe7UASuoCpYh3ha/A7IfJ/oH7lperXTKZdc8yfGDTFKr9l
         lfC2BHNDiNgui5fNTv7U7+XbQOG6D4EaZ65Hv7v1dDB8j2ZroI3smtjtALCGWV7nZr7b
         oQbnUXgFrfEkY+ceArijnRk03dTzEphdvx2N9ZUSnGppgQnMsVv4rx51m4x19ms0ARF8
         N13RCjPNaB7J0qhEj/AyrfqI8ZmAQeYyOsY4j2Gl5I3Ru8i9VI/16Nvd6ToY1Uscd88k
         i6aQ==
X-Gm-Message-State: AOAM531/k1tqLwsd8lr1+v7eS4uGagklHY9svOu8+jCpaUetiO9wdyJN
        usV50xYd5Q9qj3R6e02FPNDF76WUoYcb9g==
X-Google-Smtp-Source: ABdhPJwGNZ3o5CSBsbP1B5SSrSP7bMQlGmkNOAOiUd55DLfijMaeRrkh/bdGRyhiWdnOJRN5i23eAg==
X-Received: by 2002:a17:90b:38c3:b0:1c5:930e:b044 with SMTP id nn3-20020a17090b38c300b001c5930eb044mr1100908pjb.198.1647016744575;
        Fri, 11 Mar 2022 08:39:04 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id 63-20020a630942000000b00372a99c1821sm8769510pgj.21.2022.03.11.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:39:04 -0800 (PST)
Date:   Sat, 12 Mar 2022 01:38:58 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, suwan.kim027@gmail.com
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <Yit7IjP09nXYkBil@localhost.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <20220311111815-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311111815-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 11:18:54AM -0500, Michael S. Tsirkin wrote:
> On Sat, Mar 12, 2022 at 01:07:23AM +0900, Suwan Kim wrote:
> > On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> > > On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > --- a/include/uapi/linux/virtio_blk.h
> > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > >  	 * deallocation of one or more of the sectors.
> > > >  	 */
> > > >  	__u8 write_zeroes_may_unmap;
> > > > +	__u8 unused1;
> > > >  
> > > > -	__u8 unused1[3];
> > > > +	__virtio16 num_poll_queues;
> > > >  } __attribute__((packed));
> > > 
> > > Same as any virtio UAPI change, this has to go through the virtio TC.
> 
> 
> Notice this pls.  Remember to copy one of the TC mailing lists.

Okay. I will send v2 to the virtio TC mailing list also.

Regards,
Suwan Kim
