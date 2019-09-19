Return-Path: <SRS0=Rcc/=XO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EC7C3A5A6
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 16:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA7621907
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 16:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jMp6N6eF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404248AbfISQV0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:21:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39406 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404246AbfISQV0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Sep 2019 12:21:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id i1so2638440pfa.6
        for <linux-block@vger.kernel.org>; Thu, 19 Sep 2019 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLElX6prsemmI7+wc0Ol+UL4D1Wa4vwan9SjKgoiFhY=;
        b=jMp6N6eFq6jQzuKpk6LGVgXz/S9TP47yGUWsOQsmv3xsq5S9u+jNmxuTo95dRVFNrQ
         94RsctbWhbXCRKVIDU4V3dNX1Lm7RBMmKwruC2/HH68wJByUsD8pMEuCwvoiw7TuSLcY
         mM44SSo5uSeSL1dqE9gscBIEMegZKliZ/hYgFPzjY4jRKUosd3wQy7ivwomcBJzLZjym
         1oH4z09PzqslgJ1Z1DUGOl2M0vYtFhQDfcfnrzyVkZfVHJGgvjrZDSYDuVSNkQ1IbC/R
         uCxN3R9nHOxvKTpgSuqdtFUbQZn2legL4RGJkoOlaQL0CyYazUdvXXuOTWCAdoubX35e
         0x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLElX6prsemmI7+wc0Ol+UL4D1Wa4vwan9SjKgoiFhY=;
        b=brTkgBWv8wVxia9judTwJZn4RPHF/og5RG9Tsahg8DAoyUo4J+KykgfgbSMdCGDSap
         K6qdTcIvsuqkEytSSvBnXXZx2+LgJ9pDcHFi0d+rrlTXXSAa3/6doAk+R8ezRN9a8618
         vraaysCZ0q+ZMwe1tNE3av8U1nIQvuhahEAEFt702uvyg6hbXrsDXu893ioA7FvCEOng
         O3234aHvefP7BtTI7AZ8YoLWGxHOBbxPV/CPZJJk85d3jlxYBVZ2VnV/GXxqOKbD0tOJ
         YzBaT4Eh3CtnPUQ+UtGtBWgAlZwI05P1kN8ZEgG9Fso7Qm7AscE/yERg8cvBtLMMcxJJ
         RxbA==
X-Gm-Message-State: APjAAAUo6G57g+EGgrwAOJjN80iHlviF596su6J1bc4isK9qOnK4Bf5Z
        im3UnwKXXiPJggNPmq7KbbpUx1rM79kAcCxIO7HXFw==
X-Google-Smtp-Source: APXvYqwUeNlfZfuENe5/I1lSuDmwkraJfDbpWXsOUMmBZl1XGtgiqQCtbZsFABCPk+AaGAlHey/MPAnIwBQkOh7YqN8=
X-Received: by 2002:a62:5fc1:: with SMTP id t184mr11250186pfb.84.1568910085164;
 Thu, 19 Sep 2019 09:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190919135725.1287963-1-arnd@arndb.de>
In-Reply-To: <20190919135725.1287963-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 19 Sep 2019 09:21:14 -0700
Message-ID: <CAKwvOdn=qYoBnsXrGh8KDaFzy6WEsfp1RhoZZQUHHL4OFzx88A@mail.gmail.com>
Subject: Re: [PATCH] block: t10-pi: fix -Wswitch warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>, kbuild-all@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 19, 2019 at 6:57 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Changing the switch() statement to symbolic constants made
> the compiler (at least clang-9, did not check gcc) notice that
> there is one enum value that is not handled here:
>
> block/t10-pi.c:62:11: error: enumeration value 'T10_PI_TYPE0_PROTECTION' not handled in switch [-Werror,-Wswitch]
>
> Add another case for the missing value and do nothing there
> based on the assumption that the code was working correctly
> already.
>
> Fixes: 9b2061b1a262 ("block: use symbolic constants for t10_pi type")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reported-by: kbuild test robot <lkp@intel.com>
https://groups.google.com/forum/#!topic/clang-built-linux/awgY7hmSCCM
Hard to say what's the right thing to do here, there's not a lot of
other switches on this variable.  That enum value barely even shows up
in the kernel.  Since this is no functional change:
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Thanks for sending the patch.

> ---
>  block/t10-pi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index 0c0120a672f9..055fac923946 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -60,6 +60,8 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
>                 __be16 csum;
>
>                 switch (type) {
> +               case T10_PI_TYPE0_PROTECTION:
> +                       break;
>                 case T10_PI_TYPE1_PROTECTION:
>                 case T10_PI_TYPE2_PROTECTION:
>                         if (pi->app_tag == T10_PI_APP_ESCAPE)
> --
-- 
Thanks,
~Nick Desaulniers
