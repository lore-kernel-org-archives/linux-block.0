Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A412EB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 18:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjGKSp2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGKSp1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 14:45:27 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F396E8
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 11:45:26 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b8bd586086so45244435ad.2
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 11:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689101126; x=1691693126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UsRC0WLlksxzONYQqoYU5eIC4cHj6Uzu7QwuNHEvDQ=;
        b=RnOX47Spyg1ov0QBusDuIfpfIM5fVrfNLFYeXnSPrnrMp/1L7XfrUo5A/56oPZ2HeW
         qx+usUZ5VSyAib+AR+TS8WFfyXbTR13yBDFS1wyYFZZ55oDTjYm0mmnGdzObImk6BmbB
         fJ6EcBGLNjJYAdqGtuBfOwwQswn0o18m0rRpoqkP3ssuG2o4W0AzBDtvcELj7BpbcIpP
         KqjVkLazzdz3iybLVHh9x/4zKHy0K+tZyd4RajQH3NmlQ7zs10IFJFWRivryxIayd8f4
         dPxPXucNnDOAj+OV8LQRkq6K3duDu7ZhK2aAPMe/Ix1vENDMf9lXTYMBlIz7x00TYN3E
         uQiQ==
X-Gm-Message-State: ABy/qLY93CD04Ubu28KSJyjmBC9diOBjxROhJfZRkqV+A3rpwEDCSSEJ
        4dmV4QLV5rolJ0NjrBH9SoDRaadSzQo=
X-Google-Smtp-Source: APBJJlEVpnyoKx0ljbe1fa0Ny6zTXn1epAcOg+kXq/6oz2O7vhlDUlR0YRMm2Fs4fZ3kaEJhsOA7vg==
X-Received: by 2002:a17:903:22c6:b0:1b8:72e2:c63 with SMTP id y6-20020a17090322c600b001b872e20c63mr20016993plg.8.1689101125514;
        Tue, 11 Jul 2023 11:45:25 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:218:86d6:e8cc:733? ([2620:15c:211:201:218:86d6:e8cc:733])
        by smtp.gmail.com with ESMTPSA id v4-20020a1709029a0400b001b83dc8649dsm2253710plp.250.2023.07.11.11.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 11:45:25 -0700 (PDT)
Message-ID: <75043b78-c1f8-5268-ade6-62a75f25708c@acm.org>
Date:   Tue, 11 Jul 2023 11:45:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] EIO of zoned block device writes
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>
References: <5zthzi3lppvcdp4nemum6qck4gpqbdhvgy4k3qwguhgzxc4quj@amulvgycq67h>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5zthzi3lppvcdp4nemum6qck4gpqbdhvgy4k3qwguhgzxc4quj@amulvgycq67h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/23 00:50, Shinichiro Kawasaki wrote:
> With kernel version v6.5-rc1, I observed an I/O error during a fio run on zoned
> block devices. I bisected and found that the commit 0effb390c4ba ("block:
> mq-deadline: Handle requeued requests correctly") is the trigger. When I revert
> this commit from v6.5-rc1, the error disappears.
> 
> At first, the error was observed as a test case failure of fio test script for
> zoned block devices (t/zbd/test-zbd-support, #34), using a QEMU ZNS emulation
> device with 4MB zone size. The failure was also observed with a zoned null_blk
> device with 4MB zone size and memory backed option. The error was observed with
> real ZNS drives with 2GB zone size as well.
> 
> I simplified the fio test script and confirmed that the short script below [1]
> recreates the error using the null_blk device with 4MB zone size and memory
> backed option.
> 
> The trigger commit modifies the order to dispatch write requests to zones. To
> check the write requests dispatched to the null_blk device, I took blktrace [2].
> It shows that 1MB write to the first zone (sector 0) is divided into size of 255
> sectors. One of the divided write requests was dispatched to the zone but it was
> not a write at zone start, then it caused the I/O error. I think this I/O error
> is caused by unaligned write command error on the device. Later on, another
> write request to the zone start was dispatched. So, it does not look the write
> requests are well ordered.
> 
> I call for a help to resolve this issue. If any actions on my test systems will
> help, please let me know.
> 
> 
> [1]
> 
> #!/bin/bash
> 
> dev=$1
> realdev=$(readlink -f "$dev")
> basename=$(basename "$realdev")
> 
> echo mq-deadline >"/sys/block/$basename/queue/scheduler"
> blkzone reset $dev
> 
> fio --name=job --filename="${dev}" --ioengine=libaio --iodepth=256 \
>      --rw=randwrite --bs=1M --offset=0 --size=16M \
>      --zonemode=zbd --direct=1 --zonesize=4M
> 
> [2]
> 
> ...
> 251,0    1      136     0.871020525  1300  Q  WS 0 + 2048 [fio]
> 251,0    1      137     0.871025680  1300  X  WS 0 / 255 [fio]
> 251,0    1      138     0.871027679  1300  G  WS 0 + 255 [fio]
> 251,0    1      139     0.871028675  1300  I  WS 0 + 255 [fio]
> 251,0    1      140     0.871038432  1300  X  WS 255 / 510 [fio]
> 251,0    1      141     0.871040086  1300  G  WS 255 + 255 [fio]
> 251,0    1      142     0.871040949  1300  I  WS 255 + 255 [fio]
> 251,0    1      143     0.871050035  1300  X  WS 510 / 765 [fio]
> 251,0    1      144     0.871051688  1300  G  WS 510 + 255 [fio]
> 251,0    1      145     0.871052551  1300  I  WS 510 + 255 [fio]
> 251,0    3        8     0.871054865  1115  C  WS 24576 + 765 [0]
> 251,0    1      146     0.871061570  1300  X  WS 765 / 1020 [fio]
> 251,0    1      147     0.871063327  1300  G  WS 765 + 255 [fio]
> 251,0    1      148     0.871064204  1300  I  WS 765 + 255 [fio]
> 251,0    1      149     0.871073358  1300  X  WS 1020 / 1275 [fio]
> 251,0    1      150     0.871075004  1300  G  WS 1020 + 255 [fio]
> 251,0    3        9     0.871075262  1115  D  WS 510 + 255 [kworker/3:2H] ... Write not at zone start
> 251,0    1      151     0.871075921  1300  I  WS 1020 + 255 [fio]
> 251,0    3       10     0.871077227  1115  C  WS 0 + 765 [65531]  ... I/O error
> 251,0    1      152     0.871085051  1300  X  WS 1275 / 1530 [fio]
> ...
> 251,0    3      281     0.904191667  1115  D  WS 0 + 255 [kworker/3:2H] ... Write at zone start comes after
> 251,0    3      282     0.904445591  1115  C  WS 0 + 255 [0]
> ...

Thank you for the detailed report. Does this patch help?

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6aa5daf7ae32..02a916ba62ee 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -176,7 +176,7 @@ static inline struct request 
*deadline_from_pos(struct dd_per_prio *per_prio,
  	 * zoned writes, start searching from the start of a zone.
  	 */
  	if (blk_rq_is_seq_zoned_write(rq))
-		pos -= round_down(pos, rq->q->limits.chunk_sectors);
+		pos = round_down(pos, rq->q->limits.chunk_sectors);

  	while (node) {
  		rq = rb_entry_rq(node);

