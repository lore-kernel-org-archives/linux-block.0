Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D518EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 18:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGTSTE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGTSTD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 14:19:03 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBDA135
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 11:19:02 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3465bd756afso5788955ab.3
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 11:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877141; x=1690481941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZGav5W1juXnv3EG46iWpR48CtLcE4/moZR3p7qd9rI=;
        b=jMTweRfjbKCiokwvPDUPhKHIm4hRWwyyhfQOrBwDgceAm7R2U0zxAsb3r7ruFBya0N
         /suGOsA7MCAsHVs2H+g4Fo/+/h2cBfrdA6F4/bJgUdlbZAe7smtCt3IJNkcMoOZD9+rv
         f6EqyR7PBYIyAHGUKTw5B3IyfptnCV0KsZD8kSpGfG9+wIO9RJy6goElt8ZIU9XqbYMJ
         4+84YZ+xc+xpA+mD5PyLvy2zwl7qq4ZxWWykiYeTQqHoxR/NqQcUlJmW8HkrFdDihwuC
         /yf+E/tCdJYysap3oVrT3oQmUdR5NPIUnnxK3oJHPxtkDEPhUQvpN2pbgbfwmzc4IkmB
         wGSw==
X-Gm-Message-State: ABy/qLbQUmXcXokd0MGF/iJ4om8SNCWibJC1h/0Rdf/+tfYYfdvkBv56
        EGf0fBsQeHLY1E5TfumHy0c=
X-Google-Smtp-Source: APBJJlGHLv17nD5YHzKTrOSShtmmACpEzV2hLqizTOIrSaU40Au/S/7tIoLVkIzabI5sezXCScVKkQ==
X-Received: by 2002:a92:d483:0:b0:345:a3c6:87ba with SMTP id p3-20020a92d483000000b00345a3c687bamr6368271ilg.22.1689877141361;
        Thu, 20 Jul 2023 11:19:01 -0700 (PDT)
Received: from ?IPV6:2620:0:1000:2514:2b58:b717:21d3:3537? ([2620:0:1000:2514:2b58:b717:21d3:3537])
        by smtp.gmail.com with ESMTPSA id c1-20020a63a401000000b0055c3e8c922dsm1503240pgf.90.2023.07.20.11.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 11:19:00 -0700 (PDT)
Message-ID: <075b8a01-d219-89d1-bb38-c5868fafaa1d@acm.org>
Date:   Thu, 20 Jul 2023 11:18:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230710180210.1582299-1-bvanassche@acm.org>
 <20230710180210.1582299-5-bvanassche@acm.org>
 <52d41b27-f429-fc4c-c522-a963f67114bd@kernel.org>
 <fb8b1b7e-4054-6598-8204-eb252395227d@acm.org>
 <fd64fa90-1227-6d4d-8f0b-fc67d8c42a7e@kernel.org>
 <42402057-3806-3930-5ff8-d68816c79ca5@acm.org>
 <c4498ce0-d04d-c8d0-800e-d856d8ed8a8c@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c4498ce0-d04d-c8d0-800e-d856d8ed8a8c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/19/23 16:07, Damien Le Moal wrote:
> Not really. I was not thinking about passthrough requests but rather write
> syscalls to /dev/sdX by applications. sd_setup_read_write_cmnd() is used for
> these too. After all, /dev/sdX *is* a file system too, albeit the simplest possible.

How about introducing a new request flag (REQ_*) such that f2fs can disable
zone locking while it remains enabled for all other users (BTRFS and direct
I/O)?

Thanks,

Bart.

