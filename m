Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB54FC433E1
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 12:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34D02075F
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 12:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kAgPyYWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHYMQX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgHYMQV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 08:16:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E6CC061574;
        Tue, 25 Aug 2020 05:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iWzjFMXQKDQ3srEorJCE75akBgF6LEsq0gmwzrpteCE=; b=kAgPyYWg3tIVz/7YwFh9fq/0Oe
        zGWhj7zbWrN7OtJQVj/+LUTvFUH2vvkTmjmXAe5HCpmazCE8veQ4Fs6ibtL6kBv8Q2xNp6zqVuGSO
        GdzaNjKa0irJucoIsLrmydMBaFsbSC2N66bpXLh+Fz91+rEe8DX40He2YYSKJ1sS5Q9IraAQ1xDGw
        XNJtCiOY0lQDXJNY6OtzLcK/S/6FrQ8x4b4JUfVlkYv24sp+Y8w/RGLdZ7a8aVvfi0wT1NCSmxLwe
        /rCy2QUOYQmqY43MB8JeRipnkcxX0Po/SSvfsNlaQ+upmcdX/X/GIHT7vXbmMQcozFDhnqEquLXo4
        n4Nt/DXQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAXs8-0002n1-HA; Tue, 25 Aug 2020 12:16:16 +0000
Date:   Tue, 25 Aug 2020 13:16:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, yebin <yebin10@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200825121616.GA10294@infradead.org>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825120554.13070-3-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 25, 2020 at 02:05:54PM +0200, Jan Kara wrote:
> Discarding blocks and buffers under a mounted filesystem is hardly
> anything admin wants to do. Usually it will confuse the filesystem and
> sometimes the loss of buffer_head state (including b_private field) can
> even cause crashes like:

Doesn't work if the file system uses multiple devices.  I think we
just really need to split the fs buffer_head address space from the
block device one.  Everything else is just going to cause a huge mess.
