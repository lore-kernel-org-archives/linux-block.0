Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BB8C31E5B
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A622B2166E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfFSRu1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:50:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42043 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbfFSRuZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 13:50:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so22674pff.9
        for <linux-block@vger.kernel.org>; Wed, 19 Jun 2019 10:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eISi0jCbBu9r7V04HeTX+S6hyx8dWzB9Ncp535yqu2c=;
        b=kMNzyw7HuQLy5q5bm08fHLOCOpxMUVSOegZGhTHdMv9XWQYonMrP4Mfp/kkKPPczES
         JwMDspZtQDLG+9MJmq+DJzea7wKrUlBmraOh4feRm0Qie2OtrEMYE81IRsrfx78eAr51
         R4JLi+zlLCMmWIRtZ0AQBauZLTBUY5KVAcr91Uq+NFIWSEVc3nZ/10zKSDsascK4eCk4
         TQMpxWHgB97yJJnjVWSNa865UyDVt65TLBPy5KBvKM1IGZ7TdtdSLOA4z6hz/sF33TFN
         Z5d5nyAl8Y3pQ5vX0EOhEtrDWGnhoQFmkFsZXYvMtcV2DLA+rPy6X9XSG/MkTmkdA3JI
         d+kQ==
X-Gm-Message-State: APjAAAUBYNfhEvVC18SqSiF/SjVx1ByECjdWDJWGMhh6iy5p2qPABAUS
        lImeZ7sDZ640YVgBzMY+U70=
X-Google-Smtp-Source: APXvYqyz0f7ARw/JlQWS8ViNYw3aF2m1q63FRIs+LYJLGpVke+m/6yEW2y5W+OAN1J+YTjtwuvgFwQ==
X-Received: by 2002:a62:5e42:: with SMTP id s63mr122785865pfb.78.1560966624596;
        Wed, 19 Jun 2019 10:50:24 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z186sm19019146pfz.7.2019.06.19.10.50.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 10:50:23 -0700 (PDT)
Subject: Re: [PATCH V4 3/5] block: use blk_op_str() in blk-mq-debugfs.c
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
 <20190619171302.10146-4-chaitanya.kulkarni@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2cb6834c-1f22-c5ac-2875-e5533419eac5@acm.org>
Date:   Wed, 19 Jun 2019 10:50:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619171302.10146-4-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/19 10:13 AM, Chaitanya Kulkarni wrote:
> Now that we've a helper function blk_op_str() to convert the
> REQ_OP_XXX to string XXX, adjust the code to use that. Get rid of
> the duplicate array op_name which is now present in the blk-core.c
> which we renamed it to "blk_op_name" and open coding in the
> blk-mq-debugfs.c.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   block/blk-mq-debugfs.c | 24 ++++--------------------
>   1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index f0550be60824..68b602d4d1b8 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -261,23 +261,6 @@ static int hctx_flags_show(void *data, struct seq_file *m)
>   	return 0;
>   }
>   
> -#define REQ_OP_NAME(name) [REQ_OP_##name] = #name
> -static const char *const op_name[] = {
> -	REQ_OP_NAME(READ),
> -	REQ_OP_NAME(WRITE),
> -	REQ_OP_NAME(FLUSH),
> -	REQ_OP_NAME(DISCARD),
> -	REQ_OP_NAME(SECURE_ERASE),
> -	REQ_OP_NAME(ZONE_RESET),
> -	REQ_OP_NAME(WRITE_SAME),
> -	REQ_OP_NAME(WRITE_ZEROES),
> -	REQ_OP_NAME(SCSI_IN),
> -	REQ_OP_NAME(SCSI_OUT),
> -	REQ_OP_NAME(DRV_IN),
> -	REQ_OP_NAME(DRV_OUT),
> -};
> -#undef REQ_OP_NAME
> -
>   #define CMD_FLAG_NAME(name) [__REQ_##name] = #name
>   static const char *const cmd_flag_name[] = {
>   	CMD_FLAG_NAME(FAILFAST_DEV),
> @@ -342,12 +325,13 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
>   {
>   	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
>   	const unsigned int op = rq->cmd_flags & REQ_OP_MASK;
> +	const char *op_str = blk_op_str(op);
>   
>   	seq_printf(m, "%p {.op=", rq);
> -	if (op < ARRAY_SIZE(op_name) && op_name[op])
> -		seq_printf(m, "%s", op_name[op]);
> -	else
> +	if (strcmp(op_str, "UNKNOWN") == 0)
>   		seq_printf(m, "%d", op);
> +	else
> +		seq_printf(m, "%s", op_str);
>   	seq_puts(m, ", .cmd_flags=");
>   	blk_flags_show(m, rq->cmd_flags & ~REQ_OP_MASK, cmd_flag_name,
>   		       ARRAY_SIZE(cmd_flag_name));

Although I'm still not enthusiast about the strcmp(..., "UNKNOWN"):

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

