Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956C3C433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 17:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354648AbiCYRHW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiCYRHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 13:07:21 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA767E6156
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 10:05:46 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id y6so6156029plg.2
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 10:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=kcqkC1uXRkuj4JXqG704WzGScpajYhdhW1K2pJhT0Dc=;
        b=tpMvXQQjTS8gRAFKY+D7LcWi+Z3FyzrHUFsHjFFWWfWHGjNwJ8WKL0XgoOnL6AB3nk
         vgHT2sfRQbJXY44+iWnoieZiaHYiGvQZLBINsMYSFxZEGxQWV9HDHLvffeZjsZD/ZLao
         vx0+jQxrtICuoYS1NLlhmFsfNkaGGvJ1EcLCf/F6COnBefWlEqBhd2ycRB506DbTCIVJ
         Gd+7FRsbqP6mGYlq8aTEXk1ut6fG2ot1siYs+kjbowt0v04dMCBrZwLxSe8HnC2GyzqS
         6GcLWab1ozvcK3CfFI8JOrdSUnY257v+UNNjIRlSOx1WEFqHN/x1j20t4RdxdkPvme3l
         irGw==
X-Gm-Message-State: AOAM533uWJTDx6MdXI8ngbp8rGjNXDLpeQYk6vwxzgApjR1j3gSgRw0x
        FaxTgIWBxBm3Xal0bGcaxU8=
X-Google-Smtp-Source: ABdhPJwyzfMGd74rU+Fe7mH98aMa7REAgm0UeapiYElgHr3w1/kRJJcEzmPOaHMyktYmFcGB+0uYaA==
X-Received: by 2002:a17:902:f607:b0:14c:d9cf:a463 with SMTP id n7-20020a170902f60700b0014cd9cfa463mr13345107plg.32.1648227946194;
        Fri, 25 Mar 2022 10:05:46 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5257:7a13:18f3:2907? ([2620:15c:211:201:5257:7a13:18f3:2907])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090a65c700b001b936b8abe0sm12735069pjs.7.2022.03.25.10.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 10:05:45 -0700 (PDT)
Message-ID: <180dc22b-4fee-93c2-9813-1b4f109b5dc7@acm.org>
Date:   Fri, 25 Mar 2022 10:05:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prioritize high-priority
 requests
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210927220328.1410161-1-bvanassche@acm.org>
 <20210927220328.1410161-5-bvanassche@acm.org>
 <Yj22kLrsw+z7sj7R@pengutronix.de>
Content-Language: en-US
In-Reply-To: <Yj22kLrsw+z7sj7R@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/22 05:33, Oleksij Rempel wrote:
> I have regression on iMX6 + USB storage device with this patch.
> After plugging USB Flash driver (in my case USB3 Intenso 32GB) and
> running mount /dev/sda1 /mnt, the command will never exit.
> 
> Reverting this patchs (322cff70d46) on top of v5.17 solves it for me.
> 
> How can I help you to debug this issue?

That is unexpected. Is there perhaps something special about the USB
stick for which the hang occurs, e.g. the queue depth it supports is
low? Can you please share the output of the following commands after
having inserted the USB stick that triggers the hang?

(cd /sys/class && grep -aH . scsi_host/*/can_queue scsi_device/*/device/{blacklist,inquiry,model,queue*,vendor}) | sort

Thanks,

Bart.

