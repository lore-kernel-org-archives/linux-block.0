Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C01C77B61
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 22:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjC3WrA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjC3Wqq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 18:46:46 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1D0184A2
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680216374; x=1711752374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=et2M9lsJgWvDH6XAMMV1adP5bHqcThbd3mlghwBoKHw=;
  b=V9CsyENBg7xWEYCSduAZPkgj/CQR3zzJdvUSYSjR7HnBt/Pvggz099nb
   JC045pSCTS/WQBUUlFNfB/XBpAwcYyAgjQUd+R0P8aJzXXgmO+MR6hXpk
   OhbDhBhWfdcW/Hp0pt2GH/Y+oR6dvRjLlA3KetG0MH31Ct0kpxBd9OYgN
   n1b/MxbZS9eniXtEvlKTrG359XIKHcFubbLYqqxw4cPTfv2Mw7STVu7Wb
   PN6v2iG/lc2+rhEAvnhzO0rzGrENw1hxzNxtdeH24XSTOQ4AvpqG2tBOe
   1PjiDEA8NhH9ghRU8LH6XBTFlU+vszCbuD/QhemYzSSDDHtyW2ysVa545
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,306,1673884800"; 
   d="scan'208";a="226925207"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 06:45:37 +0800
IronPort-SDR: luCncyYwQB69qwXstAcLWXfySfMAcJ06pS4DdFJTOS49dmC7VcikPltxJDCl87+h26imc2Pg7J
 4kBF37vbnB4J2CFN0fQvqVbhLI8eNU+kKZsgGaHyLfe3VeVrCIcS+1bz/rwcKLULiLHZG82Ux/
 XJfNHNSwY7lVeuZVVQd9kdK29w8Ld6/F5+9//DohAEpAweFSxZd4wLHBcLyHjllsnEkWFkxOFq
 VNYVThtV/7+0dzNjAu68R706xeTer5n5qPdN7x7LdtOFbuZHBN3ASzD5JMBm5rIozLNdJeCaFo
 o44=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 14:56:04 -0700
IronPort-SDR: wh2hvrIQkeRST2jWpQfXEKD39XJFIETPBY6Pe/L+xLboGXSFzU/DfvtjsJcE9yRaa3yJ5SOHzX
 Ds1tM+qW8A15KHixasv3845CBn0RzynzNtl6M9eZzKDugYd8EXLfeGn088PSPKSGj/jGkBOPR/
 K64j688RpkHdDVHfKepzG3TKAcWokr9lPuEUQh0Mn5HxHgI1Ez3ZrFHjz189zQnfsjm7+wskJS
 Dn/++/a7wG/ZuE/+kZ4TMLOIpDbQvAjs5rloniAOK8MGgeVwRwud0kRppmfOX3J/2EXJ8ZIlM7
 yP8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 15:45:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pndmd1SyPz1RtVv
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:45:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680216336; x=1682808337; bh=et2M9lsJgWvDH6XAMMV1adP5bHqcThbd3ml
        ghwBoKHw=; b=ouodt5ZOTowWojbVUMt6/IIs19ey1XlXvWTULQWvuJowfAhtDsA
        YIy4A8V+gbwfZIgwF1c4NmwMpjIxe8QQRBA9Qptxcuip25NhFHKRxd83/17DJJuv
        ADtEJspVAqFmtpkvzX1p9P0/HgJ57b38uxCBqCCPsTMggIzxwswyEJbfRfbT71VX
        ZEXaPKUUlv9TVhju3zX+sHCQIW4C7/llr6c7GRAN2z/Eokj9SkDPwQlNeL70V+LP
        EzkfTq2pfvGM5mXIE4H5ghGQtTULe4D7qxhnyKKkKxL8u3RQW8Z8kHzZipeoQLjS
        7uElm7MRbmIVRSTFg22IWRwRuovH4VCgmzw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UrSKHhzZ8_GT for <linux-block@vger.kernel.org>;
        Thu, 30 Mar 2023 15:45:36 -0700 (PDT)
Received: from [10.225.163.124] (unknown [10.225.163.124])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PndmZ1xVGz1RtVm;
        Thu, 30 Mar 2023 15:45:33 -0700 (PDT)
Message-ID: <002d5d2a-f12f-a64d-6719-250823dc5a76@opensource.wdc.com>
Date:   Fri, 31 Mar 2023 07:45:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 5/9] null_blk: check for valid block size value
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, ming.lei@redhat.com,
        bvanassche@acm.org, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com
References: <20230330213134.131298-1-kch@nvidia.com>
 <20230330213134.131298-6-kch@nvidia.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230330213134.131298-6-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/23 06:31, Chaitanya Kulkarni wrote:
> Right now we don't check for valid module parameter value for
> block size, that allows user to set negative values.
> 
> Add a callback to error out when block size value is set < 1 before
> module is loaded.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/null_blk/main.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index f55d88ebd7e6..d8d79c66a7aa 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -190,8 +190,23 @@ static int g_gb = 250;
>  device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
>  MODULE_PARM_DESC(gb, "Size in GB");
>  
> +static int null_set_bs(const char *s, const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	ret = null_param_store_int(s, kp->arg, 512, INT_MAX);
> +	if (ret)
> +		pr_err("valid range for bs value [512 ... %d]\n", INT_MAX);

This is is only checking the range. block sizes must be power-of-2 as well but
that is not checked. And for the range, block size up to INT_MAX ? That is not
very reasonable.

> +	return ret;
> +}
> +
> +static const struct kernel_param_ops null_bs_param_ops = {
> +	.set	= null_set_bs,
> +	.get	= param_get_int,
> +};
> +
>  static int g_bs = 512;
> -module_param_named(bs, g_bs, int, 0444);
> +device_param_cb(bs, &null_bs_param_ops, &g_bs, 0444);
>  MODULE_PARM_DESC(bs, "Block size (in bytes)");
>  
>  static int g_max_sectors;

-- 
Damien Le Moal
Western Digital Research

