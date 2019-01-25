Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D62C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 03:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF327218DE
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 03:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfAYDuO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:50:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43605 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfAYDuO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 22:50:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so3612253pgk.10;
        Thu, 24 Jan 2019 19:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mJIL0M7lKjMC7jEiUQQwvHyY4N/RjNScIj6Zg4fH9/Y=;
        b=HwWaxwLeU8VKdk0VBkJkKa9MLj4Usxn13CQ88XfEIzuGHL9qUJH7d23RWUcDg9l8Bn
         aZlEwGiNlxSYvdzHJ+J/ws32Jm1MAchirTB+1fynRj1dk+zcIhMNHgw66E1HazWxleJw
         y9VUa0Myxc51uHECEou24eL+Ol1kd1YZ6dYX8pj//iMcJukEpXjZxteqFhpHYkF3Mc1l
         N+oi506uRu6+YtkvnYfaXaxeDD2IA+WIN9VBmebbniEfBCVHW20pRN0ldPgwtrh92Y+T
         kEgm5t8mF3LIHzKkxqmh81Gx0fwAh5zXb/wem9wOElzK9HHkE39D+pvMXkecMkpgGcyD
         X/fA==
X-Gm-Message-State: AJcUukdNARpq1lzKOVCjFtWbeyjZnY/g8Xg77gCnzv1zvqNRu+MIrowV
        eHIW3fQ4+ue41VxaH/fa4H3gi53W
X-Google-Smtp-Source: ALg8bN77fwFIXf9/lfk1hKssKdhEgUFq+lYfyqlrMyYBkI2w8lOzl5CRLPqg05JwSmHZhGA7yriC/Q==
X-Received: by 2002:a62:7a8b:: with SMTP id v133mr9464252pfc.159.1548388212998;
        Thu, 24 Jan 2019 19:50:12 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id w185sm32650218pfb.135.2019.01.24.19.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 19:50:12 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: Fix doc related to blkcg_exit_queue
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
References: <20190125020142.921371-1-marcos.souza.org@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <06802295-4dc7-20bd-a511-99dc37bf8777@acm.org>
Date:   Thu, 24 Jan 2019 19:50:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125020142.921371-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/19 6:01 PM, Marcos Paulo de Souza wrote:
> Since 4cf6324b17e9, a portion of function blk_cleanup_queue was moved to
> a newly created function called blk_exit_queue, including the call of
> blkcg_exit_queue. So, adjust the documenation according.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>   block/blk-cgroup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 2bed5725aa03..77f37ef8ef06 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1269,7 +1269,7 @@ void blkcg_drain_queue(struct request_queue *q)
>    * blkcg_exit_queue - exit and release blkcg part of request_queue
>    * @q: request_queue being released
>    *
> - * Called from blk_release_queue().  Responsible for exiting blkcg part.
> + * Called from blk_exit_queue().  Responsible for exiting blkcg part.
>    */
>   void blkcg_exit_queue(struct request_queue *q)
>   {

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
