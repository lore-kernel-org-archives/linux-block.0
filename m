Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88F9C3F68F
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 17:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2672173E
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 17:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfLLRWS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:22:18 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:58995 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbfLLRWS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 12:22:18 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mj8eD-1i3LX32Hp7-00fE1F; Thu, 12 Dec 2019 18:22:16 +0100
Received: by mail-qk1-f170.google.com with SMTP id w127so2219464qkb.11;
        Thu, 12 Dec 2019 09:22:16 -0800 (PST)
X-Gm-Message-State: APjAAAV3JJfgqfCWg55UnQ4BYdJLe4Y7djylzfe0312Fm5kJuSQb2+vU
        EomzlytEcYFXwuk/UKdSUAHizRE4NTV7OZE/n4Y=
X-Google-Smtp-Source: APXvYqz76ALLRIJrqi+qSs7WB11jyOhj3HEjIAoyxGME6zc4jj521Lx7pQv8mFjzWan8um1MNJW2peDA5RFrLV5hGTA=
X-Received: by 2002:a37:84a:: with SMTP id 71mr8936277qki.138.1576171335225;
 Thu, 12 Dec 2019 09:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20191211204306.1207817-1-arnd@arndb.de> <20191211204306.1207817-21-arnd@arndb.de>
 <20191212162947.GC27991@infradead.org>
In-Reply-To: <20191212162947.GC27991@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Dec 2019 18:21:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a26-6ttEdcnJQX2PtCcY_PPDV1UFK8CTogd7uDOm3iu9w@mail.gmail.com>
Message-ID: <CAK8P3a26-6ttEdcnJQX2PtCcY_PPDV1UFK8CTogd7uDOm3iu9w@mail.gmail.com>
Subject: Re: [PATCH 20/24] compat_ioctl: move HDIO ioctl handling into drivers/ide
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Hannes Reinecke <hare@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:D7jHZfHVOQ7tAIyJwnkf58cg53tIgVu/C17Q6iZNRGfT3olvpS5
 VkwOgmnp7/GbbfpknbF9wc+dxx2kVxKfCrlR8pPVyxHhJ/C4COjkXg+zjsJVff6jkxhD1Oi
 Q6yOj0XGzOlpLOL7KrzOIp+oOQwJzT1Z3ZhnGy5c7gNa4oXuD8CmWB8xIVMSI/rfgVjqSMs
 p5XMLwAgW8K4MbmjCYcIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FU1A32JE3M4=:aYSHuAm6vjlM6cxi7EHjV+
 HPpc5PxdE0EWflUOE3+3Jiukcq36kzIyZ9ilVdYgDh0tp1p298UqNhpjRJGuWVG82D1543cwD
 IvqC5Hf0mI2tQ6ntUGILMqaDPIox+ssjChH7ug3YTOQiL9SQWeFRmW4Fyy7ct0AhtrQig5nny
 AgHqQ5aM9d57bTiO3TUrqLEAJAAFH2wGb25f7cz8VW0gXW+paGBR/MDMHB1tJs7DrKA04ZVp8
 HwoX2RLA9YtAo3Zmq3H43rQzZ4TPPHv6xFv2p9z/Ufyvo9bmGqeKyksWBlKjf2m5YTGH9wn89
 liMMJzHrq5K8ZHiFBY8JJXG2wNeoXcHjpsA77DefhgadbF2eBSTXggvxGIY4uyZRNbr7UZjOh
 TfUxF+vsf1KDuedgSEYByWnQ8gKz5ofJXNG2Zm6m3MoMhygxidrGvb2Hpaj+4TBTRBPDcfcsj
 3Q2n8DtaWo8Gh0zAtUhRBcSyI784D/j8taVKuDVbpsv/dljjym11vMKKukU9dX7axlpu80krn
 exIRhuXIUhHeYIFZNTKbaQ1LDz9kuhY05nE3Fpx7Wv4c1knRcNnvrhPjJ7vZIhoWlR9x6KAw+
 wa8znN9ZPNnO5XsEc0Gddh3MyhR6W3KjgdMKjUOM/R7kxq9EQ4Qj/u64ZHbji3lvLoiCeWbdm
 +Qk2DuUDoJGlgg2g936llFiE5kJWr0jvT8fGhZ56TWsGEqkfC6LT3dsmDpGShMCmsrAPuR3AF
 seuNajI82RFFWX1fqJcsEaL7o3gOiJkAX/BHC6rPRRMBmjTRjwUpXj6YQwX7fG/UYNgUoQYkh
 6skkPp6ZmW1AHXrf8z6LY59JqRSWY1OZ8nNr8lg7+4cH+Fk/6KrooRg7YBzMVQ6YAGioiYKmT
 gZAZld80yuJIv1ImIHpA==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 12, 2019 at 5:29 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +static int put_user_long(long val, unsigned long arg)
> > +{
> > +#ifdef CONFIG_COMPAT
> > +     if (in_compat_syscall())
> > +             return put_user(val, (compat_long_t __user *)compat_ptr(arg));
> > +#endif
> > +     return put_user(val, (long __user *)arg);
> > +}
>
> We had this
>
> #ifdef CONFIG_COMPAT
>         if (in_compat_syscall())
>                 ...
>         ...
> #endif
>
> patter quite frequently.  Can we define a in_compat_syscall stub
> and make sure compat_ptr and the compat_* types are available available
> to clean this up a bit?

in_compat_syscall() already has a reasonable stub, what was missing
when I created this series is the compat_long_t definition and
the compat_ptr() helper.

With patch 01/24, we can rely on the types, but I still need to add
a generic compat_ptr() implementation for non-s390 to remove the
#ifdef here.

That is probably a good idea anyway, it just needs a bit of testing.
The last time I tried this, I ran into problems with the order of compat
header inclusions on some architectures.

I've made a prototype now, will see how it goes.

> > -     if (NULL == (void *) arg) {
> > +     if (NULL == argp) {
>
>         if (!argp) {
>
> ?

changed now.

      Arnd
