Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60EBC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 22:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833A661050
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 22:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhIUWfL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:35:11 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:33570 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhIUWfK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 18:35:10 -0400
Received: by mail-pf1-f178.google.com with SMTP id s16so998454pfk.0
        for <linux-block@vger.kernel.org>; Tue, 21 Sep 2021 15:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rjCaKL8aEqCL+F9sb3SwzG3pg3uKxZz/vmHbmg/LRi4=;
        b=7rgBQN+A2TGWLtUziq2DGnUdnTiLkTXTLmfGosKSivY7TglwBt3tK8WUMgFYyL3UvK
         I6pHgLpkWBBaHdRSxPATDsnK5z7omzm/OAZ9Cbs8W48OhEl8mT/amnkOwGceN9ybFk+g
         Z5TlVMmrhOh/310dCsQksB+naxIEEYPPFsUmrshTqIHUq/fHafxkEFn5DPi6D+Kc7s4l
         rRGQD92rN/hDrdUQqBPKdqG21aFNWwT59fGzIH5vLZOZW4nljsVlUrPiUdoUv7VzW2Oo
         s4bQzWhiQIVx3JhTQ0hc43URoe6qKoAdFnbQKsbNtgrHA+VIhuIP5Gwx9k25aWDnGpFy
         dMSQ==
X-Gm-Message-State: AOAM532KMqdgC6mnkpWe3+y1of9ibrnBReMAd17+2eiI+pOsRDTjVZit
        4zHUDbkRIDGQ5BJWKyt8fAk=
X-Google-Smtp-Source: ABdhPJzgyL8LTcfQqH2Uxa1uOHQ1splo0RboF9BMUrEbTOoVbdQ0vEgfHfS0Hyjfjcc/HALF2P/tVg==
X-Received: by 2002:a63:6983:: with SMTP id e125mr5732651pgc.328.1632263621639;
        Tue, 21 Sep 2021 15:33:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f3b9:da7d:f0c0:c71c])
        by smtp.gmail.com with ESMTPSA id t13sm108998pjg.25.2021.09.21.15.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 15:33:41 -0700 (PDT)
Subject: Re: tear down file system I/O in del_gendisk
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20210920112405.1299667-1-hch@lst.de>
 <89982489-a063-0536-2a35-7420d71fc939@acm.org> <20210921090811.GB336@lst.de>
 <868b6e73-0f0a-86d3-395c-dc797a71d616@acm.org>
Message-ID: <799aea3a-1998-b551-5f24-06172113194d@acm.org>
Date:   Tue, 21 Sep 2021 15:33:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <868b6e73-0f0a-86d3-395c-dc797a71d616@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/21 7:24 AM, Bart Van Assche wrote:
> This regression may have been introduced by commit 5f7acddf706c ("null_blk: poll
> queue support").

(replying to my own email)

All the blktests tests that I ran pass if make the following changes:
- Revert the commit mentioned above.
- Use the soft-iWARP driver instead of the soft-RoCE driver (export use_siw=1).

Bart.
