Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3D9C77B78
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 11:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjECLGE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjECLGD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 07:06:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5E43C14
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 04:06:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3063433fa66so1721093f8f.3
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 04:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1683111959; x=1685703959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zC1Gta3a1KlJpbjr0dHCub5GbkSXMMiO3N0auJSFEi4=;
        b=5WhYU1zjMzb3TRHB1ZMk7kLTS0gKNrQH6Y+bzmvOp+q02IjV9kk6xvjBSHRbTeiBU8
         9C9b40A8nGaZpu2kkWZINs88/ff/9yp228wkRX/6hdH3/mwpUMV10573pUulpY5gv7FA
         Xngnq88/iEOCk/UJA/wG0paP+7OyXCfo6DnTpibkGHznrTuCvdpgd1pOuDxkT8KkmOgq
         wK1Jxilbjc7JXsXzsTMDBAxC/SAG0N5epLX/RGX+H9VnewcAQiusg7zsjvxTN8o//g9s
         JTGRX2Hv0PF2oN5CkRkOyFGt95YQw0e96Gi5jnY7FQzfRE+iG1P4csBYqMzx1kqubBWe
         2kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683111959; x=1685703959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zC1Gta3a1KlJpbjr0dHCub5GbkSXMMiO3N0auJSFEi4=;
        b=UW24rtj92Y/s7+chMcGJK1/X5Dw8wfwXdSUvNmaGQizvNsN8aTp2a2bgz2c0ARSh90
         T456cXEq9tY2tU6w5ZuqEkORrAcUuG51wnd0TZYQ/MReLC9esdgZFnhCBKAUPpGOg24w
         LGF1Umnyp/C9CAkCpXyNNvjf6VSAJFl8Go+k2ziN/FXo2gJ9QPwMRPkEyRCzYg86RLBI
         9Qp4XQoIXj75uevk59SG1SxPPAWIz8UvxHboenmDEa2ZpCGz9Ble4H1GMbqI2fGzq2WP
         sKhSHHZh/ZS8i2o4gpLjTnK8aZfKXsD6TSzds+e5VnsMNkP0zPP/Gc+jiar0RwHIRmq+
         wQiQ==
X-Gm-Message-State: AC+VfDxBxjpid7xq7uksD8SY8QQOtcd/7mEZ9qoa7sruI+rCtOdoQJ3m
        gpUyc/GBPAQxV1IU78u63zj5Vg==
X-Google-Smtp-Source: ACHHUZ7zkhTIpzWubzYVvlBwUFu5dNo6evewdVN6u2chVe57/nTRHxWkzD+fPR2/AIMcjUnNBk+8cQ==
X-Received: by 2002:adf:e2cc:0:b0:305:ed26:8576 with SMTP id d12-20020adfe2cc000000b00305ed268576mr9968284wrj.9.1683111959225;
        Wed, 03 May 2023 04:05:59 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d58c2000000b002fe522117fdsm33440960wrf.36.2023.05.03.04.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 04:05:58 -0700 (PDT)
Message-ID: <b1568ca5-4daf-f6b5-7861-4881aa46e578@linbit.com>
Date:   Wed, 3 May 2023 13:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drbd: do not set REQ_PREFLUSH when submitting barrier
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Thomas Voegtle <tv@lio96.de>
References: <20230502092922.175857-1-christoph.boehmwalder@linbit.com>
 <ZFHgefWofVt24tRl@infradead.org>
Content-Language: en-US
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <ZFHgefWofVt24tRl@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 03.05.23 um 06:18 schrieb Christoph Hellwig:
> On Tue, May 02, 2023 at 11:29:22AM +0200, Christoph Böhmwalder wrote:
>>  	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
>> -				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
>> +				    REQ_OP_FLUSH, GFP_NOIO);
> 
> This isn't going to work.  flush bios are (somewhat confusingly)

Indeed...

> implemented as writes with no data and the preflush flag.  So this
> should be:
> 
> 	REQ_OP_WRITE | REQ_PREFLUSH.
> 
> and it looks like whatever flushing this does hasn't wroked for a long
> time.

Thanks for the hint. I'll prepare a v2 today.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
