Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33087 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeACQ5I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jan 2018 11:57:08 -0500
Received: by mail-pf0-f196.google.com with SMTP id y89so971113pfk.0
        for <linux-block@vger.kernel.org>; Wed, 03 Jan 2018 08:57:07 -0800 (PST)
Subject: Re: [PATCH] bcache: fix unmatched generic_end_io_acct() &
 generic_start_io_acct()
To: Zhai Zhaoxuan <kxuanobj@gmail.com>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Cc: tang.junhui@zte.com.cn
References: <20180103043937.28235-1-kxuanobj@gmail.com>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <ab64bfb0-652f-87c1-6acb-2e3810d4ab5b@lyle.org>
Date: Wed, 3 Jan 2018 08:57:05 -0800
MIME-Version: 1.0
In-Reply-To: <20180103043937.28235-1-kxuanobj@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/02/2018 08:39 PM, Zhai Zhaoxuan wrote:
> The function cached_dev_make_request() and flash_dev_make_request() call
> generic_start_io_acct() with (struct bcache_device)->disk when they start a
> closure. Then the function bio_complete() calls generic_end_io_acct() with
> (struct search)->orig_bio->bi_disk when the closure has done.
> Since the `bi_disk` is not the bcache device, the generic_end_io_acct() is
> called with a wrong device queue.
> 
> It causes the "inflight" (in struct hd_struct) counter keep increasing
> without decreasing.
> 
> This patch fix the problem by calling generic_end_io_acct() with
> (struct bcache_device)->disk.
> 
> Signed-off-by: Zhai Zhaoxuan <kxuanobj@gmail.com>

Verified, looks good to me, added to my for-next staging branch.

Reviewed-by: Michael Lyle <mlyle@lyle.org>
