Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8BAC2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C30D21D7D
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 19:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rubrik.com header.i=@rubrik.com header.b="bLchwNI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAWTqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:46:10 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42318 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgAWTqK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 14:46:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so4549186edv.9
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2020 11:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vD4wEhXBPUbSTT+g/nmEXsPL8ISOhsNfJaDqZ0hs+YQ=;
        b=bLchwNI2hZ90oj87WDQHEWwcXbnaTozTTTSL+EHv4m4KWnaQBJC68uKXoeoHCn9cEM
         FS4HRPgQnjqDR+BLGBCzx19JUg5AdpIHwTVmWp0ZxXLbwVYKqckWsSyxERDTdWsJeAMI
         vpwgq536nzUzw0uS0x3oSazB98GWRNLDcDBt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vD4wEhXBPUbSTT+g/nmEXsPL8ISOhsNfJaDqZ0hs+YQ=;
        b=PzD8xRECS9Efj/avrXkeYnqFNZmj8gCPIWsjWOhO4L55mCTOIR6Ferc7+gbOn86vPk
         /GzkThaf4vkWWnG33KkvbwmDSfk0AzBhW/SgR9fgunxE5rGDZcBuiDR2xf9JdJ+2oQUp
         crwWIVljgqtKh66Z9PpoooudZgQADTyeRCInM8WFy4euNyA9srrY/5tDw+o2TDw35sHt
         DcRyd7NIBCWa2GvmubuUJTVQyReRhbHZg3/GmfGr65LyWC584+Je7ojv//zW+9lP2h/U
         GUIhWVBypMulrhKGf6C0UniSs/iBWjBgecpp9glKglUN8Ckt4mr1nhacreTUMYHRW7MQ
         oFXg==
X-Gm-Message-State: APjAAAVj6NROOzc9zhuRKArDvxBe0FAxjXnYJKEocTiTyLGsc5waqMsu
        8HKu8lc5sOXvZacQYhCj8dsztgyVAfraUYoggYiM
X-Google-Smtp-Source: APXvYqzWw8F5PEnW714sZWnLdv5/+LN/StHB/Ork5l+D4wkqEF5lPPTYcEoVKVfZ38fE6eP1/JMi2g7pplXkCAQBkYM=
X-Received: by 2002:a50:bf4b:: with SMTP id g11mr8184916edk.373.1579808768074;
 Thu, 23 Jan 2020 11:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20200121192540.51642-1-muraliraja.muniraju@rubrik.com>
 <88d16046-f9aa-d5e8-1b1c-7c3ff9516290@kernel.dk> <CAByjrT9=pZGOwDFnJQ60aG-EznV2QK+DQT3a1NEDJr3RU0K_Gw@mail.gmail.com>
 <3c2833ef-5d7f-32ae-bbb0-01d6f812a34b@kernel.dk>
In-Reply-To: <3c2833ef-5d7f-32ae-bbb0-01d6f812a34b@kernel.dk>
From:   Muraliraja Muniraju <muraliraja.muniraju@rubrik.com>
Date:   Thu, 23 Jan 2020 11:45:57 -0800
Message-ID: <CAByjrT8xiL0BLo1MoidZ5O9ooWZnQdd9TQMgcfUFPxaLOMAFhQ@mail.gmail.com>
Subject: Re: [PATCH] Adding multiple workers to the loop device.
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 23, 2020 at 11:29 AM Jens Axboe <axboe@kernel.dk> wrote:
>
>
> Please don't top post, we just lost all context here unless I had fixed
> it up for you.
>
>
> On 1/23/20 12:25 PM, Muraliraja Muniraju wrote:
> >
> > On Thu, Jan 23, 2020 at 10:59 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 1/21/20 12:25 PM, muraliraja.muniraju wrote:
> >>> Current loop device implementation has a single kthread worker and
> >>> drains one request at a time to completion. If the underneath device is
> >>> slow then this reduces the concurrency significantly. To help in these
> >>> cases, adding multiple loop workers increases the concurrency. Also to
> >>> retain the old behaviour the default number of loop workers is 1 and can
> >>> be tuned via the ioctl.
> >>
> >> Have you considered using blk-mq for this? Right now loop just does
> >> some basic checks and then queues for a thread. If you bump nr_hw_queues
> >> up (provide a parameter for that) and set BLK_MQ_F_BLOCKING in the
> >> tag flags, then that might be a more viable approach for handling this.
> >
> > I see that the kernel is already is using the multi queues with the
> > number of hardware queues is 1. But the problem IMO is that the worker
> > seems to be processing 1 request at a time, to parallelize requests
> > and have more concurrency more workers needs to be added. I also tried
> > increasing the nr_hw_queues without increasing the number of workers,
> > I did not see any difference in performance and it stayed the same. It
> > allows to queue more requests but it is processed one at a time. I
> > have not tried with enabling BLK_MQ_F_BLOCKING though. I see that it
> > can schedule requests early.
>
> The experiment is useless without BLK_MQ_F_BLOCKING set, so you need
> that at least. With that, you _will_ see work items processed in
> parallel, depending on where they are queued from.
>
> --
> Jens Axboe
>
Sure, let me try setting the BLK_MQ_F_BLOCKING on the existing patch
that I sent and see. Will update soon, Thanks.
