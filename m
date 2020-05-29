Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADEEC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 16:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77BB7207F9
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0HSFP7On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgE2QXw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 12:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgE2QXv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 12:23:51 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A4EC03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 09:23:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r10so11133pgv.8
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=puA359iGDFh0OT7hpkV/Vyf1DfDzBP50qPuCsPcldeQ=;
        b=0HSFP7OndK37ekmoVSybP1U4EVSaKHL/A/WOf57a5Z9D3awYHm0xzDMEqOXMGHRt+b
         Q5IkIebYmBkyMiv7cPDu9yFTqGZUXNZB9mE8b8B3noT+ud6B4nFF1z3VnepUGSf1GlPW
         WL/ID+QZugqpTZbILnMblmlTkiMU0Mlgeq5Q4+SDudvYoqeCnJFwVYtJYU9GJ9oyo5Lc
         SbOARgQQ41EtAwxUVXbUdjYVVKllOUfEpe5Bm0l8iWSt9P8PsyAjBw0zAbNKZ+jD+kBe
         W4p9OcyOqfmthwgFoFarUO2AfEXll4+2JUp9iGzL45TDEGtLwU50VOHSe9fuAs+WXVcm
         LPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=puA359iGDFh0OT7hpkV/Vyf1DfDzBP50qPuCsPcldeQ=;
        b=hg7IujEM9ltWa8/gXVUcCpHQayq0mSPt43hS9SRqlrSN5lfwV0wsZcy7jThPxCzcPs
         D9pChvnuY+LMCB55ZYIhZ48kWVdC8d0/sdj1IG5AAEtZL5N4WBKGBdClS9V/SxWZg6e0
         bNHkxp7wRg/736ZRPG5v7xfOugEi98V+LcXtJuQxrBzk21zqgGsbuoiz9EhtUaVgLUjI
         hcYC6hO+cgzpUmcs1A8PsxauKCqnwC2mnk4TMDtG0YGjQP6eahMW0iA0GOORaVe3kMdw
         Juvd9eMkeCp50CL7IQycvWksZ4H5qRZX2gtLCHRRpk+hCawqRXfpXv+SqjWUrY8ZSVpb
         hVJg==
X-Gm-Message-State: AOAM5310RK/4tygNbgmQkeSopF8Tz7HQ15hvoX4CxAUqWNgnQ7xmJt4n
        BPRbLi0VR3DEh3L9SqIdV5lDsw==
X-Google-Smtp-Source: ABdhPJzSXdZitcrglA9Fuqw1/kiDc/DTiYqardixyXR/cg8oZ4jJOi3QlVzsIkJ+YjxflhkRKNB1CQ==
X-Received: by 2002:a62:174c:: with SMTP id 73mr9150022pfx.71.1590769431052;
        Fri, 29 May 2020 09:23:51 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q65sm3427280pfc.155.2020.05.29.09.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 09:23:50 -0700 (PDT)
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v4
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200529135315.199230-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9a790a4d-e61d-52c5-8ef7-70a509ee6541@kernel.dk>
Date:   Fri, 29 May 2020 10:23:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529135315.199230-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/29/20 7:53 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series ensures I/O is quiesced before a cpu and thus the managed
> interrupt handler is shut down.
> 
> This patchset tries to address the issue by the following approach:
> 
>  - before the last cpu in hctx->cpumask is going to offline, mark this
>    hctx as inactive
> 
>  - disable preempt during allocating tag for request, and after tag is
>    allocated, check if this hctx is inactive. If yes, give up the
>    allocation and try remote allocation from online CPUs
> 
>  - before hctx becomes inactive, drain all allocated requests on this
>    hctx
> 
> The guts of the changes are from Ming Lei, I just did a bunch of prep
> cleanups so that they can fit in more nicely.  The series also depends
> on my "avoid a few q_usage_counter roundtrips v3" series.
> 
> Thanks John Garry for running lots of tests on arm64 with this previous
> version patches and co-working on investigating all kinds of issues.

Applied, thanks.

-- 
Jens Axboe

