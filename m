Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB13C4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 08:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiKCIG6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 04:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiKCIGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 04:06:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F29E0FE;
        Thu,  3 Nov 2022 01:06:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5C5D068AA6; Thu,  3 Nov 2022 09:06:28 +0100 (CET)
Date:   Thu, 3 Nov 2022 09:06:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH 1/2] block: don't allow a disk link holder to itself
Message-ID: <20221103080628.GA3346@lst.de>
References: <20221103025541.1875809-1-yukuai1@huaweicloud.com> <20221103025541.1875809-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103025541.1875809-2-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yes, this is a good one.  Please add a single sentence blurb explaing
the issue before the Test prodecure?

With that this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Thu, Nov 03, 2022 at 10:55:40AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Test procedures:
> 
> 1) dmsetup create test --table "xxx sda", assume dm-0 is created
> 2) dmsetup suspend test
> 3) dmsetup reload test --table "xxx dm-0"
> 4) dmsetup resume test

Can you wire this up for blocktests?

I've also been wondering how we could wire your other two test cases
up as I think they'be very useful.  Hopefully I can find some time
to inject delays with eBPF or something like it.
