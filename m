Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED23FC77B78
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 14:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjECO4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 10:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjECO4V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 10:56:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA88F420B
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 07:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A27561166
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 14:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35735C433EF;
        Wed,  3 May 2023 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683125779;
        bh=Vy372GcCCs6KdpZsx/Lg92u1BwYcidGMSRYXpp1G+40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYmrQhjqnGkj0r3KMuY8Pih9ne4giNi+OVJzG+6PhmDms7W0/YvBLi9bW4CEK4ovm
         orsWDTwdhmmKDo3rLYObmU1Hd9ZugS9xsHbqdv4Dq9LZQW9oQdnZbCoG3nyLsX4zA7
         2FfVEk9ws81xQmA633vBcTa3Riu/2uWGOEpev+4OBNk4M82FoMufwGSgisFOQRaX/8
         mcZ06vdHYTpNsz2rQF6vXW4Gg7O18E2V7kTr190ST/4eEFnjvm4BcpdN/zX9tQCLyi
         R4S8adbxRWio8/QqBG3qDn3bZMEeeQjvE/bEZvojAeJg6bCkRK2tA0CAq55CemYjgy
         NWnOWdqefWXUA==
Date:   Wed, 3 May 2023 08:56:16 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, joshi.k@samsung.com, axboe@kernel.dk,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [RFC 3/3] nvme: create special request queue for cdev
Message-ID: <ZFJ2EP/vGOSb1TAN@kbusch-mbp.dhcp.thefacebook.com>
References: <20230501153306.537124-1-kbusch@meta.com>
 <20230501153306.537124-4-kbusch@meta.com>
 <20230503050457.GB19301@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503050457.GB19301@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 03, 2023 at 07:04:57AM +0200, Christoph Hellwig wrote:
> On Mon, May 01, 2023 at 08:33:06AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The cdev only services passthrough commands which don't merge, track
> > stats, or need accounting. Give it a special request queue with all
> > these options cleared so that we're not adding overhead for it.
> 
> Why can't we always skip these for passthrough commands on any queue
> with a little bit of core code?

A special queue without a gendisk was a little easier to ensure
it's not subscribed to any rq_qos features, iolatency, wbt,
blkthrottle. We might be able to add more blk_rq_is_passthrough()
for things we want to skip and get the same benefit. I'll look into
it.
