Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CFC54EBE
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 09:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjAJJnb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 04:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjAJJn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 04:43:28 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BDF1AF;
        Tue, 10 Jan 2023 01:43:21 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D623968BEB; Tue, 10 Jan 2023 10:43:16 +0100 (CET)
Date:   Tue, 10 Jan 2023 10:43:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [PATCH 7/7] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Message-ID: <20230110094316.GA14143@lst.de>
References: <20230106083317.93938-1-p.raghav@samsung.com> <CGME20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e@eucas1p2.samsung.com> <20230106083317.93938-8-p.raghav@samsung.com> <20230110065822.GF10289@lst.de> <35293c0c-2d72-c4ee-2296-079d56df7d5b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35293c0c-2d72-c4ee-2296-079d56df7d5b@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 10, 2023 at 10:07:39AM +0100, Pankaj Raghav wrote:
> I just extracted the cleanup from my old series. Do you think it is better
> to send it as a separate patch instead of adding it along in this series?

dm and block have different maintainers.  So unless there is a
dependency it's better to split the patches out.
