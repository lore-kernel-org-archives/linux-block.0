Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f48.google.com ([209.85.160.48]:41820 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeABREo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jan 2018 12:04:44 -0500
Received: by mail-pl0-f48.google.com with SMTP id g2so28989834pli.8
        for <linux-block@vger.kernel.org>; Tue, 02 Jan 2018 09:04:43 -0800 (PST)
Subject: Re: [for-416 PATCH] bcache: fix writeback target calc on large
 devices
To: tang.junhui@zte.com.cn
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1514885112-12218-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <e53d3218-d121-7bdb-005b-caa0732e1ea1@lyle.org>
Date: Tue, 2 Jan 2018 09:04:40 -0800
MIME-Version: 1.0
In-Reply-To: <1514885112-12218-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I'm withdrawing this patch.  Reading the entire function more carefully,
I think the rate calculation is completely wrong both in the original
code and in this change.

That is, the top of __update_writeback_rate calculates a dirty data
target for one backing device.  However, the target for one backing
device is compared to the amount of dirty data in the entire cache.  If
there is more than one cache device, the writeback rate will be far too
high.

I will attempt to write a new version of this scaling functionality soon
that fixes both the overflow issue and ... corrects it to calculate the
correct thing.

Mike
