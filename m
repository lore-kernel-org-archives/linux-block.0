Return-Path: <SRS0=IQXF=WU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8A2C3A59E
	for <linux-block@archiver.kernel.org>; Sat, 24 Aug 2019 16:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4009B20870
	for <linux-block@archiver.kernel.org>; Sat, 24 Aug 2019 16:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfHXQED (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Aug 2019 12:04:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35326 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfHXQED (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Aug 2019 12:04:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn20so7470696plb.2
        for <linux-block@vger.kernel.org>; Sat, 24 Aug 2019 09:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1mbi2B08YUZNvoGZmgrphwrVXFpwV64yiYH/lq2ODnc=;
        b=M8+i7QkwRGsqbFaszHYTLfLXqkGEAMmk1nVcT2MRXQeXJ7bPqpNcx7DBgpoC8ZdiAu
         z5DD9VCBwxmn1VOMzqgQg4GCIWEQqhF0XJfronL+ZFzz3/ky7AGUQGp8edLdN8Fi6iDO
         Oh9hB7KIa3YOaT2LkNlKDd9wanDUDWDXXuYvDZ6trVraADEPaZNgust5NFHHgw47j2cG
         RBRFI8a2Ks3kHHwkmRICcc2I/moVWDoaDHPQziGB8HpLFKCdRG0nLUk19FuX5kGoMbMX
         z8Cz69XJXqXybo7vONkESLHdPkUK3pa57XmAGDlJ1sZCpWJXqz75D1WsufbA38+YwpID
         NuUg==
X-Gm-Message-State: APjAAAWBhs/VeGFlY03XK3cTKU39mBLT0He+twOH7mXZz8hVUCp4GGPp
        ydISPDUVxubFjNTMFEbcHHKvp42R
X-Google-Smtp-Source: APXvYqznFScT6zno+N2Zs+O3yk6+HhNLxVfAvJmeXBVM2mAA1FZfS2dAicoTtH7FRSt8IHCz1c4XtQ==
X-Received: by 2002:a17:902:bb0d:: with SMTP id l13mr10556090pls.176.1566662642427;
        Sat, 24 Aug 2019 09:04:02 -0700 (PDT)
Received: from asus.site ([2601:647:4000:1349:56c2:95e9:3c7:9c11])
        by smtp.gmail.com with ESMTPSA id b14sm5261153pga.20.2019.08.24.09.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2019 09:04:01 -0700 (PDT)
Subject: Re: [PATCH 0/5] block: loop: add file format subsystem and QCOW2 file
 format driver
To:     Manuel Bentele <manuel-bentele@web.de>,
        development@manuel-bentele.de, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20190823225619.15530-1-development@manuel-bentele.de>
 <da0a76ae-0627-24b8-1aa5-62463e8b3759@acm.org>
 <4cc02259-24c0-0858-5439-5b1b0649d4f2@web.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <48618bb6-45c5-34c7-2a9a-1a6ddf828e8c@acm.org>
Date:   Sat, 24 Aug 2019 09:04:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4cc02259-24c0-0858-5439-5b1b0649d4f2@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/19 2:14 AM, Manuel Bentele wrote:
> On 8/24/19 5:37 AM, Bart Van Assche wrote:
>> On 8/23/19 3:56 PM, development@manuel-bentele.de wrote:
>>> During the discussion, it turned out that the implementation as device
>>> mapper target is not applicable. The device mapper stacks different
>>> functionality such as compression or encryption on multiple block device
>>> layers whereas an implementation for the QCOW2 container format provides
>>> these functionalities on one block device layer.
>>
>> Is there a more detailed discussion available of this subject?
 >
> No, the only discussion is the referenced one [1]. But there was a
> similar discussion in the master's thesis of Francesc Zacarias Ribot
> [2]. Unfortunately, I found no attempt on the mailing list that proposes
> his solution.
> 
>> Are you familiar with the dm-crypt driver?
 >
> I don't know the specific implementation details, but I use this driver
> personally and I like it. Do you want to propose that only the storage
> aspect of the QCOW2 container format should be used and all other
> functionality inside the container should be provided by available
> device mapper targets?

(+Mike Snitzer)

Hmm, I haven't found any reference to the device mapper in the document 
written by Francesc. Maybe that means that I overlooked something?

I referred to the dm-crypt driver because I think that's an example that 
shows that QCOW2 file format support could be implemented using the 
device mapper framework.

Mike, do you perhaps want to comment on what the most appropriate way is 
to implement such functionality? The entire patch series is available at 
https://lore.kernel.org/linux-block/86279379-32ac-15e9-2f91-68ce9c94cfbf@manuel-bentele.de/T/#t.

Thanks,

Bart.
