Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79138C48BC2
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 02:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D89D613B3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 02:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFXCrZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 22:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXCrZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 22:47:25 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C92C061574
        for <linux-block@vger.kernel.org>; Wed, 23 Jun 2021 19:45:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o5so6072245iob.4
        for <linux-block@vger.kernel.org>; Wed, 23 Jun 2021 19:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/OSyVR61XD9Kg6s4o47sceyMyMjakKnzHrYWn8ryqTI=;
        b=0+IuKPSuw+qS9m/yGUXs7gxb7ZeFTP9ErCNyvDCfCtrYP6IemPRKWOG6Z3g3yl0lhp
         OvZ+OOfVGnyrIzbRNK7bCJaU+BM5YkJdqN0nIps8+N3upghnqprLMJIzd/XuUoF30Hzh
         4UpGirvQ9GHmOvHHhjbUWlJqRpLF20mL1yEyifU7g8Oc//2Vy78y/UInstLMgLQfAyv3
         lhlsNAcxCnkveVKCWicxTefUkHLV0hO5HRaWANBdDfvMyVkseivptxSAp8CZrS9++Pgl
         gWlGobEr1TaFOrNrGUceEog0nabwOAZhAfVLzdtd7pZxN7D9zuIi5/+TMuZlC9AHI2CR
         InPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/OSyVR61XD9Kg6s4o47sceyMyMjakKnzHrYWn8ryqTI=;
        b=LyDivT4eGpumtwh55AChjxyKnwUXUP0nMiyXPC+6BtRdVkfO8k24t0silzgY7gdOaJ
         JALj/b3zbQqTekZqQLUDmtCyhWVbHASNlhdS/U0wwVZzKRY8TTVSXxWweefvRQ4GK4rO
         0jNHwD0RZgDprx09FzHjz6260rWFSMhYlw6e6zgWBOfIl9DlxMqGYuU5Qb8rFD9ZLJT+
         I+I0dN0gwuSeRlznTp/mm65CF/bMUmxV7V0HzMROCbnoNRO9nhJxyus1RgOhfEyw3yv/
         IOYyIx+aVbS6sIbMBA20lcuYVSlJBSErwlrRDIjqeNajHM2IwbfzYWC/2oJGrayLLCxK
         2CVA==
X-Gm-Message-State: AOAM530x5uT6M8UNC+mWPiuB4fEG4ENo3/ZiWemTv/O/riJWogBGOEGP
        SNGfx4MxhPyucTBKtWf9KBomA0r3DBEgjg==
X-Google-Smtp-Source: ABdhPJytmyUELTPQbsNYU3SFs04l0n+65KHoSdlKe1Tt+aQBtWnIHNaPHzHQBteUv2dMsRYlq+j/nA==
X-Received: by 2002:a02:ba0d:: with SMTP id z13mr2577746jan.80.1624502706376;
        Wed, 23 Jun 2021 19:45:06 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id i26sm808719ila.85.2021.06.23.19.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 19:45:05 -0700 (PDT)
Subject: Re: loop cleanups v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
References: <20210623145908.92973-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <207a4fee-8c04-05df-3058-a5ec0e4538aa@kernel.dk>
Date:   Wed, 23 Jun 2021 20:45:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210623145908.92973-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/21 8:58 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series contains a bunch of cleanups for the loop driver,
> mostly related to probing and the control device.
> 
> Changes since v1:
>  - use local variables instead of dereferencing struct loop_device
>    outside loop_ctl_mutex

Applied, thanks.

-- 
Jens Axboe

