Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC95EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 29 Nov 2021 15:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhK2Pnb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Nov 2021 10:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhK2Pla (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Nov 2021 10:41:30 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D4C09CE42
        for <linux-block@vger.kernel.org>; Mon, 29 Nov 2021 05:46:20 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z8so7291205ilu.7
        for <linux-block@vger.kernel.org>; Mon, 29 Nov 2021 05:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=hl5Za4mpIb0SL/qd0APOvED9t8pV+X1r9kqmjSfSrgM=;
        b=eZsGBKQYA3AZlKygoTjqTCdU1O5iLaAWespWmhsDbnzyhHu/6druza6sDIQ5kuDCuD
         475lwdxY1xDvDUYxtbFP8RKlv4An1m9UizK05JW1BaSRbe87Ax66yDLEvgVDvpAn583y
         2RXLgwiUc4k7HeI8lu7P/BxINVzAiIWxmWLS0kd9W2cFLrGyihVtlRlHTsandVlUk2JM
         KyqFkjLCpJ72Onnd+HFPTm1a2qt4cVZIDv/kIzSEeWL+fwgI2ZhYZW6hFw/+NIOKxVRa
         OyC+ujResUczyUwQs7UQTnnNT+BgBuW8A5X7MNiIXfg1Tmcksp8CQ6jM26jNA3jtXQ9p
         ASfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=hl5Za4mpIb0SL/qd0APOvED9t8pV+X1r9kqmjSfSrgM=;
        b=jlto3fb/K1F5slPkcbjejFGO0QDJKbNT5Y2pX3w6mPukYJzkeM17z8cpmMxzzsVhSM
         Zc5/PLK+7uOQ8Nbl5knKvdnhv9cZj5AqbkhIle5rQLIJyTaRlTDDbQ+JPl0Jcopx1t2W
         mELmNn/420OxwvdTZovHsGybqZjlbGEbz3WbxTVUeS+ChMpCp+gu/7/Cuf2OktzI9uf8
         n4exGRC82rVZrqgMQRj7h6puMBpAmdHi2JFmLUtH2qrpjj4w3BePUxg7EqmnLKdyeOrY
         uIY4Zl8Aj3AHLYHxHMnnJJ6ojzShymU+u6kpmpBBjvgYhBzKf7mCIQPPg9RsJPRfTKnm
         CIvw==
X-Gm-Message-State: AOAM530MWed+EGGnBHYPTjHMKIGAzKpjJUbaQU8dlDMDiJM+fh7T/LFN
        pDNjkHoDbIgxPHbTuizjFo8JG3p8I8aRGxAG
X-Google-Smtp-Source: ABdhPJw9V7S9eXO364y5xRo+oh9SqoIrjUyF89rVN1djB8q6Bx2jMMB7rNG3WC9CFrzn646Y0Hd8zg==
X-Received: by 2002:a92:d405:: with SMTP id q5mr543827ilm.212.1638193579842;
        Mon, 29 Nov 2021 05:46:19 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g5sm10500619ioo.18.2021.11.29.05.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:46:19 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     ming.lei@redhat.com
In-Reply-To: <20211129012659.1553733-1-yebin10@huawei.com>
References: <20211129012659.1553733-1-yebin10@huawei.com>
Subject: Re: [PATCH -next] block: Fix fsync always failed if once failed
Message-Id: <163819357457.61510.7885347054893018948.b4-ty@kernel.dk>
Date:   Mon, 29 Nov 2021 06:46:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 29 Nov 2021 09:26:59 +0800, Ye Bin wrote:
> We do test with inject error fault base on v4.19, after test some time we found
> sync /dev/sda always failed.
> [root@localhost] sync /dev/sda
> sync: error syncing '/dev/sda': Input/output error
> 
> scsi log as follows:
> [19069.812296] sd 0:0:0:0: [sda] tag#64 Send: scmd 0x00000000d03a0b6b
> [19069.812302] sd 0:0:0:0: [sda] tag#64 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
> [19069.812533] sd 0:0:0:0: [sda] tag#64 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK
> [19069.812536] sd 0:0:0:0: [sda] tag#64 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
> [19069.812539] sd 0:0:0:0: [sda] tag#64 scsi host busy 1 failed 0
> [19069.812542] sd 0:0:0:0: Notifying upper driver of completion (result 0)
> [19069.812546] sd 0:0:0:0: [sda] tag#64 sd_done: completed 0 of 0 bytes
> [19069.812549] sd 0:0:0:0: [sda] tag#64 0 sectors total, 0 bytes done.
> [19069.812564] print_req_error: I/O error, dev sda, sector 0
> 
> [...]

Applied, thanks!

[1/1] block: Fix fsync always failed if once failed
      commit: 8a7518931baa8ea023700987f3db31cb0a80610b

Best regards,
-- 
Jens Axboe


