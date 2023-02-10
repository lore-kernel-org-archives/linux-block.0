Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCA3C636D7
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 19:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjBJTxz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Feb 2023 14:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjBJTxz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2023 14:53:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616443A90
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 11:53:52 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b5so7583936plz.5
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 11:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tyTlWz5fYsKMWvFoz4Fm+BhCFJnS3C5FOiC8ggnUQfI=;
        b=Ol9zBscQLroOZLNiYZeIv/bRg1UL/AJUoHG3NuhutRaVVpj+QF100PIRYejUXFvuBc
         QfNqRH/f1UPFr/yaCTv6OA/rA+wEZkXcm43agI99YUdEVVYHiyv9VyFyCjfUF8LfutGY
         UmnIe963to6v8n0Cytr488j+BWbyLoJNiysJ2SzM3WflykR3wivjnc9q0XcXU12PgeUk
         +DS+LnzA/dLorlEz31WeofOmgV613YoGDdECNkJ34GZ/DKmpklG47P5iZ4NU61j/4M0D
         GuOGusK5pY1UHyDow8MUhDOl28Hn+xdn1/uLapUJlsVpUdLqT0epIPHpQ9ti4PIZ4/Ix
         YJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyTlWz5fYsKMWvFoz4Fm+BhCFJnS3C5FOiC8ggnUQfI=;
        b=SaqEolR7PCxuFKBm2+xd+GS/UApgApzY5GR2Qd4cW71HHdikOsG2rc8K7DhTlQWQ6E
         WiwPieTJdtrS01QY18LmBaNTBEXxAuzRFaNG+YBqHtsX6y31ohzty5LXPf7z5IgArmLJ
         /thW1o7wqzjUEPnRI/HzuuT7l7uylhQSTsMwQejqPMQlicAIbUM6sNxNgt6pE4xce17w
         rXd8rsysv8/z0k/sSisaa5tbdSyiRq4u8xkyEvSZ0IeSbVwNRNKgVNlS0Hxkb9mNDBoK
         Vsd06pCjNjS36aaLcDOX65QX65eXriTeHq/r9St3nC7GgtgBbp7WOHhRuw8w9rtQk6hT
         W/JA==
X-Gm-Message-State: AO0yUKUwzBcZVXzidcqm6/JuQaUi92XF1g/4iIyZI8S1+OnpsxoCOthn
        kfu+ba/kjbr6ehRtVyix8e+Myw==
X-Google-Smtp-Source: AK7set/nvu8HziW1amt4dCHtn3BSe+vey3sbMHabG6azp6FyjmQj/GFCEnSrIOjP7tge14+lGQIKow==
X-Received: by 2002:a17:903:1107:b0:196:3f5a:b4f9 with SMTP id n7-20020a170903110700b001963f5ab4f9mr17238288plh.1.1676058831800;
        Fri, 10 Feb 2023 11:53:51 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902be0a00b00199524dc67bsm3742155pls.163.2023.02.10.11.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 11:53:51 -0800 (PST)
Message-ID: <39a543d7-658c-0309-7a68-f07ffe850d0e@kernel.dk>
Date:   Fri, 10 Feb 2023 12:53:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        io-uring@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230210180033.321377-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/23 11:00?AM, Kanchan Joshi wrote:
> is getting more common than it used to be.
> NVMe is no longer tied to block storage. Command sets in NVMe 2.0 spec
> opened an excellent way to present non-block interfaces to the Host. ZNS
> and KV came along with it, and some new command sets are emerging.
> 
> OTOH, Kernel IO advances historically centered around the block IO path.
> Passthrough IO path existed, but it stayed far from all the advances, be
> it new features or performance.
> 
> Current state & discussion points:
> ---------------------------------
> Status-quo changed in the recent past with the new passthrough path (ng
> char interface + io_uring command). Feature parity does not exist, but
> performance parity does.
> Adoption draws asks. I propose a session covering a few voices and
> finding a path-forward for some ideas too.
> 
> 1. Command cancellation: while NVMe mandatorily supports the abort
> command, we do not have a way to trigger that from user-space. There
> are ways to go about it (with or without the uring-cancel interface) but
> not without certain tradeoffs. It will be good to discuss the choices in
> person.
> 
> 2. Cgroups: works for only block dev at the moment. Are there outright
> objections to extending this to char-interface IO?
> 
> 3. DMA cost: is high in presence of IOMMU. Keith posted the work[1],
> with block IO path, last year. I imagine plumbing to get a bit simpler
> with passthrough-only support. But what are the other things that must
> be sorted out to have progress on moving DMA cost out of the fast path?

Yeah, this one is still pending... Would be nice to make some progress
there at some point.

> 4. Direct NVMe queues - will there be interest in having io_uring
> managed NVMe queues?  Sort of a new ring, for which I/O is destaged from
> io_uring SQE to NVMe SQE without having to go through intermediate
> constructs (i.e., bio/request). Hopefully,that can further amp up the
> efficiency of IO.

This is interesting, and I've pondered something like that before too. I
think it's worth investigating and hacking up a prototype. I recently
had one user of IOPOLL assume that setting up a ring with IOPOLL would
automatically create a polled queue on the driver side and that is what
would be used for IO. And while that's not how it currently works, it
definitely does make sense and we could make some things faster like
that. It would also potentially easier enable cancelation referenced in
#1 above, if it's restricted to the queue(s) that the ring "owns".

-- 
Jens Axboe

