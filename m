Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9C2C433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 13:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE0D20B7C
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 13:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uxcY+HoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfHINlc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:41:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38756 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfHINlc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Aug 2019 09:41:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id z14so8661645pga.5
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2019 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hDbmSeAqM7CnABefrdoIV33EQwgfzsxS6CwWc2ozMxc=;
        b=uxcY+HoGpSPxU3WZM34vst9UCgKCvpWafX3qIo5agR9YilACC8L2UAmnDJsft2xWlO
         b07chohxzG7xDB3J+bqVaMoSrNljFZcSamWc9wW+uH9NiT+TA4SsQP0SWcbE28tHM18q
         mTwYKTOwdk+pUBUgpdGK/EFNza0fSDoIXyaZqjkdpT4EJZKVcnEyqtf/0ogGJ8b1WYnh
         3TrhBjACarraJTY0jKNBogI4gswvHw4aUqukhNA/+NdjDgM5YBCHb/Z0lxBjmFJOTwTK
         IvKidRrYHkitWYQfblSGRj+3MOR6AywPx/kgY9mxZa3glzSQfeGZZHHr2wvtoZ1z6Lpf
         vPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hDbmSeAqM7CnABefrdoIV33EQwgfzsxS6CwWc2ozMxc=;
        b=hmc0WeWJtPjLQ2404Ek74C1Zx3xZCiWIxoq+p37CtFQFOCg37JEPB5dknYjrzlSWgs
         ghlJeMs88ACgkhnBT+Pe8QmlZYbPjaXISRe8Hx9NY+9t+NZsIdlxIggwnSTGzMMCwgY6
         XLJhV2hdOC+Gn5iLjcVQU1qrcb71kY0m/HjI3YD7wXYfqkPy4ySm5PDQU02oGhAh5jvM
         bxXllLc3nzB+XTmBC27s51tBrNJxbIJxPRPvVMSaEQxEfAashsBkeFiWLIThGn2C/sH8
         EGjkH0pCgDpuDsO9HvBquodF6b1FlF8QdiOH31crzy+5pkDQ1iuTlzrHTWx8oBejlZ24
         Dbag==
X-Gm-Message-State: APjAAAUWFUTVhgmdvjF6V5ZWDxLmP585fQotjliMXTp18+/MLy0nWiSQ
        NJlUhdM4QsSoppo34MfpoQvgyA==
X-Google-Smtp-Source: APXvYqxy1N/BNXHHumn8ArufQ0S1e3+SjdYte+WSSnMyakBpI1Ibu103uf5GY4RSvgofZXfNb2fYxQ==
X-Received: by 2002:a62:b615:: with SMTP id j21mr20995178pff.190.1565358091327;
        Fri, 09 Aug 2019 06:41:31 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:80e5:933f:36b7:b13c? ([2605:e000:100e:83a1:80e5:933f:36b7:b13c])
        by smtp.gmail.com with ESMTPSA id 3sm104328974pfg.186.2019.08.09.06.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 06:41:30 -0700 (PDT)
Subject: Re: [PATCH] floppy: fix usercopy direction
To:     alex.popov@linux.com, Jann Horn <jannh@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr
References: <20190326220348.61172-1-jannh@google.com>
 <9ced7a06-5048-ad1a-3428-c8f943f7469c@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b324719d-4cb4-89c9-ed00-2e0cd85ee375@kernel.dk>
Date:   Fri, 9 Aug 2019 06:41:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9ced7a06-5048-ad1a-3428-c8f943f7469c@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/19 6:36 AM, Alexander Popov wrote:
> Hello everyone!
> 
> On 27.03.2019 1:03, Jann Horn wrote:
>> As sparse points out, these two copy_from_user() should actually be
>> copy_to_user().
> 
> I've spent some time on these bugs, but it turned out that they are already public.
> 
> I think Jann's patch is lost, it is not applied to the mainline.
> So I add a new floppy maintainer Denis Efremov to CC.

Looks like it got lost indeed, I will just apply this one directly for
5.4.

-- 
Jens Axboe

