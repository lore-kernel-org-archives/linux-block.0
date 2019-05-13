Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76350C04AA7
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CD821473
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 15:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XqjVMG6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbfEMPQC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 11:16:02 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55167 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbfEMPQB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 11:16:01 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so20840735ite.4
        for <linux-block@vger.kernel.org>; Mon, 13 May 2019 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zQKAeApbQkGSD0p9oJ6Vk8zjf372ECXjcP7amsJgHmE=;
        b=XqjVMG6jbZ7CL5+3ycqBJDm2IZ4Is0m01tiJzG1wE9WJp07ok3eMK6eZxKbdTnBNsz
         8FE+QprL9A4TLnzKsxrBuRTBl1EWTjHdQm27KeoCjvLCf7xxHfn3BDyynV53cGVMJtV9
         nxGZMnPe1uywHCoVeLJuz9muXMgkkkSd9Xcz7xxIQ4krdFtYPHKuKcensTbuvPalQf8o
         nSMTA2+01DL8XCtb34vPkaubCi1uGUeBwcYJ9XvFG8H1V/okutNH4ZcE23J3ChUL0v8c
         QOStHA84Q6P1TcSUNce3Cp+rceqF5nUx5y5f2p78zmJjevaRCT6Ti3Mr9gRLWCR+HPQB
         XP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zQKAeApbQkGSD0p9oJ6Vk8zjf372ECXjcP7amsJgHmE=;
        b=oVCvnyCbQy2016AREvQoARWgrTNHZwtIZnJycJwwMBKCO+gt7n53mtt+li0ICP8a2o
         ID+Zmt1VYHmWIrZ/TinEPfSXN68e+ywZ3stsv/9XkMkwOfCnBjrwqjw+u/iE8s3sPxfs
         kZUbiUQCDaLP/lJjTxb4Nnnhtq2yCngEapHY4zED5cHt/1O8P5z2yzOPZMnGQOr4yDLv
         On3EiLCsEEdJonLMwSEAy82GUsRB60hvXtRqAh/2/pxYySDR59b7qWkZvi7xSV86hS66
         IzVnO2qJVHK8DDVI1MMZwffTHy2cgk4V6JYZp+cAa6ApCQapEBz7+qOVdl/RWnimjIYq
         ZE4A==
X-Gm-Message-State: APjAAAVymp1oX1apoobIz56+pMWskSATIcmpq94DMCM57RuM1KbCO3M+
        hPudX8JNhtWds55+0p34nWIIHw==
X-Google-Smtp-Source: APXvYqyae2kbVGHd9cIxb31cVMqpb47k9n3/oInM0VA5XiPnBWhONSYMR28gs0cOUgIUTDki9iqSmA==
X-Received: by 2002:a02:1142:: with SMTP id 63mr18630806jaf.19.1557760560527;
        Mon, 13 May 2019 08:16:00 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q16sm4360158ior.75.2019.05.13.08.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 08:15:59 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: fix race condition reading SQE data
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <3900c9a9-41a2-31cb-3a7b-e93251505b15@kernel.dk>
 <20190511170801.32182-1-source@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3c0071d2-528b-573a-49fe-c6f72398840c@kernel.dk>
Date:   Mon, 13 May 2019 09:15:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511170801.32182-1-source@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/11/19 11:08 AM, Stefan Bühler wrote:
> When punting to workers the SQE gets copied after the initial try.
> There is a race condition between reading SQE data for the initial try
> and copying it for punting it to the workers.
> 
> For example io_rw_done calls kiocb->ki_complete even if it was prepared
> for IORING_OP_FSYNC (and would be NULL).
> 
> The easiest solution for now is to alway prepare again in the worker.
> 
> req->file is safe to prepare though as long as it is checked before use.

Looks good, as we discussed a week or so ago. Applied, thanks.

-- 
Jens Axboe

