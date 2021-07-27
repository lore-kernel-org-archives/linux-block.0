Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17767C4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 20:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC69960F9C
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 20:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhG0UiV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhG0UiV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 16:38:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9275C061757
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 13:38:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z4so4784687wrv.11
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KPMi5h0wG6VmN+T30wtj1G7lchgByCQoOqYqjiw39eI=;
        b=Hff9T2vJsztwyRZh4fWvE06Xfgk4KUguvUar59ZlSdCyyiNBS+r63aTSY/c8z9sGZj
         v+sRktjjPf9pTrYFjX28EEutT2bKhGdOWYzmfBaP2STq+H0wAnoZSzDab+jvKPLmbFks
         6c7/tjy9decpJZaA2zYLKsSveYNDsdf2nnTtJBDawqiIMA2rjPhSKFYwAR8smcv2K1nG
         sU6BNWlPSlDD1L3TiE9TK6niStqpMgylEKaY7ePRKQ5cPIwAuG9mwWSaDVMuIm6zN5a/
         j+OKiIcq6r9il8phqIkMhdAwTAYg0GqqK5qpVg47UL9E/Ktn//M+O4OkiV7aO8HIJrbg
         EedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KPMi5h0wG6VmN+T30wtj1G7lchgByCQoOqYqjiw39eI=;
        b=TeigVCb6NNcSarPSKXkCukx+vbWaPgc1NprVh2vcQ1uo1kxknVBSTc4kiOkzRLOCQu
         3SC2LBPnb2U9Hbu6zN/IZS/PeIrfT/TLCqGr6iL4c5SL1HdG46rA3KfizA7ESiVd0/TT
         5jgMSmvYY9HKwYX1aG16IZ4vrKqAP554pBCDvbhsFfDLkJ+lB0GfVDewfUx1GN3GVlk9
         2drDD8dH2n5jhTygdvoEnv9jFBAyTl59VIVhixzAG6ZTFvyGfNJ5YAbZhNo6nDFNqkw7
         ZXqJq9yyzfAsxQSymLXQuBk7d7oJRN1hdaZg41O95lGxOKqISIQB01sIoRjoMS+KIzzV
         nfiw==
X-Gm-Message-State: AOAM530NYQkIWGLBNUzGC1z/I6t7rOTJ1wvAi30pcAhYoutKAd0Ck+Bh
        5GPzEluHWltipVlpNsgIqY5qJS9jm1U=
X-Google-Smtp-Source: ABdhPJzULrhZk2lqdInoI6Mjx/u3ve6ShCM8qkTZhLAl61553LahecpEUl5/CyDMOvLjoxzh+TxJhA==
X-Received: by 2002:a5d:64c2:: with SMTP id f2mr26218030wri.374.1627418298225;
        Tue, 27 Jul 2021 13:38:18 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id d67sm4223406wmd.9.2021.07.27.13.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 13:38:17 -0700 (PDT)
Subject: Re: [dm-devel] use regular gendisk registration in device mapper
To:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <20210725055458.29008-1-hch@lst.de> <YQAtNkd8T1w/cSLc@redhat.com>
 <20210727160226.GA17989@lst.de> <YQAxyjrGJpl7UkNG@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <9c719e1d-f8da-f1f3-57a9-3802aa1312d4@gmail.com>
Date:   Tue, 27 Jul 2021 22:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQAxyjrGJpl7UkNG@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/07/2021 18:18, Mike Snitzer wrote:
> On Tue, Jul 27 2021 at 12:02P -0400,
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> On Tue, Jul 27, 2021 at 11:58:46AM -0400, Mike Snitzer wrote:
>>>> This did not make a different to my testing
>>>> using dmsetup and the lvm2 tools.
>>>
>>> I'll try these changes running through the lvm2 testsuite.
>>
>> Btw, is ther documentation on how to run it somewhere?  I noticed
>> tests, old-tests and unit-tests directories, but no obvious way
>> to run them.
> 
> I haven't tracked how it has changed in a while, but I always run:
> make check_local
> 
> (but to do that you first need to ./configure how your distro does
> it... so that all targets are enabled, etc. Then: make).
> 
> Will revisit this shortly and let you know if my process needed to
> change at all due to lvm2 changes.

BTW it would be also nice to run cryptsetup testsuite as root - we do a lot
of DM operations there (and we depend on sysfs on some places).

You can just run configure, make and then make check.

Thanks,
Milan
