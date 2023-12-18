Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F417A2D
	for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6cea0fd9b53so1857268b3a.1
        for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 13:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702934053; x=1703538853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6BizXNJusR0F6ATFmyg9rslBVNlEHOqo+rfJFs8w7U=;
        b=E02pfBmHRSYloOK1xbXd8+m2r2dDTSn2z/Np4Z4KwXwFV4SosRcb+6B9j+9l5VEJDt
         LAh7FPzEjTKGXiWFQNJcOMar2uuDkh9IR0q3o63o7QoDeMkf0DbuZVQ2nlPoCmsVryfC
         kjGnc4zcqCAf6RGKv2GuSiFIztgVEto69ii1i5aGUteC6T8TvF3wQuIN82gHLnkLIVzp
         AnQzG5KPy75QGBRy9Q2gIK9IjGcASVNP0Mf/3Dy5atIe4F8FzzC0raL0tOzqzE7PejNZ
         wM5gMSIXseLTQTGhvr/vDq5yaDqQdfyqBdp2top2ZPaqYooTPcanRN37h5QH/P7vYM7w
         Ad9g==
X-Gm-Message-State: AOJu0YySWNK5C/GEMyhUcM2pBxQynuMmlE2VCzMyViMmeXtEWkpaq26F
	/a248t+aH6Q2RMaOSXH8UYg=
X-Google-Smtp-Source: AGHT+IHIxF15Z5rwW+Lz20CmGygeqKD0G3W1OnYXJA87KTUWFamoo7Te4tMgKgAqhlWAiHhp8PpMDA==
X-Received: by 2002:a05:6a20:a891:b0:18f:97c:8271 with SMTP id ca17-20020a056a20a89100b0018f097c8271mr7550538pzb.123.1702934052647;
        Mon, 18 Dec 2023 13:14:12 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78811000000b006c320b9897fsm3371497pfo.126.2023.12.18.13.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 13:14:12 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/4] Improve I/O priority support in mq-deadline for zoned writes
Date: Mon, 18 Dec 2023 13:13:38 -0800
Message-ID: <20231218211342.2179689-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

This patch series prevents that the mq-deadline I/O scheduler submits zoned
writes out of order if different writes for the same zone have different I/O
priorities. Please consider these patches for the next merge window.

Thanks,

Bart.

Changes compared to v1:
 - Changed the approach from ignoring the I/O priority of zoned writes to using
   the I/O priority of pending zoned writes.
 - Included two unit tests.

Bart Van Assche (4):
  block/mq-deadline: Rename dd_rq_ioclass() and change its return type
  block/mq-deadline: Introduce dd_bio_ioclass()
  block/mq-deadline: Introduce deadline_first_rq_past_pos()
  block/mq-deadline: Prevent zoned write reordering due to I/O
    prioritization

 block/Kconfig.iosched    |   5 ++
 block/mq-deadline.c      | 135 +++++++++++++++++++++++-------
 block/mq-deadline_test.c | 175 +++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h   |  17 ++++
 4 files changed, 300 insertions(+), 32 deletions(-)
 create mode 100644 block/mq-deadline_test.c

