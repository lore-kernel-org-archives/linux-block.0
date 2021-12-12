Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9CFC433F5
	for <linux-block@archiver.kernel.org>; Sun, 12 Dec 2021 19:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhLLTTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Dec 2021 14:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhLLTTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Dec 2021 14:19:52 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35386C061714
        for <linux-block@vger.kernel.org>; Sun, 12 Dec 2021 11:19:52 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z26so16234973iod.10
        for <linux-block@vger.kernel.org>; Sun, 12 Dec 2021 11:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3lZYxpFHoHqMrCneiYqxM2dzSIurnwCBe+TMroYiJck=;
        b=FBOecOtaMwOkhlDZ0/J2RlgSx2edE8HMAZwyEgihebjHlovFCXr5/KAvd7O9OPw0l0
         oOHgGZnzouRALI68Xas2MduS55uPE8j3hcXN04AD50aAx0fDMyvGD3l5V4eQ6hTxItzb
         pir4UzAIViHXY7iXSCeh2Eq/ZfANX0dHh6mF3AYt7msBYlyWunE+cuL3HB3qIPbgOBvJ
         EVgpOYjUkYhW1fPm29YsuM2wcEhnQlwbgpp1BYY53+tEjXcztsIAcaCvC2DT+aQpe+4t
         //R9qoZ4plzKwkyM9ksX62V4TLxHWne6Q+RkRBlK0vLaydXnpS8emzE723S1xju8Vnri
         SbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3lZYxpFHoHqMrCneiYqxM2dzSIurnwCBe+TMroYiJck=;
        b=Y4Kv6YCIzjPV5HrkYnZtjGaVGXG/5BArAIiWMIA69cnbatoVlv3fVMvDRpuh63AeAa
         utV+iG3PFv+9RU/xMfX5Swi4qCkPt3Mn+TSQz/ff+Ud9F+gDrstLagzJ7E0G8UTa1pmP
         E9BnGucaXjZKY/o4MelrzikcaFE50gDmSrf6QPFZM306sQW9qgBHaDkgx617mUJ5yLCM
         +44CnnYnI61Ca3Fu3iYyTRzyW6ViV4bnJ/dxTwfRxiUN9GvBKaAkXPS7OIjoW7Qi9ksS
         yB/hR+oxs0XEe66re0/fGXuEDuWBYwfbYCuKpeW7Is5l+vrWdW/YQBi6P4lpOpfzD0Hx
         sEnw==
X-Gm-Message-State: AOAM533A0LF1lSS1QZhxv0tTNoOBaFlCT8ji160zh5i74yocXLDRpzbv
        WgTgtLAv7AU5QG6tEVI3HsJgIeyoeqhf0Q==
X-Google-Smtp-Source: ABdhPJy8YauyTX8Vc2KXDIZeOSGmxTPw/AoCqg0BVxPbFoL9vjndnKCfeQRFl1tsYKRtdhtYNIQXNA==
X-Received: by 2002:a5d:9ec2:: with SMTP id a2mr31833716ioe.44.1639336791259;
        Sun, 12 Dec 2021 11:19:51 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 18sm5951719iln.83.2021.12.12.11.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 11:19:50 -0800 (PST)
Subject: Re: [PATCH] mtd_blkdevs: don't scan partitions for plain mtdblock
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20211206070409.2836165-1-hch@lst.de>
 <4bc1b80c-9c43-ccd6-de78-09f9a1627cc8@kernel.dk>
 <CAMuHMdU0q-W0YSLqjazK32VuE5ZH+eE8H1vbv74o014Dw7wSXg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <db998e18-6b2b-63b0-c00e-757778cecd89@kernel.dk>
Date:   Sun, 12 Dec 2021 12:19:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU0q-W0YSLqjazK32VuE5ZH+eE8H1vbv74o014Dw7wSXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/21 3:02 AM, Geert Uytterhoeven wrote:
> Hi Jens,
> 
> On Fri, Dec 10, 2021 at 7:52 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On Mon, Dec 6, 2021 at 12:04 AM Christoph Hellwig <hch@lst.de> wrote:
>>> mtdblock / mtdblock_ro set part_bits to 0 and thus nevever scanned
>>> partitions.  Restore that behavior by setting the GENHD_FL_NO_PART flag.
>>>
>>> Fixes: 1ebe2e5f9d68e94c ("block: remove GENHD_FL_EXT_DEVT")
>>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>>> @@ -355,9 +355,11 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>>>                                  "%s%c%c", tr->name,
>>>                                  'a' - 1 + new->devnum / 26,
>>>                                  'a' + new->devnum % 26);
>>> -       else
>>> +       } else {
>>>                 snprintf(gd->disk_name, sizeof(gd->disk_name),
>>>                          "%s%d", tr->name, new->devnum);
>>> +               gd->flags |= GENHD_FL_NO_PART;
>>> +       }
>>
>> Not sure why I didn't spot this until now, but:
>>
>> drivers/mtd/mtd_blkdevs.c: In function ‘add_mtd_blktrans_dev’:
>> drivers/mtd/mtd_blkdevs.c:362:30: error: ‘GENHD_FL_NO_PART’ undeclared (first use in this function); did you mean ‘GENHD_FL_NO_PART_SCAN’?
>>   362 |                 gd->flags |= GENHD_FL_NO_PART;
>>       |                              ^~~~~~~~~~~~~~~~
>>       |                              GENHD_FL_NO_PART_SCAN
>> drivers/mtd/mtd_blkdevs.c:362:30: note: each undeclared identifier is reported only once for each function it appears in
>>
>> Hmm?
>>
>> I'm going to revert this one for now, not sure how it could've been
>> tested in this form.
> 
> Because next-20211130 and later have commit 46e7eac647b34ed4 ("block:
> rename GENHD_FL_NO_PART_SCAN to GENHD_FL_NO_PART").

I guess that explains it, it ended up in the wrong branch...

-- 
Jens Axboe

