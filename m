Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660E7C433FE
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 12:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiC2Mt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiC2Msz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 08:48:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BB82662F0
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 05:44:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i11so6228085plg.12
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fCBm6T6pHoGIJABk66WaUaTY6qy2GGnpicpMa2oqsDc=;
        b=2b1CeJjtCPxDqdS4uKb/Vs3/mcEc+f6DLzMvUjEEHgbjZcCF9gtgRgyDd4XONvvtpl
         k7xHwXSSopPIr5xQDez8P+sXYAOABfIgO/nkOvJeVWyK/rFi3jkPiOXMHlg9hqI9dwZv
         cpzNjEE/Hbr2IbinNxOecFTKnCuO+cTSS2LBdWFIDFagpVUpaQm1Yra0EBhWpQv0a9Ah
         GOBoA+dcdR2CCmlGOkd4j9v/Zx4N17wgpj6lTJbD/DqiBWvTUnbvMtzab4gZn1taksNe
         ewb2Gx7piJScXnQfWLgezPyeQUuTN+y2gjVjb7qKuKev74h3zY2TigrpPJjjG02JrSYQ
         hV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fCBm6T6pHoGIJABk66WaUaTY6qy2GGnpicpMa2oqsDc=;
        b=ieqa0PlJzguGUuV1c7M1I5uWuzeOCU2nfBuPRTwAMaEz96Zor/GmDzRhIBV/aIiLV6
         R5/mZqtP3YzfzFA1+Vx/SZljt6mZLySTXWweEK5FoXmWsfLVCtnDAu9h+hq9qxvYzQPO
         PNgZvGZk5MYfyj3///RHPjmSCwy5oZISJF7LWml7cAJdvcXQqcz6EhxxMqn4z6tPVchZ
         ZnwDISI6xH6i1/focZ0e7NRKm+ZbZimf+2fNJAcDuMRJvZSnDrKRqM2Ak53/mUAJNFzk
         ssSmVrzP+XtTlgs9vpUEtlV+Fydc/ca7Az63/wFhTCyKkyoAkIkc9YeKW/FVjbKOWECq
         +Ebw==
X-Gm-Message-State: AOAM5330/spaslcmqdU6dfxhvwpgPdyKno1fCGblGybFcRLcgvq8H/ip
        OIJF7Kb34vWd6pkRn8VChdTHd/4u/0TRY3wd
X-Google-Smtp-Source: ABdhPJyISzzTKjsNvY35EAKYfQydvSaJ9JfroFH0CCCUtcAiaNWUJ4RSTdNv+cCyY6rHQztRw2/mXQ==
X-Received: by 2002:a17:903:2488:b0:156:1e8d:a82 with SMTP id p8-20020a170903248800b001561e8d0a82mr6121809plw.51.1648557870299;
        Tue, 29 Mar 2022 05:44:30 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm20470414pfu.202.2022.03.29.05.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 05:44:29 -0700 (PDT)
Message-ID: <190625d8-ed84-f657-6058-2d151f6d4caa@kernel.dk>
Date:   Tue, 29 Mar 2022 06:44:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC 1/6] blk-mq: add a new flag
 'BLK_MQ_F_NO_TAG_PREEMPTION'
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, andriy.shevchenko@linux.intel.com,
        john.garry@huawei.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <20220329094048.2107094-2-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220329094048.2107094-2-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/22 3:40 AM, Yu Kuai wrote:
> Tag preemption is the default behaviour, specifically blk_mq_get_tag()
> will try to get tag unconditionally, which means a new io can preempt tag
> even if there are lots of ios that are waiting for tags.
> 
> This patch introduce a new flag, prepare to disable such behaviour, in
> order to optimize io performance for large random io for HHD.

Not sure why we need a flag for this behavior. Does it ever make sense
to allow preempting waiters, jumping the queue?

-- 
Jens Axboe

