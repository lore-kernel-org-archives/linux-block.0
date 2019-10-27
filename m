Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AADCA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 16:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE7720873
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 16:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AAwmCSHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfJ0QcI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:32:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44041 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfJ0QcI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 12:32:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id q16so3854324pll.11
        for <linux-block@vger.kernel.org>; Sun, 27 Oct 2019 09:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bs2SjWSFOmSDRO8IdoMZpHMPqP3d7IxK89dWrHU3ttI=;
        b=AAwmCSHMTfWdNBSGiXVez7q/KUsaYY0UtStbu0Ih3kRlSzUx3A82a3dQVTQrC6OfAb
         sfCW6bJ/dHLuQKn0xHRAA2B6hj/4AriwEOEoREaPAhWEnjVCVe67CvRnegD6cDtyWHcg
         1e3LpOLksdH7k6S2gB/+Gb8jlIs/Wx3I6P6Xpe4fAGWVTPn2ytunNhjFfbdCep6ExGn3
         SlGfhz0uxIKfKSg0ybi5jimVDjloVh8xURZJYNEFtcOGs+H7b6/GchTbUVvp4LSjLhwl
         NrnTJRL0i4m1N8inhGK5LV8lsB0A9H2OFiQ2M4OOX/RjgDuZFNa5WuGkOSY38b7ctbZD
         KdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bs2SjWSFOmSDRO8IdoMZpHMPqP3d7IxK89dWrHU3ttI=;
        b=Vz+uGBHLkmc718f1uUugG/RTD7a3PBRNVx2D6r74OYMRjLkj370MuapZvstkA47r1P
         RpZHXyxGsSrBdbjWqgU7XxEU1RfIKiYOff7tOv3hgWORjQDo86+VWwrykJEC5eCQr8/0
         uzWVr6zmKDY9piW4X0ivHX/M0WQW1gU9Y3sXY7CrSZT678aBRThK2apoMxSKg9bi89ut
         qBsTWZQcfbux2RcKVJFFxCCQ01F873Xvw7q1rkLoXfZBq6WqtarS6aOVCtUJU1zZqq5a
         /rXe0Xqz1VZTqWuNna4EFE+Eb6pSpeg05sc1I32Uiss2vT3JXDSS57Zyp8JA2/g9/YDv
         JWIA==
X-Gm-Message-State: APjAAAVMZ+bj2CHL82jCJ72m/Zjz/ir4fuOm6aO3opTptT9KINUo1iw1
        wmwzTAlNApYC+eV9SKdfeRYe4A==
X-Google-Smtp-Source: APXvYqwhO/0jkTJpR1pX3HlXBFwvjVVpk5az/keU1AHeINk3poeCtcxalOsc/QyR37yBfHb8kU7T/A==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr15186161plb.38.1572193927324;
        Sun, 27 Oct 2019 09:32:07 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id v2sm7620245pjr.14.2019.10.27.09.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 09:32:06 -0700 (PDT)
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572189860.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
Date:   Sun, 27 Oct 2019 10:32:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1572189860.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/19 9:35 AM, Pavel Begunkov wrote:
> A small cleanup of very similar but diverged io_submit_sqes() and
> io_ring_submit()
> 
> Pavel Begunkov (2):
>    io_uring: handle mm_fault outside of submission
>    io_uring: merge io_submit_sqes and io_ring_submit
> 
>   fs/io_uring.c | 116 ++++++++++++++------------------------------------
>   1 file changed, 33 insertions(+), 83 deletions(-)

I like the cleanups here, but one thing that seems off is the
assumption that io_sq_thread() always needs to grab the mm. If
the sqes processed are just READ/WRITE_FIXED, then it never needs
to grab the mm.

-- 
Jens Axboe

