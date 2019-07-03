Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BDFC5B57D
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 01:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24AE20645
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 01:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Cx5YBwQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGCBKR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:10:17 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:37776 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCBKR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 21:10:17 -0400
Received: by mail-pl1-f172.google.com with SMTP id bh12so240630plb.4
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 18:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SUyMsQTAT4Xex1w0m5orXD/uZpdvPJFFkpqi7cw7ARc=;
        b=Cx5YBwQxfHbcSYTVPaaiJ095/bU5COtLFsgp3iJFRhkzhR3ZpKFNRIDHKG25E65Vck
         emq5ODbKKS6w1+ZAAPrC8NrV/i+C6hhZPdPpF/cHVgPU/vb7CFk5gokRVt8m86TxyNzJ
         ztNT63j2t/v10F5hsOtK8vz/Ar+61linqF5VkxecGZYg1ftz0dLQ/0RbEanr5gyTPWlH
         S4lPmzMl3mBr2q+cXP6ZiUpI3+7eDGak6dv/DtzS2BdDLgQXQPvQzpeQOJ6uHc0NO/pk
         yMBBorh6ye5whXiOcXma9ZrWNqY2UCyYdgThYOvdlNlYQoz02NsjaR108ZkVky8WbHXl
         9zdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SUyMsQTAT4Xex1w0m5orXD/uZpdvPJFFkpqi7cw7ARc=;
        b=IVUr0C+VKXN9mf1/u9ihzt4MhTgwzsqTnYjefnNXS0k5eNU86tMNRqK7o3rXtS75js
         XpgQdZNWs4eonR0fFBdJeF/pFR+aStd4fsLytjWLR3kkCKZotI5ZarxGvE7hWVEDHKbQ
         r2q/b+ziI+lwy8xOPro2Ipbal02oCADNfRuIsoNW/EYl5Zl+QPb2nFHXqFEsI8i7uam2
         Cu0yZf6xenaJRo7en4oVDkC/KTbBNEK6d+SiLyHJUj0dZoOvq1lvIvV4tzUM2gErfi14
         BV33IvsdLu1rDbRiDE0rGUUZtr5R4czRADskaHiF5e1Ikr+LC2G+0HyCy+vohVFvuAde
         oZ8Q==
X-Gm-Message-State: APjAAAX7jsohCL8QR4F/lAFSw4MMho/DCAWrr9PC7HDpj0ZukwPRnZxj
        +kguwRFFnIRbP4WaUG9HWbnnlz1GFmHNAg==
X-Google-Smtp-Source: APXvYqxW36FHRIjXYS5pXxmunWiBZKGCXGnyaRwQqwIRANxRpZzwuv+sjdiy6l2cN0We/BCxA+MC1A==
X-Received: by 2002:a17:902:8696:: with SMTP id g22mr37716047plo.249.1562116215616;
        Tue, 02 Jul 2019 18:10:15 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id o95sm214586pjb.4.2019.07.02.18.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 18:10:14 -0700 (PDT)
Subject: Re: remove bi_phys_segments and related cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
References: <20190606102904.4024-1-hch@lst.de>
 <a703a5cb-1e39-6194-698a-56dbc4577f25@fb.com>
 <bbc9baba-19f2-03ec-59dc-adab225eb3b2@kernel.dk>
 <20190702133406.GC15874@lst.de>
 <bfe8a4b5-901e-5ac4-e11c-0e6ccc4faec2@kernel.dk>
 <20190702182934.GA20763@lst.de>
 <ef4a5fb5-9d79-75e1-1231-fdfc14f91835@kernel.dk>
 <20190703000055.GA28981@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a01c861b-8c5c-0f6d-4ca8-00e97bcecbd9@kernel.dk>
Date:   Tue, 2 Jul 2019 19:10:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703000055.GA28981@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/19 6:00 PM, Christoph Hellwig wrote:
> On Tue, Jul 02, 2019 at 12:37:59PM -0600, Jens Axboe wrote:
>>> I couldn't get that to boot in my test systems even with mainline,
>>> but that seems to be do to systemd waiting for some crap not supported
>>> in the config.
>>>
>>> But with my usual test config I've just completed a test run with
>>> KASAN enabled on a VWC=1 driver with no issues, so this keeps puzzling
>>> me.
>>
>> Let me know what you want me to try. I can't reproduce it in qemu, but
>> it's 100% on my laptop. My qemu drives also have VWC=1, so it's not
>> (just) that.
> 
> I seriously have no idea unfortunately.  It works fine for me both
> on qemu and on a real WD SN720 drive on my laptop.  Just for curiosity
> you could try to pad the bio structure and see if bloating it to the
> old size makes any difference.

No change with the padding, put it in the same place. Still insta crash
before I get to login prompt, or right after I login and run sync.

> The other things that comes to mind is that when Johannes removed
> BIO_SEG_VALID there also were some unexplainable side effects,
> I'll look into seeing if there was any similarity.

Do you have a link?

I'll try and poke a bit here.

-- 
Jens Axboe

