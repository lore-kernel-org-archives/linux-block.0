Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F83C77B73
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 01:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjESBjm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 21:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESBjm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 21:39:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD9AE51
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 18:39:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25377d67da9so120077a91.0
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 18:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684460380; x=1687052380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbBjjtXl49jT7JYIkFgCnFOcFlWqhv9TYhPqRtuvhfM=;
        b=aBkHHl51hhFsEVrqfyCJcHH7xdHUnJHewgCtu4vN5s4lL3qFGf+pwSUm2gQKMCaOmW
         W5wAGpVOWrW/sDqbArkwDVATxCRuAnwaHZ7K0pQoglqpJwTk8l7kmvR90QJEsBgsePqB
         DRw1TI52jjDUnF4HUXDPFRJATG+0djxeviKHoZ3tkGqC+MezugkjS/EGlv8qHtROFw+J
         CjzVLLJcJtppuFp1J71QacrYgZeX0dVBocblOB9VJoVB+m40zixTrLyEkO/DVa5W0fVk
         5qVP7CYHHpNI+8oj9lZ/FUhEooQNKrDNazMQ3Rn+Ijls7rT8zPXszdL2PAVtne/kJokw
         yBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684460380; x=1687052380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbBjjtXl49jT7JYIkFgCnFOcFlWqhv9TYhPqRtuvhfM=;
        b=emv7c7paCfG/x2iVrRTunh+8C5jZMxEv/0JnxhdtURI+K7EXdTxErAPPWnOOXJafNV
         NMh3hsmeCZJvaDmN9bngg06rqlaSkVXF5NuzDsCdMveb36n+pH4qNU9jPON7iFEpab1q
         eBdG4DbElVBRvAa+FXs0sgSt8vi5kiSJcrHpvv8JVsPN5GRVHogrEBlTAIXrPPs6Fq+a
         Q8DoSlEtl+7JUhnuFe+7/QUym5xoh0dRDoJcrJymUsq2xK+u0W3qlZfLnsGpqfM/0AUv
         +ZD680k7JybPeFlXXL+PA6pnhbdfKnXUdQ0yHPJ/14Y/Cs8KnNWlzv2/8v7eIZltxItc
         wf0w==
X-Gm-Message-State: AC+VfDzrFsUWI7Ky/Muf+YPF5rjddAjOChRI7kHStBlGDzLgGBPUdYE3
        6B7jaD4I4BPzzzsmxHmSx2ywWw==
X-Google-Smtp-Source: ACHHUZ7xjYvMzZhr/5598m5XzG3FjFXkCnDRnXgO8VCDUB0xWEu5oJCON4XrTdGS5fWe7u7jU/a04A==
X-Received: by 2002:a17:902:f54a:b0:1a9:71d3:2b60 with SMTP id h10-20020a170902f54a00b001a971d32b60mr1264952plf.0.1684460380585;
        Thu, 18 May 2023 18:39:40 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q31-20020a17090a1b2200b002508f0ac3edsm317834pjq.53.2023.05.18.18.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 18:39:39 -0700 (PDT)
Message-ID: <5d769f74-7da0-3ea8-53c8-635fabadac39@kernel.dk>
Date:   Thu, 18 May 2023 19:39:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: keep passthrough request out of the I/O schedulers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20230518053101.760632-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230518053101.760632-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 11:30 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this is my respin of Ming's "blk-mq: handle passthrough request as really
> passthrough" series.  The first patch is a slightly tweaked version of
> Ming's first patch, while the 2 others are new based on the discussion.
> 
> This isn't meant to shut down the discussion on wether to use scheduler
> tags for passthrough or not, but I'd like to see the bug fixed (and
> a series I have that needs it unblocked).

I think the series stands fine on its own.

-- 
Jens Axboe


