Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAFEC61DA3
	for <linux-block@archiver.kernel.org>; Tue, 21 Feb 2023 09:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjBUJOf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Feb 2023 04:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjBUJOd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 04:14:33 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5409F14498
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 01:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676970858; x=1708506858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k9SZeacDb9eLNQtlyjp/+pCtwgcI4xgvzkphSJgUW10=;
  b=Hk7aX0++6NRqdqfv0G4Bjfw6HP81ru2+qvNWRnmp0v76luct00vwJoCL
   2ROXOXyR6UfX9JoNu532oIppuyjEoM0+5WKYoTz8mViRYdlcdNtPI2N2A
   rlvRq3NSYFx2XHRVSCUZ2diFn+UqCPyPEomCOHwRl+mHGsDqv77vnT4e6
   YrEg/3GnEwYcMXqRHjejQqY08tkZY+r1na26uOl3HYeXDrRqzqHU7yaVN
   rcxPNGfWgpQaKFl0rWAyc1oBEk0T4meqgiULSQeYJ7JgzgC80lm/jhOS6
   /NuoKXg94Ap/QhiXi+vSTsQoGQ4nZuq6na5rRaSS/EMys1fWIwWaTXm2n
   A==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="223586682"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2023 17:14:17 +0800
IronPort-SDR: utv13ji6P0UXzmsEEZKUtULwvaoDSBcnRb8FQ9FjtyIloMi5gGq1/Au71IaK596P6oIHYE5qCJ
 Ekc2ACmPVAAIMN9PlEL4DezG+bpgGOIa7ueiSaEqusMNZIxU+MHEfOQVoPFf2NMHrj7qvELhkP
 HGJ10KMDXKFvBz7MySQxaJ9CL0TdV0xUN7RONJRtSybKVf+W8JkESBcLs66FoPafO1PauJeKVo
 6w6x7ZKIovxqLw/0cLaY8XU+tSi3UpJgtCyW0VVA5RXFkpel6TJwSAxXY/k6XYI1Bv6fQ86WFE
 gnY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 00:31:17 -0800
IronPort-SDR: M6uF6hUwMhsnFfEAsiGLzzlKQOdVA4bu7AifSbx+b4S+pMDSYfP0Wel4KH7zkJkQrY1EB85dbu
 zCE04Fnu5i6KBNQEYf9c7LZb5mE4oZe9PAUbhpENu/RUO3OXDT9Z4IdwJyTdr1BipdHHYCuhNL
 pl3JguLfdwaafS0cKjcifaZ3ZfB1Qw2JzN0kqtXiHcjhSJYpadrQR8dAwkZVNetyVoaU2jbNP/
 g0KYRUwtav9V+n/D7CkfBu8sUym0WqNhTA3i9ZUHGdUVxQIHgHBq6gT+B3s499k5Wx+r5FHtNt
 nJQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 01:14:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PLYWX6ldPz1RvTp
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 01:14:16 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676970856; x=1679562857; bh=k9SZeacDb9eLNQtlyjp/+pCtwgcI4xgvzkp
        hSJgUW10=; b=JhbgQ9zXWY9tYKN8PkATIpy0RHGxkF+ar2L2TUqe9mTezP8EJ8C
        +KagVt5hpC1LzaUt9bNY5PsV+JpZ1XjJ7Rcqiv7RT+1gQTbkWRECEqL0hJTVGYUD
        7UJxTked0An24GFaKUI9wyhurblEnw0WP+UkYvo8IKFc+nRBBdZkJOiNqVkUW6r3
        AWf9ydGe2seLyIgDVvRqvx50Wiet0eKv0iRPj3/1kaXyQjfWQ1MrPDS3ielIyuLz
        Qv05xlc8lRly0isLB5zf7OsBQsnBbCl9ADQodAigf30BTdmG6/xHerRrMJ2RyCcv
        n2O5GWpNE4gDhP38r0R/z+uUn9VQ6c3WMtg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q_d_5foaXshI for <linux-block@vger.kernel.org>;
        Tue, 21 Feb 2023 01:14:16 -0800 (PST)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PLYWW1N5Tz1RvLy;
        Tue, 21 Feb 2023 01:14:15 -0800 (PST)
Message-ID: <78830e38-e7a4-24e5-277e-f8e5022c59ef@opensource.wdc.com>
Date:   Tue, 21 Feb 2023 18:14:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] block, bfq: free 'sync_bfqq' after bic_set_bfqq() in
 bfq_sync_bfqq_move()
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, axboe@kernel.dk,
        paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <e2071a24-cd25-e5bd-9166-a3b575b7bf4a@huaweicloud.com>
 <20230221082905.3389012-1-yukuai1@huaweicloud.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230221082905.3389012-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/23 17:29, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> As explained in commit b600de2d7d3a ("block, bfq: fix uaf for bfqq in
> bic_set_bfqq()"), bfqq should not be freed before bic_set_bfqq().
> However, this is broken while merging commit 9778369a2d6c ("block, bfq:
> split sync bfq_queues on a per-actuator basis") from branch
> for-6.3/block.

The patch looks OK to me, but the commit message is not super clear. What is
broken exactly ?

> 
> Fixes: 9778369a2d6c ("block, bfq: split sync bfq_queues on a per-actuator basis")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index ea3638e06e04..89ffb3aa992c 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -746,8 +746,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
>  		 * old cgroup.
>  		 */
>  		bfq_put_cooperator(sync_bfqq);
> -		bfq_release_process_ref(bfqd, sync_bfqq);
>  		bic_set_bfqq(bic, NULL, true, act_idx);
> +		bfq_release_process_ref(bfqd, sync_bfqq);
>  	}
>  }
>  

-- 
Damien Le Moal
Western Digital Research

