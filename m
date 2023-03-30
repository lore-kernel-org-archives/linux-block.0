Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3CDC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 09:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjC3JXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 05:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjC3JW6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 05:22:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D84768A
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 02:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680168167; x=1711704167;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nloRtl5KeBrf+vMxSxbqgv2fksrI3POPo5oBfqo4Kh4=;
  b=evh7TEGLOfm8wLm4vNT/ys6ywGpYVmLA1dziO+8hQSpAZ8PC4IR8r3oz
   wirEfUy2PtYnOxoFppWfvEVZ1Q/Ppf6zJm9NtMpfs8ZivAghqfswbxSxb
   /LgWgXNS9u1KZ8HBLmwpuCU8G49lU+KsyInclyVxEbHIW4PSNfPZvYSX9
   IE134ELETJZnzA/s9UnbSnKg+hBIy3o/pusJEp92GvnlragGvx1GGI9XS
   EM6ANC72pkLK4z11gkUarMFudUJNiMqeU7oiRVCTY031WfNuDu6xHcvbY
   cRx1F17pIJEaCfP2oxVl2R92Oz5rYLWtA65kmiYti79wChdNNUyxNdt9U
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="226687725"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 17:22:46 +0800
IronPort-SDR: A9gWVC7IwNFcH5ixBgD18EgIzUwvM8gb1+1eI2V/I8QS7gLv0OdO6uIXi8PC0jhWCtWDzQfEcs
 qikc7RqYlN6AlO10PJC+7cgwJfOj6PxByisoilxUUKkRis1Drjsjgx10FmAet/eNU5zGg30NBY
 XAosMfFFjSKh0Ithb695YNZMZso0FGe8D4Mi4cvxucTxo1OI4W5AxmkGkelHN8wOYOnodeXBeP
 UbnhxwGcEVFxR9/zj+UCdd1UINrk7W2N0Bstlz4CpKTTJR1vQT5IwEZ3TTSuopYWgyh/k/lzPd
 NWc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:38:54 -0700
IronPort-SDR: cT2A5JHP8atHNT37YX6GpBxhG9TwaQ3on4HfyC9WYcKhyz/xgJaWRsltOXyFQ7n3xtQD/ra54V
 Anf06xDk3bcWXOsIFnIrAMFFmK1reCeR5LZj//ewQMnoctDpFlmhxOY+ItoAUsE3quHsZ5AbFd
 cdTfstT++y2BFlFSX+FGnaYF+NjqLncmZHcHP+r9fWKaH0KVrMRm+hX9bl9/FZYGhzHqxnQt3f
 ZFIaMkaloV4oLKoqwAWS2QoZMuEHxJ/t3u6ulf7gM9vG8m+TsJ5TxHPXcqVTwHfyEBKxTmagAu
 xmc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 02:22:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHyG5xygz1RtVw
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 02:22:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680168166; x=1682760167; bh=nloRtl5KeBrf+vMxSxbqgv2fksrI3POPo5o
        Bfqo4Kh4=; b=sdmhDhobGB/11BEJcQvHssMTH8RDF4wwI3UclyqnEbtmbn/aNwP
        h9iM7iG2zxkBYQUWK0Xubj208xP1fTJtY/mUqabwEJMpb67ns6UBwFbezaqNyRFF
        AZAJzHVLmz7KTXd2fAbe8P6eiAJb/g1mZpXq4M7hOwa2i/VcgR3GM1nJ6WvIi1Xs
        MGS/C99SsoPQ9PDrye6Y7AYbgrERbZLSp21rGWdmRZE0hSpd/nwvXYqy3JhiUAbS
        P7k20HEu7RLaTbZK2LXVpKKtqiwn5lfizb+0TuFL2+SEaOvCuVrW3iKDZ4ZYTC0t
        WTl3yjzJ0sgrmbtLhoKkmMNGJfMAYacmwcg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rJSbpTzDbPnu for <linux-block@vger.kernel.org>;
        Thu, 30 Mar 2023 02:22:46 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHyD6LRzz1RtVm;
        Thu, 30 Mar 2023 02:22:44 -0700 (PDT)
Message-ID: <3e67b995-d2fd-7518-2a55-3279bc10d950@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 18:22:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/9] null_blk: check for valid submit_queue value
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, ming.lei@redhat.com,
        bvanassche@acm.org, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com
References: <20230330055203.43064-1-kch@nvidia.com>
 <20230330055203.43064-3-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230330055203.43064-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 14:51, Chaitanya Kulkarni wrote:
> Right now we don't check for valid module parameter value for
> submit_queue, that allows user to set negative values.
> 
> Add a callback null_set_submit_queues() to error out when submit_queue
> value is < 1 before module is loaded.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/null_blk/main.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index cf6937f4cfa1..9e3df92d0b98 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -100,8 +100,18 @@ static int g_no_sched;
>  module_param_named(no_sched, g_no_sched, int, 0444);
>  MODULE_PARM_DESC(no_sched, "No io scheduler");
>  
> +static int null_set_submit_queues(const char *s, const struct kernel_param *kp)
> +{
> +	return null_param_store_int(s, kp->arg, 1, INT_MAX);
> +}
> +
> +static const struct kernel_param_ops null_submit_queues_param_ops = {
> +	.set	= null_set_submit_queues,
> +	.get	= param_get_int,
> +};
> +
>  static int g_submit_queues = 1;
> -module_param_named(submit_queues, g_submit_queues, int, 0444);
> +device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues, 0444);
>  MODULE_PARM_DESC(submit_queues, "Number of submission queues");
>  
>  static int g_poll_queues = 1;

I would do this:

+#define NULL_PARAM(_name, _min, _max)                                  \
+static int null_param_##_name##_set(const char *s,                     \
+                                   const struct kernel_param *kp)      \
+{                                                                      \
+       return null_param_store_int(s, kp->arg, _min, _max);            \
+}                                                                      \
+                                                                       \
+static const struct kernel_param_ops null_##_name##_param_ops = {      \
+       .set    = null_param_##_name##_set,                             \
+       .get    = param_get_int,                                        \
+}
+

And then have:

+NULL_PARAM(submit_queues, 1, INT_MAX);
+NULL_PARAM(poll_queues, 1, num_online_cpus());
+NULL_PARAM(queue_mode, NULL_Q_BIO, NULL_Q_MQ);
+NULL_PARAM(gb, 1, INT_MAX);
+NULL_PARAM(bs, 512, 4096);
+NULL_PARAM(max_sectors, 1, INT_MAX);
+NULL_PARAM(irqmode, NULL_IRQ_NONE, NULL_IRQ_TIMER);
+NULL_PARAM(hw_qdepth, 1, INT_MAX);

That can be done in a single patch and is overall a lot less code.

-- 
Damien Le Moal
Western Digital Research

