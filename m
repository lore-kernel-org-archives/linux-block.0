Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E81CCA482
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 14:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiGROcx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 10:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiGROc0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 10:32:26 -0400
Received: from relay3.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D650023173
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 07:32:25 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 5B8778091B;
        Mon, 18 Jul 2022 14:32:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id C991F80013;
        Mon, 18 Jul 2022 14:32:22 +0000 (UTC)
Message-ID: <49a8099eb7dd01e9d2d190056171341d87cd442b.camel@perches.com>
Subject: Re: [PATCH] nbd: add missing definition of pr_fmt
From:   Joe Perches <joe@perches.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, josef@toxicpanda.com,
        axboe@kernel.dk, houtao1@huawei.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Date:   Mon, 18 Jul 2022 07:32:21 -0700
In-Reply-To: <853a5164-78cf-1ccb-8e18-cff5b5bce4ff@huaweicloud.com>
References: <20220706093320.1962871-1-yukuai1@huaweicloud.com>
         <853a5164-78cf-1ccb-8e18-cff5b5bce4ff@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: zn5wsm8bu3ibsfq9fmhf1s3698hxhkmh
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C991F80013
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19u1lF+U+u5u4KTIb69mjPigTZKoouq7xY=
X-HE-Tag: 1658154742-75497
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2022-07-18 at 21:52 +0800, Yu Kuai wrote:
> 在 2022/07/06 17:33, Yu Kuai 写道:
> > From: Yu Kuai <yukuai3@huawei.com>
> > 
> > commit 1243172d5894 ("nbd: use pr_err to output error message") tries
> > to define pr_fmt and use short pr_err() to output error message,
> > however, the definition is missed.
> 
> friendly ping ...
[]
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
[]
> > @@ -44,6 +44,9 @@
> >   #include <linux/nbd-netlink.h>
> >   #include <net/genetlink.h>
> >   
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) "nbd: " fmt
> > +

Typically, this #define is place before all #include lines
so there is no need for an #undef

