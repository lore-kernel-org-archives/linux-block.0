Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94950C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 15:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1C46101C
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 15:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbhIGPQP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:16:15 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:38414 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbhIGPQN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 11:16:13 -0400
Received: by mail-pj1-f42.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1729168pjc.3;
        Tue, 07 Sep 2021 08:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gsd2cdPywaCZVtygSGO4OtqLBtYoIbpYjnfPbYYEukA=;
        b=OW2Qxr1FwjbcJTXcs0OSRhCJ/LEx5L9QlivS0pSwUIdIMlPjtcGrFooSgIDDTmu5He
         VSo6ak+628gZqILyb4aFNw8R/eJcfzUej9fq/u4d83uHSZx4vxiqsBlUUpX0e+1LsSqG
         XnaPCGvYaMmKm9Dvv5tV5UQEv/EF+LC8KpSEGrqIPFE8qGOXNw/zHEPSEAaXtiEjbcjU
         NI893fb854bBVlpstRtfN4otuaJ7WRB+X/2vNcSxNGeZq8zWJbC9a0D9apbWll5KyJvZ
         MjvnhwiXnsmJazubpdrG8AALAlJuLhXzDI5zXfAlw/bcXO3G9om/6+MehIVI9thhNINY
         bjbw==
X-Gm-Message-State: AOAM5339LHKOj8IW3FZguAAZrWgSk1l5BNUWmE/EnKCm9pwr1Aqi3fGY
        3UluTlpi4gFr+yF6ebb+shrrGmd5Tx8=
X-Google-Smtp-Source: ABdhPJzdA2y7oMm+BK4o5ntxcvbaYPywCTgezZTwgpmYCixTVRcDeJ+talsGUPmpebtS+eP6/DGYjw==
X-Received: by 2002:a17:90b:120a:: with SMTP id gl10mr5102122pjb.234.1631027706589;
        Tue, 07 Sep 2021 08:15:06 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 15sm11209207pfu.192.2021.09.07.08.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 08:15:05 -0700 (PDT)
Subject: Re: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
To:     Niklas Cassel <Niklas.Cassel@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
 <20210907142145.112096-3-Niklas.Cassel@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fdd5ab2a-af90-69bd-2d37-c5060ce68de4@acm.org>
Date:   Tue, 7 Sep 2021 08:15:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907142145.112096-3-Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/21 7:21 AM, Niklas Cassel wrote:
> blk-mq will no longer call the I/O scheduler .finish_request() callback
> for requests that were never inserted to the I/O scheduler.

I do not agree. Even with patch 1/2 from this series applied, finish_request()
will still be called for requests inserted by blk_insert_cloned_request()
although these requests are never inserted to the I/O scheduler.

Bart.
