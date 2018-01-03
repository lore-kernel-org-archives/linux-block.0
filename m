Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f54.google.com ([209.85.160.54]:33284 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeACSB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jan 2018 13:01:29 -0500
Received: by mail-pl0-f54.google.com with SMTP id 1so1689858plv.0
        for <linux-block@vger.kernel.org>; Wed, 03 Jan 2018 10:01:29 -0800 (PST)
Subject: Re: [for-416 PATCH v2] bcache: fix writeback target calculation
To: tang.junhui@zte.com.cn
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1514913607-22144-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <2d7f9a54-d60c-2600-8a0f-9caec2a7f8d8@lyle.org>
Date: Wed, 3 Jan 2018 10:01:26 -0800
MIME-Version: 1.0
In-Reply-To: <1514913607-22144-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/02/2018 09:20 AM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> When I saw the code "int64_t error = dirty - cache_dirty_target", I was 
> totally lost, I will try my best to get out. 

Don't waste your time, let me think about this more.  I think the
previous version was correct and now I screwed it up.  I need to really
read how the dirty block accounting happens to do this properly.

I will send a v3, and make sure that I'm fully confident in it.

> And this patch dependent on your earlier patch(PI controller), did that
> patch have applied to upstreams branch? I searched in 4.14 branch, 
> and did not find it.

It's 1d316e658374f700fdfff9299c70ce65d8d145e6 on linus/master.

Mike
