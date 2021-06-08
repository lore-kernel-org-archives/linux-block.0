Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BED5C47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 15:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBC161287
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 15:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhFHPGB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 11:06:01 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:36713 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhFHPGB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 11:06:01 -0400
Received: by mail-pj1-f45.google.com with SMTP id d5-20020a17090ab305b02901675357c371so13918643pjr.1
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 08:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xWQnAJeNzdp06JbxiO/z5U+GoJHTfCjMg6UZSsFqdJI=;
        b=f225e0SXNQ9fNa7HTW8A7DmEx051WJmUHqThSjOjmffD8KwWlCMA6SsSIDVWsNhIZ7
         iPZqKZLRwpJF72r+ASzXu8NCiiBXAkm5UTp201qHdRbpYUt4GoCckPJd1Sw3eZGMPcaI
         hVCWh3rIArv/FJjYHEabr4eS5e2kKaKWCOM+hdW4bWVUXHxTSNdv6BobxvQHl59xs7wr
         T91RMbceJrvlleZQE8g7A8HIrpRQgW9AkljnJv81hmP+UP42uNMr2UUb4rxspl+ZQHm2
         A+FCEf1vquDxGNWkmGkBtr0czBxtE+ROvAW6MLZuV2QE7aU6isoFRBzkiFGN+r1KBx0y
         NPDw==
X-Gm-Message-State: AOAM531aXb1ysVsvMJTRiL7OTKuatSJN8taHlm432JG9gc+Og//Xh9Yn
        HrtwoCZVM/yEYqIjeWrw+wk=
X-Google-Smtp-Source: ABdhPJzE0FaTajSMTSNpnP3Rsb+81e8fH22xlG4tSidFj0SV3uX8zxJMnMy9SQpC+1eIZIAFN6d3lg==
X-Received: by 2002:a17:902:44:b029:ee:9107:4242 with SMTP id 62-20020a1709020044b02900ee91074242mr108535pla.18.1623164643380;
        Tue, 08 Jun 2021 08:04:03 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id i8sm11735001pgt.58.2021.06.08.08.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:04:02 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] block: fix race between adding/removing rq qos and
 normal IO
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
References: <20210608071903.431195-1-ming.lei@redhat.com>
 <20210608071903.431195-2-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <897fbf4d-569d-afae-c20d-745c8e2965d2@acm.org>
Date:   Tue, 8 Jun 2021 08:04:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608071903.431195-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/21 12:19 AM, Ming Lei wrote:
>  static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
>  {
> +	/*
> +	 * No IO can be in-flight when adding rqos, so freeze queue, which
> +	 * is fine since we only support rq_qos for blk-mq queue
> +	 */
> +	blk_mq_freeze_queue(q);
>  	rqos->next = q->rq_qos;
>  	q->rq_qos = rqos;
> +	blk_mq_unfreeze_queue(q);
>  
>  	if (rqos->ops->debugfs_attrs)
>  		blk_mq_debugfs_register_rqos(rqos);
> @@ -110,12 +117,18 @@ static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
>  {
>  	struct rq_qos **cur;
>  
> +	/*
> +	 * No IO can be in-flight when removing rqos, so freeze queue,
> +	 * which is fine since we only support rq_qos for blk-mq queue
> +	 */
> +	blk_mq_freeze_queue(q);
>  	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
>  		if (*cur == rqos) {
>  			*cur = rqos->next;
>  			break;
>  		}
>  	}
> +	blk_mq_unfreeze_queue(q);
>  
>  	blk_mq_debugfs_unregister_rqos(rqos);
>  }

Although this patch looks like an improvement to me, I think we also
need protection against concurrent rq_qos_add() and rq_qos_del() calls,
e.g. via a mutex.

Thanks,

Bart.


