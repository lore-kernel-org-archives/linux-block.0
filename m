Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5381FC433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 06:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbhLCGyZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 01:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhLCGyZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 01:54:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19F7C06174A
        for <linux-block@vger.kernel.org>; Thu,  2 Dec 2021 22:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pfny0GJjCHHK2KbapJgU+GM/Y7sre0HuCTAnjsBcoXg=; b=PhAzEEIoZZgevKe261hym14xio
        1mjuiBWeRJIGk7Vr70I+oqZTEQFXldSRlfULaPNfrBY52G4GdhTvNPblJ7OJY/+Cxx3wl6P8HQYxG
        nnm1ftR8+YnML9PAXeoCtduXLcXHh171EmpKguMTbhrCNK0inMsPv06WgYkuK+FRh/bqNTKPO+WTF
        jAeOFqWOFrtGSbw622yW6cmDrLheDAQHqCcMTqcZrJR1CNyx177YVmfNyBzK3Rd3liuXNptCmXGEz
        RL3Gy4TtTJQUCCxGEoYM062S7dZrqJxJ5aUcHq0oFCAT9oyxoWA9o0WJ+v7W+IiJfgbrbYprCJHlD
        oi2tETTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt2PG-00EcPd-1n; Fri, 03 Dec 2021 06:50:54 +0000
Date:   Thu, 2 Dec 2021 22:50:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] loop: make autoclear operation asynchronous
Message-ID: <Yam+TsPF1jaKM+Am@infradead.org>
References: <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
 <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
 <YaSpkRHgEMXrcn5i@infradead.org>
 <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
 <YaYfu0H2k0PSQL6W@infradead.org>
 <de6ec247-4a2d-7c3e-3700-90604f88e901@i-love.sakura.ne.jp>
 <20211202121615.GC1815@quack2.suse.cz>
 <3f4d1916-8e70-8914-57ba-7291f40765ae@i-love.sakura.ne.jp>
 <20211202180500.GA30284@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202180500.GA30284@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 02, 2021 at 07:05:00PM +0100, Jan Kara wrote:
> So the advantage of using task work instead of just dropping open_mutex
> before calling __loop_clr_fd() is that if something in block/bdev.c ever
> changes and starts relying on open_mutex being held throughout blkdev_put()
> then loop device handling will not suddently become broken. Generally it is
> a bad practice to drop locks (even temporarily) upper layers have acquired.
> Sometimes it is inevitable in in this case we can avoid that... So I'd
> prefer if we used task work instead of dropping open_mutex inside loop
> driver. Not sure what's Christoph's opinion though, I don't feel *that*
> strongly about it.

Dropping the lock is a complete no go a it doesn't allow proper
reasoning about the locking scheme in the block layer.

task_work_add sounds nice, but it is currently not exported which might
be for a reason (I don't really have any experience with it).
