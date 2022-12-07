Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C69C3A5A7
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 01:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLGBfB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGBfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 20:35:00 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D14B9A1;
        Tue,  6 Dec 2022 17:35:00 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRfqr6ML3zqSwx;
        Wed,  7 Dec 2022 09:30:48 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 09:34:58 +0800
Subject: Re: [PATCH] blktrace: Fix output non-blktrace event when blk_classic
 option enabled
To:     <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <acme@redhat.com>, <mingo@elte.hu>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221122040410.85113-1-yangjihong1@huawei.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <e5654353-9850-beb5-cf72-7a7473a14743@huawei.com>
Date:   Wed, 7 Dec 2022 09:34:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221122040410.85113-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

PING.

Thanks,
Yang.

On 2022/11/22 12:04, Yang Jihong wrote:
> When the blk_classic option is enabled, non-blktrace events must be
> filtered out. Otherwise, events of other types are output in the blktrace
> classic format, which is unexpected.
> 
> The problem can be triggered in the following ways:
> 
>    # echo 1 > /sys/kernel/debug/tracing/options/blk_classic
>    # echo 1 > /sys/kernel/debug/tracing/events/enable
>    # echo blk > /sys/kernel/debug/tracing/current_tracer
>    # cat /sys/kernel/debug/tracing/trace_pipe
> 
> Fixes: c71a89615411 ("blktrace: add ftrace plugin")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>   kernel/trace/blktrace.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index a995ea1ef849..a66cff5a1857 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1548,7 +1548,8 @@ blk_trace_event_print_binary(struct trace_iterator *iter, int flags,
>   
>   static enum print_line_t blk_tracer_print_line(struct trace_iterator *iter)
>   {
> -	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CLASSIC))
> +	if ((iter->ent->type != TRACE_BLK) ||
> +	    !(blk_tracer_flags.val & TRACE_BLK_OPT_CLASSIC))
>   		return TRACE_TYPE_UNHANDLED;
>   
>   	return print_one_line(iter, true);
> 
