Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f44.google.com ([209.85.160.44]:40375 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbdL1CjC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Dec 2017 21:39:02 -0500
Received: by mail-pl0-f44.google.com with SMTP id 62so18956285pld.7
        for <linux-block@vger.kernel.org>; Wed, 27 Dec 2017 18:39:02 -0800 (PST)
Subject: Re: [for-416 PATCH 2/3] bcache: writeback: properly order backing
 device IO
To: tang.junhui@zte.com.cn
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1514424646-3221-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <f0aff580-97a1-00d8-9a94-be8e38fce690@lyle.org>
Date: Wed, 27 Dec 2017 18:38:59 -0800
MIME-Version: 1.0
In-Reply-To: <1514424646-3221-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tang Junhui--

On 12/27/2017 05:30 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> LGTM, and I tested it, it promotes the write-back performance.
> [Sorry for the wrong content in the previous email]
> 
> Reviewed-by: Tang Junhui <tang.junhui@zte.com.cn>
> Tested-by: Tang Junhui <tang.junhui@zte.com.cn>

Thank you very much for the review.  Does this also apply to 1/3 (which
is needed for this patch to apply)?

Mike
