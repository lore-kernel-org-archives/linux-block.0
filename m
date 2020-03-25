Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248EAC1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 14:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83CF2074D
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 14:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Vq2x/FtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCYOtm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:49:42 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55967 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCYOtm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 10:49:42 -0400
Received: by mail-pj1-f68.google.com with SMTP id mj6so1115139pjb.5
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2020 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XaoMEMejIpMESAc9WqR2GhKqL0OQjsDRcjnTUf3tMEU=;
        b=Vq2x/FtK+b9c3oq56Ike2Db5P6DEsGVOcUUKgyP+GHz434GzReIN2kgefyNw323oln
         gEOwym2ejfMVV0z9WW53ltBChF9b42YciEy+RTto6pk4bJSkBfdTZntslttgOV79WAn4
         phzJGBtAkyesDelSw/CmbodkA/VJ9nLJoREr88utYFaEtFQwhyqJXch7vXa9fJiJcMzh
         3t9QT7wHOSvQt5jeb2uq/RH/w2hTvHEbFvYs+3hbYntd5s/VsVJl95HMXf7p7CwN8z7I
         ZlD6Be0pN4pgT3z30DBD7Iz7pw9aIth6Fz2uV27vzPXZnCvPxph/3PT8svIj3M9NNln/
         A50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XaoMEMejIpMESAc9WqR2GhKqL0OQjsDRcjnTUf3tMEU=;
        b=dV1DGzFn2amQsjZXKij8DBQT0rtPcXkrrpT5duXSlz2vsxKjPiSk7JX60kBwQRB+AY
         OYutTdoTS9FmDPg8wkGT7fvTV/Ng3uJ/ckYYcyqarDYOMKbuf1W6tmCtZ7UnO/BV7/qw
         slIr6AFgtWEW5MqqXtgxANPOSj/gpm7yIhnFln3r8TABJATDBqoOcFF3vV1mK/TlGM7L
         YuPnz8tGVPrt49LQGN18+5icDss/adZlAAGMpFvkCmpJ2C9e0cMmlHVVXiiR3tXEMEhB
         8Za2Jn5G0APBXX3LqfeoP8bzbUjDPVujaPpxwLfb23ylL56d6641Xne20bgQnOrnEqxo
         jREA==
X-Gm-Message-State: ANhLgQ0sKv6AHSGH2wwTE09XDH26eChkatRNGV1ll4kHMzmMOklUT/AX
        +z3md9Cy5ZSh2yPt3KAwa/LI0Q==
X-Google-Smtp-Source: ADFU+vtAJhJaAlT8lvsDcE+zhPZE/r4CdTmaK8ibgJdiL7XXlGU4pvlo03OdxzU01Pwam6evPWdUHw==
X-Received: by 2002:a17:90b:4d07:: with SMTP id mw7mr4246463pjb.103.1585147780821;
        Wed, 25 Mar 2020 07:49:40 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id i11sm4668038pje.30.2020.03.25.07.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:49:40 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] block/diskstats: more accurate io_ticks and
 optimization
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
References: <158514148436.7009.1234367408038809210.stgit@buzz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d8e3459-6d67-72ae-c1df-5335d2a49bf7@kernel.dk>
Date:   Wed, 25 Mar 2020 08:49:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158514148436.7009.1234367408038809210.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/20 7:07 AM, Konstantin Khlebnikov wrote:
> Simplified estimation for io_ticks introduced in patch
> https://lore.kernel.org/linux-block/20181206164122.2166-5-snitzer@redhat.com/
> could be very inaccurate for request longer than jiffy (i.e. any HDD)
> 
> There is at least one another report about this:
> https://lore.kernel.org/linux-block/20200324031942.GA3060@ming.t460p/
> See detail in comment for first patch.
> 
> v1: https://lore.kernel.org/lkml/155413438394.3201.15211440151043943989.stgit@buzz/
> v2: https://lore.kernel.org/lkml/158314549775.1788.6529015932237292177.stgit@buzz/
> v3: https://lore.kernel.org/lkml/158503038812.1955.7827988255138056389.stgit@buzz/
>  * update documentation
>  * rebase to current linux-next
>  * fix compilation for CONFIG_SMP=n
> v4:
>  * rebase to for-5.7/block
>  * make part_stat_read_all static in block/genhd.c

Applied for 5.7, thanks.

-- 
Jens Axboe

