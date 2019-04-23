Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1173FC10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 14:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D424020685
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 14:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRuMlwSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfDWOlx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:41:53 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54467 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfDWOlw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 10:41:52 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so514092ite.4
        for <linux-block@vger.kernel.org>; Tue, 23 Apr 2019 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n96aQRl9RFy0hPdQk7Xa/MQx25bn/TZiR6m6PTgCGiY=;
        b=sRuMlwSJj3tx8x7QtHL0m2YRLbf8LMnIVSOaWhe5upFpwFFoEpQ70YawhsWMfzx6HA
         F33OKNgxrugpe5kM4pTTs6KZzuTTmw4+8OfsUVqhTAb/RMMrlgvwxijHsUPxbrWeO5F2
         KLKPdBp9nPB518gASp1WibOP5SPyTtoArxz1SUkjIo1+07Kh/qDEGAJVoDQR1i0PuHPc
         igfP3GyDnQrZKuuiYUjZNOtuINYWem4u2I4pTWE+2SHFE0GneeQXaTLWmBLKlpTWGksz
         cpn8KEs7QvA5xJR6PkzgzeS+ny6gbwIz1k1QRHky+jFg4ZvNVDoeyv+nwAkXXp92JRxm
         vHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n96aQRl9RFy0hPdQk7Xa/MQx25bn/TZiR6m6PTgCGiY=;
        b=g57SYdpbhnudAGrifmJF+Gdo8y1Gbyzu5ND/QWEIfZje2LJRnVPQBnx8Ka+wOppj1/
         uSfzKJ4mfOUxSOCwuAsDIM+TJ48MOiY/r5HM/osD9aI9M+t9Jy+lfE4dbo/0dKLgVbLc
         MhBDetYjth0vHU2lTXYimRqhvQhhDnqM5ve3DzLM8eSFrh3jiuv/1uFTNq5Rn4q0xE7A
         /C1GbLw2K8jrD3zEuImnnYU+pa2MFPAuP4ryvNzRjiA93LH1KPdDzAOSdm/KJ/OyswnI
         teEgKB8TR9tf45BpjW9QA56gDYqYIRxjkYTR1h04ZrbQEFWFtlW8uvK23hehF72sxe/C
         /L7g==
X-Gm-Message-State: APjAAAVrgnb9A8WjUSq2y13d1VJpm56lzAbQW3iPoJFAkZtjgrzkTo9S
        dA4P/Ur45XI8AttIjb5JI51DV+lWPBuFgGkIlMbQxg==
X-Google-Smtp-Source: APXvYqz3PvZSMG+Nu8zlC35uDmhyokQcJgVocQMotkVuMRYZbBN/tTGQ+UdNfB8Y7+NKek77p5QYvhDqt7eppOtzhxc=
X-Received: by 2002:a02:c043:: with SMTP id u3mr8633027jam.35.1556030511715;
 Tue, 23 Apr 2019 07:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043fe9c058720a5d3@google.com> <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
 <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
 <53a17444-9539-5810-82a0-ceeefa742508@kernel.dk> <cfa6be6d-4125-6d1e-8993-e9ec9dbaa7bb@kernel.dk>
 <CAHk-=wh=kKEb6qbuhnSWh5S55SbQBOE33991ULSFUgVrEnzivA@mail.gmail.com>
In-Reply-To: <CAHk-=wh=kKEb6qbuhnSWh5S55SbQBOE33991ULSFUgVrEnzivA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Apr 2019 17:41:40 +0300
Message-ID: <CACT4Y+b8dkFzQoJgaNLMiDjF4bM1AeSZaH5EWTvF_o5MQhu4Pg@mail.gmail.com>
Subject: Re: WARNING in percpu_ref_kill_and_confirm
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>,
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 22, 2019 at 7:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 22, 2019 at 9:38 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > With the mutex change in, I can trigger it in a second or so. Just ran
> > the reproducer with that change reverted, and I'm not seeing any badness.
> > So I do wonder if the bisect results are accurate?
>
> Looking at the syzbot report, it's syzbot being confused.
>
> The actual WARNING in percpu_ref_kill_and_confirm() only happens with
> recent kernels.
>
> But then syzbot mixes it up with a completely different bug:
>
>    crash: BUG: MAX_STACK_TRACE_ENTRIES too low!
>    BUG: MAX_STACK_TRACE_ENTRIES too low!
>
> and for some reason decides that *that* bug is the same thing entirely.
>
> So yeah, I think the simple percpu_ref_is_dying() check is sufficient,
> and that the syzbot bisection is completely bogus.

Using crashed/not-crashed predicate gives better results overall. More
than half kernel bugs have different manifestations due to different
reasons. And even if we can say for sure that we see a different bug,
we still don't know if the original bug is also there or not. See the
following threads for details:
https://groups.google.com/d/msg/syzkaller-bugs/nFeC8-UG1gg/y6gUEsvAAgAJ
https://groups.google.com/d/msg/syzkaller/sR8aAXaWEF4/tTWYRgvmAwAJ

Unrelated crashes is the most common cause of incorrect bisection
results (66%). To enable better bisection we would need to integrate
some meaningful precommit testing into kernel development process
(would be tremendously useful for other reasons too). E.g. this "BUG:
MAX_STACK_TRACE_ENTRIES too low!" is this:
https://syzkaller.appspot.com/bug?id=dbd70f0407487a061d2d46fdc6bccc94b95ce3c0
and the reproducer is simply opening /dev/infiniband/rdma_cm or
/dev/vhci or something equally simple with LOCKDEP enabled. None of
this was done in a testing environment for several weeks. And then it
took another month to propagate the fix through all distributed kernel
trees. For all that time simple programs crash and bisection can't be
done and we are spending time here...
