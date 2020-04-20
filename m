Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3982AC55181
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 21:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213EE2078C
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 21:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgDTVHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:07:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42457 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgDTVHR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 17:07:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id g6so5679253pgs.9
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 14:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iQg8BsGeC+oOIpY/hDtjQO5kX8dYwBU+ORWYPV3pRHA=;
        b=XLNcbTgZI3MNstR5/xy0vbOWG0/9cCxu80BcMAzvm1tKekoheGzObHJ8auqAFhs+yu
         VmiLshqzD4Ja03xhZCQiwCO4uHuTDbgBk2Za66NLjZ5uqvuIXjvqYZZqjItCAB/r6O9Q
         6taBiAoT19nyd8Bd8URtdNrr5BaA6nz2uvRNFernUiZU39GcbdPMF/xbJBfdVh3T1U8c
         7bnvYiqtwOVzxthJrlzGfsO5fsJYfzjLl0m32/zpmXW1ypd8XcFLwYwAytFF5j6jCK12
         ED8fm7oYCjJPDDPCwgRNO1DtXxtUYfH4ozB4XGDSAuK3zEqBXOkDiuvr7Iaw98qbk3Io
         RTmQ==
X-Gm-Message-State: AGi0PuYyUfw+phrrSk+YLoVEaJjVyMz1XLbFlFHfKd+zs7d+e43+8HJ2
        dhJXJvAQaZx2V6xeL4NjU7Y=
X-Google-Smtp-Source: APiQypLtDg9rYPey8bDQOP5kpd6av+j7Gm/TynlB9952pZ0S/5RMzwEoqsguPmlFH6EIgifBnFcr1A==
X-Received: by 2002:a63:d906:: with SMTP id r6mr18874048pgg.416.1587416836219;
        Mon, 20 Apr 2020 14:07:16 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.198.105])
        by smtp.gmail.com with ESMTPSA id x25sm379010pfm.203.2020.04.20.14.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 14:07:15 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] block: refactor __blk_mq_alloc_rq_map_and_requests
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
 <eb995b7a9c5a942c596eb21856043c4a1b2135f1.1586199103.git.zhangweiping@didiglobal.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e289ea06-c799-8444-2b2a-720f5d75f2c2@acm.org>
Date:   Mon, 20 Apr 2020 14:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <eb995b7a9c5a942c596eb21856043c4a1b2135f1.1586199103.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/20 12:37 PM, Weiping Zhang wrote:
> This patch add a new member nr_allocated_map_rqs to the
> struct blk_mq_tag_set to record the number of maps and requests have
> been allocated for this tagset.
> 
> Now there is a problem when we increase hardware queue count, we do not
> allocate maps and request for the new allocated hardware queue, it will
> be fixed in the next patch.
> 
> Since request needs lots of memory, it's not easy alloc so many memory
> dynamically, espeicially when system is under memory pressure.
> 
> This patch allow nr_hw_queues does not equal to the nr_allocated_map_rqs,
> to avoid alloc/free memory when change hardware queue count.

It seems to me that patches 6 and 7 combined fix a single issue. How 
about combining these two patches into a single patch?

Thanks,

Bart.
