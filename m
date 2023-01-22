Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CFFC25B4E
	for <linux-block@archiver.kernel.org>; Sun, 22 Jan 2023 22:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjAVW15 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Jan 2023 17:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjAVW14 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Jan 2023 17:27:56 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C380D1206B
        for <linux-block@vger.kernel.org>; Sun, 22 Jan 2023 14:27:55 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v23so9792678plo.1
        for <linux-block@vger.kernel.org>; Sun, 22 Jan 2023 14:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dAZopDqbAo3QdY1k+KfmF5laZlZPUhPOvXWpz29n6Q=;
        b=Te1loueT5FFT0///54ss+EGi5NnqZVnF66p9MrcSE2rlWW1aIYLlCCmGTCSW0F6DSF
         zGy/XhMPjWNOg0DTMdyryIdeC6S94qekXqZk6buO+/Y1zMPfGEuPKe1HnPmE+ScrERWn
         xI0FN6LDwN/9ZhC6ZxOtaJRABzDIs/aJ7ag5KnguVVe25wjnO9VF6p7+lMwTFL65IFcD
         gYlMIM1RXLCrAEXfPrPZoDmNxd0gYLglpwxFXhBXpa316k2GQE2o2N4FFVpLefP8Lhf9
         Xcqt1FTx9L0iCGSIFzYdmU532nJrR280DdX4Ubcy0mcevXrzERjnxXMMVfUgJYIabw5P
         V7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dAZopDqbAo3QdY1k+KfmF5laZlZPUhPOvXWpz29n6Q=;
        b=eDlNClJamSmrYRehDLJ5oTNgJ+zFP/psGTE76Euje+XhV8024HAl45i7oKJNF4Nw1R
         UlmyBVgYiwPqFZTWCOEW8V92gFAAYD776I5N2TmRKrZOLP1HeEWfV3lbuGPdGdPfoHOw
         pGtO8IEgmOLlpM4A3z2YKi5W6XRYUp1LXbw7+OggfXx1qu21b/tOobLy5yiVa01GLaUi
         tPOyzNMlY+6hFeY+pJ503ge9iGd5+JNBJG8FaKbvjnJu/SLTYoFpdg1vq0IMzveJ95vz
         Mc8Mi9qtdKsBILtDyNpntSSfIdIe6l6eBtXQnbmBSJrc1KfyLIb5AjZp51Yf10AhnB98
         6mGg==
X-Gm-Message-State: AFqh2kriiqq+Kg/edi+nBdpXP02HZQv1wyS/geqi5wFCzN6CNRkOv4Gv
        /kiO7N0CaU2CH96pP+5sttw+3Q==
X-Google-Smtp-Source: AMrXdXvaxXC+r8949o3MWU3crnBc0kvErgg9rRt/S+eh5ENhV+3MuHcztG7rmUXpDJjEAnKh9bEC/A==
X-Received: by 2002:a17:902:9041:b0:193:3a44:c436 with SMTP id w1-20020a170902904100b001933a44c436mr5527342plz.6.1674426475215;
        Sun, 22 Jan 2023 14:27:55 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001947ba0ac8fsm3706940plo.236.2023.01.22.14.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 14:27:54 -0800 (PST)
Message-ID: <1ce4f09a-f4c3-ccd5-556e-3eb3aaa143f1@kernel.dk>
Date:   Sun, 22 Jan 2023 15:27:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] paride/pcd: return earlier when an error happens in
 pcd_atapi()
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tom Rix <trix@redhat.com>, tim@cyberelk.net, nathan@kernel.org,
        ndesaulniers@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230122154901.505142-1-trix@redhat.com>
 <1a501bc9-7058-6c47-0ebf-44459bc0e730@kernel.dk> <Y820PCtcJv12fJpI@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y820PCtcJv12fJpI@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/22/23 3:10 PM, Al Viro wrote:
> On Sun, Jan 22, 2023 at 01:49:00PM -0700, Jens Axboe wrote:
>> On 1/22/23 8:49 AM, Tom Rix wrote:
>>> clang static analysis reports
>>> drivers/block/paride/pcd.c:856:36: warning: The left operand of '&'
>>>   is a garbage value [core.UndefinedBinaryOperatorResult]
>>>   tocentry->cdte_ctrl = buffer[5] & 0xf;
>>>                         ~~~~~~~~~ ^
>>
>> Has this one been compiled? I'm guessing not tested...
>>
>> In any case, this code is going away hopefully shortly, so let's not
>> bother with changes like this.
> 
> 	Look at the callers - the value left in entry is discarded if
> ->audio_ioctl(..., CDROMREADTOCENTRY, &entry) returns non-zero.  Sure,
> it's a nasal daemon territory, but realistically it's not going to be
> caught by testing.

I don't expect anyone really to be able to test it, but v1 had a pretty
basic issue that would've surely triggered a compiler warning had it
been compiled.

-- 
Jens Axboe


