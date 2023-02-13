Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6AFC636D4
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 20:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBMUEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 15:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjBMUEs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 15:04:48 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544562726
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 12:04:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s11so6831735edd.10
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 12:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3VQLY//5P39OuXGOEpzf1Glp5VE7sIcldzWZWkHVBtk=;
        b=TsAcvf6Rib9TA7nd5ff4vkYnkiTo2vkqF7CbonXHIwalzDwl0C+xPzUQngvguvBhYW
         lfrD3pWDukUSl79bN71gu/WciycmYWabbXLrlXuPTtajVxjnp+EjdrsnaaWimERVUikg
         BZJmYQInM/dGBkTYdpAbao9PfJ1lR4MxklY+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VQLY//5P39OuXGOEpzf1Glp5VE7sIcldzWZWkHVBtk=;
        b=Y0j/BtFD9obG/zL8W8IsLnukwKz9a4KZsoIYnEdYdlQ05wr94DjOq0MUZlRVDprJWE
         mOV/0FS7v5V42U4moh9E4mQJ2kNGDPQMf/EJNeh2GpcQIYw5ZWnYtSMZ6m5AwKVjYsyW
         Thc3w/XGez3ybNBlLjVkif9zKQ0o8uDxHmxOJJShmFcBYxqXWOdSGMvT0VJxGV8O9QoB
         r4YioQ83wT2zydLXXZfkG/QwrlVFabOnwYsc31RSFU5MEP9/FesHDxdRRtd3XiMB5YSp
         JFXashWs58lZi9lEQz09rvbhJgvzhtgVz44j/KwOE7ClJZk+RTDuWEvwK7sVRvQTJQ6G
         yygw==
X-Gm-Message-State: AO0yUKX4/7tvjwb0kQkhAp0ZHCMXejH18h7qYkskeh0SRjdXDDMxdL+S
        37LjlbUCe1zqfhSv3ziZy7IM5VcLGhX4wMMeVBY=
X-Google-Smtp-Source: AK7set/v9cTI1iF06qxnD/RVlSRKCEwb6H/pvmI9stZjnpXg6j4hTxtNCrEZWpmZYrGLiDXDfs9YJg==
X-Received: by 2002:a50:998b:0:b0:4a2:5652:d8ba with SMTP id m11-20020a50998b000000b004a25652d8bamr7974744edb.18.1676318685474;
        Mon, 13 Feb 2023 12:04:45 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id ee55-20020a056402293700b004acbde59e64sm3479261edb.8.2023.02.13.12.04.44
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 12:04:44 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id jg8so34712651ejc.6
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 12:04:44 -0800 (PST)
X-Received: by 2002:a17:907:366:b0:88d:ba79:4310 with SMTP id
 rs6-20020a170907036600b0088dba794310mr5996890ejb.0.1676318684223; Mon, 13 Feb
 2023 12:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20230210153212.733006-1-ming.lei@redhat.com> <20230210153212.733006-2-ming.lei@redhat.com>
 <Y+e3b+Myg/30hlYk@T590> <CAHk-=wgTzLjvhzx-XGkgEQmXH6t=8OTFdQyhDgafGdC2n5gOfg@mail.gmail.com>
 <Y+hDQ1vL6AMFri1E@T590>
In-Reply-To: <Y+hDQ1vL6AMFri1E@T590>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Feb 2023 12:04:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJsi7t7YYpuo6ewXGnHz2nmj67iWR6KPGoz5TBu34mWQ@mail.gmail.com>
Message-ID: <CAHk-=wgJsi7t7YYpuo6ewXGnHz2nmj67iWR6KPGoz5TBu34mWQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs/splice: enhance direct pipe & splice for moving
 pages in kernel
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 11, 2023 at 5:39 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> >
> >  (a) what's the point of MAY_READ? A non-readable page sounds insane
> > and wrong. All sinks expect to be able to read.
>
> For example, it is one page which needs sink end to fill data, so
> we needn't to zero it in source end every time, just for avoiding
> leak kernel data if (unexpected)sink end simply tried to read from
> the spliced page instead of writing data to page.

I still don't understand.

A sink *reads* the data. It doesn't write the data.

There's no point trying to deal with "if unexpectedly doing crazy
things". If a sink writes the data, the sinkm is so unbelievably buggy
that it's not even funny.

And having two flags that you then say "have to be used together" is pointless.

It's not two different flags if you can't use them separately!

So I think your explanations are anything *but* explaining what you
want. They are just strange and not sensible.

Please explain to me in small words and simple sentences what it is
you want. And no, if the explanation is "the sink wants to write to
the buffer", then that's not an explanation, it's just insanity.

We *used* to have the concept of "gifting" the buffer explicitly to
the sink, so that the sink could - instead of reading from it - decide
to just use the whole buffer as-is long term. The idea was that tthe
buffer woudl literally be moved from the source to the destination,
ownership and all.

But if that's what you want, then it's not about "sink writes". It's
literally about the splice() wanting to move not just the data, but
the whole ownership of the buffer.

Anyway, I will NAK this as long as the explanations for what the
semantics are and what you want to do don't make sense. Right now they
don't.

              Linus
