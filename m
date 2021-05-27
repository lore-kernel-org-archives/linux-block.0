Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0276AC47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 18:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CA0613D4
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 18:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhE0Sz2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 14:55:28 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:40517 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhE0Sz2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 14:55:28 -0400
Received: by mail-pf1-f171.google.com with SMTP id x188so1289649pfd.7
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 11:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CXdSaRbt6suRAs9kbAFES8YfJO9Vc4nrXY8elND08JU=;
        b=YYKS9BvTXFMd+/yRfiXnhMv3gABIp4UBo72xBDoKdDYWpzX7sWd5LAGGPZfRy0E9Yp
         YK2DzX9VTpnNkpZ6POiUcWNpIJd6MvDXYEmT99xwPgsMf9i1UKq4k4znTBHPhKOiiFXn
         2gYWDEKjyyE77CMk9FlMnqJdYfxj0RN6rctfAAbEb+m/5FJIlsAu7LyeeMAk1qB+eF7i
         Om6l3q6DwioVgrG11jAhkx1EmRr6d4/uPJbPmEjqy8JiWICJIedTlZUG4zRpOlkT+3DJ
         Hcbih9DXH4yWAk1DaUubUmxVp5m+xcoUT/Xr3L9RIAAZnRfmHptqR+OGW9HCdUX8AA4r
         k8Sg==
X-Gm-Message-State: AOAM532AdlAhju33K9mnvSJ0dngzUTA5jWOhrA75BrrA9tba+k7d66d5
        HGgmuQ+Pnpt6MFqbDLFlm1sZMV1bzUU=
X-Google-Smtp-Source: ABdhPJzYTAhGojjY94Ru3WcZuKdgq9PUCrYz+3lllnF2CXHnnNDxPAftOSx2AnhJMr6UGWdtocRgRA==
X-Received: by 2002:a63:b008:: with SMTP id h8mr5046027pgf.236.1622141633895;
        Thu, 27 May 2021 11:53:53 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s14sm2641689pfs.108.2021.05.27.11.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 11:53:53 -0700 (PDT)
Subject: Re: [PATCH 0/9] Improve I/O priority support
To:     Adam Manzanares <Adam.Manzanares@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "hch@lst.de" <hch@lst.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <7c34db067cde1a4920dac73c1d38720597c948ca.camel@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a4846eaf-a53d-0413-04d5-b95fce5ad779@acm.org>
Date:   Thu, 27 May 2021 11:53:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <7c34db067cde1a4920dac73c1d38720597c948ca.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 10:58 AM, Adam Manzanares wrote:
> On Wed, 2021-05-26 at 18:01 -0700, Bart Van Assche wrote:
>> A feature that is missing from the Linux kernel for storage
>> devices that support I/O priorities is to set the I/O priority in
>> requests involving page cache writeback.
> 
> When I worked in this area the goal was to control tail latencies for
> a prioritized app. Once the page cache is involved app control over
> IO is handed off suggesting that the priorities passed down to the
> device aren't as meaningful anymore.
> 
> Is passing the priority to the device making an impact to
> performance with your test case? If not, could BFQ be seen as a
> viable alternative.

Hi Adam,

As we all know complexity is the enemy of reliability. BFQ is
complicated so I am hesitant to use BFQ in a context where reliability
is important. Additionally, the BFQ scheduler uses heuristics to detect
the application type. As became clear recently, there heuristics can be
misled easily and fixing this is nontrivial (see also
https://lore.kernel.org/linux-block/20210521131034.GL18952@quack2.suse.cz/).
I want the application launcher to create one cgroup for foreground
applications and another cgroup for background applications. Configuring
different I/O priorities per cgroup is an easy and reliable approach to
communicate information about the application type and latency
expectations to the block layer.

Some database applications use buffered I/O and flush that data by
calling fsync(). We want to support such applications. So it seems like
we have a different opinion about whether or not an I/O priority should
be assigned to I/O that is the result of page cache writeback?

Thanks,

Bart.

