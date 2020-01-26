Return-Path: <SRS0=p+1D=3P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBBDC2D0DB
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 20:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9286F2070A
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 20:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjOZLwAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgAZU0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jan 2020 15:26:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35910 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAZU0M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jan 2020 15:26:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id g15so6545019otp.3;
        Sun, 26 Jan 2020 12:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHSNnUzcI55cuh2B6E1Lu8th6RkgDQpPE0JKT7s64CI=;
        b=SjOZLwAZbMj9UZ80mbvMlTbZWgu9VEXGCNXF73NNrKlC5pJe1dgwGwpVlbtQ6e4A0O
         +p58mKbvVkbe0ExlHVVEtj/Q7d5VEOqm9iGcs4OgI+cZ4vQ5MHhm+lxjjmYziQE9OCKz
         IH3nWVHgHNXgo0zbBELkCJiE4nZvTmcaxE7AXUgLHYdMJKOdb/CiIQlPMIb4prusBn7l
         hxM0qTUxRMj9nNHMn4q8CEH8/miT77FQhJq4UN2oWo70WwFe5ES3d7cn4TCGmqhHS8Dz
         PorEzOAai4kS/p7lLw6+Vhyul/SurMTMQqtDCEY4igUfaQufmyaLB3sEEiE15CjIQupl
         GwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHSNnUzcI55cuh2B6E1Lu8th6RkgDQpPE0JKT7s64CI=;
        b=hgCRdnOAlp84S0avw4wiDxZFRPmdrLuCrzx9/ZZW609puOX2jX94ZzlW1cLa/mKcw6
         KAPz7wTlaLgzLjPYjY56n2dQUoG+rgqxnhgEjiNhySU4wZ6BIHokwR+q9AbwXUIKyaXu
         SAeRgb9/v8s8zk4X9Tts1xHZc/PLQThTAeGKehgm+bs1hyNw7sQ76QmeD7qu0doTmcVv
         F71L2X0fIUiN7+Dp30pw1iWAWTub2MtI7FOHVmYss9Neu8FehQgCWMjCk3Q747mqASFA
         1cE4m5p8mVn8/PLlV6kbnK7kT4uGdcgDMGrMalNKUqw5i6fxeKRXVtPqvNh1n2+nIPrP
         isuA==
X-Gm-Message-State: APjAAAVNumIeKjotGa64Cf5eTJ4/JZWhuhf/VejAuKsniGu1ziJNWMQi
        XNzSqpUAHnS66Gs422DEJGRh04flgZzgw4LDKW23oJGk7b4=
X-Google-Smtp-Source: APXvYqzL0w+vJsuf+cfw4JDQOlgcTdka5oHPmUBhgIEIV/e0YTz6uRTvOpg8UGxF45TpYqTrdppwFZL3t/WrL6vIxvc=
X-Received: by 2002:a9d:da2:: with SMTP id 31mr9838115ots.319.1580070372012;
 Sun, 26 Jan 2020 12:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20200120222618.1456-1-xiyou.wangcong@gmail.com> <20200121190059.7ae9f7a9@gandalf.local.home>
In-Reply-To: <20200121190059.7ae9f7a9@gandalf.local.home>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun, 26 Jan 2020 12:26:00 -0800
Message-ID: <CAM_iQpU_Z6CFZh2hBQLneqy6=EFSZCUGET+vh+d78YDrOgTj+w@mail.gmail.com>
Subject: Re: [Patch v2] block: introduce block_rq_error tracepoint
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 21, 2020 at 4:01 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 20 Jan 2020 14:26:18 -0800
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > +/**
> > + * block_rq_error - block IO operation error reported by device driver
> > + * @rq: block operations request
> > + * @error: status code
> > + * @nr_bytes: number of completed bytes
> > + *
> > + * The block_rq_error tracepoint event indicates that some portion
> > + * of operation request has failed as reported by the device driver.
> > + */
> > +TRACE_EVENT(block_rq_error,
> > +
> > +     TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
> > +
> > +     TP_ARGS(rq, error, nr_bytes),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(  dev_t,        dev                     )
> > +             __dynamic_array( char,  name,   DISK_NAME_LEN   )
>
> Hmm, looks like I need to go and do a clean up of the kernel, and
> educate people on how to use dynamic arrays :-/

Yeah.

>
> The "len" field of a __dynamic_array() is to be a function to determine
> the length needed for each instance of an event. By having a constant
> there, it will be the same for every events, plus the meta data to hold
> the "dynamic" part of the array. This would be much better to simple
> use __array() instead.
>
> But as you use "__assign_str()" below, then it's expected that name is
> a nul terminated string. In which case, you want to define this as:
>
>                 __string( name, rq->rq_disk ? rq->rq_disk->disk_name : "?"  )

Ah, I wanted to use string() but all the existing users initialize/assign
them twice: once in TP_STRUCT__entry() and once in TP_fast_assign().


>
>
> > +             __field(  sector_t,     sector                  )
> > +             __field(  unsigned int, nr_sector               )
> > +             __field(  int,          error                   )
> > +             __array(  char,         rwbs,   RWBS_LEN        )
> > +             __dynamic_array( char,  cmd,    1               )
>
> Not sure what you are doing with cmd. It appears to be always hard
> coded as an empty string?

It is supposed to be a string of one-char commands. This is a
copy-n-paste from existing block_rq_requeue(). I don't know why
its length is 1, but yeah it looks wrong to me too.

Thanks!
