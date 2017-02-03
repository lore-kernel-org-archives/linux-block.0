Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33469 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdBCQnB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2017 11:43:01 -0500
Received: by mail-pf0-f174.google.com with SMTP id y143so7081602pfb.0
        for <linux-block@vger.kernel.org>; Fri, 03 Feb 2017 08:43:00 -0800 (PST)
Date: Fri, 3 Feb 2017 08:42:29 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, paolo.valente@linaro.org
Subject: Re: [PATCH 1/2] blk-merge: return the merged request
Message-ID: <20170203164229.GA26515@vader>
References: <1486051573-13445-1-git-send-email-axboe@fb.com>
 <1486051573-13445-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486051573-13445-2-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 02, 2017 at 09:06:12AM -0700, Jens Axboe wrote:
> When we attempt to merge request-to-request, we return a 0/1 if we
> ended up merging or not. Change that to return the pointer to the
> request that we freed. We will use this to move the freeing of
> that request out of the merge logic, so that callers can drop
> locks before freeing the request.
> 
> There should be no functional changes in this patch.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-merge.c | 31 ++++++++++++++++---------------
>  block/blk.h       |  4 ++--
>  2 files changed, 18 insertions(+), 17 deletions(-)
