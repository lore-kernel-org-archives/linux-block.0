Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E08EC74A5B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 22:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCQW4a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 18:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCQW43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 18:56:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C5DD514
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 15:56:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so6815839pjz.1
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 15:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679093788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgl6/Ew3LdfVeuq3EG0BPByS9IqpLUKC1pNwODZSZMU=;
        b=e6R9EwymyM8VB3T/Qk9Bv7+QepHZSKJljv0Tk0WcqnlmSGmI/JU/r9KMRinX1eUh3Y
         +2zTFGLlEhiGkYfExeZ0TLIqg4/MZG8WTJ1/bK4fTPeSFCS2KlnbRRscLIoJw/EiZvy3
         wOjxustqLkj0IMLmd0C7JiYUaCLuTV3rJAnwmmblpoUX/eI5O02Ac2urVs3k6Sq3OddO
         ukQ9C+M5H4d1KShMTho2fwl2AOx7i/LJljqCBPIb06zvUWJKpbUxefq9DUiXheNRTrCW
         QsEYIYgTgsvg1dCdT+IwAGgGVI+1GztUQJscTfQvk5daK0y+1dfdmUH9ckBCUbrKy2o9
         RmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679093788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgl6/Ew3LdfVeuq3EG0BPByS9IqpLUKC1pNwODZSZMU=;
        b=4t8NxOZtwyA3GvxZ9be1L76ejpQXB9UWVjPIXkX8PdBqyPgLrpnrUXnmOUFj5YnRTa
         Uoa2b4kVrqz4ljknwAwmu5k0+G2baljQg+FmhaUKVJHPvz8hgKwFADaeQ0PQBkmDB6eh
         l7DwrwWvZL6aXE6gGfE86DWOeJY7n6o4jQsRJEzBd3FjTmYQCSFet8swK55sFlPcgo6A
         8u3Oc/vSkVoEgEYFHJzRHXzu3SIKxPj9lRA87NCnCSnWUA4owuvom77h3a1yp2vtCg6J
         UTOLF1Hod5yWZqLmY/vz2RbMOQNbxQVDGTwUj2r8ujX/L0pDtJuFbn4CIA9DJ9lEVFn7
         Behw==
X-Gm-Message-State: AO0yUKVJKiVS3B7Avzw3/Oe/n03WIyE515ZCYhhI3YDxIxlTQuHD8yQw
        Sz2dkI0M4RyfZMM0o47XEFrO6PHocHvPnxDVTUK7iA==
X-Google-Smtp-Source: AK7set+VZ1C/vdje0Qf+DN5K6lCsci8LicRW622ZINtSJOlwFek/UOb9dFwUqU2dwUFenMc0n7bU0LcAGLAMvZzPf6E=
X-Received: by 2002:a17:902:e749:b0:1a0:4aa3:3a9a with SMTP id
 p9-20020a170902e74900b001a04aa33a9amr3500662plf.2.1679093787879; Fri, 17 Mar
 2023 15:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
 <CAKwvOdmJkQUe6bhvQXHo0XOncdso0Kk26n8vdJZufm4Ku72tng@mail.gmail.com>
 <6414c470.a70a0220.6b62f.3f02@mx.google.com> <CAHk-=wi5yk0+NeqB34fRC-Zvt+8QZVPTiny9MvCxxjg+ZqDhKg@mail.gmail.com>
 <CANiq72m46OzQPtZbS_VaQGgGknFV-hKvhBw8sVZx9ef=AzupTQ@mail.gmail.com>
 <CAHk-=wgTSdKYbmB1JYM5vmHMcD9J9UZr0mn7BOYM_LudrP+Xvw@mail.gmail.com> <CAHk-=wgLBjQZ1Xic9SDvtPOu3MNwRznZygZ35mqq4CpKmWdBtA@mail.gmail.com>
In-Reply-To: <CAHk-=wgLBjQZ1Xic9SDvtPOu3MNwRznZygZ35mqq4CpKmWdBtA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Mar 2023 15:56:16 -0700
Message-ID: <CAKwvOdkSBASKK9LZowSdNyN+OR7Kx+j5sMdiJ1nSwbvoQPzNVQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 2:00=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Mar 17, 2023 at 1:51=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > but I would *really* like clang to be fixed to not silently generate
> > code that does insane things and would be basically impossible to
> > debug if it ever triggers.
>
> Side note: the key word here is "silently".
>
> If clang notices that it generates crazy code, a warning at build-time
> would be preferable to the "oh, we noticed the crazy code generation
> because we do sanity checking that just happened to catch it".

That's fair.  I have something hacked up locally that can spot the
fallthough from m5mols_set_fmt() as objtool did. With some polish, we
can likely ship that as a compiler warning.  Then we can have these
checks regardless of objtool arch support.

First I need to teach LLVM that __stack_chk_fail is noreturn, though
I've only verified that thus far in glibc, musl, and bionic; I still
need to check that's the case for the BSDs' libcs.
--=20
Thanks,
~Nick Desaulniers
