Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36487 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeABTCK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jan 2018 14:02:10 -0500
Received: by mail-pf0-f174.google.com with SMTP id p84so25997410pfd.3
        for <linux-block@vger.kernel.org>; Tue, 02 Jan 2018 11:02:10 -0800 (PST)
Subject: Re: [for-416 PATCH v2] bcache: fix writeback target calculation
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: tang.junhui@zte.com.cn
References: <1514885112-12218-1-git-send-email-tang.junhui@zte.com.cn>
 <20180102190049.29237-1-mlyle@lyle.org>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <1dfbbe4d-d445-7b54-de87-93be150b5597@lyle.org>
Date: Tue, 2 Jan 2018 11:02:07 -0800
MIME-Version: 1.0
In-Reply-To: <20180102190049.29237-1-mlyle@lyle.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Please note I have not tested this version yet: I'm just putting it out
for review.

Mike

On 01/02/2018 11:00 AM, Michael Lyle wrote:
> This fixes bcache writeback target calculation, for defects relating to
> large cache sets and calculation errors when there are multiple backing
> devices.
> 
> Bcache needs to scale the dirty data in the cache over the multiple
> backing disks in order to calculate writeback rates for each.
> The previous code did this by multiplying the target number of dirty
> sectors by the backing device size, and expected it to fit into a
> uint64_t; this blows up on relatively small backing devices.
> 
> The new approach figures out the bdev's share in 16384ths of the overall
> cached data.  This is chosen to cope well when bdevs drastically vary in
> size and to ensure that bcache can cross the petabyte boundary for each
> backing device.
> 
> Per review, we ensure that every device gets at least 1/16384th of the
> writeback share.  This also differs from v1 of the patchset in scaling
> the error, which corrects previous problems with writeback rate
> calculation across multiple devices.
> 
> Reported-by: Jack Douglas <jack@douglastechnology.co.uk>
> Signed-off-by: Michael Lyle <mlyle@lyle.org>
