Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66C2C7EE2D
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 17:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbjEWRTl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 13:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbjEWRTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 13:19:38 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6EBDD
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:19:38 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-528dd896165so5397589a12.2
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862378; x=1687454378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bA2Dp0hq5GoIHRA5UMzDyji84dZ8sX8m+2ZQMAlQLo=;
        b=LcQHAlIUAIFRkmy4Q38Poh7l6zyG1bN2nMr0RsIcUlNzYtNHwbXPSThmJiHYhpgz2Y
         9bL4O9Ndu17eHcTHQDZf7glH5XCWbXUC3TSg7RlFkGGwSVfGo/mmeIOp1VMbsIITVQOH
         o5ZULip0RAGgpEPkZ7KPE9r7/WxAcwX8xP+7xAJdNE6slNeVqrMNN3AUTnBFd0ujZoT7
         qfSSeBJb6jpt0KJrL8iU99PrlYQAE9uKraslUBFXCq5uxwtpzr9eOczAQpalrF4PvLsk
         L4vh4dylxvg9py/q6agepa91R50D0aAccOCnGqlPujoKYS8Sisowj4qiBGZYlS8XQagg
         KW1w==
X-Gm-Message-State: AC+VfDyvifz00gbynvXfuY3U9wSAOlESI8f5CYwFPiAXqxOhnsGS+Yra
        RTOrRF0dQQ495hqd3bheuZ0=
X-Google-Smtp-Source: ACHHUZ5PVkqviUQ6OE9PXsE7uJ3eFm+435m5RhGyi7YYNrHmn2108ukZBIpsmVNZMHZ8ch6kkLL/lw==
X-Received: by 2002:a17:90a:a109:b0:247:3e0a:71cd with SMTP id s9-20020a17090aa10900b002473e0a71cdmr12724650pjp.6.1684862377591;
        Tue, 23 May 2023 10:19:37 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:24d2:69cd:ef9a:8f83? ([2620:15c:211:201:24d2:69cd:ef9a:8f83])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090a290200b0024e11f7a002sm6616114pjd.15.2023.05.23.10.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 10:19:37 -0700 (PDT)
Message-ID: <1d2fc2c5-18fc-a937-7944-7d7808c00a0b@acm.org>
Date:   Tue, 23 May 2023 10:19:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-3-bvanassche@acm.org>
 <ZGyBV5W1WxVEzAED@ovpn-8-32.pek2.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZGyBV5W1WxVEzAED@ovpn-8-32.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 02:03, Ming Lei wrote:
> On Mon, May 22, 2023 at 11:38:37AM -0700, Bart Van Assche wrote:
>> Send requeued requests to the I/O scheduler such that the I/O scheduler
>> can control the order in which requests are dispatched.
> 
> I guess you are addressing UFS zoned for REQ_OP_WRITE:
> 
> https://lore.kernel.org/linux-block/8e88b22e-fdf2-5182-02fe-9876e8148947@acm.org/
> 
> I am wondering how this way can maintain order for zoned write request.
> 
> requeued WRITE may happen in any order, for example, req A and req B is
> in order, now req B is requeued first, then follows req A.
> 
> So req B is requeued to scheduler first, and issued to LLD, then
> request A is requeued and issued to LLD later, then still re-order?
> 
> Or sd_zbc can provide requeue order guarantee?

Hi Ming,

The mq-deadline scheduler restricts the queue depth to one per zone for zoned
storage so at any time there is at most one write command (REQ_OP_WRITE) in
flight per zone.

Thanks,

Bart.

