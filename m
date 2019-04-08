Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FD3C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53A1214C6
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDHOt1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:49:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:38920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfDHOt1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 10:49:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C07E4B00F;
        Mon,  8 Apr 2019 14:49:25 +0000 (UTC)
Date:   Mon, 8 Apr 2019 16:49:25 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, broonie@kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Angelo Ruocco <angeloruocco90@gmail.com>
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
Message-ID: <20190408144925.GA23021@linux-x5ow.site>
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408143935.9062-2-paolo.valente@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 08, 2019 at 04:39:35PM +0200, Paolo Valente wrote:
> From: Angelo Ruocco <angeloruocco90@gmail.com>
> 
> When bfq was merged into mainline, there were two I/O schedulers that
> implemented the proportional-share policy: bfq for blk-mq and cfq for
> legacy blk. bfq's interface files in the blkio/io controller have the
> same names as cfq. But the cgroups interface doesn't allow two
> entities to use the same name for their files, so for bfq we had to
> prepend the "bfq" prefix to each of its files. However no legacy code
> uses these modified file names. This naming also causes confusion, as,
> e.g., in [1].
> 
> Now cfq has gone with legacy blk, so there is no need any longer for
> these prefixes in (the never used) bfq names. In view of this fact, this
> commit removes these prefixes, thereby enabling legacy code to truly
> use the proportional share policy in blk-mq.
> 
> [1] https://github.com/systemd/systemd/issues/7057

Hmm, but isn't this a user-space facing interface and thus some sort of ABI?
Do you know what's using it and what breaks due to this conversion?

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
