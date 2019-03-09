Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35261C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 04:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD33207E0
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 04:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pa7p0B2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCIEbG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:31:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45035 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCIEbG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 23:31:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id j3so15699567pgm.11
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 20:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+Qm6xs8b1ynsT5l9Yv9RTVR/8PtYE0YOkCPZ5e79wkc=;
        b=pa7p0B2wSfK+Ve9KXHvi7eE0GmWFtZYKnZ4E4kyVss+nIVl8ozzNKAQUBSUIeDSFhh
         XOZO6zJHOFj4D5HYZRnjYwDJfU6uF33NLr0P6Nl4jKQB21zWFT4NB2tFF3mWhzvkZ29u
         Jg4GdXBx2joG70MgWqtngsny/GCx35yV3e7EL6bridvgMvi8AXli9Pl75j0ToRkxqdwh
         7iOLraO2gpUgxny8qzwz0VNFxQ9Obfa3B98bxHlj/2NuCgvAhr1wdZ8p7k9l8kgOhFKi
         OnYxMqOt/HLTwXCMFDKslkRYhrca8LfEa4f2O5fEzNME9T0uTkdveUFznc4wET1mKoy4
         HgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Qm6xs8b1ynsT5l9Yv9RTVR/8PtYE0YOkCPZ5e79wkc=;
        b=W83veoqhnEf8eykMrH1A13JQyNdA9PtavcQbs2Etcumx5vwRXuFXmVjLfIPNc37xwI
         hpU9nb+3CkalMNfdrND0xJiX83IE18nEtS4wavjvKtXyta5lQIIBAiIOR3F8UtChyvxQ
         7n3URuL5Au8GrGb9hCr/f4pSeuqq88DRDPfWUaSvrIn9eRPb/D0MdAD/21sRwDV6OD0f
         00YmYDL3iVs6xf18p13Eg71mwRnq8QiAYcAe2PHN4kRow00FcJa17X8izxa+bPvaaqCq
         5nTiTdkFNCUFTMLmxm15nxNwenYy3EssjT1ARFAUPwsrH5oaDzLCYbP8dedfHBqYd89N
         FIyQ==
X-Gm-Message-State: APjAAAVHou8ufis2VfnsSrbblb+IZkhWZTs2e9IDqh1znsw6tmuUV+06
        Lu8gOJXkEOdir6zPKkAYrXgcrj0lfcbwEw==
X-Google-Smtp-Source: APXvYqxKm+SmLrdcPIFISowSOx0m52mNF821ykF+G0ivR3XkZV7rV0UMEtXYStt199Bbq/KxsqnEjw==
X-Received: by 2002:a17:902:f302:: with SMTP id gb2mr22844632plb.51.1552105864990;
        Fri, 08 Mar 2019 20:31:04 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v186sm22495470pfv.184.2019.03.08.20.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:31:04 -0800 (PST)
Subject: Re: [PATCH fio] t/io_uring: add depth options
To:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org
References: <20190308215959.5575-1-keith.busch@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05f6756f-2298-5f88-1f44-6c6d11a82e29@kernel.dk>
Date:   Fri, 8 Mar 2019 21:31:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308215959.5575-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/19 2:59 PM, Keith Busch wrote:
> Make depth options command line parameters so a recompile isn't
> required to see how it affects performance.

Thanks, everything really should be command line options. But I never
bothered, it wasn't mean to live this long :-)

Applied

-- 
Jens Axboe

