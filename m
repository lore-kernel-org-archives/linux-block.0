Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE81C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 16:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFB36135F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 16:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhHXQLQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhHXQLJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 12:11:09 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861C8C061757
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 09:10:25 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id v16so21047228ilo.10
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jz4ywF+79Oe0j4aT+Vh+DJbIEjsB0djbeRIU067fgU4=;
        b=XC1clyhgwxkHzrR2433uTlXB+xjqmhH2fafV88LaKrZGRJ9VoE8lgReci81JetOn4r
         1HjVLYfM7KL+kD/tkSldSlm2xDVwoTrc2XIUbwUIGGThQSAL2cPt3FIW7uKq0Nhp5hsh
         abHx7PUqLeHuoC9ofMONtWBq5ugWRFxVYNAjpJCFX8EZ1BZv0Aik7fqTFO+2q+6arRAw
         t7lf0MOeWshwlSbDZoQq9DSxSICg0660Vanf3zbtWI6jo9+EXUbHmvC5IrmgcELKchJy
         B7e5/jNg7rOl6s2AhKWgIMvcvp8UC5ET4OvxvHV+h2A4/yG6PfuhJpE6tTHWjKEWVqyw
         SeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jz4ywF+79Oe0j4aT+Vh+DJbIEjsB0djbeRIU067fgU4=;
        b=DYI4xqj8PUOAGjrjR2lVFT88NLEgjH8lT67hPUWToYJqGBc5mU5OC3j9uJD1LKzApi
         M4a64St1vebmVGOy30WRVrbO/yCSWyzq/AyPhwRCYEoIcNTYE+prR3Ypw5QCM5ACU4bg
         X08bTpJ4irn7OaCMSHlcMMM1qOXhOW2fl+tsmHlsLCKb6L/rpKnwLMwt+kjlIZsbLP3x
         FqVKeNMNmmcGAGhue+HsX96HxBXGZlR8R6gUJSqB7YaXNazBAWsv7Rgk05mm8WpDZ2nw
         LzeyCdZBhUR6ix1PZEvKz8HLBklZGzhTD8EpNTjK8v3msOFE7mQb47Ixbvv59OzxhjaW
         D4Vg==
X-Gm-Message-State: AOAM530yIFtKkF7DDwWmcdP9kOyp2nU21sZTzoGlzOtSuCq96VSo9apO
        fA4O/EItqOrS/6FEsgMKdafqgA==
X-Google-Smtp-Source: ABdhPJws9cQWwnGMgUoIJO/L8Kl/TrFDt3/d1UFkhuR1kZ137xI+ulZvXttQflFYpJA6xQShyBY0OQ==
X-Received: by 2002:a05:6e02:1d08:: with SMTP id i8mr28080920ila.185.1629821424999;
        Tue, 24 Aug 2021 09:10:24 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m26sm10471414ioj.54.2021.08.24.09.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:10:24 -0700 (PDT)
Subject: Re: [PATCH] block: refine the disk_live check in del_gendisk
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Bruno Goncalves <bgoncalv@redhat.com>
References: <20210824144310.1487816-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <789fb904-0137-1343-ffcc-529f42dc36ee@kernel.dk>
Date:   Tue, 24 Aug 2021 10:10:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210824144310.1487816-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/21 8:43 AM, Christoph Hellwig wrote:
> hidden gendisks will never be marked live.

Applied, thanks.

-- 
Jens Axboe

