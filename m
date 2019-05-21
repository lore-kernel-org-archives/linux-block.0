Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AA7C04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F0F217D4
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEUMIS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 08:08:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41057 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUMIS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 08:08:18 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hT3Z2-0006ue-6K
        for linux-block@vger.kernel.org; Tue, 21 May 2019 12:08:16 +0000
Received: by mail-wr1-f71.google.com with SMTP id n9so7960703wrq.12
        for <linux-block@vger.kernel.org>; Tue, 21 May 2019 05:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXhU7/Nn4406vWILE1V7HnwbpPCsuskWXUNv5gI4pr8=;
        b=TYv/9XLgb7zHTJmJpE92JfPJQfrl1teCCgjZdaCJQb+fBD7hPTb9cyHEeC9WErLT/Y
         eyMmItRQE22mqwfc1Q5kLueLWZzn3Gn5gjU5pRP6GtOQ/ElWZ6t4HZvt6I1ns4Ex6++n
         W0LgYza4WTaZRSZTy8bVrK+wY6xDFgAJnxb5rX5MauPiOsJMG+H0vpxLbe/3UrzL7TbS
         sEIHErjgvRsCjLd+cUh2a4W2tAfx9qaUMdbwWBO34MlaAyC6Cn8n+7sodaXIoU37zRj1
         +thi8K+PphvKxW00d45cHbOD+4l/44VmX0ZL+EVT3HNHnznGok2XyCUE+p5YYj+qZqOp
         Mhqw==
X-Gm-Message-State: APjAAAUFDM0DR8ka7UZEix+2dxv/izdo8ux4HfBUXyiMga9QA2WFKzCn
        NwKdUDvV1XAzIavuKEuaWnwtyHrVDlw5a6+lRU5UbXkPCESWIaPCSkSK7rrzH4rfP9cm26KPvBt
        Q9Q70tMnf/kksLKRz0L472cvXOXW+KDF9bwne+sNRP8Sy+kIY+W+019/J
X-Received: by 2002:adf:8306:: with SMTP id 6mr37224320wrd.155.1558440496011;
        Tue, 21 May 2019 05:08:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFs6jLle8rolj8Uvchcc0hIOU9iziAkdiGdWrTuNrb0vVhuvAlwYbeJAsL050r5pHjQwVAgcnfki4xEyGbzcU=
X-Received: by 2002:adf:8306:: with SMTP id 6mr37224310wrd.155.1558440495856;
 Tue, 21 May 2019 05:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220911.25192-1-gpiccoli@canonical.com> <CAPhsuW6KayaNR-0eFHpvPG-LVuPFL_1OFjvZpOcnapVFe2vC9Q@mail.gmail.com>
In-Reply-To: <CAPhsuW6KayaNR-0eFHpvPG-LVuPFL_1OFjvZpOcnapVFe2vC9Q@mail.gmail.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 21 May 2019 09:07:38 -0300
Message-ID: <CAHD1Q_wkziJYx4z0JcBavmQRzTh3a4g5xZG8bhVX+TYTkhaTrg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] block: Fix a NULL pointer dereference in generic_make_request()
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        axboe@kernel.dk, Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 21, 2019 at 2:59 AM Song Liu <liu.song.a23@gmail.com> wrote:
> Applied both patches! Thanks for the fix!
>

Thanks Song!
