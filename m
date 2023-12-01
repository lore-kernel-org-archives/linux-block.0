Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34903194
	for <linux-block@vger.kernel.org>; Fri,  1 Dec 2023 10:18:51 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-423dba21f1aso13100391cf.1
        for <linux-block@vger.kernel.org>; Fri, 01 Dec 2023 10:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454730; x=1702059530;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gw1s8OwBOFau4DTTIbfvWAMkH6j53iHIsgYJgD8NB4E=;
        b=wrS3KOmRiAEtCyobg+dfUvip9KnFMONOcyEv+A+5hYFvC7+dXGkMNRFvjI2tQuEfPN
         ncgnktiliYHeullfh798VBhqpPaRnHG0a+OjWfTIsmOqW+ppqZLxMnyZKJbe0nyqEFuy
         p3CWvZ7QClYJ8XRFM7BftU59sGrtwDwRq2w0PxvGSrbhIHU/dTJnzDB/Kw0GKiHhaxiE
         7DlCDg78r1s2bWLM56X+kLkfzJTnV3xoddRQrFoIR4JIEJQl8bGOCQ2ZGfkq0jiSI3u5
         fm88tCgBG0zD31hpKm8kzdVPHadANfLwMpFBe4tkyx0SNTRBACJhQwBGT9S2ipW8S0Mu
         TfsQ==
X-Gm-Message-State: AOJu0Yw9w9WCOtToKCSSwmQ5fCR9kfWb1j2Mq64fsgAbskK+cq25ve03
	RsJw4HC8lNDJDR0dOpRPvt2Angf8QKIeIh/WOQ==
X-Google-Smtp-Source: AGHT+IFfC1J4GajOpkujBfQtoLuov3Wdmf+LAOECf4lApqlZkdRh1g/YzzszFzOcOqGzORNm7z1EjA==
X-Received: by 2002:ac8:590d:0:b0:417:b55d:dfa0 with SMTP id 13-20020ac8590d000000b00417b55ddfa0mr30300367qty.0.1701454730183;
        Fri, 01 Dec 2023 10:18:50 -0800 (PST)
Received: from localhost ([62.182.99.157])
        by smtp.gmail.com with ESMTPSA id s6-20020ac87586000000b004181a8a3e2dsm1697242qtq.41.2023.12.01.10.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:18:49 -0800 (PST)
Date: Fri, 1 Dec 2023 13:18:48 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, Wu Bo <bo.wu@vivo.com>
Subject: [git pull] device mapper fixes for 6.7-rc4
Message-ID: <ZWojiLENEOmcKFCo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/dm-6.7/dm-fixes-2

for you to fetch changes up to 41e05548fa6b069a2b895cf4c7bd9ad618b21e2f:

  dm-flakey: start allocating with MAX_ORDER (2023-11-29 15:47:55 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM verity target's FEC support to always initialize IO before it
  frees it.  Also fix alignment of struct dm_verity_fec_io within the
  per-bio-data.

- Fix DM verity target to not FEC failed readahead IO.

- Update DM flakey target to use MAX_ORDER rather than MAX_ORDER - 1.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmVqIjwACgkQxSPxCi2d
A1pcwAgA00/Fln0p84cD3wFKauC61RALx5awoS0S2obAN+JY9yLs3xl1XDm92HyI
9giOXofHVKIlOQW6qASfZoCNGvtKPCVoKZF9KXKCqpK8wyKpuuG+yTPVeSsOK/fw
pKcPp3FyXsu+9FXH3oO9xauLPOiGDC7BfIcHFQITHzT7qwMxQcPQ1HwfVwjrWIjG
lgIQToiSZokBKBWXKyo63SMVkwWhlTdrfG1CJrc0UC9/f6DBMS0RTYJqmNJ3V8ak
i0QyQdGZxc9TFuZe/G+Oq381z+X42iRDlluVU3ClMQTyoemQRcySi98CjRLruu7x
1H79s8ZIaJc/4mkxlJUQingL+dmuGA==
=Av5r
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Mikulas Patocka (2):
      dm-verity: align struct dm_verity_fec_io properly
      dm-flakey: start allocating with MAX_ORDER

Wu Bo (2):
      dm verity: initialize fec io before freeing it
      dm verity: don't perform FEC for failed readahead IO

 drivers/md/dm-flakey.c        | 2 +-
 drivers/md/dm-verity-fec.c    | 3 ++-
 drivers/md/dm-verity-target.c | 7 +++++--
 drivers/md/dm-verity.h        | 6 ------
 4 files changed, 8 insertions(+), 10 deletions(-)
