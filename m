Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA978C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 16:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEBB218AE
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 16:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="get1YWLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfB1Qgk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:36:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37948 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1Qgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 11:36:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id g12so10631539wrm.5
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 08:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6sPzpAS1AmOKmTRJOv353p5PJh7AxxPry2/1SWFFqFI=;
        b=get1YWLwTo/gbmdSi6zjIsfcvMntDHfgwTpGj84jF+G24JDRRfLM/uTKeDwgYhIZfx
         ISWfFLwVnufWEFyMurbj9g6zCHX9pAjqSfb3SiY9K8eQ0ZxFk/CON+ZMMBHQiJwjDb1n
         uL4Y+0UjHvUtV3AiyVl5w5N7CZpH6GMJ1Y5JVX7oSlCYKgkcIFvhEIqbOAZgdG2sU514
         I6tMsbidRBGATV6beV6IQ3Vr0dELI4NNpMPgH1g/5sb//4yZGIzmqwFVIyqMNcek3Bai
         gwQLyzIVHjDoWz7Xe0aqMAxxjejVztxjLq4wq7t8aEWwCR+pWJMIEI9whMsPJfB/4Ieo
         e0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6sPzpAS1AmOKmTRJOv353p5PJh7AxxPry2/1SWFFqFI=;
        b=DxbTLpsbEMqsJCj7PoyrwUaZz/Y9u8ntczBcqUhuVptAsPvG7XNj/QHM7GzTkJ8szc
         aBAXAISsLNc6GKo3Z6g51LUFlRZr+Erj0uUUS1V0yAt1pe3hplxwH8yfzQ4fFC+BNOb2
         NsPzQSHv4o5kZ7QpAWrfh3dkMOSF/Mqz57oVssVyfb9aqoCAGSxz1QoPfhA08nfsvuK6
         9MqqqPghRjlT7oZL6cik5J52j/NifDiLryiq/Njbjh8DYX8bJKbRFVkx8aYt4137U6GB
         +xrLzuwe0MQq1rGDLtVGBB6LvkPQj8SaGvX5hllC4SHadF2u9HfeJcTtSkyw9WzfLjW8
         rXPw==
X-Gm-Message-State: APjAAAUiDJmtQiYw/iqYGRXiJiCDhrFM8NLNT+9DX2eL152gchw5ltR7
        6PFWKoNNzDPn9OS1P3szdL9DmhDu16A=
X-Google-Smtp-Source: APXvYqyhJfov8PXyTMJqCJCHgnVL89mNIhZ/WfnvKzhZFuOt7PA0zzyiicI9vIjSuiF2ZKsEToE+Jg==
X-Received: by 2002:adf:f103:: with SMTP id r3mr221990wro.50.1551371798516;
        Thu, 28 Feb 2019 08:36:38 -0800 (PST)
Received: from [192.168.0.65] ([192.116.228.102])
        by smtp.gmail.com with ESMTPSA id x6sm9034835wmg.0.2019.02.28.08.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 08:36:36 -0800 (PST)
Subject: Re: [PATCH 00/13] lightnvm: bugfixes and improvements
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <18ac8f7c-4990-073e-0fa7-b73315238bf3@lightnvm.io>
Date:   Thu, 28 Feb 2019 17:36:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190227171442.11853-1-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/27/19 6:14 PM, Igor Konopko wrote:
> This series provides a group of the bugfixes
> or improvements for lightnvm and pblk device.
> 
> Most of the patches are rather simple and covers
> some corner cases scenario, but we were able to hit
> most of them in some scenarios. Few others close some
> existing gaps which we were able to found.
> 
> Fedback is appreciated.
> 
> Igor Konopko (13):
>    lightnvm: pblk: Line reference fix in GC
>    lightnvm: pblk: Gracefully handle GC data malloc fail
>    lightnvm: pblk: Fix put line back behaviour
>    lightnvm: pblk: Rollback in gc read
>    lightnvm: pblk: Count all read errors in stats
>    lightnvm: pblk: Ensure that erase is chunk aligned
>    lightnvm: pblk: Cleanly fail when there is not enough memory
>    lightnvm: pblk: Set proper read stutus in bio
>    lightnvm: pblk: Kick writer for flush requests
>    lightnvm: pblk: Reduce L2P DRAM footprint
>    lightnvm: pblk: Remove unused smeta_ssec field
>    lightnvm: pblk: close opened chunks
>    lightnvm: Inherit mdts from the parent nvme device
> 
>   drivers/lightnvm/core.c          |   9 ++-
>   drivers/lightnvm/pblk-core.c     | 128 +++++++++++++++++++++++++++++--
>   drivers/lightnvm/pblk-gc.c       |  47 +++++++-----
>   drivers/lightnvm/pblk-init.c     |  30 ++++++--
>   drivers/lightnvm/pblk-map.c      |   2 +
>   drivers/lightnvm/pblk-read.c     |  13 ++--
>   drivers/lightnvm/pblk-recovery.c |   2 +-
>   drivers/lightnvm/pblk.h          |   4 +-
>   drivers/nvme/host/lightnvm.c     |   1 +
>   include/linux/lightnvm.h         |   1 +
>   10 files changed, 193 insertions(+), 44 deletions(-)
> 

Thanks Igor. I'll give Hans et. al. a couple of days to digest the 
changes.

