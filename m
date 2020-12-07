Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA144C4361B
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 15:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AF223715
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 15:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgLGPDd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 10:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLGPDc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 10:03:32 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859E5C061793
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 07:02:46 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jx16so19884201ejb.10
        for <linux-block@vger.kernel.org>; Mon, 07 Dec 2020 07:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5an9IpqP76fFEfITqq2IfrQNyjf5flDTbngmDsa0e0=;
        b=b0PNzOJCtcJg4O6coaXXwXy4BPnkF0lQigfsuS/Eux90pqnc8vuLYlLzaDrAzL4nw9
         8ur8vzz9e0suu4AP8UKavHCm2e3dUXKMAQ+Tc51lywhBH29uIOzdjn8I/YAVi4lFtrYC
         351Alkx/e3g3OBRpwWukHX2WrZtnbdW6tfqqwu6uU+f0XBu0m7lsi1zFFihHPapOT8wF
         Qo6gxm1kLhBuCb7sPzgKvRtuqZWVaQ5NgRQucwzG7mCRbB7yBBsgF6k5V9j39Kw8JrqL
         HLoOu8mwLaoKlDMHrzCuS69mqtOFzCDk8s/FocrZNzZeRjzGQSfybRgb8G9Zzzvi6swq
         ogOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5an9IpqP76fFEfITqq2IfrQNyjf5flDTbngmDsa0e0=;
        b=s1B5/BFlDDpjsaQaygAa4Iw8QsL19U7Ifdpg8AUqpRy2+3Lxof1EknE5NcdUgJZtGD
         Xgad2GTsHuVSzT8H+Lw3G1b4hg4H4o/ZOBJDRP6njhp89H1MUXHxd47dEJtOkdZ2AceQ
         G139AhXEQAiSa9L060BtniHTWvt8v4tTjof1At8pPxZwnj+MSUSmALw/gha45KR/V49v
         U2dFsxKy8CBZpU60JZwVjH/+gP4biEg/bp+yemQx6Ckz1QVfc7XCA3+4PkrzptJLnBiw
         WA/7LWuSbYnC6S3cSCCAWHpq/jyk9EH2RxUA+2yrmcsDdZkMmJgXBOdMFAB+2VUvdhFx
         5/lA==
X-Gm-Message-State: AOAM53374IOg790dPDr+0Q46YUIIcYIhrmmf1rRiFIPd94ylhGFIAiF5
        JN97srJbyygV9KqzNvltI/XGF7tOurjRM9sBZA/Isw==
X-Google-Smtp-Source: ABdhPJyjHAk4PRj3OIAv9j3xOZdDWo4qndoe9LdmKf3qEzqcDgfah7gXM5L/AoRSiabQqEhraV7b8RX0+RG4TP2SwEE=
X-Received: by 2002:a17:906:9452:: with SMTP id z18mr19468443ejx.389.1607353365047;
 Mon, 07 Dec 2020 07:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20201207145446.169978-1-colin.king@canonical.com> <afd6edda-460c-8488-6e63-438053e88eac@kernel.dk>
In-Reply-To: <afd6edda-460c-8488-6e63-438053e88eac@kernel.dk>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 7 Dec 2020 16:02:34 +0100
Message-ID: <CAMGffEmKW=wa3_UiJA9+SLKcB0q9WmOMThQwoe0pc9oQQ62phA@mail.gmail.com>
Subject: Re: [PATCH][next] block/rnbd: fix a null pointer dereference on dev->blk_symlink_name
To:     Jens Axboe <axboe@kernel.dk>, Colin King <colin.king@canonical.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 7, 2020 at 4:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/7/20 7:54 AM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently in the case where dev->blk_symlink_name fails to be allocates
> > the error return path attempts to set an end-of-string character to
> > the unallocated dev->blk_symlink_name causing a null pointer dereference
> > error. Fix this by returning with an explicity ENOMEM error (which also
> > is missing in the original code as was not initialized).
>
> Applied, thanks.

Thanks Colin for the fix, and thanks Jens for taking care of this.

Jack Wang
