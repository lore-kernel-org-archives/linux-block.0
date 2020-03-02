Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE11C3F2D1
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 09:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEA0246BE
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 09:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="bjgepMjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgCBJVo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:21:44 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43676 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgCBJVo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 04:21:44 -0500
Received: by mail-io1-f65.google.com with SMTP id n21so10681615ioo.10
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 01:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEFkAcOGrFGZ9vC9gz7pgwP4iGIBCbBAbgqfhx1gxTw=;
        b=bjgepMjfTFKXiH1y1++pYmtaMgK1a0pm8g+Ft3bErJmRX5ndF/6c1HPBfqB7wtFxjY
         DHMWCTs/SdahAbFmr+r4WGKUqRK2cyniIbH2M63ygpdtoCxbQ2BsrkT/n6SSs7C6yidl
         glVje2Z6MqVA4pYo7ozPfH6s6Wab5g8Sk8iTFMQ+06NdrJ4ODeG/JpTN2/PbNEhl04zB
         2ufG1v660T3sJwb1KFARccsdBu6L5s6QKGya6JjWjFOCDCGejKBQCBacT+CW6xZRYhrM
         uNyNc09KXk+RfMP5vC9Y9ohoYS4QcNmOe0ihBiYvjXAiRFiDPORbEB772+kDOpE2wrMw
         LVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEFkAcOGrFGZ9vC9gz7pgwP4iGIBCbBAbgqfhx1gxTw=;
        b=KBVrmE93J7MNJ92HDZAUPxGZXnjxRkAow8t7L9JZpcPoYE7DHL/HGr2ZdZU1qocoAZ
         yRdqDGtx6PEPpBqBEq40PJpkXCAcbmYC39zaChdQYfiXSuAmjhZbK4g4BDFDOk4R/954
         iH5lzTDou/iiuTV+lRYjxX+wEgjIeDFzHNm3/7QZbO5Ip8huhA9/5k2dpEr20uBSSD7S
         ZxRuGME2tCLo8U5DQPNLq2TRnEwWb7eAom/NgfXJ1ZNfGigMwJuKcU7lWE9h/k9b89c3
         VMoDiN6cDfzsjNRBSmtAUNnlE9hd/lkrawmRA35lFuXc3p0cs3X5vAQPHhmHEhdHGl2W
         VwlA==
X-Gm-Message-State: APjAAAVfMwMtssnrcy/BAdngw/83nPSsYfsE4zCDC/lzAp9OuBS41xcy
        HIaemfjXy0rRKe6XI7Vqs9YCJqv2gsYOKztJVpmT+Q==
X-Google-Smtp-Source: APXvYqw3sGCat8h4DoLmpdadvgGUNsDTGZi83wNh/OG/n1D9udk1A3xJIq3u1cRwZ/fnRXsnHyS9RofYxs6lCYqbjeM=
X-Received: by 2002:a02:3b24:: with SMTP id c36mr13317752jaa.23.1583140904123;
 Mon, 02 Mar 2020 01:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-4-jinpuwang@gmail.com>
 <60d1b3e1-2da6-90ae-1e0b-1c313ffbd9b0@acm.org>
In-Reply-To: <60d1b3e1-2da6-90ae-1e0b-1c313ffbd9b0@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 10:21:33 +0100
Message-ID: <CAMGffEm5vueNV7jW8hTWT3SR2qgPTNuRZg7k3kDGu-KGAcLqKw@mail.gmail.com>
Subject: Re: [PATCH v9 03/25] RDMA/rtrs: private headers with rtrs protocol
 structs and helpers
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

On Sun, Mar 1, 2020 at 1:37 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:46, Jack Wang wrote:
> > +enum rtrs_imm_type {
> > +     RTRS_IO_REQ_IMM       = 0, /* client to server */
> > +     RTRS_IO_RSP_IMM       = 1, /* server to client */
> > +     RTRS_IO_RSP_W_INV_IMM = 2, /* server to client */
> > +
> > +     RTRS_HB_MSG_IMM = 8, /* HB: HeartBeat */
> > +     RTRS_HB_ACK_IMM = 9,
> > +
> > +     RTRS_LAST_IMM,
> > +};
>
> This is the first time in this header file that the abbreviation "hb" is
> used. Please add a comment that explains what this abbreviation stands for.
>
> Thanks,
>
> Bart.
Will do, thank you
