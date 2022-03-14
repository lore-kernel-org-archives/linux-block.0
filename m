Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05164C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 13:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiCNNXS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCNNXS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 09:23:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E63C3336A
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 06:22:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p8so14345990pfh.8
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aIq+poFcfTu2a4rr4RSq7CQIzYMD4W0191h0DVdkEWk=;
        b=ZHBt0/Fz6gjmEqnZY3Opl41FbGU9rI8SqlPRYFxVhGd7lm40rQiNdl/VM7CKPvCxDf
         xx0QAJoGVq5NNzke7z1ia/QU9c6ZbDnwOsHRFSSHEHVF0d6S+wyulFb9mCwczqVOmEbV
         tqHw56hoODk6miUoDb/wLV79OQdiFJgCpzYlPz1Jzv5WNzdbYMC1JmfU5qN16aw2Undf
         SHDFEFfqElr6uCXsmaj0loQ4H+X4DFgZGkouBDa1QHdFjeFsNqkuBT82teuX1gZzSA3k
         Pv/K0h1aSRf80ifTZZDL8uUVXcYQuJJuINeufxXAl0mPB7Q+7oezuFA9QxfZmZ03UsqR
         dNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aIq+poFcfTu2a4rr4RSq7CQIzYMD4W0191h0DVdkEWk=;
        b=qtWpOZfbJjmF+Hiuqf5zcySLLv5d6eqCTqfDVXz1oGiWEs0lRggEAnW+XN5kCUV4pk
         gZh6w3YM0pzV8mOfnLNlgo4iMwvLPVV+yUo4eIusrUaFH28PNTZ2cbs5JxdqMF0XWIXV
         qwXrSBYmaUmb/O0xGMnoxdUZUEEYXG5NspH1FaMe4gm4HYp9wigNLrmKH9sHI7zSg+3F
         5eo6TNNnErjyJVrMwK3e8KPmhFI2kzWYPDLjC3ZdGqvpDgWh2rlZwL5THD3p42Wt88M/
         CVGYkpB+P9hPu0WDTdvcni2337wl7/tpzM4TsAP1ZR4rp94TbpEhyWgHZcHKRwt8F6rD
         R5yg==
X-Gm-Message-State: AOAM531csBUCxBenKnMIa6q6oCBNh+8uxuAc4RPR6Y5f4Jk4is833uPN
        z/sqpWwyMrsiLWXidwmhnGQ=
X-Google-Smtp-Source: ABdhPJwFd6PnKn7ex0Rg+Go/rh4kOK5vMFhTiEs+MjeNcD9AmTepvq0DQogTKtjOON8IolVSm3cASQ==
X-Received: by 2002:a05:6a00:c95:b0:4f7:75d5:49c with SMTP id a21-20020a056a000c9500b004f775d5049cmr21843290pfv.56.1647264127816;
        Mon, 14 Mar 2022 06:22:07 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00230d00b004f427ffd485sm21965905pfh.143.2022.03.14.06.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 06:22:07 -0700 (PDT)
Date:   Mon, 14 Mar 2022 22:22:01 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, jasowang@redhat.com,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <Yi9BeVK3GbFrxIgB@localhost.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
 <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
 <20220314071222-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314071222-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 07:15:18AM -0400, Michael S. Tsirkin wrote:
> On Mon, Mar 14, 2022 at 12:25:08PM +0200, Max Gurtovoy wrote:
> > 
> > On 3/14/2022 11:43 AM, Suwan Kim wrote:
> > > On Sun, Mar 13, 2022 at 12:37:21PM +0200, Max Gurtovoy wrote:
> > > > On 3/11/2022 6:07 PM, Suwan Kim wrote:
> > > > > On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> > > > > > On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > > > > > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > > > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > > > >    	 * deallocation of one or more of the sectors.
> > > > > > >    	 */
> > > > > > >    	__u8 write_zeroes_may_unmap;
> > > > > > > +	__u8 unused1;
> > > > > > > -	__u8 unused1[3];
> > > > > > > +	__virtio16 num_poll_queues;
> > > > > > >    } __attribute__((packed));
> > > > > > Same as any virtio UAPI change, this has to go through the virtio TC.
> > > > > > In particular I don't think gating a new config field on
> > > > > > an existing feature flag is a good idea.
> > > > > Did you mean that the polling should be based on a new feature like
> > > > > "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
> > > > > and features[]? If then, I will add the new feture flag and resend it.
> > > > Isn't there a way in the SPEC today to create a queue without interrupt
> > > > vector ?
> > > It seems that it is not possible to create a queue without interrupt
> > > vector. If it is possible, we can expect more polling improvement.
> 
> Yes, it's possible:
> 
> Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
> \field{config_msix_vector}/\field{queue_msix_vector} maps interrupts triggered
> by the configuration change/selected queue events respectively to
> the corresponding MSI-X vector. To disable interrupts for an
> event type, the driver unmaps this event by writing a special NO_VECTOR
> value:
> 
> \begin{lstlisting}
> /* Vector value used to disable MSI for queue */
> #define VIRTIO_MSI_NO_VECTOR            0xffff
> \end{lstlisting}
 
Thanks for the information.

Then, in function vp_find_vqs_msix() at virtio_pci_common.c, it sets
VIRTIO_MSI_NO_VECTOR if vritqueue->callback is NULL as below code.

static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
		struct virtqueue *vqs[], vq_callback_t *callbacks[],
...
		if (!callbacks[i])
			msix_vec = VIRTIO_MSI_NO_VECTOR;
...

In oder to create poll queue in virtio-blk, I set NULL callback for
poll virtqueues and it will create queue without irq.

Regards,
Suwan Kim
