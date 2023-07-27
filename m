Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192B3C001E0
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 14:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjG0Onf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 10:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjG0One (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 10:43:34 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2B9F2
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 07:43:33 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b9cdef8619so6526935ad.0
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 07:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690469013; x=1691073813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CP19JBqlXlVacq/YBzOgglGyuG6Tt1P84y124adiYMA=;
        b=NY7gbhvU8ucK8egJe82M23OyjQWeLKEeedG6zc6nMV8GUefYAUEkptdQxm0LwNYmTS
         wmzHoK1ccsdqY/4b2UjjCqbqbjT8kdnO5UOEEKwQVUg2MqebgjAA43u4BhoOigKF45Ze
         LNg9kpw5Mt+/HZCkSHM1SqpE2DblsOPWLOtLHcMm5C/cGSs8d6YM98slokbKOD9TCBih
         4bfEcTRnDbGk7g/sxv/B6G3lWe0GeK4HgOfHzPENbkKIgq1BoT6KIxvXOxro4daLYaX/
         VTC7zijxDxMUtI05XToeRoX/jMdWAbdO5eA2nOfNArKH2OlocKCYn/2Dh0OU9O7/XnJq
         4DFA==
X-Gm-Message-State: ABy/qLZNm5qyKk43fqt3NTKoNsxQpoUsy1dPG0/11txJ6b6P8ivzTkFP
        U4f8KXThvDXbj7iNI2S+P5k=
X-Google-Smtp-Source: APBJJlHd1gA+d2uf0lEaXMhtK10KetDw0lKB+10ha7prKG5yyNxaABQ4PBahfl/ijDTxwnUd52OteA==
X-Received: by 2002:a17:902:d4c7:b0:1b8:b3f0:3d57 with SMTP id o7-20020a170902d4c700b001b8b3f03d57mr5386812plg.31.1690469012954;
        Thu, 27 Jul 2023 07:43:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:32d2:d535:b137:7ba3? ([2620:15c:211:201:32d2:d535:b137:7ba3])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b001bb0b1a93dfsm1748721plb.126.2023.07.27.07.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 07:43:32 -0700 (PDT)
Message-ID: <0880328d-f2ab-beca-a3d4-a7db04123edc@acm.org>
Date:   Thu, 27 Jul 2023 07:43:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/7] block: Introduce the flag
 QUEUE_FLAG_NO_ZONE_WRITE_LOCK
Content-Language: en-US
To:     Nitesh Shetty <nitheshshetty@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-2-bvanassche@acm.org>
 <CAOSviJ0uBynC9M16cRusttU1OaB4HJS8=xmjCGP7bUCMicmiOA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAOSviJ0uBynC9M16cRusttU1OaB4HJS8=xmjCGP7bUCMicmiOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/23 03:59, Nitesh Shetty wrote:
> On Thu, Jul 27, 2023 at 1:39 AM Bart Van Assche <bvanassche@acm.org> wrote:
>> + * Do not use the zone write lock for sequential writes for sequential write
>> + * required zones.
>> + */
>> +#define QUEUE_FLAG_NO_ZONE_WRITE_LOCK 8
> 
> Instead of QUEUE_FLAG_NO_ZONE_WRITE_LOCK I feel
> QUEUE_FLAG_SKIP_ZONE_WRITE_LOCK is better.

Hmm ... this patch series makes it possible to use an UFS storage 
controller and a zoned UFS device with no I/O scheduler attached. If no 
I/O scheduler is active, there is no zone write locking to skip so I 
think that the former name is better.

Thanks,

Bart.

