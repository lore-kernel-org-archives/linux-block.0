Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40658C433FF
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 10:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13C921E6C
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 10:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCsuofcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfHGKNk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:13:40 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52441 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfHGKNk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 06:13:40 -0400
Received: by mail-wm1-f54.google.com with SMTP id s3so81206681wms.2
        for <linux-block@vger.kernel.org>; Wed, 07 Aug 2019 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XieZzxfLu9QufPlb11ITYZ3LK0n8S+Cl5vGZeFQR1/s=;
        b=FCsuofcc8CHgcnL0rvRj6pMGqDOrJKc9YzJretRyWtcpapHsu3f/UYn9KSK70GNM4F
         sJcbSGWuPFYTDAHITzVE5Wxg6NWZEBi6aalU2a/UGBArnBJQy46NxRizwGci595h4c92
         q1+fIDJicBfa1XaneUAv02NlhO4S8D5mKgrFsSup2ZpPY6lZephfc1gqTSq5ZTV811P1
         Qhjq45amlHQEG5/LinKv6Qm4Y7wqIo2tOr2yHOOhx0iZhz9yCSZo01c3hgxXVE82khMm
         skdQx01f5qopEqf774kmirIWxIBT6T5cYj/Lx7ZEGwobEUxj1wjR2az/KyWkbthRUWmc
         nacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XieZzxfLu9QufPlb11ITYZ3LK0n8S+Cl5vGZeFQR1/s=;
        b=EEZ+Riuh/wVAPJvBsOpuSogH7XxzhGRt9BO2OqC6fF5DC2qbTcFTExHMrUxvFziOyx
         pyaQBBfk/JH2nxpYZIRQsyhb+IwiRbNRVHms6HTghBXgTQuAQbaMSbknnasO931LyvAc
         Uqdyax9cxMyM3VwB0RPEtCpAZBB8hmQyVGNY1ZiVKNusLMREYSoQWrsoWDeyKtOEIHpe
         JxV7ZliM8FzSQ8u9KjaZNyN4jt4enl9jlOKaClOUNrh1xXpwHRgg3Na06Udv7oOj9nYS
         mmJyQvZSjq+NBLNIiMhvcnWiMciSXCN0CliUjiU8+ghx9ezvfdc/puIrILJnQRSTKu62
         X1wA==
X-Gm-Message-State: APjAAAXqLUyRTCd7jfXUjzQP1c4s5zJUkO9hBUUQ00jZu2i46VPR4vl2
        xcFdVJ+5oiklsoG1o2OJ5rqLew==
X-Google-Smtp-Source: APXvYqxfsj/lDh8u5Bbjul1se3r/54whi7TTiB31c+Gur5zm2UkzOjzwE2Tndw7WKXBmYDJvatDQoQ==
X-Received: by 2002:a1c:6c14:: with SMTP id h20mr10374824wmc.168.1565172816952;
        Wed, 07 Aug 2019 03:13:36 -0700 (PDT)
Received: from [192.168.0.100] (88-147-66-232.dyn.eolo.it. [88.147.66.232])
        by smtp.gmail.com with ESMTPSA id x20sm70944946wmc.1.2019.08.07.03.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 03:13:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: slab corruption in 5.3-rc3 while inserting an usb key
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190807101031.GA18652@amd>
Date:   Wed, 7 Aug 2019 12:13:35 +0200
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B3F60AA-6851-46D0-A6E0-049BD54D5256@linaro.org>
References: <20190807101031.GA18652@amd>
To:     Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
I hope this has to do with the failure reported by Doug.  I'm
finalizing my fix.  I'd appreciate if you could retry with my fix
applied.

Thanks,
Paolo

