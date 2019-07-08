Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BC4C606CF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312792166E
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 21:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PNZTFdhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405353AbfGHV0r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:26:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37375 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfGHV0r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 17:26:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so5607276plr.4
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2019 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gmg5R3DJNxPKlWBjKN45gPlSPRDQQrmHqt4ghDQ7srA=;
        b=PNZTFdhC76Fq7B/wgTFZuOIgCuztZHaKfroBEvHPyUx6WdzQ03y1VPoGTUqhCoQmYl
         /SlgdtzHs9TTwssiCOUzVrJkJwFM9oo+wHIEGDur2myVh7UGHSCcTKzZpc4PWyhoG1B3
         MWH7R1M0ZGQhEh1gD6V4uBM8+m2kzLnF43zhF+rd2JvKdpqIgWC41dRr0fW/luz9pb3E
         lPoJ/O06UL40kbiwTXCtSfVYNaaBh5xbrRmEuGwc/A/B5uvln+J8OYMKQvqKCnqEPGnq
         jvrx2f9l1Cc69B66Mdaf9oQOr/QKOW/5YQjU8dGAw4VNRC/Ue7eQUr9sx63Qvdwepnw2
         i/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gmg5R3DJNxPKlWBjKN45gPlSPRDQQrmHqt4ghDQ7srA=;
        b=KGyUiX7To6WmDXduLyjjnlhOeAr6DuTCiJWJeeo+a7HNMHySJjXlHbDM/ePiSGdd0q
         SJ8n7apDmmY/dwVrQOz5OXAyeh9hFmCvf2KdWLUgvggcWnmPG+YTdpPEo8wjpDghEwt4
         5TOGqABIFWE+ztkR6iQZVQRb3mG5mZL+IOIN7eJc8UF6xkOjpDMDWHRk4HYw5HMRhRIu
         Zfy581SDjJuzEQAYYawbTf0N/BfFTMxTo7viY1gYTZN6NKT5QKNKCKnzfa6tsTG5qhHQ
         9eSLQs/5Dzjff3VjdLOTogn75cpGqZklVxlI5/093JQGCMfCsuKBmXImChgM1QN4xmfa
         B/cQ==
X-Gm-Message-State: APjAAAV90z1kch9MSqyPQl6ndgwaJu21ZTxrLxsECwYQBnovNxEBRuIH
        /URT5gDl5OJpuotRqqGoN65ftyUzHESMuA==
X-Google-Smtp-Source: APXvYqy+KOaL9ODJgGOMfP0JNVOcXWH2CbqjG1Ez+VtTrdWyHRoNLEKh2Y6fXRgZAdGFvdhhzt5uGw==
X-Received: by 2002:a17:902:3225:: with SMTP id y34mr26871532plb.135.1562621206499;
        Mon, 08 Jul 2019 14:26:46 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1134::10d5? ([2620:10d:c090:180::1:5742])
        by smtp.gmail.com with ESMTPSA id c130sm18092335pfc.184.2019.07.08.14.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 14:26:45 -0700 (PDT)
Subject: Re: [PATCH liburing 0/4] Optimize i386 memory barriers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
References: <20190708195750.223103-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf94c9a6-322b-80f0-4b7a-cf88ee13db9f@kernel.dk>
Date:   Mon, 8 Jul 2019 15:26:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708195750.223103-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/19 1:57 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> The four patches in this series optimize i386 memory barriers and fix
> the 32-bit liburing build. Please consider these patches for the
> official liburing repository.

Looks good, thanks Bart. Applied.

-- 
Jens Axboe

