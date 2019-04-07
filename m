Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4671C10F0E
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 14:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803A820896
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 14:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfDGOSS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 10:18:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39219 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDGOSS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 10:18:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so5765504pga.6
        for <linux-block@vger.kernel.org>; Sun, 07 Apr 2019 07:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2hE+Y4VLdlpNzQ9km+DbjGD+caRGA+nzXynZLj8D/zE=;
        b=IMLD4lxoQ55T0+Fcs4Bt9fcljjPZemoAq59E6KpVxQLaufR7WAS/caXlTXUUctp5yS
         ifAmlAnJ3VR/5F1/xc14rfap9qEQIYV4e4Ftit+c809elkmyNBTpT9Woh4ZOow+RVMEG
         mMznFE93U3pNJ0nP8LbibFSYSE+tJtYItvo//kjiHAP+TooCUUcrMQ2nsuJH5jElBpTR
         WdQdueq6xkcx1PNLS98c0NgByHaRyivsM96JgYN4ej9CVwy+cPN9IZhgnJeSyRb4hB+/
         4AGAnT1joanFdqtQDfo9TnfggWbINoMbigm92qiSt8rUZV65VwU1GPCkN94x8rxo+f+P
         KNHA==
X-Gm-Message-State: APjAAAXHSqSL948ecqTVCzPVK5fCXjX0e7QDw6qGdT7X1vOL9W0GkrHV
        lQ3N3V/UWkfGCsx8rN57yq7x994L
X-Google-Smtp-Source: APXvYqzBUbGgJtgUDKX8nZGhI2fwhWkKlvWsIWBgwldrxbHS06qfOwhp3ElBlRWjohlilgVMb2K4qQ==
X-Received: by 2002:a63:c45:: with SMTP id 5mr23352911pgm.385.1554646697289;
        Sun, 07 Apr 2019 07:18:17 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id c5sm4451835pgh.5.2019.04.07.07.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 07:18:16 -0700 (PDT)
Subject: Re: [PATCH] block: cleanup for blk_cleanup_queue()
To:     Shenghui Wang <shhuiw@foxmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
References: <20190407110314.7145-1-shhuiw@foxmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <26a49dd7-4525-1632-5bc5-a41cf5327cec@acm.org>
Date:   Sun, 7 Apr 2019 07:18:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407110314.7145-1-shhuiw@foxmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/19 4:03 AM, Shenghui Wang wrote:
>   	/*
> -	 * Drain all requests queued before DYING marking. Set DEAD flag to
> +	 * Drain all requests queued before DEAD marking. Set DEAD flag to
>   	 * prevent that q->request_fn() gets invoked after draining finished.
>   	 */

No new requests can be queued between the "dying" and "dead" states. I 
wrote "dying" in that comment because I meant "dying". See also commit 
3f3299d5c026 ("block: Rename queue dead flag").

Bart.
