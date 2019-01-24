Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300ABC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2C821872
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMVjnyRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfAXSYn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:24:43 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38272 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAXSYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 13:24:43 -0500
Received: by mail-qk1-f195.google.com with SMTP id m17so3871654qki.5
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/MAzoMkblArd54RvGu7NqDW+AgBC1SWBZBxsAm5YiY=;
        b=AMVjnyRMLesG86Ov325v5kwvlE9dLwAAEYppk0It0cT4/Xr95G1quWVzAA9bYY2RY3
         fjXJGp2KV+66SHpsXvPbslA7DC0fvit44XUGl6AtdmZwqL7zQO4vfYP7qO4U9CRELfTW
         z3vMYFJLPnXgvQO0AlnWRmAxN0iyBK1Oj8QfrzYUWgiQNxtBXp1PtTwTGU9bBSsR7muT
         oMJShtE1lghA22K2iBCC6Rwy3IwQSQJMRTiSkS/h5HD/fbqHlocwKamMPHNa3r3V+/CF
         ySN5XqF2DCun2dTZ8Jbdecg9W7fkt3t439eY8jV22lMsZXD9KhqGjUId9cGN5S8EyYQi
         xMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/MAzoMkblArd54RvGu7NqDW+AgBC1SWBZBxsAm5YiY=;
        b=XQ3s9+NOAeftTo7RKfpJliPxmvQ6X13WtwRs7rFo1mXvZ+srNZcLK5GQzbnUzxmaqq
         1IExNln34wMwfN5vfJqkt6fPS+U9n5/iatMeiSEAEDFId7HTitWD8VVGwHMeveYndzdu
         ++ggxKIqykwh4a4QHm8VcZ6poimSwG1eNFVWIeSBBPku8NBKcD4cTXKMisn85WNPhl3k
         ENLVRTZYvT72hwaLn+3OV6XD/neJjt6pmrtopmgs/3itHhbawVQM2Xkk0lyBKZ07MloU
         moOvE99fRjIwND34o8IZdeZXUj1rl9yzo/CH32qTuuoJaWYUfbDOouoaluW8hzz1MtnR
         nDuA==
X-Gm-Message-State: AJcUukeA4CswFRHtky5spygJ8TMM+K4UwELuU8qN2ilRKL/W7KtiLJ+z
        RAcs3EUhx03IITxe3YK+Hsh+Ymdms04pdx7nj2MYXL9WHUQ=
X-Google-Smtp-Source: ALg8bN5eq9PcyMhBKWHHqiKKi0ROiNpRPLXzhYr5pqGDuwNaC3AgSGFT4zlAo4vAQdACKfUk8zxFr53eUgsT7v9tRRM=
X-Received: by 2002:a37:b785:: with SMTP id h127mr6686763qkf.294.1548354282196;
 Thu, 24 Jan 2019 10:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20190124001655.92508-1-bo.liu@linux.alibaba.com> <d2ccb98d-2880-5ba0-8871-f92f1a6f60c8@kernel.dk>
In-Reply-To: <d2ccb98d-2880-5ba0-8871-f92f1a6f60c8@kernel.dk>
From:   Liu Bo <obuil.liubo@gmail.com>
Date:   Thu, 24 Jan 2019 10:24:31 -0800
Message-ID: <CANQeFDD91q17xEkuyeXUr7Pf7rhUyniVq4OvDnvGy4+XA4vocQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] iolatency bug fix
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 24, 2019 at 10:11 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/23/19 5:16 PM, Liu Bo wrote:
> > This set is to fix a hang case if blk-iolatency is in use.
> >
> > The 1st patch adds a warning for unexpected inflight counter.
> > The 2nd patch explains the hang problem with more details.
> > The 3nd patch is a cleanup of blk_mq_freeze_queue.
>
> This is much better. You'll want to reorder 1 and 2 though, it's a known
> issue that we can hit the underflow condition before you fix the issue.
>

Oh sure, I'll send a v2.

thanks,
liubo
