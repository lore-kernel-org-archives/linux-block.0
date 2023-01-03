Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D99C3DA7D
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 21:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjACVrx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 16:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjACVrw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 16:47:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563FF14D17
        for <linux-block@vger.kernel.org>; Tue,  3 Jan 2023 13:47:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id a11-20020a17090a740b00b00223f7eba2c4so4724993pjg.5
        for <linux-block@vger.kernel.org>; Tue, 03 Jan 2023 13:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhC4/3uBGCBCr/tgMgnnzdGxffnCjxrZCxhvGrp3PFk=;
        b=V7/EaEOarXKo39fBJISg9sSr1bDe+EuV/ZLMuZ4mjEJDTiUrva8Tz5R437EO2OLQHm
         Y308Scex9Ra6FlgCwcrlnp+OFC2PMfjTIkyMrm759WoNgIqUPLI3RqJy3ZmbqsGhzjrV
         JGj6UtWuG7p+hCfaCu1Zn4lxbLF416yTQ42q7L2Wa/z8JFTWERHTVIfyWIzSWRnU9N5v
         /g+qdNiaqgzc4zkvrzy3lkI2k/0PLD3wA+sU9zgeoG6Rg0F2MkJmWGSa9J1tQHYOZre2
         oGsEPGM4JV1Od1lg320ZRFj6KeJoa2wfUurJpnijbcNzlAldUOlQlXTtm7UgmBoMvXEn
         PYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhC4/3uBGCBCr/tgMgnnzdGxffnCjxrZCxhvGrp3PFk=;
        b=zBqZ/v5gkDS6xZNeN9eo0rO5z/asN8nBvSqlgLc/JyB9pU7ltuDacqxfdfWQa2TflB
         9UwgD/wv0cVOG1sEeXiTCKwZ+1WOAn530TGBUlXElyzuJZi2nDTwOIpwzmYvjtuAsWNB
         fFJ9b1EX0WlcWjwWzuvuFNMNqZJrhBGJNWWGlGyVHxVh09H9bUwFQb14+zCLxbpOSDr0
         IfCrgCVfST15vzqrCCeWRpwgjHLyTmkH60/loILk+3QH0psgtcs/ZMNEF0oCI/LSfAOP
         +KWbfY2y9O2o/TlZz/FYA2/+uk8bL+/yn+/G28+8EFpwNHPlfdg3ymkEYFatWENpieck
         fuVg==
X-Gm-Message-State: AFqh2kowuFL9Z5rqDyHdAmiBytsc01xo99KnYueWafUxaHgTboUoF6Jt
        w9/h2yp1LCV/+rIFW6cdRXY=
X-Google-Smtp-Source: AMrXdXsullIkG7y2z3D2vOKAZ9s46xWjaBsPIUTO6CBBSFGwxPtNI+tH7f1P3y5YzaALJZO2cRYnsA==
X-Received: by 2002:a17:902:d355:b0:189:7e2f:d64c with SMTP id l21-20020a170902d35500b001897e2fd64cmr72724359plk.55.1672782470283;
        Tue, 03 Jan 2023 13:47:50 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b0018c990ce7fesm22861421plh.239.2023.01.03.13.47.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 13:47:49 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Potential hang on ublk_ctrl_del_dev()
Message-Id: <862272BC-C6A3-4A60-A620-4C5596972D01@gmail.com>
Date:   Tue, 3 Jan 2023 13:47:37 -0800
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
To:     Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ming,

I am trying the ublk and it seems very exciting.

However, I encounter an issue when I remove a ublk device that is =
mounted or
in use.

In ublk_ctrl_del_dev(), shouldn=E2=80=99t we *not* wait if =
ublk_idr_freed() is false?
It seems to me that it is saner to return -EBUSY in such a case and let
userspace deal with the results.

For instance, if I run the following (using ubdsrv):

 $ mkfs.ext4 /dev/ram0
 $ ./ublk add -t loop -f /dev/ram0
 $ sudo mount /dev/ublkb0 tmp
 $ sudo ./ublk del -a

