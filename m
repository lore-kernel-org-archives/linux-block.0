Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0778C433EF
	for <linux-block@archiver.kernel.org>; Fri,  8 Jul 2022 18:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbiGHS7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jul 2022 14:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbiGHS7A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jul 2022 14:59:00 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0D91C138
        for <linux-block@vger.kernel.org>; Fri,  8 Jul 2022 11:58:59 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id c13so13315185pla.6
        for <linux-block@vger.kernel.org>; Fri, 08 Jul 2022 11:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8El55oBhsal1YvHv4IXgTDyrjOJ73nQdWIhXAlq6X58=;
        b=TbN1WxCd6ezJNBVFzRJ+oHlTnWw0yHz4i039/BIVpwyWk+T5pPWQH0IZM4yw+8x3Lg
         s+muUY/0soU8shnP4PS10rGfiQE22gK5omaJbm4YisgxydBmnW2ze2oZZw6nO6OSQB98
         b77f5bMp2b16CMv+Tr5ACV0+QR6k4g6e3dCYPDAwoo5a6DUW5r4nJdK8jjV5rqDPPqU0
         1zFsdO0nHCFZJ1OkRYVqXbAf2dyGUnyE4wAYZyl+NUz6Jlws7Dup8N2aiKFjuVZSNfjO
         vyxv1mEP+p3TEtfbGuvgF+ISAf2L3NkQrgvkngGEj5dp7rJDsevEuqqq8qtK2cHZBuUz
         u8NQ==
X-Gm-Message-State: AJIora81HjSVJuIH8HPm0cLw7Yr1qulwmzX4l0Fkbxh/JDFZFc85w1RZ
        LJk1oejV1P9PhnLG1gbq7CMrYQ1cq9s=
X-Google-Smtp-Source: AGRyM1u31kiAYPbguv9ZthcIeygs6/BqhPnSdUiZJNQb8c9w02A8HFa+TwhukQTeCpGPelUgJA2oUw==
X-Received: by 2002:a17:90b:4a12:b0:1ef:fd9e:a02e with SMTP id kk18-20020a17090b4a1200b001effd9ea02emr1446301pjb.216.1657306738673;
        Fri, 08 Jul 2022 11:58:58 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b0016bdf53b303sm12194911plh.205.2022.07.08.11.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 11:58:57 -0700 (PDT)
Message-ID: <def01493-bd2d-bed4-ab1a-9b4304687692@acm.org>
Date:   Fri, 8 Jul 2022 11:58:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bug report] blktests nvme/005 trigered debugfs: Directory
 'hctx0' with parent '/' already present!
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs9Jhg4DZRnck_rdGWtpv9nLTAF__CVtPQu9vViVUZ-Odg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHj4cs9Jhg4DZRnck_rdGWtpv9nLTAF__CVtPQu9vViVUZ-Odg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/22 09:32, Yi Zhang wrote:
> I found below error log when I ran blktests nvme/ tests on aarch64
> with the latest linux-block/for-next,
> Please help check it, and feel free to let me know if you need any
> info/test for it, thanks.

Is this 100% reproducible? I tried to reproduce this yesterday but 
without success. See also 
https://bugzilla.kernel.org/show_bug.cgi?id=216191.

Thanks,

Bart.
