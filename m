Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46376 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935053AbcKXBAR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2016 20:00:17 -0500
Date: Wed, 23 Nov 2016 16:59:58 -0800
From: Shaohua Li <shli@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>, <axboe@fb.com>, <vgoyal@redhat.com>
Subject: Re: [PATCH V4 09/15] blk-throttle: make bandwidth change smooth
Message-ID: <20161124005957.GA4724@ksenks-mbp.dhcp.thefacebook.com>
References: <cover.1479161136.git.shli@fb.com>
 <0e70ed3ab921ff6556cfe6a6c30428d4cfaf9e52.1479161136.git.shli@fb.com>
 <20161123212335.GC11306@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161123212335.GC11306@mtj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 23, 2016 at 04:23:35PM -0500, Tejun Heo wrote:
> Hello,
> 
> On Mon, Nov 14, 2016 at 02:22:16PM -0800, Shaohua Li wrote:
> > cg1/cg2 bps: 10/80 -> 15/105 -> 20/100 -> 25/95 -> 30/90 -> 35/85 -> 40/80
> > -> 45/75 -> 10/80
> 
> I wonder whether it'd make sense to make the clamping down gradual too
> (way faster than the ramping up but still gradual).  The control model
> isn't immediate anyway and doing the other direction gradually too
> might not hurt the overall control accuracy all that much.

Sure, that's in my todo list. Part of the reason is I didn't figure out an easy
to do it. I'll keep trying later.

Thanks,
Shaohua
