Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA04C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C1721473
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfDHPEc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:04:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727013AbfDHPEc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 11:04:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42928ACEE;
        Mon,  8 Apr 2019 15:04:31 +0000 (UTC)
Date:   Mon, 8 Apr 2019 17:04:30 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        lennart@poettering.net, mkoutny@suse.cz
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
Message-ID: <20190408150430.GB23021@linux-x5ow.site>
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[+Cc Michal ]
On Mon, Apr 08, 2019 at 04:54:39PM +0200, Paolo Valente wrote:
> 
> 
> > Il giorno 8 apr 2019, alle ore 16:49, Johannes Thumshirn <jthumshirn@suse.de> ha scritto:
> > 
> > On Mon, Apr 08, 2019 at 04:39:35PM +0200, Paolo Valente wrote:
> >> From: Angelo Ruocco <angeloruocco90@gmail.com>
> >> 
> >> When bfq was merged into mainline, there were two I/O schedulers that
> >> implemented the proportional-share policy: bfq for blk-mq and cfq for
> >> legacy blk. bfq's interface files in the blkio/io controller have the
> >> same names as cfq. But the cgroups interface doesn't allow two
> >> entities to use the same name for their files, so for bfq we had to
> >> prepend the "bfq" prefix to each of its files. However no legacy code
> >> uses these modified file names. This naming also causes confusion, as,
> >> e.g., in [1].
> >> 
> >> Now cfq has gone with legacy blk, so there is no need any longer for
> >> these prefixes in (the never used) bfq names. In view of this fact, this
> >> commit removes these prefixes, thereby enabling legacy code to truly
> >> use the proportional share policy in blk-mq.
> >> 
> >> [1] https://github.com/systemd/systemd/issues/7057
> > 
> > Hmm, but isn't this a user-space facing interface and thus some sort of ABI?
> > Do you know what's using it and what breaks due to this conversion?
> > 
> 
> Yep, but AFAIK, the problem is exactly the opposite: nobody uses these
> names for the proportional-share policy, or wants to use these names.  I'm
> CCing Lennart too, in case he has some improbable news on this.
> 
> So the idea is to align names to what people expect, possibly before
> more confusion arises.

OK, crazy idea, not sure if Jens and Tejun will beat me for this, but
symlinks?

This way we can a) keep the old files and b) have them point to the new (a.k.a
cfq style) files.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
