Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B236EC433F5
	for <linux-block@archiver.kernel.org>; Fri, 17 Dec 2021 16:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbhLQQZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhLQQZM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Dec 2021 11:25:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF85C061574
        for <linux-block@vger.kernel.org>; Fri, 17 Dec 2021 08:25:12 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id co15so2727666pjb.2
        for <linux-block@vger.kernel.org>; Fri, 17 Dec 2021 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=i5b9PXwhAv6r3gLGUQSE4NSFBShDvIEQt7qaKbqdtRU=;
        b=oUkhRhxL7JjguwmmNEIfWI77z+V+UN9VccwOVfxMjGgLpOYWokci2tfIxVqsGczmST
         QMxe3fcL/DphTCa09VQqbosf4tTlsF0XqoP63h1S66W47QyQ+/igaI5OBfIzrmoKzzZe
         3rigQueqD7rezcc5qugBXfwmqrFlKxNi/kkC/JbX+1OAlWk9Q61yzo7j1HGoE0aiE6jw
         Xu926yr+rLhSReYBvO4eo/NAZCRhPCevqQwOEr1CfukbfA8KVAWKEUmpA9SdGrHxNLno
         0Ce8mhLfTrvVkgPVQRpxQnzMpq/vhaNNc5Y3vcJGeRHL16jD/J/GrzFJeflJ2nUkyDvG
         dFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i5b9PXwhAv6r3gLGUQSE4NSFBShDvIEQt7qaKbqdtRU=;
        b=wgAxEMLQhReivevRHOANk90xU9rNZgG/c4CMlLnPJu+GVPsFCrLkCfyfIb2vTpR/+L
         m6BCDYI6d7zxizMcxMnSBdcoyCfqWnE326Q703eQt9yhbFI7jG4NED/Qg0g7ZtizgjCI
         7srlDzbbj0LSMG/9F4RolnMRZCoZPrEczFZjzoQsg5B5zzDZqqbEPpms/rse4Am2se6D
         RnNBW3zXYZMssnCCBaFI+7GcQkMLennw1mOFn6/qctvvym0qFskDWiUK9XAEobhxAV4C
         22zhdlF1nDNIGPRjOy1gzBY1jMkh8U7++vBMbnIc1k71gVxoLAml1XDL4f6f+4OFU3UN
         t/XA==
X-Gm-Message-State: AOAM532iQ45J5MEO3VuznFGJq839meov/7Y8z6OgBTOeOgRbx3Gxw1/v
        gKbUmHFVbD8umrVrRxWDj8t7iUS3MO/oAw==
X-Google-Smtp-Source: ABdhPJx3bmYolgmWDig8iyqAYOvSIoFRuQg5Rl3cmZdn7QGY7iyfQpRgeaMheRIczzz2i3SXX8XRsQ==
X-Received: by 2002:a17:90a:950b:: with SMTP id t11mr13029826pjo.80.1639758311355;
        Fri, 17 Dec 2021 08:25:11 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21c8::1321? ([2620:10d:c090:400::5:4398])
        by smtp.gmail.com with ESMTPSA id nl16sm12921115pjb.13.2021.12.17.08.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 08:25:10 -0800 (PST)
Subject: Re: [PATCH] block: use "unsigned long" for blk_validate_block_size()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block <linux-block@vger.kernel.org>
References: <f81aaa2b-16c4-6e20-8a13-33f0a7d319d1@i-love.sakura.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b114e2c8-d5c2-c2e8-9aeb-c18eaba52de0@kernel.dk>
Date:   Fri, 17 Dec 2021 09:25:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f81aaa2b-16c4-6e20-8a13-33f0a7d319d1@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/21 4:38 AM, Tetsuo Handa wrote:
> Use of "unsigned short" for loop_validate_block_size() is wrong [1], and
> commit af3c570fb0df422b ("loop: Use blk_validate_block_size() to validate
> block size") changed to use "unsigned int".
> 
> However, since lo_simple_ioctl(LOOP_SET_BLOCK_SIZE) passes "unsigned long
> arg" to loop_set_block_size(), blk_validate_block_size() can't validate
> the upper 32bits on 64bits environment. A block size like 0x100000200
> should be rejected.

Wouldn't it make more sense to validate that part on the loop side? A
block size > 32-bit doesn't make any sense.

-- 
Jens Axboe

