Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C902BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 11:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiERLyI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbiERLyI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 07:54:08 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D30E36E35
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 04:54:06 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id er5so2624011edb.12
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 04:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hW2Dr5J4nseMlDzAD5820/5Bmxx/Ly068xqN61nkp4w=;
        b=Fh09nUyvC+LR6xBp6ghqdtF0dP6BmFBY7dMg11cNAkGY5dpr/AxxWeaM9XKV0ei2c7
         KqsTHy007VGpkxp64XNpxlba+i2OxucEyrxUBC5OnEGkiUlj6KFz3BM+LWNG98jTp+7F
         i/LAqjeZUXEKkn8GmVINWw4t8wXKNQU2JGRsXb9qcODddTFGq6LJMpUXV4zrj2qKlLFC
         uNZWQhhoy1eFj3t3gdtFEOWeaEB+gj1zbXYAcqz17pw+IxoEHqA8crLJ/D6zbSKTLCjY
         3fAYUTLDeHDx/HVgV5OA/dNbhIrgMC543mzqSg8edmmEl01GidcFCn4UW8RuMdmWrIEa
         lW2Q==
X-Gm-Message-State: AOAM5315Zy0fBL/rEtqZ1oUKQDyMHakikKdgPqC+r1/Ykw3zSJQW5p+G
        l4erL0x3nrhc98O3L2MYQeDYZSmzoaH1qPMW
X-Google-Smtp-Source: ABdhPJzk44FSoOXKG5dJzWg5JuuMY1KCVuq5dAGxZNoCUYNxgQKfz5U8ypgXTAWq1vxyZFMHpqkW9A==
X-Received: by 2002:a05:6402:2789:b0:427:bc78:85c9 with SMTP id b9-20020a056402278900b00427bc7885c9mr24530241ede.50.1652874844673;
        Wed, 18 May 2022 04:54:04 -0700 (PDT)
Received: from [192.168.50.14] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id l3-20020a056402124300b0042617ba63d5sm1236502edw.95.2022.05.18.04.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 04:54:03 -0700 (PDT)
Message-ID: <632dfb2d-b94e-39ab-3777-d1248218daf7@acm.org>
Date:   Wed, 18 May 2022 13:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH blktests] nvmeof-mp/001: Set expected count properly
Content-Language: en-US
To:     Xiao Yang <yangx.jy@fujitsu.com>, osandov@fb.com,
        yi.zhang@redhat.com
Cc:     linux-block@vger.kernel.org
References: <20220518034443.46803-1-yangx.jy@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220518034443.46803-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/22 05:44, Xiao Yang wrote:
> The number of block devices will increase according
> to the number of RDMA-capable NICs.
> For example, nvmeof-mp/001 with two RDMA-capable NICs
> got the following error:
> -------------------------------------
>      Configured NVMe target driver
>      -count_devices(): 1 <> 1
>      +count_devices(): 2 <> 1
>      Passed
> -------------------------------------
> 
> Set expected count properly by calculating the number
> of RDMA-capable NICs.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
