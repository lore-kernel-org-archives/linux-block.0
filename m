Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B48AC77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjDKWxs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 18:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjDKWxr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 18:53:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C913C3B
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 15:53:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63240bdd5e8so388837b3a.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 15:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1681253625; x=1683845625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwN+vpcrp8JnaBxSFxnp66UorlPenXdR7YcSEsS9PJA=;
        b=Blve6j3beEvr4MGx4o2cQAOsiz/oa5sDRIeSd5bwP7EgKVWwCZh6W5Zcuoirh445V9
         gN+WnNp8ssR0FmDjROQtj7GjRFg8VK9cnovPOOH0Uh7yWoqhhvr6rkNOR+e98zZx3j/y
         cnZ+Z0tpLq69T/G+KSgss+94ZnlknhZ9/W10wjS7vW1hns3/8jz6zgkJvuzgpj7cjThk
         aUMvLlPvD7ldCMAaqo2+dEDSmckpizuCbu/BTE1j7aLBYdBzoRi2+N6LK/Y/Ks96CGW3
         ctCdcWgV43LXZEADK/532mTy38Z+Z6uUys0yphSbWMI4wCdkc5VLiA1iLpbxfreIReFe
         fOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253625; x=1683845625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwN+vpcrp8JnaBxSFxnp66UorlPenXdR7YcSEsS9PJA=;
        b=j2uc4AQDNqKHMJWYCg7H4p8OO/dpTdSYTcbvhhe8iPhTAmT+Q1Kn+caRsYIQs4wpSR
         FfZvcxcaBjBRiutSE+ZTqTfbEb7BRCc7iEe/mDUsvSzMkC7TBQt/xhjeQJ0J4MIA25g4
         Zsh3GXhayj8poIA4PlhTBYDjR1OpYvNBBqiGneh85KVJpsa9Rv1v7hKbqIVfQKTFvwgb
         UY5GYDR4SAFWMaa37RaF4okRUQBpv2hDTveHlrRQgp0HiHDmgaA4mRrv+nuIhq/pzsrS
         mON8QQ7dNcqK6bF4Dcgm/A+PnEK+tcnlVezZ1b2Pej8/4Hqlf2uVBVUetCNlbb1rdbKZ
         U1gA==
X-Gm-Message-State: AAQBX9c2YgIx7ef9g+NW4lsk9imByu7PCacCbemIFEqmY2bTcT4m2w2O
        MqA/IikvhinpfnuKE39frHRs/J1R3uGov1Dgrz4=
X-Google-Smtp-Source: AKy350ZwLjFGBs1C1IQ6bdjW6D/KSdMpqjWdP4TOPIhdiCaVGn6kZjqQL2EZSc7OlV2XdyUxmiJ5vQ==
X-Received: by 2002:a05:6a00:2353:b0:633:4c01:58b4 with SMTP id j19-20020a056a00235300b006334c0158b4mr574228pfj.2.1681253625543;
        Tue, 11 Apr 2023 15:53:45 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j18-20020aa79292000000b005ccbe5346ebsm10283023pfa.163.2023.04.11.15.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 15:53:45 -0700 (PDT)
Message-ID: <09a546bd-ec30-f2db-f63f-b7708e6d63a1@kernel.dk>
Date:   Tue, 11 Apr 2023 16:53:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Content-Language: en-US
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
 <39a543d7-658c-0309-7a68-f07ffe850d0e@kernel.dk>
 <CA+1E3rLLu2ZzBHp30gwXBWzkCvOA4KD7PS70mLuGE8tYFpNEmA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3rLLu2ZzBHp30gwXBWzkCvOA4KD7PS70mLuGE8tYFpNEmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 4:48 PM, Kanchan Joshi wrote:
>>> 4. Direct NVMe queues - will there be interest in having io_uring
>>> managed NVMe queues?  Sort of a new ring, for which I/O is destaged from
>>> io_uring SQE to NVMe SQE without having to go through intermediate
>>> constructs (i.e., bio/request). Hopefully,that can further amp up the
>>> efficiency of IO.
>>
>> This is interesting, and I've pondered something like that before too. I
>> think it's worth investigating and hacking up a prototype. I recently
>> had one user of IOPOLL assume that setting up a ring with IOPOLL would
>> automatically create a polled queue on the driver side and that is what
>> would be used for IO. And while that's not how it currently works, it
>> definitely does make sense and we could make some things faster like
>> that. It would also potentially easier enable cancelation referenced in
>> #1 above, if it's restricted to the queue(s) that the ring "owns".
> 
> So I am looking at prototyping it, exclusively for the polled-io case.
> And for that, is there already a way to ensure that there are no
> concurrent submissions to this ring (set with IORING_SETUP_IOPOLL
> flag)?
> That will be the case generally (and submissions happen under
> uring_lock mutex), but submission may still get punted to io-wq
> worker(s) which do not take that mutex.
> So the original task and worker may get into doing concurrent submissions.

io-wq may indeed get in your way. But I think for something like this,
you'd never want to punt to io-wq to begin with. If userspace is managing
the queue, then by definition you cannot run out of tags. If there are
other conditions for this kind of request that may run into out-of-memory
conditions, then the error just needs to be returned.

With that, you have exclusive submits on that ring and lower down.

> The flag IORING_SETUP_SINGLE_ISSUER - is not for this case, or is it?

It's not, it enables optimizations around the ring creator saying that
only one userspace task is submitting requests on this ring.

-- 
Jens Axboe


