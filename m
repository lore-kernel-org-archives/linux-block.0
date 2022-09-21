Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F52ECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 10:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiIUKde (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 06:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIUKdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 06:33:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7583290C68
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 03:33:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s14so7133040wro.0
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 03:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QNdK/x1FwWDTtDiwm+N/ozUQEsyD1wB+oSdekgNGTIg=;
        b=axbU1KZEPt9HoFsx/4W5fbKk0Gk2Z49UGAlbSbDQsURq7gkj8NsotdzJDjC/qbSH+W
         sJTFtxon7elLIMdmkwPak/bCn+PS5r6UGcS/MfKmexA91F8H+Sk/K8eNuc1j4blaUAco
         fzTXTn4xdiz4Wr+O4zWy/UVl+92RM7Ry6j/t9BMf2I8QOnOifks3RhONYxH2YASkTDDe
         +9kAd9aCjOT0iE4jun77GcaaaGRYhgtz42w2Ktjupc44jcHIuM+E2mxEfKun2Ba5lAwV
         wzf2GMvq95lOWK8yhnL2HJAlYgBXB/Qa7qmOFoZvilGdUhwyv08NEOMGjg52/wbXwT2r
         r6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QNdK/x1FwWDTtDiwm+N/ozUQEsyD1wB+oSdekgNGTIg=;
        b=qa61PwVfPg15mUnwXV7ITfJ7uYW/nZZ2Uuocf7vgUlMKSsRhOIVhzIDebHWT3Mx2lM
         Sv6hOnr0BbCa3VCCcS4gT9BrHtrwby9POdhnCPwFqhPtaz4yCv9vfe5F7ZoKGbR9Y2kY
         9D0oLgnOgP1+JtCxU63VwdpBqhRxvM7c4NGBs+MW3ncQ4Kec70d9EMM9ZppHXaPSBDoD
         D7Nz3gdtLS3o0l85fh78vI/lpnVz7RaBuEyxd5HzVWlDZfdcXcJvsljmYbQeWWBgFAv3
         s2kQlWG75U2InHAVnYF24k83+7JSIlEj6eHS8QUkjM3WnzBXbkKSds+9sz2JT+gcYLJS
         ZdLA==
X-Gm-Message-State: ACrzQf3zQcoTyX+eVG4KxC/29SLQfDAUnr4vv61+PVBeDbENSyH+CV03
        B4Sjtg1ZJwSM11tBKC62zpbSGw==
X-Google-Smtp-Source: AMsMyM50CgQ5xl3r0AX3gxpIgmXPUs4Doiiew8orNM97DPAkZMD04CyFbVnv+mbWb8CmFb0RoeDaMw==
X-Received: by 2002:a5d:51c3:0:b0:22a:c371:a4e0 with SMTP id n3-20020a5d51c3000000b0022ac371a4e0mr16449172wrv.522.1663756405961;
        Wed, 21 Sep 2022 03:33:25 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ba30-20020a0560001c1e00b00228655a5c8fsm2197599wrb.28.2022.09.21.03.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 03:33:24 -0700 (PDT)
Message-ID: <677922df-1674-a872-4bc6-e9c874ee4e46@linbit.com>
Date:   Wed, 21 Sep 2022 12:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/2] Remove orphan declarations for drbd
Content-Language: en-US
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk
References: <20220920015216.782190-1-cuigaosheng1@huawei.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220920015216.782190-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 20.09.22 um 03:52 schrieb Gaosheng Cui:
> This series contains a few cleanup patches, to remove a orphan
> declaration which has been removed and some useless comments. Thanks!
> 
> Gaosheng Cui (2):
>   drbd: remove orphan _req_may_be_done() declaration
>   block/drbd: remove useless comments in receive_DataReply()
> 
>  drivers/block/drbd/drbd_receiver.c | 3 ---
>  drivers/block/drbd/drbd_req.h      | 2 --
>  2 files changed, 5 deletions(-)
> 

Both patches look good to me, thanks.

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

PS: I think trivial fixes like this are important, but they also create
additional maintenance burden. So if you have more of these in the
future, maybe save them up and submit them all at once (maybe even in a
single patch if they are related). Thanks!

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
