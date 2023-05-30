Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942A5C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 14:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjE3OXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjE3OX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 10:23:26 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1157B180
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 07:22:54 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33110a36153so750905ab.0
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 07:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685456572; x=1688048572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMQ9ry8AKTO2FR7tRHTRE93ffp9TP0HpWMZoGgQvYPQ=;
        b=V05PqSXnA/o4aizLouT8C2GNTnWY6Jmz3rPcWRR6mywaAUXjuFQVBqL8n43YaW8lKZ
         lh3UJRUh8Lx/GZPnqEfgKEkYJejr5+w4tQjI5MNHp9Ru6g7bYDRFAwYnfe4Bkqxdp9tU
         CX0Y7d2iwsnVfC4nCDzPphTXgpfmA/iOjqRhzl3LHhb12Qq/P0SQ0ZWMj3Tooe8N6sui
         F/785TkH0bWEk/ua64A6iLfNwNLnnDIVE0YvTALbpD8v0cF+NTQ7RWnosUA1k1V9/kgf
         kJBfWKPN9lUlQozDDRB9eQimr3bc8ssAX/dhzR2wK523e9oQKyXo6c7E3JInD/9Ovt68
         JiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456572; x=1688048572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMQ9ry8AKTO2FR7tRHTRE93ffp9TP0HpWMZoGgQvYPQ=;
        b=Wtne8NJE1XRBb6Q30jDR6pGe3VEjiFq4xJMH5qHbGbth/KSBLLh46IlYx6AyMWNG7g
         rnc3e0gFFpTd67M/Q0yrSyh0etHxoM+z+xldreF8IStnuYM/mRLmbX8KuaBi1+7aJeBQ
         a6n64W2zMHxT2r0GcKZk6samw2aeF2euxX9FFPRcDb7mJ5kN7kxNHOC6SBlsBNYZnNBh
         p/QjOKlyWEHMxQ3g/FpWcSUI8uxSkNJUUU561liIe3H7FfubP6IC7oyiwe7GSeYsYpqO
         WjoagmueFGhRxnoZSEg1tIw64FBljtsfKn8Yqno9nxlfYtHar54Qky3FPiOfVv+CkU/0
         mxFA==
X-Gm-Message-State: AC+VfDw4mmaueBm4qb2YI+O5e/L9Xj0fNkV7aQaSBflBY03FNIeEcAtf
        7ylOSRuF8Hum6dNjrWQMIXbf1Q==
X-Google-Smtp-Source: ACHHUZ6bAQuuHXpQlR+iC5nEfSoFbg5j9AdJTp/kx+0TZ1coKbNYT8KiYZ6HXc/m0Q1/bl2BmHMSwg==
X-Received: by 2002:a05:6e02:219d:b0:33b:3a14:c14c with SMTP id j29-20020a056e02219d00b0033b3a14c14cmr1520578ila.3.1685456572032;
        Tue, 30 May 2023 07:22:52 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v11-20020a056638250b00b004035b26b6d8sm761464jat.2.2023.05.30.07.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 07:22:51 -0700 (PDT)
Message-ID: <8e874109-db4a-82e3-4020-0596eeabbadf@kernel.dk>
Date:   Tue, 30 May 2023 08:22:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/7] block layer patches for bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
 <ee03b7ce-8257-17f9-f83e-bea2c64aff16@kernel.dk>
 <ZHEaKQH22Uxk9jPK@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZHEaKQH22Uxk9jPK@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/23 2:44?PM, Kent Overstreet wrote:
> On Fri, May 26, 2023 at 08:35:23AM -0600, Jens Axboe wrote:
>> On 5/25/23 3:48?PM, Kent Overstreet wrote:
>>> Jens, here's the full series of block layer patches needed for bcachefs:
>>>
>>> Some of these (added exports, zero_fill_bio_iter?) can probably go with
>>> the bcachefs pull and I'm just including here for completeness. The main
>>> ones are the bio_iter patches, and the __invalidate_super() patch.
>>>
>>> The bio_iter series has a new documentation patch.
>>>
>>> I would still like the __invalidate_super() patch to get some review
>>> (from VFS people? unclear who owns this).
>>
>> I wanted to check the code generation for patches 4 and 5, but the
>> series doesn't seem to apply to current -git nor my for-6.5/block.
>> There's no base commit in this cover letter either, so what is this
>> against?
>>
>> Please send one that applies to for-6.5/block so it's a bit easier
>> to take a closer look at this.
> 
> Here you go:
> git pull https://evilpiepirate.org/git/bcachefs.git block-for-bcachefs

Thanks

The re-exporting of helpers is somewhat odd - why is bcachefs special
here and needs these, while others do not?

But the main issue for me are the iterator changes, which mostly just
seems like unnecessary churn. What's the justification for these? The
commit messages don;t really have any. Doesn't seem like much of a
simplification, and in fact it's more code than before and obviously
more stack usage as well.

-- 
Jens Axboe

