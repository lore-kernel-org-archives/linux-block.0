Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E0DC433FE
	for <linux-block@archiver.kernel.org>; Sun, 12 Dec 2021 20:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhLLUTD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:19:03 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:34399 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLLUTC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Dec 2021 15:19:02 -0500
Received: by mail-io1-f44.google.com with SMTP id e128so16405795iof.1
        for <linux-block@vger.kernel.org>; Sun, 12 Dec 2021 12:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ykuGLSsr3frX2jPYg/40m3lbFOoiCYd2tsRxXdaS99s=;
        b=tkVa7mvc+nrWJF1ZnYiKNAU0t+IL1dEa9s+nyyGsnibZZ8NFrMtC68j5QXETPPyLfK
         2JRp7p/9UiQxLuyloa5JSzGdiZquIPejm0576jAeDeg7QJC2c97R5C6C64PZ6/OrP+4O
         9rgf3b6G8DzTVW2Mko9+IpPdskspU3z6h+B5PpdOPLmjOo/mRJJi1tUymLDyfJMYEAoN
         rM5L+AoynEeklwcU7Nhm65xtL5+P1QUbrYpYGFLb5pa4gM0seug2qLzil6wsxJ9vfANR
         YjzSFhDB8cT0agk1RO004ivT3ErUg/AGIX6Qz23qiLWqH6RwmryuVyE97Sq2UKZyCRrK
         pOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ykuGLSsr3frX2jPYg/40m3lbFOoiCYd2tsRxXdaS99s=;
        b=pcvdjUqvxnjTdQk/BJ3AkVUdJwFcnEhBIMuszsUdnM/EQZhwYbJ+W8etOwv30LsrmZ
         /8dOvgfcKhWoQGgEx8MkBk8NLgItmhAckLFaCxc7dHwwpu3Ux0a+Nm4RszCWhRQPY5gj
         VBnCWHFeBnQtyIUyJrU06xT4ziELUxrUWtVyEK9DSCdanIlg5CjAZ0ofW6/l+uKi9B14
         NXIBkORlmlxjth3hjDXltisxFQz9CjBD0c99vFAYESLwhSo0XuL0Yd+ML/mL91A2S05+
         XCBOJ+1GZNTDIRrc/NOhdyRaiSIIniyBzIm7YzPHpDAbnNm7k8WodVMfZizFgfXiCxOn
         3vaw==
X-Gm-Message-State: AOAM531f6jFJHD4hltm0bLH06MQDmx2xH5ZlUYyT2Yx/UJlwRrHmBht/
        3H0hO9a8E3IBwBFfGHkSfjn+6VvFLqTn/Q==
X-Google-Smtp-Source: ABdhPJw0OOh9J00ASZNVp9H0XzG+rmnrLUR1VfhH6yW8ZOpWS7fb8K1sLnAq3C3MdON2BaF5D/319A==
X-Received: by 2002:a02:ba07:: with SMTP id z7mr29080253jan.84.1639340282415;
        Sun, 12 Dec 2021 12:18:02 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h14sm7753954ild.16.2021.12.12.12.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 12:18:02 -0800 (PST)
Subject: Re: [PATCH v13 06/12] bcache: get recs list head for allocated pages
 by specific uuid
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
References: <20211212170552.2812-1-colyli@suse.de>
 <20211212170552.2812-7-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1ac0d154-ca8c-7b37-f59c-1e0c29b971c2@kernel.dk>
Date:   Sun, 12 Dec 2021 13:18:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211212170552.2812-7-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/21 10:05 AM, Coly Li wrote:
> From: Jianpeng Ma <jianpeng.ma@intel.com>
> 
> This patch implements bch_get_nvmpg_head() of the buddy allocator
> to be used to get recs list head for allocated pages by specific
> uuid. Then the requester (owner) can find all previous allocated
> nvdimm pages by iterating the recs list.

This patch looks like it should just get dropped.

-- 
Jens Axboe

