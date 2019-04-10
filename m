Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAADEC10F14
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 12:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75ED22083E
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 12:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="dJBwE/0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfDJMWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:22:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47065 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfDJMWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 08:22:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so1811375edd.13
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=gIpH8nukPXLUgFESkQN+PXva8bA2gsMJOsACXEGLiUo=;
        b=dJBwE/0d68SqNDVwq7bVDdeee7smFtR33tDwJkfWXm02BTk9FG616XWhzQ0LWljXZY
         OzBojerw/zVkt/1/aR5EdQUP0U4RlpzRlccwWETTtDCq0fqr7ljQ4GJFKpCBq3cLWl+P
         edGTcYsaN3SFpXa7L03z00pr9wlOhG9mRmYIMRiTkzEJP0BdhSkZlbPoRj/aw+XsoscA
         a382WWycaLLZyDW5izqkZs+oxOVBYMFNwWEjGAee3dlL14boAzwrH7fTDcZNn/RWmE0T
         xJqklLapC6W/scT5oqD6pxYxd1cyUp88KN0ywd/MNLGcSwgES8LxgZtvBXhPqzv9PJdr
         kj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=gIpH8nukPXLUgFESkQN+PXva8bA2gsMJOsACXEGLiUo=;
        b=cvcWrRVRzQMcZavp5BayAke+lrn7VwnDFZFnXlS1Tcv1/7XXUMHzb/cbbjxrrXx7HL
         iNktvvmIqgJPNy/7bbEa+PFIP6P+P3w4JgQg8eMzjwa+koA+Z6fhEqYVgv23FknZRWs0
         d7Regfjy4aVB8aggbT8wrjbFnken5b3VIrpIjGL/CHzRoAL9MbY59DT/rQrnYV/5EOxY
         KdAdvRbMz2FoJZhQq8RM+tJxpPL4F+G1bt+Yw1joWDl9hS1aPrB/R3pwQDbnwDpDuSJh
         aYCUMSjSZTvCs1Pot0Q+lM0nzAtxtXaPWWKueuP5MiRwWBIOm9GJFsjSx8aaaAKkJA98
         cTEA==
X-Gm-Message-State: APjAAAVF/AcdejLbYMc1sJ/TQJ3JSFzLHzKOngwocdiNLNT64yuovR+O
        QYsc8EQDd8CZaTMa4bfo1VKfFg==
X-Google-Smtp-Source: APXvYqwzBowlOD6IkSvmk2rM350kHZzKKBDz5EjL3Hr1jp6DjTwXaQaEgb71fx4ksV97BhcTddMG0Q==
X-Received: by 2002:a50:fe03:: with SMTP id f3mr27351881edt.57.1554898958587;
        Wed, 10 Apr 2019 05:22:38 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id c4sm2149621edl.63.2019.04.10.05.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 05:22:37 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <5D5705F7-C0D7-4303-82A2-965320560220@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0AA9B68A-323A-419E-A631-4771C821D7FD";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] lightnvm: pblk: fix crash in pblk_end_partial_read due to
 multipage bvecs
Date:   Wed, 10 Apr 2019 14:22:36 +0200
In-Reply-To: <20190408073308.3082-1-hans@owltronix.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To:     Hans Holmberg <hans@owltronix.com>
References: <20190408073308.3082-1-hans@owltronix.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_0AA9B68A-323A-419E-A631-4771C821D7FD
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> On 8 Apr 2019, at 09.33, hans@owltronix.com wrote:
> 
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> Ever since '07173c3ec276 ("block: enable multipage bvecs")' we
> need to handle bios with multipage bvecs in pblk.
> 
> Currently, a multipage bvec results in a crash[1].
> Fix this by using bvec iterators in stead of direct bvec indexing.
> 
> Also add a dcache flush, for the same reasons as in:
> '6e6e811d747b ("block: Add missing flush_dcache_page() call")'
> 
> [1] https://github.com/OpenChannelSSD/linux/issues/61
> 
> Reported-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> 
> It ain't pretty, but let's fix the breakage while waiting for Igor's
> partial read cleanup to be ready.
> 

I would prefer to have the real fix, but it is good to have this fixed for
5.2. Can we agree on a revert if Igor sends the patch within the 5.2
window?

Javier

--Apple-Mail=_0AA9B68A-323A-419E-A631-4771C821D7FD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyt4AwACgkQPEYBfS0l
eOAz/g/9Fmx5T2IMaMjvJPhKDA3gejav6rTdHc7tRxL7uXiZ85wVFrgQDaTKkup0
ysVroXUUztk9KpSxrajZxYpFgWdsTM4BUQZtIXVIx3soKifOZbSdwOcHUIs2TVCo
WO88W7s1eVUR8qb1e4EEWAQ4GCEGtRfXoxFgFwY0p2RNEieVo9UnY1dy1V5yXwXp
JhpySwbKRG0XVrNUTOQTEmnUnK+Jz1nmSm0IurrajW5V78I8KWWIPQryVmIngSv6
kSfx4LOBrMXuUWU97i5FvfwIKpVOH4+jFhHI+9tO+ySQQZQ1oBep0IdVXzcSI1x1
auTkZNdQAWXUkjHR4yL9FZS5WabqMEhIvv99fU1K4BcuW7i3/tYieg0OS/B3z7LZ
ShbI4G36RWVKkPq8/cqqW8/eE0LwuthzyZlt7/wBSzknGSLB6JWLIxu7G7ZmegkS
6G4ay+Bohi/bX+/g1wGeJI9TA1VV+qtZnWN+Dz79zNoWJm8abd94/E7EEiXPk7do
RrBPP/TCy4BPG/i7cPKAa/aP/LwtgOBMkap43KHrDhuRdZLjEGOa1Z6pmGljrQ98
Qm8luiUgpPM7hbUWb9XQVnYCb6+v/bkX3dAQLQlRRFjGTKpGsJvm/UJ1FleHkAEk
JRJrWtYJPRpCsjNsu53AIt9sGcEexqrlJq4Y48ICLl7P4x2oAJg=
=kcp3
-----END PGP SIGNATURE-----

--Apple-Mail=_0AA9B68A-323A-419E-A631-4771C821D7FD--
