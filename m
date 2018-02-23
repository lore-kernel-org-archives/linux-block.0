Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:47012 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeBWDzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 22:55:46 -0500
Subject: Re: [PATCH] blk-throttle: avoid multiple counting for same bio
To: Chengguang Xu <cgxu519@icloud.com>, Tejun Heo <tj@kernel.org>
Cc: axboe@fb.com, Shaohua Li <shli@kernel.org>, vgoyal@redhat.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        xuejiufei <jiufei.xue@linux.alibaba.com>
References: <1518504350-139546-1-git-send-email-cgxu519@icloud.com>
 <20180213144314.GP695913@devbig577.frc2.facebook.com>
 <E42EF2AF-710E-4783-BFFE-D77502B4E04C@icloud.com>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <ddbcd815-a347-a465-f3e8-2537307110cf@gmail.com>
Date: Fri, 23 Feb 2018 11:55:28 +0800
MIME-Version: 1.0
In-Reply-To: <E42EF2AF-710E-4783-BFFE-D77502B4E04C@icloud.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 18/2/23 11:33, Chengguang Xu wrote:
> Hi Tejun,
> 
> Sorry for delayed reply, I was on vacation last week.
> 
> The problem still exists in current code of 4.16.0-rc2, 
> detail test information is below, if further info is needed please let me know.
> 
> Thanks.
> 
That's true, the issue Shaohua has fixed is double charge, but double
stat issue still exists.

Jiufei has posted a fix, which has already been tested by Bo Liu:
[PATCH RESEND] blk-throttle: avoid double counted
https://www.mail-archive.com/linux-block@vger.kernel.org/msg18516.html

Thanks,
Joseph
