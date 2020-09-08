Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40059C433E2
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 23:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AEB20672
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 23:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oCz04+pA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgIHXmN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 19:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIHXmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Sep 2020 19:42:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F16C061573
        for <linux-block@vger.kernel.org>; Tue,  8 Sep 2020 16:42:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m8so689947pgi.3
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2020 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FAxZjxhFm2BJKLXiRqI1gbkphvdfwqqlyhBR2lsE7Po=;
        b=oCz04+pA+HMqm/0yBZ79cyMSW+1C4bxzm8V2XRKK4l3KDTrxEj4RAGfFKVGTAsqQJc
         Xs/iXPeRFBzJP3z9egDe5dNhui+OfoO7UDOuE+R6eELC3za5v/wUjWfLoD2aYx+48eee
         ELpax1o8/C1yKFK0IcuLFuroPktIWFMSCwTqWqdh88xJeq7u1xBETaxG3q/1wy42jGUk
         G7R6/9qb+kkjzx0+GeK+SxLeJElCofgbBEPCIYrJu/F7za/xJiuzDhl+Ks66vDAi6dAi
         go0+47rGYlvtyhFlYhRZUpkHDOBfuNEkUn6oQiH1lYRSnBDaqzd8ONlwf1tW/dzY0d9K
         axCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAxZjxhFm2BJKLXiRqI1gbkphvdfwqqlyhBR2lsE7Po=;
        b=DoFJmM1kynCYfpRqwzlah8/IoIRjOSCNSR276dgWEZVYwN7xdkLVmCQfRgi4UXAMD1
         hHqEf8OdqedQWJINoA99HIq7j6DCC3eu0OenLqb6YcnV57hhWRkxOZaH9qQNB9YoSEd7
         KJ6wQdax74Mxmw7EGLEv+47+VfndclFNjfuMTfcZ99/CvUa6BXLlu6N+P7TzjPaiTSq3
         gyFy2yxWe1dD8ZoWNelEDxSK/7CVV+kT3dJfi8H71MsD2juf0u2fZDrF4Kpqa0Bern2/
         eWXnbIV8eYAVInipwQ39xiDGPvmczWSXAM4rq96kJd3kLSjKp40iT6cEWmAqItnKUti1
         IehQ==
X-Gm-Message-State: AOAM532UcPkCz7aMrzpXr8Uhl/tG599gX2hexMDlttBa+I36Ik6dJEhx
        /fkiNG9Y+g7+enIq6ZmftvEqhQ==
X-Google-Smtp-Source: ABdhPJwc9o/GpyxH3ZCLVM03OcQ68Uc8ackw6kiGkUvBzdhNHFtmZn5RP3pa5RFQttw46CMqvrjduw==
X-Received: by 2002:a63:de0a:: with SMTP id f10mr883375pgg.88.1599608525970;
        Tue, 08 Sep 2020 16:42:05 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j4sm490283pfd.101.2020.09.08.16.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 16:42:05 -0700 (PDT)
Subject: Re: [PATCH] block: only call sched requeue_request() for scheduled
 requests
To:     Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Yang Yang <yang.yang@vivo.com>,
        Paolo Valente <paolo.valente@linaro.org>
References: <80b64d8a0408e7c8c30b363aaf6d39e735521c1d.1599597940.git.osandov@osandov.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3ec128e1-2f0c-205d-a700-e215f5f7c451@kernel.dk>
Date:   Tue, 8 Sep 2020 17:42:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <80b64d8a0408e7c8c30b363aaf6d39e735521c1d.1599597940.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/8/20 2:46 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Yang Yang reported the following crash caused by requeueing a flush
> request in Kyber:
> 
>   [    2.517297] Unable to handle kernel paging request at virtual address ffffffd8071c0b00
>   ...
>   [    2.517468] pc : clear_bit+0x18/0x2c
>   [    2.517502] lr : sbitmap_queue_clear+0x40/0x228
>   [    2.517503] sp : ffffff800832bc60 pstate : 00c00145
>   ...
>   [    2.517599] Process ksoftirqd/5 (pid: 51, stack limit = 0xffffff8008328000)
>   [    2.517602] Call trace:
>   [    2.517606]  clear_bit+0x18/0x2c
>   [    2.517619]  kyber_finish_request+0x74/0x80
>   [    2.517627]  blk_mq_requeue_request+0x3c/0xc0
>   [    2.517637]  __scsi_queue_insert+0x11c/0x148
>   [    2.517640]  scsi_softirq_done+0x114/0x130
>   [    2.517643]  blk_done_softirq+0x7c/0xb0
>   [    2.517651]  __do_softirq+0x208/0x3bc
>   [    2.517657]  run_ksoftirqd+0x34/0x60
>   [    2.517663]  smpboot_thread_fn+0x1c4/0x2c0
>   [    2.517667]  kthread+0x110/0x120
>   [    2.517669]  ret_from_fork+0x10/0x18
> 
> This happens because Kyber doesn't track flush requests, so
> kyber_finish_request() reads a garbage domain token. Only call the
> scheduler's requeue_request() hook if RQF_ELVPRIV is set (like we do for
> the finish_request() hook in blk_mq_free_request()). Now that we're
> handling it in blk-mq, also remove the check from BFQ.

Thanks, applied.

-- 
Jens Axboe

