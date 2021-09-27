Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA7C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADDA60E9C
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhI0WdK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhI0WdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:33:10 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A0CC061575
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 15:31:31 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r75so24858244iod.7
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sX6r+VtFysjF4oYWhq8xiiNNA4lX1D1DfLKUJZfhu90=;
        b=OGr73FRvt46870zXruqJzO3SP1Ff106DAwHYXUFkbZMroSt9xlbgYfx7Ha7zEr+0eQ
         fFB+gzMSVZ08KIy7nyZNnCarwiShb9palyfj0dXtHLBmtY9QZen0dwLXBl4Rvl7CxcNn
         SP7cAuUENfc4oxY/hNo+0A66ksQ9JUCs/MnzyXpskmihN/bESuVMBxAXmMC+yskn4ewF
         cvNKll/Bip9zfqynoppKB6jf4oU5D9Xmqy9wGOf+8D4/xEcZSZdSXUHc0DgUlJw88XJd
         dW6kqum5J6035JIytkWK80yNFYf+nDLSA6v4LNgfQDtCvMy5K9RF5zPvdixHvFODqSpb
         uFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sX6r+VtFysjF4oYWhq8xiiNNA4lX1D1DfLKUJZfhu90=;
        b=WlQ7p5jDpXT2Imw5sJSb8RtusAMZ3gQEBw1YTu29E5GElSuz8b2GEqCgFYXK8aFtit
         fZlzJ4EZ11nRec4KUyrho29F0fkq34l2hLkPYpuntOPlYrnpDTtzVno8UJdY+BiOvgtt
         tONjxz0CuiUfRfpNJrcsC1kEJXv4dvwgW0Kyp7iuBA/u9qSPaalRzyn9gsBiaW0o9jTc
         fn8A1+wWybZwBFNqA2SdQzVG6Rc+SOGYKQ3chYfQkhLEYgORsDHdwnmlJcAmsxVW3KPo
         UsLdzlaA4pUuryxr8yI4nRWknJpKq+fhCceVn/DfhBVEiquCDH85aHzT7rCL8Ef6cckj
         IXbA==
X-Gm-Message-State: AOAM531W7x3o2XqWZtFMb3w/+AAW7lAAabVChJAvTZm0MuNrmePPNBp6
        BIvtKxBifsHxwvLxkCLWgfUrRQ==
X-Google-Smtp-Source: ABdhPJzP/D0Hpjy1B2sLyeFE8yokRGllLNT0YFxbbt65jzTeEocCKfwSycbAz2t49gx5XfwHzWMFZw==
X-Received: by 2002:a05:6638:dcc:: with SMTP id m12mr1876527jaj.68.1632781891278;
        Mon, 27 Sep 2021 15:31:31 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t16sm9791519ilm.68.2021.09.27.15.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 15:31:30 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] block: fourth batch of add_disk() error handling
 conversions
To:     Luis Chamberlain <mcgrof@kernel.org>, bhelgaas@google.com,
        liushixin2@huawei.com, thunder.leizhen@huawei.com,
        lee.jones@linaro.org, geoff@infradead.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        josh.h.morris@us.ibm.com, pjk1939@linux.ibm.com, tim@cyberelk.net,
        richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210927220157.1069658-1-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <529d5e4a-82a4-2498-f63d-34c177ca4ab4@kernel.dk>
Date:   Mon, 27 Sep 2021 16:31:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927220157.1069658-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/21 4:01 PM, Luis Chamberlain wrote:
> This is the fourth batch of add_disk() error handling driver
> conversions. This set along with the entire 7 set of driver conversions
> can be found on my 20210927-for-axboe-add-disk-error-handling branch
> [0].

Applied 1-2, 6, 8-9, thanks.

-- 
Jens Axboe

