Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7C4C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 00:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E257523A02
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 00:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgLHAff (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLHAfe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 19:35:34 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3715C061749
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 16:34:48 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 131so12123378pfb.9
        for <linux-block@vger.kernel.org>; Mon, 07 Dec 2020 16:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4QCHLS3U7zqDnpTaPBuJz4uQUsnBczg1hiUP0MYvmv0=;
        b=YlQ/uxa4hPd8zGY9N0j32P6wOWn1Vw1lOutEi8Ct+S7EsvBAdQVVBFcA3u5HhNdWn0
         0rwmP0p71waYk35MhAClcsB46ob0xkW4hHfFf58cw+PQshyrsNLCJwhy6tMKt/31B56p
         4EIypaip4yccNWgxM3hfOO1nFVPaamCX5CHIXYDM/OqTE/SkjFtoRBugU1rFBVEpby4j
         pHovMEYfZ4XWbYrKjN9czC0kHhXnQ3EXF2ChVFqlZzyOlxwKrHOOynnJNcy1SPcV4qVh
         L1eLjqvvu6bdFMijFHMLUzaz2x3iQ0oSKKrM8eE4/Bi73aTbMCqy4Ymw+b2vf/Kbb4Dw
         KKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4QCHLS3U7zqDnpTaPBuJz4uQUsnBczg1hiUP0MYvmv0=;
        b=G8U/6I3iLYKr8Y/GG57QZ1681C2sem1lsi/FHf8mJYsKb8JihkZx9DM95Gg3ZawkIm
         nAFBs9BuB71L0Lu5/fnewebmsh+0re9Yd4+huIA3jiPeOqChOX6mpxL+wm/dPGap/GKD
         5QwyBLKbWGXmuB9Dah5Sg5fqcdcRVm2yqLDXlA14hKkHeJWum9+owmyqyOqFo4bm2mPH
         BFKwDqKbvRf5C3SBbVWr+oN4e23xlLVW01mJ10zeAzZ7dzxBSY6xmZ/rqxb5eqIvUb5f
         IgrWrY3AdOpdJZtbVxDozZSxGFmx6ikyXIo+PcJLS2UmwS3TWaSS/THT+PnNreAQLxCw
         Vx+w==
X-Gm-Message-State: AOAM530yY/oT9b/gqRjDhwsGPcXPQt8gDU2VvvXEcsR+xPDceSSjMcjb
        ASsLEZaDzbBW0KW75I2yTEzJqDJxNh4QYQ==
X-Google-Smtp-Source: ABdhPJzVia/AGSz277pBeDNDpZZDIehz2foyIYSujvaJi5KLf6Zl7/TP8eziGPuoGYwvvHJxFXUqEA==
X-Received: by 2002:a17:90a:e38d:: with SMTP id b13mr1350352pjz.101.1607387688151;
        Mon, 07 Dec 2020 16:34:48 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id o11sm558909pjs.36.2020.12.07.16.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 16:34:47 -0800 (PST)
Subject: Re: [PATCH v2] block: Improve blk_revalidate_disk_zones() checks
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20201111073606.767757-1-damien.lemoal@wdc.com>
 <CH2PR04MB65223742BEE5687703584A55E7CD0@CH2PR04MB6522.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eafc156a-765c-4b7d-0726-8ab67be36b36@kernel.dk>
Date:   Mon, 7 Dec 2020 17:34:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CH2PR04MB65223742BEE5687703584A55E7CD0@CH2PR04MB6522.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/20 5:29 PM, Damien Le Moal wrote:
> On 2020/11/11 16:36, Damien Le Moal wrote:
>> Improves the checks on the zones of a zoned block device done in
>> blk_revalidate_disk_zones() by making sure that the device report_zones
>> method did report at least one zone and that the zones reported exactly
>> cover the entire disk capacity, that is, that there are no missing zones
>> at the end of the disk sector range.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> 
> Jens,
> 
> Ping ?

Picked up, thanks.

-- 
Jens Axboe

