Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A967C433DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 19:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427F2206BE
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 19:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KKgKzZnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgHXTkm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXTkm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 15:40:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A15C061573
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 12:40:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ep8so4743644pjb.3
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vwhq2dXTSMNvKvoJk0Zd4D/I3kNBGUtdB0oUb6Xl4Oo=;
        b=KKgKzZnkMORqI3S5bZWHPtP7ZANt3V6OWcp2GPL5+jcjGwFoEZ5KdxmbTqK8R6z6pe
         LCvXVkXs77eGeJUTZQy1u25/M5kQdwE4foETbptoQGRo3IFy0Q8eno/9GYVBXTJoixrT
         0Eqn4QydPtZMAzS7ONKJgDtR1mKgkuMXTToQLpP8oqOSle6Q+g7ZCi54BVKOssIrYznG
         /F/TfsiJaNnqK1+R2ozBXEN8tdGbOR16ZS7N+8ROPx6kpBIVrpmybVbg64JcQqQZFWss
         LqM+HqteR+B/WfAnwT5IIdz7G/AE/z/s8k0Ps7K0JGC+0PcBxaLvSq0yyO9bftlCA6Pr
         AlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vwhq2dXTSMNvKvoJk0Zd4D/I3kNBGUtdB0oUb6Xl4Oo=;
        b=gXjBAa4qbuP71oLSFhccZ6JQ57CWrJ5wlVpXD/gCzU3cW1i96Dp/733UQNHNBN/nJB
         ghPJoLzHrtKcUbmfNuy+41HHgIzhg37fRrwHy0T9JMtPQIARK9lTfbvKq2IVMjX7IBak
         ucwB8yJFZSAzSwOOf6BHyCi3p8Hjc67Cl9O+MvN0z8BKcJ0DmRL81jYHFNAZB1dE4V/H
         ekXz6yhII2R/vNQHPsqSBFbw4psBJvWtVNAJk/vuAr6zwC5fq51sTuP1/fu6+KpYV8Uz
         S8JWsD25+ogSA13Ql66Rwuk6nW7QtIov1cYJ7zyCKulaK7uSfvqsvXiNnzgbFvVV7DhB
         X7oA==
X-Gm-Message-State: AOAM531dkPqysexW92ieHhqy03TPEYzb/JRuVSWAhG9F0AfPpE5gAsAm
        1UMoJqWo+/5oS997VyiOygdhLlQOoNr/fFyg
X-Google-Smtp-Source: ABdhPJwsm96rlThUd2Q4ak5cC3nm1MWpzdPhxuZYrqjQrLrFQh6GYXngL9HH+nO3zqQbnx+wdTboXg==
X-Received: by 2002:a17:90a:e604:: with SMTP id j4mr620155pjy.215.1598298039966;
        Mon, 24 Aug 2020 12:40:39 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21e8::193f? ([2620:10d:c090:400::5:b493])
        by smtp.gmail.com with ESMTPSA id z15sm349370pjz.12.2020.08.24.12.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 12:40:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block fixes for 5.9-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4945e1c2-a6dd-2827-e7ff-db7aa7ee3bec@kernel.dk>
 <CAHk-=wjXzLuN5+koGeDZig6qwabdU3ZG3Ra7TQjSzQr50YPwVw@mail.gmail.com>
Message-ID: <caa1ab82-337d-088b-f2ab-de25f06c6808@kernel.dk>
Date:   Mon, 24 Aug 2020 13:40:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjXzLuN5+koGeDZig6qwabdU3ZG3Ra7TQjSzQr50YPwVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 24, 2020 at 12:56 PM Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> On Sun, Aug 23, 2020 at 12:27 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > io_uring-5.9-2020-08-23
>
> .. you ran the wrong script. Oops.

Oops yes indeed, guess it was too much on my mind when I tagged it.

-- 
Jens Axboe

