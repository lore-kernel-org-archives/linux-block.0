Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E21C433E6
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30EB3207B7
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhA0QRc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343961AbhA0QPo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 11:15:44 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAD3C061573
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 08:15:03 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g3so1306987plp.2
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xiqRpJ5Ht6dR1wStXAMqrua7i2NfwhoL7Gu6JxmbtR0=;
        b=uWA0sCspPE3AkDSyaNYslh7VDfnSpKOfrK0nXICZYMMjajQojSrQhAYij265UzsGks
         VwWSj6yZAjVHCk2OLX+cBU2oQvVQDWNbB2quFe5YO+SFCSMrhwIXcicULLZldCXP1EHI
         9/HeEq5Z0t5qQzwbGRPMsEimr0xkKw7XxYAtyUbkp6n5xXYk6Db8dJk9LtFfjSStcDDj
         DyMuTkfxZ0Ako7l26doxamMLFxkz3DPmZFj0f6kSDn5YhvDNx2WonCGf0HyHUirBMUOH
         oXPJQwBPU4sNNuf6M5qw1GF2SUOpgCZ6jotLwVlzOeEnUy0oKgVGD/R0vFYhPirac8oj
         PxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xiqRpJ5Ht6dR1wStXAMqrua7i2NfwhoL7Gu6JxmbtR0=;
        b=g5d7LDlXMOLw7HV7TR9t/kmfYWdu9EabiIGKaDymPVQGEB6PSmDkyaj0Xqg80VDLnQ
         9N03PRuTTXG2eDq0qqy+D5jn09+Lh5xK57ra9Hl1cQYVjJa+D8dLllOT2DZS6q8A+Jzl
         ehB3trOACqF7u4Am1dE7jQJDtc+aGCG8+gJTUpqUw1fR3Db7y39IH33aRoz3gTZW4byr
         4FerT8p2TA+u71IeDSwQ6Ir08QIBqNHf2UtRm4jeZ25oXkpigEJSrKhDq/fR3Fq57K36
         S9c+pWRu++/+2RB3L48tuncBS0IJ3faRm2FdeeMcsRTZIC6VliTK5zSGqiA7iBNW6NTU
         fTSw==
X-Gm-Message-State: AOAM533f7jdepHwjJUq+rX+XoURKRP8EpgGlYSSF9tl0gBjJ0aZQ/L+M
        XJPbE1faIrgiVhHEhBFB8Nqf5A==
X-Google-Smtp-Source: ABdhPJzsswtHV3w92LRCKEE7cnjcT4Vnr+fzOt1CqP/Koqrj3vZY9dGwAEokGdDdFpPClOtSAuHMbA==
X-Received: by 2002:a17:902:eccb:b029:de:8483:505d with SMTP id a11-20020a170902eccbb02900de8483505dmr12053475plh.63.1611764103374;
        Wed, 27 Jan 2021 08:15:03 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id u12sm2775076pgi.91.2021.01.27.08.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:15:02 -0800 (PST)
Subject: Re: [PATCH] Revert "block: simplify set_init_blocksize" to regain
 lost performance
To:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210126195907.2273494-1-maxtram95@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eac57824-f2eb-9a81-aa5f-3fd62f8e531d@kernel.dk>
Date:   Wed, 27 Jan 2021 09:15:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126195907.2273494-1-maxtram95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/21 12:59 PM, Maxim Mikityanskiy wrote:
> The cited commit introduced a serious regression with SATA write speed,
> as found by bisecting. This patch reverts this commit, which restores
> write speed back to the values observed before this commit.
> 
> The performance tests were done on a Helios4 NAS (2nd batch) with 4 HDDs
> (WD8003FFBX) using dd (bs=1M count=2000). "Direct" is a test with a
> single HDD, the rest are different RAID levels built over the first
> partitions of 4 HDDs. Test results are in MB/s, R is read, W is write.
> 
>                 | Direct | RAID0 | RAID10 f2 | RAID10 n2 | RAID6
> ----------------+--------+-------+-----------+-----------+--------
> 9011495c9466    | R:256  | R:313 | R:276     | R:313     | R:323
> (before faulty) | W:254  | W:253 | W:195     | W:204     | W:117
> ----------------+--------+-------+-----------+-----------+--------
> 5ff9f19231a0    | R:257  | R:398 | R:312     | R:344     | R:391
> (faulty commit) | W:154  | W:122 | W:67.7    | W:66.6    | W:67.2
> ----------------+--------+-------+-----------+-----------+--------
> 5.10.10         | R:256  | R:401 | R:312     | R:356     | R:375
> unpatched       | W:149  | W:123 | W:64      | W:64.1    | W:61.5
> ----------------+--------+-------+-----------+-----------+--------
> 5.10.10         | R:255  | R:396 | R:312     | R:340     | R:393
> patched         | W:247  | W:274 | W:220     | W:225     | W:121
> 
> Applying this patch doesn't hurt read performance, while improves the
> write speed by 1.5x - 3.5x (more impact on RAID tests). The write speed
> is restored back to the state before the faulty commit, and even a bit
> higher in RAID tests (which aren't HDD-bound on this device) - that is
> likely related to other optimizations done between the faulty commit and
> 5.10.10 which also improved the read speed.

Can't argue with these numbers, and while this should probably get
fixed up instead, let's leave that for future kernels. I'll apply this
for 5.11, thanks.

-- 
Jens Axboe

