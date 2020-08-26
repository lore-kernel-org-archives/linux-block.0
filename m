Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C7DC433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 16:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C692074A
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 16:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgHZQXd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:23:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40546 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHZQXc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 12:23:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id h12so1283007pgm.7
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2020 09:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J5a6w/9w4RkawRXUOLm1ecjXyqbvkSI9++BQYLBwAQQ=;
        b=nd70740K6Xjfbxwx4lXgVU79pJ3S0lm8rNcYG968thKanOIHAS95filhBPnulPsiLf
         hjpe5RevVXp+hZDF3Qo2+5nLnFOaqHWIDie0kpxZNuEAWvtZNqXwslDoJeQtY5qFsjts
         1PyDHTdTGNUrYjQd62EQi3SrH6WX6zRgjDjHCyM3JffxjtXFkWuw3zv98gRA8alL4w1e
         fe6EF3U1dnitS4QhnrZvr66O/876LGEWEQn4lS2ldE8VokjfbfM401k9fi8BEe97O/2N
         UzRKqwu4TYKgLSZc6whLkJiKSr6+vas0514bUJHE80PN1mHiu1jjx0iiH2X+3XA1TkT6
         fHJw==
X-Gm-Message-State: AOAM531FGlPcsjhJJYfhGEPkvVyZ4FuF+Z1H0+FPipqNWty2rLMP9KEI
        Y8F/XpEEoNZy+4ztxqyk8oc=
X-Google-Smtp-Source: ABdhPJz8Y0uxcbPerkle75+zi16HVzMtdb/Mm6NTnmJAtNQt2iesT8rzssJpIT3Okv2EpQvVH6szNg==
X-Received: by 2002:aa7:9799:: with SMTP id o25mr2479191pfp.109.1598459011901;
        Wed, 26 Aug 2020 09:23:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9f7:9743:3b73:57d2? ([2601:647:4802:9070:9f7:9743:3b73:57d2])
        by smtp.gmail.com with ESMTPSA id x13sm3600450pfr.69.2020.08.26.09.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 09:23:31 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] blk-mq: serialize queue quiesce and unquiesce by
 mutex
To:     Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc:     Chao Leng <lengchao@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20200825141734.115879-1-ming.lei@redhat.com>
 <20200825141734.115879-2-ming.lei@redhat.com>
 <751a63a2-9185-ba27-e84a-91b7cdd33ee7@huawei.com>
 <20200826085422.GB116347@T590>
 <20200826153633.GA2151118@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <58f5ea5b-d33a-eea7-0576-7bb3c4450ad6@grimberg.me>
Date:   Wed, 26 Aug 2020 09:23:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826153633.GA2151118@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> It doesn't matter. Because the reentry of quiesce&unquiesce queue is not
>>> safe, must be avoided by other mechanism. otherwise, exceptions may
>>> occur. Introduce mq_quiesce_lock looks saving possible synchronization
>>> waits, but it should not happen. If really happen, we need fix it.
>>
>> Sagi mentioned there may be nested queue quiesce, so I add .mq_quiesce_lock
>> to make this usage easy to support, meantime avoid percpu_ref warning
>> in such usage.
>>
>> Anyway, not see any problem with adding .mq_quiesce_lock, so I'd suggest to
>> move on with this way.
> 
> I'm not sure there really are any nested queue quiesce paths, but if
> there are, wouldn't we need to track the "depth" like how a queue freeze
> works?

We might need it when the async quiesce is implemented for this,
because then quiesce will only "start" and in a different context wait
for the quiesced event (where we may need to add wakeup for waiters).

This is why I want to see this with the async quiesce piece.
