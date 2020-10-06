Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19CEC4363D
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 13:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F9D2083B
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 13:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eLcRUkG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJFNaf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 09:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFNae (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 09:30:34 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0AC061755
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 06:30:33 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id u9so1278995ilj.7
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2020 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nxheCNIBk27fHu3SnrcxO61/+dDNHmsAZ+V/ZMEW1FQ=;
        b=eLcRUkG2BvfNZR/tqkzKvzcLDyo/A6+biNXbVCHVso0GMsT/R5rqPedObSgaDe9L8c
         x0z6llgsNEBoVzsgqpOaFfZ9JiPbsICxfW7EziTA0SG+UDfU3+TFx8yDCkzQZ9jwPUDW
         9KrsUS04E/nlNYGV9xNGXMqKnYGYloDBAJCgd0gq2oRHsItaZLz32OR39N1g24dgtK9j
         eGJbie/Rfp+ie0uFEvMdRtZG0FFl9mjwlbnWOcsw9xz143eu8uMwTFT5Hew5ULmMJvDN
         iTSkUk7cXgD6eFxPcmNfN4cFenqUrB0GGG2jvdiZyds5NoT2vnOIN0ZmzoAeoWoe87d6
         GIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nxheCNIBk27fHu3SnrcxO61/+dDNHmsAZ+V/ZMEW1FQ=;
        b=hmZ+NZ34wSM0GzSCEo/jXnW62jsvpfyGUq5KTLjKPLFSuLe26jRMEP5X+8clM5dNXh
         yHs+Tt72Kh+7b9XESRIO1y42+DfBeXoSO3orKPy4JhmLqBSPEDUBb6cvNrdzZVKeYmTx
         /J90yx1TPB/9nJ53+oVO0RnTmkPTdizFgVreIDTS8za1h1hR7cHi0REJSBzSZ1/OakA6
         AzYoJjVmdvqJH/tA2mV4jtlkg3y7Htesqsfol0boozZ5DtwGYVq6Iryi1uOUMAZdcyxw
         Gb6LKEA2x8pONOJboqOY+Ri40pEpmM6Q5500XwDlloa1MsllD9Tn6ZyoDCN3BsMCWSZ8
         ZNdw==
X-Gm-Message-State: AOAM5300MTCr/wwrTcChBBhY4TvBFOl0tFrg5Oxi0uqJEt5juI6dc6Yh
        7tRjvXNUvlKJ//cYuqn0MfgXlA==
X-Google-Smtp-Source: ABdhPJyYNSRknztkzPHBli45617VnJ7M3gsP6dNnh3SvCD7hO2X+20R3o/jN3dD0tjR3bCKJt301AA==
X-Received: by 2002:a05:6e02:547:: with SMTP id i7mr3863840ils.0.1601991032389;
        Tue, 06 Oct 2020 06:30:32 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y26sm1511291iol.24.2020.10.06.06.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 06:30:31 -0700 (PDT)
Subject: Re: [PATCH V7 0/2] percpu_ref & block: reduce memory footprint of
 percpu_ref in fast path
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20201001154842.26896-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8b0828ee-8b86-a505-842b-f86968591bfe@kernel.dk>
Date:   Tue, 6 Oct 2020 07:30:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001154842.26896-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/20 9:48 AM, Ming Lei wrote:
> Hi,
> 
> The 1st patch removes memory footprint of percpu_ref in fast path
> from 7 words to 2 words, since it is often used in fast path and
> embedded in user struct.
> 
> The 2nd patch moves .q_usage_counter to 1st cacheline of
> 'request_queue'.
> 
> Simple test on null_blk shows ~2% IOPS boost on one 16cores(two threads
> per core) machine, dual socket/numa.

Applied, thanks.

-- 
Jens Axboe

