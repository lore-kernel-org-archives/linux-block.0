Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934B0C001B0
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 08:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjGEIxi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjGEIxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 04:53:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9D1E4F;
        Wed,  5 Jul 2023 01:53:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666ecf9a081so4857890b3a.2;
        Wed, 05 Jul 2023 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688547214; x=1691139214;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcMV/oDNc5jjXxYQqzEa+skV9Tw/l/5nny8oPwFyOoU=;
        b=ZPUj4Be3vPh+LjUuqnMuVjQJLBk8KqFoZdP1BInuvd3QmciSo0Q/iHQQVTzz8o+ulN
         oJ8gR2+6ef63DPFfNAtluSwLYJwWIKgzJLkYO7stql2j048XBG3z8dZZwTB+RIUz5SYQ
         Cd4hhLf/Wa7tL+EzVw3YPqRudLNobCm89nobyU8ulFv59/4M70C20uB4Lm7R0D3OdjlM
         /835zhTzkM5jTZsrClXrcEW16sQzs8Z+4qcGrM3sMLsG5mMotWrKB/UfnlrblN704/Yc
         n09a4DgKfct89TLPGH9sBlTbCE8zt11IP8byR28T17t5D+MXWBlQ08PWzsfyi4pxS+pQ
         W7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688547214; x=1691139214;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XcMV/oDNc5jjXxYQqzEa+skV9Tw/l/5nny8oPwFyOoU=;
        b=JkROf4apWu+AbcTYsD2mJRy9ln33hFNDUU0W0Egyl5lsumxMEYyBxQkNB4VL7ZOwTs
         qG53QPTbtuQ7HDzAi348t/1EVyPmsDhuFNbstxIuHTtX2hNxWk9Eb0iBXXvCCS9ZBLRY
         4C3Z1PXZm/fZlDFmWe9dsRl5b3/TZh+Pw62Y6TsvKmlZPeEnvEn5lI7L4OHZy9NL44Tv
         j22IjQ/q6CWU1MnjhEXsRlN2iF3qYU92316u7TMotPgISjykrIX8zotQTa5+cSp+seRp
         GEzILbkc1ZEKgSV0CI+jLzsxKWZGGOQubOHOXJZ+WDadSz1X4H/7F2gBP/RCpkcPQCnl
         oa1Q==
X-Gm-Message-State: ABy/qLZn/0yF8+T1XkaTgSbC9D2pA8Jr6HbS2O2VHZ43cMG6ncuV6Ib/
        WzsdHQ+su/P3eDgfjEwVeCkfwz6ne6M=
X-Google-Smtp-Source: APBJJlGjTR/jpkN373kxOqm0v2l30e+F1b6HxfvSMuiJYRCe9cvrUy2KzwB2CSUL4c4VHxPQT3LQIw==
X-Received: by 2002:a05:6a00:1704:b0:682:2fea:39f0 with SMTP id h4-20020a056a00170400b006822fea39f0mr19854662pfc.5.1688547214399;
        Wed, 05 Jul 2023 01:53:34 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79255000000b00682b2fbd20fsm1014830pfp.31.2023.07.05.01.53.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2023 01:53:34 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check
 patch
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com>
 <CAMuHMdUc-mqHC80euFrXLGGJO3gLW3ywu2aG4MDQi5ED=dWFeQ@mail.gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de, hch@lst.de,
        martin@lichtvoll.de, stable@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <06995206-5dc5-8008-ef06-c76389ef0dd8@gmail.com>
Date:   Wed, 5 Jul 2023 20:53:27 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUc-mqHC80euFrXLGGJO3gLW3ywu2aG4MDQi5ED=dWFeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

thanks for the review!

Am 05.07.2023 um 19:28 schrieb Geert Uytterhoeven:
> On Wed, Jul 5, 2023 at 1:38 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
>> fails the 'blk>0' test in the partition block loop if a
>> value of (signed int) -1 is used to mark the end of the
>> partition block list.
>>
>> This bug was introduced in patch 3 of my prior Amiga partition
>> support fixes series, and spotted by Christian Zigotzky when
>> testing the latest block updates.
>>
>> Explicitly cast 'blk' to signed int to allow use of -1 to
>> terminate the partition block linked list.
>>
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
>> Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
>
> Please drop this line.

Because it's redundant, as I've also used Link:?

Cheers,

	Michael


>
>> Cc: <stable@vger.kernel.org> # 5.2
>> Link: https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Reviewed-by: Martin Steigerwald <martin@lichtvoll.de>
>> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
