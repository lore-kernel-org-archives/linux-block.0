Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B01C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 18:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiBVSFm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbiBVSFk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 13:05:40 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D52172896
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 10:05:13 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id z16so12873581pfh.3
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 10:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UmUZdhtufL3sCVsB9RvKfT0/3o0CKvRD3FS9MduxtGM=;
        b=Ol9JMzYyAngCjfms9UisDhrns6U+zkntmWPTK7t+coz14C5qpfq4Bd61onaTaOvJGy
         8rCd0P2seCr0qoL3u/4iFfa5i10obruR1qsErr7DbKhnfmCLtzspyKhyG0BbO8RmAFbz
         0r84KFNCbwMrMC+LU/qB+pYkV4/BMmCvLkXlUGfnxHQAFH3T/CR41oK5lzgSe9EktAjp
         KfOpIetgawYKgYeyQH06Ge5evikoOjD67zyW5I07YATZ1TQFZT2/Y05eSwmRQFIvKsbe
         Ycs1uXp12oWuwaVgKL4cr/HmplqMl4kjbgYy7Cp0yhDjhcNcSMDzgu9dMOjZxdC+FtUh
         bHHw==
X-Gm-Message-State: AOAM532EUD1wh0eT9Bt/cWtTSk8cC5FC5fcsioe2qc/WAXu7QfmUNeKC
        YKU6Di0hlGyaPkos1QaAdOfnm7/o7opMCg==
X-Google-Smtp-Source: ABdhPJz19k1IKsySpeth1TrTLyE9Eh4OP51xtCzaVtNsiW2boeE5bKbZXRRF4pq2GuL+MlyUaiC+lw==
X-Received: by 2002:a63:4b09:0:b0:372:c793:ab50 with SMTP id y9-20020a634b09000000b00372c793ab50mr20345148pga.495.1645553113095;
        Tue, 22 Feb 2022 10:05:13 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id w15sm18569564pfu.2.2022.02.22.10.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 10:05:12 -0800 (PST)
Message-ID: <2029243d-c39b-8c9a-0b62-cf596e03e060@acm.org>
Date:   Tue, 22 Feb 2022 10:05:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <986caf55-65d1-0755-383b-73834ec04967@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/22 22:57, Hannes Reinecke wrote:
> On 2/21/22 20:59, Gabriel Krisman Bertazi wrote:
>> I'd like to discuss an interface to implement user space block devices,
>> while avoiding local network NBD solutions.  There has been reiterated
>> interest in the topic, both from researchers [1] and from the community,
>> including a proposed session in LSFMM2018 [2] (though I don't think it
>> happened).
>>
>> I've been working on top of the Google iblock implementation to find
>> something upstreamable and would like to present my design and gather
>> feedback on some points, in particular zero-copy and overall user space
>> interface.
>>
>> The design I'm pending towards uses special fds opened by the driver to
>> transfer data to/from the block driver, preferably through direct
>> splicing as much as possible, to keep data only in kernel space.  This
>> is because, in my use case, the driver usually only manipulates
>> metadata, while data is forwarded directly through the network, or
>> similar. It would be neat if we can leverage the existing
>> splice/copy_file_range syscalls such that we don't ever need to bring
>> disk data to user space, if we can avoid it.  I've also experimented
>> with regular pipes, But I found no way around keeping a lot of pipes
>> opened, one for each possible command 'slot'.
>>
>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html

There have been more discussions about this topic, e.g. a conversation 
about the Android block-device-in-user-space implementation. See also 
https://lore.kernel.org/all/20201203215859.2719888-1-palmer@dabbelt.com/

> Actually, I'd rather have something like an 'inverse io_uring', where an 
> application creates a memory region separated into several 'ring' for 
> submission and completion.
> Then the kernel could write/map the incoming data onto the rings, and 
> application can read from there.

+1 for using command rings to communicate with user space.

Bart.
