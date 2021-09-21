Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA27C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 07:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69276611C5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 07:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhIUHPQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 03:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhIUHPP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 03:15:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60321C061574;
        Tue, 21 Sep 2021 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UM8apK1AMhOhazdy0HBfxa+/Uonxl6SHf+LLiZVVEXs=; b=OuJkjcvq+GqgEBM2UDS36I+w0K
        t8xJ2RwxvKNyjK+NhQS2GLwIT1lVYdNWNA4FchhBvu1XrGWOdRL+ZWXIkIpQM04heXKG8ZeJwep1S
        Zsh+wnSLp8vD7A6WiTrDZaGbZ6WodqRb9ilwJhylDO7q1yszAybTDJDG7F0Jz9zmpVGNpMM2Tcw/n
        ng/UEfBed7D3fNvSInTbEHYK6Se7GIXZUgLGLheI3/Pnej8G2KgRUqR1mBJhEymgRFzrwDmEupuGn
        ht8pvAQRMLeqwpMZ3G4arJIN/6YnBQmwDGBWEYiDX1dtwkZhDSywayqj4XFIVVgcYf8vN2ge7Pb72
        wspJ0XJQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSZxr-003adz-QA; Tue, 21 Sep 2021 07:13:22 +0000
Date:   Tue, 21 Sep 2021 08:13:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+f5608de5d89cc0d998c7@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Song Liu <song@kernel.org>
Subject: Re: [syzbot] possible deadlock in bd_register_pending_holders
Message-ID: <YUmGC7CKhMj4qQg1@infradead.org>
References: <000000000000e272fb05cba51fe4@google.com>
 <d4d71dc8-0373-b7a9-2a95-ba2d3c87f968@I-love.SAKURA.ne.jp>
 <8431ea39-7ace-a601-419a-dca74e1db287@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8431ea39-7ace-a601-419a-dca74e1db287@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 10:10:55AM -0700, Eric Dumazet wrote:
> Note that current kernels (which include dfbb3409b27fa42b)
> still hit this :
> 
> [    3.197383] ======================================================
> [    3.204253] WARNING: possible circular locking dependency detected
> [    3.211116] 5.15.0-dbx-DEV #16 Not tainted
> [    3.215907] ------------------------------------------------------
> [    3.222770] kinit/1 is trying to acquire lock:
> [    3.227900] ffffa09bc8971230 (&mddev->open_mutex){+.+.}-{3:3}, at: md_open+0xf3/0x150
> [    3.237803] 
>                but task is already holding lock:
> [    3.245020] ffffa09bcf003f18 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xa2/0x580

This should be fixed by:

https://marc.info/?l=linux-raid&m=163049641806992&w=2

Song, what is the plan to get that into Linus' tree?
