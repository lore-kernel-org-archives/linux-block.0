Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1342C31E4B
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92662063F
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 17:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfFMRF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:05:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45866 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729894AbfFMRFV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 13:05:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so663975pfq.12
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 10:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+7FKAT5xuoFMIJLg9eMriNBN5tsBut1zijtvt/ug6VY=;
        b=UZvboiN//TL8EeZr1Sl3l2fc+mLM9e48RJ0RsiQ1MtN7IytEcnUCyXN9sggT1V1bP7
         erbxwY3YFXr5stH+XIvZf2fwoGafiGToOmwJpc99rx/G6/vudbV9Rl1HB2q6+tjhAQZC
         z8tXTfH+ZvkJE1LhKZeGQU0AyoSY7NpzzTty1l8kMykhjVkjfIOJVQn29gVxpqf+Usxk
         KM5jz1LOwr7+ZFcoH70wrZGEXlmztcuPIoYR8Gy0jJeUzC6S8b+faFhZ1hxyblHyynzl
         NnU4xnHzGr/3+mKVqq+wymHxGzyML1zokywcXBrpJ8nzPo+INHwEXF3z/z8Ur952tDFp
         ybZQ==
X-Gm-Message-State: APjAAAVqEAfHpg9GfDUMIXDZNBN0Td5Z6kZ8UTN0Uu43HfeVeOpcluJb
        T16FwL9OytZEzWrrwQGqoGE=
X-Google-Smtp-Source: APXvYqwcJFPqORoPUrLR11JoBB4sd/tAvbkqZgJLfrjY+eTqSklWUYRDHwwKj4GCSoveKS5fzKL4qg==
X-Received: by 2002:a17:90a:a596:: with SMTP id b22mr6694221pjq.20.1560445520373;
        Thu, 13 Jun 2019 10:05:20 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m96sm540897pjb.1.2019.06.13.10.05.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 10:05:15 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] block: add more debug data to print_req_err
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, hch@lst.de, hare@suse.com
References: <20190613141629.2893-1-chaitanya.kulkarni@wdc.com>
 <20190613141629.2893-3-chaitanya.kulkarni@wdc.com>
 <d369fbbd-0d98-b804-619b-23049ee12398@acm.org> <yq1d0jhtoii.fsf@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <be1e3944-4f5a-ca40-1496-614058fd3bb2@acm.org>
Date:   Thu, 13 Jun 2019 10:05:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <yq1d0jhtoii.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/19 9:53 AM, Martin K. Petersen wrote:
> 
> Bart,
> 
>> If this patch gets applied there will be three copies in the upstream
>> code that convert a REQ_OP_* constant into a string: one in
>> blk-core.c, one in blk-mq-debugfs.c and one in
>> include/trace/events/f2fs.h. Is it possible to avoid that duplication
>> and have only one function that does the number-to-string conversion?
> 
> People often have a hard time correlating SCSI and block error messages
> with tracing output. So in general I'd like to see us not just trying to
> standardize the helper functions, but the actual output.
> 
> I.e. I think it would be great to print exactly the same string for both
> error log messages and tracepoints. Since Chaitanya is doing a lot of
> work in this area anyway, that may be worth looking into?

Hi Martin,

I'm in favor of improving consistency. But are you sure that we can 
modify the tracing output format without breaking any applications?

Bart.


