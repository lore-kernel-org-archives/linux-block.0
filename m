Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513F0C28B2B
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 17:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354618AbiHSRgO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354644AbiHSRf5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 13:35:57 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901A712D291
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 09:54:31 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z13so2576457ilq.9
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=kEgxLxyt3h0x/jFdni4K5q92FtFQOvnZzYmn+u7N/G8=;
        b=ed4Vxs/J2lSYIjQ6e+iFFOv2jiv5rrxiasRfh/DQXvIF3Rq7gBUYR0lMA0AtOlpeiO
         ej4adI+H0qvjC1vBPIIkTr8GRsfB/gR6ChIURsp3LISxVcHvk9sI+TpTkPG1w9q6dp4H
         C272o+xGLTi/qyryp7ix4/nyGnwcAaF5nenVBYsG6vGnixC18WWQpJAk17nfYhaEzf9F
         VCvDPa7GQZ4b2dV+KyfL5NGyH4UcE02wPbMjKkHG0Z97+lGdWiTba2wRTqqIKJlaZDno
         dLlHb2N07fXKWIudhiIwhIOcsSERK+gmLishLV1e+MZ2gxjs8S1KpBJfbYzHbFfvNSit
         MgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kEgxLxyt3h0x/jFdni4K5q92FtFQOvnZzYmn+u7N/G8=;
        b=WDLQG2Qanl29KbfYpCGqvu8wmyQBo2w5chxLuT5kgmGj5XkJszPEovDr3Khv6RLzRI
         HTkLwMIQ6wy0EXN1Wzbc6EoXGmxm21zicjig1ihK9mt6urnLzgf3V+kv60Nn7yg0l9fL
         phueBDUchT34Z1JSr4oWAdkfi0cEZRcC36FLXC/Iu7l6yPoFA4ugp96miPmAi++25lj9
         VfBm7Vi7NF1nmouNVOhonUNr3vywCB7PKq6+cFxENhtwHlEPUPnNl7vN2SDW2tg0J05c
         RI+ycmKwkvGxA22vUDygDPlAXA9fDap9nxiQvBGcDI5nlXtafxp9GLtVQCaR5AJsc1Rm
         La3A==
X-Gm-Message-State: ACgBeo2rc4pDsyPb82KyJ+02u+XUBKa5RIIo7FjaqRXt2BC1eUXNXl7A
        CbDwgxexqT0UFZYo6BoGK+7qDw==
X-Google-Smtp-Source: AA6agR6AAbHutLHBBkygd/1S8feIR7jgrF8JBN0ZYgsXVxlMAT905cOHf+xTxFZsr/dTF0nbdFSv/g==
X-Received: by 2002:a92:ca47:0:b0:2de:a702:7a20 with SMTP id q7-20020a92ca47000000b002dea7027a20mr4225326ilo.307.1660928024804;
        Fri, 19 Aug 2022 09:53:44 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b11-20020a05663805ab00b00342a03e834esm1938410jar.3.2022.08.19.09.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 09:53:44 -0700 (PDT)
Message-ID: <36444e6a-c766-051c-011d-2e28b63ac714@kernel.dk>
Date:   Fri, 19 Aug 2022 10:53:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v7] block: sed-opal: Add ioctl to return device status
Content-Language: en-US
To:     Luca Boccassi <bluca@debian.org>, linux-block@vger.kernel.org
Cc:     Milan Broz <gmazyland@gmail.com>
References: <20220816140713.84893-1-luca.boccassi@gmail.com>
 <CAMw=ZnRSV3uF+HFjvL5Fdb_S_RB=3YrWT4ZqtG9e4ZmJTpehVQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAMw=ZnRSV3uF+HFjvL5Fdb_S_RB=3YrWT4ZqtG9e4ZmJTpehVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/22 4:45 AM, Luca Boccassi wrote:
> On Tue, 16 Aug 2022 at 15:07, <luca.boccassi@gmail.com> wrote:
>>
>> From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>
>>
>> Provide a mechanism to retrieve basic status information about
>> the device, including the "supported" flag indicating whether
>> SED-OPAL is supported. The information returned is from the various
>> feature descriptors received during the discovery0 step, and so
>> this ioctl does nothing more than perform the discovery0 step
>> and then save the information received. See "struct opal_status"
>> and OPAL_FL_* bits for the status information currently returned.
>>
>> This is necessary to be able to check whether a device is OPAL
>> enabled, set up, locked or unlocked from userspace programs
>> like systemd-cryptsetup and libcryptsetup. Right now we just
>> have to assume the user 'knows' or blindly attempt setup/lock/unlock
>> operations.
>>
>> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
>> Tested-by: Luca Boccassi <bluca@debian.org>
>> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
>> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
>> ---
>> v2: https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzchsMzrK%25dougmill@linux.vnet.ibm.com/
>> v3: resend on request, after rebasing and testing on my machine
>>     https://patchwork.kernel.org/project/linux-block/patch/20220125215248.6489-1-luca.boccassi@gmail.com/
>> v4: it's been more than 7 months and no alternative approach has appeared.
>>     we really need to be able to identify and query the status of a sed-opal
>>     device, so rebased and resending.
>> v5: as requested by reviewer, add __32 reserved to the UAPI ioctl struct to align to 64
>>     bits and to reserve space for future expansion
>> v6: as requested by reviewer, update commit message with use case
>> v7: as requested by reviewer, remove braces around single-line 'if'
>>     added received acked-by/reviewed-by tags
>>
>>  block/opal_proto.h            |  5 ++
>>  block/sed-opal.c              | 89 ++++++++++++++++++++++++++++++-----
>>  include/linux/sed-opal.h      |  1 +
>>  include/uapi/linux/sed-opal.h | 13 +++++
>>  4 files changed, 96 insertions(+), 12 deletions(-)
> 
> Hello Jens,
> 
> Is there anything else I can do for this patch? I've got two acks. We
> really need this interface in place to start working on supporting
> sed/opal in cryptsetup.

It's just bad timing, since we just left the merge window. I'll queue it
up when I open up the block bits for 6.1.

-- 
Jens Axboe
