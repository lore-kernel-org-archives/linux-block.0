Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C741C433DF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 20:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75F92075A
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 20:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593116742;
	bh=c4cTSsUezX96Rwg9PngmOXJn/n5tbOZb7vuxiLpOkvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t9zTUzBqdYkWnhhNwK5JxiQ/hSml5eYS1iTxjP8gYfMKEbn3oiYfTQreMR2TzvCkk
	 oOTCfeY2iMpkt6bTDcjJM/9fc74wHBtNwH1G8HuGhlXn34go+b7PI1zPHckF+V8o6E
	 HFv1qJ62VMeADoV6zmvhr00C1Krc+mznAzrooqzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390959AbgFYUZm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389406AbgFYUZl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 16:25:41 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D4E12072E;
        Thu, 25 Jun 2020 20:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593116741;
        bh=c4cTSsUezX96Rwg9PngmOXJn/n5tbOZb7vuxiLpOkvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmABzUh66EQBbjd3WO+57e6gCUL4bnXKtE/Mf5vjeYYErq7P5vhHPhE8pmzMinGFE
         yWjP/1btseQbBCi7kjzHtzHM9ah6bdBbG8+LNPm+vYQQ8ZkNXoA1eeMyfmbXloPudm
         hpvLxpkduVmph0dQZ0Oz9DJgtXTneH852QcSZzlM=
Date:   Fri, 26 Jun 2020 05:25:34 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Message-ID: <20200625202534.GA28784@redsun51.ssa.fujisawa.hgst.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-5-javier@javigon.com>
 <6333b2f1-a4f1-166f-5e0d-03f47389458a@lightnvm.io>
 <20200625194248.44rwwestffgz4jks@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625194248.44rwwestffgz4jks@MacBook-Pro.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 25, 2020 at 09:42:48PM +0200, Javier González wrote:
> We can use nvme passthru, but this bypasses the zoned block abstraction.
> Why not representing ZNS features in the standard zoned block API?

This looks too nvme zns specific to want the block layer in the middle.
Just use the driver's passthrough interface.
