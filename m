Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E06C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 14:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbhLGO50 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 09:57:26 -0500
Received: from mail.itouring.de ([85.10.202.141]:57962 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238271AbhLGO50 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Dec 2021 09:57:26 -0500
Received: from tux.applied-asynchrony.com (p5ddd7e1c.dip0.t-ipconnect.de [93.221.126.28])
        by mail.itouring.de (Postfix) with ESMTPSA id 616B1103761;
        Tue,  7 Dec 2021 15:53:54 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 1A09BF01601;
        Tue,  7 Dec 2021 15:53:54 +0100 (CET)
Subject: Re: [PATCH] bfq: Fix use-after-free with cgroups
To:     Jan Kara <jack@suse.cz>, Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>, fvogt@suse.de,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        stable@vger.kernel.org, Fabian Vogt <fvogt@suse.com>
References: <20211201133439.3309-1-jack@suse.cz>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <28ded939-6339-c9e1-c0a3-ff84fb197eed@applied-asynchrony.com>
Date:   Tue, 7 Dec 2021 15:53:54 +0100
MIME-Version: 1.0
In-Reply-To: <20211201133439.3309-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2021-12-01 14:34, Jan Kara wrote:
> BFQ started crashing with 5.15-based kernels like:
> 
> BUG: KASAN: use-after-free in rb_erase (lib/rbtree.c:262 lib/rbtr
> Read of size 8 at addr ffff888008193098 by task bash/1472
[snip]

This does not compile when CONFIG_BFQ_GROUP_IOSCHED is disabled.
I know the patch is meant for the case where it is enabled, but still..

block/bfq-iosched.c: In function 'bfq_init_bfqq':
block/bfq-iosched.c:5362:51: error: 'struct bfq_group' has no member named 'children'
  5362 |         hlist_add_head(&bfqq->children_node, &bfqg->children);
       |                                                   ^~
make[1]: *** [scripts/Makefile.build:277: block/bfq-iosched.o] Error 1

Probably just needs a few more ifdefs :)

cheers
Holger
