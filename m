Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB39DCA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 21:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AD121872
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 21:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lILpxe+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfJYVpi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:45:38 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36323 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYVpi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 17:45:38 -0400
Received: by mail-il1-f193.google.com with SMTP id s75so3109514ilc.3
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 14:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KSmmoXpgZgZZPMYFzmD/g27FCNe11Jnk66TJmTgerKc=;
        b=lILpxe+dSD4ZqxhlWaZZugrBzAtaGP2t5gk7ACVmzl15g128OUt/KN4IW9OlZrWbvX
         iwHlyi662oPotQf8iIVESpoNVT47YrZ52Jflq9j4XxCNYfZ7SeZJXcU6GIsV6XkTJziJ
         2ExGk6KBBQTHjRm0bbPXs3Zg9HHuLL7bugOsf9KVtiM5+fDepsEFbtWZVBGGC909oq4p
         3B2tMaH9pm70b89rkW/4uumkTXv6uxHnhU21cPNn8VlJkmHOz/7LYn1moClrcSA7wQmw
         lUxLIdsAJPhirVBhGEJ0DBqgAJN7zJH6M4ioC8LEt7wRmRSlpHwGWmIrZPI9vSlQZtmx
         vCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KSmmoXpgZgZZPMYFzmD/g27FCNe11Jnk66TJmTgerKc=;
        b=h2/zI+hf2YssHdvTHrtxjIM41caeVZbyalqieHGQy76Pa0XrukP5mBnyvHYdOGNmZP
         /YjYv9DHAuJKFk+CJDdcFanpSXp4WF0yGyMFKd/hSut/Pkf11K9tM9oA3n7rInKyWEZI
         Bi7szcUblRpE3s4ZCMUeIjBXUXWbPl3nB0LjhvHG0gHWAHOOxigVZft3TeXZnFDrfIKD
         8Rc4Am/ggOk3aqdUXaD1zi91Px2bQTZs0l1lJrKr47fgtNB7uYBz8l5B8QcYxOmMrArL
         EXYf5jiQd71mnl9b3FPPqAj4UHsxjYu4NPp+FqIFvl9rPI3Qco9l2EpEKwhFEX3JlMH1
         Pe1g==
X-Gm-Message-State: APjAAAWHFWIrVQHQBXl3eOcS0IU0mkrc7pMdZGCg7AgrxEe1FYYk0yuB
        ptYvWZhVvMGvobhypQ7pdzbT62keze0o9g==
X-Google-Smtp-Source: APXvYqz/y5GlAsCN1ZBMSeWQkipoXLxSAIdIvtlbEegDLbX2VTABTXFerzq6H09Zjvkz3ZXhRikjvQ==
X-Received: by 2002:a05:6e02:c02:: with SMTP id d2mr7075626ile.261.1572039936417;
        Fri, 25 Oct 2019 14:45:36 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w75sm498961ill.78.2019.10.25.14.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 14:45:35 -0700 (PDT)
Subject: Re: [PATCH 2/4] io_uring: io_uring: add support for async work
 inheriting files
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, jannh@google.com
References: <20191025173037.13486-1-axboe@kernel.dk>
 <20191025173037.13486-3-axboe@kernel.dk>
 <c33f7137-5b54-c588-f4e8-dd7e1e03edf3@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0ea19a52-a1cf-ae8a-82d7-f4ffb3c0286b@kernel.dk>
Date:   Fri, 25 Oct 2019 15:45:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c33f7137-5b54-c588-f4e8-dd7e1e03edf3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 3:31 PM, Pavel Begunkov wrote:
> On 25/10/2019 20:30, Jens Axboe wrote:
>> +static int io_grab_files(struct io_ring_ctx *ctx, struct io_kiocb *req)
>> +{
>> +	int ret = -EBADF;
>> +
>> +	rcu_read_lock();
>> +	spin_lock_irq(&ctx->inflight_lock);
>> +	/*
>> +	 * We use the f_ops->flush() handler to ensure that we can flush
>> +	 * out work accessing these files if the fd is closed. Check if
>> +	 * the fd has changed since we started down this path, and disallow
>> +	 * this operation if it has.
>> +	 */
>> +	if (fcheck(req->submit.ring_fd) == req->submit.ring_file) {
> Can we get here from io_submit_sqes()?
> ring_fd will be uninitialised in this case.

We can't, we disallow submission of any opcode (for now just accept)
from the sq thread that needs a file table.

-- 
Jens Axboe

