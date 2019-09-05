Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EEAC43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 18:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0BC2070C
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 18:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403810AbfIESEb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:04:31 -0400
Received: from verein.lst.de ([213.95.11.211]:50749 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403808AbfIESEb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Sep 2019 14:04:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9434F68B20; Thu,  5 Sep 2019 20:04:28 +0200 (CEST)
Date:   Thu, 5 Sep 2019 20:04:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH 3/3] nvme: remove PI values definition from NVMe
 subsystem
Message-ID: <20190905180428.GD24146@lst.de>
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com> <1567701836-29725-3-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567701836-29725-3-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 05, 2019 at 07:43:56PM +0300, Max Gurtovoy wrote:
> Use block layer definition instead of re-defining it with the same
> values.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
