Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8120C77B75
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 16:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjESQW6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 12:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjESQWw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 12:22:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2CA10D2
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 09:22:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51144dddd4cso1307945a12.1
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684513361; x=1687105361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kK1ZTkygyrBiweN68dKEUcpOojpjbump5mMSvci/Nuk=;
        b=O1ry9Qs17DnpstX9SnQyPz37GUS8m7sJbF3M4QmL3o/8nTwdBkJYrSXOZtU4foiTZs
         CIlEHqqBaL4/CafCnMR4s12l0bPpwO7KJiNvPh83XRtsDgl8bnP/RZ3c93A2ZTYHOfY0
         bmL9cCqczCBR1hTCZXzi78fOb2aNxHvfaJJeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684513361; x=1687105361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kK1ZTkygyrBiweN68dKEUcpOojpjbump5mMSvci/Nuk=;
        b=MVuNSISn1J2AHTSdUSf26o+okK1DfppuO+pDo6CD84n0XNL44o1ZACbyX/ZISIKyr5
         JuzmgYXs680xntYixemycsc1+chTnWhHTxHjIB1/4UqSZozmnXqZgUmnohf7Dj72VY+r
         dVL5Slc55yk3pHes+f9h0KwniryUwMD5I/ujq1/GRlROny7i6flPRdeOoOW7hLd1UH6+
         m0VbsKLvFSiz3UxedRjcHG9DSdfrET3pvihBm7uexI4WeDUU4nZhG2dLQi6pn9K9xkPC
         1XlGJYChqOypeEWKhpbXiRMgVAUmMAU5nagLcaUBgaJ4xO3n/yyqJfc3DrfMCHCmaqdE
         efVQ==
X-Gm-Message-State: AC+VfDzIEdF3qbOKR4tDp/+bJmT9SPJAkz+2CMSM5bjDCsrtEiJEZgKr
        VhKCKgs/US6EWnkvjt7A2NR0Ly6WhVNfZlt2Pi8/TzcK
X-Google-Smtp-Source: ACHHUZ6fpdFQMBQqPR/Ir18Mp1e5gxO834HeL7Ty6ipMwPW0a7A6OxsiSefC01Cj+oQZxq5Uo0KkVw==
X-Received: by 2002:a17:907:2ce1:b0:961:800b:3f57 with SMTP id hz1-20020a1709072ce100b00961800b3f57mr2294589ejc.77.1684513361460;
        Fri, 19 May 2023 09:22:41 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id s23-20020a1709066c9700b0094f4d2d81d9sm2448223ejr.94.2023.05.19.09.22.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:22:40 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-510db954476so4232617a12.0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 09:22:39 -0700 (PDT)
X-Received: by 2002:a05:6402:2d5:b0:510:f6e0:7d9f with SMTP id
 b21-20020a05640202d500b00510f6e07d9fmr2254674edx.13.1684513359285; Fri, 19
 May 2023 09:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-10-dhowells@redhat.com>
 <ZGcvfLWAqmOLrnLj@infradead.org>
In-Reply-To: <ZGcvfLWAqmOLrnLj@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 09:22:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzSLXt38J_B2=QWCDi7A1c5B0_cJ3XYRj9rYn+YXbjQA@mail.gmail.com>
Message-ID: <CAHk-=wgzSLXt38J_B2=QWCDi7A1c5B0_cJ3XYRj9rYn+YXbjQA@mail.gmail.com>
Subject: Re: [PATCH v20 09/32] tty, proc, kernfs, random: Use direct_splice_read()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 19, 2023 at 1:12=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> Pinging Al (and maybe Linus): is there any good reason to not simply
> default to direct_splice_read if ->read_iter is implemented and
> ->splice_read is not once you remove ITER_PIPE?

For me, the reason isn't so much technical as "historical pain".

We've had *so* many problems with splice on random file descriptors
that I at some point decided "no splice by default".

Now, admittedly most of the problems were due to the whole set_fs()
ambiguity, which you fixed and no longer exists. So maybe we could go
back to "implement splice by default".

I agree that as long as the default implementation is obviously safe,
it should be ok, and maybe direct_splice_read is that obvious..

           Linus
