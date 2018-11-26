Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69DEC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8171A20663
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8171A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electrozaur.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeK0EGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:06:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35729 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeK0EF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 23:05:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so19789999wrb.2;
        Mon, 26 Nov 2018 09:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=y1Lg62kLgfOVBE/BxVcLaf7hHFNj3EiFx0A43WgfNqA=;
        b=pdp10eP+lFBorErpwpKwCCBqytsaM3GD8EKEBU8R0LjPUoOZQ2gFQTtlh2298UICuo
         bBVKWES38tRhYPt+9BvBZL8bXpAm4ElbIOOVLT6m1bNu+S3KtTVZQ1EZjxTuaSefElHW
         SQpYnwQVaX/zFLxzd0pUpqTl328Lr/6l5wet3NLwk4U00ORTEWiLGJnbOAMzWadzMBE9
         irQCGDf8NV7AHUVElbO1r88LE1lYgahHH4BOKLz0YkDeTPapQBAZIsWYAIR0SJNEjbqB
         ZU5+LgzLn6obeo8xoB52h5gixXpvc2nMiuHd8d9Y+tlNZs+m4IKHI+adLM9Emp0qAPuq
         ADRA==
X-Gm-Message-State: AA+aEWZ6wwwHx63ebd9JS1FGFNhfx6NkOg+KkY3lhokW/LnvV4e740E2
        +o0JYg8paJE6xr6b85eNRSxvDdJF
X-Google-Smtp-Source: AFSGD/XQ/aPZJ5cMK4Woyqpz4HODklrbd2mCMqQOfAkuYTiFhUG7SqaMtLGj6IYh1znM33Qj399vBw==
X-Received: by 2002:a5d:4147:: with SMTP id c7mr24421761wrq.179.1543252273771;
        Mon, 26 Nov 2018 09:11:13 -0800 (PST)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id j199sm2375174wmf.13.2018.11.26.09.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:11:13 -0800 (PST)
Subject: Re: remove exofs, the T10 OSD code and block/scsi bidi support V3
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com
References: <20181111133211.13926-1-hch@lst.de>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <4f4b6aff-6726-c500-e3e4-f8b73d641851@electrozaur.com>
Date:   Mon, 26 Nov 2018 19:11:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181111133211.13926-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/18 15:32, Christoph Hellwig wrote:
> The only real user of the T10 OSD protocol, the pNFS object layout
> driver never went to the point of having shipping products, and we
> removed it 1.5 years ago.  Exofs is just a simple example without
> real life users.
> 

You have failed to say what is your motivation for this patchset? What
is it you are trying to fix/improve.

For the sake of "not used much" I fail to see the risk taking of
this removal.

> The code has been mostly unmaintained for years and is getting in the
> way of block / SCSI changes, so I think it's finally time to drop it.
> 
> Quote from Boaz:
> 
> "As I said then. It is used in Universities for studies and experiments.
> Every once in a while. I get an email with questions and reports.
> 
> But yes feel free to remove the all thing!!
> 
> I guess I can put it up on github. In a public tree.
> 
> Just that I will need to forward port it myself, til now you guys
> been doing this for me ;-)"
> 

Yes I wrote that for V1. But I wrote the *opposite* thing in a later mail.
Which nullifies this statement above. So please remove this quote in future
submits.

Here is what I wrote later as response of V2 of this set:

<Re: remove exofs and the T10 OSD code V2>

I think I'm changing my mind about this.

Because of two reasons:

One: I see 3 thousands bit-rots in the Kernel and particularly SCSI drivers
that are much older and fat-and-ugliness consuming then the clean osd
stack. For example the all ISA bus and ZONE_DMA stuff.

Two: I have offered many times, every time this came up. That if
anyone has a major (or even minor) change to the block and/or scsi layers
that he/she has done. And that now breaks the compilation/run time of
OSD or exofs.
  I'm personally willing to spend my weekends and fix it myself. Send me
  a URL of the tree with the work done, and I will send the patches needed
  to revitalize OSD/exofs as part of that change set.

I have never received any such requests to date.

So I would please like to protest on two of Christoph's statements above.

"The code has been mostly unmaintained for years and is getting in the
 way of block / SCSI changes"

1. What does "maintained" means? I have for all these years been immediately
   responsive to any inquiries and patches to the code in question.
   And am listed as MAINTAINER of this code.
2. I have regularly, for ever, every kernel release around the RC3-RC4
   time frame, compiled and ran my almost automatic setup and made sure
   the things still run as expected (No regressions).

So Yes the code has not seen any new fixtures for years. But it is regularly
tested and proven to work, on latest kernel. So it fails the definition 
of a "bit rot"

Christoph you've been saying for so long "getting in the way of block/SCSI
changes". And every time and again this time please tell me, you never answered
before. What are these changes you want to make? can I please help?

Send me any tree where exofs/osd compilation is broken and I will personally
fix it in "ONE WEEK" time.

(If compilation is fine but you know runtime will break, its nice to have an
 heads up, but if not my automatic system will detect it anyway)

Lets say that if in the FUTURE a change-set is submitted that breaks OSD/EXOFS
compilation, and I failed to respond with a fix within "ONE WEEK". Then
this goes in as part of that change-set. And not with the argument of
"Not used, not maintained" - But as "Breaks compilation of the following changes"
I promise I will gladly ACK it then.

So for now. A personal NACK from me on the grounds that. You never told me
why / what this is breaking.

Thanks
Boaz

</Re: remove exofs and the T10 OSD code V2>

> Now the last time this caused a bit of a stir, but still no actual users,
> not even for SG_IO passthrough commands.  So here we go again, this time
> including removing everything in the scsi and block layer supporting it,
> and thus shrinking struct request.
> 

Again. T10-OSD or not. Bidi is currently actively used. By Linus rules
You are not allowed to remove it.

Two use paths:
1. Management CDBS of private vendors yes via iscsi. virt_io and usb-scsi
2. Target mode support of WRITE-RETURN-XOR, and COMPARE_AND_WRITE

---
You guys should do what you feel best. Even not answering my questions and
of course not agreeing with my advise, .i.e about breaking people's setups.

But please remove the wrong quote from me. Please quote my objection
of the matter. (pretty please because you may surly ignore that request as
well)

[I am not fighting about this at all. Please do what you need to do.
 Just want to set the record strait that's all]

Cheers :-)
Boaz

