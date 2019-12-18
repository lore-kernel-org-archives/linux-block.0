Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B61EC43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 01:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA5021582
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 01:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LN64OzUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLRB2G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:28:06 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42799 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfLRB2G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 20:28:06 -0500
Received: by mail-il1-f194.google.com with SMTP id a6so235021ili.9
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 17:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rsdijfwxXIxEdfTf0BJ4NmtNQn2EATypQJ6GWjnlpeA=;
        b=LN64OzUR0PK6WuZ1fEl4fu8/YArhpB0cNXjvLjDyVu4uSbb1wZHaJI8pdSOrfCaAqt
         Je1XxbdQjFviM1dg0yITmdQcncyA9VHiL2PYu9cSm9o5LO1ByfFpaXGx26MECSkeYjef
         C9KJXeSU78bQwI4zGaNwJ6Tq0wCp7Zncnv7esvgYC48tD/qA1k0GF/RiDC94FV+uRlUp
         Mvzyzq6WWkigWT3qBTJFetlWPdXCO2NR4xmIB8dkyRcmivmTtTl6jo39EWNBxI67bFU8
         7mIKH/oIIoCo2Y6j7HdvZ6DH5GkQbIaei8i8njuBAwsfZ7fmNqBKpLgDU55yjpsQ6n87
         f1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rsdijfwxXIxEdfTf0BJ4NmtNQn2EATypQJ6GWjnlpeA=;
        b=dNYA7EjpUkz0nMnv94oioUxuxbF80MfGREibm+GbCjGpOh1rwZpiHfSBAkxEEEYOwf
         YR/QdNAscZEkCVfDR5GRqA9+bRBSM1VCgLa4KzfDlgYaexgjt9WP0w7Ln4gKzV7Gojdt
         SKEyMYEls7AkvWoUoaHMxk0sY8SJeGivxo9CrcbK9d6A7ryX0Z2SBfS2JvgkL9yVDcyJ
         3RUEjtwyq2WO0QuOJUsn9/gZxyxSFdXB9ip7wDKWUkkKwjG1yHXAuxth4tuMMqgEKhbF
         wi0jhGPB3SzpYcKZI9/McjZVYdRAYJmyCWioI2MJZdPrAZPwjsrL7vFd4cWKX/Tt0+V4
         sYDA==
X-Gm-Message-State: APjAAAVx2phCX47sFe4wW5nmeS/XSCIdzTIpYpZos/JJ5SbaktVkPHVO
        UL5d2UHEnFuy23HxVeq32VgmiQ==
X-Google-Smtp-Source: APXvYqxMoNlpt/TC/axYgAFYjxnhzrkeZChcmx0aIRqCHbKGd9YPVayHYz3Z+3XrRumsEypM7n7L1Q==
X-Received: by 2002:a92:45d2:: with SMTP id z79mr386262ilj.76.1576632485203;
        Tue, 17 Dec 2019 17:28:05 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e5sm146581ilq.77.2019.12.17.17.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 17:28:04 -0800 (PST)
Subject: Re: [PATCH] block: make the io_ticks counter more accurate
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, xlpang@linux.alibaba.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191217142828.79295-1-wenyang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <658ba1d9-45b3-db85-250d-7a1a9328e9ff@kernel.dk>
Date:   Tue, 17 Dec 2019 18:28:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217142828.79295-1-wenyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/19 7:28 AM, Wen Yang wrote:
> Instead of the jiffies, we should update the io_ticks counter
> with the passed in parameter 'now'.

But they are not the same clock source...

-- 
Jens Axboe

