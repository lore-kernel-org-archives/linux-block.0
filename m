Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36A8C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 20:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjC3UcU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 16:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3UcS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 16:32:18 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FD793C9
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 13:31:30 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id a5so19776141qto.6
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 13:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208289;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhCjWj6A07ChaEE/VAs2MqHk+Daf+HpCUVuoJdoHHkY=;
        b=EzcyvYJKcNVy9s2qHmhlELncS6o66B6wJvtMdYpSwvBGnxz1KbIcYIanZJ2o6cwB7o
         H6g+IMeDb310GcW494wo+svWM9LUalgvwnsTD/0JNeIBxXq1AYpHN9XEkqr/rA9S+AuE
         XKZd0qVdpbjo4sSmeiE/8QFQSSS6TrgMrblTF0gZr85qkZMJEs1PUUqGl2ikUR9JZcxE
         Klsw/nImxcM5rxdBcsXC4beThazWLZjZGHNZ+THkicarXH/NlCISwAYcJOsM+ST6uz97
         nP28xk2x80rNeC5YaJ2OP2Xj5Azpt4tySR7p7ITmRMITLsftcKDEIX6OzzzkyAYetGAm
         ubPQ==
X-Gm-Message-State: AAQBX9ez5dTDnSloty66HIb9f7+UnU7oKD40YKBQwJjWRNIbdEudSD+9
        p0U45WwkDZ/8YsUVaV8sRVC9
X-Google-Smtp-Source: AKy350Ys1PW85D28/axnMtdHaVIykTLm2UcqEqmi84VV10hdDWNkCTOzLB3TCnPz6RapbsyWeLZuyQ==
X-Received: by 2002:a05:622a:1208:b0:3e4:dcb4:169 with SMTP id y8-20020a05622a120800b003e4dcb40169mr33830225qtx.16.1680208289629;
        Thu, 30 Mar 2023 13:31:29 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id s9-20020ac87589000000b003e4f1b3ce43sm117842qtq.50.2023.03.30.13.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:31:29 -0700 (PDT)
Date:   Thu, 30 Mar 2023 16:31:28 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Orange Kao <orange@aiven.io>
Subject: [git pull] device mapper fixes for 6.3-rc5
Message-ID: <ZCXxoMlJVnVH0TQ2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.3/dm-fixes-2

for you to fetch changes up to 666eed46769d929c3e13636134ecfc67d75ef548:

  dm: fix __send_duplicate_bios() to always allow for splitting IO (2023-03-30 15:54:32 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix 2 DM core bugs in the code that handles splitting "abnormal" IO
  (discards, write same and secure erase) and issuing that IO to the
  correct underlying devices (and offsets within those devices).
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmQl7tQACgkQxSPxCi2d
A1rZ8ggA0MT7yLR2Bu2ZwyCXInkDdWH5cgQ5V9KqbOq80/8pMHQdxkuILej/mv6P
I3YNzRXZMkYLDoXEN6ISd6P4D+FWxP++AqPcEk8rp4eiSvmxi+R7PYe4wPDTPaKT
OAzwu1GmrJ88lUGAvfY9fNDuCApFubskasfIApUFFAQinuDPpo8fexmiiyNxPLIE
MKPoRUzsDe34C6QLjlv4BJ0hHd+zYwnwCckSlekRYdiOR8Gx4VD1mK7z3Dm8xBpA
ERCHbjCCSuz4FTyiLYJziIjZW/gY9u4N3H5w1njsnUCUmUs6/N3ETsO6qEfzeLVc
Snxdmfp+UNQnpFLA5OHfTduvU8ufKw==
=RpDD
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Mike Snitzer (2):
      dm: fix improper splitting for abnormal bios
      dm: fix __send_duplicate_bios() to always allow for splitting IO

 drivers/md/dm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
