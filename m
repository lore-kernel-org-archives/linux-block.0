Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ECAC433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B872923A33
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 17:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgLKQet (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 11:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgLKQeg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 11:34:36 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC06C0613CF
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 08:33:55 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id d9so10070928iob.6
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 08:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FAw6hXoyT6uM9vzPmYIpKukJwESiYRXuzPIlQPsLuXA=;
        b=GgmBkl44Ns0gn6fknyLrsvDLce3lNfA8/ZC1mXAsFWrphIf18X2YFWw+jfWGedUrD0
         fcf5KOopk5B7ysjly8U/Vo9AD+OiBji8WXC+UiPRhtP/RXzH/bsz+QvIaM8aABYHpax6
         +0xKwSz463HwLAERIZROHqMt9W+1jDX7L7ofGx2ajd/iOypqt/QpiE0FmsWleAiZC/qf
         Y8jE7kcIt56n+wVzQa1KrIuWdkXQ29P/lCOheovVXjiXRG1blgtm9MqT1S4AexDNMVU4
         Da2nvlUbduTWTMRx3aclzQhF3G0Hpz+SiFDWx9ZoI/D5JAFTTDN2SUE5zVNybuynlvcB
         CLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAw6hXoyT6uM9vzPmYIpKukJwESiYRXuzPIlQPsLuXA=;
        b=TT6XZWOSIisDkONJanZbNpcnqmPsquCEKQh4jG3gkqAgZFvJtUEm++fkdTo0g2wYSf
         Yt7zgUq/+YRyVUbOQ2Ms8oOvZtD6wXIKtxKfse1Y9ySMu3S3//CC8z9mmBIfySllQxZQ
         uz9VBxrBGCfkqH1I2dp1a2C9DknVBh6s1fLD9K57o83lf9I0G1WKSxGH/0HBXZA6cTNB
         iBwvc0d+J53YN2iKfktF3tUDh4DX2EQ90zz/8/Tv5zByTgzEDaF6iDkUwPZtmTRrC1BH
         7D/R8vlOC6kisOexFOGUPtQ4gOcxZMbAX6su8oJ7+RFQwv3rVA3lzdcmBU5r3gq0RVXY
         9UHQ==
X-Gm-Message-State: AOAM533yv4oB/mtGPtlWofhz++U5PMOWn277JgZej0T4rAHx8Ra5jmtX
        4rlOH1oZJYhD2DpZrsBwQckmqeWAJfsu0w==
X-Google-Smtp-Source: ABdhPJza4ydPg5ScWsbhL87xQLWUOu18OVel48dEocpMnw6mZJsUxBpB5MtgvueLlNUMfiiYS7gltg==
X-Received: by 2002:a6b:3788:: with SMTP id e130mr16099681ioa.23.1607704435255;
        Fri, 11 Dec 2020 08:33:55 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f2sm4657901iop.6.2020.12.11.08.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 08:33:54 -0800 (PST)
Subject: Re: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
To:     Mike Snitzer <snitzer@redhat.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>, hch@lst.de
Cc:     "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>, dm-devel@redhat.com
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
 <20201209135148.GA32720@redhat.com> <20201210145814.GA31521@veeam.com>
 <20201210163222.GB10239@redhat.com> <20201211163049.GC16168@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1ee7652e-b77f-6fa4-634c-ff6639037321@kernel.dk>
Date:   Fri, 11 Dec 2020 09:33:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211163049.GC16168@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/20 9:30 AM, Mike Snitzer wrote:
> While I still think there needs to be a proper _upstream_ consumer of
> blk_interposer as a condition of it going in.. I'll let others make the
> call.

That's an unequivocal rule.

> As such, I'll defer to Jens, Christoph and others on whether your
> minimalist blk_interposer hook is acceptable in the near-term.

I don't think so, we don't do short term bandaids just to plan on
ripping that out when the real functionality is there. IMHO, the dm
approach is the way to go - it provides exactly the functionality that
is needed in an appropriate way, instead of hacking some "interposer"
into the core block layer.

-- 
Jens Axboe

