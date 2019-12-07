Return-Path: <SRS0=ZBdn=Z5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E232C43603
	for <linux-block@archiver.kernel.org>; Sat,  7 Dec 2019 01:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619B72245C
	for <linux-block@archiver.kernel.org>; Sat,  7 Dec 2019 01:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575680642;
	bh=FXf6f0LodJ3g4NUoj/Ba5RlgD5YItBl5ZUrjmyza25k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1wWTo3pViWyDoxgwgzH83kTE6wzoRAiqvPLQ+xGk6RLJNEyfIfQaNCivTzsoS6DSV
	 970VbUoMaplGMY9Z2hbNPezv0DqfWlGrV2xGrvNTCAgNg3fTJDYYSJYj66iW+cQJVg
	 MyGC2VT4beHRcBr+FiePaJiZIkIEZNMGmTEb/S1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLGBEB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Dec 2019 20:04:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46073 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfLGBEB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Dec 2019 20:04:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id d20so9509933ljc.12
        for <linux-block@vger.kernel.org>; Fri, 06 Dec 2019 17:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xp39wpo5AR+pbRP/tZoeRSZICS3SHzWRMfhJEvbxIGA=;
        b=F9QgFlzOLVDvV/NH9kO5C38Tw6X+Hr1zV9nvDrPtaW9IdmdHU1TNQTmWgtmr08QLWs
         m/LzPoUZk/NRRXSGyCni67pyjPAjI1csctIc4AcmS9vEoOX/8bco5LDaWzkI+5Pvvxsm
         tA5h/kF2wpsxbPSmFh84K3eYpHR4dbqT6qkZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xp39wpo5AR+pbRP/tZoeRSZICS3SHzWRMfhJEvbxIGA=;
        b=to2ZITJq0Tlh2t5U/xGBs5/War5Djba8Lbty6mShrXOMldshW+4pFGc2nhl1UvWJwG
         4cJZy1LvKIXMBIv3NT47WqhWcQorOt9Zm0kPA72I/nEaKeoc7qyj4HCS3l6Pm31EqxNM
         iig97OPZwE8Qwup50c3hzawGM7eYRyAux2/THmYvLLNS2W7EUMw6yq84ka4ag9PrTg0r
         RsHyVdJ1mjmEAynECBv2fiqOVWyWmMVEiI2X1KP7EGWYC+DluCGNp+FXa2m7m9AAey5O
         jh6ndJfVp06hCVRKVVOPOGrE2X+rbhOdlBdaG8L/iauJl6gwLcbme084g2nY3PXD9Xwt
         VOSw==
X-Gm-Message-State: APjAAAUO8B6bS7w6wQeJQb+B2LVT75TKl89UZs4NPepGtQ0a/BIvgdS+
        EQxUJdEloUdX27NPt70/Ren+mRcJMnc=
X-Google-Smtp-Source: APXvYqweCz1SG/MXYNcDiN9oA380SO/QxuSfbFSVH7y3r0Y5jk2F4QuKqRQdrB7lDawQgcz4mTvetw==
X-Received: by 2002:a2e:914d:: with SMTP id q13mr10172665ljg.198.1575680638977;
        Fri, 06 Dec 2019 17:03:58 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id c23sm7260632ljj.78.2019.12.06.17.03.56
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 17:03:57 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 203so6562598lfa.12
        for <linux-block@vger.kernel.org>; Fri, 06 Dec 2019 17:03:56 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr9400181lfk.52.1575680636244;
 Fri, 06 Dec 2019 17:03:56 -0800 (PST)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <20191206214725.GA2108@latitude> <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
 <20191207000015.GA1757@latitude>
In-Reply-To: <20191207000015.GA1757@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 17:03:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
Message-ID: <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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

On Fri, Dec 6, 2019 at 4:00 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> Tested with 5.4.0-11505-g347f56fb3890 and still the same wrong behavior.

Ok, we'll continue looking.

That said, your version string is strange.

Commit 347f56fb3890 should be  "v5.4.0-13174-g347f56fb3890", the fact
that you have "11505" confuses me.

The hash is what matters, but I wonder what is going on that you have
the commit count in that version string so wrong.

                   Linus
