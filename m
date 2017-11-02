Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:50320 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbdKBQbe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Nov 2017 12:31:34 -0400
Received: by mail-pg0-f67.google.com with SMTP id y5so64317pgq.7
        for <linux-block@vger.kernel.org>; Thu, 02 Nov 2017 09:31:34 -0700 (PDT)
Subject: Re: [PATCH] bcache: add a comment in journal bucket reading
To: tang.junhui@zte.com.cn, colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1509592094-26115-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <af5a9d9c-9088-6b1e-c72f-cb1f6e02174b@lyle.org>
Date: Thu, 2 Nov 2017 09:31:30 -0700
MIME-Version: 1.0
In-Reply-To: <1509592094-26115-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Tang--

On 11/01/2017 08:08 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> Journal bucket is a circular buffer, the bucket
> can be like YYYNNNYY, which means the first valid journal in
> the 7th bucket, and the latest valid journal in third bucket, in
> this case, if we do not try we the zero index first, We
> may get a valid journal in the 7th bucket, then we call
> find_next_bit(bitmap,ca->sb.njournal_buckets, l + 1) to get the
> first invalid bucket after the 7th bucket, because all these
> buckets is valid, so no bit 1 in bitmap, thus find_next_bit()
> function would return with ca->sb.njournal_buckets (8). So, after
> that, bcache only read journal in 7th and 8the bucket,
> the first to the third buckets are lost.
> 
> So, it is important to let developer know that, we need to try
> the zero index at first in the hash-search, and avoid any breaks
> in future's code modification.
> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>

Fixed a small whitespace error at end of line.

Reviewed-by: Michael Lyle <mlyle@lyle.org>

Thank you for making this much more clear.

Mike
