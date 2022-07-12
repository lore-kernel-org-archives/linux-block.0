Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E1DC43334
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 19:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiGLTyb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 15:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbiGLTyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 15:54:13 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF68CE0
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 12:52:43 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so12951326pjo.3
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 12:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dv/VTAFxi/L4YgwDeRx8dYSf4XrQApITKQiNJinKgqA=;
        b=hM4ma4C2XZ5T+rLQO487RXaPVcrLuYnePmxG9nfxedd16RHk9uzQFO2Whm7CMTZweg
         qPXmVnTYSATzHu41O+KhANykQWhpX0WEaKTVZ0X/WcuyDZCDcC+EG1iKWK9GtPr890WP
         zwMMGH7clIxyvXXp3emYq2bB+JRg8j1Kwh0f/b2z0ck3jF4BwGNZPOHQWb9/VEbUk5pa
         c35x18uKwABEG7VfMyLh3m5dStOU1iIGdraw8598TMJT5So2+x7kBIramdkEmmTwIN2m
         HOMb//yVFU09+G2jgkKzJHMzRbIHViq0Ucy9oBp3JDPEcrtZdCkwaWZA2V8Q1xjoyjcV
         hqNg==
X-Gm-Message-State: AJIora+upBEIKqvLqAVbA58SZt/Z1c7LVp17kBtpdjt4dhaMGS5yCIqD
        u0ND+Jw1oSk8Zdr/IDV5Z3E=
X-Google-Smtp-Source: AGRyM1vdlMZV6hld+V2guoYwDXSTpSC4f7xfi3c8LAEpCisSKz7lCbyRWlsgaRJkGcGWXUvuI/t0eA==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr6222284pjb.164.1657655563392;
        Tue, 12 Jul 2022 12:52:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:de3c:137c:f4d2:d291? ([2620:15c:211:201:de3c:137c:f4d2:d291])
        by smtp.gmail.com with ESMTPSA id w19-20020a63af13000000b0041562fd3c13sm6511082pge.4.2022.07.12.12.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 12:52:42 -0700 (PDT)
Message-ID: <3240717a-bec8-0681-1c78-c2b06a2346f3@acm.org>
Date:   Tue, 12 Jul 2022 12:52:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] blk-mq: don't create hctx debugfs dir until
 q->debugfs_dir is created
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
References: <20220711090808.259682-1-ming.lei@redhat.com>
 <4c5f332f-ccd4-5d0e-14d4-bccf57bcd7cc@acm.org> <YszTg0GAQrOa96UX@T590>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YszTg0GAQrOa96UX@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/22 18:50, Ming Lei wrote:
> On Mon, Jul 11, 2022 at 10:20:39AM -0700, Bart Van Assche wrote:
>> Does this patch need a Fixes: tag?
> 
> Yeah,
> 
> Fixes: 6cfc0081b046 ("blk-mq: no need to check return value of debugfs_create functions")
> 
>>
>> Additionally, as one can see here, I reported this bug before Yi:
>> https://bugzilla.kernel.org/show_bug.cgi?id=216191
> 
> Sorry for missing your report, and I am fine to add your reported-by.

Hi Ming,

Since this patch is already in Jens' tree I will let Jens decide how to proceed.

Thanks,

Bart.
