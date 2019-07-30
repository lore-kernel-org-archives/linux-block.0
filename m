Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF63C433FF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 21:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2A42067D
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 21:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfG3VLZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:11:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50276 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfG3VLZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 17:11:25 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.lenton@canonical.com>)
        id 1hsZP1-0001Fi-2a
        for linux-block@vger.kernel.org; Tue, 30 Jul 2019 21:11:23 +0000
Received: by mail-wr1-f72.google.com with SMTP id i2so32379420wrp.12
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 14:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8zeu7ZUyAJjcWYRBBJAwoN6DzL1w3rGJu58PoKrAk4=;
        b=Op0fjqMa5seDdmKLj+UfY/bSqorUL4wqaudKIechWJECN/9w4MuHaCk25YZi1w4J66
         c2Gz2h+boClIJ7DddBnoduwPJwZZ20iJ2clcDLxc3eyu+qAP+xy4yHyrjxNNKEN8lLz4
         sz3B0xQ2jq+rys61Zh2YXKP41EmKKi7MAR/YuBEYoonrnlVWuZcfe7X2mLtr/23Ee5qC
         WX5aV6N1WF53jdsJV2IB4Qe7yXaAmN8eGPTRqj7D5cYriMCeQJxR4LHMeHuGRMiN4HR2
         Hlr8IH5NNmMWOttQRZstGiFrhN97kEYoFDAzfcqo23ghrcZm+1Z7xbiWfehI5aY1okEH
         EM2w==
X-Gm-Message-State: APjAAAVEmXjXtJ2vzGGaGVbdy0qpoh6AH7HRh2v+ARmRXANhsbcbwx7N
        +r03lQ0s+47Ov2cjuWesNC7VpBC4P5O3JHmiyERv3tJX4b56xzaZnvoMdPYoS/kGbEgY5Jnn+K8
        X1oOmko7fiRstN+BcxCiVwNmf47R41FarT1zQArsa/GK1FH3xntYb10Qb
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr57901639wrk.229.1564521082714;
        Tue, 30 Jul 2019 14:11:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyBESk9rM/vvx4iIE6FFUTXB87MlPQamg3WDEiezxZ0DBT3Ce9Lpps+xmmheKrW69oCH8+Ss0afboyREJttns=
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr57901626wrk.229.1564521082493;
 Tue, 30 Jul 2019 14:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190516140127.23272-1-jack@suse.cz> <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz> <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com> <20190730092939.GB28829@quack2.suse.cz>
 <CAL1QPZQWDx2YEAP168C+Eb4g4DmGg8eOBoOqkbUOBKTMDc9gjg@mail.gmail.com>
 <20190730101646.GC28829@quack2.suse.cz> <20190730133607.GD28829@quack2.suse.cz>
 <009a7a06-67c5-6b3c-5aa3-7d67ca35fc3a@kernel.dk>
In-Reply-To: <009a7a06-67c5-6b3c-5aa3-7d67ca35fc3a@kernel.dk>
From:   John Lenton <john.lenton@canonical.com>
Date:   Tue, 30 Jul 2019 22:11:09 +0100
Message-ID: <CAL1QPZS0zTdovk0BqFu-GxQf2xfXqJFhQZQCzZD=Ev6hkO456w@mail.gmail.com>
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Kai-Heng Feng <kaihengfeng@me.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, jean-baptiste.lallement@canonical.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 30 Jul 2019 at 20:17, Jens Axboe <axboe@kernel.dk> wrote:
>
> Jan, I've applied this patch - and also marked it for stable, so it'll
> end up in 5.2-stable. Thanks.

thank you all!
