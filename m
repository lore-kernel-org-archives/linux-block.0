Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4684C3F2D7
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 14:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4D4217F4
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 14:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="HdCEra2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCBO7T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:59:19 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37027 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgCBO7T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 09:59:19 -0500
Received: by mail-il1-f194.google.com with SMTP id a6so9562484ilc.4
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 06:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYkZC+H0cclejhwnu9ybKgEGURqGTDULgNJyOMe/aZs=;
        b=HdCEra2IzdfQAQEBA7Agqn/vJJa/CGaerdl9UrJGEi6izanHXQsrt/RuKJIkiac1Fv
         HHd8gPxzkzeXH35TOn9AZmvG/5Wm7jriHCBv0UW1Pdtf/MfhPRUoUvsK5h98tL1HH+JG
         lIV5MmCsnF4XFf37ufrpmKTXUH+sMeFx7a8/4EVc4Ly7vciXfDu0t/ijOk19sEWCrb3N
         gbmC6WcQ1zDdA7t7aeYbuqG20B+IEjmXmGQF9h4rF6e0vG9UfWudYWRxR5AMLWa/D2LT
         k45gtvTeizB7XsVpx03CAs9rrqV7AT9Tqcame9BMBcW4ApIp77OSIF/4jsmBWJylnu9p
         csaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYkZC+H0cclejhwnu9ybKgEGURqGTDULgNJyOMe/aZs=;
        b=U5v/YQ+hFf9FKcbHQd1dgrVu9O9BPAcuRDgsABk8g+K/ZghEg3J6ZojBVBNYfW0D5p
         tCjVXwCgRPv4yAeXikrLl7pO+8v2LJNHpF3Zv/XeW4eeOt2bUT3Ozw2nw2/hw8O2AxKH
         S53pBzHmteGKFcQSS3+fukiJcvL45Lz+BicaQhBf8nHtOkiFOk1qvfXkjzJObXzB75tU
         86XElJjfOgeT7AnCA14L9MT2CVAyQtnS8+sXgVQslmOcCegkzOjP4PqH77h1PSKhpWE0
         nZ8QY/J8We6tLrnPsr5Pmkh2LnB0vjx+SrkW4pAGWZU3Ia6emVbHsBlvllz1R0iohSvt
         b7Pg==
X-Gm-Message-State: ANhLgQ1mmynUcqTlQzSEYTWgxGKjxsWU3R3VhDBQIgzlHeUUPGoKcfow
        VVTxsJGZLlSH9LFJ+kXXYLBZmAtcML0C0lBYuul/2RXX
X-Google-Smtp-Source: ADFU+vumyIWWKcoN+ffBvEV/Func4aa1zUSwHnUK9EmvZwaPhmcivVqZOJ/95Vk7oLaIEuf0IM/h35yvLCdVyAU5ywM=
X-Received: by 2002:a92:811c:: with SMTP id e28mr69574ild.22.1583161156724;
 Mon, 02 Mar 2020 06:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-17-jinpuwang@gmail.com>
 <6aa73b1c-b47a-c239-f8bb-33a44a3c4d97@acm.org>
In-Reply-To: <6aa73b1c-b47a-c239-f8bb-33a44a3c4d97@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 15:59:06 +0100
Message-ID: <CAMGffEmSg_hdWjHSYREo4b_aESbwby_dTEMRVs6YBTbXSOEK5Q@mail.gmail.com>
Subject: Re: [PATCH v9 16/25] block/rnbd: client: private header with client
 structs and functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 1, 2020 at 3:26 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > This header describes main structs and functions used by rnbd-client
> > module, mainly for managing RNBD sessions and mapped block devices,
> > creating and destroying sysfs entries.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thanks Bart!
