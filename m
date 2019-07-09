Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06681C73C46
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 13:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A47214AF
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 13:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfGINvv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:51:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43273 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGINvv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 09:51:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so9327626pfg.10
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2019 06:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3IgSjAndKBaL5yNV0LHiVtAxGsoydE+aRc6pMYRyyZ8=;
        b=mMcT279V7/UMNzdt3NCDIhNKda+AT0CehQ9hVk0RzPIkYYC1wFIjPpQPsAnCj/MgLg
         rTQDWEU36j8n8YZO2Bqg1BLTcDupfJfIB/ic8ilprXCHxzGLvq33lgj69904iXMZLPbO
         B7MjFFPqHDNsjFqMCiZtpbpF5jxPPp3eJJN8T+58lkWRqkHcpOA3o3kgQLRQKN87QiWO
         ncve9YICm8OeDqUtjgUVmE6OmV09Mu/wXICksSHwOjvQAgobh2yBW3jeDPx6ns5wJ3nD
         i98P1GSQzUDZFfIQ61agmbeNfs7ACqox6C4D5A33/xni2U8+FJ+6Q3G8vjQ5uYrSm0J0
         NA0w==
X-Gm-Message-State: APjAAAVU8LQheCr+Dm4D6zne0l5RZ9czu9hKoaNltQ0PkWEQ8vvzRaGl
        j81mc4EYvDU5E5fUSe03+DDYcDTS
X-Google-Smtp-Source: APXvYqz4GUJ3WKb81FoOeQ49/MfN1jTXD+EnfafXbdVxUhn6SlfZZBUqXiccPQXfC6Fpg+/D6q5LdQ==
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr31197433pgs.439.1562680310177;
        Tue, 09 Jul 2019 06:51:50 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:b5e7:ffc0:231b:2d76])
        by smtp.gmail.com with ESMTPSA id c5sm16482756pgq.80.2019.07.09.06.51.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 06:51:49 -0700 (PDT)
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f5beffea-f856-c076-e2bd-0cf5fe2b0383@acm.org>
Date:   Tue, 9 Jul 2019 06:51:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709090219.8784-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/9/19 2:02 AM, Damien Le Moal wrote:
> Simultaneously writing to a sequential zone of a zoned block device
> from multiple contexts requires mutual exclusion for BIO issuing to
> ensure that writes happen sequentially. However, even for a well
> behaved user correctly implementing such synchronization, BIO plugging
> may interfere and result in BIOs from the different contextx to be
> reordered if plugging is done outside of the mutual exclusion section,
> e.g. the plug was started by a function higher in the call chain than
> the function issuing BIOs.
> 
>        Context A                           Context B
> 
>     | blk_start_plug()
>     | ...
>     | seq_write_zone()
>       | mutex_lock(zone)
>       | submit_bio(bio-0)
>       | submit_bio(bio-1)
>       | mutex_unlock(zone)
>       | return
>     | ------------------------------> | seq_write_zone()
>    				       | mutex_lock(zone)
> 				       | submit_bio(bio-2)
> 				       | mutex_unlock(zone)
>     | <------------------------------ |
>     | blk_finish_plug()
> 
> In the above example, despite the mutex synchronization resulting in the
> correct BIO issuing order 0, 1, 2, context A BIOs 0 and 1 end up being
> issued after BIO 2 when the plug is released with blk_finish_plug().
> 
> To fix this problem, introduce the internal helper function
> blk_mq_plug() to access the current context plug, return the current
> plug only if the target device is not a zoned block device or if the
> BIO to be plugged not a write operation. Otherwise, ignore the plug and
> return NULL, resulting is all writes to zoned block device to never be
> plugged.

Are there classes of zoned devices for which the plug list is useful? If 
so, have you considered any other approaches, e.g. one plug list per 
request queue instead of one plug list per task in case of zoned devices?

Thanks,

Bart.
