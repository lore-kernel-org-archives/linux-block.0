Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF77CDB47E
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 19:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjJRTKB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Oct 2023 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjJRTKA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2023 15:10:00 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45469114
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2023 12:09:59 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-351610727adso4232445ab.0
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2023 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697656198; x=1698260998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vb3IBU5yy7t8bMvrKZ3G2oxuWdruwAw/ttBvYUW8G1E=;
        b=lg06KmteStZYWwttvtnpGTznIAYPN/NecBolfYZvwOswPsQrCHhYX4yI1NgbfUsKoI
         zC8GWvxaNKAFiytcBXgB2vcMXBPSzoyYwHoTSURnckfw+u63Vjn8iF1tJDSuIPNAQIW4
         zG6I9mIa0fjln7XnduvU6Ckc6Z4iF0VARIbe32+heJvJzWkJk5CiezJQ9wFWbinnAMi3
         Zefn3G8ix8jlM/b+WqlZZDfYxRBnLscxCYiXmcH9BH+M5RJTZbw+bnHBMbv0Vq/dkOyq
         GdGUkF18hFnM2tq4qUU3RXDJuBgVPHlXt7zChvJih0qdWRjmYq7Huz/6yM0XYmffpE3U
         yw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656198; x=1698260998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vb3IBU5yy7t8bMvrKZ3G2oxuWdruwAw/ttBvYUW8G1E=;
        b=ms1ejnevOZ6EvXgpMlzMSsTlRUPKJTLUQU576bkaxE5FwFI/ASKtcF6ShuUG/tBxUJ
         y0NIG6hLK5MnAUh5WWNzVN38oeh+sWPtLOcpnpulojK6j3z/ICulye9jpmubPn4plLDY
         Iyu3JSqFEo2eF4BD+74osqYgVpXAzEEKVR83BKcIvhc+RvEabqE79fuCKfU8QUvQZFU1
         q/hINAwvijvqgQJKXjP5t6kAUJNdunJuMF0St/TYl/fEyT+Q+ck/rvp0Sl4X3/tM9wTQ
         eEdwU0VbkBhaJJRGXnKQz9KfWgDUbqIYyLnECnJggTkPu5t7WvEqqJdGv0xt9rOtQFHi
         NCSg==
X-Gm-Message-State: AOJu0YwPxKycCrDxgCNq0psBW/O9/rCO/N+Szr7IrzjH1Irzim4TponV
        smo7Y23OP2W/xlZx+NUd7ZBp8Q==
X-Google-Smtp-Source: AGHT+IH6CdQgC3rN9tmOifWLdhZDIEPtTG3N/Htttp7Zng29PPqIamxI33unHYKXoPIdm2O/qdo55Q==
X-Received: by 2002:a05:6e02:3885:b0:34f:7ba2:50e8 with SMTP id cn5-20020a056e02388500b0034f7ba250e8mr303287ilb.2.1697656198581;
        Wed, 18 Oct 2023 12:09:58 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z15-20020a92da0f000000b003512c3e8809sm1292642ilm.71.2023.10.18.12.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:09:58 -0700 (PDT)
Message-ID: <3f3c2289-3185-4895-92cb-0692e3ca9ebc@kernel.dk>
Date:   Wed, 18 Oct 2023 13:09:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] Pass data temperature information to SCSI disk
 devices
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>
References: <20231017204739.3409052-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231017204739.3409052-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/23 2:47 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> UFS vendors need the data lifetime information to achieve good performance.
> Without this information there is significantly higher write amplification due
> to garbage collection. Hence this patch series that add support in F2FS and
> also in the block layer for data lifetime information. The SCSI disk (sd)
> driver is modified such that it passes write hint information to SCSI devices
> via the GROUP NUMBER field.
> 
> Please consider this patch series for the next merge window.

My main hesitation with this is that there's a big gap between what
makes theoretical sense and practical sense. When we previously tried
this, turns out devices retained the data temperature on media, as
expected, but tossed it out when data was GC'ed. That made it more of a
benchmarking case than anything else. How do we know that things are
better now? In previous postings I've seen you point at some papers, but
I'm mostly concerned with practical use cases and devices. Are there any
results, at all, from that? Or is this a case of vendors asking for
something to check some marketing boxes or have value add?

I can take a closer look once this is fully understood. Not adding
something like this without proper justification.

I'm also really against growing struct bio just for this. Why is patch 2
not just using the ioprio field at least?

-- 
Jens Axboe

