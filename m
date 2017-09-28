Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:26381 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdI1StC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Sep 2017 14:49:02 -0400
Date: Thu, 28 Sep 2017 11:45:06 -0700
From: Liu Bo <bo.li.liu@oracle.com>
To: Guoqing Jiang <gqjiang@suse.com>
Cc: linux-block@vger.kernel.org, NeilBrown <neilb@suse.com>
Subject: Re: [PATCH] badblocks: fix wrong return value in badblocks_set if
 badblocks are disabled
Message-ID: <20170928184506.GB27771@lim.localdomain>
Reply-To: bo.li.liu@oracle.com
References: <20170927221317.31237-1-bo.li.liu@oracle.com>
 <86e97dbb-5d8d-66c7-5bc6-39e0d16f7724@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <86e97dbb-5d8d-66c7-5bc6-39e0d16f7724@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 28, 2017 at 09:57:41AM +0800, Guoqing Jiang wrote:
> 
> 
> On 09/28/2017 06:13 AM, Liu Bo wrote:
> > MD's rdev_set_badblocks() expects that badblocks_set() returns 1 if
> > badblocks are disabled, otherwise, rdev_set_badblocks() will record
> > superblock changes and return success in that case and md will fail to
> > report an IO error which it should.
> > 
> > This bug has existed since badblocks were introduced in commit
> > 9e0e252a048b ("badblocks: Add core badblock management code").
> 
> I don't think we need to change it since it originally was return 0 in
> original
> commit.

The difference is that the original md_set_badblocks() returns 0 for
both "being disabled" and "no room", while now badblocks_set() returns
1 for "no room" as a failure but 0 for "being disabled".

thanks,
-liubo

> 
> commit 2230dfe4ccc3add340dc6d437965b2de1d269fde
> Author: NeilBrown <neilb@suse.de>
> Date:   Thu Jul 28 11:31:46 2011 +1000
> 
>     md: beginnings of bad block management.
> 
>     This the first step in allowing md to track bad-blocks per-device so
>     that we can fail individual blocks rather than the whole device.
> 
>     This patch just adds a data structure for recording bad blocks, with
>     routines to add, remove, search the list.
> 
>     Signed-off-by: NeilBrown <neilb@suse.de>
>     Reviewed-by: Namhyung Kim <namhyung@gmail.com>
> +static int md_set_badblocks(struct badblocks *bb, sector_t s, int sectors,
> +                           int acknowledged)
> +{
> +       u64 *p;
> +       int lo, hi;
> +       int rv = 1;
> +
> +       if (bb->shift < 0)
> +               /* badblocks are disabled */
> +               return 0;
> 
> After a quick glance, I guess we need to fix it inside md, since below
> change
> seems not correct in fc974ee2bffdde47d1e4b220cf326952cc2c4794.
> 
> @@ -8734,114 +8485,19 @@ int rdev_set_badblocks(struct md_rdev *rdev,
> sector_t s, int sectors,
>                 s += rdev->new_data_offset;
>         else
>                 s += rdev->data_offset;
> -       rv = md_set_badblocks(&rdev->badblocks,
> -                             s, sectors, 0);
> -       if (rv) {
> +       rv = badblocks_set(&rdev->badblocks, s, sectors, 0);
> +       if (rv == 0) {
> 
> 
> So we need to correct it like:
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 0ff1bbf..245fe52 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8905,7 +8905,7 @@ int rdev_set_badblocks(struct md_rdev *rdev, sector_t
> s, int sectors,
>         else
>                 s += rdev->data_offset;
>         rv = badblocks_set(&rdev->badblocks, s, sectors, 0);
> -       if (rv == 0) {
> +       if (rv) {
> 
> Thanks,
> Guoqing
