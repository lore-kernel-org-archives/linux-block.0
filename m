Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70589C6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 12:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCVMyo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 08:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCVMyn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 08:54:43 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162E22202D
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 05:54:42 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c18so22387695qte.5
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679489681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F9v4u5dsmD7IdPDedAw7yl5GKCx002rE2DFuzXEhabA=;
        b=oseP/IlFp1j6s51mg5FR8BiD6pOuhlK2sA/PlZwS/47aFuK75h2plqVR7N7hDpcFa9
         RNPKysEMUcAGmfNzJFQjff8MPwtzdEDzgXasGPPvcWoLZRxVPcs0do46FVyGzpIx9O9f
         FgsKFh5qQ8h7ho1bSmqDMyyTzD9X+IKIEneS507MEDL3prFqV3lx0yiRMRFF8RpcWnLD
         y2HeeLXMMjA65EWEnQpwhRbYW5wkS0WxrYqbmrXRxpcXw54Ksy4fYNzuP6ahgYd10Qw0
         Qy4dGtMucvoCfJFJYxp/OlFfph19hl6TG3+gX53Gm423poeYD12x9UMuxq7X9L/RkxaM
         KD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9v4u5dsmD7IdPDedAw7yl5GKCx002rE2DFuzXEhabA=;
        b=0cGhbnhNEvsV8gVrIlL18gM2dZ5pyMaydHx2hslTDHwOIu9dtcb21Cnv19iIXq+LZb
         RiqSnoJ2qxywislo4N+GcIrg2RPAuzw+Vpd8esXiy+F2wiADsPvWHMB7Nf1PQ11w34W+
         vLUVoew4QHL6QvrnJ4ve9FB+cByYQqxnNdD9uN9dTnQz8RNHfKgNqXtfDkScyHMIU0hb
         KM/0wzuly8i126NDTxFGGycz0jCYDy9Kl5usqIw2t5e35nxPo7k6PhB+xAh0h6UmVGRf
         P0+UjXsaKhR8isrAPW/WoaMrUhD/R9kpKiIxRtG56EHPYocOn2SyJIOD2ET4OtBKOcGm
         gONQ==
X-Gm-Message-State: AO0yUKWLsURqfduzruXA8S2dkk1lUUjclOvHra+978RgnMFBBCIPfnD2
        AlBNdKWBk6NWUISOapdCZJihRQ==
X-Google-Smtp-Source: AK7set84B/dAzc/qRKnsrbryejsxkR+kgL8Ft54Ca1aeV7djrv80URDlXYzzFfBac/AL/7y8+qjk8Q==
X-Received: by 2002:ac8:5c93:0:b0:3e0:3187:faf3 with SMTP id r19-20020ac85c93000000b003e03187faf3mr6264695qta.13.1679489681268;
        Wed, 22 Mar 2023 05:54:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8604a000000b003d3a34d2eb2sm10168725qtm.41.2023.03.22.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:54:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pexzE-000msK-9E;
        Wed, 22 Mar 2023 09:54:40 -0300
Date:   Wed, 22 Mar 2023 09:54:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBr6kNVoa5RbNzSa@ziepe.ca>
References: <20230322123703.485544-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322123703.485544-1-sagi@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 02:37:03PM +0200, Sagi Grimberg wrote:
> No rdma device exposes its irq vectors affinity today. So the only
> mapping that we have left, is the default blk_mq_map_queues, which
> we fallback to anyways. Also fixup the only consumer of this helper
> (nvme-rdma).

This was the only caller of ib_get_vector_affinity() so please delete 
op get_vector_affinity and ib_get_vector_affinity() from verbs as well

Jason
