Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2B2C31E51
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDD520823
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfFRHTY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:19:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40890 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbfFRHTX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 03:19:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 772529F995D8B9CC4DE9;
        Tue, 18 Jun 2019 15:19:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun
 2019 15:19:17 +0800
Subject: Re: [PATCH V3 6/6] f2fs: get rid of duplicate code for in tracing
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        <linux-block@vger.kernel.org>
CC:     <jaegeuk@kernel.org>, <bvanassche@acm.org>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
 <20190618054224.25985-7-chaitanya.kulkarni@wdc.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <088167e2-8744-5176-f282-7015d02482fa@huawei.com>
Date:   Tue, 18 Jun 2019 15:19:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190618054224.25985-7-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Chaitanya,

On 2019/6/18 13:42, Chaitanya Kulkarni wrote:
> Now that we have used the blk_op_str(), get rid of show_bio_type() and
> show_bio_op() to eliminate the duplicate code.

I think we can merge 5/6 and 6/6 into one patch.

> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  include/trace/events/f2fs.h | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index ec4dba5a4c30..a8e4fe053e7c 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -73,20 +73,6 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
>  			REQ_PREFLUSH | REQ_FUA)
>  #define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)
>  
> -#define show_bio_type(op,op_flags)	show_bio_op(op),		\

Could you just replace show_bio_op() with blk_op_str()? it's minor though.

Thanks,

> -						show_bio_op_flags(op_flags)
> -
> -#define show_bio_op(op)							\
> -	__print_symbolic(op,						\
> -		{ REQ_OP_READ,			"READ" },		\
> -		{ REQ_OP_WRITE,			"WRITE" },		\
> -		{ REQ_OP_FLUSH,			"FLUSH" },		\
> -		{ REQ_OP_DISCARD,		"DISCARD" },		\
> -		{ REQ_OP_SECURE_ERASE,		"SECURE_ERASE" },	\
> -		{ REQ_OP_ZONE_RESET,		"ZONE_RESET" },		\
> -		{ REQ_OP_WRITE_SAME,		"WRITE_SAME" },		\
> -		{ REQ_OP_WRITE_ZEROES,		"WRITE_ZEROES" })
> -
>  #define show_bio_op_flags(flags)					\
>  	__print_flags(F2FS_BIO_FLAG_MASK(flags), "|",			\
>  		{ REQ_RAHEAD,		"R" },				\
> 
