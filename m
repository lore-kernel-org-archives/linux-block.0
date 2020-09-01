Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F494C433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 03:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69083207D3
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 03:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2Hpp2pGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIADjD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIADjD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 23:39:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60C6C0612FE
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 20:39:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so1915745pgh.6
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 20:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CmWImjbfkai8w8IYrzWttSFE/ShThoXbvLekJzQkDNE=;
        b=2Hpp2pGPGoM76EKftl74jbI1jE6i7BkynyJ4YEmKkncEDpi7syFP4I6+fZ40aXoMWP
         4jHntOowSoOmVOmt3/HKPrWZeu0hPu4w4Xw5l/nPcBhXe8mpT+ekpd6/nvfhlPBvka35
         bVdb4MsJL2T012kuCrdQLPBK9FQWt2jc38W+VKcfMdwe4fcc1ydnRfEXtPvTTdqB0uz1
         Roak8DeVTXNH9SdCwuhtN4cW48ZXgHlA4qR1GtjrQO9Zv5qm1FSCvQvlqfL50Xsdkfpp
         aL6oEfHl4LCfAP/k+ddBM2K88gUh0fwJoqJpZLv8o8PMGJlB2cvgsmslGDup+j6jdPxL
         mlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CmWImjbfkai8w8IYrzWttSFE/ShThoXbvLekJzQkDNE=;
        b=T45/8xyC94kNJcDHCqGxRv5dEs5X4IOfv1WXdQxyehql5pxPK8ixeGytbo686tGQ+B
         Q3BeryMkit9pybCQWmPgkqAY228fcd74ODxtfdpXZsZ/dyLk1aFecQh/uwh7K8Jhm31V
         XFH7TORabYaS//8Pb3AZPger9z8+9NFGVVFI8oapbi4vviGiFuNZOsMxxiX0JrTGKJXU
         W8wrZcuc86WExGJ20xfMuQ5T4mPDIwQHv8QIwuZD0krNVMDB/0eFLrk52C/sBA99TWkk
         E2YXCF0mJ5vGh1doJ00egMepvOE9uwshR7DWBbKXqs9jsaJXCt0hIf44L5o9n6fOi7ZL
         yyww==
X-Gm-Message-State: AOAM532gUqfDTMdHFiq8kEWLHHBaPKkBO0PwmbU84OZih9S+fWbtJYnZ
        oWm+8GlsG1PDSlGF+zeUG+cn8Q==
X-Google-Smtp-Source: ABdhPJxwc59YPWeeBw2UNybtTAbxjkWeEOLQHBC6jojvyuHuUAYP7kos/LMRkBGs5mEgIM5IdCOWkw==
X-Received: by 2002:aa7:8657:: with SMTP id a23mr3953845pfo.169.1598931542218;
        Mon, 31 Aug 2020 20:39:02 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id o192sm9966704pfg.81.2020.08.31.20.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 20:39:01 -0700 (PDT)
Subject: Re: [PATCH] io_uring: Fix NULL pointer dereference in
 io_sq_wq_submit_work()
To:     Xin Yin <yinxin_1989@aliyun.com>, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200901015442.44831-1-yinxin_1989@aliyun.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae9f3887-5205-8aa8-afa7-4e01d03921bc@kernel.dk>
Date:   Mon, 31 Aug 2020 21:38:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901015442.44831-1-yinxin_1989@aliyun.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/31/20 7:54 PM, Xin Yin wrote:
> the commit <1c4404efcf2c0> ("<io_uring: make sure async workqueue
> is canceled on exit>") caused a crash in io_sq_wq_submit_work().
> when io_ring-wq get a req form async_list, which may not have been
> added to task_list. Then try to delete the req from task_list will caused
> a "NULL pointer dereference".

Hmm, do you have a reproducer for this?

> @@ -2356,9 +2358,11 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>   * running. We currently only allow this if the new request is sequential
>   * to the previous one we punted.
>   */
> -static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
> +static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req,
> +							struct io_ring_ctx *ctx)
>  {
>  	bool ret;
> +	unsigned long flags;
>  
>  	if (!list)
>  		return false;
> @@ -2378,6 +2382,13 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
>  		list_del_init(&req->list);
>  		ret = false;
>  	}
> +
> +	if (ret) {
> +		spin_lock_irqsave(&ctx->task_lock, flags);
> +		list_add(&req->task_list, &ctx->task_list);
> +		req->work_task = NULL;
> +		spin_unlock_irqrestore(&ctx->task_lock, flags);
> +	}
>  	spin_unlock(&list->lock);
>  	return ret;
>  }
> @@ -2454,7 +2465,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>  			s->sqe = sqe_copy;
>  			memcpy(&req->submit, s, sizeof(*s));
>  			list = io_async_list_from_req(ctx, req);
> -			if (!io_add_to_prev_work(list, req)) {
> +			if (!io_add_to_prev_work(list, req, ctx)) {
>  				if (list)
>  					atomic_inc(&list->cnt);
>  				INIT_WORK(&req->work, io_sq_wq_submit_work);
> 

ctx == req->ctx, so you should not need that change.

-- 
Jens Axboe

