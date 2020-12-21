Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE33C433DB
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 19:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F73422AAE
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 19:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgLUTC3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUTC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Dec 2020 14:02:29 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83A0C0613D3;
        Mon, 21 Dec 2020 11:01:48 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id f9so6952501pfc.11;
        Mon, 21 Dec 2020 11:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:cc:subject:message-id:mime-version:content-disposition;
        bh=sMN/dLSbQO4evWvvCA4ljyXcUU+8cXQNTt3YuKOkzz8=;
        b=uq8EY+Lf2UsqQjii5XyNNSyXoHY6mBbrNBxPedNhOxD7PMumFV8oD1zUBp4FrMlz27
         +u3DuKxJnDlrPxvNPgjutfwrfpWvJQNF03UMDPHqBptrRx+BriQkRQLASa9ZlA9d9/N7
         DTINZYDXB589K5enGQlb/7+4Dy3Rr0+mjyBcZ6i+bIVyKLF9LIDcWV4//+kQ0Y//YqFD
         NaZ0XYmOPy74Do+dpG0bdXYVg8utsBBqYYKc0QnhwX65f3IDIioXBL0cTkLUyEeedFzU
         uxB4G1uyWMGz6XXo/3np+MDCmoF3QCzL1kWx3W5EmojGSYLUhMBzExl/AEX/hJmLwShG
         41/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sMN/dLSbQO4evWvvCA4ljyXcUU+8cXQNTt3YuKOkzz8=;
        b=Ow9+euzEVv/fgXFsW/Xqwww8h08hvjQ5NZ1koXpPrRjy4sREwAcTULJNLQ3CZCR8mV
         FLdQktz0jTw9ajQkWgXlPrtXW51lZdHJBfnFSR30FgWCfMhitnaIxk+rpUutpZ0jPMKL
         JyC6PjUSzNDmyrE1TIoX/21Qs2Hs4qruBM7h2XEnexOl5ciksa94QxVrI2kgVTekI1pY
         3VDjC0+VHXtSnfyC8YI4LLNOKyj7Y0HVVsAs0zGPTjQ2U9e+y7OjvEfu1nPq5/C4r2eO
         5PGk7yEGyv+74cYNbgotrWww7He09881JPVbYMsdAxkPVKizhdzr4GR31WtzBKi3qhUt
         7BtA==
X-Gm-Message-State: AOAM533q/A2nacJXdC2+/a7v2MVjl+Up2p4NSMeA8g3YpdBy8mENDRiR
        NLPdVDXUhB2GBQWrUncDS3pTdmMj+fDOqQ==
X-Google-Smtp-Source: ABdhPJypjzB0iALUY86NNTL/9chn3Hv2q25zFTjPRo8PblFBKibaRG43A1nKV5a7F513BZ4fZGfCcg==
X-Received: by 2002:a17:902:694c:b029:da:afba:beab with SMTP id k12-20020a170902694cb02900daafbabeabmr16994073plt.32.1608566696869;
        Mon, 21 Dec 2020 08:04:56 -0800 (PST)
Received: from localhost ([103.248.31.152])
        by smtp.gmail.com with ESMTPSA id b13sm17536099pfi.162.2020.12.21.08.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:04:56 -0800 (PST)
Date:   Mon, 21 Dec 2020 21:34:50 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: aoe: Use seq_putc() if possible
Message-ID: <20201221160450.t74ylcxazg4nryla@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lk4q7y37k42boc5x"
Content-Disposition: inline
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--lk4q7y37k42boc5x
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <ameynarkhede03@gmail.com>
Received: from localhost ([103.248.31.152])
        by smtp.gmail.com with ESMTPSA id f9sm16893958pfa.41.2020.12.21.08.00.19
        for <Markus.Elfring@web.de>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:00:19 -0800 (PST)
Date: Mon, 21 Dec 2020 21:30:13 +0530
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] block: aoe: Use seq_putc() if possible
Message-ID: <20201221160013.pohxcqob35pk44k6@archlinux>
References: <20201220152829.65094-1-ameynarkhede03@gmail.com>
 <2580003e-91eb-65b0-2a96-7d6fddf3f706@web.de>
Content-Disposition: inline
In-Reply-To: <2580003e-91eb-65b0-2a96-7d6fddf3f706@web.de>
X-TUID: 7yALrRi0EZU+
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

On 20/12/21 04:04PM, Markus Elfring wrote:
> > This is a single character that is printed out. Use seq_putc() for
> > it to simplify the code.
>
> How do you think about to reconsider the integration of a previous update suggestion once more?
>
> [PATCH 1/3] block-aoe: Use seq_putc() in aoedisk_debugfs_show()
> https://lore.kernel.org/lkml/58b532fc-14c5-6e87-75d0-d78703b289dc@users.sourceforge.net/
> https://lore.kernel.org/patchwork/patch/785968/
> https://lkml.org/lkml/2017/5/8/90
>
> Regards,
> Markus
Apologies. I didn't find those patches.
I'm a beginner so I'm submitting style changes mainly
to get familiar with email based workflow of linux
kernel. I'll keep in mind to search previous
patches next time before submitting a patch.

Amey



--lk4q7y37k42boc5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEb5tNK+B4oWmn+0Z9BBTsy/Z3yzYFAl/gx6IACgkQBBTsy/Z3
yzYt2Qf+I5f8pEG/A5b8aIux8m33P9YmJ2Pvrxz+U0v8dkweL3eZ7zzwZIWKTuGf
kbhLK3N7oAXq6xHI/p6ZrYcuKaLu0VztRLxvY16k9m8/aZz+B4yc01fIMUXqgG/f
+qj8cs1NYWWf3UMq2NQc8kLOKuJsKA7ra5W4C0NPozSh8g2WN9PNUF44X8cbzpRr
w2LSnvIiOATwicIa3gBgIdxIYHh9dFDd9JKTt6/o2wJJG/NO08V0f05hNT02qzqH
JKi6B0KI+q80UBQGCj8JcL5RhI1LvhIgxb6fboxyakCuzaujhBGD/CSeRT2hL2Bh
Rf9OzDbbfADCiouKoulcqPaiOfEGxw==
=BWYt
-----END PGP SIGNATURE-----

--lk4q7y37k42boc5x--
