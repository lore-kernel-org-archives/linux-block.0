Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B185C0015E
	for <linux-block@archiver.kernel.org>; Tue,  1 Aug 2023 11:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjHAL34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Aug 2023 07:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjHAL3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Aug 2023 07:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8D710EA
        for <linux-block@vger.kernel.org>; Tue,  1 Aug 2023 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690889338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=F7/Vx2vQrKZJtPQGs5BzH3RGbwK4yN0bYxF9djK4RRM=;
        b=Lhh5LHt4QaQVus3Bk3qkMSwmQ6mJvQI5AtEdUW8ooR5ZSCCrSpXAabrMRERWQhs6NNNsYt
        naDXJvD2blW/D64o1/kDpXHS+5TfnSFDUoiFvlTVXyTXaWyi3G2lpZmo5CQPY6Fgkr7jAJ
        widy814kvb9NLQizg4T6qCRtrhSatvg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Dtiwjrk1OYmCVntS7vkZog-1; Tue, 01 Aug 2023 07:28:57 -0400
X-MC-Unique: Dtiwjrk1OYmCVntS7vkZog-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-39cdf9f9d10so7994667b6e.3
        for <linux-block@vger.kernel.org>; Tue, 01 Aug 2023 04:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889336; x=1691494136;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7/Vx2vQrKZJtPQGs5BzH3RGbwK4yN0bYxF9djK4RRM=;
        b=iKUDOp1PSynCUmhYWYKJ3YL2Q70Ww8v4qYenHWlj7FdF6+NkD0iCEEtBiBVQmaIayn
         vkviTrIGotqiSTRM/TMyOMlgnLQLOOfrTcpXovZ/5pXqGbLixmuA3YThGY3zT2J6pa4k
         FdHDV9/nVwti/X2ISlZmF3hSY2giTNdh3v3yeqxU6Sa/2Gc9IY/jEJz+kuUi1lW4QUPS
         58uUNS3/jY0X6Ra+SKeudHZoLvNKQ5g5QnqVm/GvAMFW3bUsPfovSQCdEcJIjvi4ak61
         Vwv4K+0sV9yKkU43olxOFC+DMFTO9PANMxmHvlGDtslwpWoIwnV2D1w2afOWykkAyE3Y
         ZiUw==
X-Gm-Message-State: ABy/qLaRiLyLN/t09r8xbCiwNl2NgVi425W4BcmQZ+UGkPIz1XfprQfQ
        iX4SbG9N42kxejGcP4xSpO3SK9RJitKo21xTzRV/BRg7+lCqT1Q2vKx+PQW4wN3n7M8hhiD1s5L
        Dfx+sQiTYaznZ+LhCz+mBFNmKhWNMfPRHBsHLHOCM8ii7kQSRGJbB
X-Received: by 2002:a05:6808:1a81:b0:3a7:1bd8:4eb6 with SMTP id bm1-20020a0568081a8100b003a71bd84eb6mr6000663oib.44.1690889336213;
        Tue, 01 Aug 2023 04:28:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGq5WBisi5MLVrJQkJb+u+kNQn8jJartIHndaKJkvl0JaqoT+K/XIH/4PHOkvNq2TGdInKUTu2Anm2CGwaIHiw=
X-Received: by 2002:a05:6808:1a81:b0:3a7:1bd8:4eb6 with SMTP id
 bm1-20020a0568081a8100b003a71bd84eb6mr6000654oib.44.1690889335955; Tue, 01
 Aug 2023 04:28:55 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 1 Aug 2023 19:28:44 +0800
Message-ID: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
Subject: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not created
 in time
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

I found random nvme/047 failure on linux-block/for-next when I do
stress blktests nvme/tcp nvme/047 test:

Kernel config: https://pastebin.com/6i3sZWAx
============================================0
nvme/047 (test different queue types for fabric transports)  [failed]
    runtime  71.129s  ...  7.096s
    --- tests/nvme/047.out 2023-07-16 23:04:30.052101710 -0400
    +++ /root/blktests/results/nodev/nvme/047.out.bad 2023-07-19
09:17:35.949908134 -0400
    @@ -1,2 +1,198 @@
     Running nvme/047
    +fio: looks like your file system does not support direct=1/buffered=0
    +fio: looks like your file system does not support direct=1/buffered=0
    +fio: looks like your file system does not support direct=1/buffered=0
    +fio: looks like your file system does not support direct=1/buffered=0
    +fio: destination does not support O_DIRECT
    +fio: destination does not support O_DIRECT
    ...
    (Run 'diff -u tests/nvme/047.out
/root/blktests/results/nodev/nvme/047.out.bad' to see the entire diff)

After some investigating, I found it was due to the /dev/nvme0n1 node
couldn't be created in time which lead to the following fio failing.
+ nvme connect -t tcp -a 127.0.0.1 -s 4420 -n blktests-subsystem-1
--hostnqn=nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
--hostid=0f01fb42-9f7f-4856-b0b3-51e60b8de349 --nr-write-queues=1
+ ls -l /dev/nvme0 /dev/nvme-fabrics
crw-------. 1 root root 234,   0 Aug  1 05:50 /dev/nvme0
crw-------. 1 root root  10, 122 Aug  1 05:50 /dev/nvme-fabrics
+ '[' '!' -b /dev/nvme0n1 ']'
+ echo '/dev/nvme0n1 node still not created'
dmesg:
[ 1840.413396] loop0: detected capacity change from 0 to 10485760
[ 1840.934379] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1841.018766] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 1846.782615] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1846.808392] nvme nvme0: creating 33 I/O queues.
[ 1846.874298] nvme nvme0: mapped 1/32/0 default/read/poll queues.
[ 1846.945334] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420

BTW, I also found after disabling nvme_core.multipath, seems this
issue cannot be reproduced.

--
Best Regards,
  Yi Zhang

