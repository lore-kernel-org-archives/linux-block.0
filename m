Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:47268 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdJ3FOh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2017 01:14:37 -0400
Received: by mail-pf0-f194.google.com with SMTP id z11so10073300pfk.4
        for <linux-block@vger.kernel.org>; Sun, 29 Oct 2017 22:14:37 -0700 (PDT)
Subject: Re: [PATCH] [PATCH V2] bcache: fix wrong cache_misses statistics
To: tang.junhui@zte.com.cn, bcache@lists.ewheeler.net, colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1509158391-31992-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <92c04a1a-ef09-27ec-c006-9ec60e5e9f28@lyle.org>
Date: Sun, 29 Oct 2017 22:14:34 -0700
MIME-Version: 1.0
In-Reply-To: <1509158391-31992-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/27/2017 07:39 PM, tang.junhui@zte.com.cn wrote:
> From: "tang.junhui" <tang.junhui@zte.com.cn>
> 
> Currently, Cache missed IOs are identified by s->cache_miss, but actually,
> there are many situations that missed IOs are not assigned a value for
> s->cache_miss in cached_dev_cache_miss(), for example, a bypassed IO
> (s->iop.bypass = 1), or the cache_bio allocate failed. In these situations,
> it will go to out_put or out_submit, and s->cache_miss is null, which leads
> bch_mark_cache_accounting() to treat this IO as a hit IO.
> 
> Signed-off-by: tang.junhui <tang.junhui@zte.com.cn>

Reviewed-by: Michael Lyle <mlyle@lyle.org>

Applied to my local tree for test.  Thanks!

-mpl
