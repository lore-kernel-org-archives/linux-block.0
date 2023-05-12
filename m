Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F29C77B75
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbjELPI6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjELPI5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:08:57 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E11FC7
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:08:56 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-76c56d0e265so30992139f.0
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683904135; x=1686496135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wO7KR/oI/b4LCHxvDoSFxI8GjKx7kT+apEfpkl3d+dc=;
        b=D2fXNokYwH/aFZae7BaaUdDSH5XgrlJyANeC/12VZagyYQlinypu2EvoFvX/VwPRCc
         ti3OqNqZ/mwjyd614DCrD12QZxvWBLUWWGB5JdNjzGIm21jZYHdeT9RXz6Sw0U+gRMkM
         4KgI+eu0+iNwDqHcr1AzBwbwEdCifxaFf8pgblc7521P/ipR9zLDiShmJoVwfHlC3rk/
         cbIPnb4yQR07g9ovAcJnmbXfMiYdiU3LT9eo/8lUW1RtI6ByzxYZ3mKwX++o8s/cFRbp
         LVcWfWgsPJbg7DBamZL/CHG95xetNkn1BED0HRnXdwY5wS7i02Tn8Ba36fDkkmMBvV/t
         aXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683904135; x=1686496135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wO7KR/oI/b4LCHxvDoSFxI8GjKx7kT+apEfpkl3d+dc=;
        b=CTZJW0Mavq94yi4pZ4Ry+oRwjIZaAcgnpADeGkWHZg6recAlpBAWMS34v7NmHHmHwW
         2RehWhnuDFzeBA6emiZ8aEFhzYDbMOZIwiQqId1pVjPZ4mGcMPoYQUhvzuIUwatR8jcN
         zK3ynjqpKFSi9A6EVC/7cNuQfsV6HHKtiNruvnKflKMSIoSHCDibgoYUUipZyA74owu7
         MHObwh1/I3KavFoVoqaIBOW4MS8jy6kOxDrh0G3ipV62wRUVUG0w3W8Fr+lDPUJURk4t
         7CczkttoIWwnK4kDDphrF9Ceh/BDf9Q4h3U4hezSbC1xSsX7B2b3FuS1xCaf30nsrDOl
         XkSg==
X-Gm-Message-State: AC+VfDyZ6yRH9s/uJdqAaBZ/PcfOUorYVEc0mBMFN1h5khjNweGZL/Tq
        1WpT9z3ERY4QepUCEiysmUv2Vw==
X-Google-Smtp-Source: ACHHUZ41pC0Uxq6kk4wyQ/ywckcVTWMHSGhkvo8/0t2xQFLDitRPoNL7P49WkaCSUvZjVmm/62/W4g==
X-Received: by 2002:a05:6e02:1b08:b0:331:1267:31f9 with SMTP id i8-20020a056e021b0800b00331126731f9mr12688467ilv.0.1683904135540;
        Fri, 12 May 2023 08:08:55 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x14-20020a02948e000000b0040fa3029857sm5031956jah.128.2023.05.12.08.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:08:55 -0700 (PDT)
Message-ID: <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
Date:   Fri, 12 May 2023 09:08:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230512150328.192908-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/23 9:03?AM, Ming Lei wrote:
> Passthrough(pt) request shouldn't be queued to scheduler, especially some
> schedulers(such as bfq) supposes that req->bio is always available and
> blk-cgroup can be retrieved via bio.
> 
> Sometimes pt request could be part of error handling, so it is better to always
> queue it into hctx->dispatch directly.
> 
> Fix this issue by queuing pt request from plug list to hctx->dispatch
> directly.

Why not just add the check to the BFQ insertion? That would be a lot
more trivial and would not be poluting the core with this stuff.

-- 
Jens Axboe

