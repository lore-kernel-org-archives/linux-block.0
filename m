Return-Path: <linux-block-owner@vger.kernel.org>
Received: from www262.sakura.ne.jp ([202.181.97.72]:59800 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752991AbeDZVKh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Apr 2018 17:10:37 -0400
To: tj@kernel.org, farosas@linux.ibm.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz
Subject: Re: write call hangs in kernel space after virtio hot-remove
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <f0787b79-1e50-5f55-a400-44f715451777@linux.ibm.com>
        <20180426185052.GM1911913@devbig577.frc2.facebook.com>
In-Reply-To: <20180426185052.GM1911913@devbig577.frc2.facebook.com>
Message-Id: <201804270610.FFH64587.OLVtHJFFFQOSOM@I-love.SAKURA.ne.jp>
Date: Fri, 27 Apr 2018 06:10:20 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Tejun Heo wrote:
> (cc'ing Tetuso and quoting whole message)
> 
> Tetuso, could this be the same problem as the hang in wb_shutdown()
> syszbot reported?

Excuse me, but I'm too unfamiliar to judge it. ;-)

Anyway, since Fabiano has a reproducer, I appreciate trying a patch at
https://groups.google.com/forum/#!msg/syzkaller-bugs/qeR_1VM0UvU/1zcLE0Y4BAAJ .

Also, Fabiano's attempt might be somewhat related to a NULL pointer race condition
at https://groups.google.com/forum/#!msg/syzkaller-bugs/bVx4WExoTDw/G68X4kPcAQAJ .
