Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8F6C433FE
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 12:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiEJMz0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 08:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242039AbiEJMzJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 08:55:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F0E1D865C
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 05:50:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x18so16652408plg.6
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fzxrrRn7cvywNO0Eg0g8MebJNrUAMkIxCPWEMLe1ccY=;
        b=Knxf+25kcpEt1lD1GjOJabs6ZQCKEJQ1n2FOsMOb8tgxCcfH/p+ESdNWzCoSL1+JZf
         GJeXvj2N86c0tABjp6OcRXyDPuRRZH4Yl4mxe8CZCRmHyA7Ih6t82i+FRuPur6OIsTKs
         N+Dv4oCnBx00eIAA2ZFDmqu2KaLd8ravhRD89bEV8ZA/N73jpbgm1KkcJqJ8hwIMU52U
         KNFtaLh4+J6omGoToE9+9ufHGmSdB9xDT/7pp8dUUM2EWRnB/+j/68PY42brWlMwKkQF
         xvzRor0v+R8WiTFLbSeykXRu6H3uQo+Q5NcjcJfGoIJOYL28BR6tHhL4YMI1qSed5GRa
         8Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fzxrrRn7cvywNO0Eg0g8MebJNrUAMkIxCPWEMLe1ccY=;
        b=zwPcPObJruf+CBmCwOFQlnp+zjpeDsVsKDNL4vHhizkSTd1NEjzFFjYxSmL8XeLGcF
         TG5ztVqkoWhOBzwjVSlN8UWz+D5DlJOXqiN5Sw6bPgwEsww/goH1pzO5f/5XRHmQCAb3
         iODLCrskictf4Wt5KTqlZQAXBehq2HZ/5yILvScca8BCY0NkG9MC86Wa6CFvEIiSn0Nw
         oP+Ck+cGBdH61Rx4oX5T4xEvq9RIfi4wc6QcNdJ2+PIMLvy5oIkMykVbRsddlHom0Wgw
         jssXSZRY6M/vJV015Ygsf6Sqwej5zkpxZTJa0BdyqKVgD+MEOviVnlTpImLI3eQBTQjD
         h3Xg==
X-Gm-Message-State: AOAM532BQvo56U1smCk2l9QH8+ZQStjlK0PAFbqZtRLyROH7crX7STbD
        EUGqx3d33Uh3BA5pauXf9ySChIWCWUPyUd9+
X-Google-Smtp-Source: ABdhPJz9xpmarjEYY69KKbBo6OrTUj6+f98YhVpTCwrY6O0JPMtCCCwu9m5ErVPx4i80Fdv6IHt7dg==
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id s7-20020a170902988700b001516e1c7082mr20228734plp.162.1652187037457;
        Tue, 10 May 2022 05:50:37 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ot17-20020a17090b3b5100b001dc4d22c0a7sm1719430pjb.10.2022.05.10.05.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 05:50:37 -0700 (PDT)
Message-ID: <1afd2c01-69b3-ab8f-6bfe-118e3e56001c@kernel.dk>
Date:   Tue, 10 May 2022 06:50:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 0/2] sbitmap: NUMA node spreading
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/10/22 5:14 AM, John Garry wrote:
> Hi Jens, guys,
> 
> I am sending this as an RFC to see if there is any future in it or ideas
> on how to make better. I also need to improve some items (as mentioned in
> 2/2 commit message) and test a lot more.
> 
> The general idea is that we change from allocating a single array of
> sbitmap words to allocating an sub-array per NUMA node. And then each CPU
> in that node is hinted to use that sub-array
> 
> Initial performance looks decent.
> 
> Some figures:
> System: 4-nodes (with memory on all nodes), 128 CPUs
> 
> null blk config block:
> 20 devs, submit_queues=NR_CPUS, shared_tags, shared_tag_bitmap,
> hw_queue_depth=256
> 
> fio config:
> bs=4096, iodepth=128, numjobs=10, cpus_allowed_policy=split, rw=read,
> ioscheduler=none
> 
> Before:
> 7130K
> 
> After:
> 7630K
> 
> So a +7% IOPS gain.

What does the comparison run on a non-NUMA non-shared queue look like?
Because I bet it'd be slower.

To be honest, I don't like this approach at all. It makes the normal
case quite a bit slower by having an extra layer of indirection for the
word, that's quite a bit of extra cost. It doesn't seem like a good
approach for the issue, as it pessimizes the normal fast case.

Spreading the memory out does probably make sense, but we need to retain
the fast normal case. Making sbitmap support both, selected at init
time, would be far more likely to be acceptable imho.

-- 
Jens Axboe

