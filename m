Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE7C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 23:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7042086C
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 23:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfGOXQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 19:16:56 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33398 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731058AbfGOXQ4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 19:16:56 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hnADA-0007pe-Cs; Mon, 15 Jul 2019 17:16:49 -0600
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>
References: <20190712235742.22646-1-logang@deltatee.com>
 <20190715231411.GB5449@vader>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <91813de2-22cb-f191-4bae-0f1306422c07@deltatee.com>
Date:   Mon, 15 Jul 2019 17:16:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715231411.GB5449@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, jthumshirn@suse.de, tytso@mit.edu, mmoese@suse.de, chaitanya.kulkarni@wdc.com, osandov@fb.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, osandov@osandov.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests 00/12] Fix nvme block test issues
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-07-15 5:14 p.m., Omar Sandoval wrote:
> 
> Thanks for cleaning this up! I replied with one nitpick, and besides
> that and comments from the other reviewers, I'm happy with it overall
> (assuming it passes shellcheck).

Thanks, yes my sed skills are obviously not as good as yours. I'll fix
that nit up for v2 which I'll send in a couple days.

I have run "make check" on the series and it does pass.

Logan

