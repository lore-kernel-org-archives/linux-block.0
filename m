Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:49962 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdJJFiz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Oct 2017 01:38:55 -0400
From: tang.junhui@zte.com.cn
To: mlyle@lyle.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, tang.junhui@zte.com.cn
Subject: Re: [PATCH] bcache: fix race in setting bdev state
Date: Tue, 10 Oct 2017 13:38:30 +0800
Message-Id: <1507613910-1156-1-git-send-email-tang.junhui@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

Hello Mike:

> How did you find this?  Did the race trigger at detach or was it through 
> code inspection?
I find this through code inspection.

> I need to analyze this more.  It looks correct on its own, but there are 
> a lot of atomic variables and the way they are used is complicated.
> 
> I'm inclined to think that detach should traverse the writeback lock for 
> safety.  It would be a lot less complicated to analyze what would 
> happen.  What do you think?
As Far as now, except this issue, I can't see any more race during detach,
so I don't think we need to take a writeback lock. Could you please show me 
what problem you worried about?

Regards,
Tang
