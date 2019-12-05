Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA7C2D0BF
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 17:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FEF24648
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 17:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575567206;
	bh=r67g/9hiA927KJVVx+cBd7MCpOd+2xqMrxYTzGwUZns=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=gFHRivzPtm2SK+++ZqFGYXcMezgf8WOonlas6RTaLU6u8WqZ4eABjXzzrs/Xbp/NY
	 KQHmLQy0SuBtHyUyXCiYlVlbpHrzgI7f4bASuWb+Mbb68qFlyk2miE8Ext5CXYCGSi
	 /uRsewqv6e8L9q2BBzMZssZHCBEukCtKHZ2lTr1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfLERdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:33:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43793 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbfLERdZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 12:33:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so3099092lfq.10
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2019 09:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/eKd/FDqrplPYUuvbR0AiU2l8M+m4LPxDGweCaRKq6w=;
        b=M56np70zVr1VfiJPsuEXyT4OG9+Mgq+nZRonIdlMO0qNjSITB1EVwHnE+jM9THnBNz
         3vX00ZNLigUAoH1Qop/bcwkoEis8chlXpTrSREoavAISt/m/5l5mLyPd23rMwP17l/QA
         7M9TY3swoS1z9u0iCZT3it6ySOEzIm2iiZPAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/eKd/FDqrplPYUuvbR0AiU2l8M+m4LPxDGweCaRKq6w=;
        b=W8FrPzf9tbHKGLU9Tkq/AYYAbE9QymC1+nlDFQwMbmmRttROCWlUucwktczYrSDRS1
         CKDCnI8qego7m1Z1bdZycXxOogJ2Ah3/LxNqoS1xw8+OoSEkPOy2p7aaoBTtw3UHpJky
         ME/1j4qX0P8hOW9zjreR/dRK6OYt/4or4TH4McTMFhJqf+60m3zeM5OZdcYlYTtxlN0e
         dACCI229UYlCam89OzGhUuoIkEFuhDViROtNIzx2Qj3/btzLcdlJN4B64gSfe4VBu224
         3Kn92oq6l4aM0i7PYXyB38pGonT05Qs0B10ZJhazzJU0PMXhj2Vm/mcqLjA4CEks4V0I
         4y1Q==
X-Gm-Message-State: APjAAAUfwkMaIzS5SBdfo6i97tqctdvZoXFNdYHfR7kBjnnANWpYAZ9K
        Ak057X67T3xbxrx4ETM4uQB158Gdhis=
X-Google-Smtp-Source: APXvYqyMFFh1Ku5b4KvPsSgbn0bRZdgnuPztxsszFwrcl//16LSooFh2tD8CmDcQSqoCs1nY0RZXUw==
X-Received: by 2002:a19:6e43:: with SMTP id q3mr5476669lfk.152.1575567202483;
        Thu, 05 Dec 2019 09:33:22 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id t1sm5283669lji.98.2019.12.05.09.33.20
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:33:21 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id c9so2601867lfi.6
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2019 09:33:20 -0800 (PST)
X-Received: by 2002:ac2:430e:: with SMTP id l14mr2520386lfh.79.1575567200366;
 Thu, 05 Dec 2019 09:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20191205125826.GK2734@twin.jikos.cz> <31452.1574721589@warthog.procyon.org.uk>
 <1593.1575554217@warthog.procyon.org.uk> <20191205172127.GW2734@suse.cz>
In-Reply-To: <20191205172127.GW2734@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:33:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whw+R5GVQdpV6J_5afQ=76vtBPzBPRj6-zG1tnhT32Pag@mail.gmail.com>
Message-ID: <CAHk-=whw+R5GVQdpV6J_5afQ=76vtBPzBPRj6-zG1tnhT32Pag@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: Notification queue preparation
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
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

On Thu, Dec 5, 2019 at 9:22 AM David Sterba <dsterba@suse.cz> wrote:
>
> I rerun the test again (with a different address where it's stuck), there's
> nothing better I can get from the debug info, it always points to pipe_wait,
> disassembly points to.

Hah. I see another bug.

"pipe_wait()" depends on the fact that all events that wake it up
happen with the pipe lock held.

But we do some of the "do_wakeup()" handling outside the pipe lock now
on the reader side

        __pipe_unlock(pipe);

        /* Signal writers asynchronously that there is more room. */
        if (do_wakeup) {
                wake_up_interruptible_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
                kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
        }

However, that isn't new to this series _either_, so I don't think
that's it. It does wake up things inside the lock _too_ if it ended up
emptying a whole buffer.

So it could be triggered by timing and behavior changes, but I doubt
this pipe_wait() thing is it either. The fact that it bisects to the
thing that changes things to use head/tail pointers makes me think
there's some other incorrect update or comparison somewhere.

That said, "pipe_wait()" is an abomination. It should use a proper
wait condition and use wait_event(), but the code predates all of
that. I suspect pipe_wait() goes back to the dark ages with the BKL
and no actual races between kernel code.

               Linus
