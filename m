Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE51C433B4
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 14:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE5961452
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 14:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbhDVOX1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 10:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236544AbhDVOX1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 10:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619101372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6dM3vlskxaUCVoSymQo+tBQHrfX2GxQW1OumkU4YCLc=;
        b=T/uRWiCCWfNIfjLys+2U9m9zx7WjTSK6ZSAxglHt+VXNUEbtcLjdRG8Q7p+gDqKlBE2wP3
        WuMvCFeQqCgvDBtgpa/W+e9nB7WyYXZK+017NMzX5m5+4Bq90xzecjelD/pZgQz1IugXO+
        DzCp93Wrli7njCBcrb7sD7hCNUbVzS0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-No-8rLYuPaa0dql6MXSfkA-1; Thu, 22 Apr 2021 10:22:49 -0400
X-MC-Unique: No-8rLYuPaa0dql6MXSfkA-1
Received: by mail-ed1-f71.google.com with SMTP id y10-20020a50f1ca0000b0290382d654f75eso16835095edl.1
        for <linux-block@vger.kernel.org>; Thu, 22 Apr 2021 07:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6dM3vlskxaUCVoSymQo+tBQHrfX2GxQW1OumkU4YCLc=;
        b=D76X3sv0VeJXie46+SnyFcApiq3H/dZ3CjsS8nKEb5/mMTf3WXsir/91IdBrukyTnI
         vUsjcvmPMkppCtcOjRiRUa5Qxwcj4+qp6C9QhhJHr13EqkUJs5ksCtUO3v2km0TRrtrz
         uRFn5XGfYRc7fuYoMhdI8cGyxyYdz4KkB1i35IKXPvPGjZ6zCGvVmAEGu8b2/iazsHmy
         u1NXdc+LMIpucMMSCLinCXMQrj4nMfjTo1kbm9P2LAAMUOKOKBx05AZ2dcfPlCtRm+hY
         VwH2JlaFz82qrLujPlPAqqbjF3HgaDH1NIRSbX5ZIymHbxzMNYF2GDT1niZU0ag+pRt0
         D+LA==
X-Gm-Message-State: AOAM531c86uyziVHm9YvVcmGfd7pmbjvptZq5o/5zUDNmdnZa7M1m6u8
        hvYrAVcJ1jxMAGR5G0G331GgN+rduHrSqmQg8ccn/qfUOGQpqjRUvCqUgzEIkdsmLG4oiTMoZ2Y
        GUKMGVaqtLzrEUVMj/e4/OCc=
X-Received: by 2002:a17:906:60d6:: with SMTP id f22mr3627823ejk.177.1619101368048;
        Thu, 22 Apr 2021 07:22:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg6IpTdebpcD59morQGAl2NDtrxuofK+0xAYW+6pVHquUotCJVra+jBhH6twGEGfu7JKrqBg==
X-Received: by 2002:a17:906:60d6:: with SMTP id f22mr3627797ejk.177.1619101367853;
        Thu, 22 Apr 2021 07:22:47 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id ws15sm1985849ejb.38.2021.04.22.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 07:22:47 -0700 (PDT)
Date:   Thu, 22 Apr 2021 16:22:45 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, libc-alpha@sourceware.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH liburing] examples/ucontext-cp.c: cope with variable
 SIGSTKSZ
Message-ID: <20210422142245.evlxjvfw3emh7ivw@steredhat>
References: <20210413150319.764600-1-stefanha@redhat.com>
 <YH2VE2RdcH0ISvxH@stefanha-x1.localdomain>
 <CAMe9rOpK08CJ5TdQ1fZJ2sGUVjHqoTHS2kT8EzDEejuodu8Ksg@mail.gmail.com>
 <YIFJDgno7deI5syK@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YIFJDgno7deI5syK@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+Cc: io-uring@vger.kernel.org
+Cc: Pavel Begunkov <asml.silence@gmail.com>

Original message: 
https://www.spinics.net/lists/linux-block/msg67077.html

On Thu, Apr 22, 2021 at 10:59:42AM +0100, Stefan Hajnoczi wrote:
>On Mon, Apr 19, 2021 at 11:38:07AM -0700, H.J. Lu wrote:
>> On Mon, Apr 19, 2021 at 7:35 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> >
>> > On Tue, Apr 13, 2021 at 04:03:19PM +0100, Stefan Hajnoczi wrote:
>> > > The size of C arrays at file scope must be constant. The following
>> > > compiler error occurs with recent upstream glibc (2.33.9000):
>> > >
>> > >   CC ucontext-cp
>> > >   ucontext-cp.c:31:23: error: variably modified ‘stack_buf’ at file scope
>> > >   31 |         unsigned char stack_buf[SIGSTKSZ];
>> > >      |                       ^~~~~~~~~
>> > >   make[1]: *** [Makefile:26: ucontext-cp] Error 1
>> > >
>> > > The following glibc commit changed SIGSTKSZ from a constant value to a
>> > > variable:
>> > >
>> > >   commit 6c57d320484988e87e446e2e60ce42816bf51d53
>> > >   Author: H.J. Lu <hjl.tools@gmail.com>
>> > >   Date:   Mon Feb 1 11:00:38 2021 -0800
>> > >
>> > >     sysconf: Add _SC_MINSIGSTKSZ/_SC_SIGSTKSZ [BZ #20305]
>> > >   ...
>> > >   +# define SIGSTKSZ sysconf (_SC_SIGSTKSZ)
>> > >
>> > > Allocate the stack buffer explicitly to avoid declaring an array at file
>> > > scope.
>> > >
>> > > Cc: H.J. Lu <hjl.tools@gmail.com>
>> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > > ---
>> > > Perhaps the glibc change needs to be revised before releasing glibc 2.34
>> > > since it might break applications. That's up to the glibc folks. It
>> > > doesn't hurt for liburing to take a safer approach that copes with the
>> > > SIGSTKSZ change in any case.
>> >
>> > glibc folks, please take a look. The commit referenced above broke
>> > compilation of liburing's tests. It's possible that applications will
>> > hit similar issues. Can you check whether the SIGSTKSZ change needs to
>> > be reverted/fixed before releasing glibc 2.34?
>> >
>>
>> It won't be changed for glibc 2.34.
>
>Thanks for the response, H.J. and Paul.
>
>In that case liburing needs this patch.
>

I think so:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

