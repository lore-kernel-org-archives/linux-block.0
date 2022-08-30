Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CEFC0502C
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 12:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiH3MPH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiH3MPE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 08:15:04 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096B61D0EC;
        Tue, 30 Aug 2022 05:14:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m2so10925172pls.4;
        Tue, 30 Aug 2022 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fJYEc38Yw+lvhMhFHsgvslje7wKIBBoSuOJR/tnkpTo=;
        b=iav6ByDoj1t+KIwjs/wKPJKseMmwTTNbsSaMDSPSEdsAX0bOLx423c91g/qUE1QWWV
         hsDW63egxm0McLnp/oUNvKX+9KgwbMjAnCAhXLUYqB89JW6RfsE2c+otccpxAbGHrhv+
         BUwnReGrdjrGFD0zSQrnZjVXxmC49cEqQ7KV3AYHpwqrZObRLfolAq7EQrIm1Y9Nao1J
         zBdu/cJfH9G6YQNGOfuhWP2SZ7a9cuoiLJIp/3JJgDTwaWHxjzyx9uSbhOXJZ09TwdiC
         sspTj3aV2JXfTK7J4dMgcEms/1EEy9hV1pWYIpCMS2vd/CL7PK+BKMnQIxxn+KWaEP+G
         SHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fJYEc38Yw+lvhMhFHsgvslje7wKIBBoSuOJR/tnkpTo=;
        b=gGxde9GKPC5HNkRfVptCbSeqrNWnQgZkH0cQFE32q1SCSstuATgKymXCAfF11OhF1d
         UktRxES/1JWS6mwruXz3ptOD2l0axeC9lDXEsu+XzyUa307gF3IaWcOhU0zTPgfhSEkk
         J6lHqOnw1FdQO9SZueK+VxQwicBEzvbIBkh2040FMJSHhgVaVRV77V9goDMJIVpG8QRq
         jScRIFCJYdLdgZNLZw6OC+nl6OSRlSTHoptvBR+jIzVCT6Yg7yMaUDtY8F6sQTtjYyDt
         zj8tFyiObYAElsyFzmxwQEMrbEAwIrIh3m5I0YWiOBxXmwc90+vPSu9HZqqlF+p5pARB
         7+1Q==
X-Gm-Message-State: ACgBeo1BrpzJNO4pe0jBb3cRL532GnSzZL9tf30qFK3vR6AsxOFx1J1u
        EcdJACLqVXo3QC5omnVwwOo=
X-Google-Smtp-Source: AA6agR7GYeFJ8cQSDyVYpSw4KU95qia+W8TReIXPVDJltkmKf8PRHulG7d/YfXNEtl/T/mwuGZ67SA==
X-Received: by 2002:a17:902:d2ce:b0:175:994:7778 with SMTP id n14-20020a170902d2ce00b0017509947778mr4594502plc.43.1661861698605;
        Tue, 30 Aug 2022 05:14:58 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id y27-20020aa793db000000b00537f7d04fb3sm6973544pff.145.2022.08.30.05.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 05:14:58 -0700 (PDT)
Message-ID: <21e0e256-c223-5395-d992-040e98ce3308@gmail.com>
Date:   Tue, 30 Aug 2022 19:14:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] Docs: ublk: add ublk document
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220828045003.537131-1-ming.lei@redhat.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220828045003.537131-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/28/22 11:50, Ming Lei wrote:
> +- UBLK_CMD_ADD_DEV
> +  Add one ublk char device(``/dev/ublkc*``) which is talked with ublksrv wrt.
> +  IO command communication. Basic device info is sent together with this
> +  command, see UAPI structure of ublksrv_ctrl_dev_info, such as nr_hw_queues,
> +  queue_depth, and max IO request buffer size, which info is negotiated with
> +  ublk driver and sent back to ublksrv. After this command is completed, the
> +  basic device info can't be changed any more.
> +

Is "see UAPI structure" means set the structure?

-- 
An old man doll... just what I always wanted! - Clara
