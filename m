Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93B7C432BE
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 19:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862556103E
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 19:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhG1TWZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhG1TWY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 15:22:24 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C053C061765
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 12:22:21 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso3191713otb.10
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xtCzcJFAu9dR3CG6ek/fh/xMW6UNckFyG7RsgVYyIWw=;
        b=TT+fBye+Vvf5GJpNluw0WcRTC7515kpgaXVVegMP0wr4inSikyrK9QanPefFtjXmim
         WTEQtYiCNW/5IW8h+juauUzRzHM/svXLuLrAV+fuKZ9rqkmQbDIA9OT+VvZQH2bjm2cT
         0/p6SsgDhIIYH/h46RytjULmrLSTZRSXTrga4HzPz/3Qm0rJj1aeVtkoOK4gaNlySQvW
         3M+BSBbmJisXYnHtIp6o6BQhrd/mwd9K2OyKVF+/qPBE4+wp0j2A3zZhqHHEgyHyZMqF
         tmmtTCOr682Mglw8SU0cvL4tSZlC4vzW8FLEHyOkF1swMSKXTy+H6mdf1t8PCYkkfmg8
         Lovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtCzcJFAu9dR3CG6ek/fh/xMW6UNckFyG7RsgVYyIWw=;
        b=TREPtL19aqM39MkNVkEwMijb5kF7KeTS3yrN8Jbtwp3duCXKt/ZbIHGHyEVT4iEE2Q
         qvFfaTt+oyx7lTj8LJARWZC/gbreJQ3HheX/lkFVOyV2QJgNNwRMAdLwhZoOqdD2kiCw
         K/Dcmbme4o+2oH0NbOCyPIYGxQ0rRerZetAMt+kBtTlCnUg9nqcKjyBlrsQq2p1k9R5B
         mPKWvwECz+5+IFWbVU1E5Krovck/O9aZuU1QtmAD3EijMApdy7DEUtHDicOeox1t0vf1
         pIUHGA88EHf/oJ/yRA6wgXoDMrqaROOhdpOwLwGMPrnqxHQ9ejvD8bNmmMo8qFfuUyxk
         XsfQ==
X-Gm-Message-State: AOAM5301ElUtG1ZysoYoElgqjoX2iDSmc7xPQt9vYJVP7/kwuLiQoduX
        1Wjd54PhBZISHFemchfyWzZS+Q==
X-Google-Smtp-Source: ABdhPJxCOixxPZx/B9u6/IckaLKvyCZhkvAoWYTyKbBLx//EwCPaLJWT+Dr+GFNlXpBF10QYtCkl5g==
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr1050189otr.51.1627500140530;
        Wed, 28 Jul 2021 12:22:20 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p4sm127444ooa.35.2021.07.28.12.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 12:22:20 -0700 (PDT)
Subject: Re: [PATCH v5 0/5] block: add a sequence number to disks
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
References: <20210712230530.29323-1-mcroce@linux.microsoft.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa2b4c63-6262-ab0b-63c2-270e84207dc0@kernel.dk>
Date:   Wed, 28 Jul 2021 13:22:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210712230530.29323-1-mcroce@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/12/21 5:05 PM, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Associating uevents with block devices in userspace is difficult and racy:
> the uevent netlink socket is lossy, and on slow and overloaded systems has
> a very high latency. Block devices do not have exclusive owners in
> userspace, any process can set one up (e.g. loop devices). Moreover, device
> names can be reused (e.g. loop0 can be reused again and again). A userspace
> process setting up a block device and watching for its events cannot thus
> reliably tell whether an event relates to the device it just set up or
> another earlier instance with the same name.
> 
> Being able to set a UUID on a loop device would solve the race conditions.
> But it does not allow to derive orderings from uevents: if you see a uevent
> with a UUID that does not match the device you are waiting for, you cannot
> tell whether it's because the right uevent has not arrived yet, or it was
> already sent and you missed it. So you cannot tell whether you should wait
> for it or not.
> 
> Being able to set devices up in a namespace would solve the race conditions
> too, but it can work only if being namespaced is feasible in the first
> place. Many userspace processes need to set devices up for the root
> namespace, so this solution cannot always work.
> 
> Changing the loop devices naming implementation to always use
> monotonically increasing device numbers, instead of reusing the lowest
> free number, would also solve the problem, but it would be very disruptive
> to userspace and likely break many existing use cases. It would also be
> quite awkward to use on long-running machines, as the loop device name
> would quickly grow to many-digits length.
> 
> Furthermore, this problem does not affect only loop devices - partition
> probing is asynchronous and very slow on busy systems. It is very easy to
> enter races when using LO_FLAGS_PARTSCAN and watching for the partitions to
> show up, as it can take a long time for the uevents to be delivered after
> setting them up.
> 
> Associating a unique, monotonically increasing sequential number to the
> lifetime of each block device, which can be retrieved with an ioctl
> immediately upon setting it up, allows to solve the race conditions with
> uevents, and also allows userspace processes to know whether they should
> wait for the uevent they need or if it was dropped and thus they should
> move on.
> 
> This does not benefit only loop devices and block devices with multiple
> partitions, but for example also removable media such as USB sticks or
> cdroms/dvdroms/etc.
> 
> The first patch is the core one, the 2..4 expose the information in
> different ways, and the last one makes the loop device generate a media
> changed event upon attach, detach or reconfigure, so the sequence number
> is increased.
> 
> If merged, this feature will immediately used by the userspace:
> https://github.com/systemd/systemd/issues/17469#issuecomment-762919781

Applied for 5.15, with #2 done manually since it didn't apply cleanly.

-- 
Jens Axboe

