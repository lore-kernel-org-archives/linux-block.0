Return-Path: <SRS0=5hX+=PI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD8AC43387
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 00:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5211020836
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 00:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PxMG7pKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbeLaA0H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Dec 2018 19:26:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43008 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLaA0H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Dec 2018 19:26:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so22707830lji.10
        for <linux-block@vger.kernel.org>; Sun, 30 Dec 2018 16:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRRAFT0yfV7+BzTynOrgOchLC92C7QAkPDrLd1rHsDA=;
        b=PxMG7pKc1WpffgBBTvBppSOOwNSf1b7WAweZ+QTskQEh7MYVl85IA86K3MYBSNgby2
         TvGqwUIIh14QSX9UyH70jAU7C3nyfi2VF4FvGtWN2jqnLQCKZfFHf0d/EC0N381WKdP2
         Emvg+EX3oYmbf2hlDDL5YvrNCN1r9KbCr3w8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRRAFT0yfV7+BzTynOrgOchLC92C7QAkPDrLd1rHsDA=;
        b=EX98bXn3hDFgCUCvPt3k67LbCVL8VSMSubuHOMsl46vux3xXOPgpM1ghzy3PWBcqmr
         6+vh2ZgmlKbEF5050pFsxuc8NWrdOIbpjsDqeMLDvIa9PztQVn9tYR/4EtHGJgrZDFcR
         JttbMyG2bUcti1PPAzudQoYISgM2X5m+QOcIPozXbP651vO/jvo+g54xfC1M9M69gkaV
         eBuKgvYi6wsT4hfGSTZEAD0p+Rfs5gEalA1lDMNfG13+5mCWNjpsjB9TqkN64iXyiaEZ
         BB1ZfA3bwLoBlmTQXSMxrqIDEmkEdM1QLUwp9Y00Js7KMLA+lL8FKCPwgFlRF7DzDrlQ
         OwGw==
X-Gm-Message-State: AJcUukfn/5giZy12AlRH8+PHbYOrQJybGZ1FkJ0vV5S+GUw2j0qH1uxU
        TPooePNW5WXR8UVI4QTiZunw+Tu22pQ=
X-Google-Smtp-Source: ALg8bN4b1pSRyK7gJmjQ2UQzWx5jrpiDEiDdYEg8xyaMzmBaxP5ZZ5KRlHY/nAcaoOr7NxU/wGvOAw==
X-Received: by 2002:a2e:2b11:: with SMTP id q17-v6mr19969795lje.25.1546215964141;
        Sun, 30 Dec 2018 16:26:04 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id v11-v6sm9933821ljc.57.2018.12.30.16.26.02
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 16:26:03 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id b20so17585466lfa.12
        for <linux-block@vger.kernel.org>; Sun, 30 Dec 2018 16:26:02 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr18798955lfa.135.1546215962212;
 Sun, 30 Dec 2018 16:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20181227160944.GA12190@redhat.com> <20181230090646.GB1022@infradead.org>
 <alpine.LRH.2.02.1812301413220.7178@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1812301413220.7178@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Dec 2018 16:25:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh89gmqGaK4K7+ns9S6CSeCfuUmiy8GPeVz8_ntMz-DYg@mail.gmail.com>
Message-ID: <CAHk-=wh89gmqGaK4K7+ns9S6CSeCfuUmiy8GPeVz8_ntMz-DYg@mail.gmail.com>
Subject: Re: [git pull] device mapper changes for 4.21
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        AliOS system security <alios_sys_security@linux.alibaba.com>,
        Colin Ian King <colin.king@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Milan Broz <gmazyland@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Sweet Tea <sweettea@redhat.com>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 30, 2018 at 11:15 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> But you're right that 2TiB devices are common and that perhaps this option
> should go away.

2TiB devices are definitely not common in the one situation where this
option might matter: small embedded devices.

I don't think the cost of 64 bit is in the arithmetic, but it might be
in some of the data structures.

But my gut feel is that it probably doesn't much matter, and we could
get rid of the config option without anybody ever noticing. I don't
think we have that many data structures with 'sector_t' in them.

We might try to first just force the option on, and see if anybody even cares.

                  Linus
