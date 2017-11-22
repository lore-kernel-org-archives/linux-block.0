Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mxhk.zte.com.cn ([63.217.80.70]:51592 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751167AbdKVFsn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Nov 2017 00:48:43 -0500
From: tang.junhui@zte.com.cn
To: colyli@suse.de, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Re: Re: Re: [PATCH] bcache: stop writeback thread after detaching
Date: Wed, 22 Nov 2017 13:48:27 +0800
Message-Id: <1511329707-22492-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

Hello Coly, Mike

> > If the change can be inside bch_register_lock, it would (just) be more
> > comfortable. The code is correct, because attach/detach sysfs is created
> > after writeback_thread created and writeback_rate_update worker
> > initialized, even these resources are initialized within
> > bch_register_lock and released out of bch)register_lock in your patch,
> > there won't be any race. It's OK to me.
>
> I think I agree with Coly that I'd prefer it to be moved down into the
> register lock, as I think that will be safer with any future changes.
> Are you willing to adjust it this way?


OK, I'll fix it and resend a v2 patch later.    

Thanks,
Tang
