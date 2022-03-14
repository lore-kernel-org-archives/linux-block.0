Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576ECC433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 12:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbiCNMmJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiCNMg4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 08:36:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E91192A5
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 05:33:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e13so13411629plh.3
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TASiAYWHV6s42bG7I6XgggS2QjYdX7TpQEABV+Awx48=;
        b=LdJ4gzjbsl+ZzJxMMTDYBfkT5uw8oPWc41Vmtsc7UNR21MkVn8x7Bf+WGLashl1aq5
         Zss3FVdbgVXdW4LoN70Hgq9K0zHRnXVxL3IUvsuQkCFa884Hfgzdv3pDXP/B1HGfjypR
         SGkhCkMsSk4MTdQoDcjQL8Us9ba+ba8Q/rRtE1sdMO0Yr6pdy79Amr9/ovR35Zc5JuR9
         gvI/KtVQhIVwB1DoAUNDRj47y2HAoh6nlZjfCwQF+OTHh4Qgl4wSDYpX2K37Pov+/KhL
         FIdejxLLnAioVY2rd5f+xruczaJrPUcOwjt44vsIbhzB0yDRsAZO7iCCMkesfpE516p6
         p50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TASiAYWHV6s42bG7I6XgggS2QjYdX7TpQEABV+Awx48=;
        b=6uNbGSW64qdZ046NWHCcP+xqD0BgBa3f0TOQ/bTsVqID8jtWPGPTBUOCNyhKFa8GvE
         7JZFQKBS/yLhF+E06OPkfVCkqK5pH/FMJ0rF+LdPowhR5/xIMcxu4LJW/pJRHEmgeLbP
         OrxJvhdFSiGTyUOcYuczac3mEfyKstmBJk6JQsd/2icC6R/gMKS/ZnNC4lpHdE+afUyS
         s60YQuRNZxS7bDHChJ2uVGxkdJHmNqWXOBpe46YD0uSgZ+f07z9K0I8/pXVr0zNMkf+9
         fCmQo3+GOfdTq2kYLl1gBGptWIG33UyCy5K6OHTmWMVQAAS1CWCbh7zhb7gbDXQyhBv0
         W9ew==
X-Gm-Message-State: AOAM532Jupj9RoOU0WpZ7UugHz6cz03chibFb+uS6VG6adVIXJlS5oAL
        sypeuInS7G+4iKCrvaj9d8M=
X-Google-Smtp-Source: ABdhPJwB0tflLx+3kx7WyHj779wsQesqlRf81af508ubvk0YuCIK/6+fgt/2P9aFMXJ//3HLgY1OTg==
X-Received: by 2002:a17:90a:c252:b0:1bc:52a8:cac8 with SMTP id d18-20020a17090ac25200b001bc52a8cac8mr35683303pjx.61.1647261193907;
        Mon, 14 Mar 2022 05:33:13 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id k5-20020aa788c5000000b004f7a02d2724sm9851998pff.50.2022.03.14.05.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 05:33:13 -0700 (PDT)
Date:   Mon, 14 Mar 2022 21:33:08 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <Yi82BL9KecQsVfgX@localhost.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
> 
> 在 2022/3/11 下午11:28, Suwan Kim 写道:
> > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > index d888f013d9ff..3fcaf937afe1 100644
> > --- a/include/uapi/linux/virtio_blk.h
> > +++ b/include/uapi/linux/virtio_blk.h
> > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> >   	 * deallocation of one or more of the sectors.
> >   	 */
> >   	__u8 write_zeroes_may_unmap;
> > +	__u8 unused1;
> > -	__u8 unused1[3];
> > +	__virtio16 num_poll_queues;
> >   } __attribute__((packed));
> 
> 
> This looks like a implementation specific (virtio-blk-pci) optimization, how
> about other implementation like vhost-user-blk?

I didn’t consider vhost-user-blk yet. But does vhost-user-blk also
use vritio_blk_config as kernel-qemu interface?

Does vhost-user-blk need additional modification to support polling
in kernel side?

Regards,
Suwan Kim
