Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7860C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 12:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F31160F58
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 12:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbhHYMqp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 08:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhHYMqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 08:46:45 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714C0C061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 05:45:59 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b7so30667425iob.4
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 05:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=781JtqPtA8gBK7xnZpcx46eoM4H/fGrNaRnX7QWrU2k=;
        b=TEJebKwZT44LeKovxzie9othmn/mzKbvweFxz5A7s93pZPNWZ1egL764L4Yqo7NR5f
         t+9Ev96xmw3yhyUxddU80Sfp1uLcv9k9t2CMoivBU/rza9bhGL29zK7W8R9mubeuJfaZ
         0ElQyBuDHHEH31C196Cokx5HqqOa7QlLK/Gy+Jy2r7tZhE8+r00hpkbcamYus7z1VpCP
         74LBRqRh8ycvoE2j1sx09AO3iEUE5UcY7Vga0xElanoDTvC2/acxbLjSnGWPIweoAmJ3
         X3vO3U/ZsmK0PrRMPbsoJGwoAcNpMYFy9W9+ETeRXkqeW1HyyAnCrb1bkThp37yoKZHW
         obrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=781JtqPtA8gBK7xnZpcx46eoM4H/fGrNaRnX7QWrU2k=;
        b=hOvdeqzNkX7V8VLmhkW3A2Q/vekNMEC+Gka2zFzz5tVcmudDM+SVbsWDdH2TRNlRAM
         K4+0uGxXuCTDpjUMs8wxIBeScvwnK0A2HeqC587b+Hqf8vVz4lYoMQmDRIdL4fJwilqi
         BCLvnCKDK+xZfMUul0iVFiYO5psRQM2bIoAypGSXgA1XPs8kvGWZP6XKGQ4qErDR5VHr
         nJM5p8PoctV/Mr4O5Lz2agEaOCwLUGF0PerwowCNfMIgB4WyTdkuBu/SAluTwMTXTVRo
         +80+W3rAL7S/1JPbBUVYNI9G/i84atP/DbTS4GwRZz+63JR2dtU/pPD3Clianos/fgge
         DpPg==
X-Gm-Message-State: AOAM530DBPvUdM8OjaubYOToUVCDPUBhi9a0qfqTMIdCeSF4tcd49J/P
        4kZkIxs4O+RR46NTJQtQy3Q9zA==
X-Google-Smtp-Source: ABdhPJzg1a6h1EQvkTx2aq7YatE1szl3PQtsYL8DbKALfLwOuZp/5c8fL0lvMEEQXgEIvbzJTQsJyQ==
X-Received: by 2002:a02:5bc5:: with SMTP id g188mr40194238jab.136.1629895558915;
        Wed, 25 Aug 2021 05:45:58 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id p7sm11453565iln.70.2021.08.25.05.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 05:45:58 -0700 (PDT)
Subject: Re: [PATCH] block, bfq: cleanup the repeated declaration
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-block@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>
References: <1629872391-46399-1-git-send-email-zhangshaokun@hisilicon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5bf6872d-c93e-2d18-12b7-2fbc9cc0d0e4@kernel.dk>
Date:   Wed, 25 Aug 2021 06:45:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1629872391-46399-1-git-send-email-zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/21 12:19 AM, Shaokun Zhang wrote:
> Function 'bfq_entity_to_bfqq' is declared twice, so remove the
> repeated declaration and blank line.

Applied, thanks.

-- 
Jens Axboe

