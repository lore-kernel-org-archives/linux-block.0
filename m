Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD9CA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 21:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0114621A4C
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571952613;
	bh=e00/yHSlXvXqqf/JB2YJn64yA5+CxFA09Oq6zHURRsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zUAKMfZYpt7q94zPYGicy0rdZVianzx725CdBrAM+ssjVZ9o4jX0uHmbjkM10ZXeL
	 YN/o7NtMrRljH/CauG+y9bCPE/xYkPhXEDvSjuZ83PdvQwYO5xfeRNbu30eM2Vm3ck
	 HFwoPP+Ms3N+1h9TXA9PtGmbfQdzT3pUg7NOrRBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfJXVaM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:30:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39715 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbfJXVaM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 17:30:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so257494ljj.6
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5FP/voiQdxeaQU3Va8HH5cRZmi1OHTMwBKcRrrOo6E=;
        b=G+CKE+0sNMbBuosjchwhgzz8NQwfbV/8kKBYcW1zgIA+wCHZXB0W4xnrddKNkrujly
         nBXQf8TMFFxtwDaqAlubm1WQBu/DIP2jq0ClHTeKxpnxD8j4n3vqHGpl41RLHFrD0jXc
         jfdzDY5G/0JxiPvAj8Pc7cihC14c7Kl2f6hiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5FP/voiQdxeaQU3Va8HH5cRZmi1OHTMwBKcRrrOo6E=;
        b=eQ5/6ArwSvhN+7+LPkaa4Aodb+LFjJLQFa4oZahd7i0ENrAssuJoEQJOZppEtlTl7t
         6fcwJx5j0VqElzstYYCZNsn85r30LYVkvnjA2jfQYdWGlU5BXcaK4guYlknCAotDVV+N
         UzwKNrqviqWwRWWeyrZuahmg1YmTmltdNdAJS4mrbVZU81tSP+nRm6D/nrd67Ewo7XXN
         kdYja/nkrBSRFzDQyGUDaUw+JUjtZScDS+0tp9GyuAuuI6b49422YI7VUrRDEMfyBH8k
         Qe6cedJSz0OyjlQk9pSr2M2bvFlCTUUlq/9vZXc+p64eHZ6P2ZxZexfqcQMiEIMC1lQ3
         g7fQ==
X-Gm-Message-State: APjAAAVH1UFUoHsli/TruLBfdSpmS38/gk+0wDSCJLJ+oSHBNhHborLY
        iWnpI/UOtHsKGM7GAjDyMc+n67tHLMHMlA==
X-Google-Smtp-Source: APXvYqxq5/vN7+N678A5QktrPVKXYM68eeLog9lPIHjjNm5A27WxxgJjP3jpb4laa3bc7XO7O8FzYw==
X-Received: by 2002:a05:651c:c7:: with SMTP id 7mr4027386ljr.42.1571952610084;
        Thu, 24 Oct 2019 14:30:10 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 3sm1528390lfq.55.2019.10.24.14.30.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 14:30:08 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id c4so225645lja.11
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 14:30:08 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr3303284ljp.133.1571952607809;
 Thu, 24 Oct 2019 14:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <30394.1571936252@warthog.procyon.org.uk>
In-Reply-To: <30394.1571936252@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Oct 2019 17:29:51 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com>
Message-ID: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 24, 2019 at 12:57 PM David Howells <dhowells@redhat.com> wrote:
>
> pipe: Add fsync() support
>
> The keyrings testsuite needs the ability to wait for all the outstanding
> notifications in the queue to have been processed so that it can then go
> through them to find out whether the notifications it expected have been
> emitted.

Can't you just do

    ioctl(fd, FIONREAD, &count);

in a loop instead? "No paperwork. Just sprinkle some msleep() crack on
him, and let's get out of here"

               Linus
