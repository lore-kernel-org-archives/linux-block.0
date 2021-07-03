Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297E3C07E97
	for <linux-block@archiver.kernel.org>; Sat,  3 Jul 2021 05:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0BB613E6
	for <linux-block@archiver.kernel.org>; Sat,  3 Jul 2021 05:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhGCF3p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Jul 2021 01:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGCF3o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Jul 2021 01:29:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A89C061762;
        Fri,  2 Jul 2021 22:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VX6C6jpDcBYdKjazHco/JNM/nWgswOL8/+4B06FF4rQ=; b=Z0A5kfG6Q93tzG9RIz5oYOMumn
        H42JoUtgfC/AAv+xjmFvQ5BXN0msoYhbI5soE5+Zxapt0VKThK/N89kJ80o/hnEjQWWeubnxwOeh0
        /ayeKqNp6XAaO7LyUmQvivlyYnK6ILZ+GtiJNkjRByJS7apHsWAaykFM+iROCB7q9hi6HfY8LPVmq
        0mDANsT2aDx65nf3FO+148ccp1do6yduy4kU8fwhE9BqH5fe4g+4fk4ZCf6or7fE0U9H9cOpw6nt3
        RxMSpkdaAm6NQPOnj0rYweH3BDpjwhyVkzx2MSPtu7KxkTWv03wFmOe4/dwAlzvsJpZKpyDtvahLq
        hKiFOrpg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzYAm-008KWD-IK; Sat, 03 Jul 2021 05:26:39 +0000
Date:   Sat, 3 Jul 2021 06:26:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rajat Asthana <rajatasthana4@gmail.com>
Cc:     axboe@kernel.dk, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@wdc.com, jack@suse.cz, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+7d6c5587ec9cff5be65c@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: Avoid accessing an already freed kobject in
 delete_partition
Message-ID: <YN/1DOeSA5ODf1AV@infradead.org>
References: <20210702231228.261460-1-rajatasthana4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702231228.261460-1-rajatasthana4@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This should be fixed properly by:

"block: check disk exist before trying to add partition"
