Return-Path: <SRS0=K2Ob=YP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4759FCA9EA0
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 20:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3542086D
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 20:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=inesctec.pt header.i=@inesctec.pt header.b="XSw1Yh0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfJVUsU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:48:20 -0400
Received: from mx9.inesctec.pt ([192.35.246.56]:51268 "EHLO mx9.inesctec.pt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731448AbfJVUsT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 16:48:19 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Oct 2019 16:48:18 EDT
Received: from localhost (localhost [127.0.0.1])
        by mx9.inesctec.pt (Postfix) with ESMTP id 393AA100001B7
        for <linux-block@vger.kernel.org>; Tue, 22 Oct 2019 21:38:46 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inesctec.pt; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:mime-version:received:received:received:received; s=
        dkim; t=1571776726; x=1572640727; bh=TrcPoZqg8oRCRXC8cg3cl8T8BTe
        rTVB0ooaajL1l5Kg=; b=XSw1Yh0NkiqJ2sMoARgwiUfgy2kel1pYGorpBHS4ivU
        ZJLl+2KF+2WgC7Xt89JRXi7FtSWDLjU1pcbdy3Wmkj/A+InVF0CBNgXYPFCG78bY
        j+X+/500idMjZ5h5MqmIN0/6wajGkzFgfyoD97KxSrxY2+NyspOHzMt9Ud0ARmis
        =
X-Virus-Scanned: amavisd-new at inesctec.pt
Received: from mx9.inesctec.pt ([127.0.0.1])
        by localhost (mx9.inesctec.pt [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XnGoOSXz0XKK for <linux-block@vger.kernel.org>;
        Tue, 22 Oct 2019 21:38:46 +0100 (WEST)
Received: from ex2.inesctec.pt (ex2.inesctec.pt [194.117.26.22])
        by mx9.inesctec.pt (Postfix) with ESMTPS id 1B0D5100001F5
        for <linux-block@vger.kernel.org>; Tue, 22 Oct 2019 21:38:46 +0100 (WEST)
Received: from mail-io1-f44.google.com (209.85.166.44) by ex2.inesctec.pt
 (194.117.26.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1415.2; Tue, 22 Oct
 2019 21:38:44 +0100
Received: by mail-io1-f44.google.com with SMTP id u8so22116683iom.5
        for <linux-block@vger.kernel.org>; Tue, 22 Oct 2019 13:38:44 -0700 (PDT)
X-Gm-Message-State: APjAAAWKjpAfrZ9u43jHhy7otac/x9m1xSIG4P0LMwO1yiWurEFZbf3A
        z+XX2f0ToIE/R1gjdn2GPslPAr4JNLRghgx4oIY=
X-Google-Smtp-Source: APXvYqz7svinicfrC63UYN/MZC10Vwmxx97JXLrja36Su70IeaWb8hXvLsCYDuP9eR6GBshDw0CCJb7kJZBW9YYhAb0=
X-Received: by 2002:a5d:9952:: with SMTP id v18mr5480694ios.58.1571776723341;
 Tue, 22 Oct 2019 13:38:43 -0700 (PDT)
MIME-Version: 1.0
From:   Alberto Faria <alberto.c.faria@inesctec.pt>
Date:   Tue, 22 Oct 2019 21:38:32 +0100
X-Gmail-Original-Message-ID: <CAHB4L8iUrPovWfR5YL6yexsGjF5+LPB7w24SpVPojfaeOGrZ4Q@mail.gmail.com>
Message-ID: <CAHB4L8iUrPovWfR5YL6yexsGjF5+LPB7w24SpVPojfaeOGrZ4Q@mail.gmail.com>
Subject: Some questions regarding block device semantics
To:     <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [209.85.166.44]
X-ClientProxiedBy: ex1.inesctec.pt (194.117.26.21) To ex2.inesctec.pt
 (194.117.26.22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I have been unable to find the answer to the following questions regarding
the semantics of block devices:

1) I noticed the concepts of "logical block size", "physical block size",
   and "soft block size" (cf. blkdev_ioctl() in block/ioctl.c). The
   meanings of the first two are documented in
   blk_queue_logical_block_size() and blk_queue_physical_block_size() in
   block/blk-settings.c . However, what is the soft block size used for?
   Is it historical and superseded by the logical and physical block
   sizes?

2) If two concurrent writes requests (i.e., both are submitted by some
   client and only then do both complete) to the same block device
   intersect, are there any guarantees regarding the content of the
   affected region after the writes complete? What about concurrent writes
   to the same logical block? And physical block?

3) Are there any guarantees regarding the content of a logical block that
   was being written (i.e., for which a write request was submitted but
   not yet completed) when a crash occurred? What about a write to a
   physical block? Also, what if the write was a FUA write?

Is someone able to clarify me on this? I apologize if these questions are
too basic for this mailing list or if I missed any relevant documentation.

Thanks,
Alberto Faria
