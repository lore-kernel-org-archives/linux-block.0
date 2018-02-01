Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:44734 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeBAVzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Feb 2018 16:55:43 -0500
Received: by mail-pg0-f46.google.com with SMTP id m20so13054428pgc.11
        for <linux-block@vger.kernel.org>; Thu, 01 Feb 2018 13:55:43 -0800 (PST)
Subject: Re: [PATCH] [PATCH v2] bcache: fix for allocator and register thread
 race
To: tang.junhui@zte.com.cn, colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1516883456-4170-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <adcfc52c-95ab-d3da-5526-47b3c9b70f70@lyle.org>
Date: Thu, 1 Feb 2018 13:55:41 -0800
MIME-Version: 1.0
In-Reply-To: <1516883456-4170-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tang Junhui--

On 01/25/2018 04:30 AM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
[snip]
> The stack shows the register thread and allocator thread
> were getting stuck when registering cache device.

This looks good-- applying to my 4.16-related test branch.

Reviewed-by: Michael Lyle <mlyle@lyle.org>
