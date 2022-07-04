Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC38C433EF
	for <linux-block@archiver.kernel.org>; Mon,  4 Jul 2022 23:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiGDXE7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 19:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiGDXE7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 19:04:59 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675EDEBE
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 16:04:57 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id q9so15144669wrd.8
        for <linux-block@vger.kernel.org>; Mon, 04 Jul 2022 16:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3iPb1uwa1fPfHppzvLU9rHvh0oUB4hSiMAfifeyLX24=;
        b=Izv4IW8AI1baYzJtFqu7A2Jnh9KTU0DtAakCSe49qYhAx5FR0dZfvYOLWG02sZKeFB
         3xSUpeFR4zr5diRfKgJLNBfm8UEt8eIOQTHT7DjJl5UqvHbpYhPD07ER/mq4WnovLVMy
         gBfgq4Mv7nvszl40CB0CuAso7Yizbjyn1r7LO+pFzCFoFkWk1YovdllXV7P56lswN/BA
         jYYQnmLKQrpGaqA41FpSy7DjhgRRrbNohZ97YTkxuK7eG06kEIFEQL8Vod61tnfivQIf
         PkSWHuIS7rCr6hJtAAWo3Ewtudn1PaD0jfwY4Ys4tJoVMbYRVenbEPGq95CbWQdYcPA9
         1Ddw==
X-Gm-Message-State: AJIora8wacVzammqDWZF+fmpCDnLfGZJ9vz7lmIiW0CpMMNB1NK+uihb
        8jv9lVr0VfjGYDTmXxjLmmo=
X-Google-Smtp-Source: AGRyM1vpSmj7Wkc4yoYCw/LOEo7TDl1/XOsTN1ySnSXCzObyaIfDpJxYLCBDixArytk+F9NvaSaC5w==
X-Received: by 2002:adf:fb49:0:b0:21a:3ccc:fb77 with SMTP id c9-20020adffb49000000b0021a3cccfb77mr28242775wrs.280.1656975895818;
        Mon, 04 Jul 2022 16:04:55 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id b6-20020adff906000000b0021d6a23fdf3sm4104231wrr.15.2022.07.04.16.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 16:04:55 -0700 (PDT)
Message-ID: <2c42c70a-8eb4-a095-1d2b-139614ebd903@grimberg.me>
Date:   Tue, 5 Jul 2022 02:04:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] nvme/rdma: nvme connect failed after offline one cpu
 on host side
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
References: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
 <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> update the subject to better describe the issue:
> 
> So I tried this issue on one nvme/rdma environment, and it was also
> reproducible, here are the steps:
> 
> # echo 0 >/sys/devices/system/cpu/cpu0/online
> # dmesg | tail -10
> [  781.577235] smpboot: CPU 0 is now offline
> # nvme connect -t rdma -a 172.31.45.202 -s 4420 -n testnqn
> Failed to write to /dev/nvme-fabrics: Invalid cross-device link
> no controller found: failed to write to nvme-fabrics device
> 
> # dmesg
> [  781.577235] smpboot: CPU 0 is now offline
> [  799.471627] nvme nvme0: creating 39 I/O queues.
> [  801.053782] nvme nvme0: mapped 39/0/0 default/read/poll queues.
> [  801.064149] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
> [  801.073059] nvme nvme0: failed to connect queue: 1 ret=-18

This is because of blk_mq_alloc_request_hctx() and was raised before.

IIRC there was reluctance to make it allocate a request for an hctx even
if its associated mapped cpu is offline.

The latest attempt was from Ming:
[PATCH V7 0/3] blk-mq: fix blk_mq_alloc_request_hctx

Don't know where that went tho...
