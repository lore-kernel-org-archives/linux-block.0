Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A8FC433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 18:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C8B613C0
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhDMSYe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhDMSYe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 14:24:34 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F0EC061574
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 11:24:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id dp18so3925832qvb.5
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOiJzunVd05mqamt/5TGLR6Y6fd83AHptXCwJ4Xqk20=;
        b=XFVCecc5SaXMXkEtMSOm6hS5wZ10POOPoNVf6wtWlKfFJsuYEYKWxhzSt0+b/fVFg5
         j70FPau57jAGTGNQ3+9tA9h9ZoO7yhMw9fFhKY3ccf2fbxJjT4KC68lzeAS+4cn3HMGB
         wp5PzotUQA4HOmRLYGnF6lGyWvjkDUaH9c4W68ZoCoNauDoc4V9TStZcf3ER3GSgi2B8
         TAKRg/N1syJIMdjgHR6v6YGmBieKFHBRue3kOx9W/YALVuUYFVfV04eS3w2NY9xdW8aO
         3ft/9Hvx7suI6YOOuwBV33K9HKwN2ojD3DmQGMoZB4GKqS/qhxJBAMFiF7xo1WSXfU70
         peYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOiJzunVd05mqamt/5TGLR6Y6fd83AHptXCwJ4Xqk20=;
        b=XnYwjUKhQTNe8MQgn+pz30ytJO4SXUnWU4N+qgnvmZwpc277BV5CaKk9BPNmf1nMwW
         v0PjpPzfLOOYsBlhW2wnQgacTnGBdpaaglQmrnnriEhXht/yOZGCQWQG5+aQOAdQN5Wf
         bjIYsrcUipH9WHTY6/HqSwHcMlrtxpFRijbKAGCkAj0g39X2EICfQ7hyT9HgHS5iUosm
         C0JEtUqGc6JO5JiQOhsZdz7uhg2gRuKFZOJUlAu3/hYKxHn91pB9xoTmjBHtkIKemCLZ
         30ZnLK4b7dYEEJqYGCgZhovUiuvP5N7uxvLWvhQYSZb0uGD30z6qBc6j3cP3o+IqzybK
         0M4w==
X-Gm-Message-State: AOAM533aMpTitEf0rvMJJgBfuohMK+JFMOe3oI4KjHZ7uIDPjLgYCpNm
        2uWFc00Rw9wOdjBvN+MPEaOLHMRVa5oWy/4iHHPUmw==
X-Google-Smtp-Source: ABdhPJw6yF83WYbBJZbmO8yDMBaKSylZ7lchp4a3dBmw4v5MoYL6NrNQOEUYGEgo1fjifejUv/nkR/RD81DbNlucA38=
X-Received: by 2002:a0c:8421:: with SMTP id l30mr21579057qva.23.1618338252752;
 Tue, 13 Apr 2021 11:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae236f05bfde0678@google.com> <20210413134147.54556d9d@gandalf.local.home>
 <20210413134314.16068eeb@gandalf.local.home>
In-Reply-To: <20210413134314.16068eeb@gandalf.local.home>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 20:24:00 +0200
Message-ID: <CACT4Y+ZrkE=ZKKncTOJRJgOTNfU8PGz=k+8V+0602ftTCHkc6Q@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in del_gendisk
To:     Steven Rostedt <rostedt@goodmis.org>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, masahiroy@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        rafael.j.wysocki@intel.com,
        Sean Christopherson <seanjc@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 13, 2021 at 7:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 13 Apr 2021 13:41:47 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > As the below splats look like it has nothing to do with this patch, and
> > this patch will add a WARN() if there's broken logic somewhere, I bet the
> > bisect got confused (if it is automated and does a panic_on_warning),
> > because it will panic for broken code that his patch detects.
> >
> > That is, the bisect was confused because it was triggering on two different
> > issues. One that triggered the reported splat below, and another that this
> > commit detects and warns on.
>
> Is it possible to update the the bisect to make sure that if it is failing
> on warnings, to make sure the warnings are somewhat related, before decided
> that its the same bug?

It does not seem to be feasible, bugs manifest differently in both
space and time. Also even if we somehow conclude the crash we see is
different, it says nothing about the original bug. For more data see:
https://groups.google.com/g/syzkaller/c/sR8aAXaWEF4/m/tTWYRgvmAwAJ
