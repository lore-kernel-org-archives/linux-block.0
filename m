Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D0C38A2D
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 12:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiJZMqO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiJZMqN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:46:13 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C8F9E0D5
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:46:12 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id l14so18888675wrw.2
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHOZvPiQyJrYIwJpVXjaISAt9cvh1UXpPpZ1J0WtUzM=;
        b=Af7/C01UBYl+LUS4BG0hL6a65Ir+pwmv+z7If88F8uLANm4dMIiXbEkU8dtifIvJfM
         G4M1q0zenx0EshkDaFff/zHete0Kb3joOmkBULpZgr7ztN6etd3cMHz9G8CagtsCYX/x
         m/forSlbpTq3WxcXalAbbHnGloq7tIHNaAO/2gOaI+kAefU9C2p0ovdHUB+pEbnOqdeW
         044Be4sF4Q9ak2f87lO36dbI3JoK5hSW9aLv08MZo6bZj2F3WYYSLBlEqmFaZxer5616
         0ySQiLXEWepGQPuPePPkEPwf0MeMwHxVRlToP9Iz7kDlUSZt1pIJsXe7NVFu76NscXla
         FTsQ==
X-Gm-Message-State: ACrzQf15sihpSr9+wVviqRNqnz+LmpRdGJ8MX7AF+xTwKoQaU+mI/Nxn
        onf8+KHwkTSFnfxEaktt4Ng=
X-Google-Smtp-Source: AMsMyM7G7ZltULJQfexGzwYocPJXRgyYUw7xlKQFhXYAxd9Bd3zLdgEwUgiMEkslhk6CJpfljDTrMQ==
X-Received: by 2002:adf:e583:0:b0:236:6280:57c9 with SMTP id l3-20020adfe583000000b00236628057c9mr14344980wrm.262.1666788371201;
        Wed, 26 Oct 2022 05:46:11 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b00228cd9f6349sm4967595wrv.106.2022.10.26.05.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:46:10 -0700 (PDT)
Message-ID: <cafdc008-9d07-758a-bb66-1ca62b0baa50@grimberg.me>
Date:   Wed, 26 Oct 2022 15:46:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/17] nvme-pci: refactor the tagset handling in
 nvme_reset_work
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-3-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The code to create, update or delete a tagset and namespaces in
> nvme_reset_work is a bit convoluted.  Refactor it with a two high-level
> conditionals for first probe vs reset and I/O queues vs no I/O queues
> to make the code flow more clear.

This is clearer, but what I think would be even cleaner, is if we simply
move the whole first time to a different probe_work and treat it like it
is instead of relying on resources existence as a state indicators
(tagset/admin_q). The shared portion can move to helpers.
