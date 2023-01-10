Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4790DC54EBE
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 06:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjAJGzJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 01:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjAJGyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 01:54:53 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438D4C02;
        Mon,  9 Jan 2023 22:54:53 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B36168BEB; Tue, 10 Jan 2023 07:54:49 +0100 (CET)
Date:   Tue, 10 Jan 2023 07:54:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, kernel@pankajraghav.com,
        linux-kernel@vger.kernel.org, hare@suse.de, bvanassche@acm.org,
        snitzer@kernel.org, dm-devel@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 2/7] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Message-ID: <20230110065448.GB10289@lst.de>
References: <20230106083317.93938-1-p.raghav@samsung.com> <CGME20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f@eucas1p1.samsung.com> <20230106083317.93938-3-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106083317.93938-3-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
