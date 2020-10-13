Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDB7C433DF
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 19:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2225D20EDD
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 19:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fSdqfqAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgJMTKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJMTKS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 15:10:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10124C0613D0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 12:10:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hk7so525688pjb.2
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jjOlaevdD5EBB4BEBIqa31B4mlsOxUYhYJQrpicyV2E=;
        b=fSdqfqAWh1dsmWAGRygvcfFX2trIxK9N3ny8qQc2mgjCjpOWgBhMEYuBmK3aAa+g/J
         rchUGzr4gejlUR10HBEEIoS9XnAPtGG/5KYp9bW7zqFbBYHNvgoL56acRcpG0uDn2+T7
         fPUyWwcrHzzOcYi8mQGA8xGirrv9y9e9ns1IXIMHNkvjyQQzthogYr5mR69YB2GUfa5j
         1xXm4Rzqvu11s/CF8YvvS4/uxARZcEU4Fqxssg9tiPzMI/gps8TcwpBlOt2lAs4ST0n+
         f0/boZxmno7xcbP0xDd+L9EVhEjmRBcNm9C4OYxa6Me4TkUPsolj5VNCXlIol5H+uoc3
         thow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jjOlaevdD5EBB4BEBIqa31B4mlsOxUYhYJQrpicyV2E=;
        b=BZE2ZaLAvHwT7v27acSEkT6aZk5YpZJT0S+BEUuvY40gUsQODZQReI69docb/yk6rn
         6cusutlr2ZoXglLCBXLj7n3T12nJ4M2R86OZ+PTYwbBhoMVMqCtIhblwQ/GoDKImLkIG
         vQ2+0EOUedKjegpdgTPL6/piMFZ+B+M4luvWtIRq509dtDI2Q9o7WFHxGMlH6ys5LFI9
         nbTqKX4491y1opflAwMil0WqFUiJlcxhqhjXeNEBPokoyH3gstN41ofyUHwqKYkr0/AE
         hKKAi9ZTgIXzvahFO/6jZviiBG3qj8gsZE6NpXAoPTIOuISzD3GiJ5vWsg+3iNhv2YBZ
         3+CQ==
X-Gm-Message-State: AOAM5327IFCGBshEbFyZnCSo2b7zjfqOLOLaaTlNC7Gma4Vjg6+JXsvj
        a7104dLlhYW2U5mO1pMJBpcdAQ==
X-Google-Smtp-Source: ABdhPJww6pT6H4/8ewZFNPXWbwEtpqnDl622Hjj1aHVDVykYe45drGGyd8YnFH1bHZBqKB7mzItgHA==
X-Received: by 2002:a17:90b:1a89:: with SMTP id ng9mr1198669pjb.24.1602616216369;
        Tue, 13 Oct 2020 12:10:16 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g9sm369399pgm.79.2020.10.13.12.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 12:10:15 -0700 (PDT)
Subject: Re: [PATCH for-next 0/3] misc fix and cleanup for rnbd
To:     Jack Wang <jinpu.wang@cloud.ionos.com>, linux-block@vger.kernel.org
Cc:     hch@infradead.org, bvanassche@acm.org, danil.kipnis@cloud.ionos.com
References: <20201013103050.33269-1-jinpu.wang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <58de108d-7372-c712-9ad9-b45e2233c2d3@kernel.dk>
Date:   Tue, 13 Oct 2020 13:10:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013103050.33269-1-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/20 4:30 AM, Jack Wang wrote:
> Hi Jens,
> 
> Please consider to include following changes to upstream. 
> 
> The first one is just a resend, Gioh sent it 2 weeks ago, it got ignored
> somehow.
> 
> The second one is just a small clean up.
> 
> The third one is a small bugfix.

Applied, thanks.

-- 
Jens Axboe

