Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4CCC2D0E8
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A4820658
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="VgI8wdrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgCaJWE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:22:04 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35832 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731167AbgCaJIN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:08:13 -0400
Received: by mail-il1-f195.google.com with SMTP id 7so18691080ill.2
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 02:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UaIPuaEHfGlz40ytsuyWF6/JgDLQ4j3rGwrQc8nNOeo=;
        b=VgI8wdrsaGL+NGbHkCzSH49Y7Kwn/7Zevnvommr9+aANVihZWB71+LWoaPFNqTywX4
         fzNNYwJwA8KL/YiHJ8e6pLEcDI83Zu+eRPks3DjLUSod1hLhMHeNYCghoCKGm/82p/q3
         TMdeni1Eje9vPwxNubuzs0iJ2EJwbwu4wydKoQPORrXbYXuUO9a7H1itq/G2DDxaYz/9
         34P59XZRP3vGO7sbSRBH9NjLTuNHDliG4HuU6BTGtXeU+rHifrsooS+1bsI1JkZI2R/h
         aEo6m5gu9vUIv1AZ0p2S5OKgZKGVRt7/Sr728HRocUIFGsDomDGbaB81opxaxl/WTEDB
         Vsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UaIPuaEHfGlz40ytsuyWF6/JgDLQ4j3rGwrQc8nNOeo=;
        b=fm2yN2jjIhbTLALqL54ddpmLM0vw/bDCTc1VJUsBiPv2vswLxSNyYd68PcSXnQBzAu
         g/2nbwkhqc6MWx1g4MIPJt0EBY5SwVkdfCzrOdv4nFsuLBo9kAXZI6PBY7eNEJUooU9K
         vwj6Ok+awrNFY0QmWWCufNsQQ5v37rU4n5nhIURZiVEvvvFqPRTcZmp5nOUlK/SKgxed
         QWa4cDt/z7erVo089itX4z4BLvylGUdRsMxuXTz5wxvouj8nOaTjKJUOsILdApi43mzP
         J6YEY0nzp2cbgSk81mOtsvSKVOkYcjSKw/aAXhUuazzAQKAK/S5YhhhEJDRbOdGbWGhO
         iRwA==
X-Gm-Message-State: ANhLgQ0oYAAX8TuVvweVpTZMEuLrcvEschvKUMHVmhYggS9ystBlzb+q
        HK10M7dVBfIQCNZUt4BgCVYcIzdB9Mxrm+sBH+vT1A==
X-Google-Smtp-Source: ADFU+vuyPdhOQ1fVl1caMfDVAEeg351dCzywDnnsXe4ufhInV7i/V2M30hJ5kR5TWkss0d7Qy48aaDlizNyc0+Qt2yI=
X-Received: by 2002:a92:8159:: with SMTP id e86mr14386435ild.60.1585645691918;
 Tue, 31 Mar 2020 02:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-18-jinpu.wang@cloud.ionos.com> <0b163be9-2cd6-248a-f9e7-a68e690aceb2@acm.org>
In-Reply-To: <0b163be9-2cd6-248a-f9e7-a68e690aceb2@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 11:08:01 +0200
Message-ID: <CAMGffEnmj52TfL=fDcvU_tgW=KpUqVWuCKeVwneU2W7Eo8sMGQ@mail.gmail.com>
Subject: Re: [PATCH v11 17/26] block/rnbd: client: private header with client
 structs and functions
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

On Sat, Mar 28, 2020 at 5:26 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +#define BMAX_SEGMENTS 29
> > +#define RECONNECT_DELAY 30
> > +#define MAX_RECONNECTS -1
>
> Please add a comment above each of these constants that explains the
> role of these constants. I can guess what the purpose of the last two
> constants is but not what the purpose of the first constant is.

Sure, will add comments for each of them.
Thanks!
