Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8FFC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733AA2083B
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 19:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m7kfLHcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfBHTmo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:42:44 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54443 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfBHTmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 14:42:44 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so11658884ita.4
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xtgiuIKK7UIOxCspefQXXIdxZFEynOgd6anNxHKTO/w=;
        b=m7kfLHcQxyKUy/jNCDcjkqi/d5RIWCYqoSQc47qPDoNpEuPcJJgpHZjIFkXcm8BZoF
         0QBuPD8oLaeeoD1UWbvUvw7Qv18QfSuQKbPqjXYZx/v5JWZ/ICJd16jST0pSvJfvz7bZ
         hCeXy8KzYPmVWgpj4GZJS1YU1nqt0ZNoeO0x2WQK1Idlxg3IbODTPPE1K2yiJQHKHPIh
         vcCv48tKnSJz80T4W/xSMxuZyFnVGhbahN7IL71jNDbOPT5JK4zLamHdPd3OIhJcM3Nf
         mx5dzDLWrgzIPYa+TYBI3Z8wmbtdPfe7co3wckMGMmTSyXSbhf5H8qhhAFW1su6JWeAa
         sIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtgiuIKK7UIOxCspefQXXIdxZFEynOgd6anNxHKTO/w=;
        b=V5HWHz92hx386AFPp7gI5rXiFaIv96c7rdj44s51bFv11MphYWhonrojUWvt0nAViP
         3KWHPvEDzF4wy0SOyfi9Zu8+1+jvMq5wyEYtfdzKBsHhYDzlt6fnyxZemarJy43gzjEO
         R32WZcDhy/L+sRPGC/dVtm2mH+/oxlz1eSrTIRd1AjbJRDXfCSyyKv3T7R7TRM5LS7FR
         6vng/hThtF06g5GYbAuacMLv9jX9fqNazjdtcKJMAtsFeuI3iyvwJIepzT8tAr28BfPw
         U/XXzmeCd5SzBeTnB+tkquMNPNce455rGQSDo9pOIlLawTmigkWwGsx8PNg/yP31nATc
         e0rA==
X-Gm-Message-State: AHQUAuYApR5syZeRrbg1w4dyk2Z1WF4cuA8k+cEyUkBpD52E/dyVtX+Q
        +JvQm0s5ITOBAq9Ae7j6X6P3e5+CjuEiEA==
X-Google-Smtp-Source: AHgI3Ia0V4ABkqosqaYamQvIw7L7r9fD6P5Nu7j9XSoylhO0a7ss/1CWPu9hEn7bv6GTvD+S8xp0gg==
X-Received: by 2002:a02:3003:: with SMTP id q3mr13025147jaq.16.1549654963818;
        Fri, 08 Feb 2019 11:42:43 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x17sm1288973ioa.6.2019.02.08.11.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:42:42 -0800 (PST)
Subject: Re: [PATCH v2 0/3] iolatency bug fix
To:     Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20190125001249.72688-1-bo.liu@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <61ffd35a-d6a5-0c46-3de8-c1c9dead506a@kernel.dk>
Date:   Fri, 8 Feb 2019 12:42:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125001249.72688-1-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/19 5:12 PM, Liu Bo wrote:
> This set is to fix a hang case if blk-iolatency is in use.
> 
> The 1st patch explains the hang problem with more details and provides
> a fix.
> The 2nd patch adds a warning for unexpected inflight counter.
> The 3rd patch is a cleanup of blk_mq_freeze_queue.

Applied for 5.0, thanks.

-- 
Jens Axboe

