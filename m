Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D294FC433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32F160E8F
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhJZOlC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhJZOlC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 10:41:02 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F47C061745
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:38:38 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r194so454853iod.7
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RFoQdcvapghUeZRRJfLrcd3GnglIRElfNP8AgVpkymw=;
        b=2ove/RWwCK27o3jZlAK1F5PtNV686L5mfsAMBF58kyvcMhBb/RRxuixnxlc4cDnqHl
         KCfPcASplMetW7hwF9YpG876BMkL2TgOnxAYhESbl1kY2ffQCUlzR+NF5pefvNpVBq0s
         1zvDYmF9JyKsehAiKXV3m3xlJPIg0oFdJy70vXhSbIqQqz8OkMsgHMpnIXJHI3aMaYAu
         fIsXkSyXRVAVgvXQnirwEU5Kz03x7HrM2DMd+Z/HdMoWkekBIYWegc60hkPGC29BGBlU
         7VJSGLlulLovD+NvJO40tJwzuO3F5d/gwC/Rlya0nR8RRCyND7CFltpxhJxQ95PbP11u
         aPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RFoQdcvapghUeZRRJfLrcd3GnglIRElfNP8AgVpkymw=;
        b=bpJisx0rq2+DXzlXAV+MUvtFOI7SljLZl6VwCxTDvQI6UwY3XbnPO4CFlawaUSuXl0
         sCh//TCHHfTIQ09cpFJBhfSAio1AzfF7mzOCgaOXbNw5W6JphcpxrGBadfKWIynKyTPE
         K6sRgD3w0jD/sobKEJfQaVPraupqwSu6GxdvyIr1Na1BSuui/Ac7WDaVSyVNxxX9uhGI
         4D0HFOGqc2ncX46Ud8TwgxKAmseMTQFWb7TV9IsL3Ow79WSz0RSFLLZONQSZahWOPhlY
         ZNv8q3SSaPlgM/8QNu0BjzAssVcwKVMFluc0gvR7OpYLe6xI6jegScUljbbM3l/OabIl
         Ctpw==
X-Gm-Message-State: AOAM530/X4c1ENG1DCm0+vLAFJhX+d8PSpypRFfoCDxEg9CHws7HGX+M
        3C0Ls6Cddmd2WUgCc5hl1lAYmyzWXfaq4A==
X-Google-Smtp-Source: ABdhPJwm4n3F0NqeJKJj8p0BxpSf/HR8qyvopKreHLntEgR/RnzFvOTVFvgM9hYuG2QGzAYUVPxOlA==
X-Received: by 2002:a05:6638:2581:: with SMTP id s1mr15598452jat.35.1635259117292;
        Tue, 26 Oct 2021 07:38:37 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b9sm7428696ilo.38.2021.10.26.07.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:38:36 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: don't issue request directly in case that current
 is to be blocked
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20211026082257.2889890-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e1ec2083-f1d7-7b33-15c7-0df4de3aa8f6@kernel.dk>
Date:   Tue, 26 Oct 2021 08:38:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211026082257.2889890-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/26/21 2:22 AM, Ming Lei wrote:
> When flushing plug list in case that current will be blocked, we can't
> issue request directly because ->queue_rq() may sleep, otherwise scheduler
> may complain.

Oops indeed, thanks Ming.

-- 
Jens Axboe

