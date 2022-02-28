Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F5C433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 10:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiB1Kdg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 05:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiB1Kdf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 05:33:35 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEC21403A
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 02:32:52 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220228103246epoutp01094c35fd0b6958341d3e4bcc24e3ddce~X7KFVxE4A0456004560epoutp01F
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 10:32:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220228103246epoutp01094c35fd0b6958341d3e4bcc24e3ddce~X7KFVxE4A0456004560epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646044366;
        bh=DE++bbV4PufN2NIHg235o161XQxS+vRZfeqB10jhsNw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=RHgaB+8ZsYemWPm3xOW/Xg7L++uIrfQRqVovehx0keIzAPXGo5Q50yY72ilqw9r1X
         HoMfDVv5Pjbn9RjamuzeW2lTe53AZd4NVaK6UkDlAHM9InwEqqHUkkWo3MDOnrGZwI
         sbIxtwFNaah014jqshf4kEkxr+YzVRdHYBllTVqU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220228103246epcas5p3324c9cbf011223743aec17deb83f08ae~X7KE_5dU31936119361epcas5p39;
        Mon, 28 Feb 2022 10:32:46 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K6cC21Ml4z4x9Py; Mon, 28 Feb
        2022 10:32:30 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.EE.06423.2B4AC126; Mon, 28 Feb 2022 19:32:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220228093018epcas5p137f53cb05ce95fed2ac173b8fddf2eee~X6TjJzanh0828708287epcas5p1I;
        Mon, 28 Feb 2022 09:30:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220228093018epsmtrp1681e2f421ca4701532dc338344b9057b~X6TjJPCIn2992429924epsmtrp1s;
        Mon, 28 Feb 2022 09:30:18 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-c2-621ca4b218d8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.9F.29871.A269C126; Mon, 28 Feb 2022 18:30:18 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220228093018epsmtip1e46703c128df219e77d356741925eb31~X6Tiamwkm1259012590epsmtip1P;
        Mon, 28 Feb 2022 09:30:17 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Towards more useful nvme passthrough
Date:   Mon, 28 Feb 2022 14:55:11 +0530
Message-Id: <20220228092511.458285-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmhu6mJTJJBo/OsFvsvaVtMX/ZU3aL
        fa/3Mjswe2xeUu8x+cZyRo/Pm+QCmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0t
        LcyVFPISc1NtlVx8AnTdMnOA1igplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK
        9IoTc4tL89L18lJLrAwNDIxMgQoTsjOuzZjJWvBDoWJjy122BsYO6S5GTg4JAROJ86+2s4PY
        QgK7GSW+71DqYuQCsj8xSiw9vYMFwvnGKNEybT8bTMeRdy/YIBJ7GSU2/jjCCuF8ZpRo/nyf
        qYuRg4NNQFPiwuRSkAYRAVWJv+uPsIDYzAL2Ekcal4MNEhZwkJi4og9sNQtQzbMJn8FsXgFL
        iXP7fkItk5eYeek7VFxQ4uTMJ1Bz5CWat85mhqhZxy7RdyoEwnaRWPdjFwuELSzx6vgWdghb
        SuJlfxuUXSzx685RZpCbJQQ6GCWuN8yEarCXuLjnL9j9zED3r9+lDxGWlZh6ah0TxF4+id7f
        T5gg4rwSO+bB2IoS9yY9ZYWwxSUezlgCZXtIfP+3ghESvLESWx9+ZJnAKD8LyTuzkLwzC2Hz
        AkbmVYySqQXFuempxaYFhnmp5fB4Tc7P3cQITmxanjsY7z74oHeIkYmD8RCjBAezkggvO6tk
        khBvSmJlVWpRfnxRaU5q8SFGU2AYT2SWEk3OB6bWvJJ4QxNLAxMzMzMTS2MzQyVx3tPpGxKF
        BNITS1KzU1MLUotg+pg4OKUamAInhOq5arW+f35G30YsLqGIh8v4ZXzhw8/C89dcuPte9Fmp
        z7yKjo2TAm92p5+/vHdZWlgP87p7c6dHPDjQtfnXpBspKj+zN73R5JupLSvAbfx6Q9EdU42n
        sj96+EK3sxRUz45YIrj/tspUV46jedppr9hCd21clzODbZN4zPYcRokbM74rLnySMU3LRTvm
        y9pXyhdtj6v33U471rrh9tH+wn1LJlfe2cC4fjn3HN2Pk3++2y812fFJ9cNje+uChP9xVK0w
        9Q3qCj1w4v6cn3c+BIcF82fsmR0Uz3bsva7441//7+V89r/JVK09I0GJdffX/Ga//JW1E5Ze
        C2A2Ei3jfFf9qyRKt3yWn+oZq1lKLMUZiYZazEXFiQBapGO79QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnK7WNJkkg58rjSz23tK2mL/sKbvF
        vtd7mR2YPTYvqfeYfGM5o8fnTXIBzFFcNimpOZllqUX6dglcGddmzGQt+KFQsbHlLlsDY4d0
        FyMnh4SAicSRdy/Yuhi5OIQEdjNK7J+7jx0iIS7RfO0HlC0ssfLfc3aIoo+MEuv3rAFyODjY
        BDQlLkwuBakREVCV+Lv+CAuIzSzgKLHs2AxmEFtYwEFi4oo+sDksQDXPJnwGs3kFLCXO7fvJ
        BjFfXmLmpe9QcUGJkzOfsICMZxZQl1g/TwhipLxE89bZzBMY+WchqZqFUDULSdUCRuZVjJKp
        BcW56bnFhgWGeanlesWJucWleel6yfm5mxjBAamluYNx+6oPeocYmTgYDzFKcDArifCys0om
        CfGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cB0RfZNDzt7
        dDRbcOO8/M4uwZMXWJIut3JNMfAPab0h9tKz7PytnI/9zn85WD8WWHQpxbbbvgm8ey6rlEVm
        QwLPxDPFsbXm6WsW/Q9blnLlv476yhkSEXzJVat8/64+dtj4U0MNu/rkPVL2t2t220puSnra
        1f15knSvpdLBC1zzWY9pevQJee5YP7fnQedBv5OPTiSZTlUV+26Q+vGQ45o564tZf6+Y0/7r
        x4YyBuHlx9WXpDtNjlhnc/K3R4aS/aN6T7/lxfIfBVnm9X2bY7HivbvZVeO6uA/BInee8DTN
        eG1kcXrlqpDdV9Z9eiKXkGRRcFTp9O7QvO4FgsGTuh0TbZ/rfBFYYxSn9zDktbYSS3FGoqEW
        c1FxIgApM1tStwIAAA==
