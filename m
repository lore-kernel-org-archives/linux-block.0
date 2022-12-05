Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC9C4321E
	for <linux-block@archiver.kernel.org>; Mon,  5 Dec 2022 18:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLESx7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Dec 2022 13:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLESx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Dec 2022 13:53:56 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FAA1FF81
        for <linux-block@vger.kernel.org>; Mon,  5 Dec 2022 10:53:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so12407019pjm.2
        for <linux-block@vger.kernel.org>; Mon, 05 Dec 2022 10:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hN16r2JqgO0aUt9hEV33NLw/555dF70HALoTZ9f98ns=;
        b=Fm9dfwrFeIHNqJDczZ8ygOt/Uha01dMRWprhcIoeUWieIM4pkz1xky0EJcPnQBQWe0
         m7GUZoU0/2aCb+0E0+M6kltGs6hlEENaCX5gfWhRnXRd0rye5mK3KgRvIyM/2Oob5UlE
         38SmhTUgfCQay5hI4WIf3FEGQSsP7+pCWGiu3ohS05iL+h2v7+4MM6ftNKTC3q+ULBws
         nL39f0K0e/CH9ck/0WnWtdA3yoVKa3Ds36+G8AkqXJGYa6Ma+P2vAgd/4nl8Sjjj7ig4
         xXJQXoxqZJQ1eNNeKYHnnOqVcnXQ7tDUkUNigzrEsoOXLZHKOOwqgr2IQdgxEPpBBKfc
         HsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hN16r2JqgO0aUt9hEV33NLw/555dF70HALoTZ9f98ns=;
        b=PDzCg4phprKxtplDzACBhhkxBbmulZmVLFfYyH91n8S8wepydjmHcDflmpfqyYCFmZ
         gAN0lTGi39KPeD12jRglJ0RPXUdFYm5E3wI49w1emdXq61odVkCuYJzcIEdh2AyedzaI
         KDgKi7xQ3tSIJ+5/lx4Q0+yAo3Ty25RJenyCbRrAqpUHN9kEsVY/4hNXX+l9qoB4unpr
         6DcR2/5262lGNtExPkNWFgXKlni7uEDsAN7m1iMR7UDCxcbImU+zPWGzVO45dLz4rWEE
         KV9rbmWCmxgKMzNd68cfE9xn0YMRIr3PmApChtZbLoFrRYHl8wd2pk5ypIBxMjK3g3in
         KDBA==
X-Gm-Message-State: ANoB5pnG0xLONtjKtzxZsNNgOyd4ij9n4LtQ9XPA4Sdd7BcgLjMtx5iI
        cU64Yx82Kh/ZKH08p3R6rlZ66Q==
X-Google-Smtp-Source: AA0mqf4PO6AFHe2UJAtP+NKsy/VfRk3d594BgBjTrOZGH8U7h8+eNxk2+VLeleDwTNhV8wJgpjSYkQ==
X-Received: by 2002:a17:902:e411:b0:189:8796:7813 with SMTP id m17-20020a170902e41100b0018987967813mr40667373ple.110.1670266434300;
        Mon, 05 Dec 2022 10:53:54 -0800 (PST)
Received: from ?IPV6:2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a? ([2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902778800b00189a7fbff33sm10880935pll.170.2022.12.05.10.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 10:53:53 -0800 (PST)
Message-ID: <23c98c7c-3ed0-0d26-24c0-ed8a63266dcc@kernel.dk>
Date:   Mon, 5 Dec 2022 11:53:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
 <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/22 11:36 AM, Alvaro Karsz wrote:
> Hi,
> 
>> Is this based on some spec? Because it looks pretty odd to me. There
>> can be a pretty wide range of two/three/etc level cells with wildly
>> different ranges of durability. And there's really not a lot of slc
>> for generic devices these days, if any.
> 
> Yes, this is based on the virtio spec
> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html
> section  5.2.6

And where did this come from?

-- 
Jens Axboe


