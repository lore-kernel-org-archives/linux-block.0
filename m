Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A2C6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 13:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCVNw4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 09:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjCVNww (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 09:52:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D70637E6
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 06:52:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D03467373; Wed, 22 Mar 2023 14:52:00 +0100 (CET)
Date:   Wed, 22 Mar 2023 14:52:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, sagi@grimberg.me,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <20230322135200.GA16587@lst.de>
References: <20230322002350.4038048-1-kbusch@meta.com> <20230322002350.4038048-3-kbusch@meta.com> <20230322082310.GA22782@lst.de> <20230322084651.xmnup2ag3ve6jr3a@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322084651.xmnup2ag3ve6jr3a@carbon.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 09:46:51AM +0100, Daniel Wagner wrote:
> The blktest I have written for this problem fails for loop without something
> like this. We can certaintanly teach blktests not run a specific test for loop
> but currently, the _require_nvme_trtype_is_fabrics check is including loop.

Who says that we could support polling on all current and future
fabrics transports?
