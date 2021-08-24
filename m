Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47EFC4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 07:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5FC6115A
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 07:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhHXHYd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:24:33 -0400
Received: from verein.lst.de ([213.95.11.211]:50524 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231945AbhHXHY1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 03:24:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 820E567373; Tue, 24 Aug 2021 09:23:40 +0200 (CEST)
Date:   Tue, 24 Aug 2021 09:23:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+aa0801b6b32dca9dda82@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in wb_timer_fn
Message-ID: <20210824072340.GA25108@lst.de>
References: <00000000000072e53a05c983ab22@google.com> <20210816091041.3313-1-hdanton@sina.com> <20210816093336.GA3950@lst.de> <yt9dim01iz69.fsf@linux.ibm.com> <20210819090510.GA12194@lst.de> <yt9dr1eph96a.fsf@linux.ibm.com> <20210819135308.GB3395@lst.de> <CAHj4cs-S7sTEMZ=zSreW5_PgQQVxvf-4netHy-paPR2kfY=-hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs-S7sTEMZ=zSreW5_PgQQVxvf-4netHy-paPR2kfY=-hQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 21, 2021 at 03:48:01PM +0800, Yi Zhang wrote:
> I also met similar issue with blktests, I tried to apply the patchset
> but with no luck to apply them, any suggestions to fix it.

Please just retests the latest for-5.15/block or for-next branch in
Jens' tree.
