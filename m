Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA74C4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 22:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJRWZz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 18:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJRWZy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 18:25:54 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1434E6525A
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 15:25:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l28so10635960qtv.4
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B1l2vnLm/0Lgbz9B99VIiD/UIQurnKKZZ/zYmbgiPeE=;
        b=fF6/MhXtl3eCSM9IYaDnpI7DvaFv4M2bUcMTQQt0UHPhLtRyxcNGBwPux53aUWWCJu
         q8ZwsNdUj1/C6sNEe2MAUCRE6qGTv9fP/GadcQPpuf9eBMYFWDCRuYz26jBoGsMfTgFn
         XHC2MuLRAMl2Hw4yVNwzxGXtS1EGrstSJ3/QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1l2vnLm/0Lgbz9B99VIiD/UIQurnKKZZ/zYmbgiPeE=;
        b=XTt24upWzNPSN3edYRdP141YwcIdflXLM0B5AOXbtZwMcwtiBK17PHtXyDyPD3W4u0
         tB2qJ8/9JhjapgFFrow2oV6R8Ib9olqDtlhpgGbn1nexgVCDeVxC1WUFAWBLcZxTox4A
         7j8t/MJI9ID2zDdeGYs0IIHQxRj0s18rcVZJjGfJ3pBdKgS0H5CGKvDOBZrIaGJsP714
         gGX4vNZVCDN0rxcxvK0cbX2rkjJZKX7HGQ7/re2BEJG8udgl1mUQF+oD9V6LKUIr2aBk
         btQ22Ix1tDJ0ByKMpebw6Tyd5WPkludcPfcLBJUzS5isCk3O8tT0RxL69s6uqJMHRcXe
         HOKA==
X-Gm-Message-State: ACrzQf0cVZsrBSa0t4fUPDzKunZNNaL0BVT2Or6tQVGH57JFMkpi3/O5
        jSnZFe6w5V0oC9Qg837Z9AkR9WN4B+LsTw==
X-Google-Smtp-Source: AMsMyM77J9MgX5G29TKHIYA3ypqSkXGMr3kg9fKj6rBk4d1CF0bMkxSjkb+QTNad2uj3wUOBhgQ9oQ==
X-Received: by 2002:a05:622a:1651:b0:38f:2829:a1fe with SMTP id y17-20020a05622a165100b0038f2829a1femr4092209qtj.173.1666131951885;
        Tue, 18 Oct 2022 15:25:51 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id ch8-20020a05622a40c800b0039cc82a319asm2694743qtb.76.2022.10.18.15.25.51
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 15:25:51 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-360871745b0so151216347b3.3
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 15:25:51 -0700 (PDT)
X-Received: by 2002:a81:2544:0:b0:360:c270:15a1 with SMTP id
 l65-20020a812544000000b00360c27015a1mr4162300ywl.67.1666131513519; Tue, 18
 Oct 2022 15:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <Y07SYs98z5VNxdZq@redhat.com> <Y07twbDIVgEnPsFn@infradead.org>
 <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
 <CAHk-=wiE_p66JtpfsM2GMk0ctuLcP+HBuNOEnpZRY0Ees8oFXw@mail.gmail.com>
 <Y08W5Tj1YC8/BZDM@redhat.com> <b9608b92-fab8-93a0-2821-80a49c3328eb@gmail.com>
In-Reply-To: <b9608b92-fab8-93a0-2821-80a49c3328eb@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Oct 2022 15:18:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wje72wCLtizgPoae=yZf-n0p9dbZe+gxFqa3Cu=i6Bk6w@mail.gmail.com>
Message-ID: <CAHk-=wje72wCLtizgPoae=yZf-n0p9dbZe+gxFqa3Cu=i6Bk6w@mail.gmail.com>
Subject: Re: [git pull] device mapper changes for 6.1
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Alasdair G Kergon <agk@redhat.com>,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 3:11 PM Milan Broz <gmazyland@gmail.com> wrote:
>
> The problem is that ioctl() are often just translated to -EINVAL.

Oh, that's absolutely a real problem.

Don't use one single error number.

           Linus
