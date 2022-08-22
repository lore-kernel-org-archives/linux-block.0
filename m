Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E56C3F6B0
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 05:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiHVFqZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 01:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHVFqY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 01:46:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C1B25C50;
        Sun, 21 Aug 2022 22:46:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so8488276pgb.4;
        Sun, 21 Aug 2022 22:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc;
        bh=EZ6zyXMtSXkd7oqpzJx7bOLc4ED/KqdW+vVISMpRooU=;
        b=W2ekLYjeaC0AdOY7oVmHoxhJC5RKuDplSYkW5fn2y34vBbnPp+2y0L41sCxpWz+D9F
         dr4iH+cL4uJhZsfqcXGjCigxWxbOsn8QHPVX+9RVV6pUZEYqKgjt+YcZ0swZLb8YtoTl
         s4rtGtwql7BvrevisvKwi9CRmosTY06ndLZlqv0EI6dgi83MNPNc181vqDX7qkNDOr00
         tF4naQTIHFTlscEvvQUXnxIzPQcOihwqq3Ua2U7q3T6nt2YCN+acGIrdbk6mMMtw7bqc
         tYo+jn5gAiRPXHRvHg1MimKOwfTH60W8KorHVop+eTVwkO7N1sDGKfp+IN5PyC2sET5O
         bWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc;
        bh=EZ6zyXMtSXkd7oqpzJx7bOLc4ED/KqdW+vVISMpRooU=;
        b=IeZdfd45KSd2aLgqb7jN3J66gImlsrwnbirN+H2TjXNMANZptrgP6sKbQv8at7GVof
         qloAFWc5ehlb/LvtHTve3bREQ/7g+9S5utBHqekFbah2E/m92A5sbDzTBDPgIKQMNhBD
         d5MtoP/x7KT3db+kinB+D4aBdYtQK6PFJ0PIW+2ZX4i3UEbRgNvs8ykRa61uJ2RB3oZD
         mbH6ci1hbLztbbThbme3Nk9vLJxE3kFvWMoPw8pvx56cOlUiapLl+X0orHb7KfSEgHcn
         C5YCiAfTuT5MsegUSjt22wNIS94HK5LmvFhDfmusSIdLMvaox00kGOEo5wW8AD67G8KU
         UQnQ==
X-Gm-Message-State: ACgBeo2oojpERSgJG2UEtJ278byAoGlzfrdOW1E2c5DsK6zqK6qYwp0k
        x/wzyUF/VSMdGEkk3mnxdBFEjxjCcHM=
X-Google-Smtp-Source: AA6agR5CYnv3UjvCi7MnOQVLN5mLgu5J9hAjA6pupzSmcla0rvp2Gv7i5mFAfP+KlZAc11datac01Q==
X-Received: by 2002:a65:6e49:0:b0:429:cae6:aac6 with SMTP id be9-20020a656e49000000b00429cae6aac6mr15398243pgb.268.1661147183217;
        Sun, 21 Aug 2022 22:46:23 -0700 (PDT)
Received: from [10.1.1.24] (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id z14-20020a170902d54e00b00172e6c66f84sm1797148plf.148.2022.08.21.22.46.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Aug 2022 22:46:22 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
To:     Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <71d9f2fe-42d1-2a09-a860-702b42a3a733@kernel.dk>
 <0bf2e4f9-a1c1-3847-a2b5-d9b9eaaa783a@gmail.com>
 <2669426.mvXUDI8C0e@lichtvoll.de>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6fa2c159-e7c7-2d2c-04b5-54c2b2c9a24e@gmail.com>
Date:   Mon, 22 Aug 2022 17:46:17 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <2669426.mvXUDI8C0e@lichtvoll.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Martin,

Am 22.08.2022 um 08:59 schrieb Martin Steigerwald:
> Michael Schmitz - 26.07.22, 05:58:40 CEST:
>> Am 26.07.2022 um 15:40 schrieb Jens Axboe:
>>> On 7/25/22 7:53 PM, Michael Schmitz wrote:
>>>> Hi Jens,
>>>>
>>>> there's been quite a bit of review on this patch series back in the
>>>> day (most of that would have been on linux-m68k IIRC; see Geert's
>>>> Reviewed-By tag), and I addressed the issues raised but as you say,
>>>> it did never get merged.
>>>>
>>>> I've found a copy of the linux-block repo that has these patches,
>>>> will see if I can get them updated to apply to current
>>>> linux-block.>
>>> Thanks, please do resend them and we can get them applied.
>>
>> Will do - running final compile tests.
>
> Just reminding. Did this go in meanwhile?

Not yet, at last count.

Christoph had reviewed v8 and I've addressed his comments in v9. Should 
have added his Reviewed-by tag for both patches perhaps, not just patch 1.

Shall I resend v9 with that omission rectified, Jens?

Cheers,

	Michael

>
> Thanks,
>
