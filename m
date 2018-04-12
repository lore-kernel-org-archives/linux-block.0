Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51463 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751837AbeDLGpg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Apr 2018 02:45:36 -0400
Subject: Re: [PATCH 0/4] bcache: incremental GC and dirty data init
To: tang.junhui@zte.com.cn, kent.overstreet@gmail.com, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1523515124-2021-1-git-send-email-tang.junhui@zte.com.cn>
From: Coly Li <colyli@suse.de>
Message-ID: <9830b04f-7f62-9867-26ab-1b424456367e@suse.de>
Date: Thu, 12 Apr 2018 14:45:25 +0800
MIME-Version: 1.0
In-Reply-To: <1523515124-2021-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/4/12 2:38 PM, tang.junhui@zte.com.cn wrote:
> Hi maintainers and folks,
> 
> Some patches of this patch set have been sent before, they are not merged
> yet, and I add two new patches to solve some issues I found while testing.
> since They are interdependent, so I make a patch set and resend them.
> 
> [PATCH 1/4] bcache: finish incremental GC
> [PATCH 2/4] bcache: calculate the number of incremental GC nodes according to
> 			the total of btree nodes
> [PATCH 3/4] bcache: notify allocator to prepare for GC
> [PATCH 4/4] bcache: fix I/O significant decline while backend devices registering
> 
> These patches are useful to prevent I/O fluctuations or even jump 0 while GC or
> cached devices registering. I have test them for some times, I hope somebody could
> have a review for these patch, any comment would be welcome.
> 

Hi Junhui,

Copied, these patches are in my to-review list :-)

Thanks.

Coly Li
