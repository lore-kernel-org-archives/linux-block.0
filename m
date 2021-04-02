Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CF0C433ED
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 17:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC69E61151
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 17:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhDBRTa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 13:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbhDBRT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 13:19:29 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EE5C0613E6
        for <linux-block@vger.kernel.org>; Fri,  2 Apr 2021 10:19:27 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id x16so6015426iob.1
        for <linux-block@vger.kernel.org>; Fri, 02 Apr 2021 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=Hc6Kx7pZ+efXQ7hRh++gnGGX3Df+rt727QLUYlWlCNXhHkqUaaD2QUrPkka7LmQk8D
         YE3+Wv96+HUOrdrDXYLR5vxY+DO9B+qIeUphINenyf64qVKFIhJSmBNs7mjAivtaytt9
         ho5e5hAAMkaEZYzP63rOtWzx+41zX96PLnTHGPnU9CSjy2ExycqvIDCJznthntbEu4wC
         ytAYjqlgaAF5c1gY9lyYaxvOyQlp3iotImEqdHH9i2iOAm9WItTAU0lLboIwlMfeZJNa
         XZ8kYgWzzV2V9mUdsg/EcKKt6OcdS7fX8bzMBXCOAPqIzadQ8PjTJCyHdPknsykcKoLC
         maBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=g0g87IVyewe7RUMpIqS4yMeal8jb7IqBIdCKgYi0GjMHh+AlfKpA92upOhxkqUPRaB
         P6DxmVs3RUavIZ6Knne9Tny03LSRv5YfPZlmIIEcYu30ynu2xlkd9fEUhotF865zdFpD
         g5KnremhON5NzdDD3zMl99A+f46x665SSrpsN+QwQezXLBtbL3h6KtPCndqf/fblZhnT
         VpijGnl8s0CXKgWiE8nbe3mDwBLnZzQXN8rgkCTYVM7f16Q/WMFYwjfEwJNsPQdgXUIX
         ++s8FfrmV/tQw5HB1h/IJDEML1UgoL7ucF7bcfS+Rs4JdcjlAQskn0wZaSaDgcoEaPSK
         nGgg==
X-Gm-Message-State: AOAM533mgqgSDVw//TpsxYg+dnZrAPWDFSdzFVMXuk/QA7O0HE1NyWvc
        bKuO50Cd962Avg71VgUi8hwPnTDI67mdiQ==
X-Google-Smtp-Source: ABdhPJzJplwSJsZ39SOWMuv0CGcTczWpsTZ4ooLj5q/f8bdKMG2iRzDQsv1x8agL+oVHtIwrO15Fsg==
X-Received: by 2002:a02:6c8d:: with SMTP id w135mr13730666jab.125.1617383966369;
        Fri, 02 Apr 2021 10:19:26 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g26sm424966iom.14.2021.04.02.10.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 10:19:26 -0700 (PDT)
Subject: Re: [PATCH] block: remove the unused RQF_ALLOCED flag
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210402171746.389793-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3edc94d8-1310-00cf-c6ff-7d8098e91427@kernel.dk>
Date:   Fri, 2 Apr 2021 11:19:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210402171746.389793-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Applied, thanks.

-- 
Jens Axboe

