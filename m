Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E235C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95A52086D
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tower-research-com.20150623.gappssmtp.com header.i=@tower-research-com.20150623.gappssmtp.com header.b="Of4Fj0fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95A52086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tower-research.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeLMUes (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:34:48 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:34960 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMUer (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:34:47 -0500
Received: by mail-wr1-f50.google.com with SMTP id 96so3359316wrb.2
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 12:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tower-research-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=uia8NdYpP4YNLCKWFzt0lVj4Qj/ZMPTbFXBGYaokNu0=;
        b=Of4Fj0fvwgBCnD5Xw46vSmPRginbWuRvW7fpOfm6thOjMeYIQ+5MI1De2dckL3g/pf
         Nqc2fR8XzTEXuVBAPQdU+mWRiVx2hcnht9KMJg7fSXKrVlKSK0y9w/VQqqz8PWjkGrUX
         Xw5bLhNQP8KXy5ifyFEuAef+1spYf470IIX4IJhJH7acTVSvRCz2idyVrbA5MLC/G/fF
         5O2PdSIo2/ROaEPrfRY4rWQTMs/EME6pHo7i7kciWmQEjtplP1ebFr8XiGtUC496kjgV
         yHGENf7uux6wsKIs4SDJ9N/HfwyRIFsYBYKCpCcHzElu4K3nTmAJsT3rnIWXZhi3YGeu
         Ew6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uia8NdYpP4YNLCKWFzt0lVj4Qj/ZMPTbFXBGYaokNu0=;
        b=Nc1Qhmhq7XBgp80ODiANmiOP2BB+dqUrvbjiQ0FZWGxJiGQqnA6rxuOJRT1B5iPaiT
         PRy2QY/YfmVvVh0S4hZ1YthjVdNcORLEwYTKNQ1O2+/nICEA+AJSr5Sinh0xeRHFSexV
         Ifeh6YrIhDr1l+0Eu+PKoTWSftRzoexppf735Ji89H/m8YORWi/8OBwmPpMQG8c/0Wzt
         r5XjutPSbPvcd0+Fskoqw77rDJr/QnnxfbXqedjw3dGEk08WTkRuzVmI66PCYJNdxU5d
         IB1IY0lqJoA62HpunQW+83rk+CIaI2tILB55fBFo4EaLa8/QrHTj8p9JL/i41a6Hc4+S
         llwQ==
X-Gm-Message-State: AA+aEWb6IijsUM7pAplTgi/gN3y8Bc6N/pTuIZzzNbg1wD6k7/7WkCtl
        QjKWUEUWGn1y9SHOFNTV/DIpxY5D4wQXtm7bdLBkqIO199Y=
X-Google-Smtp-Source: AFSGD/VWvxmCLLMUnlmWlZWXsRa1mrlC9C1MUab9BIfr3af7kTqMUndjRH5Kpr/cDNPsN/2SV0UWsvGTPfr7AUwLuzU=
X-Received: by 2002:adf:8228:: with SMTP id 37mr231422wrb.160.1544733285730;
 Thu, 13 Dec 2018 12:34:45 -0800 (PST)
MIME-Version: 1.0
From:   Madhav Ancha <mancha@tower-research.com>
Date:   Thu, 13 Dec 2018 15:34:09 -0500
Message-ID: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
Subject: Unintuitive scheduling results using BFQ
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In our setup, we have a task that writes to a NVMe SSD drive using the
page cache. (using ::write os calls). This task does application level
buffering and sends big (large MBs) chunks of data to ::write call.
Each instance of the task writes upto 10Gbps of data to the NVME SSD.

We run two instances of this task as below.
Instance 1: Using ionice -c1, we run a RT IO instance of this task.
Instance 2: We run a normal (best-effort) IO instance of this task.

Both the write task instances compete for NVMe bandwidth. We observe
that BFQ allocates equal bandwidth to both the task instances starting
a few seconds after they start up.

What we expected is that Instance1 (IOPRIO_CLASS_RT scheduling class)
will be granted all the bandwidth it asked for while Instance2 will be
allowed to consume the remaining bandwidth.

Could you please help us understand how we may be able to design to
get our expected behavior.

Thanks
