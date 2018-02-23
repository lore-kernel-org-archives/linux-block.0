Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40454 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeBWOQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Feb 2018 09:16:40 -0500
Date: Fri, 23 Feb 2018 06:16:35 -0800
From: Tejun Heo <tj@kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>, Shaohua Li <shli@kernel.org>
Cc: Joseph Qi <jiangqi903@gmail.com>, axboe@fb.com, vgoyal@redhat.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        xuejiufei <jiufei.xue@linux.alibaba.com>
Subject: Re: [PATCH] blk-throttle: avoid multiple counting for same bio
Message-ID: <20180223141635.GB1641506@devbig577.frc2.facebook.com>
References: <1518504350-139546-1-git-send-email-cgxu519@icloud.com>
 <20180213144314.GP695913@devbig577.frc2.facebook.com>
 <E42EF2AF-710E-4783-BFFE-D77502B4E04C@icloud.com>
 <ddbcd815-a347-a465-f3e8-2537307110cf@gmail.com>
 <7E596018-7D00-4537-B717-697FE401DD55@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7E596018-7D00-4537-B717-697FE401DD55@icloud.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Fri, Feb 23, 2018 at 12:29:25PM +0800, Chengguang Xu wrote:
> > That's true, the issue Shaohua has fixed is double charge, but double
> > stat issue still exists.
> > 
> > Jiufei has posted a fix, which has already been tested by Bo Liu:
> > [PATCH RESEND] blk-throttle: avoid double counted
> > https://www.mail-archive.com/linux-block@vger.kernel.org/msg18516.html

Shaohua, can you please take a look at the patch?

Thanks.

-- 
tejun
