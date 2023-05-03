Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0659AC77B78
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 05:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjECFFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 01:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECFFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 01:05:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E929198C
        for <linux-block@vger.kernel.org>; Tue,  2 May 2023 22:05:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB11368AA6; Wed,  3 May 2023 07:04:57 +0200 (CEST)
Date:   Wed, 3 May 2023 07:04:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        joshi.k@samsung.com, axboe@kernel.dk, hch@lst.de,
        xiaoguang.wang@linux.alibaba.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC 3/3] nvme: create special request queue for cdev
Message-ID: <20230503050457.GB19301@lst.de>
References: <20230501153306.537124-1-kbusch@meta.com> <20230501153306.537124-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501153306.537124-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 01, 2023 at 08:33:06AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The cdev only services passthrough commands which don't merge, track
> stats, or need accounting. Give it a special request queue with all
> these options cleared so that we're not adding overhead for it.

Why can't we always skip these for passthrough commands on any queue
with a little bit of core code?
