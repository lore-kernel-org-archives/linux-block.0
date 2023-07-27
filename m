Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC89DEB64DD
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 20:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjG0UUG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 16:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjG0UUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 16:20:05 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A848213F
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 13:20:04 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-68706b39c4cso463970b3a.2
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 13:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690489203; x=1691094003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/96a3zHkJjvv20RvXBqEv1QB41ltihCxTy9kgfLSNg=;
        b=AhxVULBZRAeBhVnIZAbpx81RruHLCjjhJ34oScBWU+95+LZVIuIum33Af+O92rCQWB
         sbZVweiVtU20UDggePIExDukXr8LcVp21FdyHRxTLR7Q/HaeksKvafqHchuMyTiHaA+4
         7VIG/ewaR7NIKana/XQE7+MZmQlkA91LMKB1PtGfLDYW1W+G1xb/AYT91LkpOzJgakWa
         1zO9ZTW/IEJK6B+iPJSgk+mkKcqCDjMGiXBnJdsecnFg2SeqwMz12OBWI3lqGTyFFFMz
         +4+V8eV8dM7aVMTREZeDSPbXUbeJ9O/jWpmtSMc/Tvy6Tj2b27/aJWRJLfaymnfPBK4p
         upuQ==
X-Gm-Message-State: ABy/qLb0xKacOzqpnFQGjKnIaUg8thX3g5inKbRKIoMOJMJt0pTMdSHt
        Uk3aFycYtW1t8eyU1dugteA=
X-Google-Smtp-Source: APBJJlEgw8lBDL7YXe9GttZE6fd6EUOOlj/5ds1/L0WRzyi7yhrLdbjbYB3nXSkJx1AVMDYokpYFxg==
X-Received: by 2002:a05:6a00:ad2:b0:682:4de1:adcc with SMTP id c18-20020a056a000ad200b006824de1adccmr212632pfl.12.1690489203518;
        Thu, 27 Jul 2023 13:20:03 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:607:27ba:91cb:68ee? ([2620:15c:211:201:607:27ba:91cb:68ee])
        by smtp.gmail.com with ESMTPSA id m3-20020aa78a03000000b00686e8b00a50sm162375pfa.104.2023.07.27.13.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 13:20:03 -0700 (PDT)
Message-ID: <d3193436-4e16-693d-f69a-f2d21cac11f3@acm.org>
Date:   Thu, 27 Jul 2023 13:20:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/7] block: Introduce the flag
 QUEUE_FLAG_NO_ZONE_WRITE_LOCK
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-2-bvanassche@acm.org>
 <65bb97ce-f0e4-8174-0d27-64a8543d4bbb@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <65bb97ce-f0e4-8174-0d27-64a8543d4bbb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/23 17:54, Chaitanya Kulkarni wrote:
> On 7/26/2023 12:34 PM, Bart Van Assche wrote:
>> +/*
>> + * Do not use the zone write lock for sequential writes for sequential write
>> + * required zones.
>> + */
> 
> In first go I got little confused with above comment, how about :-
> 
> /*
>    * When issuing sequential writes on zone type
>    * BLK_ZONE_TYPE_SEQWRITE_REQ, don't use zone write locking.
>    */
> 
> It makes it easier to search in code with BLK_ZONE_TYPE_SEQWRITE_REQ
> but if everyone else is okay with original comment or if it is not
> correct suggestion feel free to ignore my suggestion ...

How about this comment?

/*
  * Do not serialize sequential writes sent to a sequential write
  * required zone (BLK_ZONE_TYPE_SEQWRITE_REQ).
  */

Thanks,

Bart.

