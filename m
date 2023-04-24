Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C991C77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 06:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDXGUv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 02:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXGUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 02:20:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E32C2132
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2023 23:20:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D49968B05; Mon, 24 Apr 2023 08:20:41 +0200 (CEST)
Date:   Mon, 24 Apr 2023 08:20:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        martin.petersen@oracle.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, oren@nvidia.com, oevron@nvidia.com,
        israelr@nvidia.com
Subject: Re: [PATCH v1 0/2] Fix failover to non integrity NVMe path
Message-ID: <20230424062040.GA10281@lst.de>
References: <20230423141330.40437-1-mgurtovoy@nvidia.com> <20230424051144.GA9288@lst.de> <5b7ca121-2b85-ddd0-d94b-1739cc5dcbec@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7ca121-2b85-ddd0-d94b-1739cc5dcbec@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 24, 2023 at 08:10:59AM +0200, Hannes Reinecke wrote:
> Yeah, I'm slightly unhappy with this whole setup.
> If we were just doing DIF I guess the setup could work, but then we have to 
> disable DIX (as we cannot support integrity data on the non-PI path).
> But we would need an additional patch to disable DIX functionality in those 
> cases.

NVMeoF only supports inline integrity data, the remapping from out of
line integrity data is always done by the HCA for NVMe over RDMA,
and integrity data is not supported without that.

Because of that I can't see how we could sensibly support one path with
integrity offload and one without.  And yes, it might make sense to
offer a way to explicitly disable integrity support to allow forming such
a multipath setup.
