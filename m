Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133A0C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 16:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJTQrW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJTQrU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 12:47:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A011DB273;
        Thu, 20 Oct 2022 09:47:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1140268C4E; Thu, 20 Oct 2022 18:47:13 +0200 (CEST)
Date:   Thu, 20 Oct 2022 18:47:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, hch@lst.de, willy@infradead.org, kch@nvidia.com,
        martin.petersen@oracle.com, johannes.thumshirn@wdc.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -nect RFC v2 0/2] block: fix uaf in
 bd_link_disk_holder()
Message-ID: <20221020164712.GA14773@lst.de>
References: <20221020132049.3947415-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020132049.3947415-1-yukuai3@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As mentioned before I don't think we should make this even more
crufty in the block layer.  See the series I just sent to move it int
dm.  
