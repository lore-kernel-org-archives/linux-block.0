Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C204DC10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86357214AE
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555950887;
	bh=kfIcnxKvqoQ8S/q2CBsY7jfi/O92sQ/nQh33ZlA5XR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PhLlWQrQq50Er2R84/mPBrWaXZjoxQrx6YTyQM4vzefykG/u3eySEfmqIq+eOdAQn
	 +WSzlydFdw/r+0st5sd+1K2TUPe+JwfQ8atu34CyQgrngoWEPkrx0K+xDsN2AHEEp3
	 qkitrvYhQ6fV/iPPfE6lcOpIkSTUCf1BB3dTw26s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfDVQer (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:34:47 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:45277 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfDVQeq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 12:34:46 -0400
Received: by mail-lf1-f42.google.com with SMTP id t11so9389196lfl.12
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fehd6cWonKO2WJxaw8cPP4qBfU61mSuWXXGtQiq40Us=;
        b=VlWHTpciCrw/OJCBlw1zce2W9q5v+eNGC+pBmsyhOxfbTzMjB8phJ5lZX8PGq9UwPX
         HVxH3usdHGv7SQS9UbMGk3kuK7G5yAdfYFbSb38lV+7rJwcw/6wggDMrLeUmvMZMj1CT
         DR+2GIz8Qg8/SKDedS38j34hOh+rvpgRbMtLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fehd6cWonKO2WJxaw8cPP4qBfU61mSuWXXGtQiq40Us=;
        b=DV3F6XSCoG1eLl32Ay10vdht4GvJF8lnCjafCVmg8ONSYUBg4k9DpNc5IzvZ4/1/gU
         1WRhp+3tdy1Lv+f6oiJ/y0bftZVtXWzAFIoVlJNI/Z2mz4v3DTG6Vmy+MF5BtS2JD371
         DyDEnw7AtPmQ8pQ7FZ5z3CXmVkXxUCMF/QQTxyBmVU/t/aelaJs2qxUwZKjwHo8AlY9X
         joXrQBnE7AdVbx93C60L6Er+JgI3ulFTeaivqNNkYC9jahnEufKi/+uHtkO9TRp12Xa4
         cxXi4JkcUDEwhyPaOYOUz4pXrhw5AXJRwe5Wc84A10IpY6ug4L2z65yleebdRBVSaurI
         DZXQ==
X-Gm-Message-State: APjAAAV3Sfub3SEQ79N5njDkkV0zc+oUFWwDeoLWCeny5kTGvLUPmQ7Z
        u9mwqeKxOwn6OdVWVP3Xrh4vtnw+w5E=
X-Google-Smtp-Source: APXvYqzTMfi4ifWz0/4rqYlUkxVBV7Rfh/7KLmg24wi0kUtJhSNfPSkOXa/XxEyP4hlLJJc2fX7UQw==
X-Received: by 2002:a19:f703:: with SMTP id z3mr10870029lfe.119.1555950884322;
        Mon, 22 Apr 2019 09:34:44 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id f4sm2806107ljg.37.2019.04.22.09.34.43
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:34:44 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id h5so9429315lfm.1
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 09:34:43 -0700 (PDT)
X-Received: by 2002:ac2:547a:: with SMTP id e26mr10716923lfn.148.1555950494590;
 Mon, 22 Apr 2019 09:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043fe9c058720a5d3@google.com> <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
In-Reply-To: <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Apr 2019 09:27:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
Message-ID: <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
Subject: Re: WARNING in percpu_ref_kill_and_confirm
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[ Crossed emails ]

On Mon, Apr 22, 2019 at 9:23 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> I think the below should fix this. Very early versions of io_uring didn't
> have this issue, since we did the percpu ref tryget for io_uring_register().

Ok, so I like your patch better than mine, but note how syzbot
bisected this to the initial merge of the io_uring code.

I agree that code shouldn't have had this particular issue, but it
looks like it does.

Is there some way to race with io_ring_ctx_wait_and_kill(), which
_also_ does that ref_kill() thing? I'm not seeing how that could
happen, but maybe if the file ref counts get screwed up you have
->release() called early..

                  Linus
