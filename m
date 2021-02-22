Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05302C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA96264E41
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 23:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhBVXLR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 18:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhBVXLR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 18:11:17 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E84C06174A
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 15:10:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d3so8371201lfg.10
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=htMgZbviUWPJfHpdvErYulOZUuVUyLrfs/6w9xy28ag=;
        b=ClwOBQrwLYSl4rhcoxRQ/DM5JJD+v+bODw1s4lJtLIZLpR9EdecXQ0HTHBzAaHl4Ws
         2SlZ7n9BfUorVsr4NXXysklod2KJtdWt0UU+mjXez2pbalJK1kXFrsJZsDPZ4+RDmbTr
         xpZRt9pamMdqv04Mlhknx2b0AXqapL1LxFQSZkN8UParBtLWg31UV9q6+L5DLB5eX8hW
         a1QCTeyuoncaoYnxdFmkzUEzbag4c24ITH1i2Fn3K+mvUYpss/c1sQxA2EWOZ/DvQlyl
         SKQx70LDQenui6v1rV+TJ0R6HdULMgTpC7ORwZ3Ppl/wg48R6e7g0HqawlYa9BkX1TqS
         zmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=htMgZbviUWPJfHpdvErYulOZUuVUyLrfs/6w9xy28ag=;
        b=Ho2+7j9l6z0wbLL0o/zzoPffyIznUM5FBSrwc76B2wYX+JBbKM4ddRL6H60flYQsBN
         m7b6QXEpejGBb0spjI33cRyoQ6IeYQcCbcV+cXlgAOiPTYM8F/VTI8E2hBXSnukheC1k
         /xqTflCl8kaOWinhRPU7XF4YAvLfz//CKcmrI/HGD5sH/kDVeqcDsJu37kpVbSm14sNk
         zS+8TYo2P4Hv0XTs/2Vl4jsg6UvcLDOXcOtYhW4tJtPuLmrVhEX2JDElzGI27e8wJbR6
         UDy8XfKIqrwd1KODGYnRYPSjKFbnS0WcCjHt0k3kFEfrM9mfTNpXZx7YStdRYdHJ/mft
         5KEg==
X-Gm-Message-State: AOAM533WuotHt6lge8O2ifFVzXCF3XKGxvtKd3FN8TpIGtJJPWVHziPt
        LqNOzYcqYoTz2qqFc2oujtwhXcqs/dbJiBBSztemYg==
X-Google-Smtp-Source: ABdhPJwpRsRyerHjiRnE+ThB+csI+gODmDp0QyaJFsIStJfWMTBWcuWoOsE3BMvF8l/UbVnYJqknooqnxdHP02t5lpU=
X-Received: by 2002:ac2:5de4:: with SMTP id z4mr3297329lfq.535.1614035434936;
 Mon, 22 Feb 2021 15:10:34 -0800 (PST)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 22 Feb 2021 15:10:22 -0800
Message-ID: <CALAqxLU3B8YcS_MTnr2Lpasvn8oLJvD2qO4hkfkZeEwVNfeHXg@mail.gmail.com>
Subject: [REGRESSION] "add a disk_uevent helper" breaks booting Andorid w/
 dynamic partitions
To:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>
Cc:     linux-block@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey all,
  After updating to Linus' HEAD today I found my db845c board wouldn't
boot to android with the error below.

I was able to bisect the boot regression down to "block: add a
disk_uevent helper":
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bc359d03c7ec1bf3b86d03bafaf6bbb21e6414fd

And have validated that reverting that change seems to get things working again.

I don't really know the dynamic partition DM details well, so any tips
as to what might be going wrong here would be appreciated!

thanks
-john

[   25.782268] init: [libfs_mgr]Skipping mounting '/dev/block/dm-0'
[   25.788373] init: [libfs_mgr]Failed to open '/dev/block/dm-0': No
such file or directory
[   25.796579] init:
[libfs_mgr]__mount(source=/dev/block/dm-0(missing),target=/system,type=ext4)=-1:
No such file or directory
[   25.807978] init: Failed to mount /system: No such file or directory
[   25.814466] init: Failed to mount required partitions early ...
[   25.820757] init: InitFatalReboot: signal 6
[   25.833635] init: #00 pc 00000000003936a8  /init
(UnwindStackCurrent::UnwindFromContext(unsigned long, void*)+96)
[   25.844001] init: #01 pc 00000000002f1df0  /init
(android::init::InitFatalReboot(int)+208)
[   25.852340] init: #02 pc 00000000002f21d8  /init
(android::init::InstallRebootSignalHandlers()::$_22::__invoke(int)+32)
[   25.863211] init: #03 pc 000000000000053c  [vdso:0000007f97c34000]
[   25.869449] init: #04 pc 000000000045ffb0  /init (abort+176)
[   25.875163] init: #05 pc 00000000002f714c  /init
(android::init::InitAborter(char const*)+44)
[   25.883760] init: #06 pc 000000000034dc98  /init
(android::base::SetAborter(std::__1::function<void (char
const*)>&&)::$_3::__invoke(char const*)+80)
[   25.897241] init: #07 pc 000000000034d840  /init
(android::base::LogMessage::~LogMessage()+360)
[   25.906002] init: #08 pc 00000000002e93a8  /init
(android::init::FirstStageMain(int, char**)+6648)
[   25.915039] init: #09 pc 000000000045ee58  /init
(__real_libc_init(void*, void (*)(), int (*)(int, char**, char**),
structors_array_t const*, bionic_tc)
[   25.929411] init: Reboot ending, jumping to kernel
