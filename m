Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0845C433EF
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 03:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiFYDHX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 23:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiFYDHW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 23:07:22 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC44A3BFB6
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 20:07:21 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so4432203pjj.5
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 20:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8PhPnJufRPGUoXpnT6jir/NjOF5m2WMjIT68ERjlmi4=;
        b=FJzOKbS2eN2JxLyDviAP5TgrQfgvvOKZbJW5QkyXhsq8vQ6orphKBE0fv5bYlPs1+d
         B5Y1qeoYdOhn0D4GbnUtSXj1m16wUhfl3zBhNwbLTJUTa2iJnx2moGE2XAWE7LiRudci
         y94x9HG0F8RzY5guuVrI8Bn8LnoFoWStbjYNdNVGUmuId2seXnsCjLPpuFwi4lvmI05F
         KTT7vutNaxIH24wPKWTrpByFcwvRsdWCR97wmlPCDxX2TLjc5DCw1eHRkJs6e9TkRqZy
         CEWahazDyuvavMaMXkt72CzRI5Fz9sK/TnVfKjf631ExeKBVsQVjgiz1vIeUtTHNFEAT
         e2+Q==
X-Gm-Message-State: AJIora8KUYhzRhVpPEIuuRkXUDsD2D6ijKlcHZwTx3KbJfLT+t6ONxlr
        L/yxoP9zl3QoV/ZUwxR3M/I=
X-Google-Smtp-Source: AGRyM1vgVsFdSo06omUvwg9EE4TJn/PIWxxoH3Z3HJiP1xjg51923vwqzJ9iTLnSCq7qpfrpWjKIPA==
X-Received: by 2002:a17:903:22d0:b0:16a:3039:adc9 with SMTP id y16-20020a17090322d000b0016a3039adc9mr2253882plg.32.1656126441126;
        Fri, 24 Jun 2022 20:07:21 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b0016a0b31a8bdsm2557894pli.4.2022.06.24.20.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 20:07:20 -0700 (PDT)
Message-ID: <a89698fb-2799-5131-84a3-34a7d793b023@acm.org>
Date:   Fri, 24 Jun 2022 20:07:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/6] blk-mq: rename blk_mq_sysfs_{,un}register
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220624052510.3996673-1-hch@lst.de>
 <20220624052510.3996673-6-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624052510.3996673-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 22:25, Christoph Hellwig wrote:
> Add a _hctx postifx to better describe what the functions do, match
               ^^^^^^^
postfix? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

