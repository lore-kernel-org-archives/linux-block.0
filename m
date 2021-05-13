Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29841C433ED
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0827D61408
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 17:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhEMRJL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 May 2021 13:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhEMRJI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 May 2021 13:09:08 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E107BC061574
        for <linux-block@vger.kernel.org>; Thu, 13 May 2021 10:07:57 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r5so23600805ilb.2
        for <linux-block@vger.kernel.org>; Thu, 13 May 2021 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+pz+B7Vh/yB30QaZtxQETJtp46lqx44quP0JA5mjmsk=;
        b=Eu7an7LTNDAg6J7yaF6AmYS/ChuinUpzm0/YvN7E62kNV0mesWTYs4UACch6GUEk/Q
         nqaLJUU3MWzUYOA+05V8X56KEN8lbegg0RVwmTULAelRyuncNqoKJhX8fXGeRoRYxm+9
         2iRr2Gdg3S/ekgA1ga7Q+wnLLqrC4VRFWt3wpf0A26azz3jj4ewmM0Ica5ksItZC3uvq
         PRdDOPTssCA9Mi2g4wr9UrBS9sWftZDTK6tUS2KsLbaLaOP8BPdiKqqrMiivEC9Rmf2x
         6/Hm2ucrmOTAe0XHLbl33B+62c8xrZTYprSVWDGmnlFtPi6iQ8/lhBoutemkAOySTyZh
         xEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+pz+B7Vh/yB30QaZtxQETJtp46lqx44quP0JA5mjmsk=;
        b=FjIwyOfDJs1jnnXo47EM+XLD7WSw6XVfTWczWeM5WpCu/vpQ9cFv6dkRDSqQJydoFl
         4/JEepldcX9+IGkWnI2L221HPOqX6SIarf6UtYPrWCvPXg17RErLDv85htRgPNkUE2ha
         h1Q1T2rOBep3TjTMQG36X1pPBcixniYO2niPmmSOqpvlALlpGPjLj79ioj8CYby5NRSr
         yMq0B7mEjTiwSUc2l6apgJFrDa432DdT+5l9bxdzhollWlC6TE3aNHlGXgWFg3BU7lTy
         ZYifgvTtmvo9SA2zpQNINJva5hOivfL3j/r2qsF09V9D446UD6yTnvVCRGAA3n3USkz9
         HjJg==
X-Gm-Message-State: AOAM532uglLW1ua1r1aLQVXkDTxD3Ac711N2aaDZlnQNHvuZXx6zFAoY
        TBNjrVYzX27Ut6++8uSOKdF89w==
X-Google-Smtp-Source: ABdhPJw1kIBMmytzxogqo7fn3kFHFilpUhMsaq9CV7g1YAtfFJl3KzQz6GEcWdSY2PHE5ncGfhkp/w==
X-Received: by 2002:a92:cc02:: with SMTP id s2mr36177651ilp.101.1620925676783;
        Thu, 13 May 2021 10:07:56 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u7sm1400392iof.41.2021.05.13.10.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 10:07:56 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.13
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YJ1b7OeZpoR3j13K@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a9528930-b123-af71-794b-55b2b9bfeba0@kernel.dk>
Date:   Thu, 13 May 2021 11:07:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJ1b7OeZpoR3j13K@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/21 11:03 AM, Christoph Hellwig wrote:
> The following changes since commit efed9a3337e341bd0989161b97453b52567bc59d:
> 
>   kyber: fix out of bounds access when preempted (2021-05-11 08:12:14 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-13

Pulled, thanks.

-- 
Jens Axboe

