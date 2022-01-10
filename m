Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CDBC433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 02:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbiAJCna (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jan 2022 21:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbiAJCn3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jan 2022 21:43:29 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A7C06173F
        for <linux-block@vger.kernel.org>; Sun,  9 Jan 2022 18:43:28 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id s6so15752870ioj.0
        for <linux-block@vger.kernel.org>; Sun, 09 Jan 2022 18:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+3bGR3R0JZMa84L/xLoLwGFsUDY4seX3vnLdRIZKDOI=;
        b=olT97Tonp4ek2/PMS/jByBPTQQdtdWhEKyKHmpTSRL0Fag1hC1ECakX0XIyt41qrBs
         aLu80+jge2V2QzJG6GYXsmoa+MZETIr5JwfJYwUyzV/YpNzVQxF4eIzcYNXbECQeFQZG
         m9vaflkYMpgLHjq1xo7FPsxl9YN/+MHuw+9RX1r9srenZmGelCfCRqtrl4SUMLtdX7m0
         9ki7uHfZ7kp1ZQ5bZBX0I6nB5Wukl+zo7L0Xfs8j9ikPDpSGNHK19NV+0IBL0A4Uu/TT
         tjC1KFyNYiV6hZibHgHDKWMtGbe0QNBCv7ASOPTbSiTLeVNlsUmMOZeAoIC2SmExT97o
         qRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3bGR3R0JZMa84L/xLoLwGFsUDY4seX3vnLdRIZKDOI=;
        b=sRGbU2hVfZjQgg3BKy+RSlq6HFHQSgw3fAD1VC3i0d0PIzvJgbg2nvJ0p5B4NeYnmv
         dsfjyZHypE2Brhm+1hI4V+3UhoEynQez1bEtEt07lr0MtoBP7zp1sEqO7QFRgyY4b1YH
         QQwlQGyduVm4TbZjyByZBLfh7RANF4NV/gq0bU6REr3mxcb2T44PeKV9EYGwI6YBEfuI
         WdH/3OLfqdEjMVVOKGYF49oJ+uNMCBqSeTFDDlv4R9fJQl4IC1lUhaso3QjsUocZSIqJ
         lW6Gn0SHTtOBLfOv/OhVSkGroEjQY7Plz5vprCXdSYaXZji7dP0tIAoP5rjJ1Vemq/HK
         K8fQ==
X-Gm-Message-State: AOAM532f0djA1AqA7Fq3z8WMRt5/klNL5u/54or8411dN3knrfuuzuo2
        uQuNJROogNCFJ71udB7BYu4kEMnRFylb0w==
X-Google-Smtp-Source: ABdhPJzyhYg/WcNAN+GzWGIHbWTMu2O95P33rkFB0mGwgiZaUP1CxWiBWdbggbgHUYYU+es//m2FIg==
X-Received: by 2002:a5d:9a95:: with SMTP id c21mr34078666iom.189.1641782608215;
        Sun, 09 Jan 2022 18:43:28 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q6sm3407442ilv.65.2022.01.09.18.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 18:43:27 -0800 (PST)
Subject: Re: [PATCH] lib/sbitmap: kill 'depth' from sbitmap_word
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>
References: <20220110015007.326561-1-ming.lei@redhat.com>
 <020ba538-bb41-c827-1290-c2939bf8940c@kernel.dk> <YducMfW4vhk15CMq@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8e24bd70-a817-ff8d-c59a-3e998e5cb869@kernel.dk>
Date:   Sun, 9 Jan 2022 19:43:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YducMfW4vhk15CMq@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/22 7:38 PM, Ming Lei wrote:
> On Sun, Jan 09, 2022 at 06:54:21PM -0700, Jens Axboe wrote:
>> On 1/9/22 6:50 PM, Ming Lei wrote:
>>> Only the last sbitmap_word can have different depth, and all the others
>>> must have same depth of 1U << sb->shift, so not necessary to store it in
>>> sbitmap_word, and it can be retrieved easily and efficiently by adding
>>> one internal helper of __map_depth(sb, index).
>>>
>>> Not see performance effect when running iops test on null_blk.
>>>
>>> This way saves us one cacheline(usually 64 words) per each sbitmap_word.
>>
>> We probably want to kill the ____cacheline_aligned_in_smp from 'word' as
>> well.
> 
> But sbitmap_deferred_clear_bit() is called in put fast path, then the
> cacheline becomes shared with get path, and I guess this way isn't
> expected.

Just from 'word', not from 'cleared'. They will still be in separate
cache lines, but usually doesn't make sense to have the leading member
marked as cacheline aligned, that's a whole struct property at that
point.

-- 
Jens Axboe

