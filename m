Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22858C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 03:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FF223A5E
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 03:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgLHDa0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 22:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgLHDaZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 22:30:25 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99CCC061749
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 19:29:45 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id f9so11936605pfc.11
        for <linux-block@vger.kernel.org>; Mon, 07 Dec 2020 19:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/9G/C62N71eYALbTeP38z8WTx0TuJMRd5q2txQVdN4E=;
        b=ijLRQWNQM0hih+pCqO8KYdqxe9pr+sQ552GHZtxCqnH6aw+PgMzh4D1sY7cABcjPqZ
         yycxvRqb5bD93T8iXDFb8NGJ3Ck5Yr+2e/b8ZrfoJftZ1h5ZjYvqiTcMPugogh7AMP06
         CCvexjhvUQ+xKQhvERIS+lifCwY4JXkTCgEzZvt3mm/movPF8WVoHbYBdmHO9LRmnCTG
         TZwfrSey8hqyMV2tmBCZ+qhJFhjtn/iD48fmZQBRDN3x+luHCb59iyUOJlR9tUyGnGL0
         G5GcUnN/e6Yy3/ETWj3AxSE80ew/RQFOv+QaXi1NqzXJLxNM50L/Fa2y/Ci4b71M7KT/
         7h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/9G/C62N71eYALbTeP38z8WTx0TuJMRd5q2txQVdN4E=;
        b=FO/hUaXQP2F1p5ybgRUCknn7p0MA3zn8P1S2o80mEbDAFmA7FGVq6PbRfZwaUn2A02
         rmFGVLARqxNc6nliend9ICd1FUVZEeDjXPzNdmRunbOPqRYVU4/1HI42H6324qJPd2g8
         e6WBH2qHfm1NfxaC1kQJh8LpoIxSldJrXx+VInkfBGeao34jy3IyU2ab0s5+ii+rUfJr
         qyYcVM+cKLHQ03XyAMIcJothTcS9vPA1uIkHC4Nz5btQrqG2eEIQAX6CxnmRfSpJHWf8
         G9cFTr6MYad5XY6Ep+oe4srtj0kBEoRRpGfHNQQhW25WHFD53OSIRpgs/Ns5FI5iY0Ie
         Cb1Q==
X-Gm-Message-State: AOAM533r8ygdtkFSyB9E7ICemWERlXBoTfQzDuNf9S6HMsvdLho2v3sz
        ElKLcpUSC3eEHvdFWbHqlIHRmS2pPgA3Fw==
X-Google-Smtp-Source: ABdhPJxzTqmvL3HLCLxF7Em5LVoRtNbEyof+7T+RORlokcHsRo/LGy/wybIduuXI5XAKefLsMvndFA==
X-Received: by 2002:a17:90b:e0d:: with SMTP id ge13mr2037954pjb.111.1607398185205;
        Mon, 07 Dec 2020 19:29:45 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d4sm855758pjz.28.2020.12.07.19.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 19:29:44 -0800 (PST)
Subject: Re: [PATCH v9] block: disable iopoll for split bio
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <20201126091852.8588-1-jefflexu@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b211cec4-07fa-d647-b068-f7225963bc6c@kernel.dk>
Date:   Mon, 7 Dec 2020 20:29:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126091852.8588-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/20 2:18 AM, Jeffle Xu wrote:
> iopoll is initially for small size, latency sensitive IO. It doesn't
> work well for big IO, especially when it needs to be split to multiple
> bios. In this case, the returned cookie of __submit_bio_noacct_mq() is
> indeed the cookie of the last split bio. The completion of *this* last
> split bio done by iopoll doesn't mean the whole original bio has
> completed. Callers of iopoll still need to wait for completion of other
> split bios.
> 
> Besides bio splitting may cause more trouble for iopoll which isn't
> supposed to be used in case of big IO.
> 
> iopoll for split bio may cause potential race if CPU migration happens
> during bio submission. Since the returned cookie is that of the last
> split bio, polling on the corresponding hardware queue doesn't help
> complete other split bios, if these split bios are enqueued into
> different hardware queues. Since interrupts are disabled for polling
> queues, the completion of these other split bios depends on timeout
> mechanism, thus causing a potential hang.
> 
> iopoll for split bio may also cause hang for sync polling. Currently
> both the blkdev and iomap-based fs (ext4/xfs, etc) support sync polling
> in direct IO routine. These routines will submit bio without REQ_NOWAIT
> flag set, and then start sync polling in current process context. The
> process may hang in blk_mq_get_tag() if the submitted bio has to be
> split into multiple bios and can rapidly exhaust the queue depth. The
> process are waiting for the completion of the previously allocated
> requests, which should be reaped by the following polling, and thus
> causing a deadlock.
> 
> To avoid these subtle trouble described above, just disable iopoll for
> split bio and return BLK_QC_T_NONE in this case. The side effect is that
> non-HIPRI IO also returns BLK_QC_T_NONE now. It should be acceptable
> since the returned cookie is never used for non-HIPRI IO.

Applied, thanks.

-- 
Jens Axboe

