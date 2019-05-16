Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DE2C04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 23:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D442082E
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 23:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="u3/KS+cP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfEPXPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 19:15:10 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:43048 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfEPXPJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 19:15:09 -0400
Received: by mail-pl1-f179.google.com with SMTP id n8so2341984plp.10
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6Goer7djeQOOTYuw+iyeNYpS/Qo0b6LPXrUfSHmyX48=;
        b=u3/KS+cPLDyM0rdRzacRudl2kDL9LuHI0r7iOCKWVeFQLr6hFQP4BPb3DdUablFLUa
         OnrBtrM/mNHH0B/aNi7sL92lkymJryWdyQPqu+uPYh3eYVPSUO2qoDqyVxU6oxWqdoYz
         fwBGBf1FtpcmysH9uOdscP+0E8S4uN7Kyk2NTpKTIyIkmGCJiE/0wTJuRGo022e6w8Ii
         1tcUIccPwByCyvqcQ5E/XDIaYDimu1zNNxoOC6T/Mbwnucr9Xc6UrywREM8tYcHlkJtE
         W5gFa/nBfkxbOmJcR/m7+CA8HG0IBZNS+6WQHpfuFl2bDwVVfE5VODDgHSaQlpiBHSrM
         FQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6Goer7djeQOOTYuw+iyeNYpS/Qo0b6LPXrUfSHmyX48=;
        b=W1Dfm5gZ2o/smqpalgPgcBxsIXAJMTQ6Rd0l7FOuaSwtkKHIMNO4lOIF0evTsuXX+I
         DMk8FGXmJpC67XZUEm+5/0huZp6YEF0j6zXOiuk5ayt8wTAgt/pro7ekDX27c97X2pyc
         4W3i0p7YKwfLok0WxBdnfFYVXcDl9dy3ufcFyHdpMqVW4EoElXJUS6pFF0BKyE46Jlia
         WoQOpov36nVDCJj97cF7jJMt3h3yNpkOPiH2cuAeUPoSQQKmHJ8M36QritE/shwG64EG
         d5mUTEimN+ZgiM3TUPQyAFuSlZyXA9de7KJ3IDQiBhENAn3lXA03ft0uy6YGYoGtzx6X
         DzGg==
X-Gm-Message-State: APjAAAXULoN/vwqhW4RjIM6ueWgZoA/rUObrdB89E/KnnLQhAuJBe7gT
        oZN2VUasm3wrRnXBGIVTCaX+cBgQPNhzbQ==
X-Google-Smtp-Source: APXvYqx1IsUJaYg2vr9q1oqmRgSVTYscMOXW1hjw8Y+o+brCL/diAi+DCHze6CnhJu0odDv2qL4SAQ==
X-Received: by 2002:a17:902:e287:: with SMTP id cf7mr53552266plb.217.1558048508776;
        Thu, 16 May 2019 16:15:08 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id u66sm8056021pfb.76.2019.05.16.16.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 16:15:07 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.2-rc1
Message-ID: <02533e56-7dfb-d8b1-a970-f8129f9f3e3f@kernel.dk>
Date:   Thu, 16 May 2019 17:15:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Small set of fixes for io_uring. This pull request contains:

- smp_rmb() cleanup for io_cqring_events() (Jackie)

- io_cqring_wait() simplification (Jackie)

- Removal of dead 'ev_flags' passing (me)

- SQ poll CPU affinity verification fix (me)

- SQ poll wait fix (Roman)

- SQE command prep cleanup and fix (Stefan)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190516


----------------------------------------------------------------
Jackie Liu (2):
      io_uring: adjust smp_rmb inside io_cqring_events
      io_uring: use wait_event_interruptible for cq_wait conditional wait

Jens Axboe (2):
      io_uring: fix failure to verify SQ_AFF cpu
      io_uring: remove 'ev_flags' argument

Roman Penyaev (1):
      io_uring: fix infinite wait in khread_park() on io_finish_async()

Stefan Bühler (1):
      io_uring: fix race condition reading SQE data

 fs/io_uring.c | 88 +++++++++++++++++++++--------------------------------------
 1 file changed, 31 insertions(+), 57 deletions(-)

-- 
Jens Axboe

