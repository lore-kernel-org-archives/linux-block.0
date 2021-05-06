Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4155AC433ED
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B06610D2
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 15:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhEFPDz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 11:03:55 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:50709 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbhEFPDy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 11:03:54 -0400
Received: by mail-pj1-f53.google.com with SMTP id md17so3486667pjb.0
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 08:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bSUZJK+GiypPBzQmpQG4BZMhYH3gmtkds4Klia8lghk=;
        b=B3u2MFxN+PkvuILPyK4v4h1UoyZROuUoYn32fWTNNLMmR1u+zfkHqerlBF7fKJaZhG
         KXnaLB92XPOfLWdtXIMWjWfRJt2Zs3qV7h11p+FOguLwVYVEuZ3M0pLmE1XE30jum8WQ
         93y6ltUWSk0Mm6/FX1fqgnyTtU5iaXDA4b93kPwyzUCaWqGwoVhIfklm/k+13R05LwqX
         2FDrxQJX+wmgUq9D36tuWutaGWrXOcvc87F3yIyTR0W328KIIc87E1rgKrHshygNzVAI
         bJLK8pWCcsaZwxJOop83UwU62p269WEdsxecLS5lN5b+w92wAxe8QUFLKmtuczi2ApF9
         KRCg==
X-Gm-Message-State: AOAM531GI3ljXfY0akCcXtaTosUSVt/w2JobZrh6DTof6MI3mJpy5zCg
        KjssxFe/6gCExMjB0o7XECTqb40dGew=
X-Google-Smtp-Source: ABdhPJy0jTB++Tr/05EuUyr3zlIlnQRWhsIgOC0QXRO3yy/2h9VYeklC+UPTOKHEmepQFNVDnO8T6g==
X-Received: by 2002:a17:902:ba88:b029:ee:f232:d13a with SMTP id k8-20020a170902ba88b02900eef232d13amr4981516pls.44.1620313375901;
        Thu, 06 May 2021 08:02:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c791:bbbb:380d:7882? ([2601:647:4000:d7:c791:bbbb:380d:7882])
        by smtp.gmail.com with ESMTPSA id z126sm2402785pfz.130.2021.05.06.08.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 08:02:55 -0700 (PDT)
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <db8a5f29-46b6-42c3-72c0-7ac70509e5d6@acm.org>
Date:   Thu, 6 May 2021 08:02:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210505145855.174127-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/5/21 7:58 AM, Ming Lei wrote:
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 4a40d409f5dd..8b239dcce85f 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -203,9 +203,14 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
>  		unsigned int bitnr)
>  {
>  	struct request *rq = tags->rqs[bitnr];
> +	unsigned long flags;
>  
> -	if (!rq || !refcount_inc_not_zero(&rq->ref))
> +	spin_lock_irqsave(&tags->lock, flags);
> +	if (!rq || !refcount_inc_not_zero(&rq->ref)) {
> +		spin_unlock_irqrestore(&tags->lock, flags);
>  		return NULL;
> +	}
> +	spin_unlock_irqrestore(&tags->lock, flags);
>  	return rq;
>  }
Has it been considered to change the body of the if-statement into the
following?

		rq = NULL;

That change would reduce the number of return statements from two to one.

Thanks,

Bart.
