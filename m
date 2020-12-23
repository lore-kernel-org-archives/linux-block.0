Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157DBC433E0
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 11:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7AA22240
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 11:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgLWLBh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 06:01:37 -0500
Received: from m12-18.163.com ([220.181.12.18]:49909 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbgLWLBh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 06:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=M35LH
        ELfTDr+95tytg/ZBbWoj5oyIhKQQ5Gnw2hDcsQ=; b=SLWB4RWKdTfsfCRzKt1Yn
        weMXlV9BoCZLuuv9AeVO0n5n869bGL55CfyWFeuxBPP3BqJwJePOHg6eb5wqd1FU
        7vZ6GB1qON11WqiT4mULktW3eksaSFN42ePl4kODArdbzGz7KlpQZnEgyflQHz28
        WLvtZAs527wAigXyJx4Kzg=
Received: from localhost (unknown [101.86.213.121])
        by smtp14 (Coremail) with SMTP id EsCowAAn34LfDONfEs8NLQ--.30515S2;
        Wed, 23 Dec 2020 17:24:48 +0800 (CST)
Date:   Wed, 23 Dec 2020 17:24:47 +0800
From:   Hui Su <sh_def@163.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        sh_def@163.com
Subject: Re: [PATCH] blokc/blk-merge: remove the next_bvec label in
 __blk_bios_map_sg()linux-block@vger.kernel.org (open list:BLOCK LAYER)
Message-ID: <20201223092447.GA1558053@ubuntu-A520I-AC>
References: <20201223043158.GA1502002@ubuntu-A520I-AC>
 <20201223083307.GA27350@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223083307.GA27350@infradead.org>
X-CM-TRANSID: EsCowAAn34LfDONfEs8NLQ--.30515S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4iLL0DUUUUU
X-Originating-IP: [101.86.213.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBDgAEX1rbLpibAQAAs4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 23, 2020 at 08:33:07AM +0000, Christoph Hellwig wrote:
> On Wed, Dec 23, 2020 at 12:31:58PM +0800, sh wrote:
> > remove the next_bvec label in __blk_bios_map_sg(), simplify the logic
> > of traversal bvec.
> 
> What makes you believe that this simplifies anything?

1. this change remove the jump lable, so we do not need goto.
2. we do not need to assign flase to new_bio in the
bio_for_each_bvec, we only need to assign false to new_bio at first.

And I have resend a PATCH V2, this change have some format problem.

Thanks.

