Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489AFC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 19:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A49120672
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 19:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iUw/H9pJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A49120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLGToi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:44:38 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37526 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeLGToi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 14:44:38 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so8856897iti.2
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 11:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o8+U0qzb5/iVzQvjWeZovBuvtnLCD8VDfkj4bJvkxH8=;
        b=iUw/H9pJ4AXoh+G1XFleoTFyXrZCPNmkfbAp9rs7x3c5ThXYJSB/tIl5WXuUBNpJdG
         57mg8vMR9up2jItBdWbf0UVaYPNo+OYnmrollDQYWdKAxHA7hRPoL9sTOXsR4Ixmooxa
         ygehyL31Ti9DsN9OEN/mWd+2UwDyZ0GkJ1TAJ9OEpGsSYwXOI85GeaNrvkia8v5Z+KRf
         3RWEjltnAH3BLqQYKNzi7r3MUayc9VjNrN2LWtnJ99Qp1EUSCDDHVKz1fK7SLsWGUKUh
         3QR1n7eJ++5Dvz6vZDUq1c/xaBCnIn/y2jRN7v7Y0tV345ziAPBRltMMzoVEp63fY7O/
         pHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o8+U0qzb5/iVzQvjWeZovBuvtnLCD8VDfkj4bJvkxH8=;
        b=E1aW5IcPJdLc18xS+lnt5ezM1DsvfsMW/mkG32dx4mALsA/txavFutwJundasqlhLO
         BuLYe6AQcMJ8R/pQZ0T4JTHu7xgBFC2zK5uFOIuSWVsW+yWiMOX2cHy3rx8GumJJ5KVY
         pSeqSTWxEPIoWIzkexrQtguKv4q4zXl0m8wFGzxyjRUClArEeLziHA4ZSsdfZGHbWXmU
         ZxXdkFIZyVQIXNY0IJR7tiPx6tsW30ic1HLeQzHDd86is5HP5uyFHyfucshhiUOOCUMD
         shWMwJmv5d33UmrirSey2Y65ZxDjrs1PvMwRGATVorRj4mKVkBKjOBDPQz35tWkkuIm5
         HcDA==
X-Gm-Message-State: AA+aEWaRK2ava6GcEDtCrZcUhYuGcqD48UUHaIAUkPtxZv+P46y60amE
        8LtfNL5uQU2fHXJs3tKAtwTsDQ==
X-Google-Smtp-Source: AFSGD/VhucSOfpxMHDpT2oZeo4+yPSpfsgxirxDSg3dSFOla5UnrRWWB375wGpr807W3sWAT0rtBdQ==
X-Received: by 2002:a02:781e:: with SMTP id p30mr3100557jac.85.1544211876901;
        Fri, 07 Dec 2018 11:44:36 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 21sm1743861iou.79.2018.12.07.11.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 11:44:35 -0800 (PST)
Subject: Re: [GIT PULL] first batch of nvme updates for 4.21
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20181207192046.GA19243@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eed3dc6e-d01e-64b6-6d3b-43d81b54660e@kernel.dk>
Date:   Fri, 7 Dec 2018 12:44:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207192046.GA19243@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/18 12:20 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> please pull this first batch of nvme updates for Linux 4.21.
> 
> Highlights:
>  - target support for persistent discovery controllers (Jay Sternberg)
>  - target optimizations to use non-blocking reads (Chaitanya Kulkarni)
>  - host side support for the Enhanced Command Retry TP (Keith Busch)
>  - host and target support for traffic based keep alive (Sagi Grimberg)
>  - host and target support for disabling SQ based flow control (Sagi Grimberg)
> 
> Plus all kinds of optimizations and cleanups from the usual suspects.
> 
> The following changes since commit 43e497feb3987c868f87c7ca1470c5937689fe01:
> 
>   blk-mq: re-build queue map in case of kdump kernel (2018-12-06 22:52:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.21
> 
> for you to fetch changes up to 48fd68b3c5c66af6e0004787a54765a8d040989b:
> 
>   nvme: remove unused function nvme_ctrl_ready (2018-12-07 11:16:38 -0800)
> 
> ----------------------------------------------------------------
> Chaitanya Kulkarni (4):
>       nvme: consolidate memset calls in the nvme_setup_cmd path
>       nvmet: use IOCB_NOWAIT for file-ns buffered I/O
>       nvmet: use unlikely for req status check
>       nvmet: fix the structure member indentation
> 
> Christoph Hellwig (1):
>       nvmet: mark nvmet_genctr static
> 
> Hannes Reinecke (1):
>       nvme: add a numa_node field to struct nvme_ctrl
> 
> Israel Rukshin (3):
>       nvme: Remove unused forward declaration
>       nvmet-rdma: Add unlikely for response allocated check
>       nvme: remove unused function nvme_ctrl_ready
> 
> James Smart (1):
>       nvmet-fc: remove the IN_ISR deferred scheduling options
> 
> Jay Sternberg (7):
>       nvmet: provide aen bit functions for multiple controller types
>       nvmet: change aen mask functions to use bit numbers
>       nvmet: allow Keep Alive for Discovery controller
>       nvmet: make kato and AEN processing for use by other controllers
>       nvmet: add defines for discovery change async events
>       nvmet: add support to Discovery controllers for commands
>       nvmet: enable Discovery Controller AENs
> 
> Keith Busch (1):
>       nvme: implement Enhanced Command Retry
> 
> Sagi Grimberg (9):
>       nvme: introduce ctrl attributes enumeration
>       nvme: cache controller attributes
>       nvme: support traffic based keep-alive
>       nvmet: support for traffic based keep-alive
>       nvmet: allow host connect even if no allowed subsystems are exported
>       nvmet: support fabrics sq flow control
>       nvmet: don't override treq upon modification.
>       nvmet: expose support for fabrics SQ flow control disable in treq
>       nvme: disable fabrics SQ flow control when asked by the user
> 
>  drivers/nvme/host/core.c          |  70 ++++++++++++++++++--
>  drivers/nvme/host/fabrics.c       |  13 +++-
>  drivers/nvme/host/fabrics.h       |   2 +
>  drivers/nvme/host/fc.c            |   5 +-
>  drivers/nvme/host/multipath.c     |   4 +-
>  drivers/nvme/host/nvme.h          |  13 ++--
>  drivers/nvme/host/rdma.c          |   5 +-
>  drivers/nvme/target/admin-cmd.c   |  76 ++++++++++++----------
>  drivers/nvme/target/configfs.c    |  42 ++++++++----
>  drivers/nvme/target/core.c        | 118 +++++++++++++---------------------
>  drivers/nvme/target/discovery.c   | 129 +++++++++++++++++++++++++++++++++++--
>  drivers/nvme/target/fabrics-cmd.c |   6 ++
>  drivers/nvme/target/fc.c          |  66 +------------------
>  drivers/nvme/target/io-cmd-file.c | 130 ++++++++++++++++++++++++--------------
>  drivers/nvme/target/nvmet.h       |  53 +++++++++++++---
>  drivers/nvme/target/rdma.c        |   2 +-
>  include/linux/nvme-fc-driver.h    |  16 -----
>  include/linux/nvme.h              |  51 +++++++++++++--
>  18 files changed, 514 insertions(+), 287 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

