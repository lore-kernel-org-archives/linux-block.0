Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C519C433E0
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 19:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A356722D6E
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 19:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbhAETRW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbhAETRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 14:17:21 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E888C061574
        for <linux-block@vger.kernel.org>; Tue,  5 Jan 2021 11:16:41 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v19so479440pgj.12
        for <linux-block@vger.kernel.org>; Tue, 05 Jan 2021 11:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vWNDNO/XfL/ncHE2eKOk0BmDNlW2uHwe3nGMOUQkjSg=;
        b=qL9igD4xefW/McBb0zKsXnDcsGrq9Yif5tKyBfFA6BpjyRHrPi5vFFi/r3viVAOTab
         49Uq6t0dtq4WAEQSA+TXs72nJdz2LUs4qejtcipbOmRYIFCH/7YS2S8ABxtnHzgobznO
         3+nD0w2ly7DU3R8bT20xshiavl1o+TM1v+VvTRwhMVzRZROmZztA2xbr5Z/mydULguHK
         urIWtrMW7uiRT5oDKIOMvF/CSgvaHUq0loCqNhYi4Oiqj/WwLPUmbeM+URR4mpB3YQ6A
         Vsl/rA8YlXy982aT0gHNniol35+ZF1e9e19Kt+ur/ytRO9Ay6IrxWMTRJAhZ9Sr4eptr
         d1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vWNDNO/XfL/ncHE2eKOk0BmDNlW2uHwe3nGMOUQkjSg=;
        b=mdxAenltkMjnUT+p0fKIN4DAMsSzFsCOYNYig6QgrHycpfA8o57yRF62526wUX66wF
         mEttxIX3U39417jlPHsNgpSbU0zFUd7WYG2gFQJUE8ZXY/483RAN0va4qpazjxiT4qsR
         EK51SaFZUU8cuw4R+EVseUMlUgzUUINFwX4D71cuQlVWfbnSC1+2cb2IZKf2RmYrMRcH
         SiJkoDtGBaB4VJl0Ccp6UkWrZ/2xyYgHJTb3K2VNCC8bQ5q2Cnis03kTe1Jb+yA5ef8+
         qUL/Ys3LXNchsK30xQDaceV4jRZ4FlQt1ocYcydlqiCiS7lmnY7Lx+pxMMF1SMfzEFAM
         dXIQ==
X-Gm-Message-State: AOAM5319Y1ptasmfTIO745Coi8VnF+kt2UrlUZonjghdnDB8utE+C5Dl
        uaCbEDdPXAuvczwkHugPwnw=
X-Google-Smtp-Source: ABdhPJwnCbZ6s6swHj0RW0g4MBZMoRxL+5uEW0Ap+ch1WTG+LATyWC4Dx0JMgN+mbiBWk9+6DhDozg==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr760054pgg.196.1609874201094;
        Tue, 05 Jan 2021 11:16:41 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id p9sm10811pjb.3.2021.01.05.11.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jan 2021 11:16:40 -0800 (PST)
Date:   Wed, 6 Jan 2021 04:16:38 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_set_request_complete
Message-ID: <20210105191638.GB4426@localhost.localdomain>
References: <20210105071936.25097-1-lengchao@huawei.com>
 <20210105071936.25097-2-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210105071936.25097-2-lengchao@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On 21-01-05 15:19:31, Chao Leng wrote:
> In some scenarios, nvme need setting the state of request to
> MQ_RQ_COMPLETE. So add an inline function blk_mq_set_request_complete.
> For details, see the subsequent patches.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>  include/linux/blk-mq.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index e7482e6ad3ec..cee72d31054d 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -493,6 +493,11 @@ static inline int blk_mq_request_completed(struct request *rq)
>  	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
>  }
>  
> +static inline void blk_mq_set_request_complete(struct request *rq)
> +{
> +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> +}
> +

Maybe we can have this newly added helper with updating caller
in blk_mq_complete_request_remote() also ?

Thanks,
