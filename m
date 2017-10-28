Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:34292 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbdJ1BxH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2017 21:53:07 -0400
From: tang.junhui@zte.com.cn
To: bcache@lists.ewheeler.net, colyli@suse.de, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Re: Re: [PATCH 11/19] bcache: Subtract dirty sectors of thin flash from cache_sectors in calculating writeback rate
Date: Sat, 28 Oct 2017 09:52:49 +0800
Message-Id: <1509155569-31338-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

Hello Eric

> > I discussed with Tang offline, this patch is correct. But the patch
> > commit log should be improved. Now I help to work on it, should be done
> > quite soon.
> 
> Has an updated commit log been made?  I've not seen this in the commit 
> stream yet.

It has been commited as
bcache: correct cache_dirty_target in __update_writeback_rate()
log: a8394090a9129b40f9d90dcb7f4a49d60c727ca6

Regards,
Tang
