Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC04C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C8C20A8B
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 15:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgKLP3S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 10:29:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44486 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgKLP3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 10:29:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id b3so2932463pls.11
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2020 07:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mfWwkX2VqCJnpSe3f6b7gGDcCnnDVIbQGc+a3cLC1XQ=;
        b=ctj7g/mJPP+EdpF4mDTw1CS64m7osdFgApwoi5GJtCzW9Sk25imV4b4WOm5ydCIX49
         yPHjcrcaCtB/R6jy8UmJtxurW3rQ7SNa/VvJuNmXeBSRgCx2Y/jtJ6IY+BQBsBIAoXnp
         G3htLrg2Qi4j8GbPsdSoNS9zwqeJ06CNCx1Yrs0Co7KehsQ50K1JIuIBFP98tCwB+yAF
         4r4ix5c+EnxWQBRR/U9/YT0uvz17P+3tj8Jz9VhW1EluplraFiUVnYZ4ol/kwPhWQJx3
         7c/5nrfv55ab8LiUF+Od2cuaqck45Srtpg8HurDmucbuuIyhU6dXRSJ71tNsNsvwWWK3
         vfXA==
X-Gm-Message-State: AOAM531o/6aSnlYbRd1pSOJeI9+lxznyNC9wy0pze8k30Jr4sw13HtfR
        e0rkN7EqlQNieE7jtWccGoc=
X-Google-Smtp-Source: ABdhPJxOj52iktluMxLhGtb7Uxm7Tvphkd8qB2HY4bWSTc9zsAj9RHsxcwe7GxmwCtCA92aOoYD40A==
X-Received: by 2002:a17:902:a608:b029:d6:a1fc:ab75 with SMTP id u8-20020a170902a608b02900d6a1fcab75mr247999plq.18.1605194956874;
        Thu, 12 Nov 2020 07:29:16 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j1sm6672257pfa.96.2020.11.12.07.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:29:15 -0800 (PST)
Subject: Re: [PATCH 3/3] Revert "block: Fix a lockdep complaint triggered by
 request queue flushing"
From:   Bart Van Assche <bvanassche@acm.org>
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
 <43bd8381-487b-098d-8e62-3946c75bcd8a@acm.org>
Message-ID: <e0392f5e-1de2-d56b-027b-4bb4d041fdcc@acm.org>
Date:   Thu, 12 Nov 2020 07:29:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <43bd8381-487b-098d-8e62-3946c75bcd8a@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/20 7:12 AM, Bart Van Assche wrote:
> On 11/11/20 11:55 PM, Ming Lei wrote:
>> This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.
>>
>> Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
>> locking' by nvme-loop's lock class, no need to apply dynamically
>> allocated lock class key, so revert commit b3c6a5997541("block: Fix a
>> lockdep complaint triggered by request queue flushing").
>>
>> This way fixes horrible SCSI probe delay issue on megaraid_sas, and it
>> is reported the whole probe may take more than half an hour.
> 
> The code touched by this patch is compiled out with locked disabled so
> it is not clear to me how this patch could affect a probe delay for
> megaraid_sas? Has the megaraid_sas probe issue perhaps not been root
> caused correctly?

(replying to my own email)

I found the answer in the descriptions of the previous patches of this
series. I think this patch would benefit from a more complete patch
description.

Thanks,

Bart.
