Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0614DC61DA4
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 03:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBQDIz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQDIz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 22:08:55 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A4A5381A
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 19:08:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id o8so4203973pls.11
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 19:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676603334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpt9dSZI/ugzJAdat/pS3R1iX6G3/RmCpY+ZsBEtUwI=;
        b=lUBmOstiXm/aduonCGi3R6oCHNwqVFHbyeKCIgen43Rt3FNmOkwfnUvAcJEMOzGLyN
         /EiAiVx4kbX3pO5He8Fayeey0n9cG3dhCxhHYUjwgs7anzxDKxhZ92B/jqUk3suWouh2
         lQEXQbGrdwB3Z9ieGdvBRrahxAHlQsE51mzQKjbXYo8TVSwLo1b4UIqu7ELfMRvoBBmU
         cmR2B6z+2gqlSprVtakJXtTN0BWi92Y9WmUBq5OEwKVtmmK/72b8Jn5hjhjcoi9vsA85
         nZe0EiAXxw6sUJOJNnp7ii305Gpc4FjQmfzL4jk+zVixlJ+Ib75sauWtBHFxxvNwn1jF
         jPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676603334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpt9dSZI/ugzJAdat/pS3R1iX6G3/RmCpY+ZsBEtUwI=;
        b=M5Pzgr3YChqhtXOHWbBTCT5aHyJqgsOn275+ZU2p1HOJyYjHY99BCe1g/SfbD/Zkd0
         W+kOvRPge0RbkUlukHXxmdg3kfU3LVCqyaIia2a2k0vQYILlMZZQ+PojWyO81Ks1oTRZ
         2NKmPJjZ+uURRxbaAcpeBe26etBd+TZhRPkm7RciKElW0I+jDI+tm9zkLEu839TvMVez
         9GDSiiwoXYZLyRulElP967isyrnG2n/EToiRLioU0ise8dlJx4IE56rxjigAE0MqjVvC
         gchyTMzTEHDgev9/7Qtuazl+s/V2xA3IGJRd4Y2jS5qVhqc1rxPsegQCflCc/Yx/eILy
         akQQ==
X-Gm-Message-State: AO0yUKXmn4eV1v+m0CP+s45lhgFqn+ibRUoVeT/pFPLuLMX7HyB7Hdq9
        8nFU2SST9GeHp+QaC8zV6e4AUg==
X-Google-Smtp-Source: AK7set9Eta9Zz9B560F1H0j05DCD7qQMqCJsQTZ+bQ8fktcUJ2kf/NPj1XqhBiSHiHKEonkiPaa8xA==
X-Received: by 2002:a17:90a:840d:b0:230:dc97:9da2 with SMTP id j13-20020a17090a840d00b00230dc979da2mr7464748pjn.1.1676603333648;
        Thu, 16 Feb 2023 19:08:53 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t16-20020a17090aae1000b002343bac52aesm1834934pjq.7.2023.02.16.19.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 19:08:53 -0800 (PST)
Message-ID: <1b5739c9-f0dd-6d63-d85b-7029b886d8a1@kernel.dk>
Date:   Thu, 16 Feb 2023 20:08:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] sed-opal: add support flag for SUM in status ioctl
Content-Language: en-US
To:     luca.boccassi@gmail.com, linux-block@vger.kernel.org
Cc:     jonathan.derrick@linux.dev
References: <20230210010612.28729-1-luca.boccassi@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230210010612.28729-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/9/23 6:06 PM, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> Not every OPAL drive supports SUM (Single User Mode), so report this
> information to userspace via the get-status ioctl so that we can adjust
> the formatting options accordingly.
> Tested on a kingston drive (which supports it) and a samsung one
> (which does not).

Looks fine to me - Jonathan, are you still maintaining this code?
We can still get this done for 6.3. I just sent out the first
merge request, but there will be more down the line. I'll queue it
up on top for now.

-- 
Jens Axboe


