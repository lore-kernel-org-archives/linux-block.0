Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ACCEE4993
	for <linux-block@archiver.kernel.org>; Tue, 22 Aug 2023 13:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjHVNIy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Aug 2023 09:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjHVNIx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2023 09:08:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA53CC6
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692709691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2i92USkhd3aYM8lBDCV9sQj/R5WX5KpFuC2KDLqm9uA=;
        b=huIQdUcLweLc6TCgSbuPRjiEJe/0GqGqxURwqK7pPAFgL4z8M1RWRDapoYb/8knlgebPsR
        wHY6aWRRZwXQX5CNmLgRigpDsVAZ1SJifpltunYwN2qdH3eAU7L8R9XeX2EoETX79Ahe2i
        /Baq/ItNCgz72n7XNsnCjVGsEZqzU7U=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-5zeBv91CNd2s0HXxmfZWnw-1; Tue, 22 Aug 2023 09:08:10 -0400
X-MC-Unique: 5zeBv91CNd2s0HXxmfZWnw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a8607eae76so414039b6e.1
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 06:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692709689; x=1693314489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i92USkhd3aYM8lBDCV9sQj/R5WX5KpFuC2KDLqm9uA=;
        b=U9Y5pjkR2ZG3y9x/14uHlHF6x4xRBW3dQFIbJULUSoKUzrTsv75N50M1BA3EZazCOB
         xg8kMPk7+w/sutbgf/oKltwSyCaFFXvOKx74VujeQgDcU3+R6eFqJbJSyH4nHb121KCP
         cxhWLykLhKfyYWaEwk+K/4FQMWp/9zKMeqeWJWr1Dl1ZaRUrhI7jdBQX4bVNrJtKPvX3
         ohBt4xQWaq/kvVQ3iEYqgomu0Gx5Za2kTYmlt+epr9bx8x/h0doR4vICtJRz5em0Ti7r
         P7vq9sLfZxMyIQiApemRuqz4VNs/ROa9x9opN0teVGtZs86oAax5VrdH50DAf9g0dF+I
         jJVg==
X-Gm-Message-State: AOJu0YxF8GiAHNNCmquBwSmvAgJ4spBg7KU7QGa7EGzSOZdZ0iP/bkAM
        vem7+GPWI9oFPaKNTIbnN0b/JNGDWKS2KbZXxbTcuc02bMMXy9YGxYjbG1fjmo9BA3rTB+uIQaz
        CqegBpLiI7A+PB/lcYTThB1fiC4750lIwZt3xyxZbx0Jt21PhwIdxQaM=
X-Received: by 2002:a05:6358:c12a:b0:13a:cd06:f631 with SMTP id fh42-20020a056358c12a00b0013acd06f631mr6081333rwb.2.1692709688856;
        Tue, 22 Aug 2023 06:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5jnokBVqe6Vkt7S3b8TW/jdpbS9ktl8CZ+NlXNERyv6n6WFm96H+zxw3a8+CVtcXFhmkrn2bsT4tHJKpSLfY=
X-Received: by 2002:a05:6358:c12a:b0:13a:cd06:f631 with SMTP id
 fh42-20020a056358c12a00b0013acd06f631mr6081317rwb.2.1692709688582; Tue, 22
 Aug 2023 06:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230817075509.1438569-1-fengli@smartx.com>
In-Reply-To: <20230817075509.1438569-1-fengli@smartx.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Tue, 22 Aug 2023 21:07:56 +0800
Message-ID: <CAFj5m9+sm55FJAoM5iYtM=4y6VA7QwqD9bPqS7_uauwKqBvpNQ@mail.gmail.com>
Subject: Re: [PATCH] block: fix unexpected split in bio_discard_limit
To:     Li Feng <fengli@smartx.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, lifeng1519@gmail.com,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 17, 2023 at 3:42=E2=80=AFPM Li Feng <fengli@smartx.com> wrote:
>
> bio_discard_limit() enforces discard boundaries within the range of 32-bi=
t
> unsigned integers, resulting in unexpected discard cut boundaries.

Any bio size can't be bigger than UINT_MAX, see bio definition.

>
> For example, max discard size =3D 1MiB, discard_granularity =3D 512B, the=
n the
> discard lengths sent in the range [0,4G) are 1MiB, 1MiB... (1MiB-512).
> The next discard offset from 4G is [4G-512, 4G-512+1MiB).
> The discard of the 4G offset boundary does not comply with the optimal 1M=
iB
> size.

As mentioned, max bio size is 4GB, so there shouldn't be such issue.

Thanks,

