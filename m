Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF05C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1180A21722
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="L6GRts/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1180A21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeK2AZ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:25:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39994 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeK2AZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:25:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so4815986plq.7
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fV+qzC0mYci8ZbgOemCAQeQX/kRkini3sOcdxNTIkRA=;
        b=L6GRts/HmNcHoOmvZkyyfeuWkhmFc4kGMT8MAwEk01O2oFXXNiq5kQehnUQxeckFl4
         Ai3wT9o/5y4s1ic2nDB57qRyvKDlPgazLDESim+FgU56vsHTyzCtg6wbYHmPQuzG9CiF
         z2JHTKjgwsTNOrlIc06ZU+ID2LMKl9hnzrVrXgDPsnlDj1To7wAf78WBPX7Gx+S8fc4x
         Lj3IlkPMH4D4fLhYUuD1fg5gDKJBHuLRHatylcRXwAack3uxYsJ4eNYrPurZ21AkN5cx
         sq/o4zoa9abR0E8kCnrKdY/8LoJ6yrzxZC62lr7zyR7Z3/tkVht+CIu9DZh5KDnLJTGA
         W8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fV+qzC0mYci8ZbgOemCAQeQX/kRkini3sOcdxNTIkRA=;
        b=PHutRZhNEAAJsbbN9fgZtKAaCcE3mGvsEu9L1D+pdy7tQ4ChG1hVXtaVIyHbmgk/L5
         qHDU91sB0QhAJW2fYXs64tc2IiKnH3VXmvQV8tRbtjhxdkICpwNsd3ITWIBWtXR68vPI
         tFFNWY7fmbEeUGaRr/xU2XaG/sIsMqMxe+6/S/u5au1pVDFwWrZUzeQ/tLVkOK2fM0uZ
         zeRRLuLsNcHQmeS212DHwGqGHNZeDLs0r8DKnmPEBFlcbpHCeg4vznMALwNjlO0uQKr5
         a/wfa4la7qd83GbcnIWtTP1OS/M2UeNTsCrXI14F4BqeZwTw2trG1pcGAPXwKbIxmA10
         kcGQ==
X-Gm-Message-State: AA+aEWY6itUkNwi6ryiVewhSlkkTAlojH1+KTUDO6oxXdyswvZQdsoRM
        +TfLgY7iW3ai9hOLDpv3OXRH21jQlbg=
X-Google-Smtp-Source: AFSGD/V/djOXxwdrrewwITCdV2nd1IWUIFsrjJwJ306cOtger448qcEwcB34zyNqNw0Ba0NCI9yt/Q==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9mr37616837plo.27.1543411427487;
        Wed, 28 Nov 2018 05:23:47 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id r6sm12618366pgk.91.2018.11.28.05.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:23:46 -0800 (PST)
Subject: Re: [PATCH] sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN
To:     Yang Xiao <YangX92@hotmail.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <HK0PR01MB21634739CFCEA8CB1AC08E45ADD10@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c693ebe-dfc4-b5fb-f8d5-28f93b05b77a@kernel.dk>
Date:   Wed, 28 Nov 2018 06:23:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <HK0PR01MB21634739CFCEA8CB1AC08E45ADD10@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 5:36 AM, Yang Xiao wrote:
> From: Young Xiao <YangX92@hotmail.com>
> 
> __vdc_tx_trigger should only loop on EAGAIN a finite
> number of times.
> 
> See commit adddc32d6fde ("sunvnet: Do not spin in an
> infinite loop when vio_ldc_send() returns EAGAIN") for detail.

Looks good to me, applied.

-- 
Jens Axboe

