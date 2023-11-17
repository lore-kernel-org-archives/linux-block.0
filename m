Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Zys3Kkmv"
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52247A5
	for <linux-block@vger.kernel.org>; Fri, 17 Nov 2023 09:41:30 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5c875ee4f10so1013847b3.1
        for <linux-block@vger.kernel.org>; Fri, 17 Nov 2023 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700242889; x=1700847689; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o5RiwTiZDbmnN/G5s/3XrAwumQYnGu6WAncHTvtS9I=;
        b=Zys3KkmvcNzUDaCLQXGfMFSzY46oQ5vS/grJaYU+PAI4wD/As038Eq3saygszbOBSl
         gzlYwAKd2vGEdNVVPTffSX6X8x8LaDDwWqUHn3r4D2NBaFmXfHIlflZVdOXUeS2GbXi7
         jNeTpVLYLLwodWrmoBG2EN+kW4QA8LbWpKjIIVQBbV4Q3t5K+w4M/QmE7yUWEmtcLDGw
         6inzBAjORfoCLkT3wCcRZuZqt1LO6lPA3NbwoU+T0bh3J6dHjLCO61GlvZDBtog4PCTt
         YHxjE7RpHWL88H79wdOsg3Sekns18+isAkUTUqYZYfv2hOX6jX/RyQbv37Z3H+OYFcLS
         V8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700242889; x=1700847689;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7o5RiwTiZDbmnN/G5s/3XrAwumQYnGu6WAncHTvtS9I=;
        b=kAl5ruIv4hMt7et38z1x7Msk6GF9VRvP/F6oBIxZtVpq4vqsTC9c1YiXWJjZtrvADf
         Dh3n2CuaIaGclJdvVB9+NvBp4zar59jVdPQcwUO+nbHm0YtwihpkGpqGK4agWY7DbW3D
         vpISTBBRqa5ImUZXNRChecY+NT1KN37MDDNG1ulqjzFhIub8VHJz8+Gt+Lh0xpr6cCux
         Giyq+TbBZJkBRhOlm+KfYWM37xF8Py/ECwAHdogHzAiYR7+L8nc1pj1Yd+Qk33+wz9JI
         gM61NTInH42rTSoHomGfMyc8Qlj3k8RIBu2QbPsz//3clBK356WFkMyt/3aQsnEzVdD+
         gxqQ==
X-Gm-Message-State: AOJu0YzXLyvO+2F8tTBbR51EVXcDi5ue5IBWUeB2k/pl3RGpFohAN7/O
	pJdAc3Hf5J1nuJg0+LhBD+Rh8rI0sxp3oDiYrwmFMw==
X-Google-Smtp-Source: AGHT+IGccYUjmCZjoVWDXey9DDIojv2fwJ9nKUksJKa1ZzOG8SwKjZOYjU73sXl6sxJD2uw+Je0dPQ==
X-Received: by 2002:a05:690c:2d84:b0:5ad:4d0c:475a with SMTP id er4-20020a05690c2d8400b005ad4d0c475amr252230ywb.4.1700242889237;
        Fri, 17 Nov 2023 09:41:29 -0800 (PST)
Received: from [172.16.1.212] ([65.207.165.42])
        by smtp.gmail.com with ESMTPSA id a124-20020a818a82000000b00598d67585d7sm596106ywg.117.2023.11.17.09.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 09:41:28 -0800 (PST)
Message-ID: <3b2b5978-3c83-42c7-94c2-e44018ac8fb5@kernel.dk>
Date: Fri, 17 Nov 2023 10:41:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.7-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a single fix from Christoph/Ming, fixing a case where integrity IO
could be called without havint an appropriate queue reference.

Please pull!


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.7-2023-11-17

for you to fetch changes up to b0077e269f6c152e807fdac90b58caf012cdbaab:

  blk-mq: make sure active queue usage is held for bio_integrity_prep() (2023-11-13 08:52:52 -0700)

----------------------------------------------------------------
block-6.7-2023-11-17

----------------------------------------------------------------
Christoph Hellwig (1):
      blk-mq: make sure active queue usage is held for bio_integrity_prep()

 block/blk-mq.c | 75 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

-- 
Jens Axboe

