Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BECC433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 01:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbiDABYZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 21:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243718AbiDABYY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 21:24:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C7E217967
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 18:22:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j8so1132618pll.11
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 18:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JqzlBlmuscHVnNnPYh/b4FXO/hWZSCec4wgmjvC92Jo=;
        b=RVEsEQROdKrOtmuldgRa/PvAwe+jXLwDuENO6CLXw/FiINEJ2W3a0yi0925jx/MLia
         4RQiMO0g09YbbYmNnKMEqiiIA3fgP4bxLn2aCN8W/+gZANXPCAO64tzDgahR17mX/FPC
         8deLSNbM1nINSB9O+Zt3W8QmiEMN+WPmndJe7BYCuL2wMiOOzuN8AuV5gZJZKcr+vaCM
         Sf0UuNxnbI891NPM5xo1i4N4sVk8KAECSNaO9rKpQI4uvt2MJrzFA3ghdNh3ARmXwiiR
         24V0782Tbleh3JOkq6yUsnpH9gZoCjRZsyQGK5hWY77UAxGHyhEPMTaAaeBAwMke3ST/
         8xuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JqzlBlmuscHVnNnPYh/b4FXO/hWZSCec4wgmjvC92Jo=;
        b=IScrcTeGDDIOsnRFIHWn9f4Hs2OhPMBBQ1kGeiXGKuUPd76fVZGiqBn+4a4oZLVpvs
         CBPPOj90Oqo7sq5w7astf9S7aeZe8QhwbQ4ElCsCp6NBA4R2pdACZALkxWMY52PwHuxm
         QNw4SRL16ri1WhZP5nTKBrl8uf/th0sN6m5fGWkfX8OWKzxabXrO7/2JOEAkvt12SOkQ
         ULeAXVEb56Upui7ymr+z+uQsqc4uJlK1jPEHqkgGQxS9GwNoQiABM833HqCpPiedLrjH
         nKco6Z8yLJp+N23+vlHW/UpfLIE3qvANPP41ZaDgJ/FWAS1z6frxYktIu+HBOW8DhPYu
         LzHA==
X-Gm-Message-State: AOAM5305oIZNqPq8eegbDeCz9bDXcxfvnNdeRU/soPCAwOpn3Z15qZrt
        EjpK7YovfrpFcCoP8P7SNq+ciw==
X-Google-Smtp-Source: ABdhPJwoohPEsfOaUYXtn0uGcWPKVWgHksrPhLg73D4Ij9RANYSEV1jYZJzcq4SC73s2yoUDnieM0Q==
X-Received: by 2002:a17:902:6845:b0:153:9af1:3134 with SMTP id f5-20020a170902684500b001539af13134mr44235505pln.169.1648776156095;
        Thu, 31 Mar 2022 18:22:36 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090a02d700b001bf6ef9daafsm530640pjd.38.2022.03.31.18.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 18:22:35 -0700 (PDT)
Message-ID: <910afdf8-ec01-90b2-b7ec-a7644e53259e@kernel.dk>
Date:   Thu, 31 Mar 2022 19:22:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Content-Language: en-US
To:     Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sbates@raithlin.com,
        logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com>
 <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/22 11:10 AM, Kanchan Joshi wrote:
>> We need to decouple the
>> uring cmd properly.  And properly in this case means not to add a
>> result pointer, but to drop the result from the _input_ structure
>> entirely, and instead optionally support a larger CQ entry that contains
>> it, just like the first patch does for the SQ.
> 
> Creating a large CQE was my thought too. Gave that another stab.
> Dealing with two types of CQE felt nasty to fit in liburing's api-set
> (which is cqe-heavy).
> 
> Jens: Do you already have thoughts (go/no-go) for this route?

Yes, I think we should just add support for 32-byte CQEs as well. Only
pondering I've done here is if it makes sense to manage them separately,
or if you should just get both big sqe and cqe support in one setting.
For passthrough, you'd want both. But eg for zoned writes, you can make
do with a normal sized sqes and only do larger cqes.

I did actually benchmark big sqes in peak testing, and found them to
perform about the same, no noticeable difference. Which does make sense,
as normal IO with big sqe would only touch the normal sized sqe and
leave the other one unwritten and unread. Since they are cacheline
sized, there's no extra load there.

For big cqes, that's a bit different and I'd expect a bit of a
performance hit for that. We can currently fit 4 of them into a
cacheline, with the change it'd be 2. The same number of ops/sec would
hence touch twice as many cachelines for completions.

But I still think it's way better than having to copy back part of the
completion info out-of-band vs just doing it inline, and it's more
efficient too for that case for sure.

> From all that we discussed, maybe the path forward could be this:
> - inline-cmd/big-sqe is useful if paired with big-cqe. Drop big-sqe
> for now if we cannot go the big-cqe route.

We should go big cqe for sure, it'll help clean up a bunch of things
too.

-- 
Jens Axboe

