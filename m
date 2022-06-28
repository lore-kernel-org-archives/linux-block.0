Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C61EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 04:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiF1E0P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 00:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243359AbiF1E0O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 00:26:14 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8459C14039
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 21:26:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q4so18394755qvq.8
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 21:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pQioXScPR1ZrU0GmMPpYnQPltx0fgcH9pN3N7WOA3/w=;
        b=IlbQzsqYqI7lnCYALDjRz+Fjuv2GgM1cHOF0+FioMKilBr7q2wZGT5SXTrS4POc+cM
         +quq5jzbynIDHZ9weNgv+mJaTZao36nNRIQX97MQ+z38l8WJg96jGBYtPwC6iYUCEFsE
         WsfDAiSrDowvmdqq/G6GL1053Upnzzz/an4gLUMWQ7LeLDYj8h/j1ef0omy4FT/xoqcI
         IB9wICw5mk0I+nVVSQyPDENWDYNeCCRuuXAcyMlijDr4G6ulydD3BZCrNDxG/h6Ix4x3
         lvp0JfcX79Q2viOGb/MZv7asM0j8WqOKeBFPNZFCKs9A+NX4M3SLatCBcTxTNOPJCEz9
         va5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pQioXScPR1ZrU0GmMPpYnQPltx0fgcH9pN3N7WOA3/w=;
        b=kbkmBeTNaLLgZwvddItcYQO3NSkoM5it5hfogbn/kPhQAmiY0aTClkh7HvkPoCGqhR
         +o9S9I2Zpodmz/WP7y1NMkvdQ7oyirVHNvwCEFKi8L72RcizbcPsEw7CKq4sOZTEqjcT
         vo+dG7dAFUcHsJ1XnlgTd0ubV+MTrisZ2HJ1ulsEP7jPtA5GBjseNz5oG2nPHv9dSl7Q
         KS4VR5KGQeKZG+96kF+h2oCBW4nZetVmFU7FuNllrmzo5E4Ngw91ZmOJ2fkEzXzSosVm
         HhrlBdKJwOSbSgLSwRx9QCRfIBZPUfNBMqTKAFpAQhZApugVOguEsZVCpgxd3RTBIyQK
         TYiA==
X-Gm-Message-State: AJIora8p+WjKApxdJTn1++Tk1no0R3yo9fCye0NinMo9Rui8DdHtb4Xc
        dbXp4DtipiBFfkpVbl4YAw==
X-Google-Smtp-Source: AGRyM1vDjsHpl51I84tTed9uZ6LSakOPcKzqDgn+NfarFKny0QuOmxJctUHQxVvcIjE2mPS3cTutXQ==
X-Received: by 2002:a05:622a:1ba3:b0:305:15b5:8758 with SMTP id bp35-20020a05622a1ba300b0030515b58758mr12018492qtb.10.1656390372668;
        Mon, 27 Jun 2022 21:26:12 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id n8-20020a05620a222800b006ab935c1563sm9558005qkh.8.2022.06.27.21.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 21:26:11 -0700 (PDT)
Date:   Tue, 28 Jun 2022 00:26:10 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220628042610.wuittagsycyl4uwa@moria.home.lan>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrld9rLPY6L3MhlZ@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 27, 2022 at 03:36:22PM +0800, Ming Lei wrote:
> Not mention bio_iter, bvec_iter has been 32 bytes, which is too big to
> hold in per-io data structure. With this patch, 8bytes is enough
> to rewind one bio if the end sector is fixed.

And with rewind, you're making an assumption about the state the iterator is
going to be in when the IO has completed.

What if the iterator was never advanced?

So say you check for that by saving some other part of the iterator - but that
may have legitimately changed too, if the bio was redirected (bi_sector changes)
or trimmed (bi_size changes)

I still think this is an inherently buggy interface, the way it's being proposed
to be used.
