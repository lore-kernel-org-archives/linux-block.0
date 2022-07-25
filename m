Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C77C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Jul 2022 06:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiGYGnG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 02:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiGYGnF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 02:43:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A249BEE3F
        for <linux-block@vger.kernel.org>; Sun, 24 Jul 2022 23:43:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 904B768AA6; Mon, 25 Jul 2022 08:42:59 +0200 (CEST)
Date:   Mon, 25 Jul 2022 08:42:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] ublk_drv: store device parameters
Message-ID: <20220725064259.GA20796@lst.de>
References: <20220723150713.750369-1-ming.lei@redhat.com> <20220723150713.750369-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723150713.750369-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 23, 2022 at 11:07:12PM +0800, Ming Lei wrote:
> One important goal of ublk is to provide generic framework for
> making one block device by userspace.
> 
> As one generic block device, there are still lots of parameters,
> such as max_sectors, write_cache/fua, discard related limits,
> zoned parameters, ...., so this patch starts to store & retrieve
> device parameters and prepares for implementing ctrl command of
> SET/GET_DEV_PARAMETERS.
> 
> Device parameters have to be stored somewhere, one reason is that
> disk/queue won't be allocated until START_DEV command is received,
> but device parameters have to setup before starting device.

This seems rather overeingeering and really hard to read.  Any reason
to not simply open code the parameter verification and application
and do away with the xarray and all the boiler plate code?
