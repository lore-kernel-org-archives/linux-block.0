Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AF7C10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3593214AE
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555951709;
	bh=8dBuTMuCKP2mILmHiOtnnnXNuiXQZ9Do67D/ZzGwocY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kj/WH1MrmktTUw7TIF3fVy0uuqHnYlf+waupuJkloabkjLA1Lu5yt2s+PUqJs59jI
	 Znb/NmTr8+D0J7s/5TqPdpTjzXeCnP18lX9pUAQ3Z/sF7bKhWpsrBn7hFGSSEmoBZe
	 Zy4R0LmzmhmavuZRItSW0Yhu/6Y+c7/H8gyVjhm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfDVQs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:48:29 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:43846 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfDVQs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 12:48:28 -0400
Received: by mail-lj1-f178.google.com with SMTP id f18so10835310lja.10
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSrB0Et0D+AV5ELkYZg39V1gZm27DaKVPxoadzxyXZs=;
        b=bWVK4FYnD/qyeZ81E2zzaVoAmJJcvcVuH09eiO5Xn3W3kdua0mcLavKZhUa1pmynHv
         B/RicnrvR2h4G6KFl+InQfcPhPVWX+U1e5UqtwlzcuS+CnwxFAUuFT/TbQ21uuSgUHix
         SPzkCWmAHTeAf7B42XOYtbBKnXmgzXfmN4K/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSrB0Et0D+AV5ELkYZg39V1gZm27DaKVPxoadzxyXZs=;
        b=mHhrBwjexDXJTgfnk7gLgZ6kkQdRg4Jk+5V22TNKerJBGU3kzJuuHNPk2ps6Kp1L22
         jnspcMCsYD/pT6kWhoFg0YPKDiuK3PzXKEcCsgL2DSEXwYqkYcEqEw8kqB4Dx3mRZkp+
         pr7M72ZZTt/TfJumWE/VD3Ogkw6F6vNYT69XvWFDhRhd9jharxcL3g/rV8D0W6J971Y0
         j99h/B9EaFCRIjclQHYSSUJEqK5vzoJQWxD1ZFkFkJOoYjc2ZoKLEUjE7/kWmfoEy/si
         Yi6vzAT1nQhsHlCe9bfJ5IYzijU28n5Wc8UmwxsRJ/iXN7IeIzlha54XPJwapNrsrPDr
         gcbA==
X-Gm-Message-State: APjAAAXEEBJg+FEo4p7UfDl5BN3YG+hpv+sqCNX5Gaq9QaNL3Lks1mF0
        GWMytZpLtWwGbVNnCMfymgY/UgkChk8=
X-Google-Smtp-Source: APXvYqwfcta6H7ykxqyIC8FDSjAj/u67PImnztFEkkg31xfGTLys6MT6lGzUlMHtri97oxZ/90RCfA==
X-Received: by 2002:a2e:894e:: with SMTP id b14mr9385425ljk.158.1555951706414;
        Mon, 22 Apr 2019 09:48:26 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a24sm2759997ljd.32.2019.04.22.09.48.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:48:25 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d12so9441596lfk.6
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 09:48:24 -0700 (PDT)
X-Received: by 2002:a19:f50e:: with SMTP id j14mr9831758lfb.11.1555951704551;
 Mon, 22 Apr 2019 09:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043fe9c058720a5d3@google.com> <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
 <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
 <53a17444-9539-5810-82a0-ceeefa742508@kernel.dk> <cfa6be6d-4125-6d1e-8993-e9ec9dbaa7bb@kernel.dk>
In-Reply-To: <cfa6be6d-4125-6d1e-8993-e9ec9dbaa7bb@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Apr 2019 09:48:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=kKEb6qbuhnSWh5S55SbQBOE33991ULSFUgVrEnzivA@mail.gmail.com>
Message-ID: <CAHk-=wh=kKEb6qbuhnSWh5S55SbQBOE33991ULSFUgVrEnzivA@mail.gmail.com>
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

On Mon, Apr 22, 2019 at 9:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> With the mutex change in, I can trigger it in a second or so. Just ran
> the reproducer with that change reverted, and I'm not seeing any badness.
> So I do wonder if the bisect results are accurate?

Looking at the syzbot report, it's syzbot being confused.

The actual WARNING in percpu_ref_kill_and_confirm() only happens with
recent kernels.

But then syzbot mixes it up with a completely different bug:

   crash: BUG: MAX_STACK_TRACE_ENTRIES too low!
   BUG: MAX_STACK_TRACE_ENTRIES too low!

and for some reason decides that *that* bug is the same thing entirely.

So yeah, I think the simple percpu_ref_is_dying() check is sufficient,
and that the syzbot bisection is completely bogus.

                Linus
