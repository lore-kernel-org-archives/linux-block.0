Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34ACC54E94
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 05:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjAZFbl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 00:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjAZFbk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 00:31:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE42518E8;
        Wed, 25 Jan 2023 21:31:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3FE1268D09; Thu, 26 Jan 2023 06:31:37 +0100 (CET)
Date:   Thu, 26 Jan 2023 06:31:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Huijin Park <huijin.park@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bbanghj.park@gmail.com
Subject: Re: [PATCH] loop: change fsync to fdatasync when update dio
Message-ID: <20230126053136.GC28355@lst.de>
References: <CGME20230126051713epcas1p10a9005ad21887893a486100cbbd376e5@epcas1p1.samsung.com> <20230126051657.163497-1-huijin.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126051657.163497-1-huijin.park@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 26, 2023 at 02:16:57PM +0900, Huijin Park wrote:
> In general, fsync has a larger overhead than fdatasync. And since the
> dio option is for data, it seems like fdatasync is enough.
> So this patch changes it to fdatasync which has little load relatively.

The only difference is that fsync also syncs the timestamps.  So this
change looks correct, but also a bit useless given that buffered to
direct I/O or back changes aren't exactly a fast path.
