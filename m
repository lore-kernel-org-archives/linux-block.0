Return-Path: <SRS0=xX0B=TR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F030CC04AB4
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 16:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46DE2087E
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 16:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gpiccoli-net.20150623.gappssmtp.com header.i=@gpiccoli-net.20150623.gappssmtp.com header.b="EHpxwm3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfEQQT4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 May 2019 12:19:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45559 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfEQQTz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 May 2019 12:19:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id t1so8592033qtc.12
        for <linux-block@vger.kernel.org>; Fri, 17 May 2019 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQo9aBA95rp8OAvg+gFs24bz5ulMaCtimiFeAwP39GY=;
        b=EHpxwm3dHMfgR9agTnYXj6RWczAL0Tpdb+aDv35ZkbwI+JsZU8qVdWqK/TyHPVIbXA
         HYx5hUSSE3lhycSfKYN4fykntbOk+gCRvDtmboYN9bGghhCWMKW+BkPYJ4bv2FV8HrMU
         htxE4WfbdSwsT9WZQsjGcGSVr61CyxTRzQmTULtg8QkerJpzR8DsNe3Rm4DnvnZR5heC
         pvPsPiB6mwMOhbvQleHPXpbtLoe7jfr/9+FYFQewlY+bIuJqRbWq7/wPmhkEeHxurppM
         Q5n1gMcXf4WRsN3pyuPCgoWYJZ6o+EfDyh1jKfzFf4N3H1ntfv1S7WIKhYkl0eiwsVzY
         ENIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQo9aBA95rp8OAvg+gFs24bz5ulMaCtimiFeAwP39GY=;
        b=tIAOq5NjrcMzUl27SBuZ8v5Gs+dA4UPVZdzuYP0itkQ6YkYx1HIAGeSs4QYcet7AIo
         tOsR8WZE3DgIdjokxCwa4EzTPXAhvJYBkaqMOeM7+4MTX4wqLagXOYAHqOio3FgeO9YE
         CJBlZQ8AH+ODLe1NPXY8njjnffH5GD4Huio3UXbHPJl/PIw+a2bZroluKuogQB9gdWUh
         kPGkoq9oUob1MB/MTSdkZq/J3qNLBQz+9sI+gCWgNn20ToBQRvbodn3ImErBWyTfMbhB
         eOTASIfFufmWOAxpZAsxnc53laLLjVu7apP2DPPDuE7wDnCysavWgw2YQaXzu/Tf4yga
         fJMQ==
X-Gm-Message-State: APjAAAWyr73CDMbA6nKrQVEmInKK/nxbLLgfQazQ1Ydz8VynwSMjlZIr
        gJ0xynyc8s0i+I0AF48ydJ8iX1HDwAkWp3H+1Y2l+A==
X-Google-Smtp-Source: APXvYqzuMhcd/NW5WXkxDeszD4UNp2tVLZCrFZ1IXTfTd9VNsVKaISjWgeA88f5yiB7P8wqxG6PKWsPDuCucTzpWuzg=
X-Received: by 2002:ac8:1b0a:: with SMTP id y10mr46256762qtj.91.1558109995068;
 Fri, 17 May 2019 09:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190430223722.20845-1-gpiccoli@canonical.com>
 <20190430223722.20845-2-gpiccoli@canonical.com> <CAPhsuW4SeUhNOJJkEf9wcLjbbc9qX0=C8zqbyCtC7Q8fdL91hw@mail.gmail.com>
 <c8721ba3-5d38-7906-5049-e2b16e967ecf@canonical.com> <CAPhsuW6ahmkUhCgns=9WHPXSvYefB0Gmr1oB7gdZiD86sKyHFg@mail.gmail.com>
 <5CD2A172.4010302@youngman.org.uk> <0ad36b2f-ec36-6930-b587-da0526613567@gpiccoli.net>
 <5CD3096B.4030302@youngman.org.uk>
In-Reply-To: <5CD3096B.4030302@youngman.org.uk>
From:   "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Date:   Fri, 17 May 2019 13:19:18 -0300
Message-ID: <CALJn8nOTCcOtFJ1SzZAuJxNuxzf2Tq7Yw34h1E5XE-mbn5CUbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] md/raid0: Do not bypass blocking queue entered for
 raid0 bios
To:     Wols Lists <antlists@youngman.org.uk>,
        Song Liu <liu.song.a23@gmail.com>, axboe@kernel.dk
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens / Song, any news in this one?

I think would be good to have this raid0 fix rather sooner than later
if possible - it's easy
to reproduce the crash.

Thanks,


Guilherme
