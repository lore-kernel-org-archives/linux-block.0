Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CD4C6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 02:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjC1Cyd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 22:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1Cyc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 22:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7561026B2
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 19:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679972025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=HqW+pMGwvicEPTdXpzmrQh9kZBDdX/BOgKYgzHMfyRg=;
        b=f2MbFMfURIOWHzHa8TCqF5IegLiyvCkAHJVHk2f9WIgZ8nYh8QGWDRFNzNYGu2wtkkmW0m
        /XxCNJB/Fq6s+5PQXTQoV3NLXH7+2nZoxwhK8qr7wDHhJ+sG2recHj6bzu4XDhbqBfb09T
        E8P2Ujs4jI6NnwWExiBD4bYbdLj6jJM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-HENJ_cwcM3eFiTi7e37Hyg-1; Mon, 27 Mar 2023 22:53:43 -0400
X-MC-Unique: HENJ_cwcM3eFiTi7e37Hyg-1
Received: by mail-pg1-f197.google.com with SMTP id m12-20020a6562cc000000b0050bdfabc8e2so2745348pgv.9
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 19:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679972023;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqW+pMGwvicEPTdXpzmrQh9kZBDdX/BOgKYgzHMfyRg=;
        b=3YCkwq9Q/vIj4QMtMesYou1QnQnChuZzd/lqxW045Y0vc0BCT4Xqd3xKFAcXgL/v1o
         J22iXHjhjlhqzRPD1upn474z0o9vIlySbkkO2oF3OXUNhGceNmsu71pFNlDe6VDGl/Vd
         Npz4zV6rKUEZjkaisbpMMWTV2S+eneF9ON1dU/UzvQTOwfvDawZg+T3gH13pxK9ZEvyx
         r84Hf4txm1y2Hyg712F0ekbdR/eQ1fYjzEpySJtk4d0dqwvB6szH5ds2dW0EmMrvfk+w
         lS7BJvExRuGYLDgu2VaAwX4pRn11qFwOibDdZBG6i1F+seXeJzdcYhWWZjVNSvMog6pb
         Hxaw==
X-Gm-Message-State: AAQBX9cJAo+ChRNF8cAXGPeSr/smjMf6EPsoNVvXwBALaSQ3cuhfW7Xw
        LsTpQ+dq84tPt5GuybVS5OFSYX6qu/HIaZQX31NMjZQgDWrawZEWMrLsg2Q0p9XZeOSIfE4/2kO
        +7pewGwRkmAC4OEwzG31AxA92ZFfWQ3IpIcCMwZY=
X-Received: by 2002:a63:4d52:0:b0:507:68f8:4369 with SMTP id n18-20020a634d52000000b0050768f84369mr3738943pgl.12.1679972022933;
        Mon, 27 Mar 2023 19:53:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350as7d4mCo4A5Oaf9a1ol3367Um5f7mqIZWwV7iCjwhAnGV9p82DfMHQfkSrA38VorVRGrVIngRMXpyXieUDUxo=
X-Received: by 2002:a63:4d52:0:b0:507:68f8:4369 with SMTP id
 n18-20020a634d52000000b0050768f84369mr3738942pgl.12.1679972022631; Mon, 27
 Mar 2023 19:53:42 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 28 Mar 2023 10:53:31 +0800
Message-ID: <CAHj4cs_RuqDeoZhbqZgMTx1oQBN+mwFgTpuwE4h0PV0LHYQCpw@mail.gmail.com>
Subject: [regression][bisected] blktests scsi/004 failed
To:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     john.g.garry@oracle.com,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

I found blktests scsi/004 failed[2] on the latest linux-scsi/for-next,
bisecting shows it was introduced from[1], pls help check it and let
me know if you need any testing for it, thanks.

[1]
151f0ec9ddb5 (HEAD) scsi: scsi_debug: Drop sdebug_dev_info.num_in_q
[2]
+ ./check scsi/004
scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out
command) [failed]
    runtime  1.889s  ...  1.851s
    --- tests/scsi/004.out 2023-03-27 02:51:16.755636763 -0400
    +++ /root/blktests/results/nodev/scsi/004.out.bad 2023-03-27
22:49:53.511526901 -0400
    @@ -1,3 +1,2 @@
     Running scsi/004
    -Input/output error
     Test complete
dmesg:
[  268.314709] run blktests scsi/004 at 2023-03-27 22:49:51
[  268.325391] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[  268.325398] scsi host0: scsi_debug: version 0191 [20210520]
                 dev_size_mb=8, opts=0x0, submit_queues=1, statistics=1
[  268.325575] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug
  0191 PQ: 0 ANSI: 7
[  268.325693] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  268.325775] sd 0:0:0:0: Power-on or device reset occurred
[  268.345884] sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39
MB/8.00 MiB)
[  268.355905] sd 0:0:0:0: [sda] Write Protect is off
[  268.355909] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
[  268.375943] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  268.406011] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[  268.406016] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
[  268.537442] sd 0:0:0:0: [sda] Attached SCSI disk
[  270.067115] sd 0:0:0:0: [sda] Synchronizing SCSI cache


-- 
Best Regards,
  Yi Zhang

