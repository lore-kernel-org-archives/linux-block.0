Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB19DC433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 21:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B123161205
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 21:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhDGVzG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 17:55:06 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:39504 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbhDGVzF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 17:55:05 -0400
Received: by mail-pg1-f169.google.com with SMTP id l76so14039005pga.6
        for <linux-block@vger.kernel.org>; Wed, 07 Apr 2021 14:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gHQF+n6puTnpDxt07iX+IaztncwFS/gobS9+DpvhRbk=;
        b=Rdr/SOSQiBrbLILPcyNMIJZ2l9FEfgPoCCNtXBYSoJigy471iZZ1opEoM8l0gJnp/V
         wQNP9UCG6yyXaZqo513ulPr3SW4onMy41dzDYGWxTrs8N9vkmqf08AfPY2pcGlltwiuo
         ImV0s700TIVCUvPmQ4G9wNThsOAy+QHCilVeAc33MSxA1EGao0DEdj+l69ngWKJX97gt
         F96foovO65DKddz0622VIKyuTRMvpHyL1pvZof9/9HFXduZR41IaKG0gwEAoXt9UcXqM
         IVXiFKYs8npqWs7q6h6TVNvtv5+MrKzlORdG2ayPHmWboyAK7u2etoOrEy8EGlBMGNNj
         zf9Q==
X-Gm-Message-State: AOAM532sB3uIc1m7PoOsEL+UD0MYsNqZSuxBvLaw8HUW9xH4zhnx4NhG
        NCGWzqpJaXh/ZWSGX+zmivc=
X-Google-Smtp-Source: ABdhPJwUh7VsLHURi2/A9Op8ZcrfMVAiLvmVO9mU9uQ2rk9LWrZxqmQFJBg67BPbGGzXrBzEYm3fWQ==
X-Received: by 2002:a63:1b10:: with SMTP id b16mr5131551pgb.308.1617832495477;
        Wed, 07 Apr 2021 14:54:55 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id w16sm5845704pfj.87.2021.04.07.14.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 14:54:54 -0700 (PDT)
Subject: Re: [PATCH v6 3/5] blk-mq: Fix races between iterating over requests
 and freeing requests
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-4-bvanassche@acm.org>
 <CACGdZYKALg4GiXza+hnhay=XbBif3v5fV7Q=AJNUE-imw=t2yQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a5566d91-a9e8-d22e-36f0-dd69b22bc73e@acm.org>
Date:   Wed, 7 Apr 2021 14:54:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACGdZYKALg4GiXza+hnhay=XbBif3v5fV7Q=AJNUE-imw=t2yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/21 5:02 PM, Khazhy Kumykov wrote:
> On Tue, Apr 6, 2021 at 2:49 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> +       /*
>> +        * The request 'rq' points at is protected by an RCU read lock until
>> +        * its queue pointer has been verified and by q_usage_count while the
>> +        * callback function is being invoked. an See also the
 >
> extra "an"?

Thanks for having reported this. I will fix this before I repost this 
patch series.

Bart.
