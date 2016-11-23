Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34655 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbcKWVXh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2016 16:23:37 -0500
Date: Wed, 23 Nov 2016 16:23:35 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 09/15] blk-throttle: make bandwidth change smooth
Message-ID: <20161123212335.GC11306@mtj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <0e70ed3ab921ff6556cfe6a6c30428d4cfaf9e52.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0e70ed3ab921ff6556cfe6a6c30428d4cfaf9e52.1479161136.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Mon, Nov 14, 2016 at 02:22:16PM -0800, Shaohua Li wrote:
> cg1/cg2 bps: 10/80 -> 15/105 -> 20/100 -> 25/95 -> 30/90 -> 35/85 -> 40/80
> -> 45/75 -> 10/80

I wonder whether it'd make sense to make the clamping down gradual too
(way faster than the ramping up but still gradual).  The control model
isn't immediate anyway and doing the other direction gradually too
might not hurt the overall control accuracy all that much.

Thanks.

-- 
tejun
