Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD77C43334
	for <linux-block@archiver.kernel.org>; Mon, 25 Jul 2022 06:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGYGrV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 02:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiGYGrU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 02:47:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA321055A
        for <linux-block@vger.kernel.org>; Sun, 24 Jul 2022 23:47:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1C5C768AA6; Mon, 25 Jul 2022 08:47:17 +0200 (CEST)
Date:   Mon, 25 Jul 2022 08:47:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] ublk_drv: add generic mechanism to get/set
 parameters
Message-ID: <20220725064716.GC20796@lst.de>
References: <20220723150713.750369-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723150713.750369-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While we're at it, can we clean up how the logical block size,
device size and max transfer size are set?

I think we can drop setting all of them from the ADD_DEV ioctl,
as none of them is needed.  start_dev then just sets the device
size, and everything else goes through the SET_PARAM ioctl?
