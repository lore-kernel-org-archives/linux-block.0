Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072FDC77B7C
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 07:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbjEKHIp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 03:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbjEKHIS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 03:08:18 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA5F8A40
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 00:08:16 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9a6869dd3cso10628875276.2
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 00:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683788894; x=1686380894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd2Syo+tVpihK8x27Jr794LU7OeVE0LYf+cWSGjQc8g=;
        b=vrj4hl/lhoBuSWgjbMshRCXfTHtJg3MF2aUz+PoH9H2IUOKo//2sodrSswsh9PgElz
         k/ZV8RY8L2/0mC+pxxreC3H5FedwjdCAjz4NegItqTjXJOVOJ79NN9zH2JLwZuaMnEwj
         2Mx/OBbQP9+x4dbJYe13nZmix1+mwAIv2KcG/p+xwYOf3wJhe8KNUSVU9AvOA7ILK0xN
         pUk4Q5gSgzfVVTPW7Nl4ozBBonD/bdUx7amLI6peMfC+45gvuxs+iBkLI2C6fvtl7VgM
         a+rUsEYtGmcDgrt1E2ZX7b1IO0yOIoJfnRa0PGl5XsocRdhfX+X/xh5ZbUBbfNZimd0O
         HIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788894; x=1686380894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gd2Syo+tVpihK8x27Jr794LU7OeVE0LYf+cWSGjQc8g=;
        b=kPGVwFEEH0pRn4FzWyyoqSFABcQ93MdeqNQ/FUuIrbVUspranhMiwA9Wjr/G8trxAU
         FiGaUGPWz4Vz//SSN52DgA+B7qsmvzndUmLC0jYbY3zWt7SzEmNcWm7V/cITtMNKeiAK
         oH9NHf5ovxQKpS0XxR4eSpg63hf/Y6nTbGmOLpK1ByNL73CtZ8Ywt4l0sUsShKlrzM4x
         8TyYafIUOqEwQ8OD6A3NNLwJd5ytPRN5nn+/7kXULAXGdzbt02Wq8jmy2jmpllu0B3ID
         zET1r/CN1Ql289qZKK90jJymYYtFkehR5keIzb/KcvrzfOysl/TN7G4+eLh43GR2x31l
         rJ2g==
X-Gm-Message-State: AC+VfDwNbD81KUWi+rXx/P/0za3PjW95vo8vcXDJzIK5YNATPK1aMjG3
        f/iHVn5vmc7hvgGtRvGFm11EQaM5ud1/mzUFNMhZ4A==
X-Google-Smtp-Source: ACHHUZ523bCQ2OW57uRgdP7bxIwgDuG/kGUulFCOWPqUQW1m6uKz4aSIzYRS0P8MGrgM0MkmCsbidaTue+2MS61X5TM=
X-Received: by 2002:a25:d74b:0:b0:ba6:954c:870a with SMTP id
 o72-20020a25d74b000000b00ba6954c870amr1564268ybg.17.1683788894289; Thu, 11
 May 2023 00:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a294db05fb6584a4@google.com>
In-Reply-To: <000000000000a294db05fb6584a4@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 11 May 2023 09:07:38 +0200
Message-ID: <CAG_fn=W2C0oX9LZ9=QJPr2GxorCwt1kW3sHNJkypF6aKpAYp9Q@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: KMSAN: uninit-value in unregister_blkdev
To:     syzbot <syzbot+a66467b3864e82f8559f@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 11, 2023 at 8:58=E2=80=AFAM syzbot
<syzbot+a66467b3864e82f8559f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confusi=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17c0674c28000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da7a1059074b7b=
dce
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da66467b3864e82f=
8559f
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Deb=
ian) 2.35.2

Sorry for the noise, I was trying to switch KMSAN bots to the upstream
tree (it is not ready yet, needs one more patch), and accidentally
sent this report to LKML. Please disregard it.
