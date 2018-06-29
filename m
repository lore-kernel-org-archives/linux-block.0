Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:45631 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932761AbeF2UXy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jun 2018 16:23:54 -0400
Date: Fri, 29 Jun 2018 13:23:39 -0700
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] Block: initialize bio_cnt_ret_time for the first time
Message-ID: <20180629202338.vsnfx6wdy7zcjq6w@US-160370MP2.local>
Reply-To: bo.liu@linux.alibaba.com
References: <1529550424-105210-1-git-send-email-bo.liu@linux.alibaba.com>
 <17ed5986-02c8-42be-f832-04594a3bc202@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17ed5986-02c8-42be-f832-04594a3bc202@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 29, 2018 at 02:00:01PM -0600, Jens Axboe wrote:
> On 6/20/18 9:07 PM, Liu Bo wrote:
> > When a new tg is created, tg->bio_cnt_ret_time is 0, so if the first
> > IO going thru this tg turns out to be a bad one, we fail to record it
> > in tg->bad_bio_cnt as
> > 
> > if (jiffies > bio_cnt_ret_time) {
> > 	tg->bad_bio_cnt /= 2;
> > }
> 
> Shouldn't we rather ensure that ->bio_cnt_ret_time is initialized to
> jiffies?
>

Indeed, it's what the patch does, i.e. initialize tg->bio_cnt_reset_time to
jiffies on the first use.

thanks,
-liubo
