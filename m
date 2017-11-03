Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:32852 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756143AbdKCRP1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Nov 2017 13:15:27 -0400
Date: Fri, 3 Nov 2017 10:13:38 -0600
From: Liu Bo <bo.li.liu@oracle.com>
To: linux-block@vger.kernel.org
Cc: Shaohua Li <shli@fb.com>
Subject: Re: [PATCH] badblocks: fix wrong return value in badblocks_set if
 badblocks are disabled
Message-ID: <20171103161337.GA28764@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
Reply-To: bo.li.liu@oracle.com
References: <20170927221317.31237-1-bo.li.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170927221317.31237-1-bo.li.liu@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Shaohua,

Given it's related to md, can you please take this thru your tree?

Thanks,

-liubo

On Wed, Sep 27, 2017 at 04:13:17PM -0600, Liu Bo wrote:
> MD's rdev_set_badblocks() expects that badblocks_set() returns 1 if
> badblocks are disabled, otherwise, rdev_set_badblocks() will record
> superblock changes and return success in that case and md will fail to
> report an IO error which it should.
> 
> This bug has existed since badblocks were introduced in commit
> 9e0e252a048b ("badblocks: Add core badblock management code").
> 
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> ---
>  block/badblocks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 43c7116..91f7bcf 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -178,7 +178,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  
>  	if (bb->shift < 0)
>  		/* badblocks are disabled */
> -		return 0;
> +		return 1;
>  
>  	if (bb->shift) {
>  		/* round the start down, and the end up */
> -- 
> 2.9.4
> 
