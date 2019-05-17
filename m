Return-Path: <SRS0=xX0B=TR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B3EC04AB4
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 21:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98F02082E
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 21:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EsnGURIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfEQVlh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 May 2019 17:41:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45387 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfEQVlh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 May 2019 17:41:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so4267880pfm.12
        for <linux-block@vger.kernel.org>; Fri, 17 May 2019 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=AGPNbGIVDM8DZYXdO8EWRMLfpACALLPcJohjiWTCYaQ=;
        b=EsnGURItIQiCHnIF0SYu65dLHTWdF2Ag/4SW+/ggx8Mvxk6Czs+rXGrjE+t7SbWqBD
         ja6jJ/g87LtROuuUOUbnQCglFt9rLAwHwMqvzOZOy6RoOUa1RHQahJ7tQLCXYBtr682q
         xvuq+7+Tt9Fbni8ypzzh+6nWEISzH901QEGr41teEvT+1z4X969giyoB6fh99eFXFoSA
         qSHGtMPPBXM2kwunOTihLSGEoapgobhJdsxlbO5Dqdo44t+NwsK9TFrtp4fitXF+ktKN
         RRVwHW3PsEUaen+k/RNoVprAniYzt4ip/GjAnJPYUEYQMGBnivdylyP6Oyo+oTP9rIrg
         DdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AGPNbGIVDM8DZYXdO8EWRMLfpACALLPcJohjiWTCYaQ=;
        b=k6dp81V49cM4qjqodviEqGIJLBVusE59m8+lvfGSxt3A2caSRlufeMvn+uvVkljp25
         uTONLs4wcQlLuv4elSyoS+ZUD9TBegGOqxZnRowRMnPJ3LaFXLRPSQO3veSKBPY2L01P
         DZTY8gjrp80/WUqCFuU07SzohzI1fAb3rIWZvMQXnsM0EGjEVlPSzl7MvHCbYNRd5upQ
         dwf7z2cHQkJC8ceGwC/ZkBJj5h2Jz3aTFMBp55nUSBfhDtr+V+ut13grcCGNYCfwnyRz
         0o1xg9NybUyUw5DA3+JUCGtsw1HZpxB+5r9s1Ac6jgv8cw30OX0smdXXEMl8Ii9oqmmm
         gDMw==
X-Gm-Message-State: APjAAAX/LPQ7/6QqtmRQAn6clQFahaPctOlEYEeTzMFavA2Z5KTcfDM4
        2T+0OtYkG++TGUaDaDhWSfw49A==
X-Google-Smtp-Source: APXvYqwGmY1UDJcSi/iJ+lV7nRWwHFU7mQLPXlmrPRa2EFpCmnW4mY5Rn/jAGg5XoK9PJoeFu+XdnA==
X-Received: by 2002:a63:e550:: with SMTP id z16mr59599609pgj.329.1558129296212;
        Fri, 17 May 2019 14:41:36 -0700 (PDT)
Received: from x1.localdomain (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z125sm15885331pfb.75.2019.05.17.14.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:41:35 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
Subject: [PATCHSET 0/3] io_uring: support for linked SQEs
Date:   Fri, 17 May 2019 15:41:28 -0600
Message-Id: <20190517214131.5925-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We currently support a barrier operation, which ensures that previous
commands have finished before they are executed. This patchset
introduces support for linked commands. Linked commands form a
dependency between commands, but not for the execution pipeline in
general. Example:

[[ ReadA, WriteA], [ReadB, WriteB], [ReadC, WriteC]]

This is a weak ascii attempt at showing a series of reads and writes,
where each write depends on the previous read. WriteA will not be
started before ReadA is complete. Think of a copy like operation, where
ReadA is "read X bytes from file Y at offset Z" and WriteB is then
"write X bytes to file A at offset B", with the two sharing the same
iovec. While WriteA depends on the completion of ReadA, there are no
dependencies between ReadA and ReadB, and they may execute in parallel.

In terms of user API, ReadA will have IOSQE_IO_LINK set. When that is
set, the next command depends on it. If the next one also has
IOSQE_IO_LINK set, then the dependency continues. If it doesn't, then
the chain stops with the next command.

I wrote a trivial cp(2) implementation using linked reads and writes,
you can find that here:

http://git.kernel.dk/cgit/liburing/tree/examples/link-cp.c

in the liburing git repo. There's also a test program in there
exercising various types of chains.

I think this is a very powerful concept, and something that could even
be extended to be BPF driven at completion time if dependencies need
further linkage outside of what can be statically provided initially.
A potential series could be [Open file, Read, Close file] where the
fd needs to be carried forward, for example.

Patches are against current master from Linus, and are also in my
io_uring-next branch.

-- 
Jens Axboe


