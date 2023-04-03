Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1BDC76196
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 01:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjDCBXx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Apr 2023 21:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjDCBXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Apr 2023 21:23:52 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28AC10F5
        for <linux-block@vger.kernel.org>; Sun,  2 Apr 2023 18:23:50 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id t20so2268979uaw.5
        for <linux-block@vger.kernel.org>; Sun, 02 Apr 2023 18:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680485029; x=1683077029;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eQaMTk3JhKLmU3mQNWNAqby6/Tj3vZPZ/5Rj+IaqQs=;
        b=BumskOnDnkKq7u6ZA0PYH/KqNMhTFK4AC07oe1Wvqi3oWENIIIjPskTsRIQtMiYY60
         s+b25PN0jXHlRznPPGvFTgrlRFaXKOcldaaQX3TpX2IL51AltXa40Q0HEg5cJVHcO5xU
         KZm+BFkuvoapEKksGLwZ3rCtUVQoll0ArXPCbfbPVjx7z3v1QbBndudYiMN0don1HFsT
         t+H5h10begs3FdWylIjgRtylWGs4pNUAFxJc77AtGtlgCVzjiD1T9Coy7dO4xUC2savB
         DywRxQodzlVNu9uhqbDTTQoqZCVIIg+3W3SBfdQv2XU7m6OKGFw2Z+fMJow3bVuGVliI
         qeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680485029; x=1683077029;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eQaMTk3JhKLmU3mQNWNAqby6/Tj3vZPZ/5Rj+IaqQs=;
        b=eySjmNtgCf5qmH8T7C2T2eqRT847fsjEujrGTYYjXtgmSSmYl2Tn2Xd5jEQrLQKqYv
         r6CPbo36dL8Ll4QRcbo9Flf8aFspYbUI4SNEuc/ClFu3mZsA6Nw7cvM5t8hoOwfSJebf
         5/lxlxkW4LSUsoxdDAkxfIeuxnVFl0PSR+t/oFlW0BHRY9IRRN0DM1hcP7NbSLI0+kb2
         J9XobYgkmVQXTbDO2xGUJxJQjQ8M7w1eLw3HnjY0qsjiIhUA37fmb70n5kZ98xEC7U1y
         98lLXoagVPFJLapTb1Fs8arvzvjl6K2nwKP8f4zEAzUH47YSGp9jj48JAFEP0EDE6TFz
         YSfw==
X-Gm-Message-State: AAQBX9f/ixgxr3SpIpZVBal/z1BVTOOHz5ZbSpWCR7F3afOD4GSjt5wK
        6p/l57oSJHBu1zrEFxtzb648Tg==
X-Google-Smtp-Source: AKy350bi0WwCd/ytj18WKAd867pUSOSJxzt0P8o0rE9WIuVSw/Dw9oxFYILyJ3mD1OEz+UjHBondOA==
X-Received: by 2002:a05:6122:169f:b0:436:1d1c:ebe6 with SMTP id 31-20020a056122169f00b004361d1cebe6mr13819705vkl.1.1680485029634;
        Sun, 02 Apr 2023 18:23:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b12-20020ab0084c000000b007612512b30fsm1644146uaf.29.2023.04.02.18.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 18:23:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
In-Reply-To: <20230330113630.1388860-1-ming.lei@redhat.com>
References: <20230330113630.1388860-1-ming.lei@redhat.com>
Subject: Re: (subset) [PATCH V6 00/17] io_uring/ublk: add generic
 IORING_OP_FUSED_CMD
Message-Id: <168048502809.419126.16967551210747821991.b4-ty@kernel.dk>
Date:   Sun, 02 Apr 2023 19:23:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 30 Mar 2023 19:36:13 +0800, Ming Lei wrote:
> Add generic fused command, which can include one primary command and multiple
> secondary requests. This command provides one safe way to share resource between
> primary command and secondary requests, and primary command is always
> completed after all secondary requests are done, and resource lifetime
> is bound with primary command.
> 
> With this way, it is easy to support zero copy for ublk/fuse device, and
> there could be more potential use cases, such as offloading complicated logic
> into userspace, or decouple kernel subsystems.
> 
> [...]

Applied, thanks!

[07/17] block: ublk_drv: add common exit handling
        commit: 903f8aeea9fd1b97fba4ab805ddd639f57f117f8
[08/17] block: ublk_drv: don't consider flush request in map/unmap io
        commit: 23ef8220f287abe5bf741ddfc278e7359742d3b1
[09/17] block: ublk_drv: add two helpers to clean up map/unmap request
        commit: 2f3af723447c35c16f3c6a1b4b317c61dc41d6c3
[10/17] block: ublk_drv: clean up several helpers
        commit: 96cf2f5404c8bc979628a2b495852d735a56c5b5
[11/17] block: ublk_drv: cleanup 'struct ublk_map_data'
        commit: ae9f5ccea4c268a96763e51239b32d6b5172c18c

Best regards,
-- 
Jens Axboe



