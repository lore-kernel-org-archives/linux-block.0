Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC92CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 14:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533CD21925
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 14:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="G4kvwCHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408668AbfJROCa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:02:30 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:42797 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393984AbfJROC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 10:02:29 -0400
Received: by mail-pf1-f181.google.com with SMTP id q12so3956617pff.9
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2019 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NGjNwJ3PzCerpzbdNxY1kpAupfmBlrM6RYVOMxk2ac4=;
        b=G4kvwCHBRzpYuAcAAqNdmHCcNUPA9NQc88SC5szKDz6S1Y3sfEbVAfU2G7U9PUrQI4
         MPHzrULvsrDZqOhU9oPXQXIVEBUw1up/PNdTaMD5JNOEE3xHIAS/fM7hOEHrCY6xRPss
         G+ukb02aN4N8yKWp/j5cUwJzo9i5dN9yLkLbuIEz099klqdDdCHjdzlcsPZ4tx/JjyxK
         8QxGSR0U/g2C0QPRDM3mCTSwC+QJAX2xN2HpVNVSqczDcId8ggCZ+rG2ttN//wif4XGA
         8ChiPZw0+GZZcBfdHOR1BVsE/daFwTY4H6DRB5FpriYQeVjooh53b5EfUVY34nIHynp2
         RdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NGjNwJ3PzCerpzbdNxY1kpAupfmBlrM6RYVOMxk2ac4=;
        b=OagZ/hyqSI0AG4TGJaLUC2g3KCOLf9L6hGO4ax2HyjGx9cyAwUALRLx/RTou6sdhCw
         R1N4zY1E32Kq0y0jA4ebpqwg0z1JzR6KHkpRyrE6myzGkGCvJcgNN092Aec+fSjHs0a6
         Skhc2HLm2de2NBdduOgEfkb+U05vtxXH8jHrG5IbO4mORxwHjMxIM4cCgP+0A1cxe6iT
         9VgoFnHHE8jjcgO8YtORgwm35kvc+qUZH7vWiBUnQxEsqNCr9p9UEI44gKT4MjOSXUNM
         R1CjcyCqTi537efhcTe/rZKuuREsrCCw3RpYkyffOhL/fwQHjtlpdFSR5YOj5Vql6Bir
         lOgg==
X-Gm-Message-State: APjAAAVvs5pXGWOIsKJofe2fKEAZG0Ec630QgqVJN4mSqDifdiKl00jC
        ly6UsAQY2x4p3sC2ylhWTIXx7H2s1UxE/A==
X-Google-Smtp-Source: APXvYqxuWL1O5IoGH8FqUgF6lOjKpFfkmDo9ZIR94ofWHgaUp/2fayKOubjV2Zgg886deFAf1ZlrBg==
X-Received: by 2002:a17:90a:db4a:: with SMTP id u10mr11467037pjx.30.1571407348341;
        Fri, 18 Oct 2019 07:02:28 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id p9sm6378836pfn.115.2019.10.18.07.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 07:02:27 -0700 (PDT)
Subject: Re: [RFC v3] io_uring: add set of tracing events
To:     Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     linux-block@vger.kernel.org
References: <20191015170201.27131-1-9erthalion6@gmail.com>
 <af0fc0a7-11cc-08e6-cdfd-6b55fc208c8f@kernel.dk>
 <CA+q6zcXjun0Vk8HLwyh7GHq=Qkm2V9OvSFQpGupQN+LDUSNfXQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7c4af03e-4a03-ad85-08f1-121a65401a79@kernel.dk>
Date:   Fri, 18 Oct 2019 08:02:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+q6zcXjun0Vk8HLwyh7GHq=Qkm2V9OvSFQpGupQN+LDUSNfXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/19 2:59 AM, Dmitry Dolgov wrote:
>> On Fri, Oct 18, 2019 at 1:28 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Looks good to me, I've applied it for some testing. Thanks!
> 
> Thank you!

Already saved me some time in verifying some activity, so well worth it!

-- 
Jens Axboe

