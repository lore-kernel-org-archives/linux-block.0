Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0904AC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EDB2083D
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1BHMTqWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfCYQPM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:15:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50689 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYQPL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 12:15:11 -0400
Received: by mail-it1-f194.google.com with SMTP id m137so14840749ita.0
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pqYUKVKMwv5YvhQa8I/3FZP8NUyCezJ/K6L0O0AKUWg=;
        b=1BHMTqWgTQOGU1QcRFSfGlW0TLvJb8ToAg5PewmnCRznMEZLYJ0nJGeTrwQjfo1RZh
         Qj/op9hkykWQJL4K1RYhgmWKr63lJeAT7vatheTSCR44PMsuIbTjjHjev0iSB6kYgkqa
         EKY2ovK74Jpsy7LAnsIVJqtyEs8K8zqKYvaNTwpprHasIFtL8qz9BLuMcua0Hl+Qkhn/
         nzSeadq1/Y6jio5y1LSFyhdhBVsDioDvkHD9Ph6feGBOWn+IiB6YUCCRIaWGns2WkD92
         qgLTXOZG1irDj/TOuuLk/siDBdhRg474JSQspPnL2+QCtWB7uGjE3GILplHA2HAmkyEy
         JzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pqYUKVKMwv5YvhQa8I/3FZP8NUyCezJ/K6L0O0AKUWg=;
        b=YikWpjal6QSsH9T9YSwO+5J7uF2dsRrBY/AfXlDzUxgWB3ytFLQI8EZ/vmSabuNmRv
         BD3BDceioijxGX9dAjSowEAtPhRl5prHVsxPQjvrtxcuacfbNNvjrkzoi3YTNbYA/42B
         VX/Czeajjv703LjZ63u7uEdtOUolG7uzePS8sbyYEjWtKjSvMzWJA4jYvVjtSxs8/Utm
         62pHHFwZ6sEE9NlzCnYM23aPX/G2y//OKHfSuZ+T7kVA5gO8Vn2L0+nN2CYn/2bwdY7E
         K4ZHvy7nd2Vq+9pm58qegCOsWsjb1LtwSdiFbAyPjhIuUOHg7f0sIJjDmnxZRBpFC55H
         mZ4g==
X-Gm-Message-State: APjAAAWLo0dnRKoyJIKSj3wadh/rpU6jCTOIgI+iBzGahf/zw5Sl6Lzg
        bVg/7jUEPFO1cUwKwdAUNxZovQ==
X-Google-Smtp-Source: APXvYqzhokJ/W9aLEg/odcdA2NQFO9N2nplNZZZZbt4De391Ejqe3S2SAaKA0D4tfu3m+PR/1pjmtw==
X-Received: by 2002:a02:1ac3:: with SMTP id 186mr18374282jai.96.1553530510808;
        Mon, 25 Mar 2019 09:15:10 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i23sm6758795ion.40.2019.03.25.09.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:15:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: fix big-endian compat signal mask handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190325143521.34928-1-arnd@arndb.de>
 <a29338b9-60ad-a4da-da9d-a0c522a5b9df@kernel.dk>
 <CAK8P3a2SpydaLZijzUXxCzMKSEv3ymfpOCO4xSZOVfz2cwFxAQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <52bbd23b-3bda-31fc-3f38-16749b90be4c@kernel.dk>
Date:   Mon, 25 Mar 2019 10:15:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2SpydaLZijzUXxCzMKSEv3ymfpOCO4xSZOVfz2cwFxAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 10:11 AM, Arnd Bergmann wrote:
> On Mon, Mar 25, 2019 at 5:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 3/25/19 8:34 AM, Arnd Bergmann wrote:
>>> On big-endian architectures, the signal masks are differnet
>>> between 32-bit and 64-bit tasks, so we have to use a different
>>> function for reading them from user space.
>>>
>>> io_cqring_wait() initially got this wrong, and always interprets
>>> this as a native structure. This is ok on x86 and most arm64,
>>> but not on s390, ppc64be, mips64be, sparc64 and parisc.
>>
>> Thanks Arnd, applied.
>>
>> Was there a 2/2 patch? I only received this one, 1/2.
> 
> Sorry I missed you on Cc:
> https://lore.kernel.org/lkml/20190325144737.703921-1-arnd@arndb.de/T/#u
> 
> This one went out to all the affected arch maintainers.

Ah gotcha, just wanted to make sure I didn't miss a patch.

-- 
Jens Axboe

