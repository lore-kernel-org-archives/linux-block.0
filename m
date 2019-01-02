Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AFEC43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6644218D3
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PiilPSfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfABSMA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:12:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43116 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfABSL7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 13:11:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so21536358lff.10
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 10:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vq29XcOxZ5hwZ75YkqzokQLTaZqs3E3DcbhwYiMbSnc=;
        b=PiilPSfaUG+Jk9fi/Ou5t01HLbYx31BYld/3rdIcHl06PWrEhdnr4iS0fACYqgWXk6
         A/634LjxrmBuCOiJYsmtBdU8GQg1CGNdFPYb+6fUJsZeskCsJPZ5z/pWhIe520khNmzQ
         rjirt1TezWTMc/N74VQCzhJW5C12oawTZp9xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vq29XcOxZ5hwZ75YkqzokQLTaZqs3E3DcbhwYiMbSnc=;
        b=Rg/ItDl55m1hSkE0koMqGH/x+RqQZTk7USP96sYtTR7XDcGemqoQ8ELBnBBAnYEZ8n
         LoVmCRw91QVfBffGahj6eda3a9c9WoRw6tx7RPdEAAjzyh+BcTZimm6WDO59BJjLZGjh
         FpysyygtIh9J7gCFxj60NFOsYP7g24nE+BYBTRRdBhaixJEjnewc+O1Rz5eRHfdUhxnb
         k+C+IT8Yn2SWxt6K+dZVkKMBuL8MZ9cgGMqJlGzHgYJW4sGOYwV8+8WTt8YlZpVaaiIB
         ootGIeLFq5oi2Kd1OqEJzzSbcoFuZb0hwllU49kF241tsVaugLRYFNoy9hmk50Q8l6Mt
         Tvzg==
X-Gm-Message-State: AA+aEWaShCaU3TfDlBK6BrYKbOirLxUWGc9MExdLLmVvVDtkH2ojrZI7
        Mc43wQEEdbDwGtium4YrXfDCJ8LlraE=
X-Google-Smtp-Source: AFSGD/XvXMSa7bgYL0PD3YwOk2jlqp6PtFcHYOnyf/UWStwUbUOVZTqUhYiOjQ8MQ/1Jt+pyt/+KbA==
X-Received: by 2002:a19:a086:: with SMTP id j128mr20744132lfe.93.1546452717068;
        Wed, 02 Jan 2019 10:11:57 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x24-v6sm12508321ljc.54.2019.01.02.10.11.56
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 10:11:56 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id q2-v6so27692158lji.10
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 10:11:56 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr1380423ljk.80.1546452715814;
 Wed, 02 Jan 2019 10:11:55 -0800 (PST)
MIME-Version: 1.0
References: <181e0aa7-34a5-5445-70b2-45770a81659d@kernel.dk> <CAHk-=wicNcMhY_YCkT5Nsdcxake8x+sfYUByvbhTzp2v-LWjeA@mail.gmail.com>
In-Reply-To: <CAHk-=wicNcMhY_YCkT5Nsdcxake8x+sfYUByvbhTzp2v-LWjeA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Jan 2019 10:11:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whcmNjH+3pP_tgKbxe3iNu20eVVxfDyVXrKsNf7HiR0WA@mail.gmail.com>
Message-ID: <CAHk-=whcmNjH+3pP_tgKbxe3iNu20eVVxfDyVXrKsNf7HiR0WA@mail.gmail.com>
Subject: Re: block: only use __set_current_state() for polled IO
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 2, 2019 at 10:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Stop this craziness. The optimization is garbage. If you want to save
> 15 cycles, get rid of code, don't add new code in an area where the
> block maintainers have already shown that they can't get it right.

Side note: that argument is further strengthened by a very simple
observation: if the code isn't going to sleep, then the whole state
setting is entirely and utterly pointless.

So code like this:

+                       if (is_poll)
+                               __set_current_state(TASK_UNINTERRUPTIBLE);

is *FUNDAMENTAL* garbage.

Seriously, stop playing stupid games. You're doing things wrong.

I'm doing to revert that buggy commit, and I will not pull any crazy
code that tries to redo this kind of completely broken code.

                 Linus
