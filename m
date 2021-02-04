Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326A5C433E6
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 14:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A1164F76
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 14:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhBDOkj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 09:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhBDOiJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 09:38:09 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06FC061573
        for <linux-block@vger.kernel.org>; Thu,  4 Feb 2021 06:37:26 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id f67so1608842ioa.1
        for <linux-block@vger.kernel.org>; Thu, 04 Feb 2021 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6WKbmgf+2ZIGCm/dE9FPQFIm79eTOH6MS53KyM+dR2s=;
        b=r4vyQkjzXvpYLOKwhE/8h97tN0TZDkJogkAAj7FoT87Id3rGALm6nbbQG6UxEbx9po
         On5BqiliIKar0Lk04plkntapUUECmMraXLFrkk/SBzYedeZGK6H96SuNVvAndg4tKcm2
         DxtmpbZo4WsRhMQTjtG4anXtrBnmWxG8KYXXTeidFMVbsTG8bkPLj8VmqnV3lo9rEry0
         Swpyj4rt9XOb81L6OVqRtcVSYtYizt5NoK7JLKjgFQ5rw4E50Tj3clBWQb9xbx3Bh7eX
         92o+zZwiDPIl9OSDbKG8BT9ER8SFtveTF/hrgGXq2eGLLNetUatOtUQ+UcuaoOUXxC9c
         AsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6WKbmgf+2ZIGCm/dE9FPQFIm79eTOH6MS53KyM+dR2s=;
        b=KG3KRdm59EK9Al/SSpQ1Q8jmFQcYJszXbPf0iWiF2+DXgTmXw2fA2zslmHAys4XDHG
         yCtWe5C8XEZq/d0e7CfJef3DDdzfeicZOVCPhClT7jYVEES1sXFAqbLcK6eN97TESzBF
         gphLcFaCWTwnpPk/IG+r2+N65dHfrHs5wjJHS2lIhY78817tVBVeOheaq6JFhKNJFm4w
         iu+JG2/zEX1+8lVVOMu6ZfTdsCvBAvpRrshRy0RYJUUonCZ33tt0n4gKPGqzwRI21oIo
         iyWcw3TdDbDsp2khlecZ/JNvN+btybRthoOwCX7ONybVKDNvQc8uPCouGZSXsTq0Sqv2
         qPDw==
X-Gm-Message-State: AOAM532ivhOX6rXDHJkTi1TSWx/uVGFbanSvQNcpOTp6RVAlIKKZfiy8
        adpHghVphZFuMV8jPqF+5cdFmg==
X-Google-Smtp-Source: ABdhPJxKA5Vxq5X3o3KFodyPKGEYbk4IgNMPD3Tk8eHB/YEud3CDUYpQ697oyidW2sBhnc4NFrkTsQ==
X-Received: by 2002:a05:6638:2686:: with SMTP id o6mr8310988jat.68.1612449445609;
        Thu, 04 Feb 2021 06:37:25 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h23sm2557045ila.15.2021.02.04.06.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 06:37:25 -0800 (PST)
Subject: Re: [GIT PULL] Floppy patch for 5.12
To:     efremov@linux.com
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Kurt Garloff <kurt@garloff.de>
References: <45f555f4-b694-ca8e-c088-f34dea9fc7c7@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba300e13-dc16-af15-a386-0c5348e0f919@kernel.dk>
Date:   Thu, 4 Feb 2021 07:37:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <45f555f4-b694-ca8e-c088-f34dea9fc7c7@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/21 3:12 AM, Denis Efremov wrote:
> The following changes since commit 0d7389718c32ad6bb8bee7895c91e2418b6b26aa:
> 
>   Merge tag 'nvme-5.21-2020-02-02' of git://git.infradead.org/nvme into for-5.12/drivers (2021-02-02 07:11:47 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/evdenis/linux-floppy tags/floppy-for-5.12

Pulled, thanks.

-- 
Jens Axboe

