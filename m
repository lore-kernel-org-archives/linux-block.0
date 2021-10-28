Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC82C433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B525D610CB
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJ1QBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhJ1QBD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 12:01:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D063EC061570
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 08:58:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j35-20020a05600c1c2300b0032caeca81b7so4946438wms.0
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CZ+88hwHts574bnAylE3naMBO9XkXlnONWenPRHFnic=;
        b=NZUBENnqux3jfd0C9v2Cxr9g+WN3nWNc0ETGXFv9bL19B3oXEcN+g+VOyme6ijhDch
         5n93/n0MQCj433gA5nvfOpnWQEEiBFdoasREHD2KgZE8D8Y1x2q68dJbwy8vuMOPEwvM
         K8qBNcpYrrArwAG/qMf6uhn55hXwshqgtUqGMNZ8f9eip6CdGIR7c8+FmdkGQ27mKyef
         PfNm2XIikkdvJtEiJHpFthr3diLWOOCxYZaEz0HOFvExc/8/j+vMVS1eI/SHq2Qwi8ex
         UhveAWczdNj1EMbQPYZlXy0Hi9NZaGOIHXx0vJNFPEcdTboxV/2TQhuSHCd0KAA7Eeob
         x7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CZ+88hwHts574bnAylE3naMBO9XkXlnONWenPRHFnic=;
        b=QJUD1TWgrzQXNNvpLWng+ArVlQrWKEVJtqFV8YtoxDwHTowUKtHgrpib2DUJHnue92
         5RTNLWULLsf0sBKynnGNKFP1B4hvp7o0l75aMfil49eYr6xhhSIB3kP/QesWtsSHE2jc
         7AD+7uWaxoMPVF/q6x3QExxnLsl3RiYKVs06NxeZFrTnuFksqptGfbLoaxfH9R9mE0Rg
         0qjW2IYI/RDJom4jUOGn5rHqwa1A4MA0H9oi3MMyZxsn69R5UlmqkDuQQF/uSXH8LlO0
         9LyqRcDzFhPHsYs8ywGPCIDtkB67Okpx7cK34nh8iEJ66sPuBxI3L/lDslKFGW4G9NCX
         4jmA==
X-Gm-Message-State: AOAM5338n9UnKyE0hqIVFt5Vz8/RfvE1jPqSyRi1mAtG8tDitOUTV9JF
        kIKFINrEAvH6KwKNklc1XcQPABs6ipk=
X-Google-Smtp-Source: ABdhPJzHKrpeqcysDn9pKyxTTJ7YV9SEktLhCNLvNS9Ohk1HXMQ9GTF1mnITxy3NkIyzt2a6fUmiTw==
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr5404878wmj.91.1635436714453;
        Thu, 28 Oct 2021 08:58:34 -0700 (PDT)
Received: from [192.168.8.198] ([148.252.129.16])
        by smtp.gmail.com with ESMTPSA id w14sm2720324wmi.37.2021.10.28.08.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 08:58:34 -0700 (PDT)
Message-ID: <64016c86-188e-916e-662d-b33431dec946@gmail.com>
Date:   Thu, 28 Oct 2021 16:56:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/3] implement direct IO with integrity
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Mikhail Malygin <m.malygin@yadro.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Alexander Buev <a.buev@yadro.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux@yadro.com" <linux@yadro.com>
References: <20211028112406.101314-1-a.buev@yadro.com>
 <bc336e90-378e-6016-ea1c-d519290dce5f@kernel.dk>
 <20211028151851.GC9468@lst.de>
 <85a4c250-c189-db5f-0625-2aa4bd1305f8@kernel.dk>
 <AAD8717C-E050-47C0-B8C9-119C8F51B47D@yadro.com>
 <14dcfef2-ac21-35a2-a97b-9cee39b079a1@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <14dcfef2-ac21-35a2-a97b-9cee39b079a1@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 16:50, Jens Axboe wrote:
> On 10/28/21 9:44 AM, Mikhail Malygin wrote:
>> Thanks for the feedback, we’ll submit and updated version of the series.
>>
>> The only question is regarding uapi: should we add a separate opcodes
>> for read/write or use existing opcodes with the flag in the
>> io_uring_sqe.rw_flags field?
>>
>> The flag was discussed in the another submission, where it was
>> considered to be a better approach over opcodes:
>> https://patchwork.kernel.org/project/linux-block/patch/20200226083719.4389-2-bob.liu@oracle.com/
> 
> Separate opcodes is, at least to me, definitely the way to go. Just
> looking at the code needing to tap into weird spots for PI is enough to
> make that call. On top of that, it also allows you to cleanly define
> this command and (hopefully?) avoid that weirdness with implied PI in
> the last iovec.

Reminds me struggles with writing encoded data to btrfs. I believe
Omar did go for RWF_ENCODED flag, right?

-- 
Pavel Begunkov
