Return-Path: <SRS0=7zlQ=R2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC2C43381
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7228D21841
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553362274;
	bh=ZmN/AjaWGg75nTcK/UlIgOdxRX1mzrRtIduOdYfYTss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j9Np80305zon2J/RGvvBD75tA7jjuNpj7tzRuv6rtQxw4B2Td0tH62Af1EZ1tNv8l
	 FC8vQhv0wGe/hunA9bUIBl1deCazgJksVfzjRT5VgnOcGaFnpveIu4IjR8ziQ86vxV
	 2vgD1VwSg69bwI6m1b5gLpsJpyIK+kOyIfvXdbEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfCWRbN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:31:13 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:45222 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfCWRbN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Mar 2019 13:31:13 -0400
Received: by mail-lf1-f42.google.com with SMTP id 5so3377084lft.12
        for <linux-block@vger.kernel.org>; Sat, 23 Mar 2019 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuQiu6e7z/QtOdoJaMWRwxI9wZD5sepYGkOMoh4k3Vw=;
        b=Sar7sYtie4NQPGqjKjPCLb4HzCSLAlH9LIRgmNE536UndZQzvXEEICKM/4Oq5nZ+AZ
         +/LIZbbFb8jjPg/Z6EacD2p2i6dcpICNZDMLOAeorhTDIaL540B+Y3mHc9O6/fOr/ygk
         dJtCEo17U6bso9KeYSR7qMXu7WYxN+uLD9tRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuQiu6e7z/QtOdoJaMWRwxI9wZD5sepYGkOMoh4k3Vw=;
        b=ZSnV02+usGDs1u1jEREUOTlohsaifGxcA9wU1rEwl0j95WFb0qBLafjxKquwb6hMQB
         eptI6vJbA82iBI7BZUExpW9gs1kkeSEpoOpseBIz3Psv/f9N744Vt2WN+kUwwr5O9DZ9
         sNcWNEzUCtyYGR8PC6GJ9yL2h7GfSS0ZZBoK0I0kPoEhhnQ4Qf/NwmrKkli6pyMOLtMk
         9ihdTHhDq7PSOqySj/SGV9ay2ZkSYsEpbzAtgQRCZl59aDSMpv1yaTm3z47ejAIzbzLy
         8reo7Pjy5zkXt6rvua4tMXEO/uMtGO9Y8Zh5T/DO5wOGlMgLRee5yCtrEWS0qAqoSqyf
         m3eA==
X-Gm-Message-State: APjAAAUPSrSAU6s+ctqi1hANXOi93TpJ2lcqpO7KUW4axe67upRATBD4
        /k9gtvPidYcbMGyQJEHdWEZk4ujQ4mQ=
X-Google-Smtp-Source: APXvYqxTuYcGvsGz4+CMLs9dMtm3Wp2zXD7HK91+PIA3djCzM/WcausSpKOHkMcmpaP1txL3+VjmEA==
X-Received: by 2002:a19:ec14:: with SMTP id b20mr8146011lfa.55.1553362271579;
        Sat, 23 Mar 2019 10:31:11 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id b64sm2504091ljf.82.2019.03.23.10.31.10
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 10:31:10 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 5so3377050lft.12
        for <linux-block@vger.kernel.org>; Sat, 23 Mar 2019 10:31:10 -0700 (PDT)
X-Received: by 2002:ac2:548f:: with SMTP id t15mr4347486lfk.166.1553362270368;
 Sat, 23 Mar 2019 10:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <278dbb07-f4f8-8984-ab1a-0d78ef3c518c@kernel.dk>
In-Reply-To: <278dbb07-f4f8-8984-ab1a-0d78ef3c518c@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Mar 2019 10:30:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1xxHajjS8yNeoUU_=cvLvr4D7Emd80JkjPrw1VGBqWA@mail.gmail.com>
Message-ID: <CAHk-=wh1xxHajjS8yNeoUU_=cvLvr4D7Emd80JkjPrw1VGBqWA@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring fixes/improvements for 5.1-rc2
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 23, 2019 at 8:59 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> The first 5 in this series are heavily inspired by the work Al did on
> the aio side to fix the races there.

Al, mind sending your aio.c side changes too, so that we can close the
loop on this all?

The last series looked good to me, were there any left-over issues?

                      Linus
