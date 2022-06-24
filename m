Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAAACCA473
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 16:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiFXQp6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiFXQp5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 12:45:57 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A55E4DF67
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 09:45:56 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id k7so2579948plg.7
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 09:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TXyNQiR0r+Nkz9pJoNGy6fr4zjeU+bEu6esEfUL2AZ8=;
        b=H116/TUAuq8WVGOm5SAiNTzR5MytVg82KLrrfpA7c9fjznugjKkVmHVhpprsXpwGf3
         CqdYdfbyF6kXccUptxJpKq9tgjbT+CGfgzOEB+pFWlJiDKmB6147B4PsTpkhs4rCD+dj
         cTLKGCZ5/UN3h/sL+H9IdQP+5Oo8dk1tXhcswemJnMPXtshx/+ZEs3teJc6yYtpcE14o
         0SeeW1nkCkO2iq/SyeHnPcnBOSsE6bHGl5k3P9uArKSyDdprgDQO78DdAcFVCUeq+P/5
         yl/PS9N8JP/H/R+qBPRfFt9w/JqjCg2AhU8AAZAE/HB7lr6xLrL2UHZncdLjzR1+cVcq
         L77w==
X-Gm-Message-State: AJIora/8V7WNLiiIiNdzt190/Wnr42WhFhktstrnts8FB14vPAwWyNqv
        aLuzO7DhOXemHOh3qx/ltAs=
X-Google-Smtp-Source: AGRyM1s6bhXhpbVWDPcfje+RWx2IsDTc8sLqS3tYyWkcoblICLTat3pSLIFaq7zWdh7QYcVFMyIcRw==
X-Received: by 2002:a17:902:f602:b0:16a:178a:7b0b with SMTP id n2-20020a170902f60200b0016a178a7b0bmr7247plg.20.1656089156008;
        Fri, 24 Jun 2022 09:45:56 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:85b2:5fa3:f71e:1b43? ([2620:15c:211:201:85b2:5fa3:f71e:1b43])
        by smtp.gmail.com with ESMTPSA id k63-20020a632442000000b003fd3a3db089sm1821109pgk.11.2022.06.24.09.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 09:45:55 -0700 (PDT)
Message-ID: <31602226-611f-223e-ddd3-0c8ab780cb0b@acm.org>
Date:   Fri, 24 Jun 2022 09:45:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 6/6] block/null_blk: Add support for pipelining zoned
 writes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220623232603.3751912-1-bvanassche@acm.org>
 <20220623232603.3751912-7-bvanassche@acm.org> <20220624060659.GA6494@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624060659.GA6494@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 23:06, Christoph Hellwig wrote:
> I don't think adding all the previous code just for null_blk is a good
> idea.  We need a real user of it first.

Hi Christoph,

Although these patches work fine in our tests with zoned UFS prototypes, 
these patches have been tested with a UFSHCI 3.0 controller. While the 
UFSHCI 4.0 standard supports multiple queues and while UFSHCI 4.0 
controllers process each queue in order, with UFSHCI 3.0 controllers 
submitting requests happens by writing into a 32-bit doorbell register, 
just like for AHCI controllers. So although our UFS tests pass it cannot 
be guaranteed for UFSHCI 3.0 controllers that requests are propagated to 
the UFS device in the same order these have been submitted to the 
controller.

I have not yet seen any UFSHCI 4.0 implementation. The upstream UFSHCI 
driver does not yet support it either.

Hence the choice to add support to the null_blk driver for setting the 
QUEUE_FLAG_PIPELINE_ZONED_WRITES flag.

Thanks,

Bart.
