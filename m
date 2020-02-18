Return-Path: <SRS0=AW5R=4G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B30EC34026
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D990D21D56
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsEV4pt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBRSlB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:41:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44307 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRSlB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Feb 2020 13:41:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so20483798otj.11;
        Tue, 18 Feb 2020 10:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZCiAlqDH3qOaiJgV5vGDQ5vRps2KrE4XKxEP2OQROw=;
        b=hsEV4pt5WaXrHLoH1HPuSHEWmmmafWmhhYLpdXlN9spNtEg8FNcn130X8yoxLL7ADk
         FqnA//uNhE//EssWuwC/JHz4UGQ9Xy+Ak1bvW5AMZQH7Hay8NvbprXa3HHUSnXSMAvq8
         qDtgxN6XeAd8dLkp24SFA6s0oCjyxTm/ocavaHwlcL1pR1gjhc1OqMIfzX0+8VXwqCz7
         ALg0nMKr6hXVv+AZIrE9u6F27pxb3FEYzWFB9q33qD1l8OMFG8cPb9CQxqXDQuiEXyPq
         LxmpQJlHqZIj5TgH+T+ZXVkwg4bTh7Fn8PYv+DLbJSIcPJu7i3IkY6oluvcJg1gHt2N3
         l/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZCiAlqDH3qOaiJgV5vGDQ5vRps2KrE4XKxEP2OQROw=;
        b=JrpaOU36tr+pHNqcGwjoJKeGoND0ZoGMHGGIxExZ3Wo7sWw61lpUB5QPxPIDeOXAo2
         /YpzyRAaeTvaofk95jTSS31GKgdL8Z/NVgKj5Qvb7ftKDGByKIRUhp/1gTmDcZs1xwMb
         q5K4TppKvvMrS+JQF7B5zR3sxdaky7IB5993amPuu2XFsF6tuGaD2GwX/jRctLc43bX6
         nXK5iDbFXFvIL1TcZybQ14tRgHKHJQauF4aL6pKFkxC1yxA1b9IdPEUVdr5BlB7YrhZI
         XfgXt+WTkCHSWNTJhJPRsCpbbT9zYGXFyPhfbNZDl0XBfG7z7UK26QQI1MwbLolBD/da
         FuAQ==
X-Gm-Message-State: APjAAAWeY+gC00ja4+LJWiYl0Mu1LxExJHbrraTfeE7w8EavmJBHX4x8
        Wm3piYhh1IARm3RGzTlBocrBIaSKrHWU+lzyYtSCPFwsfRk=
X-Google-Smtp-Source: APXvYqwILFYaM0G8aVXHHaVO6r1RT9OQuAWCnL94KV8KPjsDTVTLkXtMFU3biliEASl7JfiD9n7GzgyPviMCcX+zND0=
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr17734076oth.48.1582051259934;
 Tue, 18 Feb 2020 10:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 18 Feb 2020 10:40:48 -0800
Message-ID: <CAM_iQpVegeSSWDWZTt4+ZT6qE3-AwsyHj7DAkFiFu8+8Hy-5jA@mail.gmail.com>
Subject: Re: [Patch v3] block: introduce block_rq_error tracepoint
To:     linux-block@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Jens


On Sun, Feb 2, 2020 at 9:37 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> Currently, rasdaemon uses the existing tracepoint block_rq_complete
> and filters out non-error cases in order to capture block disk errors.
>
> But there are a few problems with this approach:
>
> 1. Even kernel trace filter could do the filtering work, there is
>    still some overhead after we enable this tracepoint.
>
> 2. The filter is merely based on errno, which does not align with kernel
>    logic to check the errors for print_req_error().
>
> 3. block_rq_complete only provides dev major and minor to identify
>    the block device, it is not convenient to use in user-space.
>
> So introduce a new tracepoint block_rq_error just for the error case
> and provides the device name for convenience too. With this patch,
> rasdaemon could switch to block_rq_error.
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Can you take this patch?

Thanks!
