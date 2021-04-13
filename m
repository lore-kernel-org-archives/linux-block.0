Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F7EC433ED
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 17:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E804613B6
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 17:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhDMRZw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 13:25:52 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45650 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhDMRZv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 13:25:51 -0400
Received: by mail-oi1-f169.google.com with SMTP id d12so17706538oiw.12
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BgrCAWpW2o88Vtnd2CagojNmuFnqNaFy+lKXDG4OMi4=;
        b=Q2dnPKR34uEm7YfIVI7fSAIlldjEZ9KWjYSKyXLSr386wAR7uhs3vm/ECms02S9d8H
         Pk6BbsH1x/jjx8bqMjSQb1rB/3XOyQ4KPv0st2QEGyxv+ylJudxJqGVBNv1pALHuJ17r
         i4MFSzpQeWrT7iowNcQ/ak2azmDOMFviR7olaBleCyAIIlYXYcgjJ1X1U/OVkwLQdub2
         PFzjl9ikYFyPxEhhpExw9D02E9hGGokAT5iim15gL+6SpmS3/yMJ9v5fbxx5A6eOuCWL
         vsxccBYScfhnWsto9BRXWmpQ0wVaOOlC7DpYJtS1mZWzhhFh71dDiAHWV+NaI4Hg1EOT
         8rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BgrCAWpW2o88Vtnd2CagojNmuFnqNaFy+lKXDG4OMi4=;
        b=PQ8UvzgOb66HbxnByuH8IGO9233utp9bIpXay8vY/q/bbH+mw70295JGl4vREezm33
         1uZek8sySedAZu3r8z2Bz+z3TrjMpKMJkfJ+36jDfPhimxPunlTvGUI1YXvU+b3Jz5lR
         yJ2Mlb5lFQ3VcU8ho6G8STTIxpZ7E8ZfA5zEpZZr+F9S0DFG9EvCVWPFB3Jmx2wx+ABw
         LH83SWGVgCbVP+J7mEAkmOHaE/mxEFxPYIwzRJnGXKMXrsR7c6TZ7SIJL1hwwcNcqxE0
         NMbBbXK1bYkFwhXcHxR6ER2xKonC67i6saYSfF1ZSBV+i9MD9FzRerkO6zH/Vi7dhsMb
         4CzA==
X-Gm-Message-State: AOAM5317sm2VRdiUxFxJZzwELv7RWx4z4SFiLsoTy718s2CekPY7c3zo
        wBy8sG/cKham6R9RbOBF4ppn+Q==
X-Google-Smtp-Source: ABdhPJzL1/FOOAe64rlWZYMLQ7tUA4Ck1d44RmG/vHk+J0jwSN1i5FwuFPRSmIsvYrqrvH3Ip5SHAA==
X-Received: by 2002:aca:a844:: with SMTP id r65mr764817oie.168.1618334670962;
        Tue, 13 Apr 2021 10:24:30 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id h25sm1279307oou.44.2021.04.13.10.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 10:24:30 -0700 (PDT)
Subject: Re: [PATCH] block: Remove an obsolete comment from sg_io()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20210413034142.23460-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba793618-b305-04ce-b88d-aaf0ea7a2093@kernel.dk>
Date:   Tue, 13 Apr 2021 11:24:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210413034142.23460-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/21 9:41 PM, Bart Van Assche wrote:
> Commit b7819b925918 ("block: remove the blk_execute_rq return value")
> changed the return type of blk_execute_rq() from int into void. That
> change made a comment in sg_io() obsolete. Hence remove that comment.

Thanks, applied.

-- 
Jens Axboe

