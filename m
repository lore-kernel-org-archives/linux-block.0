Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34498 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdB0SkH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 13:40:07 -0500
Received: by mail-pg0-f43.google.com with SMTP id p5so23747849pga.1
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2017 10:38:39 -0800 (PST)
Date: Mon, 27 Feb 2017 10:30:21 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/3] blk-mq: make blk_mq_alloc_request_hctx() allocate a
 scheduler request
Message-ID: <20170227183021.GG10715@vader>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
 <6137d2c6-816e-83b2-103c-cdf0840f49fd@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6137d2c6-816e-83b2-103c-cdf0840f49fd@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Feb 27, 2017 at 11:07:27AM -0700, Jens Axboe wrote:
> On 02/27/2017 10:47 AM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > blk_mq_alloc_request_hctx() allocates a driver request directly, unlike
> > its blk_mq_alloc_request() counterpart. It also crashes because it
> > doesn't update the tags->rqs map.
> > 
> > Fix it by making it allocate a scheduler request.
> 
> All three look good to me. Would you mind respinning #1, it doesn't
> apply on top of the reserved tag patch.

Yup, I had those based on Sagi's original patches for some reason. I
fat-fingered send-email, sent as a reply to the original patch 1 instead
of this email.
