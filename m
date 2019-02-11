Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74029C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC0A222AC
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UjKH0LWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfBKPU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:20:29 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:40064 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbfBKPU2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 10:20:28 -0500
Received: by mail-it1-f176.google.com with SMTP id i2so3010352ite.5
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 07:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j5yFh6XcnwkgVJwWMXJtRihfN5KvU/tNJXigBepJdmk=;
        b=UjKH0LWcfgSct/qb6LgDynj/pynxcaj00R8KTwbRaMH4IuaLzL7AqHh1MU6GN52bg6
         J3zu8qFHV5owSi9OG5lXO2VcEdO6KmoJUlhZaChldtyOqcPh6KPXCj6xSG0nD7Pj3dfr
         u31oLut1ebrtbJa9fWJFfQ2PO0EGy+4Ax8AZPTfHDZ/B3bDPtNAost+IKVFRHxCHC4R/
         vao654hQl26nTPNtxFsYDWTlLPHiadNQx/U5t8TKi+L+bJOkMkUOvLXLcXgwr6sSVyJq
         s4V3uz0QvOqzLvllKE44e2RWRkNXT4ouNtraJcdXR/kO2JvndH9tIODVEdVAiNp4lrWS
         nurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j5yFh6XcnwkgVJwWMXJtRihfN5KvU/tNJXigBepJdmk=;
        b=dGbAXMQzRqeN80e1epjCCmNu7Pf+WTvolWZYkqGsneowQeXV3Kqb3COtZeltjkihsV
         T/Ut6jN3cXo3XelKUtX6mJpj6LP2Evp2zfW7M2FGYCAueYlglrHkZmzbbOa6HO/5cBJI
         OP69hBhZDnkKP2au9JkXk1rxZ4g+vVWgA6vfJP5hL4TTUlIEPFEaELrAv0a33ouJr3IU
         XdS+qGMQlwnuay7dvm70JcOoDwtdXZZmHDfDt2pYfV423gmsSSeOXIMxXkGNQwkwLGXs
         BmT1heg5Wxc3fH3MdnnRllsczePlWuI36BD6J/mcjR2a//IhYiI9piqG/PC/J8pY8Hlc
         A4Iw==
X-Gm-Message-State: AHQUAuYpv1vuqz0XKZ853VYwl+yX6kOCiuE4pJEuWKPVkmmtaiCUl926
        dXYcuqx6PLDU5pICCEz+xKjVYLW+RJlpcg==
X-Google-Smtp-Source: AHgI3IalAI00Q/iTkHKZYWCiE6rLEXptSXFDWbKccjYN4AUzpiy3hEpEb7NzWEpZJBzv2UBIaqzyIw==
X-Received: by 2002:a5e:9615:: with SMTP id a21mr17516508ioq.126.1549898426932;
        Mon, 11 Feb 2019 07:20:26 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e5sm4727819ios.50.2019.02.11.07.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:20:25 -0800 (PST)
Subject: Re: [PATCH] block: avoid setting wbt_lat_usec to current value
To:     Aleksei Zakharov <zakharov.a.g@yandex.ru>
Cc:     linux-block@vger.kernel.org
References: <1549879834-24837-1-git-send-email-zakharov.a.g@yandex.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <215eaec2-22ab-c2f0-f1c9-40bcff976807@kernel.dk>
Date:   Mon, 11 Feb 2019 08:20:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549879834-24837-1-git-send-email-zakharov.a.g@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/19 3:10 AM, Aleksei Zakharov wrote:
> There's no reason to set wbt min lat and freeze request queue
> if current value is the same.

Applied, thanks.

-- 
Jens Axboe

