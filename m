Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD277C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 12:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7EE60F23
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 12:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhJMMZ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:25:28 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39867 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhJMMZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 08:25:27 -0400
Received: by mail-wr1-f46.google.com with SMTP id r18so7743267wrg.6
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 05:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8HqoT6QO2zaRfcgy0j9QTM+ExP2pCgdEYCJfJSGrEgQ=;
        b=ifVuT/GYCR/Htp8n0bMgsIHLz7RkSDr8pxmKWdrUXBkTBnbwDK7nE3Pfvk4vr601aK
         xaLimGSnApb0swWWS1guCm+GdH/bzAyZ4uH+uB8Yamu/fhaQDWAj1LskrhJraXvAeJfS
         rGbpfAW+oC9WyMpfYC6MdFybLRUktsqo2Ub1tZSTYcDd2huu6OuzakGwVlUGHzwYB2k4
         3a2bx9xqrIXESLHrLsi0W5k/LGQqaaTx2sgFu+JVN7k2Rt9GWI++/8qvAAG0T+KuosS3
         1E7vsHZ4TKsyGKG4AiRF71VMZ32jkXnJToA39s0fz93imCpkzqA90Jff/9EtU3dewS79
         KkVQ==
X-Gm-Message-State: AOAM530upb1/2kcbNUDQ401ov90zobm6eCWsPPyR3fOyQRmDJEn0Cifx
        zSad+hrpWWMIFbhmWo5YFUY=
X-Google-Smtp-Source: ABdhPJyBpMzV8+iJPFvo+cKhdx4EU43xBBccsWlSa5HU4f9PjYqzyb/xbNHZwe+BbpwcuGNQxb4PbQ==
X-Received: by 2002:adf:bd91:: with SMTP id l17mr39598282wrh.261.1634127803106;
        Wed, 13 Oct 2021 05:23:23 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t3sm5031647wmj.33.2021.10.13.05.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 05:23:22 -0700 (PDT)
Subject: Re: [PATCH V3 4/6] nvme: paring quiesce/unquiesce
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-5-ming.lei@redhat.com>
 <20211012103620.GB29640@lst.de> <YWWjXN3GEzypVFZ/@T590>
 <20211012150741.GA20571@lst.de> <YWWnEvX2uT4mUDpE@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <37e70e26-7ae7-2ed9-abaa-7242444b659e@grimberg.me>
Date:   Wed, 13 Oct 2021 15:23:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWWnEvX2uT4mUDpE@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> There are lots of unbalanced usage in nvme, such as
>>>
>>> 1) nvme pci:
>>>
>>> - nvme_dev_disable() can be called more than one times before starting
>>> reset, so multiple nvme_stop_queues() vs. single nvme_start_queues().
>>>
>>> 2) Forcibly unquiesce queues in nvme_kill_queues() even though queues
>>> are never quiesced, and similar usage can be seen in tcp/fc/rdma too
>>>
>>> Once the quiesce and unquiesce are run from difference context, it becomes
>>> not easy to audit if the two is done in pair.
>>
>> Yes, but I'm not sure a magic flag is really the solution here.
>> I think we need to work on our state machine here so that this is less
>> of a mess.
> 
> Frankly speaking, I am not sure you can clean the whole mess in short time.
> 
> At least the approach of using the flag is clean and correct, and it can
> be reverted quite easily if you finally cleaned it.

I agree.

The assumption today is that quiesce/unquiesce are stateless in the
sense that they don't need to be paired.

At least for fabrics, the state-machine should be sufficient to
serialize the setup/teardown, but if we break the above assumption
we will need to remember if we are setting up after a reset (which
quiesced) or if we are setting up the controller for the first time
(or we artificially quiesce the queues in the first time as well).

As Ming pointed out, pci changes are more involved with non-trivial
scenarios.
