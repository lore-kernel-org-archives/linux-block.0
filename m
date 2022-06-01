Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CABFCCA473
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 15:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349836AbiFAPLf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 11:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344567AbiFAPLe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 11:11:34 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9458E79820
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654096292; x=1685632292;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V6OQBNc5mW+h4OLDFXj1emXdkRPJ/Z7nxdf1EG7KU9M=;
  b=GFhU+5Evp/oF3YlIBWWK31+btvh6l0dWzr1He9W/0pVMIG0jBbcYSJbB
   ck70XEfXgHXHlGKwnDuRgqc2tq109e8cHqtjVMkQGeNd35qH5WxoRtxdy
   g4K/xx7RR4SoyxREqlBT3zHa5il94yVSaCO5ORZyr8/ABxsGJ+OfGrtCH
   /FuqVNrA0dMR+k4t7KMsZciiTabzAhRs+l+qqqaBJfuoCaS2+SydDbXtj
   FT3NCX8cSq+sZUK0/gCZO4SkoWjdKudV1aFqTH7NomMRJGg0ooswHxJkg
   npAejWN3thy5oq79G9pSOufdjhGzWq4KVZIiR+o7wpg/KVm5RR22tuTDy
   g==;
X-IronPort-AV: E=Sophos;i="5.91,268,1647273600"; 
   d="scan'208";a="200754693"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2022 23:11:31 +0800
IronPort-SDR: Lfm4x45P8p7ojz5dFl3YcNmLxEcWEN77jTWCPp2heCPgCdyIY32nItXTt8JqwgzxqpFXPBxZP3
 R8t+uMATYEJIQiYNyXj2y3H0yzhWsaWTjr1Ii0o2ZcbaKMTuMK4cNv1h6Cqzxk5W2WfGgCDP7z
 kyEmbCicDJtrBH29f1+96T5ebKkS1yKECow+LP8x0oI17nKEwiacZzM+AZPAw1PmgLHxjdwljm
 DBvave3eKGD1GsazM/nle7WaM+upSB1QaPk7Ag8Yu1ZSmIbh/lT/DLnzXQsCBaBxAQ+jO5Kut5
 abNvrpCg130Hz/W9UE+ZbkJW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 07:35:12 -0700
IronPort-SDR: R9dkLX7mqypUySsP2xn5dujG3TfsE2ttITaDOT49rYeGTDYl1FkghuZ901uxAB9JGAqs+ksphH
 4XJqYQ3pOM0t1ufGzfduyYXI1mIsKjtl/g0BVvBQZ0/vmE70ggpbKPGAB9vjT2LEWl5Jme4fJv
 6A2wZQB3VfcixQuN/BRzvoF67WbHJt0pjxItIi0kRkpHY86JoasfKDc2Q7Xwt62X0GiuYvqEO9
 HdUQjaWcUMV74WQcebmjba5YUhs10JFnJ00WNZsfYzaEjuLSOiiLlPQeFPIZa9LLTGB9KxAK1A
 xg4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 08:11:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LCt034BFdz1Rwrw
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 08:11:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654096291; x=1656688292; bh=V6OQBNc5mW+h4OLDFXj1emXdkRPJ/Z7nxdf
        1EG7KU9M=; b=nYF0cbSwHzO/cjJI0QLG8cmS25MAmIkPSSuu4JaxiHovtkRyuIM
        4UW6ZEuGff72YCz1tf8/gIU6FffI0OS61fdmhtH9ktrSE/Wllxbx4CFgRY+euGXf
        IqWkcE8xy6R6/+yPphmnIPh2l/dak/xabz2Wo/yPeg4ETZNUfaKIAQseiL3uLn5m
        CuRCUMnzDYM3GAehHBTyfXUMaV/xst7+VmumuKMrwqYy8uX2YnSOleuC3T1rqBlE
        0ZK+fKnlF1mqJ+jFJk75QhgSOckubjKRcY6zhTYotANFacU7RlGznb36bb1438eQ
        yvb+WuOZrvZSK5VvsV16JS14jkVpA8pqAWQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ldp3PyuYB1CL for <linux-block@vger.kernel.org>;
        Wed,  1 Jun 2022 08:11:31 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LCt023d7pz1Rvlc;
        Wed,  1 Jun 2022 08:11:30 -0700 (PDT)
Message-ID: <6d40bebc-2880-5290-16dc-2807e1db9e77@opensource.wdc.com>
Date:   Thu, 2 Jun 2022 00:11:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] block: Fix handling of tasks without ioprio in
 ioprio_get(2)
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20220601132347.13543-1-jack@suse.cz>
 <20220601145110.18162-1-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220601145110.18162-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/06/01 23:51, Jan Kara wrote:
> ioprio_get(2) can be asked to return the best IO priority from several
> tasks (IOPRIO_WHO_PGRP, IOPRIO_WHO_USER). Currently the call treats
> tasks without set IO priority as having priority
> IOPRIO_CLASS_BE/IOPRIO_BE_NORM however this does not really reflect the
> IO priority the task will get (which depends on task's nice value) and
> with the following fix it will not even match returned IO priority for a
> single task. So fix IO priority comparison to treat unset IO priority as
> the lowest possible one. This way we will return IOPRIO_CLASS_NONE
> priority only if none of the considered tasks has explicitely set IO
> priority, otherwise we return the highest set IO priority. This changes
> userspace visible behavior but hopefully the results are clearer and
> nothing breaks.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/ioprio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 2fe068fcaad5..62890391fc80 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -157,10 +157,9 @@ static int get_task_ioprio(struct task_struct *p)
>  int ioprio_best(unsigned short aprio, unsigned short bprio)
>  {
>  	if (!ioprio_valid(aprio))
> -		aprio = IOPRIO_DEFAULT;
> +		return bprio;

bprio may not be valid...

>  	if (!ioprio_valid(bprio))
> -		bprio = IOPRIO_DEFAULT;
> -
> +		return aprio;
>  	return min(aprio, bprio);
>  }
>  


-- 
Damien Le Moal
Western Digital Research
