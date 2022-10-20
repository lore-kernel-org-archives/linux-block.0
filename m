Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B880C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 13:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJTNT3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiJTNTG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 09:19:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD2C19637A
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:18:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso2132356wmb.5
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AivZCskSOYsGt1NOGJ1DcoR6o1h1b6rR2pJbteQkzQg=;
        b=iW63skS2IwVx2/JzCRqs4wuTTbA5yLG9HhAZUQr/4eRngP+q99jDLysK0pZwZfbz4Y
         jLoSeQQ2Br+KYxRTBCkRAlFQTwfwxawXHzPOG1UunpvWYvMcuY7VygskemU4PdUtQuAt
         mB4z/2uLha9SfYZsbAoUVMQgC78AhcHVjOdIALDctRiu/qEDB/nRyJpkkGxHzMHRpUjy
         cHPO8vg+GfQT4HuwLMmIzpFkK99XiviHzgsXMOalnG0sE4NmFSPWImRG+5/rMrMilcRQ
         bUJSi1oNy+prOas/DZGTbAerV3QU05U+qdgeSaAunUR6AJPZ8AvqNwTJtyLe6gz35GsY
         nVjA==
X-Gm-Message-State: ACrzQf0yCPgjTOTFGRZVslP084eQpbCFxpKj6T8C2F1j6/APNnnIR1Kd
        Y1JtadjGdgKEMOAVKlDfLAs=
X-Google-Smtp-Source: AMsMyM4z/2NuduNUmj7tIVaRf8fesahqvdC0oIsxf/e/U2kmrpCbzKikgL+JSQfooAtPwRKlT4hrEg==
X-Received: by 2002:a05:600c:54f2:b0:3c6:bd60:5390 with SMTP id jb18-20020a05600c54f200b003c6bd605390mr29908717wmb.206.1666271788615;
        Thu, 20 Oct 2022 06:16:28 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ay41-20020a05600c1e2900b003a6a3595edasm2977898wmb.27.2022.10.20.06.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:16:27 -0700 (PDT)
Message-ID: <c540811d-1664-458a-0e97-d77a2a0b3f4b@grimberg.me>
Date:   Thu, 20 Oct 2022 16:16:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: per-tagset SRCU struct and quiesce
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi all,
> 
> this series moves the SRCU struct used for quiescing to the tag_set
> as the SRCU critical sections for dispatch take about the same time
> on all queues anyway, and then adopts the series from Chao that provides
> tagset-wide quiesce to use that infrastructure.

Looks nice, should be easy enough to modify scsi_host_block() to
use this as well.
