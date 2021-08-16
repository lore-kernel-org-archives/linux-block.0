Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44050C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 09:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B6161B60
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 09:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhHPJf0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:35:26 -0400
Received: from verein.lst.de ([213.95.11.211]:53676 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhHPJfZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 05:35:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1587467373; Mon, 16 Aug 2021 11:34:53 +0200 (CEST)
Date:   Mon, 16 Aug 2021 11:34:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+1fb38bb7d3ce0fa3e1c4@syzkaller.appspotmail.com>,
        axboe@kernel.dk, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in bdev_evict_inode
Message-ID: <20210816093452.GB3950@lst.de>
References: <000000000000f899f205c982f8b0@google.com> <20210815134930.3216-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815134930.3216-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 15, 2021 at 09:49:30PM +0800, Hillf Danton wrote:
> After putting bdi in wb_exit(), wb->bdi is no longer stable. To fix the uaf,
> add the WB_put bit to avoid derefering a unstable pointer.
> 
> Only for thoughts.

This doesn't help with the fact that the bdi needs to be alive
until after inode_detach_wb is called.  I posted a patch for that last
week, although I'm about to post a v2 as there are more lingering issues
in this area.
