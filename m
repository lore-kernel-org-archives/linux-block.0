Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E04C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 06:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiF3GC4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiF3GC4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 02:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0A8D286DD
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 23:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656568974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=ZT3Pr4deTdJuSWhUG+KM8YnFqiQcwWEaUGAb7rnC7x0=;
        b=HobM9nNznf7E8TFZf3YzCY30veWbHtR9Y4Wg/B0rhuzaJdsfGLYEFaK3X17A8U3SBjxduk
        f0SAqRbFSHhy896BexjI/i4n0RCGi0X7/xdXhRH7bYLz+jqj+zS2kBJx7sI5hpvxo67hMF
        62CYUMKYzjA+UD7PWNVmno6JkJPnYvI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-I3SVicOFO46m1JQLYh3XBQ-1; Thu, 30 Jun 2022 02:02:52 -0400
X-MC-Unique: I3SVicOFO46m1JQLYh3XBQ-1
Received: by mail-pj1-f72.google.com with SMTP id h11-20020a17090a130b00b001eca05382e7so934344pja.9
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 23:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZT3Pr4deTdJuSWhUG+KM8YnFqiQcwWEaUGAb7rnC7x0=;
        b=rpRbRXU8k+udE2frY2NnzAfY7NFZV5eaqJLhGUX1BiNaAlBnWs/iHsDk68GwR6bytZ
         Zls9qKj2KuARLoa+vq9xKRL6KWDmM8mjMgUuC706ssivga5/4/gXQEzlhxNN7SaTJlEM
         rMfvRvle+/E1RR0n9GJW6kCeIGyMu+1lFtANGHBKtnLvJZWbsbqzhG15KaslAdjfy3a2
         Q/jr+2LS9+jbgccYKDzNYQnvLE99y2xhHLwej0mSz7CZCnkg5rdwBNTN4Nd2FYuixahI
         n3uKvlg+dyPBfFG/xjbH5Xw8Vk7ITtsRCMJb9VgXdrWSgCun9eBMChyHV1ptniQQhvqd
         OefA==
X-Gm-Message-State: AJIora8Fo++T/WtWg0mZUTqedrNqsAYeisIVI8P84bF2V7Q73v7EBqlz
        d7WzBhlNJtdY9wA/yBugpXbQF7F2cllLKnPgy7O2fhDk3GxnHyAKPtLOmeRaqfpR2FC7j1a5LtG
        mIpcxRKKKMNPiYFFak5Rz1xk46neBlzesyMhcKGc=
X-Received: by 2002:a17:902:db0b:b0:16b:a4ff:c9d6 with SMTP id m11-20020a170902db0b00b0016ba4ffc9d6mr5007231plx.15.1656568971133;
        Wed, 29 Jun 2022 23:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vUzb9knhbrYQkg5UlFZmHNfPcDRdw5zCedzO07PslAW3rs3r9YjY4t8YKOy/MvkmKqhXuurNcT4n2AIFDtPFo=
X-Received: by 2002:a17:902:db0b:b0:16b:a4ff:c9d6 with SMTP id
 m11-20020a170902db0b00b0016ba4ffc9d6mr5007219plx.15.1656568970762; Wed, 29
 Jun 2022 23:02:50 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 30 Jun 2022 14:02:39 +0800
Message-ID: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
Subject: [bug report] blktests nvme/004 failed after offline cpu
To:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
I found this issue when I run blktests after offline cpus on
linux-block/for-next, here are the steps and dmesg log,
and from the log, the test failed with the target connect, feel free
to let me know if you need any info/test, thanks.

# echo 0 >/sys/devices/system/cpu/cpu0/online
# ./check nvme/004
nvme/004 (test nvme and nvmet UUID NS descriptors)           [failed]
    runtime    ...  0.725s
    --- tests/nvme/004.out 2022-06-30 01:50:53.637275584 -0400
    +++ /root/blktests/results/nodev/nvme/004.out.bad 2022-06-30
01:55:22.321399448 -0400
    @@ -1,5 +1,7 @@
     Running nvme/004
    -91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +Failed to write to /dev/nvme-fabrics: Invalid cross-device link
    +cat: '/sys/class/nvme/nvme*/subsysnqn': No such file or directory
    +cat: /sys/block/n1/uuid: No such file or directory
    ...
    (Run 'diff -u tests/nvme/004.out
/root/blktests/results/nodev/nvme/004.out.bad' to see the entire diff)
# dmesg
[ 1526.169417] numa_remove_cpu cpu 0 node 0: mask now 1-31
[ 1526.170619] smpboot: CPU 0 is now offline
[ 1531.030430] loop: module loaded
[ 1531.115255] run blktests nvme/004 at 2022-06-30 01:55:21
[ 1531.305557] loop0: detected capacity change from 0 to 2097152
[ 1531.354299] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1531.402815] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
[ 1531.404124] nvme nvme0: creating 31 I/O queues.
[ 1531.448181] nvme nvme0: Connect command failed, error wo/DNR bit: -16402

--
Best Regards,
  Yi Zhang

