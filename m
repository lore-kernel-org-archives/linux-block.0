Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996DBEB64DD
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 08:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGEIvD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjGEIvC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 04:51:02 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA841722;
        Wed,  5 Jul 2023 01:50:58 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a3c78ede4bso808024b6e.2;
        Wed, 05 Jul 2023 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688547057; x=1691139057;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjetYudzBDRm79CoZEFgauUDFcjdsQG1HEiGIKnkNc0=;
        b=i6C2yhZ0pF3S4zasSWenfcz2CBw8oHQivaBvNp4W74p0zANn30MONFJn6cNmDJpt8q
         mWAql0bS094GvjDUTlp+nxsqwdkUHuVueU/eimGL2TkkRF7Nn182JCKih1uSgu7Dhi+0
         45PAVKvxFhKhCtUq4GMKGyBg/mf3Lj7TI9rsz0HNm4B7IXLQc0oj8Gobtfa/nTfo7nL3
         WwsTJjJGYm/ubrabYHvyq5hplbjqa9eeQqIGlXGc9sfAddh9EN7V8ByKYMc4VkCXlajC
         Jore9r7B8L/Gg6GgORbSpJi10r1mmGne08rZ7PB+osf7JVx3+1Go8WTzhoYbwV0BGd18
         VTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688547057; x=1691139057;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wjetYudzBDRm79CoZEFgauUDFcjdsQG1HEiGIKnkNc0=;
        b=Ir0BMsefMZp1EfN3cxVo4NUoq9AFYCx+qLJE+Y5pDlbalNOJ+oitEfGu+6Rv2CuZk/
         DVcCg6EctycLbsB7flP/+8KfcOz/5ajAieFO8KJtKZ0tR8/BPpYUOEfemvDgaF5gIBHi
         EsbZMcVuVaL7N3XnfeHJoVvApq5Jrpeh4i3eGDkxPPHJOKAbNP+jarUncrzQunw2Ky5V
         lIou9rfwREezfhsKhozCjRDILNGkS9ZzRsr+h6K2H2SpyE1aS92cw/I66cHdoARGe6D9
         i26hfMxgYJPLmbGDVrPHMMTWDCHwj90Fjrmt8/scw0XABzEwbRIn8W6vXdvG+Xx7CkpY
         oUFQ==
X-Gm-Message-State: AC+VfDyJmPullam/F6u0zO4OT69b6G4VchY6P0eN6HqPcNUZvb0ejX/7
        r4oM2Th1i5nusI4WAKkxsQ7dwftyhng=
X-Google-Smtp-Source: ACHHUZ5jGof96+7NEVY63a3PdEYzNFMohoQ02d1TKKVe5Mt9qyypeD525412U6gBWe4PB43mqFlq+Q==
X-Received: by 2002:aca:2b02:0:b0:3a1:dc0d:f337 with SMTP id i2-20020aca2b02000000b003a1dc0df337mr11475349oik.45.1688547057241;
        Wed, 05 Jul 2023 01:50:57 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id j24-20020a63cf18000000b0054ff075fb31sm17590234pgg.42.2023.07.05.01.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2023 01:50:56 -0700 (PDT)
Subject: Re: [PATCH v3] block: bugfix for Amiga partition overflow check patch
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230704054955.16906-1-schmitzmic@gmail.com>
 <CAMuHMdUY6T7Q+fusJtHQxYTnKAvsdOJvFL_ZS-bkJTV32Y2yCw@mail.gmail.com>
 <69cf5397-1a99-8cc5-ed48-d354f0ad05df@gmail.com>
 <CAMuHMdVD9r2XjPYU9WJXYoSO5LriCoYy+TOp4ddru3WbX803Tg@mail.gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de, hch@lst.de,
        martin@lichtvoll.de, stable@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <07830f19-5275-2108-adf0-b5c1c1d2b5f6@gmail.com>
Date:   Wed, 5 Jul 2023 20:50:47 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVD9r2XjPYU9WJXYoSO5LriCoYy+TOp4ddru3WbX803Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

Am 05.07.2023 um 19:24 schrieb Geert Uytterhoeven:
>>> We do not really have a way to record comments in git history
>>> after the fact.  The best you can do is to reply to the email thread
>>> where the patch was submitted.  When people follow the Link:
>>> tag to the lore archive in the original commit, they can read any follow-ups.
>>
>> Does lore pick up related patches through the In-Reply-To header? In
>> that case it would be easiest for me to to put this comment in a cover
>> letter to the bugfix patch.
>
> Lore does not do that (b4 (the tool to download patch series from lore)
> usually can link a series to its previous version, though).
> New replies sent to a patch submission do end up in the right thread,
> so any later comments (bug reports, Reviewed/Tested-by tags, ...)
> can be found easily by following the Link: tag in the commit.

OK, that's good enough for me.

>>>> Partitions that did overflow the disk size (due to 32 bit int
>>>> overflow) were not skipped but truncated to the end of the
>>>> disk. Users who missed the warning message during boot would
>>> I am confused.  So before, the partition size as seen by Linux after
>>> the truncation, was correct?
>>
>> No, it was incorrect (though valid).
>>
>> On a 2 TB disk, a partition of 1.3 TB at the end of the disk (but not
>> extending to the very end!) would trigger a overflow in the size
>> calculation:
>>
>> sda: p4 size 18446744071956107760 extends beyond EOD,
>
> Oh, so they were not "truncated to the end of the disk"?

Not by the RDB parser, but truncation happens ultimately. I should have 
copied the second instance of that message from Christian's log:

sda: p4 size 18446744071956107760 extends beyond EOD, truncated

The core partition code later sanity checks the partition data and 
truncates (see block/partitions/core.c:blk_add_partition())

Cheers,

	Michael
