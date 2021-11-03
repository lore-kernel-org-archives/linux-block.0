Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB247C433F5
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08E46056B
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 16:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhKCQIC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhKCQIC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 12:08:02 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88773C061714
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 09:05:25 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y73so3397713iof.4
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gEtDXVv0jZX2+uCdO2uSTn/dUNWDGIsigqoFGSHH9P8=;
        b=HQ4ZMBySkih+WSvSGML4vxJOuBeYuJgTdEfHsfnLUEdxCS2VUo5QtlzxHCihr8TPI0
         QTSuDPmFfbhtxKefnNmhx6MGd5TYoav33lA8fjOQ/RhfoUUceTAAef4BjKiQ0VUe2cQ6
         1Gif9LsuaMpvyPPNTE91cCLlBkFm/n/mIDJjWTH3nQ1qODdJ+EtgM8mrdQezbUcyKWDa
         65RjWM2V59HPik5+eZ4X3nzAj/h9nMR2lTtnoVHYkJIK0i7U1MrXBiofbtjnoNX5pNoS
         KUCgRjTTOETeeu2Mxi1DEEPDCeFI+CMvpSNDM2H81BgecelIP3X+ZTlvFkdBGpGCOOeo
         qhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gEtDXVv0jZX2+uCdO2uSTn/dUNWDGIsigqoFGSHH9P8=;
        b=0zP8PzmIpzeJdt9dmAgD0iwWu/ELAX5Bi+DBskE2KTPoS2VIf48aDouVZoBPfQGE4U
         ykqBBPpnMYq9ImdgA2r2cSP1yszo+mAt/WbdeKT3iE4owq1BgO/an3u6G9F0gfxv/mEQ
         6YWOUOrXZnYn0BJjkYvtrTpKQ+lnrUROV0BeJeLJjsY5jJNB0suAgOa08+hYndEU+Lws
         d19Zp7BAoiHpLRRHs6BMGr7cFcJfx540vpDzAggai377XAZinZx+2zo58rkTkMvcRF0D
         oB11HUtiAQKCKCbhqvVDepJnnT56wOGkYPHIzbfbpmhZaImt+pjOEBiejwx39fkRDgsJ
         DQZw==
X-Gm-Message-State: AOAM530J14i40EvVDNZmB/8W3KmaY/SEveaMf90njoA2jk1iJryKW6K3
        dOLMStJXNZs0uWFWgehc78Ao2VO0GXRjuQ==
X-Google-Smtp-Source: ABdhPJwxMN2MmAE9YjpsP2Xlw7SuwR1JSW0I5KYlycM56Bkrq2LIALqHHrczvMO+VFPX05himUDLaA==
X-Received: by 2002:a05:6602:2a42:: with SMTP id k2mr31841407iov.97.1635955524646;
        Wed, 03 Nov 2021 09:05:24 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i1sm1426566iov.10.2021.11.03.09.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 09:05:24 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: move srcu from blk_mq_hw_ctx to request_queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20211103160018.3764976-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <514f166c-af95-5b6a-f3da-80da142ce26b@kernel.dk>
Date:   Wed, 3 Nov 2021 10:05:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211103160018.3764976-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/3/21 10:00 AM, Ming Lei wrote:
> In case of BLK_MQ_F_BLOCKING, per-hctx srcu is used to protect dispatch
> critical area. However, this srcu instance stays at the end of hctx, and
> it often takes standalone cacheline, often cold.
> 
> Inside srcu_read_lock() and srcu_read_unlock(), WRITE is always done on
> the indirect percpu variable which is allocated from heap instead of
> being embedded, srcu->srcu_idx of is read only in srcu_read_lock(). It
> doesn't matter if srcu structure stays in hctx or request queue.
> 
> So switch to per-request-queue srcu for protecting dispatch, and this
> way simplifies quiesce a lot, not mention quiesce is always done on the
> request queue wide.
> 
> t/io_uring randread IO test shows that IOPS is basically not affected by this
> change on null_blk(g_blocking, MQ).

Looks good to me.

-- 
Jens Axboe

