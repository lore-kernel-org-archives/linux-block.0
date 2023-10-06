Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B114FE94139
	for <linux-block@archiver.kernel.org>; Fri,  6 Oct 2023 23:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjJFXRX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Oct 2023 19:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjJFXRX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2023 19:17:23 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2362D93
        for <linux-block@vger.kernel.org>; Fri,  6 Oct 2023 16:16:36 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-417fc2da919so16253511cf.2
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2023 16:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696634195; x=1697238995;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5zVupE3z01tc2sxIrPY9/eebBvlEDweRwNBcoJ4yvQ=;
        b=fRwXUdmRon2/z9HW75fZPrVKbB2JmGcqd0UnZYfrsbNC66e7M5XBhC7y3SuMXNvNC8
         ENv4tJ9hrlFUxQJtFj4v/pvdEdzBxCWSSfaP6zrbdxE4haCHStBd9bDAduZyNHPxRhys
         CEjpVEB3w++YU/Sxirae6YVId2WaxWYCoEw2ghxiAfl9cQrGGv73C/MYT+DXZA1AL2w2
         yZ144pb2UPqL9tPo1+Ls/by/vFl7z4deWDdp4IsqSzCtb/4k0biWblFrbHrdjO9M1Xyd
         lWWubUNoPV04vQxO1mHcbmx2AqXizIUoPkQv8VHPz8ercQD1fVT6N1SeQ3bPtckWYHII
         DB+w==
X-Gm-Message-State: AOJu0YyGVR0kBuh7FNGM91xFNUPVfkkWki4vv8UzcsNrObu9OWJEchGf
        HYUVDlaOsGSH6VQJnmrphhge
X-Google-Smtp-Source: AGHT+IFy98nmR7XCkLtFSm2p1Dvn7gdJND9vRLfNV51HKET4h69aObyHD+LOxRGaJ3avJvaBBrB6Ng==
X-Received: by 2002:ac8:5a0a:0:b0:418:76c7:52ab with SMTP id n10-20020ac85a0a000000b0041876c752abmr10101943qta.52.1696634195277;
        Fri, 06 Oct 2023 16:16:35 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id g10-20020ac84b6a000000b00417dd1dd0adsm1625036qts.87.2023.10.06.16.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 16:16:34 -0700 (PDT)
Date:   Fri, 6 Oct 2023 19:16:33 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>
Subject: [git pull] device mapper fixes for 6.6-rc5
Message-ID: <ZSCVUa3D4BAKGsLL@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.6/dm-fixes-2

for you to fetch changes up to 3da5d2de92387a8322965c7fb1365f7cae690e5a:

  MAINTAINERS: update the dm-devel mailing list (2023-10-06 19:05:57 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix memory leak when freeing dm zoned target device

- Update dm-devel mailing list address in MAINTAINERS
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmUglFMACgkQxSPxCi2d
A1rOswf/T5nqpzFrbrzYj80DpRIQZj+nvTvPTId8X2kWQZ6uJqOpXSA1QP8DHeQj
ycn88TEK8sbXn+wvXXWoPuMrh6FVJoZASvdlhq5QhnwpCT0riwRrnh7XQIrl3Ktn
EQNmAoiKPMF/pZe653BalW/SnRJEa6603RhjHFBuGLKVS7i38oWrmbfcVEdQ+/nf
Pq7gIWoFHtL9LgvhfCLHDg/EYO+brNTJtCnqt5t67iILkK6A//BO9y3O6f2QIj8C
9Y5wGduZyaZ0uOj+LuU3sEqMfr8S6q+0vbJn4yQPDhSM0msLfB20hnYN1Nl2TGIx
B0k3YBScNq6u+pmPjKZMcnRXJnKPaA==
=p6BS
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Fedor Pchelkin (1):
      dm zoned: free dmz->ddev array in dmz_put_zoned_devices

Mike Snitzer (1):
      MAINTAINERS: update the dm-devel mailing list

 MAINTAINERS                  |  4 ++--
 drivers/md/dm-zoned-target.c | 15 +++++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)
