Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4779C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 22:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A554D2075C
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 22:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wrTdGTH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfAIW3Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:29:24 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42624 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAIW3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 17:29:24 -0500
Received: by mail-io1-f66.google.com with SMTP id x6so7352404ioa.9
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 14:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s3ZwBACT0Tq0+gA03bLH4x2n7z8PHl7NorUcutl3JwM=;
        b=wrTdGTH0LfclxmnP83OJkfPoq/mccZApZ9n7BmIvZQTXggHPZZRcsrssYvTHWVfdSC
         sD7KLm/69TtUuisne18xDABDtsUNM9wmLAOUJd2CEs7+nlzNlckDrRqc/l736+RdAED1
         hSCUQI/EpBEfExlRWBtqJkq4I854JqN9Gf9N77j1hmancP5aZ/yk3FrETfeigbHuLokl
         Yz2Rd8c7Oinu/HlZ3rfTVwHUt8h8hqxpJyRButvvY6zlDVk1na2j/FwYAh1Ce/jXZx0J
         j8UAgsRb5jG8QQIdfiO+/YkpkwpwuFt4b901nnuilWmP1qOORcHm+VvotV1/TC7zv1p5
         Va7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s3ZwBACT0Tq0+gA03bLH4x2n7z8PHl7NorUcutl3JwM=;
        b=HWh1/4uwQdy0/4acFOFSy+0Wl0pZcL0B2Dl0hN0rEZKIl/d3pH9cperxXOV71t+HEY
         c+u2oau72a0IIqpGqXrzrTMp+5JdkjwXckDQrius34fYUU/z4Rg2Gh+i4w4x5SIhqt9a
         4jMZEpqXGX2MPmbdZpXAaNyCwaTSSwxsQD7Jge6yyAPO8ptXjf571hJu2sRBmURaHwwP
         Szd6015tzKdFHKiOJY/8UNT4Fn0VwOOv0YGwCU71BD3jfPJ1tqV0UGnAqld3UjiNRESm
         /iMjkD+T8TeeZENdeYvOae6MF5EDyPpTOpNO3rATFMUPSBEHKycNLQx0hdJD3TXGOf9c
         VMWw==
X-Gm-Message-State: AJcUukf+VyJaJs8c3oMllZ5DgUUTURP7Sz5G4VaOimCvyBe+4OKhTzjO
        5R4gyVk/2pMoIbwj3fJbMRJhH+S2peefxQ==
X-Google-Smtp-Source: ALg8bN5fdpGAgB61uCfWCx5/L03ZjlXgZ63DcbkSZEKmqME1HVEHN3EpaO9kikZE2GWTwgYxpRChhA==
X-Received: by 2002:a6b:d919:: with SMTP id r25mr5418492ioc.160.1547072962965;
        Wed, 09 Jan 2019 14:29:22 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n26sm12936463iob.30.2019.01.09.14.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 14:29:22 -0800 (PST)
Subject: Re: [PATCH] block: fix kerneldoc comment for blk_attempt_plug_merge()
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-block@vger.kernel.org
References: <20190109135932.7578d716@lwn.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b2d7a56-78ff-f120-967f-9df36c10ce73@kernel.dk>
Date:   Wed, 9 Jan 2019 15:29:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109135932.7578d716@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/19 1:59 PM, Jonathan Corbet wrote:
> Commit 5f0ed774ed29 ("block: sum requests in the plug structure") removed
> the request_count parameter from block_attempt_plug_merge(), but did not
> remove the associated kerneldoc comment, introducing this warning to the
> docs build:
> 
>   ./block/blk-core.c:685: warning: Excess function parameter 'request_count' description in 'blk_attempt_plug_merge'
> 
> Remove the obsolete description and make things a little quieter.

Applied, thanks Jon.

-- 
Jens Axboe

