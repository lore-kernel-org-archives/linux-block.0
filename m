Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E8FC04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B596C20811
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B596C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeLLHQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:16:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37726 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLHQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 02:16:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so8445535pfb.4;
        Tue, 11 Dec 2018 23:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yOVMtCtUcfQcSP2Lof2a7AOpYVORsX8V+l7i0Vf25jg=;
        b=RhRjp+J1tq3yFQQjIonUxmPI7NHTV3b39gsgyZt6yp+TBPmA3W2SMckm1LLlGFLd00
         XSCompS419BPQsWP9HoM+kfrcC2MZQA7fWg1epa9RhZ6TDYDSzhR6roAzEYC79e3uEum
         +jFi9JAlgK46SZ4XeN+t4vPKcUJSTagskpk66n7m/geJnh8kM9mfKulsY4bKRv75aUfY
         ubhggQMr/et3Pt5x0y/zYZw4snY8KLckkx9L0WBL+CGulMBdSFJQral+7XHj/NC67bpX
         e796DCBxrqxzdtE+d6FtXwoJlB7+Oyjy9hgP6Q7Nmj2/FGG+K0fIfEtLdC93Aa5skLeI
         3Y3w==
X-Gm-Message-State: AA+aEWbL9yIKafDRi1wdt4tkhdLkcorI3zH+hoBLxEpSD08L7vZl49Bz
        CY6NCk/BtQntF6rNbvKsubw=
X-Google-Smtp-Source: AFSGD/WtwUFAwIRURab6gevrGtOvlb2n22oHjyqZ4T08KIdhS1OgGyqE8GGWMu4xY89R8wsG/irocw==
X-Received: by 2002:a63:5e43:: with SMTP id s64mr17496912pgb.101.1544598999477;
        Tue, 11 Dec 2018 23:16:39 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id c23sm20283668pfi.83.2018.12.11.23.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 23:16:38 -0800 (PST)
Subject: Re: [PATCH RFC 0/4] restore polling to nvme-rdma
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Keith Busch <keith.busch@intel.com>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181212070756.GC28461@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <937fc9db-1248-fcad-1b59-627c4b44ef16@grimberg.me>
Date:   Tue, 11 Dec 2018 23:16:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212070756.GC28461@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Add an additional queue mapping for polling queues that will
>> host polling for latency critical I/O.
>>
>> One caveat is that we don't want these queues to be pure polling
>> as we don't want to bother with polling for the initial nvmf connect
>> I/O. Hence, introduce ib_change_cq_ctx that will modify the cq polling
>> context from SOFTIRQ to DIRECT.
> 
> So do we really care?  Yes, polling for the initial connect is not
> exactly efficient, but then again it doesn't happen all that often.
> 
> Except for efficiency is there any problem with just starting out
> in polling mode?

I found it cumbersome so I didn't really consider it...
Isn't it a bit awkward? we will need to implement polled connect
locally in nvme-rdma (because fabrics doesn't know anything about
queues, hctx or polling).

I'm open to looking at it if you think that this is better. Note that if
we had the CQ in our hands, we would do exactly what we did here
effectively: use interrupt for the connect and then simply not
re-arm it again and poll... Should we poll the connect just because
we are behind the CQ API?