ublk_ctrl_del_dev() would not be done until the partition is unmounted, =
and you
can get a splat that is similar to the one below.

What do you say? Would you agree to change the behavior to return =
-EBUSY?

Thanks,
Nadav


[  974.149938] INFO: task ublk:2250 blocked for more than 120 seconds.
[  974.157786]       Not tainted 6.1.0 #30
[  974.162369] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
[  974.171417] task:ublk            state:D stack:0     pid:2250  =
ppid:2249   flags:0x00004004
[  974.181054] Call Trace:
[  974.184097]  <TASK>
[  974.186726]  __schedule+0x37e/0xe10
[  974.190915]  ? __this_cpu_preempt_check+0x13/0x20
[  974.196463]  ? lock_release+0x133/0x2a0
[  974.201043]  schedule+0x67/0xe0
[  974.204846]  ublk_ctrl_uring_cmd+0xf45/0x1110
[  974.210016]  ? lock_is_held_type+0xdd/0x130
[  974.214990]  ? var_wake_function+0x60/0x60
[  974.219872]  ? rcu_read_lock_sched_held+0x4f/0x80
[  974.225443]  io_uring_cmd+0x9a/0x130
[  974.229743]  ? io_uring_cmd_prep+0xf0/0xf0
[  974.234638]  io_issue_sqe+0xfe/0x340
[  974.238946]  io_submit_sqes+0x231/0x750
[  974.243553]  __x64_sys_io_uring_enter+0x22b/0x640
[  974.249134]  ? trace_hardirqs_on+0x3c/0xe0
[  974.254042]  do_syscall_64+0x35/0x80
[  974.258361]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  974.264335] RIP: 0033:0x7f1dc2958efd
[  974.268657] RSP: 002b:00007ffdfd22d638 EFLAGS: 00000246 ORIG_RAX: =
00000000000001aa
[  974.277471] RAX: ffffffffffffffda RBX: 00005592eabe7f60 RCX: =
00007f1dc2958efd
[  974.285800] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
0000000000000004
[  974.294139] RBP: 00005592eabe7f60 R08: 0000000000000000 R09: =
0000000000000008
[  974.302473] R10: 0000000000000000 R11: 0000000000000246 R12: =
0000000000000000
[  974.310811] R13: 0000000000000000 R14: 00000000ffffffff R15: =
0000000000000000
[  974.319168]  </TASK>
[  974.321982]=20
[  974.321982] Showing all locks held in the system:
[  974.329776] 1 lock held by rcu_tasks_kthre/12:
[  974.335443]  #0: ffffffff82f6e890 =
(rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3f0
[  974.346935] 1 lock held by rcu_tasks_rude_/13:
[  974.352573]  #0: ffffffff82f6e610 =
(rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: =
rcu_tasks_one_gp+0x2d/0x3f0
[  974.364522] 1 lock held by rcu_tasks_trace/14:
[  974.370246]  #0: ffffffff82f6e350 =
(rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: =
rcu_tasks_one_gp+0x2d/0x3f0
[  974.382331] 1 lock held by khungtaskd/310:
[  974.387730]  #0: ffffffff82f6f2a0 (rcu_read_lock){....}-{1:2}, at: =
debug_show_all_locks+0x23/0x17e
[  974.398598] 5 locks held by kworker/8:1/330:
[  974.404176] 1 lock held by systemd-journal/761:
[  974.410003] 1 lock held by in:imklog/1390:
[  974.415337]  #0: ffff88810ead82e8 (&f->f_pos_lock){+.+.}-{3:3}, at: =
__fdget_pos+0x45/0x50
[  974.425284] 2 locks held by ublk/2250:
[  974.430167]  #0: ffff8881764e68a8 (&ctx->uring_lock){+.+.}-{3:3}, at: =
__x64_sys_io_uring_enter+0x21f/0x640
[  974.441708]  #1: ffffffff83106368 (ublk_ctl_mutex){+.+.}-{3:3}, at: =
ublk_ctrl_uring_cmd+0x6e4/0x1110
[  974.452674]=20
[  974.455090] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
