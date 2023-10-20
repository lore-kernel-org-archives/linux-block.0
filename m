Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E32C001DF
	for <linux-block@archiver.kernel.org>; Fri, 20 Oct 2023 16:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377891AbjJTQp7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 12:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377885AbjJTQp6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 12:45:58 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDB0197
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 09:45:57 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7789577b53fso59122185a.3
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 09:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697820356; x=1698425156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9PuSn2bB2IxGmknw6dB/Si6eiBpR7N2reEFrg6SRRw=;
        b=TvyXjQegWGkYpxZOUBTEIKc0IbgW0aETBXcecZp8rKOkKtrf8mFM2BkkPX+0vWgnhJ
         AxdY/pksUW/mcHkQHIApS8fQ9DH0Bzv2u5WMpQdOKL65TQ5RSVmCqHPJXE0KqdQh00ff
         JzuH7RlYLIWgOysRvW4yNG3S0o16CW1PyYlFYZDmqbjptZiUWTZv1YLiLayYwk+c+0sE
         Yjk5Y0zkUr2H3QLMMQajh2aPuJsSN5PkRPAaMbHRml/SQxDUx/fwPswoD0gMIIgbY8Z3
         U9ajhzloEsYDDoXB4Tq182FqCVCpEcmWGAXJDhGaES88DQToQUJPV5pxnIVg6IJ2Q4GT
         WlLA==
X-Gm-Message-State: AOJu0YyWWRsyRu8sa9fDDrhibB5n4vF60GqH9mhf/bBzUrK1ghnlXYWI
        qVvmHCPVYieZBz8pXp1lTzQ=
X-Google-Smtp-Source: AGHT+IEJInSBruV0jfpzWfofWc1iRCzttLXdkFnZ7iVpoikJ5rWL5wnHg0VUGTK6J4ksoF2BghrPBQ==
X-Received: by 2002:a05:620a:2995:b0:76a:ece7:2071 with SMTP id r21-20020a05620a299500b0076aece72071mr2700085qkp.41.1697820355932;
        Fri, 20 Oct 2023 09:45:55 -0700 (PDT)
Received: from [192.168.104.176] ([64.245.0.218])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a22ca00b0076cc4610d0asm738158qki.85.2023.10.20.09.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 09:45:55 -0700 (PDT)
Message-ID: <f2728de6-ff3c-4693-b51f-58c3d46d0fbf@acm.org>
Date:   Fri, 20 Oct 2023 09:45:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve shared tag set performance
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>
References: <20231018180056.2151711-1-bvanassche@acm.org>
 <20231020044159.GB11984@lst.de>
 <0d2dce2a-8e01-45d6-b61b-f76493d55863@acm.org> <ZTKqAzSPNcBp4db0@kbusch-mbp>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZTKqAzSPNcBp4db0@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/20/23 09:25, Keith Busch wrote:
> The legacy block request layer didn't have a tag resource shared among
> multiple request queues. Each queue had their own mempool for allocating
> requests. The mempool, I think, would always guarantee everyone could
> get at least one request.

I think that the above is irrelevant in this context. As an example, 
SCSI devices have always shared a pool of tags across multiple logical
units. This behavior has not been changed by the conversion of the
SCSI core from the legacy block layer to blk-mq.

For other (hardware) block devices it didn't matter either that there
was no upper limit to the number of requests the legacy block layer
could allocate. All hardware block devices I know support fixed size
queues for queuing requests to the block device.

Bart.
