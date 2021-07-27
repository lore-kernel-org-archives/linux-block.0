Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748D6C4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 16:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD7261B73
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 16:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhG0QGL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 12:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229850AbhG0QGL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 12:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627401970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XdHI+sIfRw6QiUfn8IwVhCdtXFeYqXjq3borJurA1MY=;
        b=DiaD9B1caGFYu05ZxaaNt5qdnw+ypjSX317AnAKUe/W6QRlZjkOye8KY2oqdxs+AZTxKdU
        KSKHQY3Spqbk6E3jVnVdNCRkFWUvT9CElY5nB3FnkGzaWbaPQz9jUhdmw7MVCJ5vapm7qE
        a7zAifHKbQbaxhi4fWrG5XKS56rS8JQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-cCqEx5fwN92JcY7oLK7Rww-1; Tue, 27 Jul 2021 12:06:06 -0400
X-MC-Unique: cCqEx5fwN92JcY7oLK7Rww-1
Received: by mail-qv1-f70.google.com with SMTP id cb3-20020ad456230000b02903319321d1e3so2786735qvb.14
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 09:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XdHI+sIfRw6QiUfn8IwVhCdtXFeYqXjq3borJurA1MY=;
        b=eTqz0Z+CFYdjFDW10YkvnuBL90+ewt8HqbZHbWI2M76IpfDYn/yyKXm/5n1i7u6AW8
         8NAv5oHcHPrhX0wCdVkF0P8SFw0aY5IZUMf6hGkmIPiV0hsvWuWw5AH2MmGk59LOdOJ5
         g5RrfeZmPLqSZYxsh+qWvLiCZVnJkuYaZjtwzKdGKiFkeAUZ2meBEEPrqfbxD1QaRRBk
         cvvKC1j3ayGxzBQHMOe9F9iJ0ES5jJDvYgORkwTqTpe8vHSyp9t0XufE2txH/911Dc1p
         6zK2nQJisekc/ZMNkRrCsBBDdBQ2K2VBYP9of9HtTBP0E58TAVdI9TRkUfO6LwTXWmx4
         arxQ==
X-Gm-Message-State: AOAM532aAB7p87RFpOrMxFWd89awRQw742KNwzh9mbiupNWhGZLfS3Yn
        E5bMo1ZDmN1tGNcYIg8eM2a1xNP+9L+GtNLFcN+q0BDU7eVvOj5cd8IrJPkK30qhqTsHAs4hIzm
        yCqPJAa0gJYSgvRupZoCvlA==
X-Received: by 2002:ac8:5456:: with SMTP id d22mr20324265qtq.316.1627401966275;
        Tue, 27 Jul 2021 09:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAl6iKK0s39Zc7SHgMqBL7TW4R84gjyaLrNTceBegCY8asLYFYJh514nrrtknh3pNi7IYMIw==
X-Received: by 2002:ac8:5456:: with SMTP id d22mr20324250qtq.316.1627401966104;
        Tue, 27 Jul 2021 09:06:06 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d11sm1884722qki.40.2021.07.27.09.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:06:05 -0700 (PDT)
Date:   Tue, 27 Jul 2021 12:06:04 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/8] block: support delayed holder registration
Message-ID: <YQAu7KKyKnCm+tlf@redhat.com>
References: <20210725055458.29008-1-hch@lst.de>
 <20210725055458.29008-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725055458.29008-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 25 2021 at  1:54P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> device mapper needs to register holders before it is ready to do I/O.
> Currently it does so by registering the disk early, which has all kinds
> of bad side effects.  Support registering holders on an initialized but
> not registered disk instead by delaying the sysfs registration until the
> disk is registered.

This header starts to shine some light on what is motivating this
series by touching on "all kinds of bad side effects" being fixed.
Any chance you could elaborate what you've noticed/found/hit?

Mike

