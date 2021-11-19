Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F498C433EF
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 02:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057B9617E4
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 02:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhKSCoY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 21:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhKSCoY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 21:44:24 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E92C061574
        for <linux-block@vger.kernel.org>; Thu, 18 Nov 2021 18:41:23 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 200so7337206pga.1
        for <linux-block@vger.kernel.org>; Thu, 18 Nov 2021 18:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=19eC0yHN8Knq4er8eprHiiNnMBPtyRfdZNlAGVkzuA0=;
        b=g8V+RgDmhoLzRSSJmgnK+xoftMqWOQCDMkW7SMd7B/E63Mcto/jSrX63qkrEY7m9xt
         ElaG7vQHV0nBCYK6WBA1O6HlFiWqGNdvL83Sv8mnV8dPub4Dc0oEoU6uWRP0r2U95wBu
         hp66iNrtjPeUNgY717zMNX2JqYWAHBwPfiCIC7C/8TBBV0x21MqGAmOMlpgt6hA9Vjin
         oS1B5Nug/+PBeoByVZBZcRHG6JfxUyTnHjRb5qR9WCmY/wbOrQvyuCOqVFKVRVkyqzPv
         wC6toe7e5ybjaen7vf5R3e5C42+Vd4x+NZhfG9lnHO9yB8Mxk03M9ynzS7UUjR3Sxz5a
         3fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=19eC0yHN8Knq4er8eprHiiNnMBPtyRfdZNlAGVkzuA0=;
        b=nIO54dzS5hFhdTfcN7bJwvBneg21w51mbarTuoQRaLjZJPgTaCfURn/PzvgZ5uaujX
         GX3Ol8P6PRkTKwhNe83Rr0Ub2WQ0zJMIka+EQQeZmt514ggFpwkUEqpAseGYcLgEIN32
         9lPl8Ak2e5325djXA4CSTiVopJANvHzsL+Yd8vsZbTrU50W44qdCnl8vOKDj4cnqV4iA
         uF7hQ8fQfqsasBDmcevJW5zM6Uv9Ry9SK3ap7T+GcXmcQ6UwX77V/KQnrgON9sx5ngWZ
         FKepk46sk2CpcOQqBJF56EX2cs4lVQvvYnKCBolhWdMIX3TSMJpfaOL/kyhDWxuNgcZl
         bybg==
X-Gm-Message-State: AOAM531znehWtH/GHOzS0gOMGH6wOoTf0BdeQKJMOY5hmE9+QEAtD0P8
        OaYmdoGNJIiq0O2kdCDyoap60A==
X-Google-Smtp-Source: ABdhPJyH7dLIVlWvWY2gnMMXBa3wdH+uvv8pklXAX+TNq575sm9EEbxFByiudWsfj2dx/Ox4bYD2ZA==
X-Received: by 2002:a05:6a00:1909:b0:49f:a0d0:abcf with SMTP id y9-20020a056a00190900b0049fa0d0abcfmr60556058pfi.70.1637289682906;
        Thu, 18 Nov 2021 18:41:22 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id e18sm714007pgl.50.2021.11.18.18.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 18:41:22 -0800 (PST)
Message-ID: <debb322e-395d-90a9-2052-0cf69d96f024@linaro.org>
Date:   Thu, 18 Nov 2021 18:41:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 5.15] block: Add a helper to validate the block size
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        stable@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+662448179365dddc1880@syzkaller.appspotmail.com,
        xieyongji@bytedance.com
References: <7e6c4c23-f071-f33b-7bd4-da11980d34c6@linaro.org>
 <20211118235738.1128085-1-tadeusz.struk@linaro.org>
 <df37d57e-86e1-56dd-54b7-f3d7b96ffd56@opensource.wdc.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <df37d57e-86e1-56dd-54b7-f3d7b96ffd56@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/18/21 17:55, Damien Le Moal wrote:
> But where is this used in 5.15 ? I do not see any callers for this.
> So why backport it ?
It will be used after the
af3c570fb0df ("loop: Use blk_validate_block_size() to validate block size")
is applied.
Please read the first message in the thread to get the context.

-- 
Thanks,
Tadeusz
