Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6F1C5DF60
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 15:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BF2214B2
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 15:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pgk5y4oB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfKEP3l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:29:41 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45447 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfKEP3k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 10:29:40 -0500
Received: by mail-il1-f194.google.com with SMTP id o18so6397953ils.12
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2019 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bMfkTndicZvsLEyzZaEXVCrwa2BE+VWwBG3hP1BWuOs=;
        b=pgk5y4oBZHs2d1KFBU6G0wGBlJ/bD17jpObkyqMnHOOgEcN2+e602oRzcjEI3ryzqv
         9Fq5kx02PRxyFRAT8AW4IlZK8C/Llh3PKl43UGNemMxGcq0E8ras7aR2tr2yTPTE8WrX
         Ch1erHto4JIZYeluAzordDGF+gOU4MGDxDoQaUZO9ULJrT3mPhvqEF/am8/dvgcUOxbd
         9/uUlk6Vj45zmrF+caq+plGqGmh25HJ1KFTQqdwMLIwey2Flt4Qyg7XL2kRHh1bWKs0X
         +VuEZPXBGQ85c+khDBI64l20NMcpG7cBgaVDFxgTW1+hvumLoDn7W4QOsCFcfuGWGMfk
         tENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bMfkTndicZvsLEyzZaEXVCrwa2BE+VWwBG3hP1BWuOs=;
        b=dRpn5qEDqEaDLs5ZdFJjUexfrrXfiJYwhaUqYMs9Db44xhceoIIymTnVw91XOOSl+n
         qtCX9J2AbyehynhKBJ2/LpB4AiVL8LaiPaEG8aNaho89tJG0ybi4cDw82CoLzh5TooG/
         ZSH/WqcNSn3orZIJbnAcHMt521JSB5VUQhdbMscS3UUyVc3mT6QpYDi8bRGXueuV8D/Z
         trWdqwicCnNbVqGjTqyqtxWBldO6GrVwq+IveZKV4lmYP9dtBArKl72cdTDraMvIq7S1
         IbSu48Tvyo45ZfajzfgkTr3CsJsiOvFuZ449Aut9JgBbnZGQqAh+XqTi9hJW/OVbpN92
         n8cA==
X-Gm-Message-State: APjAAAVKeCCbQY+DuQrV1ckMnq0qiQ0OsozrxILHxAYm/S10k+QzKxkn
        Jm23XZMLbO3OEDsPFQSlKzAETQ==
X-Google-Smtp-Source: APXvYqyj+oNC9dyzuwLib1IKI2c10wgT8gq/O0GCQ1q+5cY6D94X8kglQchvGBjJ0FILSKHlSA3F5g==
X-Received: by 2002:a92:360b:: with SMTP id d11mr2220944ila.143.1572967779737;
        Tue, 05 Nov 2019 07:29:39 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k3sm3000595ilg.27.2019.11.05.07.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:29:39 -0800 (PST)
Subject: Re: [PATCH liburing v3 0/3] Fedora 31 RPM improvements
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Julia Suvorova <jusual@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
References: <20191105073917.62557-1-stefanha@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7e12e53f-4b7b-e0e8-6b9c-f291dcade8c6@kernel.dk>
Date:   Tue, 5 Nov 2019 08:29:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105073917.62557-1-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/5/19 12:39 AM, Stefan Hajnoczi wrote:
> v3:
>   * Remember to commit my changes ;-).  The changelog now contains user-visible
>     changes in 0.2 and the https git.kernel.dk URL.
> 
> v2:
>   * Wrap commit description to 72 characters
>   * Put user-visible changes into 0.2 RPM changelog
>   * Use https git.kernel.dk URL for tar.gz
> 
> Jeff Moyer and I have been working on RPMs for liburing.  This patch series
> contains fixes required to build Fedora 31 RPMs.
> 
> I have also tested on openSUSE Leap 15.1 to verify that these changes work on
> other rpm-based distros.

Thanks, applied!

-- 
Jens Axboe

