Return-Path: <SRS0=imVF=W2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E46C3A5A4
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 11:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88FA2186A
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 11:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfH3L0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Aug 2019 07:26:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50680 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3L0M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 07:26:12 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1i3f2g-0004Ie-K1
        for linux-block@vger.kernel.org; Fri, 30 Aug 2019 11:26:10 +0000
Received: by mail-wm1-f70.google.com with SMTP id f10so3373184wmh.8
        for <linux-block@vger.kernel.org>; Fri, 30 Aug 2019 04:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONtyOFC+dZSA4vQOkPiU9xYclPOsHmknJnFItn//m5A=;
        b=ogDyBylNyAcqnMA+d9LYDCAlpNPGMYeIMTgXBAeiUDBERVUsL+GWDHV8J1cFSKk+mL
         hkt4jA2nn0Bjvc1BZrnkoyCcd3mfgR0oYKna/fM7/jp8+UZXmRajIrJ3eLaKT4BGGZDh
         nIz7IrmWViuiAccsGGSig27vUPaZZswKw3DJf77TmJ2g46dbq+Lj0OLZDw3NqqHYeMuQ
         7BUa9eVQSZeSy6ngUmHDZ03u9cVOr8JD590E67XLhWNcZwZc77MovwaUuKTuGcn4AvNM
         1YYzAf57U2dfb+6LuwzST3DjPRLIwh98svKEKM1hNP5mORpFQh58Jhej1P4LqWe4WkhP
         U/fA==
X-Gm-Message-State: APjAAAXYxcrfaGt7dA8Z1zhSfvDh4VYVcPTGAwgI9dSKIe0/yhuz3VKY
        LMalbUVWPjxToBPFh5mxCKMOQ9BB7RlHLyDpcPRmv8m9yWp/jPBoRjzk6v6OziE4UTkBte4iqFj
        ABAOPu0fYspXiHSlS9uOpjaWprj+GF//BQPBkhKwZFDz+RQaqt3p5hgN1
X-Received: by 2002:adf:ed44:: with SMTP id u4mr8257336wro.185.1567164370410;
        Fri, 30 Aug 2019 04:26:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzD8gpVqNLfcWj5d2bwlzCAH3DlE5KPUT3AYaexNUWZirMrkm8yqm7IWovyEtVJINJJASgUfjsaN0RaC4cQnpg=
X-Received: by 2002:adf:ed44:: with SMTP id u4mr8257319wro.185.1567164370271;
 Fri, 30 Aug 2019 04:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190822161318.26236-1-gpiccoli@canonical.com>
 <73C4747E-7A9E-4833-8393-B6A06C935DBE@fb.com> <8163258e-839c-e0b8-fc4b-74c94c9dae1d@canonical.com>
 <F0E716F8-76EC-4315-933D-A547B52F1D27@fb.com> <5D68FEBC.9060709@youngman.org.uk>
In-Reply-To: <5D68FEBC.9060709@youngman.org.uk>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Fri, 30 Aug 2019 08:25:34 -0300
Message-ID: <CAHD1Q_ypdBKhYRVLrg_kf4L8LdXk8rgiiSQjtmoC=jyRv5M5jQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] md raid0/linear: Mark array as 'broken' and fail
 BIOs if a member is gone
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks a lot for all the suggestions Song, Neil and Wol - I'll
implement them and resubmit
(hopefully) Monday.

Cheers,


Guilherme
