Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08154C636D4
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 18:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjBJSSW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Feb 2023 13:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjBJSSU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2023 13:18:20 -0500
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FD15A9C6;
        Fri, 10 Feb 2023 10:18:11 -0800 (PST)
Received: by mail-pg1-f178.google.com with SMTP id x10so4278158pgx.3;
        Fri, 10 Feb 2023 10:18:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CuIV2ZniuR6JiN7/4weCn+3flzvSdKoSszT4evfBW74=;
        b=0vM0dRsot13GlgKxdEPxm6rjvV2GAb8eN7CSctXm2vBi/Rn8lIJ1Si9O/zxeh7VMe4
         kBW/6atqTzLpMCje+HOWfWEtNZ3wSfRrID2ugjqsWK0cOgY8GRsacs/5Bjn3LT2D7iQM
         tTU3LGKuaZphweIzbyztGJ9oJ9akdTnOMsom45BHOOqiIzvH9QagUzKAQ9La9C8PBfR/
         vgvbHzIBOhCPVHjwEosioet79Wvtz0brAmZiDFrekvItPtrfeIlD4JqYZEa/jNZf9iLZ
         kvnJM1flst4XeM5LKST3dnuLUgokbXF2I+Mp3D7gC7iE7MO5jkb8/vZM45pBPXrdWtXq
         zIFA==
X-Gm-Message-State: AO0yUKVyvxXJXZN0Worerzh+FXJNHovnqnmajX5D3Wk9yd61hejy+0MS
        kotu/QsNXT1hbIsJpewp8pagOBjIDBc=
X-Google-Smtp-Source: AK7set9N6MjmZsXjybdAr+hJoPFSqTEoYhUaKedYxqLCBx2V8yPx0GxWd7g+wUZ3hObnC7poWBjmIw==
X-Received: by 2002:a62:14d0:0:b0:5a8:5dcb:b775 with SMTP id 199-20020a6214d0000000b005a85dcbb775mr5120458pfu.14.1676053090955;
        Fri, 10 Feb 2023 10:18:10 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id v9-20020a62a509000000b005941ff79428sm3645099pfm.90.2023.02.10.10.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 10:18:10 -0800 (PST)
Message-ID: <69443f85-5e16-e3db-23e9-caf915881c92@acm.org>
Date:   Fri, 10 Feb 2023 10:18:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        kbusch@kernel.org, ming.lei@redhat.com
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230210180033.321377-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/23 10:00, Kanchan Joshi wrote:
> 3. DMA cost: is high in presence of IOMMU. Keith posted the work[1],
> with block IO path, last year. I imagine plumbing to get a bit simpler
> with passthrough-only support. But what are the other things that must
> be sorted out to have progress on moving DMA cost out of the fast path?

Are performance numbers available?

Isn't IOMMU cost something that has already been solved? From 
https://www.usenix.org/system/files/conference/atc15/atc15-paper-peleg.pdf: 
"Evaluation of our designs under Linux shows that (1)
they achieve 88.5%–100% of the performance obtained
without an IOMMU".

Thanks,

Bart.

