Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D5FC433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5301D610CD
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbhESIfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 04:35:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50630 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241814AbhESIft (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 04:35:49 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1ljHeu-0001AW-Kd
        for linux-block@vger.kernel.org; Wed, 19 May 2021 08:34:28 +0000
Received: by mail-ej1-f70.google.com with SMTP id m18-20020a1709062352b02903d2d831f9baso3398288eja.20
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 01:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version;
        bh=/rqttwSxsFbE91XKvOMRrGI+lNxhzxHzD33u7hukyrk=;
        b=NWElTiHu4Af8EPO3+g/qF3joKILz97puwyt1hcCYdyCnwuJMiUbqD/29Eh2almSO1/
         bLTjc3kzZS6KReT1AK2Do9pxw2KKQ7/WkwwMSTcpwuz2kXP4c8g3CyAmAx8odmzmYYcV
         aOq9CFPCt9lPIdRmccDUEwsmghi9mQ0qzI7+CQ+YwvfX95Xru8iUEcOta34sUByXSkd6
         K2er5/hnLUDV8JBVjplznO5BoaabfY7PA1u5C8FWCHeaEQk6j3eYWP960G3D58O3zaim
         oPWyBxjYxkC67JYIoLq/K1Ob5w11D206YlAU688lJI73RHoJyMur4MnzM4U+iY8Xn1iM
         9nqw==
X-Gm-Message-State: AOAM531k02RWyLKo0W8aArw5el4XYpLPd8oztetQlWPmfuft1F9sGoXL
        oh+w6tfD/o2IHQsBZVW+x/b1IFJVPO2M9uT4gEVpLR9+sZ7rcuhdSMQmGwn4DBVKBsinBmAaj8e
        qwuR0eOTK6c/O/eTb9FBOY0rfua3FUCpxRUMZhaIL
X-Received: by 2002:a17:907:78c5:: with SMTP id kv5mr11420915ejc.146.1621413268341;
        Wed, 19 May 2021 01:34:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOT3BxYhJ2DqVWi4123MvR17PeikVOi4v+vRZhj0ew58iTyrY64WwZRptdD2ONbaMHcEi9UQ==
X-Received: by 2002:a17:907:78c5:: with SMTP id kv5mr11420901ejc.146.1621413268177;
        Wed, 19 May 2021 01:34:28 -0700 (PDT)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id jt11sm12042285ejb.83.2021.05.19.01.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:34:27 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
Date:   Wed, 19 May 2021 10:34:26 +0200
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>, tj@kernel.org,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/Kconfig: Fix BLK_CGROUP help text indentation
Message-ID: <20210519103426.71b81635@gollum>
In-Reply-To: <YKJHGbmRMcs/e+pm@infradead.org>
References: <20210516145731.61253-1-juergh@canonical.com>
        <YKJHGbmRMcs/e+pm@infradead.org>
Organization: Canonical Ltd
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dd=2BC0fBiQ13nk4axeNujy";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Sig_/dd=2BC0fBiQ13nk4axeNujy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 17 May 2021 11:36:09 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> While you're at it, please move the symbol to block/Kconfig.

Will send a v2.

--Sig_/dd=2BC0fBiQ13nk4axeNujy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmCkzZIACgkQD9OLCQum
Qre8bw//WRU2lUHD5LhdAfhoJ4sBtkzZE74f3dQ75icmYfrzKOq9P5L4npCSRKTP
g2QICMuyDJh4V464F5i+A4iKpYAalyHsG/O+K2Qvf5MHveOibI2zDUSbCj27Gvh3
KNBtKATAyY7lX8Cm3Q/e6wgFYpX3dHWlNFV+H1832PyiDgrlRNMHb/kM+q6KF0ua
KVJC26Veqr/+27HbX8ttLF3WwbK0RH+FXlW2Tw1fcdqvhw6SXsc0t1AD1ZMRSVTz
yDCAErGGu+1DrliBSRm7Wv0JYX4sHE6XDRgNfr1CAx5pksj05+Qe6WOXAj3mAojg
2g9muTOGex5iubXzgA6cXdOBil0bO+Ee60UPCVyc7MUWd1yJXtRqfUaEeuwzzkgB
qtHIzBduiDzPW8LqC258xrmNp2wUTKmlUQiU0S4EHLybpmGmBVWyC766caRhn0Hv
5Mc/vzGbPCSMJo8xHAKe15bBLYo3+rrXkOb8VtSasBFFrKec47JnSm8QaawEej3+
Nk0HReZJyZNvaZUeSrylS6ec5f03IQBxRtckxMpdL7Z+dHtQy9YTam9Aq8b31HBr
eprtQ/qXF0SSHti7QzdB9Q2eModNgIeoD7G0mdRU9qp9+dplcGPHt9oskkDIEAdV
65WifXocv1qXcG/QAH/rtZIbenolpvXj5RFoJjGlW1pDU9Jy7Nk=
=fQvJ
-----END PGP SIGNATURE-----

--Sig_/dd=2BC0fBiQ13nk4axeNujy--