> Il giorno 7 ago 2019, alle ore 12:10, Pavel Machek <pavel@ucw.cz> ha =
scritto:
>=20
> Hi!
>=20
> Machine is thinkpad x220. BFQ related?
>=20
> =09
>=20
> [ 8224.904413] usb 2-1.1.4: Product: Intenso Twister Line
> [ 8224.904421] usb 2-1.1.4: Manufacturer: Alcor Tech
> [ 8224.904428] usb 2-1.1.4: SerialNumber: 12102500210755
> [ 8224.905778] usb-storage 2-1.1.4:1.0: USB Mass Storage device
> detected
> [ 8224.906519] scsi host6: usb-storage 2-1.1.4:1.0
> [ 8225.938476] scsi 6:0:0:0: Direct-Access     Intenso  Twister Line
> 8.07 PQ: 0 ANSI: 4
> [ 8225.941857] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [ 8225.944342] sd 6:0:0:0: [sdc] 15257600 512-byte logical blocks:
> (7.81 GB/7.28 GiB)
> [ 8225.945541] sd 6:0:0:0: [sdc] Write Protect is off
> [ 8225.945551] sd 6:0:0:0: [sdc] Mode Sense: 23 00 00 00
> [ 8225.946669] sd 6:0:0:0: [sdc] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 8225.961509]  sdc: sdc1
> [ 8225.966286] sd 6:0:0:0: [sdc] Attached SCSI removable disk
> [ 8226.351785] FAT-fs (sdc1): Volume was not properly unmounted. Some
> data may be corrupt. Please run fsck.
> [ 8685.026976] perf: interrupt took too long (3142 > 3141), lowering
> kernel.perf_event_max_sample_rate to 63500
> [ 8710.270064] Slab corruption (Not tainted): bfq_queue
> start=3Dffff8880befb0cd8, len=3D512
> [ 8710.270073] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
> [ 8710.270081] Last user: (bfq_put_queue+0xb0/0xe0)
> [ 8710.270085] 1f0: 18 e5 44 93 81 88 ff ff 6b 6b 6b 6b 6b 6b 6b a5
> ..D.....kkkkkkk.
> [ 8710.270092] Prev obj: start=3Dffff8880befb0ac0, len=3D512
> [ 8710.270097] Redzone: 0xd84156c5635688c0/0xd84156c5635688c0
> [ 8710.270102] Last user: (bfq_get_queue+0x13a/0x290)
> [ 8710.270105] 000: 02 00 00 00 00 00 00 00 00 38 a6 95 81 88 ff ff
> .........8......
> [ 8710.270110] 010: 07 00 03 00 07 00 03 00 00 00 00 00 00 00 00 00
> ................
> [ 8711.077572] Slab corruption (Not tainted): bfq_queue
> start=3Dffff8880c20b7710, len=3D512
> [ 8711.077577] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
> [ 8711.077584] Last user: (bfq_put_queue+0xb0/0xe0)
> [ 8711.077586] 1f0: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00 00 00 00
> kkkkkkkk........
> [ 8711.077591] Prev obj: start=3Dffff8880c20b74f8, len=3D512
> [ 8711.077593] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
> [ 8711.077596] Last user: (bfq_put_queue+0xb0/0xe0)
> [ 8711.077598] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> kkkkkkkkkkkkkkkk
> [ 8711.077601] 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> kkkkkkkkkkkkkkkk
> [ 8711.077604] Next obj: start=3Dffff8880c20b7928, len=3D512
> [ 8711.077606] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
> [ 8711.077609] Last user: (bfq_put_queue+0xb0/0xe0)
> [ 8711.077611] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> kkkkkkkkkkkkkkkk
> [ 8711.077614] 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> kkkkkkkkkkkkkkkk
> [ 8764.014525] Slab corruption (Not tainted): bfq_queue
> start=3Dffff888049b0c108, len=3D512
> [ 8764.014534] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
> [ 8764.014542] Last user: (bfq_put_queue+0xb0/0xe0)
> [ 8764.014546] 1f0: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00 00 00 00
> kkkkkkkk........
> [ 8764.014553] Next obj: start=3Dffff888049b0c320, len=3D512
> [ 8764.014558] Redzone: 0xd84156c5635688c0/0xd84156c5635688c0
> [ 8764.014562] Last user: (bfq_get_queue+0x13a/0x290)
> [ 8764.014566] 000: 01 00 00 00 00 00 00 00 00 50 df 96 81 88 ff ff
> .........P......
> [ 8764.014571] 010: 04 00 02 00 04 00 02 00 00 00 00 00 00 00 00 00
> ................
> [10593.478355] perf: interrupt took too long (3936 > 3927), lowering
> kernel.perf_event_max_sample_rate to 50750
> [10745.055650] Slab corruption (Not tainted): bfq_queue
> start=3Dffff88818f6a9088, len=3D512
> [10745.055660] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
> [10745.055670] Last user: (bfq_put_queue+0xb0/0xe0)
> [10745.055675] 1f0: a0 f6 71 d4 80 88 ff ff 6b 6b 6b 6b 6b 6b 6b a5
> ..q.....kkkkkkk.
> [10745.055683] Next obj: start=3Dffff88818f6a92a0, len=3D512
> [10745.055688] Redzone: 0xd84156c5635688c0/0xd84156c5635688c0
> [10745.055693] Last user: (bfq_get_queue+0x13a/0x290)
> [10745.055698] 000: 01 00 00 00 00 00 00 00 00 38 a6 95 81 88 ff ff
> .........8......
> [10745.055704] 010: 04 00 02 00 04 00 02 00 00 00 00 00 00 00 00 00
> ................
> [12141.101100] usb 2-1.1.4: USB disconnect, device number 8
> pavel@duo:/data/l/linux-olpc$
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) =
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

