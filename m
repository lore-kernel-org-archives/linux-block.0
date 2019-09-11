Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD17C49ED6
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 22:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954622054F
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 22:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GYLoGeCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfIKWFU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:05:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40550 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfIKWFU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 18:05:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id y10so10756329pll.7
        for <linux-block@vger.kernel.org>; Wed, 11 Sep 2019 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PBR/ZqujBMyrRxXxfP7k8gbUqJWi1d6iXuppjK7dj3M=;
        b=GYLoGeCupwyTlVppEvlqpoCvKCs/Ne7NCKSlYhxpkkPmt9DzrgArr0jlhMrDxEiMv5
         K229oH24XDJu7zEkk5vWuUg8c5sKb/HT4/RkqQf0lwWeHPcbKgOvvI8iP2YKx9niTpp1
         mxQtPrcaMuYYzc2EFKaOdPtwP+lPDTfQSSp7PlWPR6wzAUkAxVy3EZxujMEOvupBIWEW
         /yZvCQJnYkh5Ht4PtbbiPvpwnvEvV/SBFo62TzOaQ2Hd+pyBwNmpESX8tlh85yoN7g32
         2zWJViSEOJjXRIPlXpB/NrKJ8yxK1hFm2lKG3wdcHANszoL9yBVXou3lI9byQKD92aEl
         /5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PBR/ZqujBMyrRxXxfP7k8gbUqJWi1d6iXuppjK7dj3M=;
        b=IxwMNdcgDrTSHZ1m+XwXNFKM7U3RO4jOYGh1yDS9+K/Y3PqqhMYvwyUlNOrJxgmH34
         qAFTc+hijZL9V4elKuYcR41GJE+czX+n+DwoWbQRvDtlWPf9NeGDmxEoLVP3ZQrfTt5l
         ovrgHmVz6JP6SOniFXWZiLCshnflPq6TyULvdEzw+zFXVms4N530eR7ROL7ZlEXE5xaV
         DNOCDBfilHjcvNn7lUCaEEVp8gJ2C0vqWPPxp1gMw8mbbma7oRvsOKtdBXmBNK/svVh/
         nDvaoi0/mGwbu36VqzvbiADfxwJ1tcXFQ8ys6q6Q8KVQL5WLMfw9vU8AQ7EMvTwb9hRu
         JLcg==
X-Gm-Message-State: APjAAAVPze5s0WGt0z8ALK2u49vvk/p/B5fLuildued6X6xxyeM3cFpa
        7pfzFpA8xSnJx7ifrJaq7J+pMQ==
X-Google-Smtp-Source: APXvYqwTYfnX9fTWWd4yn0IXL1esnJDVFrzwrPA2drnZMdglBBstDiOpsZCFmNJF792hkMXdBGwpWw==
X-Received: by 2002:a17:902:ba96:: with SMTP id k22mr21079978pls.219.1568239517941;
        Wed, 11 Sep 2019 15:05:17 -0700 (PDT)
Received: from [192.168.1.188] ([23.158.160.160])
        by smtp.gmail.com with ESMTPSA id f62sm28613723pfg.74.2019.09.11.15.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 15:05:16 -0700 (PDT)
Subject: Re: [PATCH 1/3] docs: block: null_blk: enhance document style
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, m@bjorling.me, kernel@collabora.com,
        krisman@collabora.com
References: <20190911144636.226945-1-andrealmeid@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2252d8d6-17e6-402b-9136-dc85e3cccbdd@kernel.dk>
Date:   Wed, 11 Sep 2019 16:05:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911144636.226945-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/19 8:46 AM, André Almeida wrote:
> Use proper ReST syntax for chapters. Add more information to enhance
> standardization in the file and to make the rendering more homogeneous.
> Add a SPDX identifier. Mark single-queue mode as deprecated.

Please use a cover letter for sending block patches if there's more
than one in the series.

I applied these, though rewrote the commit message for patch #3.

-- 
Jens Axboe

