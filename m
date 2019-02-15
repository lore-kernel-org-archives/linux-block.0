Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8130CC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 21:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B44222DD
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 21:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfBOVlh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:41:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46878 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbfBOVlh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 16:41:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so5368891pgp.13
        for <linux-block@vger.kernel.org>; Fri, 15 Feb 2019 13:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivuDJInjFhflpXCG/L1y80SLN6+S1TKlhZF42sD6JrU=;
        b=NX5OLk2aVY0gqhOCQk6xCUa1KfyYjzJKiCS8/cHdPpCbdEHL77TxwUBHY2rXJEQr5I
         YFHx+k2VFA88B12YB4oF+IMVbqV1mjv+fEYf+oZvJD7/z864vpTiH3lMC6Oo/h9xtA8d
         jCUk9EgIkzEJ2vjWAA6NoarRqOrjt9U2oT+6uaCscw+aV1uwZGxFGHs14SIhpHfcCJBg
         itvk36DRPl/wFPMOJYPA6SDXqKuHYBjSfWqUUwlmV/2reuMihckJGj1Tcj3zAU0659GF
         ge4JR82AJ1HfRHqdkRSPPpAyyUodGqvHUYkKyp7isRqC5VzY/GP1cXB/qQf3crRduIOb
         ueRg==
X-Gm-Message-State: AHQUAua1Fe4mYDyReiyfBT1KqzM9rfyCipjTWetnON7eyR2kZ3VnYmCG
        PpeKSNTNq9FNjYBDg2CQ5FU=
X-Google-Smtp-Source: AHgI3Iaqg0xrip9tpj9bjeDf590tJynKASQVwtii80Hzso9n/I7rxiBSprpCtnPh9lNCTEapSD9/uw==
X-Received: by 2002:a62:4188:: with SMTP id g8mr12164125pfd.205.1550266896350;
        Fri, 15 Feb 2019 13:41:36 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 64sm16126228pfl.83.2019.02.15.13.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 13:41:35 -0800 (PST)
Message-ID: <1550266894.31902.104.camel@acm.org>
Subject: Re: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
From:   Bart Van Assche <bvanassche@acm.org>
To:     Felipe Franciosi <felipe@nutanix.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Date:   Fri, 15 Feb 2019 13:41:34 -0800
In-Reply-To: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
References: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-02-15 at 21:19 +-0000, Felipe Franciosi wrote:
+AD4 Hi All,
+AD4 
+AD4 I'd like to attend LSF/MM this year and discuss the kernel performance when accessing NVMe devices, specifically (but not limited to) Intel Optane Memory (which boasts very low latency and high
+AD4 iops/throughput per NVMe controller).
+AD4 
+AD4 Over the last year or two, I have done extensive experimentation comparing applications using libaio to those using SDPK. For hypervisors, where storage devices can be exclusively accessed with
+AD4 userspace drivers (given the device can be dedicated to a single process), using SPDK has proven to be significantly faster and more efficient. That remains true even in the latest versions of the
+AD4 kernel.
+AD4 
+AD4 I have presented work focusing on hypervisors in several conferences during this time. Although I appreciate the LSF/MM is more discussion-oriented, I am linking a couple of these presentations for
+AD4 reference:
+AD4 
+AD4 Flash Memory Summit 2018
+AD4 https://www.flashmemorysummit.com/English/Collaterals/Proceedings/2018/20180808+AF8-SOFT-202-1+AF8-Franciosi.pdf
+AD4 
+AD4 Linux Piter 2018
+AD4 https://linuxpiter.com/system/attachments/files/000/001/558/original/20181103+AF8--+AF8-AHV+AF8-and+AF8-SPDK.pdf
+AD4 
+AD4 For LSF/MM, instead of focusing on hypervisors, I would like to discuss what can be done to achieve better efficiency and performance when using the kernel. My data include detailed results
+AD4 considering various scenarios like different NUMA configurations, IRQ affinity and polling modes.

Hi Felipe,

It seems like you missed the performance comparison between SPDK and io+AF8-uring
Jens posted recently?

Bart.
