Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3737FC88CB4
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 17:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjFLRpK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 13:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbjFLRpJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 13:45:09 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C198
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 10:45:07 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-558b6cffe03so2641467eaf.3
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 10:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686591907; x=1689183907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAlb9volQIGj45ZSIOc8zo0X80J8Ja06Rm5bQqeTV0A=;
        b=ZreZADzkConFaJr1Ik5254aRxGZjljr0YrvBRNTocHxig+JbsNoJCbw22448tKqX3B
         1zHg+U8sHbBiDGgKBe8xqvZ1P2PKARO/ysEmVivR0rNtP+E8wtIlxTmKau0D9GvTsbaw
         kxnGCk5adwDRZ/Yp5dEA4PKjH+ZfGmGt0WFg7G79FDC5z+kRH+sQ3PL3monox0n579uV
         c3uG5+vdOZLbFsiadxgnLWe8gusraVdMb03T+CwE5xlb+ufnl9z3C+v2tagG5ekjrI6X
         HVLffqKqLOvZ3h6FckMsq6sn/QDkCFLNSAy4nXhag8RGWPjsivBDVF6NDGbluCc3TQGH
         qQng==
X-Gm-Message-State: AC+VfDxDcGGI97G3LaPG9R+8g+NHmj4gDLFxLT2FXZ/OPX72yqcMXm4N
        /LEv//E/zZki32Y6fkrJUNYNAzp0ctOiyQ==
X-Google-Smtp-Source: ACHHUZ4ZxRGPjrlBLv4O9Uv924tulj6XNcgslKjQVlxjFSao0rsSaIgHq9oGc4KzfAb/8oKZPxwYHQ==
X-Received: by 2002:a54:4805:0:b0:39a:ba1d:89a9 with SMTP id j5-20020a544805000000b0039aba1d89a9mr4341090oij.46.1686591906497;
        Mon, 12 Jun 2023 10:45:06 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a3c8300b0024e33c69ee5sm7664051pjc.5.2023.06.12.10.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 10:45:05 -0700 (PDT)
Message-ID: <a663fc71-3a06-f4bf-8451-1fbee328c2b6@acm.org>
Date:   Mon, 12 Jun 2023 10:45:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] blk-crypto: use dynamic lock class for
 blk_crypto_profile::lock
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     dm-devel@redhat.com
References: <20230610061139.212085-1-ebiggers@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230610061139.212085-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/23 23:11, Eric Biggers wrote:
> When a device-mapper device is passing through the inline encryption
> support of an underlying device, calls to blk_crypto_evict_key() take
> the blk_crypto_profile::lock of the device-mapper device, then take the
> blk_crypto_profile::lock of the underlying device (nested).  This isn't
> a real deadlock, but it causes a lockdep report because there is only
> one lock class for all instances of this lock.
> 
> Lockdep subclasses don't really work here because the hierarchy of block
> devices is dynamic and could have more than 2 levels.
> 
> Instead, register a dynamic lock class for each blk_crypto_profile, and
> associate that with the lock.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
