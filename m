Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B65C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 03:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC2C6120D
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 03:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhDLDYI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 23:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236546AbhDLDYH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 23:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618197830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q+/toeVQ76anYVr5hc380+UCtnXRU8K/Er2NqGMCyn8=;
        b=c0IAGMo4M2BVrsvhGEtOs1fJcufo910I2kI0miuQdgyIOjdXJhjRDFh1Zt6kxiy35Wm3MI
        K57BdAT68ARpNRAbDwAlnryPaUfDM5Zb+nCtVtV2MyfMq1DOeRgpMfgTkA43M1o/tpfFd2
        iT5yPkz7wEXAePjwxynZN3PcNywhhAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-wbFTiyLaOxq0WlOvUiGhLw-1; Sun, 11 Apr 2021 23:23:46 -0400
X-MC-Unique: wbFTiyLaOxq0WlOvUiGhLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25307107ACCA;
        Mon, 12 Apr 2021 03:23:44 +0000 (UTC)
Received: from T590 (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83B16610A8;
        Mon, 12 Apr 2021 03:23:29 +0000 (UTC)
Date:   Mon, 12 Apr 2021 11:23:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Changheun Lee <nanich.lee@samsung.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [RESEND,v5,1/2] bio: limit bio max size
Message-ID: <YHO9LQUt1e0J6+l9@T590>
References: <YG1iC944hUkBniDM@kroah.com>
 <CGME20210407094610epcas1p472207e8d3ca0e5e697974c993a2a34f7@epcas1p4.samsung.com>
 <20210407092836.13016-1-nanich.lee@samsung.com>
 <BL0PR04MB65146F70831B61CB6B9AFE7CE7759@BL0PR04MB6514.namprd04.prod.outlook.com>
 <cdd26ed3-2013-7edd-b25e-557a56397614@acm.org>
 <BL0PR04MB65148B0629FF23847341BAE8E7719@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65148B0629FF23847341BAE8E7719@BL0PR04MB6514.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 11, 2021 at 10:13:01PM +0000, Damien Le Moal wrote:
> On 2021/04/09 23:47, Bart Van Assche wrote:
> > On 4/7/21 3:27 AM, Damien Le Moal wrote:
> >> On 2021/04/07 18:46, Changheun Lee wrote:
> >>> I'll prepare new patch as you recommand. It will be added setting of
> >>> limit_bio_size automatically when queue max sectors is determined.
> >>
> >> Please do that in the driver for the HW that benefits from it. Do not do this
> >> for all block devices.
> > 
> > Hmm ... is it ever useful to build a bio with a size that exceeds 
> > max_hw_sectors when submitting a bio directly to a block device, or in 
> > other words, if no stacked block driver sits between the submitter and 
> > the block device? Am I perhaps missing something?
> 
> Device performance wise, the benefits are certainly not obvious to me either.
> But for very fast block devices, I think the CPU overhead of building more
> smaller BIOs may be significant compared to splitting a large BIO into multiple
> requests. Though it may be good to revisit this with some benchmark numbers.

This patch tries to address issue[1] in do_direct_IO() in which
Changheun observed that other operations takes time between adding page
to bio.

However, do_direct_IO() just does following except for adding bio and
submitting bio:

- retrieves pages at batch(pin 64 pages each time from VM) and 

- retrieve block mapping(get_more_blocks), which is still done usually
very less times for 32MB; for new mapping, clean_bdev_aliases() may
take a bit time.

If there isn't system memory pressure, pin 64 pages won't be slow, but
get_more_blocks() may take a bit time.

Changheun, can you check if multiple get_more_blocks() is called for submitting
32MB in your test?

In my 32MB sync dio f2fs test on x86_64 VM, one buffer_head mapping can
hold 32MB, but it is one freshly new f2fs.

I'd suggest to understand the issue completely before figuring out one
solution.


[1] https://lore.kernel.org/linux-block/20210202041204.28995-1-nanich.lee@samsung.com/


Thanks,
Ming

