Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1836CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 05:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiEJFym (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 01:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbiEJFyl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 01:54:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FCFE16;
        Mon,  9 May 2022 22:50:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B515F68AFE; Tue, 10 May 2022 07:50:39 +0200 (CEST)
Date:   Tue, 10 May 2022 07:50:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+99938118dfd9e1b0741a@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [syzbot] KASAN: use-after-free Read in bio_poll
Message-ID: <20220510055039.GA10576@lst.de>
References: <00000000000029572505de968021@google.com> <a72282ef-650c-143b-4b88-5185009c3ec2@kernel.dk> <YnmuRuO4yplt8p/p@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnmuRuO4yplt8p/p@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 10, 2022 at 08:13:58AM +0800, Ming Lei wrote:
> > Guys, should we just queue:
> > 
> > ommit 9650b453a3d4b1b8ed4ea8bcb9b40109608d1faf
> > Author: Ming Lei <ming.lei@redhat.com>
> > Date:   Wed Apr 20 22:31:10 2022 +0800
> > 
> >     block: ignore RWF_HIPRI hint for sync dio
> > 
> > up for 5.18 and stable?
> 
> I am fine with merging to 5.18 & stable.

I'm fine, too.  But are we sure this actually is one and the same
issue?  Otherwise I'll try to find some time to feed it to syzbot
first.

