Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBFFC433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 20:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C4064FBB
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 20:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhBESRJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhBESQw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Feb 2021 13:16:52 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FA8C0613D6
        for <linux-block@vger.kernel.org>; Fri,  5 Feb 2021 11:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=VT69IMYI6mAaXWDFon2gjK7u76Ws00zlx+76ATnHUW8=; b=Gf1Ti/diL8V+j1Ov6fdmpMrnLW
        deDbd9BbuKqt+qnDur5ahuUSIV2JEe9nZ0V3nMpDXWGPno9VyoSjHTHar3VLRXd5knCUGARNnHT6a
        dZG/4MzrpDCNz5n5Zot2R2RzfE2deCKD8BXRcQfxl00lz7i3g9P/AyfvqpCcbmQkdErHkkmLetJQC
        aVSWwrnYxhs+Hw5gLSuWg1ueE3xR+rinoEqi7bVPh30X6XyeYsNXtjb65mNHyV1+dQi/CuW7meghm
        1Q0fy4+cpzo8T2ccTWMRsCoNk47Eml8VPr7P0f7hKCtoFTKep1ecb1zbdnALft+4ooG6GUOUPnaeu
        YNvQLNQQ==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l87FA-0004kG-6G; Fri, 05 Feb 2021 19:58:16 +0000
Subject: Re: [PATCH V2 2/5] blktrace: add blk_fill_rwbs documentation comment
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, aravind.ramesh@wdc.com,
        joshi.k@samsung.com, niklas.cassel@wdc.com, hare@suse.de,
        colyli@suse.de, tj@kernel.org, jack@suse.cz, hch@lst.de
References: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
 <20210205035044.5645-3-chaitanya.kulkarni@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3f752068-5c38-3056-bff9-282d1a4a535c@infradead.org>
Date:   Fri, 5 Feb 2021 11:58:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210205035044.5645-3-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/21 7:50 PM, Chaitanya Kulkarni wrote:
> blk_fill_rwbs() is an expoted function, add kernel style documentation
> comment.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blktrace_api.h |  2 +-
>  kernel/trace/blktrace.c      | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
> index 11484f1d19a1..e17d04abf6a3 100644
> --- a/include/linux/blktrace_api.h
> +++ b/include/linux/blktrace_api.h
> @@ -119,7 +119,7 @@ struct compat_blk_user_trace_setup {
>  
>  #endif
>  
> -extern void blk_fill_rwbs(char *rwbs, unsigned int op);
> +void blk_fill_rwbs(char *rwbs, unsigned int op);
>  
>  static inline sector_t blk_rq_trace_sector(struct request *rq)
>  {
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8a2591c7aa41..d7ebef83771c 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1867,6 +1867,16 @@ void blk_trace_remove_sysfs(struct device *dev)
>  
>  #ifdef CONFIG_EVENT_TRACING
>  
> +/**
> + * blk_fill_rwbs - Fill the buffer rwbs by mapping op to character string.

Hi,
                for any next time:                    @op

> + * @rwbs	buffer to be filled
> + * @op:		REQ_OP_XXX for the tracepoint
> + *
> + * Description:
> + *     Maps the REQ_OP_XXX to character and fills the buffer provided by the
> + *     caller with resulting string.
> + *
> + **/
>  void blk_fill_rwbs(char *rwbs, unsigned int op)
>  {
>  	int i = 0;
> 

thanks.
-- 
~Randy

