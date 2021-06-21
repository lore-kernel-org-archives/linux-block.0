Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7C5C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 15:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 493CD60FD8
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 15:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFUPyU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:54:20 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:46931 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFUPyT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 11:54:19 -0400
Received: by mail-pj1-f44.google.com with SMTP id o10-20020a17090aac0ab029016e92770073so258103pjq.5;
        Mon, 21 Jun 2021 08:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=txe+1WofMbhsdqcrxgCtHOX6W/vRT0f0R5GMDOT4QPk=;
        b=hwEYLSKPP36VZGvAl1UGv8tSInc5xeVuScvkmt6dvbUDjaO+23iL/Yi9s9BAD/+vGO
         cUNkM3rp+TnwbU8ljaKR4JfdzBaduZtXPIB0XushLvGxTdWbYIB5Ds7FHHUi8gXeTKxu
         EB+7qO2q27wOONl5FNkT1rqfXmvHWp7CQ+uBzLCwe9V+/E/2QwKI1Ndn5uhIuHWySK6O
         PbwsdtNhGn8CJ9RV5q2lHBiwG7VPdkAk0wGcZyneL3aeUJRBEdBalY2mQMg41Xx3Zh7w
         gKoms8l304SaIKRyRpmrvNvOH9odBqktu8yM+Pm4HIEgyMSDaSzqAqweR/yg2WjuyLWt
         C6EA==
X-Gm-Message-State: AOAM5306LNBR/Bqy4KF81jyNOqh8sKGVFVQTPP5U+goutUXOIJDY+6EE
        cBA0rLuweubEnRTXc3rSkzWl3gdVpXk=
X-Google-Smtp-Source: ABdhPJywK7Hh+cJYivJmUZdkgWYo2c/Ey+6/LFUXcuP6/U9oQWWUQEqlWtWcT8tsT3OJISHGrLEH3g==
X-Received: by 2002:a17:90b:4b88:: with SMTP id lr8mr27685043pjb.85.1624290724860;
        Mon, 21 Jun 2021 08:52:04 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id e13sm5733492pfd.8.2021.06.21.08.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:52:04 -0700 (PDT)
Subject: Re: [PATCH] block: Include mm_types.h instead of mm.h
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20210621122407.3116975-1-willy@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <747c19ad-2692-6512-5c1c-0be346b00954@acm.org>
Date:   Mon, 21 Jun 2021 08:52:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621122407.3116975-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 5:24 AM, Matthew Wilcox (Oracle) wrote:
> There's no need to include all of mm.h in bvec.h.  It only needs a few
> things like the definition of struct page, PAGE_SIZE, PAGE_MASK and so
> on, all of which are provided by mm_types.h.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
