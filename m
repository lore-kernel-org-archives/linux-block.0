Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F80ECE58F
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C052064A
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571178073;
	bh=rkQXlFDsFSyesOcjvZcFxgz+cNH1rBDwoJ21bgZxyKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CLnYiJnw/b/f615Wbyo8nV8s1gSl75WnJnzDM7aKfHJO2pHqOz5OudJ1EOQ0SsVix
	 bZw7fDTmz4NZD6CWKL3aMWRlk54J2gOUUplbyVu1aWr8KoTlkt8j9Yk/aFrW2EdelO
	 gQ61iL5Q3C/yuyPNtwCeU+8DkY27Jj7Rq2pCGjgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfJOWVL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:21:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38210 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfJOWVK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 18:21:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so21906577ljj.5
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igJfeABa6M5mmcDSZ9XAWyfxDlpeT34TBKS5Vu4WYQ8=;
        b=LIYdbK/WEFGMNdD+uIGw2BasCdPDikOSk/1C31c/6KJAoWeweWvBbkEnJF4PHN8TkH
         BgZdUCf/ZYXj115hlOqd/koyMkdZG6Il9yGalmukOiV4kTIOYCVZSlLQpLqR2NWtyVYg
         nGZ/n1OZmV0DBw+aQ4pzCSwYlzFEdDM+SUZEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igJfeABa6M5mmcDSZ9XAWyfxDlpeT34TBKS5Vu4WYQ8=;
        b=LkyqbqKxLwEfJLtUqelozIGtmTzqkj7/DNx+SN4TpQ74CsJpTRiSky8p4sfSV9JodB
         9gB+OxOMwGdkTE8qnSZIgYuwpx5VAL/VZt4cy5WBqPnfXFhj6O1xgRgr5URE1egHzr1w
         zd42dEq0qbHbQye80F+XYV9LoFFpo+u/XTtXlHq+VpdhbywNcDG9IJnF8+XMiccMYxAd
         peGbAgzfG5YcyNIWSTd7VxhBVShu0Zh2aKUQxj02F9Qbh4Y9AoFs9pN07ICN6+94aZ5D
         lRoWLTh7ulwEOQjoaSYyuTRTw0+qsB3wFXbEZc3IJUxKvyYXMSzrqlvf5Hx8LCCXSzMp
         r45Q==
X-Gm-Message-State: APjAAAXZKpZpaRw9wfWHT9WwharCOWnipiw4Pcn7kMBQpw9B0ZfBFJvm
        SJBt1D5knBowjsvmLtnBfDW5RZXdGj0=
X-Google-Smtp-Source: APXvYqyt7qaEjj0gg5ZzicDkWwLZug8qXKMb8ouEcxcOAdNmrIZeVTMbWQuE/7tV+3fgux4oc0HYKg==
X-Received: by 2002:a2e:894b:: with SMTP id b11mr23366634ljk.152.1571178066756;
        Tue, 15 Oct 2019 15:21:06 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y4sm5542755ljd.82.2019.10.15.15.21.03
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id r2so15701612lfn.8
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
X-Received: by 2002:ac2:43a8:: with SMTP id t8mr22573654lfl.134.1571178063150;
 Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
 <157117614109.15019.15677943675625422728.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117614109.15019.15677943675625422728.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:20:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivjB8Va7K_eK_fx+Z1vpbJ82DW=eVfyP33ZDusaK44EA@mail.gmail.com>
Message-ID: <CAHk-=wivjB8Va7K_eK_fx+Z1vpbJ82DW=eVfyP33ZDusaK44EA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] pipe: Check for ring full inside of the
 spinlock in pipe_write()
To:     David Howells <dhowells@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Tue, Oct 15, 2019 at 2:49 PM David Howells <dhowells@redhat.com> wrote:
>
> +                       if (head - pipe->tail == buffers) {

Can we just have helper inline functions for these things?

You describe them in the commit message of 03/21 (good), but it would
be even better if the code was just self-describing..

           Linus
