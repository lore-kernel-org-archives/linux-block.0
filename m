Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E318CC47255
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 21:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF54B218AC
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 21:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgEHVfj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 17:35:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35392 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHVfi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 17:35:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id t11so1454962pgg.2;
        Fri, 08 May 2020 14:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLhU08i9MqQAxt45X5E12IP3TxcGwzE1Yesl7vr4uv4=;
        b=FpzAvSD8gGSbuZ4p7oC0tCwX/CgQR9FGVerL9oYFiCG+PInfUHgaB4wljzgNAIV0A9
         cRoq+US7xLAlKCF3Dpwr/fXvtsAQuiv96g1mNpTT+Qr1rey334nK6X/Y3PRbH4AqsDGT
         kZ0lWU90lCg2Zi5V5V5AzGlFckcTkEopAzlVcFiTZ8YKXr+tNx+SwqEmggZ59W7sgIWc
         sKNcETx41mMNJplas/56MCZyYyI8Sws5y27HEaUd0Mneef+795Gsd22wbbhgwPTdXWun
         SL7NZyVOR2+g6w/SuAbN5UYHQQdhNjS6dmJgcL4Fn1vxt+BgPJSlgSXTXpe7Y3tF+Vwh
         h4Nw==
X-Gm-Message-State: AGi0PubY1DbDYRA8dt4ur5cp9OVGKRE8N02TJ/1sWrDUxLOk2WEIC5+8
        ndVRmO8irQDG4MydZMkcqws8PBEk
X-Google-Smtp-Source: APiQypLEj2OIJrlXfBfTSIsW2YdaKHpfeAeclRYJaWWjPDFHCxQ6C0r3tfdDBiffb6lLP5qMzlcNMw==
X-Received: by 2002:a65:6208:: with SMTP id d8mr3717609pgv.225.1588973737710;
        Fri, 08 May 2020 14:35:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bc73:49fb:3114:443? ([2601:647:4802:9070:bc73:49fb:3114:443])
        by smtp.gmail.com with ESMTPSA id y13sm2739507pfc.78.2020.05.08.14.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 14:35:37 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch
 processing
To:     Christoph Hellwig <hch@infradead.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Cc:     axboe@kernel.dk, ulf.hansson@linaro.org, adrian.hunter@intel.com,
        arnd@arndb.de, linus.walleij@linaro.org, paolo.valente@linaro.org,
        ming.lei@redhat.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1587888520.git.baolin.wang7@gmail.com>
 <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
 <20200427154645.GA1201@infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
Date:   Fri, 8 May 2020 14:35:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427154645.GA1201@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index f389d7c724bd..6a20f8e8eb85 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -391,6 +391,7 @@ struct blk_mq_ops {
>>   enum {
>>   	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
>>   	BLK_MQ_F_TAG_SHARED	= 1 << 1,
>> +	BLK_MQ_F_FORCE_COMMIT_RQS = 1 << 3,
> 
> Maybe BLK_MQ_F_ALWAYS_COMMIT might be a better name?  Also this
> flag (just like the existing ones..) could really use a comment
> explaining it.

Would it make sense to elevate this flag to a request_queue flag
(QUEUE_FLAG_ALWAYS_COMMIT)?

I'm thinking of a possibility that an I/O scheduler may be used
to activate this functionality rather than having the driver set
it necessarily...
