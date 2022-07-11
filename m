Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A167CCA47B
	for <linux-block@archiver.kernel.org>; Mon, 11 Jul 2022 18:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiGKSYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jul 2022 14:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGKSYp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jul 2022 14:24:45 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD83F32D
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 11:24:44 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p128so5732740iof.1
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z5h98asAviTsgox7FrNAfOD5W+jbBJwdVEYAEoeHiOU=;
        b=uKF7ARNiK2yhXk78RqwF9dIBQUUgi/K++tRmFiHfMCl6ho5oxLfNu/XJSmdsnbs5Uc
         vs4p4uGROfJ83bVKzshZUi275Yht1gTiImT8NVM5cGdr1ZFjjAmC+DV3wJHPvqyfMHt1
         KfX87DGYsQafD3VUik3A1YlHBrFG6sAbnIncfzK4bem/g8nRJgKJtkW69SKmQDV9ah6f
         bqBZ2N5fwGFXLv/ernuxFTqNcCfcX5D7Ea9pkzWQM8T2DLuo/f+iNcsBiUyKrBI0GAqP
         RW9rgPBzCIomVbjvKtfJQgTvKwo9u6XKmVxUIwSAQO2htjtCpAX89YBCHzwA4sxnodnY
         u3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z5h98asAviTsgox7FrNAfOD5W+jbBJwdVEYAEoeHiOU=;
        b=UhkOlYdIoOs6sDvQrYXlaDZXiK/N0KzJaAB91H6IiS/KBzaecAW/lJXjnITJkYPYGd
         KZF0SuWJ/6n8hGcee1xIQTjKgfZJ7hr7QT94PbL/Mmlar0wA2LJpD04cI1G51thrEbQV
         YMcA8SBDuhxJ41v5CSOJn17j2/ukrhh6ktLJtT9u8d60dBoJ+z2qqJrRC3p17fyrcOK/
         rrqUt/Y5KPhETTtJdgPc/OJsV3Pz3eTDMM6byfE4OGmIfwIpZlHTWYDjN6BB8brceufV
         FQl7hqgX6Pjskq8YutCxgS5ENh8oYQpHYfx5RD+HHvdceynclPj32XrhSsuqtpYOTVrZ
         agIQ==
X-Gm-Message-State: AJIora9kiLD9SJQq90q4Ep0XMLG+wsk3Mdbqj00jcw4LLcBEi/oY0nbC
        KKYSLNS4gghkf6GZ7+gSKZMxTg==
X-Google-Smtp-Source: AGRyM1t+fqlUsfNSDzwk3ZkCWeIF6sarX69ZJp7fa7jQjkhx5B7+S4naLX97nZzjMJootHnA/lSzsw==
X-Received: by 2002:a05:6602:29d0:b0:669:1723:c249 with SMTP id z16-20020a05660229d000b006691723c249mr10314526ioq.208.1657563883999;
        Mon, 11 Jul 2022 11:24:43 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f1-20020a02a101000000b0033f3b201d1dsm3168416jag.21.2022.07.11.11.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 11:24:43 -0700 (PDT)
Message-ID: <7fb16d2a-21f4-3380-75f3-c8e8c08fd318@kernel.dk>
Date:   Mon, 11 Jul 2022 12:24:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>,
        Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de,
        kbusch@kernel.org
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, asml.silence@gmail.com,
        joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
 <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
 <43955a42-7185-2afc-9a55-80cc2de53bf9@grimberg.me>
 <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/22 12:22 PM, Sagi Grimberg wrote:
> 
>>>> Use the leftover space to carve 'next' field that enables linking of
>>>> io_uring_cmd structs. Also introduce a list head and few helpers.
>>>>
>>>> This is in preparation to support nvme-mulitpath, allowing multiple
>>>> uring passthrough commands to be queued.
>>>
>>> It's not clear to me why we need linking at that level?
>>
>> I think the attempt is to allow something like blk_steal_bios that
>> nvme leverages for io_uring_cmd(s).
> 
> I'll rephrase because now that I read it, I think my phrasing is
> confusing.
> 
> I think the attempt is to allow something like blk_steal_bios that
> nvme leverages, but for io_uring_cmd(s). Essentially allow io_uring_cmd
> to be linked in a requeue_list.

I see. I wonder if there's some other way we can accomplish that, so we
don't have to shrink the current space. io_kiocb already support
linking, so seems like that should be workable.

>> nvme failover steals all the bios from requests that fail (and should
>> failover) and puts them on a requeue list, and then schedules
>> a work that takes these bios one-by-one and submits them on a different
>> bottom namespace (see nvme_failover_req/nvme_requeue_work).
> 
> Maybe if io_kiocb could exposed to nvme, and it had some generic space
> that nvme could use, that would work as well...

It will be more exposed in 5.20, but passthrough is already using the
per-op allotted space in the io_kiocb. But as mentioned above, there's
already linking support between io_kiocbs, and that is likely what
should be used here too.

-- 
Jens Axboe

