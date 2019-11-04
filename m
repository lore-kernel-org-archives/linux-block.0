Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50946CA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FB421D71
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JMLrJvt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfKDOOf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:14:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45665 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfKDOOf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 09:14:35 -0500
Received: by mail-io1-f67.google.com with SMTP id s17so18535770iol.12
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 06:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=en9lP7o0Q1kz/RzpShy4rQmKCme7CeoeGWvCfhUNqEg=;
        b=JMLrJvt8y3UvR9uy/01L1uoolLtrbxoXEB8UBP+ZkNhlSZ1273w4nV5ARe8IOl9GdY
         niCazUySf1kN5gfvmFVv0eVarYVkFqqXwXC9V9IBoROubMT1eVj7PjyDfkTTtH9m6ctL
         j3VUfQB8GaB5sJMt61nQ/uz5I5Ar7rtOQ8vMb17fqlaugoQkouZlpOaxOyEOq6pydSRx
         u+19pMq/8WDXaUoD0EtSNNwTrq/viRO/jy4ps63dhQH6cRE0K3CkCivTzLcoSEV7uetq
         iDHWbmCSQYhpgDYkfakD1C8AT9+Vp7/h9SbzqQ/fg54ZVcQRNPHK6AmT4UB9RhYMwU2Q
         snHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=en9lP7o0Q1kz/RzpShy4rQmKCme7CeoeGWvCfhUNqEg=;
        b=ICuz1MV8Wec3im7XyyoERSTOZlDMx7gl8kffLzM0pDbYCeuzJyjnLIsbTSPEL3pVxU
         d5zNo2rGZKG/L9LMhTy1qoKJ24UcEjiFmi5MnXXSBgrBKkSERYmVxIcXpMCimXvBzMZK
         80+X+tEhWRXs2hlQ6kZby+gU14p9cbyNanGEsBDYTplWJcW37381Pw7kMolzA8tlbVpc
         TNOWwATIlem0jJly7gIW3YqyabkTIYXascmbkzm8ZNWUXr5I+4foWcJKVZ6e1V/q3lA6
         v6g1lFPd9Gv26jnI8AmjZYmzsyeO0N2cMoaK7GukFacV2CjfhwlAy8YmjDKBMVzBS2s7
         8hOA==
X-Gm-Message-State: APjAAAUfdn4829VSk7nmhXLF2Ab0JqSVeltqFFmZJzSHySRg00c9eJHi
        83pS4sPNsBvZCnhaVRjv5ueXTXjBLe/tVg==
X-Google-Smtp-Source: APXvYqzFebQ3nI4jM5CDl92Xo3vgSa+YCLxA+WyDNM5iSBS5rFXoP6m8lXjDmBFyYLB3BzHRTkZRWg==
X-Received: by 2002:a05:6638:219:: with SMTP id e25mr754530jaq.105.1572876872949;
        Mon, 04 Nov 2019 06:14:32 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s20sm1643131ilc.35.2019.11.04.06.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 06:14:32 -0800 (PST)
Subject: Re: [PATCH] blk-mq: make sure that line break can be printed
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20191104082653.3279-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a87fae8b-c4b1-4b71-aa81-3c31b1207d62@kernel.dk>
Date:   Mon, 4 Nov 2019 07:14:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104082653.3279-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 1:26 AM, Ming Lei wrote:
> 8962842ca5ab ("blk-mq: avoid sysfs buffer overflow with too many CPU cores")
> avoids sysfs buffer overflow, and reserves one charactor for line break.
> However, the last snprintf() doesn't get correct 'size' parameter passed
> in, so fixed it.
> 
> Fixes: 8962842ca5ab ("blk-mq: avoid sysfs buffer overflow with too many CPU cores")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Applied, thanks.

-- 
Jens Axboe

