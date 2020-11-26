Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20209C63798
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 03:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95D821741
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 03:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgKZDxf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 22:53:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44553 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgKZDxf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 22:53:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id t3so548882pgi.11
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2020 19:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ldTIy2CMGfYkBOWCGfd3sYGKZiM6s+iN2m8B8BP3BS8=;
        b=UNZvF/TK/vdBvHRmN5WEqgTPfo8d891D5pxJJkV6Jhn+nnM2yo5Pv7JRkWyWJV5Nv9
         hP7yTNXceO8StTIE/0HfBqJMAimm+IaASc0hsmuervaNRr9Wn1ZywxSvN7xwUvqBmhRZ
         SatmpuzsCEeKcmIld0LoiTjmYLQ2w9P/YUKPbVmyxhNzefRAUYJ5vGmXOf25EfEnQtpV
         IeAsydudV4yhK8R1mEvLZzVZ4uMi+UcqH79HDONYsArGNbcwRdGgWGax4cRtSJlV7yRt
         6AqYcK2o+ipl4egDvkzen0JNaox4Xw0R7pKUKSdUD3COpsuRBbQ5AYdHddDmqhvZkcC1
         edeQ==
X-Gm-Message-State: AOAM530T8/knbZgaPsspHhD8VXtnjssldbV14BBEqkVRfFZnVB9uZJjQ
        lXt0JqhzdPRYlGRNqGGY0GE=
X-Google-Smtp-Source: ABdhPJyLA8XaNr/oTGB+7Naxqoreg0cWy9hfHrFFYWJKW+OQl8EfKOp//2Tgn8Vd8XiU+o1q//rlpw==
X-Received: by 2002:a17:90b:19d2:: with SMTP id nm18mr1310355pjb.159.1606362814679;
        Wed, 25 Nov 2020 19:53:34 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id r14sm3242673pfc.121.2020.11.25.19.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 19:53:33 -0800 (PST)
Subject: Re: [PATCH V2 blktests 1/5] tests/srp/rc: update the ib_srpt module
 name
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201125073205.8788-1-yi.zhang@redhat.com>
 <20201125073205.8788-2-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <75116622-4d05-f889-e55c-f253e67988d6@acm.org>
Date:   Wed, 25 Nov 2020 19:53:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201125073205.8788-2-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/24/20 11:32 PM, Yi Zhang wrote:
> Fix the ib_srpt module insmod failure as the module in some distros are
> end with .xz, like bellow on fedora:
> /lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko.xz

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
