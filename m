Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8516C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 17:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA29161529
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 17:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhHWRSI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:18:08 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:41640 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhHWRQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 13:16:24 -0400
Received: by mail-pg1-f181.google.com with SMTP id k24so17260327pgh.8
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 10:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WPemYiCYn7BzeOZ1Y9w+OvOzw5jDPYf1KiS1iuFI2cQ=;
        b=UXlk8a3LQITr3jKugoc+ZCc96zeISsxbxY1rnsnD143CxAVbrQl9odV577f9oh5Cuq
         A3W93FznE2lz+Bovfjn+DwinEJ1AuP1oJX9+56TuxrXz6qyrEPguGjt5bN8NH5GysYIs
         yVIhkZyJwZ/PQMpGFyKWcW/29OHaK2dj/LDPz3wIfedEBNbtx7oBHV1FUhXIB7uMTJ77
         tgc7j+vkra4JO6Qxbwwopaxz4Jh2A1enstvH5g2PWseu5xwtNC94JwCltd71xV9qnp2V
         Zd2O9ionbofFDVQEtywKWSLSl2OkAyY3KsNSS+2/FeDFad6xgfNsV3ifKaFeHHxHdzKg
         mMXA==
X-Gm-Message-State: AOAM5302pUl+io8s57t5ZdK1JsTo36Nby7u9sYJgnOUhkdOkDXdryo0Y
        hBzbP67yBrlKkxjQ+LULEHA=
X-Google-Smtp-Source: ABdhPJw6mtTyvgeobpG3TB68oUzGUvAAwWZTK1roe500OgVnhWowYl7KzA8u+7shqIFEKN4FKrJ2pQ==
X-Received: by 2002:a63:5641:: with SMTP id g1mr33212363pgm.33.1629738941125;
        Mon, 23 Aug 2021 10:15:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e98a:ca44:7012:ad8e])
        by smtp.gmail.com with ESMTPSA id 31sm19110831pgy.26.2021.08.23.10.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 10:15:40 -0700 (PDT)
Subject: Re: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority
 requests
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-17-bvanassche@acm.org> <YR77J/aE6sWZ6Els@x1-carbon>
 <5aa99b39-c342-abd4-00a4-dc0fbfac96aa@acm.org> <YSA1JWt9soMSs23Z@x1-carbon>
 <e94f62c4-a329-398d-5003-d369506d7f89@acm.org> <YSNQAu9uXrmEteXc@x1-carbon>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b6131780-8b67-8efb-a942-e40b68df082e@acm.org>
Date:   Mon, 23 Aug 2021 10:15:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YSNQAu9uXrmEteXc@x1-carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/23/21 12:36 AM, Niklas Cassel wrote:
> I was mainly thinking that it should be possible to do a generic fix,
> such that we eventually won't need a similar fix as yours in all the
> different I/O schedulers.

Coming up with a generic fix would be great but I have not yet found an 
elegant approach ...

Another question is what the impact is of scheduler bypass on zoned 
block devices? Is the zone locking performed by the mq-deadline 
scheduler for writes to zoned block devices compatible with I/O 
scheduler bypass?

> However, it does not apply on top of Torvalds master or Jens's for-next
> branch because they both have reverted your cgroup support patch.
> 
> If you rebase your fix and send it out, I will be happy to send out
> a Reviewed-by/Tested-by.

I will rebase, retest and resend my patch.

Thanks,

Bart.
