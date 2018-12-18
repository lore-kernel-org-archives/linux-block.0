Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27DDC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 14:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACDC21850
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 14:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="Bsn8aaG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeLROya (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:54:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50303 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLROya (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 09:54:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so2974621wmd.0
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=S9ub2O24VypYiuTGi+N5MRdAiNepgjIABJM3SixMItY=;
        b=Bsn8aaG4rn0jZuFqsCIhrfA35Tq8VVsr/9Vmz/YNAcT8XDvmr63otOm73gJpGlm1Th
         3+kjSeS7Igw27zMXvCAU1fNZBO59fbS7gAC7N0xeHWwrxJgY9B5u6eBW8L1pKptlYbh4
         Ryrx7A9+pUxcmm73oqgcT7B1zHQPmFYerY2H2ryUsXAARsimUOYRrYMPHOHW82xxc5NU
         OGSWv2XXBQqglva0JMBKoFVI6/5tDFxdi+C4coVOy0q895L+43rXZEFSijzLjWnE/NfA
         aRjexfpeJL7pGvup1JNEH6bT2zVpLx3DrCChDqiqw6IGfZBFzWkAY7p8vgbBblcPFLoG
         4mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=S9ub2O24VypYiuTGi+N5MRdAiNepgjIABJM3SixMItY=;
        b=VHafTH4NwNgdYiLqeps1audLqgJSGKsLrCIQR6IwVy/h0KzY+zvCM0nLc7m+KdJBMV
         2i/qBJBetWN0IghgHGRb/CbaeJCn8MWIH/l1+d5UCDbqP+g3hvv6wCP7c5iUf4PKkK0n
         5wJL0N8Qh0jqbymzeqM+Cz2oxGTdfrmsHJBpEFqMnG0kMsb0GiI3XywH9i1C4aFvy/xY
         BU2oUGw5cKyKPd2BHr6hoImM//MaT+9y8fyqg8VOpumZAqK20KyxOTlazMK84kSuaxlU
         t5jfOhoHz1MQKja9f5oMMmz6uqK9e5s+MYQaRJmyevUgkFVIjvL2SUQZTLVxSelbt9vd
         RVzw==
X-Gm-Message-State: AA+aEWYdHLOslWDxz9bTAWiHFgbyWYVGsfxdMX0xB/BglhbCoGTDTHln
        +5yU2ftYaHZ2HxprvfA7LQdbKQ==
X-Google-Smtp-Source: AFSGD/VqwtN+PNgRA+TvQ9Qi1wEV75YP0ouc0jeOO28fJ0ceY+xlq1FtZhlHL4/aL/8oV2rTNZGkow==
X-Received: by 2002:a1c:38c4:: with SMTP id f187mr3418674wma.90.1545144867718;
        Tue, 18 Dec 2018 06:54:27 -0800 (PST)
Received: from t1.scylladb.com (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id e27sm3237351wra.67.2018.12.18.06.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 06:54:26 -0800 (PST)
Message-ID: <adc0369578db4f119e48ef2367b46192704c1214.camel@scylladb.com>
Subject: Re: [PATCH 14/26] aio: support for IO polling
From:   Benny Halevy <bhalevy@scylladb.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
Date:   Tue, 18 Dec 2018 16:54:24 +0200
In-Reply-To: <7e207359-6ee2-bce2-3c17-be328a965333@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
         <20181213175645.22181-15-axboe@kernel.dk>
         <d0ad25816ccc6fcb388b34f5e0d42ea9105c9097.camel@scylladb.com>
         <7e207359-6ee2-bce2-3c17-be328a965333@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-12-18 at 06:27 -0700, Jens Axboe wrote:
> On 12/18/18 3:32 AM, Benny Halevy wrote:
> > On Thu, 2018-12-13 at 10:56 -0700, Jens Axboe wrote:
> > > Add polled variants of PREAD/PREADV and PWRITE/PWRITEV. These act
> > > like their non-polled counterparts, except we expect to poll for
> > > completion of them. The polling happens at io_getevent() time, and
> > > works just like non-polled IO.
> > > 
> > > To setup an io_context for polled IO, the application must call
> > > io_setup2() with IOCTX_FLAG_IOPOLL as one of the flags. It is illegal
> > > to mix and match polled and non-polled IO on an io_context.
> > > 
> > > Polled IO doesn't support the user mapped completion ring. Events
> > > must be reaped through the io_getevents() system call. For non-irq
> > > driven poll devices, there's no way to support completion reaping
> > > from userspace by just looking at the ring. The application itself
> > > is the one that pulls completion entries.
> > > 
> > > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > > 
> > 
> > Looks good to me, thanks.
> 
> Is that a reviewed-by?
> 

Yes.

Reviewed-by: Benny Halevy <bhalevy@scylladb.com>


