Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690DBC433F5
	for <linux-block@archiver.kernel.org>; Sat, 28 May 2022 12:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbiE1MZB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 May 2022 08:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiE1MZA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 May 2022 08:25:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5A526FD
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:24:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j7so949544pjn.4
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SKUkS97rxdoIcZ01usMPCg8MKu4QzvixAgQo/OMynjA=;
        b=7YD3kY+poIf5j4XfOOmRdjDa+R2EbeE4LH2yzgjMadf4Kw8+VxwHMd35UFNeD2JK9v
         pfoB/cYYCbC/09j5ZtXhW2MOuV2gBN8KV935ZFtuWhvaFYWqJDp6n5+5aX/gsVMMMleC
         z1KiaovY4+ziZW33PHoicF0mUEiKAhEYRwWK6kSWfyf8PL5/pHWOrd42ez6uoDpVUIQR
         llu2fhIrEcjuSXhZ7AboZdvFrOlYXNd3keRHoy3lH2Eqv4C2t83tKRsflA1eKlaqhanN
         llIdpZttPC25bx5kfWDGjomKCn02MM4/ZxrHv0yfkr8myKerqyusKlzxV0EIV4ZdXR2H
         y2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SKUkS97rxdoIcZ01usMPCg8MKu4QzvixAgQo/OMynjA=;
        b=hcP59We7gVlTplKb5Gonpownj18d1a6S8md56YasMsVtNlW28Ly24YbW1G/w/IhvIz
         7q6h5ah1CiH0g0f0U5Y10f0rsBqQb3QMCDgHl1KGR/Bw8ucJ/ArwKCzhiRfvp1ftRPaH
         9nGgwFj6DnwHTwv+iNtJr2++Oi3qkKsi8kDnYfOo6lXrO57iHx39ny0rKfMSoZXxAR1F
         QPM4xxrhYG1mZyDf1Dp5mB/R+qZf0limN7vVE4thsthjIQLurA6Xg8BFgQS9HRiCjfAC
         2CVqBIizCudgez+kd0yqkBUJHViXlLLaZAhUfxVyJHc0GWXuQLZSVFNGvElV118iy1vm
         b6qg==
X-Gm-Message-State: AOAM530DUAw2PHDxP00mtUWyY+hyTNmhZ9Qi5TO2zbYgMkQRwHRCbdYA
        eHg7AJWmmao3TVvPEzMmXOFZmw==
X-Google-Smtp-Source: ABdhPJzlnDloDNwRAurXN79GhHsiOGP2PX3xeOmHBwmWdk6P08PVDDym+jwEpXRfC0yMtm5Z33hjzQ==
X-Received: by 2002:a17:902:bb92:b0:153:4eae:c77e with SMTP id m18-20020a170902bb9200b001534eaec77emr46490298pls.93.1653740699077;
        Sat, 28 May 2022 05:24:59 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ch12-20020a056a00288c00b004fa743ba3f9sm5217665pfb.2.2022.05.28.05.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 05:24:58 -0700 (PDT)
Message-ID: <37bbcb23-685e-d5f2-8b71-f700ef9a6e44@kernel.dk>
Date:   Sat, 28 May 2022 06:24:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] block: take destination bvec offsets into account in
 bio_copy_data_iter
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20220524143919.1155501-1-hch@lst.de>
 <a1e6fd92-ed3d-f94c-43a7-ff4fca27b759@kernel.dk>
 <20220528045233.GA13168@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220528045233.GA13168@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/22 10:52 PM, Christoph Hellwig wrote:
> On Fri, May 27, 2022 at 08:36:47PM -0600, Jens Axboe wrote:
>> On 5/24/22 8:39 AM, Christoph Hellwig wrote:
>>> Appartly bcache can copy into bios that do not just contain fresh
>>> pages but can have offsets into the bio_vecs.  Restore support for tht
>>> in bio_copy_data_iter.
>>>
>>> Fixes: 8b679a070c53 ("block: rewrite bio_copy_data_iter to use bvec_kmap_local and memcpy_to_bvec")
>>
>> Applied, but where is this sha from? The upstream one is f8b679a070c5.
> 
> Apparently from my copy and pasting discarding the initial f of that..

Heh, my tired eyes missed that, makes sense. Anyway, I did correct it
when applying.

-- 
Jens Axboe

