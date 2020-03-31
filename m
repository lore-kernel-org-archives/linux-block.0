Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB95FC2D0E8
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E1B20658
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="EPjPT9Ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgCaJ0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:26:53 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35987 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730031AbgCaJ0x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:26:53 -0400
Received: by mail-il1-f195.google.com with SMTP id p13so18704335ilp.3
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 02:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/CZCEVvaP4QJeKyBrdCxhzKGyfAnZN+S5sG3wKAL0Us=;
        b=EPjPT9Ix9refc520tdJ/5pB07YINSgYm5Jlflz9wN770In+vG2bIMqrSCz3gK9yrFw
         Cswj/woPaOY3NE1eS5piZ9pXE+0pKTO/LQ2pusHhAdvSgIMw2JA9wxXlfxvw6sqZHjcy
         MsrhUTZkFcH5B1Fr9YYfBdckXahcS8yjM/bW/jcz5/00kOSZVN8jVDbgNQqm4T7KJpOy
         Tb8WF9GbfAK9/pvKCje6XziAdIEl9iUovbngkwsxJ7OR0R3oyQ2HDG/aZVnz0g3AyKRu
         RZIZL9mOQZt/j5/ehmEUeEDUp7ddV9KtdyQyd9MJNiIRfNmzNt4s3asDcBVlMIZQTCDG
         rd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CZCEVvaP4QJeKyBrdCxhzKGyfAnZN+S5sG3wKAL0Us=;
        b=CHWZdbxzogeGCrYHgJ/IgHX172694iqWVblHjIvUjGMdVWcOXM2yPY/+rIgO9iRRgy
         B8N7AT7uIwDExMfY8F320LDwQ3xT3NZ9uDgGkAt8d9Vc4uhdVAz5fiDIrjPFomI8hoqa
         T2yvoekYzuxnYhBDFXjZEEMg1h1mfO0e6uK+yA1mhh9wRTmLtdP/7EVrYYPHwTUji/cp
         5hegvB9slaGF5Q5J8pZ/fmq2y+h4x+6d9X5MqjlrCma/GO/Ge9yxV59srgufFiCau14F
         gPKPpjIeaZX6ocQgeeY5uZliU7Dsu0pXA9uYz9gcbwegO64JPaqmHH6gV2z6oxhKF0Tc
         dBig==
X-Gm-Message-State: ANhLgQ0P0584bTe9V8c4UT3yHHiIaqJZTX9Klc78ExpDTtQb0tNtsduR
        3GAjNV6qqc0GvbxmikyxYgWy7S78Nq+iIKZv8QVqHg==
X-Google-Smtp-Source: ADFU+vsLHRoHdX+k4k1F6t37d2n0/vx2+CGoLKmML6U+/PPZhjMj0kJqDw0LRcyqsY58pIEWI6wQbp8yYvyclm2kz98=
X-Received: by 2002:a92:ba01:: with SMTP id o1mr15056961ili.217.1585646810616;
 Tue, 31 Mar 2020 02:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-20-jinpu.wang@cloud.ionos.com> <5c710388-c40e-4336-d1d8-b50d4ed3ca85@acm.org>
In-Reply-To: <5c710388-c40e-4336-d1d8-b50d4ed3ca85@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 11:26:39 +0200
Message-ID: <CAMGffEnjxB1NK-c=G9298U_VD1r9DhBQCDqvD8TozTRTXXuP4g@mail.gmail.com>
Subject: Re: [PATCH v11 19/26] block/rnbd: client: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
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

On Sat, Mar 28, 2020 at 6:00 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +                     ret = rtrs_addr_to_sockaddr(p, strlen(p), RTRS_PORT,
> > +                                                  &opt->paths[p_cnt]);
>
> Same question here: has the server port number been hardcoded here?
Yeah, as answered in another email, we will introduce a module
parameter for rnbd-clt for port_nr.
>
> Thanks,
>
> Bart.
Thanks Bart!
