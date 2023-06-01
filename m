Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9542FC7EE23
	for <linux-block@archiver.kernel.org>; Thu,  1 Jun 2023 06:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjFAGTF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jun 2023 02:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjFAGTE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jun 2023 02:19:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6526CE2;
        Wed, 31 May 2023 23:19:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 194B267373; Thu,  1 Jun 2023 08:18:59 +0200 (CEST)
Date:   Thu, 1 Jun 2023 08:18:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next v2] block: fix blktrace debugfs entries leak
Message-ID: <20230601061858.GA24071@lst.de>
References: <20230531092606.3037560-1-yukuai1@huaweicloud.com> <20230531124404.GA27412@lst.de> <509bcea6-21f6-3f64-01c3-02215955283d@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <509bcea6-21f6-3f64-01c3-02215955283d@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 01, 2023 at 09:50:22AM +0800, Yu Kuai wrote:
> Hi, Christoph
>
> 在 2023/05/31 20:44, Christoph Hellwig 写道:
>> I like where this is going, but did you check that this doesn't
>> introduce a potential crash with the current /dev/sg based blktrace?
>
> I just start to look at how /dev/sg is created and destroyed, however,
> I'm confused here, do you mean that the added blk_trace_shutdown() here
> might cause that /dev/sg blktrace to access freed momory or NULL
> pointer?

Yes.  Given that __blk_trace_remove clears out q->blk_trace and
frees the blk trace structure I'm worried about that.

