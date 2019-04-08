Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89889C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592AF21473
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDHPIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:08:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:42198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbfDHPIa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 11:08:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 596D1B011;
        Mon,  8 Apr 2019 15:08:29 +0000 (UTC)
Date:   Mon, 8 Apr 2019 17:08:28 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
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
Message-ID: <20190408150828.GC23021@linux-x5ow.site>
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
 <20190408150430.GB23021@linux-x5ow.site>
 <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 08, 2019 at 09:05:19AM -0600, Jens Axboe wrote:
> I did consider that, and that would be doable. But honestly, I'm having a
> hard time seeing what issue we are attempting to fix by doing this.

Yeah, I guess the real fix would be to update the documentation and the
expectations user-space has. Including eventual re-write of some udev rules or
whatever is facing these files. But to me that sounds more like a systemd or
even distro thing than a kernel thing.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
