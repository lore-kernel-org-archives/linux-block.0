Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BAAC433B4
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 21:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763CB613F1
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 21:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhDTVbI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:31:08 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:43562 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhDTVbI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 17:31:08 -0400
Received: by mail-pg1-f173.google.com with SMTP id p12so27680516pgj.10
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 14:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KqDkWV03fTVKEesJJ0k/pnnWitpGVVbxLDkFeHLPSio=;
        b=rScm/p9IlD5XtNLUFYhNv3jekP/ZkcMyfSOWKR+WcaKolPMCzs4DkJJFbftDdScLT1
         /RNNnGb5DVJiq3XFXnfLOLW9+tFwyibIRoNhzQZBwSHepsbwm8UpgtmYIXgU6Hvb5GlJ
         LVlwzCTwdFOUuQ44MUfdQVS1FhtzeqmkF4nlCInWOEUkSCxtyxTvUdxIjrHxN/8eYNjA
         q2Gyn6vUtifaVASRrAsk2+zWB/4LalhexTRbMnvokRJwIC4odb+3rWbYq6YXJzGThMcG
         opVM+1S5oJlyh5qGmAIgTIPbiOfg580PysDX2uUXm/TSbpvI48p3xN4hcsgAzOl5rUxt
         AidQ==
X-Gm-Message-State: AOAM531bgamZ/6sYEh6lIUVgvnHV4TrhZnrpEV1dm4tV9O5ri38JhNNI
        +CpAPDvWuqLvHO8ZP53d5xY=
X-Google-Smtp-Source: ABdhPJysFJUAwfva9j3aQWs8JeJ1QnfZqbHKk/ucL/XvtC0FGcIlZVIW78G9sTMfRCl+hKcPldaenQ==
X-Received: by 2002:a63:5562:: with SMTP id f34mr19075087pgm.391.1618954235868;
        Tue, 20 Apr 2021 14:30:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6cb:4566:9005:c2af? ([2601:647:4000:d7:6cb:4566:9005:c2af])
        by smtp.gmail.com with ESMTPSA id i9sm68286pjh.9.2021.04.20.14.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 14:30:34 -0700 (PDT)
Subject: Re: [PATCH v6 1/5] blk-mq: Move the elevator_exit() definition
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Khazhy Kumykov <khazhy@google.com>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-2-bvanassche@acm.org>
 <f5b4e317-b74d-9dc7-300b-cdadfcde794e@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <17e86b62-4a25-0256-acd9-de688be4fdd3@acm.org>
Date:   Tue, 20 Apr 2021 14:30:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <f5b4e317-b74d-9dc7-300b-cdadfcde794e@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/21 8:36 AM, John Garry wrote:
> To me, it seems odd that the double-underscore prefix symbol is public
> (__elevator_exit), while the companion symbol (elevator_exit) is private.
> 
> But it looks a sensible change to bring into the c file anyway.

Hi John,

Does the above reply count as a Reviewed-by?

Thanks,

Bart.

