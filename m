Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B44C54EE9
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 14:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiIHOmO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 10:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiIHOmA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 10:42:00 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BF211364D
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 07:41:56 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i77so14233715ioa.7
        for <linux-block@vger.kernel.org>; Thu, 08 Sep 2022 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=eWi2LVN2gecP1iaDEZcOslHil4OGn6GfTQ/ywsJxRU4=;
        b=LKjkr2bv+FmCGfu/Wp+AD7fL5K2pMWUUr/vV1s25dbXJVUx4TqzGAbIbs3U+FdZr63
         EEMPNe4U/xW3wZjBLydVXb7nPwUitbFOhP21p+51luHDGlI3dTd3IkqtXQ/9ozFWmrpP
         3eCBO5dLwo0G5exrT/POHuU9YMjrmwsl9x5eaFnxTXtPsUqKdwVw7KV+suaLHEEqTaGn
         C0PCYewzgTcTwu/EhdpJ8446cqW/bEsR6CtOhbhVo10yxauhr6xdI5ifbeq4Hib/e8Wx
         UnRE75fukNUY+jS9IzTAvhetyrmOM/lsaZaa7sCrin/ytRc5yrFpcpFr/l5SsNBShxtC
         RDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eWi2LVN2gecP1iaDEZcOslHil4OGn6GfTQ/ywsJxRU4=;
        b=MQeJrWw8En+JFvjxvzHKBuE+2iFhuI59I+UhTfmTqZXXv41B/hLO+P5YE+CLueKfJF
         JE1VePbMmnQJWi2ehxt/yfxQIS9uiJWCGKV7bSD8XJ1G+X/qRjIMWRbAqU2cWWj37RZ1
         QjaEKFAsv6bbPKuMZeO3exUHgrhFRGpmOcSJIFYWWxKgnc2hMb4QT2FF2XbvDMl6YFbp
         JbWy4hq/fJgi94Cj3iWMUd8cp6V66PIHqaPh3QFabMHJohbcwh3WHvMH/v4DoLUdFoRF
         qN2slgJp3sK2RQ4Fa6iltjOprWFIXt94ocVfhmnwF4nAdTN1yTwXuuus6tPB7GTq2HhN
         NrcA==
X-Gm-Message-State: ACgBeo0iLnw4PlNXl+1remTOviOgCBEu7RJ0trpWuprOJeHkIXhfjg2k
        R/b21xZmyqOib3Y53IzwT5RBbA==
X-Google-Smtp-Source: AA6agR7lYfm0H3nIDGjlRvtjZ9XMOgf94oL/eqyyJX1dmi3uEefT+PfOmLB45yRQs15z5OC/ZSTMmA==
X-Received: by 2002:a05:6638:2103:b0:346:c965:b935 with SMTP id n3-20020a056638210300b00346c965b935mr4811111jaj.205.1662648115499;
        Thu, 08 Sep 2022 07:41:55 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k131-20020a6bba89000000b00689abadc36asm1146694iof.3.2022.09.08.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:41:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Shigeru Yoshida <syoshida@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org,
        syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com
In-Reply-To: <20220907163502.577561-1-syoshida@redhat.com>
References: <20220907163502.577561-1-syoshida@redhat.com>
Subject: Re: [PATCH] nbd: Fix hung when signal interrupts nbd_start_device_ioctl()
Message-Id: <166264811452.472176.16885663961423246810.b4-ty@kernel.dk>
Date:   Thu, 08 Sep 2022 08:41:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 8 Sep 2022 01:35:02 +0900, Shigeru Yoshida wrote:
> syzbot reported hung task [1].  The following program is a simplified
> version of the reproducer:
> 
> int main(void)
> {
> 	int sv[2], fd;
> 
> [...]

Applied, thanks!

[1/1] nbd: Fix hung when signal interrupts nbd_start_device_ioctl()
      commit: 1de7c3cf48fc41cd95adb12bd1ea9033a917798a

Best regards,
-- 
Jens Axboe


