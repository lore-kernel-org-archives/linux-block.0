Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3968AC433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2793619B8
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhCWQRJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:17:09 -0400
Received: from verein.lst.de ([213.95.11.211]:33120 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233264AbhCWQRE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 12:17:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 81F2068B02; Tue, 23 Mar 2021 17:17:02 +0100 (CET)
Date:   Tue, 23 Mar 2021 17:17:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210323161702.GB13402@lst.de>
References: <20210322073726.788347-1-hch@lst.de> <20210322073726.788347-3-hch@lst.de> <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me> <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me> <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com> <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me> <87a0ede6-b696-d34d-e74d-56429fe32ae7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a0ede6-b696-d34d-e74d-56429fe32ae7@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 04:13:09PM +0800, Chao Leng wrote:
>> The above reproduces with the patch applied on upstream nvme code.The new patch(blk_mq_submit_bio_direct) will cause the bug again.
> Because it revert add the bio to current->bio_list.
> Just try the upstream nvme code, and do not apply the new patch(blk_mq_submit_bio_direct).

Indeed, the patch removes the deferred submission, so the original
deadlock should not happen.
