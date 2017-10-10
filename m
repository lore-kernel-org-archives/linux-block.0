Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:44913 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755048AbdJJDcl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Oct 2017 23:32:41 -0400
Received: by mail-pf0-f176.google.com with SMTP id x7so5533558pfa.1
        for <linux-block@vger.kernel.org>; Mon, 09 Oct 2017 20:32:40 -0700 (PDT)
Subject: Re: [PATCH] [PATCH v3] bcache: gc does not work when triggering by
 manual
To: tang.junhui@zte.com.cn, colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1507603489-30999-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <88e9ac51-bae7-55c7-8c89-56107c8a01e9@lyle.org>
Date: Mon, 9 Oct 2017 20:32:38 -0700
MIME-Version: 1.0
In-Reply-To: <1507603489-30999-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/09/2017 07:44 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> I try to execute the following command to trigger gc thread:
> [root@localhost internal]# echo 1 > trigger_gc
> But it does not work, I debug the code in gc_should_run(), It works only
> if in invalidating or sectors_to_gc < 0. So set sectors_to_gc to -1 to
> meet the condition when we trigger gc by manual command.
> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>

Reviewed-by: Michael Lyle <mlyle@lyle.org>

Thanks!   -mpl
