Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f53.google.com ([209.85.160.53]:46903 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbdL0WWy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Dec 2017 17:22:54 -0500
Received: by mail-pl0-f53.google.com with SMTP id i6so20086786plt.13
        for <linux-block@vger.kernel.org>; Wed, 27 Dec 2017 14:22:54 -0800 (PST)
Subject: Re: [PATCH] bcache: fix wrong return value in bch_debug_init()
To: tang.junhui@zte.com.cn, colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1514201980-30595-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <4f2a250e-d185-c53e-7d98-013fda58f7f3@lyle.org>
Date: Wed, 27 Dec 2017 14:22:49 -0800
MIME-Version: 1.0
In-Reply-To: <1514201980-30595-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/25/2017 03:39 AM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> in bch_debug_init(), ret is always 0, and the return value is useless,
> change it to return 0 if be success after calling debugfs_create_dir(),
> else return a non-zero value.
> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>

LGTM, applied to my staging branch.  (Still line ending issues but
easily fixed with checkpatch.pl --fix)

Thanks,

Mike
