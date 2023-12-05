Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E62109
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 21:32:31 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so3075927a12.2
        for <linux-block@vger.kernel.org>; Mon, 04 Dec 2023 21:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701754351; x=1702359151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gl0nLWasfnimbuTQ1aJCGIP/gBZD+Pl0+s1L8TGiqJU=;
        b=hAIz2dIhDawD+cCBvwgX6nZJDeayBujtPH9fN0pBMf3Q6KANi3JjF2IjXxu+5x03sU
         h0gJVw81PpI4kbe8+2QtbD5iIRVvS638y06Oz5WTal5nUNV1tDvkhWkyxmLlKVXI/GMj
         xay2lwjgpNoPpGR5R5xKsuOCnpRDrMLGTW629784YGSrkjYFGE2xIBHq054g3pujA7ri
         ljfJ0wPWWnA309ZoYjQsh5NqcbqW5k20deDMWjrbN/S/OBhNrly974NTkRbsCKiiQMAi
         BoPt0tB4EjV8XDzl1IFzOukWnpNaqYOh5HFmcEX49AcP0kD9vw+kT9tsOwFdmTo8/CDf
         qyhQ==
X-Gm-Message-State: AOJu0Yws7sBW4oph9dHoGRBj5Eqj1IB/KP9LLJ/w7XWVafKlFAdVNeV+
	yKGxYmZlbO9qvRVzmCac3PslTmPgLSs=
X-Google-Smtp-Source: AGHT+IF1OOfML9wSR6rcmUH7bYQXhGCcCByaa6U3ZYb+ennXH6jKzeYaING6w/oceX7THpLUXIggGQ==
X-Received: by 2002:a17:90b:1651:b0:286:9b25:1c66 with SMTP id il17-20020a17090b165100b002869b251c66mr811326pjb.24.1701754350732;
        Mon, 04 Dec 2023 21:32:30 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (rrcs-173-197-90-226.west.biz.rr.com. [173.197.90.226])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d30d00b001cfcc10491fsm1145375plc.161.2023.12.04.21.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 21:32:30 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Improve mq-deadline I/O priority support
Date: Mon,  4 Dec 2023 21:32:10 -0800
Message-ID: <20231205053213.522772-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

This patch series includes the following changes for the mq-deadline I/O
scheduler:
 - Do not modify the request order if prio_aging_expire is zero. This
   change restores compatibility of the mq-deadline scheduler with MMC
   devices if prio_aging_expire is set to zero.
 - Ignore I/O priorities for zoned writes that are not write append
   operations such that zoned writes happen in LBA order per zone even
   if different write requests have different I/O priorities in a single
   zone.

Please consider these patches for the next merge window.

Thanks,

Bart.

Bart Van Assche (3):
  block/mq-deadline: Use dd_rq_ioclass() instead of open-coding it
  block/mq-deadline: Introduce dd_bio_ioclass()
  block/mq-deadline: Disable I/O prioritization in certain cases

 block/mq-deadline.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

