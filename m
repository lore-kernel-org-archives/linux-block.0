Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFABC6FA8E
	for <linux-block@archiver.kernel.org>; Sun, 26 Feb 2023 04:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBZE5x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Feb 2023 23:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZE5w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Feb 2023 23:57:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E593E271F;
        Sat, 25 Feb 2023 20:57:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8268160BFB;
        Sun, 26 Feb 2023 04:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900B6C433EF;
        Sun, 26 Feb 2023 04:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677387470;
        bh=405WBKAPcyTV3KmeBm8hWZpyKdTRGGvvR81EzEUChcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W2LLIGsJ16LyT818xRep54ODU1OqUY0Q4Xt9DtzjExBfo5OtWwKKrknKVb5T8izwy
         Rdj6Skda0d3ijZ7e0doUthn6OXtfYO1nq3srCYc/cIuYP7M4pm7jn5PnivlPmC4seh
         0w4yYSoD1UAv55Z4r7xANXeDJaf2BG6gV/FKYzD0=
Date:   Sat, 25 Feb 2023 20:57:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: Use atomic_long_read() to read atomic_long_t
Message-Id: <20230225205749.2effb5f902dee8919704f3cd@linux-foundation.org>
In-Reply-To: <20230225203052.0fd823a1ccf0619e89b315d8@linux-foundation.org>
References: <20230225121523.3288544-1-geert+renesas@glider.be>
        <20230225203052.0fd823a1ccf0619e89b315d8@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 25 Feb 2023 20:30:52 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> > Fix this by using atomic_long_read() instead.
> > 
> > Reported-by; noreply@ellerman.id.au
> 
> That's an interesting one.  Was this mpe@?
> 
> I like it when a Reported-by: is followed by a Link: to the report, so
> I can go hunt down such things.

I found this, and added it to the changelog:

Reported-by: kernel test robot <lkp@intel.com>
  Link: https://lore.kernel.org/oe-kbuild-all/202302241840.nwdXqE5r-lkp@intel.com/

