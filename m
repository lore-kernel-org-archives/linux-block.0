Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14C8C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 05:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDJF6I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 01:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDJF6H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 01:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9621E3AA4
        for <linux-block@vger.kernel.org>; Sun,  9 Apr 2023 22:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B99614C0
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 05:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EA7C433D2;
        Mon, 10 Apr 2023 05:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681106285;
        bh=T4Xwu+1M4nUqOSg+R/cs1Eo68WpYM8P7XHB9pmWkj9Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tXNDjcA7xjrufQF8nOTph0rEep0j0LNDHB6AjEh5BmZ0eQ85jpdFouTiSo8n5LlJ9
         OfP80i/RsZw5BVI11+5tKdt9r/+obyw8ta83eTuE+XXg0gGx1a9NSIJ5dSFl0e1Jmx
         5P6ujM96ln5pF4zD77u+6yS7LcFXWbC2bWVeQNyF0jvVGLV0Xow7jBCZ9WUl5nxRih
         yK8JRrvQ3Jso/YUZ1XDLoELRgeDfyBUfzL7Ja95eO59QF0hGnc+stRpHw5sMpemuRL
         cjOarRlxEaZsVIv2vP6cnuO98p9MsRkU0+e1gti+u8DAvDeYnmnmqpIb/73vQzEnBW
         is1fav+ztGa9g==
Message-ID: <5ac02fed-1669-9b3c-a1f6-07b08290bbee@kernel.org>
Date:   Mon, 10 Apr 2023 14:58:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 1/1] null_blk: add moddule parameter check
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com,
        bvanassche@acm.org, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com
References: <20230410051352.36856-1-kch@nvidia.com>
 <20230410051352.36856-2-kch@nvidia.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230410051352.36856-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/23 14:13, Chaitanya Kulkarni wrote:
>  static bool g_virt_boundary = false;
>  module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
>  MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
> @@ -86,11 +113,13 @@ module_param_named(no_sched, g_no_sched, int, 0444);
>  MODULE_PARM_DESC(no_sched, "No io scheduler");
>  
>  static int g_submit_queues = 1;
> -module_param_named(submit_queues, g_submit_queues, int, 0444);
> +NULL_PARAM(submit_queues, 1, INT_MAX);

INT_MAX ? That is a little large... Why not using CONFIG_NR_CPUS ? Or
CONFIG_NR_CPUS * 2 to leave some room for experiments.

> +device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues, 0444);
>  MODULE_PARM_DESC(submit_queues, "Number of submission queues");

[...]

>  static int g_bs = 512;
> -module_param_named(bs, g_bs, int, 0444);
> +NULL_PARAM(bs, 1, PAGE_SIZE);

Allowing min=1 here does not make sense. This should be 512. And you could add a
"bool is_power_of_2" argument to null_param_store_int() to check that the value
is a power of 2.

> +device_param_cb(bs, &null_bs_param_ops, &g_bs, 0444);
>  MODULE_PARM_DESC(bs, "Block size (in bytes)");

[...]

>  static int g_hw_queue_depth = 64;
> -module_param_named(hw_queue_depth, g_hw_queue_depth, int, 0444);
> +NULL_PARAM(hw_qdepth, 1, INT_MAX);

INT_MAX here is a little silly. Way too large to make any sense in my opinion.
NVMe allows up to 65536, why not use the same value here ?

> +device_param_cb(hw_queue_depth, &null_hw_qdepth_param_ops, &g_hw_queue_depth, 0444);
>  MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 64");
>  
>  static bool g_use_per_node_hctx;

