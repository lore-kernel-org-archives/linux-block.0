Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F90EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 20:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjG0U5y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 16:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjG0U5w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 16:57:52 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C4E30D4
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 13:57:51 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b8ad9eede0so11371705ad.1
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 13:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690491471; x=1691096271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQxvoRRNpydwDtP4KHTZYZZ13P/5sMZ6ac1Za+WqqRI=;
        b=kPLwkTAu5WIl+i9+kmukHkqn+Iwq49JuHwrlEJvq5AKc92gf0zcjkn+g9klIhXueJy
         yOGBQb3ahb8qtMmNoVX6fy2tFvFe/F7Dd9evRUjLFYFjSJvadocMGsHZSWQzhHUKwDCL
         df96eKwt+4UwOJv68ZlNEzHda2d7Q5ev4+aGqBQlIQCIAjHcjjLODWpaw4XMkmGjjD8G
         idGurd88hujCWzXlJU9UDYVfUQrXPsHmBgKJ9Zc5i9s4k7kFLYalsTkjs4srs8TcSnqq
         31Q+aBLGesafLEwZOnAZ7JNZXm1AWMfPu48u+XYA162BsnBtGu3YB+Wm65sx+fx2J1/0
         s1cA==
X-Gm-Message-State: ABy/qLbp/9Lw859ewbnJLnzmsnNIGwlzAQ3k92k2SL81/znBCY567ra7
        U3HSkcb0g10epAvNAZLgldAeGpvl9gg=
X-Google-Smtp-Source: APBJJlGJmE4PSGChpn5ESRrTBZxPCNikryOgjHUzGKr3mKNGFSVrBiRwA+USNHlSYqUsOP9ianqrGQ==
X-Received: by 2002:a17:903:481:b0:1bb:59da:77f8 with SMTP id jj1-20020a170903048100b001bb59da77f8mr418340plb.48.1690491470836;
        Thu, 27 Jul 2023 13:57:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:607:27ba:91cb:68ee? ([2620:15c:211:201:607:27ba:91cb:68ee])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902740100b001b9ecee459csm2088567pll.34.2023.07.27.13.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 13:57:50 -0700 (PDT)
Message-ID: <29e266d7-a2f6-1125-83b1-215c1e267ea5@acm.org>
Date:   Thu, 27 Jul 2023 13:57:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/7] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-6-bvanassche@acm.org>
 <c4e4b310-c6c6-e7e7-b5e3-ff44dc63097f@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c4e4b310-c6c6-e7e7-b5e3-ff44dc63097f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/23 17:33, Damien Le Moal wrote:
> On 7/27/23 04:34, Bart Van Assche wrote:
>> +	if (blk_no_zone_write_lock(rq) && blk_rq_is_seq_zoned_write(rq))
>> +		cmd->allowed += rq->q->nr_requests;
> 
> Why += ? Shouldn't this be "=" ?
Hi Damien,

I think that the retry mechanism is also used to retry commands for 
which a unit attention was reported. Hence "+=" instead of "=".

Thanks,

Bart.
