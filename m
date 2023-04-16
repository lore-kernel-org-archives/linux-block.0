Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D5CC77B73
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 19:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjDPTCE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDPTCE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 15:02:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90052D5F
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 12:01:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b781c9787so535955b3a.1
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681671717; x=1684263717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQnLneubTQKygZhAprLS2uYmB/CVGauNdS62uMCTFbA=;
        b=RBDJu1G/IFi5TcbFsn8XDzqMOpTlPsbHw92o/RyVjCk1dMm4jpfiw9fq/+30TCQKoE
         WhHH0tDhlrIDKqwCPVKioTpPiwsrnib1e7kL8hJxyET+UX6eRtm74WYyXFcfAavzlXtS
         Z6G1wwyUDF8whoLMXm9Yl8E11CXXkKMYViMZuM4Y6rVj0yUnDBoxpq+wX0KAcDm34JLW
         UOC9XFX3VqDBbn3kaN4aX9qKJ0om4JgErPNDdx4xOC3YNj3VsbzpUEP/Pgb0e0ed4+Z5
         MEV38hRoGqOYe+viEFP/R3xIKqZpVgP7vKpGkNLAApYl6B3NDO6o3AG5UoWV98mWzgKw
         STUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681671717; x=1684263717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQnLneubTQKygZhAprLS2uYmB/CVGauNdS62uMCTFbA=;
        b=UnN3xwtvuTP+tLL2104Z/RyNs7V1lnPC38pHTVsOcFefzt7855tHN6p5fn1MYYvaAu
         bGGCYkjtIQT7L7/Jm6MT9D76LOTk/+IVtaHTqtTDKbG249l2SV77r0B8QMdxMf6z0uCy
         4HNb/TA0AYfEJwOM5V2TrK+umjCNuJyPa0VHJZlZReH6W2Hpy1aFWMtJvdP5aWZOuMV1
         liB1kU/UDW4z384n2CVqlTZPAByBYRdi9voUazeUFsVxnadwvc/0qk2Im/buTNhiJgNk
         N04qM7UxIrP7mcjo1+3mE7NVg5GXx5g5AaC64vLTVEU3sexH0C0VFbar2FQ8iiIwOihR
         gkrA==
X-Gm-Message-State: AAQBX9eDJZpZVIJ+uRI7OxFxea5ReoT0CPehkqnlj2x9NsUll4+yl62l
        SACr2/M/qEajJAs069eSdVajHg==
X-Google-Smtp-Source: AKy350aDnK+6/pHMJQzxyjsy6UcYft1GVbtKKK09R95eA9UNZrlk7ilKuTTJgnd9MxSgmviYA8E9/Q==
X-Received: by 2002:a17:90a:1cc:b0:245:eb4c:3df8 with SMTP id 12-20020a17090a01cc00b00245eb4c3df8mr8301142pjd.2.1681671717099;
        Sun, 16 Apr 2023 12:01:57 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090ac90200b00246b7b8b43asm5619891pjt.49.2023.04.16.12.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 12:01:56 -0700 (PDT)
Message-ID: <7a319f9f-d5de-3094-6492-1c8077b5a0b5@kernel.dk>
Date:   Sun, 16 Apr 2023 13:01:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] block: re-arrange the struct block_device fields for
 better layout
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20230414134848.91563-1-axboe@kernel.dk>
 <20230414134848.91563-2-axboe@kernel.dk> <ZDuM8+1VuBbxXiJN@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZDuM8+1VuBbxXiJN@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/23 11:51 PM, Christoph Hellwig wrote:
> On Fri, Apr 14, 2023 at 07:48:47AM -0600, Jens Axboe wrote:
>> This moves struct device out-of-line as it's just used at open/close
>> time, so we can keep some of the commonly used fields closer together.
>> On a standard setup, it also reduces the size from 864 bytes to 848
>> bytes. Yes, struct device is a pig...
> 
> Maybe add a comment about keeping struct device last and why?

Sure, done.

-- 
Jens Axboe


