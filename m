Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8049BC4332F
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 13:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJLNQ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJLNQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 09:16:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D90DC4DA3
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 06:16:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y191so1057118pfb.2
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qChp3gqwNKY4UYmJTk12Nqs4USSc/p3MjTW1nFT/Rao=;
        b=8KedyDzcJWSdTSKEB8GfpHhT0MKWMtWdSs2B5Fv0wHOfZHlW2Ko01iRZ6SHy7jOBZw
         Jih9lswX6MHymL5tBS8KLs6oH54ZcKwaeWPsfrh2WPp4+NKMKmz72Dtmp7h6tRpSFLkN
         1qV1P5O65A3qpbgTm77c3iLDtGzRTsqJbjzRcJ+EwT0WOWNhVjzaDFY1Z5akH3htws99
         rqMYieI/cwjVf9t+wEmnegeBqt36yG5kv+Mx4TF5ffrbA0yccbtqkszGqjIv7S6VOJss
         amxMKrsbryoBaiEeVRp+engyODtODsye4QLq/EeqQ+4tpUGpiOuxUREMJtIHnag9Q7tr
         M5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qChp3gqwNKY4UYmJTk12Nqs4USSc/p3MjTW1nFT/Rao=;
        b=Aj+3p+l8hKMmxJxO4NjwEqnUK2dRG5Nip4qK+Byql2jxGlqEt6IcjP37F0ktFUFTxC
         r+D0Z2lk2BAjoCrIXmb1/1Clv0rp1aNuznlWuFnjHUaHA17Mkj86Kl1HVplnGWrY83GJ
         Dx6vnIFoPYS6Pt3IoyyTruLCdE0OtjreUc80U6TnrKd0zkvSUt8uA8fTdQH6GruIMceJ
         RHvCoMgtCc5cvrDClMaD9jO5/5tq+dIOEoFPHhfJx0te0/o3dCjBdkYnvwzZWMG97W3i
         7haxfeZquj+VTtiElvxtaNQMBxTcQ/s59WQ3T0aCpe1eLJFFYIazUYE4x05YzBnn9pe3
         4eAw==
X-Gm-Message-State: ACrzQf3Q6mQFsmgxboK6+SN1qMh3ux+5w6u0xXxY9e2cqqvvlxGGgJy3
        fNz0kD20p3wMTLZRuCAhzsF61GelHmd/MrRv
X-Google-Smtp-Source: AMsMyM4N0HekE1X0X8yhc92JPelO7xJzaeG4Mz2OJV9qfgQQJEinQ9fOlm4kkwwl4jxyF4sexexd4Q==
X-Received: by 2002:a63:5811:0:b0:43c:9d3d:700a with SMTP id m17-20020a635811000000b0043c9d3d700amr26209264pgb.419.1665580612732;
        Wed, 12 Oct 2022 06:16:52 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y2-20020aa79e02000000b005604c1a0fbcsm11129149pfq.74.2022.10.12.06.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:16:52 -0700 (PDT)
Message-ID: <71234c8e-9a6e-ac13-ce3b-618cc8bd5a2b@kernel.dk>
Date:   Wed, 12 Oct 2022 07:16:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [GIT PULL] nvme fixes for Linux 6.1
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <Y0aoYSBCx2Wrw74I@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y0aoYSBCx2Wrw74I@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/22 5:43 AM, Christoph Hellwig wrote:
> The following changes since commit 24a403340d70aad3667b3ee0f9a7aa5c0a5193a0:
> 
>   Merge branch 'for-6.1/block' into block-6.1 (2022-10-10 11:26:40 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-12

Pulled, thanks.

-- 
Jens Axboe


