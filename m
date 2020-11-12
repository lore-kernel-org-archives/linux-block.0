Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9BDC2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 15:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E766216C4
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 15:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgKLPMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 10:12:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40857 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLPMP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 10:12:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id j5so2922966plk.7
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2020 07:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ypzV94H0yaYtd5pFfqZJmptSsWf67IW2o2OeYzuapo=;
        b=GsKSo9j/1k1mO2/3+IoiCzDHwk3oeVemu5JqDmsKnPJod+TTguWYllEHQZfl3/hlMZ
         K9WIZYQy6EF5aQGezseGDN3DJdQFpSOfbdbYeUMnpBURL83wk/ltnwVCdONbO7PkkhG8
         OSQ8cbkxPYA7pG0SxY9MSN5/bOmv036yxEWpkZBotbn2j1RgOh8KMFiaBMb4kU/LJrw9
         EHwdyb0HArETFqfxh0IKSezdBGO7AFoPppiyR6jzscDhXHTlFfRe035+Wi0PiXUHhCJP
         ujOIYjOnf7fW3v7Cnu9v8NjpqKMPP7sAfYMeST8j/Ok0EatZNsmUJgEdEK7gns3XENJO
         L5DA==
X-Gm-Message-State: AOAM5316EIiGPRohSjmQcUedRsbMTAEUDoCTAkokEo9i0cvvT/aaONgb
        Eb5Kj8fJzbEflKNMPH6u5y0=
X-Google-Smtp-Source: ABdhPJxBuNQQ2bMqbglbC0YPn4oTwpZKmcJrsexAzX/EF4QkGxC/cBEdIlPVf3P+QL2Pjsoqe3mVBQ==
X-Received: by 2002:a17:902:eb42:b029:d6:ba60:ba41 with SMTP id i2-20020a170902eb42b02900d6ba60ba41mr25994882pli.0.1605193934350;
        Thu, 12 Nov 2020 07:12:14 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id i11sm6921014pfq.156.2020.11.12.07.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:12:13 -0800 (PST)
Subject: Re: [PATCH 3/3] Revert "block: Fix a lockdep complaint triggered by
 request queue flushing"
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Hannes Reinecke <hare@suse.de>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-4-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <43bd8381-487b-098d-8e62-3946c75bcd8a@acm.org>
Date:   Thu, 12 Nov 2020 07:12:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201112075526.947079-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/20 11:55 PM, Ming Lei wrote:
> This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.
> 
> Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
> locking' by nvme-loop's lock class, no need to apply dynamically
> allocated lock class key, so revert commit b3c6a5997541("block: Fix a
> lockdep complaint triggered by request queue flushing").
> 
> This way fixes horrible SCSI probe delay issue on megaraid_sas, and it
> is reported the whole probe may take more than half an hour.

The code touched by this patch is compiled out with locked disabled so
it is not clear to me how this patch could affect a probe delay for
megaraid_sas? Has the megaraid_sas probe issue perhaps not been root
caused correctly?

Thanks,

Bart.
