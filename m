Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51241C433F5
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 04:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F1DA60F51
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 04:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhIDERm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Sep 2021 00:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhIDERl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Sep 2021 00:17:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBACC061575
        for <linux-block@vger.kernel.org>; Fri,  3 Sep 2021 21:16:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so891557pjt.0
        for <linux-block@vger.kernel.org>; Fri, 03 Sep 2021 21:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lebEMYnaBXWh/oOEd+GyspTLYi3am3ekjBpDHXWvtL0=;
        b=EGVAtaztNlvVeen+iRB6J4VVSWTUwahaDRHvSBrAVRGIAL96ckc8FHgz/SIGPN+py9
         mGlpq/DiZ/dLbjF2lA/fSAlPiR9hkwDkj2YHyft9HWENXAGOoqxwKFGbU0om0c7SYsqY
         9nJBmY7SghaPCiESkhd9jTrPIGEtAZnpS845m4J48Kk14B7agvwHTAGjmYiBWKyPuK90
         icrt/FWD2VAWRBcnkil0j1CnXb4x3pOO/UTd2KdmPpVh07bf00v/2FfNuEeOnq04op1Z
         m6udH6eHwcGzuPjJQpjpNLleqFt+N1XKnHENKzDE0IhvvEXqSa8y1kxOrPF12rw4dl9q
         7+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lebEMYnaBXWh/oOEd+GyspTLYi3am3ekjBpDHXWvtL0=;
        b=ITQj0poZPd+BAwEuTjyXdmVnY3j/8C2Jdb/RrcVdzKiLV0OX4qqKEjXwWq+urp27hC
         7j3wKW0cgP/fEBAZQaNiO2LmmJ0EGrZN4dOFRZSMZUB/1UA9ZGTubT1vJ8FntN6fbmij
         raf1iyujZpHvNO2OSYZzhz4WpGEWQ1xpdY1oPrtZdUnZ2lhoR8FcSlWk8XgPo9VvaIMp
         gKoB788m0aySpWDWhzYxVgX3on9xz1GLARy2b5gRONKwaX5bQbluhuC3rOPmYwh4Yf9P
         hWzUpJcNzEfWQ0IG4NtE6atuhmBCzCgTkktyeVe2Ywo7ZEOPUphJvM1cF5PbwgtJl7Iq
         a3wg==
X-Gm-Message-State: AOAM532u4l0YrCVc17/CaMq685Com+P1MikUez8Gky7nzhCBagKKdqA0
        iYObgOEqMaoJJToTt4ZjpURRN+vcF29HBg==
X-Google-Smtp-Source: ABdhPJwn2uAXkUOGbDP3NLXeXgakdHwr/xKMBMiCEvGaf6rk9KCbOIBiVi3Gh0mMpa2TvQzRhJ4dfw==
X-Received: by 2002:a17:90a:c8b:: with SMTP id v11mr2364937pja.114.1630729000111;
        Fri, 03 Sep 2021 21:16:40 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id u123sm765402pfb.123.2021.09.03.21.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 21:16:39 -0700 (PDT)
Subject: Re: [PATCH v3] loop: reduce the loop_ctl_mutex scope
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christoph Hellwig <hch@lst.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>
References: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp>
 <20210827184302.GA29967@lst.de>
 <73c53177-be1b-cff1-a09e-ef7979a95200@i-love.sakura.ne.jp>
 <20210828071832.GA31755@lst.de>
 <c5e509ec-2361-af25-ec73-e033b5b46ebb@i-love.sakura.ne.jp>
 <33a0a1e5-a79f-1887-6417-c5a81f58e47d@i-love.sakura.ne.jp>
 <cc5c215f-4b3b-94e9-560b-a02d0e23c97c@i-love.sakura.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c47bb93f-2265-7901-58f6-4327842d9247@kernel.dk>
Date:   Fri, 3 Sep 2021 22:16:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cc5c215f-4b3b-94e9-560b-a02d0e23c97c@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/29/21 7:47 AM, Tetsuo Handa wrote:
> syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
> commit a160c6159d4a0cf8 ("block: add an optional probe callback to
> major_names") is calling the module's probe function with major_names_lock
> held.
> 
> Fortunately, since commit 990e78116d38059c ("block: loop: fix deadlock
> between open and remove") stopped holding loop_ctl_mutex in lo_open(),
> current role of loop_ctl_mutex is to serialize access to loop_index_idr
> and loop_add()/loop_remove(); in other words, management of id for IDR.
> To avoid holding loop_ctl_mutex during whole add/remove operation, use
> a bool flag to indicate whether the loop device is ready for use.
> 
> loop_unregister_transfer() which is called from cleanup_cryptoloop()
> currently has possibility of use-after-free access due to lack of
> serialization between kfree() from loop_remove() from loop_control_remove()
> and mutex_lock() from unregister_transfer_cb(). But since lo->lo_encryption
> should be already NULL when this function is called due to module unload,
> and commit 222013f9ac30b9ce ("cryptoloop: add a deprecation warning")
> indicates that we will remove this function shortly, this patch updates
> this function to emit warning instead of checking lo->lo_encryption.
> 
> Holding loop_ctl_mutex in loop_exit() is pointless, for all users must
> close /dev/loop-control and /dev/loop$num (in order to drop module's
> refcount to 0) before loop_exit() starts, and nobody can open
> /dev/loop-control or /dev/loop$num afterwards.

Applied, thanks.

-- 
Jens Axboe

