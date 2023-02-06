Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B09C636D3
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 18:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBFS1C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 13:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBFS1B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 13:27:01 -0500
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4014B28D2D
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 10:26:59 -0800 (PST)
Received: by mail-pf1-f182.google.com with SMTP id o68so7759658pfg.9
        for <linux-block@vger.kernel.org>; Mon, 06 Feb 2023 10:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX5ehMX4OM1769jBzDWSOOhEeFMBN6bG+0r3W5lQbsQ=;
        b=qJsM7DXzl9l3stafbjctiFNt2HAPedDrYoUkmDPTLXF8E+5xyxZGWjxbjrZdZ/Xv+m
         dsQ2B7d9O3XSjWFlXJlfPADPuDhAi/W6MdcV+3eYCvsGXsch80Mbhrl4tW3uutpYSJH3
         Te8YKuwpOa5VO0VYEQKgMDRDt+mxBDckaiueMA8lIaWX8cL4609SfME+TMewj+bA7RAk
         FZyL7Px2I/tFk8n4W6QfHEHBi8wxd77lQju5J7tCe9gauhmrSF3Y1QASqLxj2IWldAp5
         MPfR8tgmVVDbxt8rVs+jofSzBYaqVLp0WeLECVRL5xBaW9j6kKtunbxycYAr/E1dN+ji
         kw/w==
X-Gm-Message-State: AO0yUKVSRg02eULhTkL8U4MmMbytdcHMUlMrGA5qTcGPkrGbF7jIF4cN
        Sh/kD6lhgNOZByh69cwd/oU=
X-Google-Smtp-Source: AK7set+bPKRvlGwdWHZRVa467XTrVkUKUOxUiDDNu5VC7zl5xMSkvIREwULMF2zWmu6cf2j05ZW4Pg==
X-Received: by 2002:a62:84c5:0:b0:58d:d546:8012 with SMTP id k188-20020a6284c5000000b0058dd5468012mr444286pfd.0.1675708018320;
        Mon, 06 Feb 2023 10:26:58 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:546b:df58:66df:fe23? ([2620:15c:211:201:546b:df58:66df:fe23])
        by smtp.gmail.com with ESMTPSA id k20-20020aa790d4000000b005907664a3eesm7480155pfk.125.2023.02.06.10.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 10:26:57 -0800 (PST)
Message-ID: <80aa92bc-f9b3-f76e-4e3a-76d3753717d2@acm.org>
Date:   Mon, 6 Feb 2023 10:26:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org
Cc:     Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>, Stefan Hajnoczi <stefanha@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
References: <Y+EWCwqSisu3l0Sz@T590>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y+EWCwqSisu3l0Sz@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/23 07:00, Ming Lei wrote:
> 4) DMA
> - DMA requires physical memory address, UBLK driver actually has
> block request pages, so can we export request SG list(each segment
> physical address, offset, len) into userspace? If the max_segments
> limit is not too big(<=64), the needed buffer for holding SG list
> can be small enough.
> 
> - small amount of physical memory for using as DMA descriptor can be
> pre-allocated from userspace, and ask kernel to pin pages, then still
> return physical address to userspace for programming DMA
> 
> - this way is still zero copy

Would it be possible to use vfio in such a way that zero-copy
functionality is achieved? I'm concerned about the code duplication that
would result if a new interface similar to vfio is introduced.

In case it wouldn't be clear, I'm also interested in this topic.

Bart.
