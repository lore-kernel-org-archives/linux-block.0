Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53105C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 16:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323A360FE6
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 16:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhIWQXk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:23:40 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41872 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhIWQXj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 12:23:39 -0400
Received: by mail-pg1-f170.google.com with SMTP id k24so6859470pgh.8
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 09:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Co7LfawBh1HzhzjeA30TW79/wFEH6R7HiLrSiY18iOU=;
        b=EgaVpYh0NCR9X9JjfQ9Aj/x4yXqlw/dKBEACK8GuhPfTG39WC05yiWj0kGW+NijuKh
         kKdJkxU6RJ/xUuBix/OACmYaY/os28cxIC2hPhXN8b+6Lv00W9t4PRTFF2YJbDC0tUbK
         UlVSw2w61iOl724KeG+bWz6GlTE1lVrwYR4gjoFFWUIEL81rO/X2IJ07QzkU/+g/OAKi
         oLE+yghyamszRh6xAj+eN98x8V5lu3o30eQBvBey7Bjq0TiWkBn8BckqX6nJULFWPLpa
         wySyXfKYABNCKyWlmEbmr/jYzqanhnohs6qoU2iZA/NGADAbJdJIfA8WVA8J5kpaHuIG
         K84w==
X-Gm-Message-State: AOAM530pFfgRQ6J0JV8qW81B5gGkivIJtBYXLG3+eLElNkFqZAOA4PI6
        aPM0g3t1j4prkZGM9sLqSoM=
X-Google-Smtp-Source: ABdhPJxD37hZJVMImI1bt+QCbXrmJgg9m4OKgV1QdoBwHHkPJd188iT0l9WVWIOj8drO2rWtDbqjoA==
X-Received: by 2002:a65:62c1:: with SMTP id m1mr5060684pgv.339.1632414127671;
        Thu, 23 Sep 2021 09:22:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3c28:de2e:5efb:9f34])
        by smtp.gmail.com with ESMTPSA id j6sm6051963pfn.107.2021.09.23.09.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:22:06 -0700 (PDT)
Subject: Re: [PATCH] null_blk: Fix a NULL pointer dereference
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210922175055.568763-1-bvanassche@acm.org>
 <d8c3e376-145e-f29a-3cf2-210fae4c8884@kernel.dk>
 <fdf80121-35aa-0295-8614-54247fd12686@acm.org>
 <ae742deb-df52-9c65-8cb1-3f66dc0bde53@acm.org>
 <4c26ddaf-1b25-7a53-6e6b-09b59ada1a99@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <941cc786-fea9-4f35-dc19-8b84461285e9@acm.org>
Date:   Thu, 23 Sep 2021 09:22:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4c26ddaf-1b25-7a53-6e6b-09b59ada1a99@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/21 9:04 AM, Jens Axboe wrote:
> What options are you loading null_blk with?

The issues I reported are the result of running test blk/010 from the
blktests suite. That test loads the null_blk kernel module twice:

_init_null_blk queue_mode=2 submit_queues=16 nr_devices=32
[ ... ]
_exit_null_blk
_init_null_blk queue_mode=2 submit_queues=16 nr_devices=32 shared_tags=1
[ ... ]
_exit_null_blk

Please let me know if you need more information.

Bart.
