Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34269 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbdCBDI0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2017 22:08:26 -0500
Received: by mail-pf0-f173.google.com with SMTP id b5so10118252pfa.1
        for <linux-block@vger.kernel.org>; Wed, 01 Mar 2017 19:08:20 -0800 (PST)
Date: Wed, 1 Mar 2017 19:07:33 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] blk-mq-debugfs: add q->mq_freeze_depth output
Message-ID: <20170302030733.GA7792@vader>
References: <7e888cad9e6c35835559281d3ab9e05ea48836d0.1488393750.git.osandov@fb.com>
 <d4ab26006c6b454db94d548df10da3ce8908c8a1.1488393750.git.osandov@fb.com>
 <6fb18656-799e-6221-6b82-44f14cd59418@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6fb18656-799e-6221-6b82-44f14cd59418@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 01, 2017 at 07:25:59PM -0700, Jens Axboe wrote:
> On 03/01/2017 11:42 AM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This can be used to diagnose freeze-related hangs.
> 
> Do we really need this? For the loop case, it was painfully
> obvious that it was a count issue. And I can't think of any
> cases where it would have helped us, outside of rewriting
> core parts (like the first edition of the shadow requests
> for the scheduler).
> 
> Not strongly opposed to it, feel free to convince me.

I don't feel a burning need for it, let's just drop it.
