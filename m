Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502FDC10F0E
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 14:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC583213F2
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 14:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara-com.20150623.gappssmtp.com header.i=@zadara-com.20150623.gappssmtp.com header.b="jAasWdzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfDGOf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 10:35:57 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52862 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDGOf5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 10:35:57 -0400
Received: by mail-it1-f193.google.com with SMTP id x132so6502845itf.2
        for <linux-block@vger.kernel.org>; Sun, 07 Apr 2019 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0u7rYQrmAYIj8QEeaWLOwCqlebJAE+qHNgD9ZLTtzY=;
        b=jAasWdzZ6eGi9IzNBCkP90ElL76oKBlUhkbpLP16UZ8QtlBcudmNqfeuz5YcvLNEKt
         C+aP61ykVR+6eGQu/A7e1u1i7DV+zd9slVXbzDpq4sP4dDEiL0xZI13o257CUpn5G9jQ
         0NNHobOpU4r0LjRG7bMy5c5qDkKIx969u8QIMM1KbBXQpB6nXthdnBg3IdsF0w3RdLQQ
         EShpiFBNY7UKnhYNDSwhpL+ioxanUBfEsWMtQKZ58CjwaKv9KCpuSAg9kJ4RbPSo8XuC
         1HBZdMi53Co4seF8F1H2rX7O1Kg/iu/WzxfwGn0hqsikwAKH78lmgWLSxxF7GqJKJpWr
         jixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0u7rYQrmAYIj8QEeaWLOwCqlebJAE+qHNgD9ZLTtzY=;
        b=BU7vwHZ3aIMqiE8h2FEoXJUn/JxJmIYgIlIdv9zSuLqn80tBiWveQ3uKn7lN0BOL9w
         99kWCrK/8iNk9lPNx4tomKDE1n8ObKZcA1cpmL2YTCovSi0Bl6Kw8Ylz+BkrcV3gZGqL
         rqOlo6phMe7ic042A9hZd3ifHtFS0B45OcE8y1B/vYTwOX9jjiYqaKQ+G0fuwPgvqxxW
         60oyVMieZxNywmL++HUZd9Oo/WGDf41pAIt1H4oAoxdZrJHIiiLdZaTI0iQMI2tIowz2
         cJvvR/Vfoqkj8IC5IUmBBomlAX+AM9aDwW2LGiXpPEZ6tqH5Y28gSa02jgluwBb84xoi
         HkUQ==
X-Gm-Message-State: APjAAAUoRGsVYBJPyvGPw2BdydYO55IgusVYvXJh8einpotHq+cXWZ8s
        LOK/KJ5F/KgGG2KMOA3MDSHZf25JfVN1NqmBE6fL3CCscnU=
X-Google-Smtp-Source: APXvYqyJl3JfjFd7gHt9qmNjgJFoKu+kF7kbedcEYMI/VCX4KZumSkeryp4ZDwyoJbKZMwCCkmecK5Tp+F99ibs7AdE=
X-Received: by 2002:a24:3d4a:: with SMTP id n71mr17368434itn.55.1554647756484;
 Sun, 07 Apr 2019 07:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <1554555800-14392-1-git-send-email-alex@zadara.com>
 <ae3ac0dc-92ef-36f9-ff0d-ef41e6deacb1@kernel.dk> <20190407075651.GA23397@infradead.org>
In-Reply-To: <20190407075651.GA23397@infradead.org>
From:   Alex Lyakas <alex@zadara.com>
Date:   Sun, 7 Apr 2019 17:35:45 +0300
Message-ID: <CAOcd+r3djpt1=ewD+QA0KsJ5woFb2G6T_9TAUCha=MtR8TyDww@mail.gmail.com>
Subject: Re: [PATCH] block: preserve BIO_REFFED flag in bio_reset()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

I understand and agree with your concern.

Looking at the code, bi_flags is 16-bits wide, and only top 3 bits are
preserved by bio_reset(). These bits are used to indicate a bvec pool.
So we don't have any free bits to move the BIO_REFFED to. Unless we
make bi_flags wider.

Bottom line, now if somebody calls bio_get() and then bio_reset(),
then on next bio_put() bio will be freed immediately. But this is
wrong, because eventually another bio_put() will be done, and this
will result in double-free and kernel memory corruption.

For example, bio_map_user_iov() performs an additional bio_get()
before returning. If somebody calls bio_reset() in-between, then
bio_unmap_user() will do double-free.

So in general, I think this issue needs to be taken care of, even if
not the way I suggested.

Thanks,
Alex.



On Sun, Apr 7, 2019 at 10:56 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Apr 06, 2019 at 12:58:54PM -0600, Jens Axboe wrote:
> > On 4/6/19 7:03 AM, Alex Lyakas wrote:
> > > Commit dac56212e8127dbc0bff7be35c508bc280213309 titled
> > > "bio: skip atomic inc/dec of ->bi_cnt for most use cases"
> > > made __bi_cnt dependent on the new BIO_REFFED flag.
> > >
> > > bio_reset() does not reset __bi_cnt, but it does reset the BIO_REFFED flag.
> > > But __bi_cnt depends now on the BIO_REFFED flag, so bio_reset()
> > > needs to preserve this flag.
> >
> > Looks good to me, applied, thanks.
>
> Uh-oh.  While this fix isn't wrong per se I think it is confusing and
> set a dnagerous precedence.
>
> We have BIO_RESET_BITS to indicate which flags survive.  So any flag
> that is supposed to survive the reset should be be added to that
> instead of specifically worked around.
