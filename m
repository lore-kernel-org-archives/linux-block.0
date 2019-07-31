Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA27AC32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 15:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB540208C3
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 15:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbfGaPAw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:00:52 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:17436 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388219AbfGaPAv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 11:00:51 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Jul 2019 11:00:50 EDT
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x6VEsMGX011945;
        Wed, 31 Jul 2019 16:54:22 +0200
Date:   Wed, 31 Jul 2019 16:54:22 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Greg KH <greg@kroah.com>,
        Alexander Popov <alex.popov@linux.com>, efremov@ispras.ru,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: floppy: take over maintainership
Message-ID: <20190731145422.GB11884@1wt.eu>
References: <20190712185523.7208-1-efremov@ispras.ru>
 <20190713080726.GA19611@1wt.eu>
 <ec0a6c5e-bdee-3c26-f5d2-31b883c0de5d@ispras.ru>
 <CAHk-=wi=fHuiQg1fMzqAP9cuykBQSN_feD=eALDwRPmw27UwEg@mail.gmail.com>
 <nycvar.YFH.7.76.1907172355020.5899@cbobk.fhfr.pm>
 <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Denis,

On Wed, Jul 31, 2019 at 05:47:40PM +0300, Denis Efremov wrote:
> Well, without jokes about Thunderdome, I've got time, hardware and
> would like to maintain the floppy. Except the for recent fixes,
> I described floppy ioctls in syzkaller. I've already spent quite
> a lot of time with this code. Thus, if nobody minds

There's no reason for jokes around this, I think you stepping up on
this one will be much welcome. There are still a lot of floppies in
the wild and we'd better make sure they continue to work well. Thanks
for doing this.

Willy
