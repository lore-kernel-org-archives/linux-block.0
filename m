Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC48C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 12:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BAC60FF2
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 12:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhIMMgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbhIMMeR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 08:34:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0764C061760
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 05:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k9G/MyGr7rTLDGPkLzp8CXriGu+yTq0eNWCp4PwCYmM=; b=pA+MjBQUNSqOnXj19xJ727PPk1
        Yrmd4/XRm6xL/M+yE9QcZdjsw2Mshz1d9syWf5Og1A21sCxkVMss1NU/EuX3gRoxIE7KVx5MTW1NE
        pLF6HxjvlhE1khBRLlA4dAougSEjvjlq5aV38jkAGOzHHLheUKUvDoYegufr1EP2jpRzF2KbK3sBq
        SbwPZgPDgDkP13ElAeAGVBSj4aOPORiQu8Cto5kNMOXTAidBJ5R8e4awKik2884qwq+51D0TI7Uwy
        tdMj8ax5VIgdN1WMP1VZOCBnj712Rz1kxe+SGToZV6Z9tbUV4mEwlfrUWI4LvfbII0l/uLUuRIg56
        tly1drLQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPl7o-00DT20-7C; Mon, 13 Sep 2021 12:32:03 +0000
Date:   Mon, 13 Sep 2021 13:31:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: Re: [PATCH 1/3] block: Add invalidate_gendisk() helper to invalidate
 the gendisk
Message-ID: <YT9EuMgnTQezWJSQ@infradead.org>
References: <20210913112557.191-1-xieyongji@bytedance.com>
 <20210913112557.191-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913112557.191-2-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 07:25:55PM +0800, Xie Yongji wrote:
>  
> +/**
> + * invalidate_gendisk - invalidate the gendisk
> + * @disk: the struct gendisk to invalidate
> + *
> + * A helper to invalidates the gendisk. It will clean the gendisk's associated
> + * buffer/page caches and reset its internal states so that the gendisk
> + * can be reused by the drivers.
> + *
> + * Context: can sleep
> + */
> +
> +void invalidate_gendisk(struct gendisk *disk)

No need for the empty line.  Also I wonder if invalidate_disk might be a
better name - except for del_gendisk we don't really use _gendisk in
function names at all.

> +extern void invalidate_gendisk(struct gendisk *gp);

No need for the extern.  Also I'd name the argument disk, just as in
the actual implementation.

The actual functionality looks good to me despite these nitpicks.
