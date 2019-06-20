Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A86C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 19:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C48206BA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 19:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EK6txOWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfFTTEr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:04:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35887 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTTEr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 15:04:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so6226918edq.3
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+BIZ1Ivo5oNfmQL2MOoA0IQ8MKWSbN0Ves6tJWOfzZQ=;
        b=EK6txOWrDFDbE18PIibX5gQP6UtHtLKtZ+DldFpt5xhc1Udo1X9RnnUJ+kBn5yYHXR
         +czycOVMd6y7u8ky35CLUP6Iqv2v4lVrTIDUkbPe3waWMVt3SokqWZyaTAjHTr1TWPeE
         34VSdeXPrG0xrZb9/Z4VpPA/4OPeSNDaZI79cFOzOXgqgKSCIPTQL7jbQWcQ9dl9RUQA
         ao1CphGWKtMYgRAceTboxy1gvCl9G+q058Ym0neBaOvRjrrlpNFh8Ie0eIMrRigAnEQ8
         djbVVaWcVHJgbTPtZPZCLei+tOtjTpI5fRyfoRE8lTvc/dT4BafKdKutu5TG/4aE8eSW
         6iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+BIZ1Ivo5oNfmQL2MOoA0IQ8MKWSbN0Ves6tJWOfzZQ=;
        b=MEILTwgve8wmKgm9x4V4wDDP7z5HG7d9s0N+cS1FcnnQ6jPH4JT155JAhBdCaqZchA
         lw6BqlynMR/32UYu98YkAbyM3O48T022USD+WAjGJgZHA+7u4hJ+ITZi8JFoY2ccUGPE
         mxqaybc9X9AMABLI0n0invX8Zr2jT7dchr7wTB6iIsxDrCqkdjKFeMENgJXKqT+lJR4L
         cL3iqT7OgmCRxmhg71E/vrbU/vBNibRp80sGm736P88XsWr+Lbsd0AE+fFJmy1c4NIRZ
         hUbmpSDwdVGSPYh994c8jpukZcht119O8LTbv6gw5skzWANQUTKejsMnXF8p4V/GHWeM
         UDPQ==
X-Gm-Message-State: APjAAAUTaBn5MjpNEAvovyZuEvZoT8O8StTbvWj1pe/HH3WbiqDVQSya
        Eyg5yrSuBIa2TVH++2jdwlVlQ67XhQ1sLufG
X-Google-Smtp-Source: APXvYqywivZpDzq21s1O90jp2C/yMWGCCbuTXYJc5EvSgYyfH/WPNHIHcuqvdaPRrXXBS8B/bJZhgQ==
X-Received: by 2002:a50:a48a:: with SMTP id w10mr35045463edb.1.1561057485369;
        Thu, 20 Jun 2019 12:04:45 -0700 (PDT)
Received: from [192.168.1.208] (ip-5-186-115-204.cgn.fibianet.dk. [5.186.115.204])
        by smtp.gmail.com with ESMTPSA id i1sm38323ejo.32.2019.06.20.12.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 12:04:44 -0700 (PDT)
Subject: Re: [PATCH V5 0/5] block: improve print_req_error
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f791ff96-e22a-2419-3905-73a83f0ecf00@kernel.dk>
Date:   Thu, 20 Jun 2019 13:04:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/20/19 11:59 AM, Chaitanya Kulkarni wrote:
> Hi,
> 
> This patch-series is based on the initial patch posted by
> Christoph Hellwig <hch@lst.de>. While debugging the driver and block
> layer this print message is very meaningful. Also, we centralize the
> REQ_OP_XXX to the string conversion in the blk-core.c so that other
> dependent subsystems can use this helper without having to duplicate
> the code e.g. f2fs, blk-mq-debugfs.c.
> 
> Please consider this for 5.3.
> 
> In case someone is interested please find the test log for print_err_req
> with null_blk, f2fs tracing and blk-mq-debugfs->blk_mq_debugfs_rq_show()
> at the end of this patch.

Applied, thanks.

-- 
Jens Axboe

