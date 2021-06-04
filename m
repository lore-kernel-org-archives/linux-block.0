Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F132C47082
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 00:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E313C6140A
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 00:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFDAps (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 20:45:48 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:43544 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDApr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 20:45:47 -0400
Received: by mail-pl1-f175.google.com with SMTP id v12so3768590plo.10
        for <linux-block@vger.kernel.org>; Thu, 03 Jun 2021 17:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B2Sh5+iDdpVpd3gdnweNu2jTq7+FtdqKAaben4sjNUY=;
        b=XJ5UYDgry9f3COr3JegKl+N/ergO4oWwu9XaK3OrhGEmz/zkyseK7MBkjjhbjZdASN
         KMMxJyj55mYD1QIm0yKx8BnttZS4SyoqOZKpAcB6Rbaqyd1tLEx4IgvK+/ITA3Pxcl68
         d4M/HHcimuIbNarsfiOqlgVRp7nJifZK8vUmXhnmo/1OIe7b9AHoYr76NhEWL9LZvNTs
         xFvkSbev1Du7KRy88OYhDdSEklN+QFB3FyExwVqw5cK19lCca8jjSMGMzXNlE5YnU07Y
         vlv1BQCubqZsU3g90RFg2Q6/BX96Y88Q9G9X6B0YE9BnsmwBiErevagZC7Aiw5+BuONS
         FD1g==
X-Gm-Message-State: AOAM533nDziSbrxKhX4QAcx4IZqy+0DksCte3j7gyAO8H9gHtnj0lI3F
        Fb8bfOeMhZfX9d8mEC2ClKs=
X-Google-Smtp-Source: ABdhPJycFsp3DEh7owBg8VEHfOZUEZnQ0zmpjWJSytfoiIGIMFhT94VqJcmwsZmv1xc87T89j3Xqig==
X-Received: by 2002:a17:903:1c3:b029:f1:ecf4:f971 with SMTP id e3-20020a17090301c3b02900f1ecf4f971mr1784937plh.6.1622767442268;
        Thu, 03 Jun 2021 17:44:02 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id p20sm190763pff.204.2021.06.03.17.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 17:44:01 -0700 (PDT)
Subject: Re: [PATCH 2/4] block: move wbt allocation into blk_alloc_queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
References: <20210525080442.1896417-1-ming.lei@redhat.com>
 <20210525080442.1896417-3-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <35a0f0b7-ad44-26cb-7fb7-d4f56241ff62@acm.org>
Date:   Thu, 3 Jun 2021 17:44:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525080442.1896417-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/25/21 1:04 AM, Ming Lei wrote:
> wbt_init() calls wbt_alloc() which adds allocated wbt instance into
> q->rq_qos. This way is very dangerous because q->rq_qos is accessed in
> IO fast path.
> 
> So far wbt_init() is called in the two code paths:
> 
> 1) blk_register_queue(), when the block device has been exposed to
> usespace, so IO may come when adding wbt into q->rq_qos
> 
> 2) sysfs attribute store, in which normal IO is definitely allowed
> 
> Move wbt allocation into blk_alloc_queue() for avoiding to add wbt
> instance dynamically to q->rq_qos. And before calling wbt_init(), the
> wbt is disabled, so functionally it works as expected.

I don't like this change since it is not generic - it only helps the WBT
implementation.

All rq-qos policies call rq_qos_add() and all these policies take effect
before rq_qos_add() returns. Does the q->rq_qos list perhaps have to be
protected with RCU? Would that be sufficient to fix the crashes reported
in the cover letter?

Thanks,

Bart.
