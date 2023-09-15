Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0105EEDE995
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 03:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjIOD2G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Sep 2023 23:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjIOD2F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2023 23:28:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7772B270C
        for <linux-block@vger.kernel.org>; Thu, 14 Sep 2023 20:28:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c364fb8a4cso15511185ad.1
        for <linux-block@vger.kernel.org>; Thu, 14 Sep 2023 20:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694748481; x=1695353281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+PxbEbDUK9m7L9eOwonONEUf3spAn5TVfpL5qQWV60=;
        b=mLtXxtTKjvfYHe/VITVe0m8r7E20dD6WhQVlDdyN3Ywh3s3mHyO6jUXs2gSsOS+LVO
         fuLT4TtoRg0ZgFabEqmLyckw5eRdqfQeeMwXaEnUQKyt/YMyooZJEkFu37vN5s8WeC1m
         MpB3PJIKbP3x6DTZvCaVo7DSfSend1ficmTOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694748481; x=1695353281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+PxbEbDUK9m7L9eOwonONEUf3spAn5TVfpL5qQWV60=;
        b=Hxa4V19XXBuQfZ/RIq0HTqdbjVlEnHTXN6sQGy7A2HSSDdDQuJvGvZ/wqSXdi3nqfb
         GPwWmMOqDZCeS/Z+P8dtVJVOOc5dupDYx56JG5dRiFLwvgMAD7cnHr0lkNzu0nn9o2TV
         8EG5PRt7ju7PdoR/Fw7C5GGvVoCj2FGreQBcdjGDxVzPba9NKoXaw0aQyXVjj593GN/x
         fY86PqW0QLSpsoFVanZuWUnbJs8BxGDdJD66cQrtJtRqv29XdKAkK6vvkcEjUd2PjVWv
         cUe1hpKaAIRZkN/SjWEjFcALT2QEr8BZmYbvQLlq0mJkWG+70I0Ef2WVNPASco+8OYXK
         E7Dg==
X-Gm-Message-State: AOJu0YzYCCPsMSgU9K9oD6h7g8fYEywdMegTwy1nOA1LO0ed0g+yOVeJ
        /70QdnZk4QOq6A1RmBfsPQwB8Q==
X-Google-Smtp-Source: AGHT+IF0/YcQFVvOK0tcqUhNbXrT6DuPYxwgG6RG9j0w5ZYKT0uGXsAGlk7mB14f95hH7iaxmatr2w==
X-Received: by 2002:a17:902:e881:b0:1bc:203f:3b3c with SMTP id w1-20020a170902e88100b001bc203f3b3cmr539931plg.24.1694748480950;
        Thu, 14 Sep 2023 20:28:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b001b9f7bc3e77sm2326232plx.189.2023.09.14.20.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:28:00 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:27:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] null_blk: refactor deprecated strncpy
Message-ID: <202309142022.50EF929@keescook>
References: <20230911-strncpy-drivers-block-null_blk-main-c-v1-1-3b3887e7fde4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-strncpy-drivers-block-null_blk-main-c-v1-1-3b3887e7fde4@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 11, 2023 at 09:46:47PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should favor a more robust and less ambiguous interface.
> 
> We know `nullb->disk_name` is NUL-terminated and we expect that
> `disk->disk_name` also be NUL-terminated:
> |     snprintf(nullb->disk_name, sizeof(nullb->disk_name),
> |              "%s", config_item_name(&dev->group.cg_item));

More accurately, it's has uses that require a %NUL-terminated string:

	pr_info("disk %s created\n", nullb->disk_name);

(i.e. showing the consumer's use is better evidence than the producer's
use.)

But I do think the above is good evidence that truncation is tolerated.

> 
> It seems like NUL-padding may be required due to __assign_disk_name()
> utilizing a memcpy as opposed to a `str*cpy` api.
> | static inline void __assign_disk_name(char *name, struct gendisk *disk)
> | {
> | 	if (disk)
> | 		memcpy(name, disk->disk_name, DISK_NAME_LEN);
> | 	else
> | 		memset(name, 0, DISK_NAME_LEN);
> | }

I does look like it expects 0-fill. Looking at it with more context,
this appears to be a trace buffer:

TRACE_EVENT(nullb_zone_op,
            TP_PROTO(struct nullb_cmd *cmd, unsigned int zone_no,
                     unsigned int zone_cond),
            TP_ARGS(cmd, zone_no, zone_cond),
            TP_STRUCT__entry(
                __array(char, disk, DISK_NAME_LEN)
                __field(enum req_op, op)
                __field(unsigned int, zone_no)
                __field(unsigned int, zone_cond)
            ),
            TP_fast_assign(
                __entry->op = req_op(cmd->rq);
                __entry->zone_no = zone_no;
                __entry->zone_cond = zone_cond;
                __assign_disk_name(__entry->disk, cmd->rq->q->disk);
            ),

This should probably have been a dynamic string, but it's not. So let's
make sure this stays padded. Can you send this again but use
strscpy_pad() instead?

-- 
Kees Cook
