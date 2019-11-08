Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0295AFC6195
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7813206C3
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 16:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfKHQ0m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:26:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38816 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHQ0m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 11:26:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id 15so4277904pgh.5;
        Fri, 08 Nov 2019 08:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AMGqQPW5u5MrdIldnP75x+wA0d9NwehFp+ze/wZzvWE=;
        b=MZIy55JuZUMqOJXENjfpPT6uUN8gBe+T8wBYH9CEx/KuPu38QK9xzb/r3PyaQG/o9B
         8XaZNfKyJDhR79x7QxptmzbOnl4A0kIr3ohFDjNk4jKPvQQpQI4M2vnbcTi1zuGcdswj
         8lAutcDyOEyrhrMqRQbvaKetyTcGuPZkF4aect/xIFJfXKiO2KSM95qnu1DphxKW1dGv
         QGkKWAMxuA9qJo7f5Cgjym5VLSK8qvtjxXKa4jhtnN4f8ZFPeVhJC0o/GCs2pqNQDxso
         YjhiNPpXr9gVXI1XOMLxNSih3VdeuRMucXB+T4TosFjHrs7qDCOoHSCgkuV5U6/OXqDF
         WIyA==
X-Gm-Message-State: APjAAAU0Ru5AeMd7VzDpwXP5OflQih7MnyfYIMpdCDMt5xEkbuSMxdBB
        r3JDRbdfWRh0m8NgvN9/asMGPZDnBPo=
X-Google-Smtp-Source: APXvYqyKmlJlSY+CASCaWKhKS5PL0Lv/x9h+stTx90jRkfLqj8LRoT0EDluBYwwIRUOqdaUYy29DJA==
X-Received: by 2002:a17:90a:9741:: with SMTP id i1mr14891484pjw.41.1573230401560;
        Fri, 08 Nov 2019 08:26:41 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p5sm5665161pgb.14.2019.11.08.08.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 08:26:40 -0800 (PST)
Subject: Re: [PATCH] block: drbd: remove a stay unlock in
 __drbd_send_protocol()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@tron.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20191107074847.GA11695@mwanda>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3a2d491f-3d24-3673-07f3-f601d5fafc97@acm.org>
Date:   Fri, 8 Nov 2019 08:26:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107074847.GA11695@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/19 11:48 PM, Dan Carpenter wrote:
> There are two callers of this function and they both unlock the mutex so
> this ends up being a double unlock.

Is there a typo in the patch subject (stay -> stray)?

Thanks,

Bart.
