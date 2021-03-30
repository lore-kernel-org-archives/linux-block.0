Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E1EC433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 22:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09FA619CF
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 22:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhC3Wa1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:30:27 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:41864 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhC3WaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 18:30:05 -0400
Received: by mail-pl1-f179.google.com with SMTP id g10so6897204plt.8
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 15:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7EhgC9AF7Eb6VrdQlSiQTMdtnS4ZprO5uIJV4PSUBPU=;
        b=myv9wg1vBg7jxIomnpGy8+dfRTPTAI3ywWZeclWQAth9F78GhHl2iiwR4uoPdrs81R
         DFXZmhJff3bBUkTpgmRtBK/MRc2Q1mqGhBd4kMigSgA4yAG5zzzBeuqyIy8vj/rtfwn+
         PkNVHqJ0A52GJaiNUDjrOnvsAA9ud8ImzIYt6DkXW0bSkK27dSeifOOgbHSKw8yt4lhT
         4rqfC+KVqBUJJnhw8hKMt0wnhyw0vQ05o44WrqgXvhcgyuGM1xbV8rF/PbIhxEZB4Tg1
         Tb+FZFL4ITbQffe1XC1a5JpEmx9n8vApayNkzOMWOZMf10KzxPU1NwBEu9Yf9KwHe09d
         h4NQ==
X-Gm-Message-State: AOAM531Z1ji8k9v+hh1FivfAGeYb7P1xedBVsOClycrD0UpXtR3qV3+t
        0PtdBd1e37qN5RcwI8IllabBNTZ6bmI=
X-Google-Smtp-Source: ABdhPJzC3ZM1Vi83D8BNooowXCY/nNkkst72z2DmJmwoZBdjp+9VWO3p0MlSZAzhlzO9siGatpsWNg==
X-Received: by 2002:a17:90a:1509:: with SMTP id l9mr460416pja.163.1617143405203;
        Tue, 30 Mar 2021 15:30:05 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s19sm48300pfh.168.2021.03.30.15.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 15:30:04 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20210329020028.18241-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <deedbe3f-0236-26fe-97ef-000c317687d8@acm.org>
Date:   Tue, 30 Mar 2021 15:30:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210329020028.18241-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/28/21 7:00 PM, Bart Van Assche wrote:
> This patch series fixes the race between iterating over requests and
> freeing requests that has been reported by multiple different users over
> the past two years. Please consider this patch series for kernel v5.13.

Hi Christoph and Martin,

Since this patch series makes significant changes in the NVMe core and 
also in the SCSI core, your feedback would be appreciated.

Thanks,

Bart.
