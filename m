Return-Path: <SRS0=HXqG=57=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8266C2BA19
	for <linux-block@archiver.kernel.org>; Wed, 15 Apr 2020 09:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D1320775
	for <linux-block@archiver.kernel.org>; Wed, 15 Apr 2020 09:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895627AbgDOJfD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:35:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:50964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895613AbgDOJfC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Apr 2020 05:35:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F73FAA55;
        Wed, 15 Apr 2020 09:35:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9CFD51E1250; Wed, 15 Apr 2020 11:34:59 +0200 (CEST)
Date:   Wed, 15 Apr 2020 11:34:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 0/6] bdi: fix use-after-free for bdi device
Message-ID: <20200415093459.GH501@quack2.suse.cz>
References: <20200325123843.47452-1-yuyufen@huawei.com>
 <20200414155228.GA17487@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414155228.GA17487@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 14-04-20 08:52:28, Christoph Hellwig wrote:
> Looking through this series the whoe approach of using a lock to clear
> the ->dev pointer looks rather odd to me.  What is the reason for now
> simply adding a separately allocated name field to struct
> backing_dev_info that the name is copied to on allocation, and then
> the ->dev field is not relevant for name printing and we don't need
> to copy out the name in the potentionally more fast path callers that
> want to print it?

Yeah, that's what I was suggesting as well [1] - especially since we
already have bdi->name with a dubious value (but looking into it now, we
would need a separate dev_name field since bdi->name is visible in sysfs so
we cannot change that). But Yufen explained to me that this could result in
bogus name being reported when bdi gets re-registered. Not sure if that's
serious enough but it could happen...

								Honza

[1] https://lore.kernel.org/linux-block/20200219125505.GP16121@quack2.suse.cz

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
