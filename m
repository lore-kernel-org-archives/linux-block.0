Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7A3CCA479
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 03:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiGNDlK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jul 2022 23:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGNDlJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jul 2022 23:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3139B21E19
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 20:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657770064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3PqAwSujQrcFKBakWmxqsGxJDNIOKr6UoNvVqvwCEF4=;
        b=EDC1bRo1y/XQDQk1vWuMH9c3WGg2gPN+Ue7vz/ctamE7A7Jx6bulURSM+ahqhCY0Snmlqa
        fIIrmwEsNIRfmTNO+03JEq52U32q6c6/A/PFMrs8Nl2sSrwQFBdkSa4uscD35BlG59LiZR
        R7ztKKB3LGfKBaahViArA7wrBAG+lB4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-lj0l3Q0eN2CkbUOOcky_hw-1; Wed, 13 Jul 2022 23:41:00 -0400
X-MC-Unique: lj0l3Q0eN2CkbUOOcky_hw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E77CB1C14487;
        Thu, 14 Jul 2022 03:40:59 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D52C40CF8EE;
        Thu, 14 Jul 2022 03:40:51 +0000 (UTC)
Date:   Thu, 14 Jul 2022 11:40:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
        hch@lst.de, kbusch@kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        asml.silence@gmail.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
        gost.dev@samsung.com, ming.lei@redhat.com
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Message-ID: <Ys+QPjYBDoByrfw1@T590>
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
 <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
 <43955a42-7185-2afc-9a55-80cc2de53bf9@grimberg.me>
 <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 11, 2022 at 09:22:54PM +0300, Sagi Grimberg wrote:
> 
> > > > Use the leftover space to carve 'next' field that enables linking of
> > > > io_uring_cmd structs. Also introduce a list head and few helpers.
> > > > 
> > > > This is in preparation to support nvme-mulitpath, allowing multiple
> > > > uring passthrough commands to be queued.
> > > 
> > > It's not clear to me why we need linking at that level?
> > 
> > I think the attempt is to allow something like blk_steal_bios that
> > nvme leverages for io_uring_cmd(s).
> 
> I'll rephrase because now that I read it, I think my phrasing is
> confusing.
> 
> I think the attempt is to allow something like blk_steal_bios that
> nvme leverages, but for io_uring_cmd(s). Essentially allow io_uring_cmd
> to be linked in a requeue_list.

io_uring_cmd is 1:1 with pt request, so I am wondering why not retry on
io_uring_cmd instance directly via io_uring_cmd_execute_in_task().

I feels it isn't necessary to link io_uring_cmd into list.


Thanks,
Ming