X-CMS-MailID: 20220228093018epcas5p137f53cb05ce95fed2ac173b8fddf2eee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220228093018epcas5p137f53cb05ce95fed2ac173b8fddf2eee
References: <CGME20220228093018epcas5p137f53cb05ce95fed2ac173b8fddf2eee@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Background & Objective:
-----------------------
New storage interfaces/features, especially in NVMe, are emerging
fast. NVMe now has 3 command sets (NVM, ZNS and KV), and this is only
going to grow further (e.g. computational storage). Many of these new
commands do not fit well in the existing block abstraction and/or
syscalls. Be it somewhat specialized operation, or even a new way of
doing classical read/write (e.g. zone-append, copy command) - it takes
a good deal of consensus/time for a new device interface to climb the
ladders of kernel abstractions and become available for user-space
consumption. This presents challenges for early adopters of tech, and
leads to kernel-bypass at times.

Passthrough interface cuts through the abstractions and allows
applications to use any arbitrary nvme-command readily, similar to
kernel-bypass solutions. But passthrough does not scale as it travels
via sync ioctl interface, which is particularly painful for
fast/parallel NVMe storage.

Objective is to revamp the existing passthru interface and turn it
into something that applications can readily use to play with
new/emerging features of NVMe.

Current state of work:
----------------------
1. Block-interface is subject to compatibility of course. But now nvme
exposes a generic char interface (/dev/ng) as well which is not
subject to conditions [1]. When passthru is combined with this generic
char interface, applications get a sure-fire way to operate
nvme-device for any current/future command-set. This settles the
availability problem.

2. For scalability problem, we are discussing this new facility
“uring-cmd” that Jens proposed in io_uring [2]. This enables using
io_uring for any arbitrary command (ioctl, fsctl etc.) exposed by the
underlying component (driver, FS etc.).

3. I have posted patches combining nvme-passthru with uring-cmd [3].
This new uring-passthru path enables a bunch of capabilities – async
transport, fixed-buffer, async-polling, bio-cache etc. This scales well.
512b randread KIOPS comparing uring-passthru-over-char (/dev/ng0n1) to
uring-over-block (/dev/nvme0n1)

QD    uring    pt    uring-poll    pt-poll
8      538     589      831         902
64     967     1131     1351        1378
256    1043    1230     1376        1429

Discussion points:
------------------
I'd like a propose a session to go over:

- What are the issues in having the above work (uring-cmd and new nvme
passthru) merged?

- What would be other useful things to add in nvme-passthru. For
example- lack of vectored-io for passthru was one such missing piece.
That is covered from nvme 5.18 onwards [4]. But are there other things
that user-space would need before it starts treating this path as a
good alternative to kernel-bypass?

- Despite the numbers above, nvme passthru has more room for
efficiency e.g. unlike regular io, we do copy_to_user to fetch
command, and put_user to return the result. Eliminating some of this
may require new ioctl. There may be other opinions on what else needs
overhaul in this path.

- What would be a good way to upstream the tests? Nvme-cli may not be
very useful. Should it be similar to fio’s sg ioengine. But
unlike sg, here we are combining ng with io_uring, and one would want
to retain all the tunables of io_uring (register/fixed buffers/sqpoll
etc.)

- All the above is for 2.0 passthru which essentially forms a direct
path between io_uring and nvme. And io_uring and nvme programming
model share many similarities. For 3.0 passthru, would it be crazy to
think of trimming the path further by eliminating the block-layer and
doing stuff without “struct request”. There is some interest in
developing user-space block device [5] and FS anyway.

[1] https://lore.kernel.org/linux-nvme/20210421074504.57750-1-minwoo.im.dev@gmail.com/
[2] https://lore.kernel.org/linux-nvme/20210317221027.366780-1-axboe@kernel.dk/
[3] https://lore.kernel.org/linux-nvme/20211220141734.12206-1-joshi.k@samsung.com/
[4] https://lore.kernel.org/linux-nvme/20220216080208.GD10554@lst.de/
[5] https://lore.kernel.org/linux-block/87tucsf0sr.fsf@collabora.com/

-- 
2.25.1

