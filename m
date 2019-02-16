Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C32C43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 01:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC90222D9
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 01:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfBPBBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 20:01:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41012 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfBPBBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 20:01:45 -0500
Received: by mail-pl1-f193.google.com with SMTP id y5so211480plk.8
        for <linux-block@vger.kernel.org>; Fri, 15 Feb 2019 17:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+C5kpP6YcNzQBaqiOd2KpdjorPk2IyQ8TfvWyizXqD4=;
        b=AEUiB9Hq1ZQFyUa4tpu5lQQaw/g9cVy/PwFFc8MJZIj1SNjr/vPhqxLHgBZK/H3nbL
         fn3bLkTOFUNsFulhX/qCsnKlOJ1aKHZy/C+dWMgbJ1KykL2/5PVq13m4PpepOUI6ljaf
         PnCPBOkaJdWooESY+bDApPHNdW+HX9i/WM8anj3+ut7yo26DzcgrpepHWT/AzKMQdx5P
         x67Cd+iwbTAtub+rTAQuOu9myvExD6kEO1i2mbQwfFQjyrDIou/Km/SanGhqW9KpUYtg
         OibevBy/21SY1CTu4s0ddUulsS8t8cuFsKGW9LeBNKTeUliApnJctIh6IjbM2/uhnIp4
         VMxA==
X-Gm-Message-State: AHQUAuae/wN+uxMbkzPjHInN6IiN3mu1ePJmkH3rThFjw4Vl9qBQCxVU
        OUCUdiwGBqce50om/y62tbc=
X-Google-Smtp-Source: AHgI3IZtuB/dskPquIgK1TJfun34ILQvcc3/H/QZb1Ds1pDQtsKLobv5z7fm8Y3WU6/Q+9YiBFxRZA==
X-Received: by 2002:a17:902:7c83:: with SMTP id y3mr13010581pll.260.1550278903862;
        Fri, 15 Feb 2019 17:01:43 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d11sm10118941pgi.25.2019.02.15.17.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 17:01:43 -0800 (PST)
Message-ID: <1550278901.31902.109.camel@acm.org>
Subject: Re: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
From:   Bart Van Assche <bvanassche@acm.org>
To:     Felipe Franciosi <felipe@nutanix.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Date:   Fri, 15 Feb 2019 17:01:41 -0800
In-Reply-To: <11A6C7D0-A26D-410F-8EE3-9AF524DF2050@nutanix.com>
References: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
         <1550266894.31902.104.camel@acm.org>
         <11A6C7D0-A26D-410F-8EE3-9AF524DF2050@nutanix.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 2019-02-16 at 00:53 +-0000, Felipe Franciosi wrote:
+AD4 On Feb 15, 2019, at 9:41 PM, Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 On Fri, 2019-02-15 at 21:19 +--0000, Felipe Franciosi wrote:
+AD4 +AD4 +AD4 Hi All,
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 I'd like to attend LSF/MM this year and discuss the kernel performance when accessing NVMe devices, specifically (but not limited to) Intel Optane Memory (which boasts very low latency and high
+AD4 +AD4 +AD4 iops/throughput per NVMe controller).
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Over the last year or two, I have done extensive experimentation comparing applications using libaio to those using SDPK. For hypervisors, where storage devices can be exclusively accessed with
+AD4 +AD4 +AD4 userspace drivers (given the device can be dedicated to a single process), using SPDK has proven to be significantly faster and more efficient. That remains true even in the latest versions of
+AD4 +AD4 +AD4 the
+AD4 +AD4 +AD4 kernel.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 I have presented work focusing on hypervisors in several conferences during this time. Although I appreciate the LSF/MM is more discussion-oriented, I am linking a couple of these presentations
+AD4 +AD4 +AD4 for
+AD4 +AD4 +AD4 reference:
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Flash Memory Summit 2018
+AD4 +AD4 +AD4 https://urldefense.proofpoint.com/v2/url?u+AD0-https-3A+AF8AXw-www.flashmemorysummit.com+AF8-English+AF8-Collaterals+AF8-Proceedings+AF8-2018+AF8-20180808-5FSOFT-2D202-2D1-5FFranciosi.pdf+ACY-d+AD0-DwICgQ+ACY-c+AD0-s883GpUCOChKOHiocYtGcg+ACY-r+AD0
+AD4 +AD4 +AD4 CCrJKVC5zGot8PrnI-iYe00MdX4pgdQfMRigp14Ptmk+ACY-m+AD0-gpN7ZCCTDgrYuN3cZ0TceD2QUDAUeJEnwR0A-OUNju4+ACY-s+AD0-adckJANXPcBu177wFlVmO4pB3jPFZOdggibVfmLERr8+ACY-e+AD0
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Linux Piter 2018
+AD4 +AD4 +AD4 https://urldefense.proofpoint.com/v2/url?u+AD0-https-3A+AF8AXw-linuxpiter.com+AF8-system+AF8-attachments+AF8-files+AF8-000+AF8-001+AF8-558+AF8-original+AF8-20181103-5F-2D-5FAHV-5Fand-5FSPDK.pdf+ACY-d+AD0-DwICgQ+ACY-c+AD0-s883GpUCOChKOHiocYtGcg+ACY-r+AD0-CCrJKV
+AD4 +AD4 +AD4 C5zGot8PrnI-iYe00MdX4pgdQfMRigp14Ptmk+ACY-m+AD0-gpN7ZCCTDgrYuN3cZ0TceD2QUDAUeJEnwR0A-OUNju4+ACY-s+AD0-TdfWF887BHpEvwQ+AF8AXw-kNNTFNe1uaKoIjDZ-gW4qr6UxE+ACY-e+AD0
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 For LSF/MM, instead of focusing on hypervisors, I would like to discuss what can be done to achieve better efficiency and performance when using the kernel. My data include detailed results
+AD4 +AD4 +AD4 considering various scenarios like different NUMA configurations, IRQ affinity and polling modes.
+AD4 +AD4  
+AD4 +AD4 Hi Felipe,
+AD4 +AD4 
+AD4 +AD4 It seems like you missed the performance comparison between SPDK and io+AF8-uring
+AD4 +AD4 Jens posted recently?
+AD4 
+AD4 I configured 5.0-rc6 and had a look at the io+AF8-uring code. Finally worked out how to use FIO's t/io+AF8-uring to submit IO and poll completions without system calls. My +AF8-initial+AF8 numbers still show SPDK
+AD4 being faster and more efficient.
+AD4 
+AD4 Searching the lists, I found a few mentions that Jens published a comparison stating otherwise, but I can't find it. Could you please give me some pointers?

Hi Felipe,

This is probably what you are looking for:

https://lore.kernel.org/linux-block/20190116175003.17880-1-axboe+AEA-kernel.dk/

Bart.
