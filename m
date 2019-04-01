Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55249C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 00:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4F720872
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 00:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbfDAAoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 20:44:32 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:33080 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbfDAAoc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 20:44:32 -0400
Received: by mail-qt1-f169.google.com with SMTP id k14so8947404qtb.0
        for <linux-block@vger.kernel.org>; Sun, 31 Mar 2019 17:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=q7mGtB0s0nAE57wWaBDLnOgCRtlCmu+7PqheiRPOxlg=;
        b=IzdllkIuVwx7B6pYq8h4qt33xoeqdw7hLsEFg0tnouvrA0ODZBStQWlwljW1dhRN5Q
         Wgojp9r37v0Sv55AUuk4RWkNOH4w9FOkervcjKiq/Zu4OAqWFdy0wBHWPnrt0avHoaGb
         Eo7RpLY7wORyoWz2ka4q43sXxCM2fyfchUPOEhjY84ii+IOf3HTZ1XRK0BuqAczACCWQ
         h6nu+VDJpw5LnsuWp9wYtwq1oGiGZN4oOKj7kbknPpOIREkAxDwkyGajO5y3J+K6zSk8
         yBlqBcsgEslVOT31xsTXM2pnMrGDca4/YhiR9i+LFL39mj4SPXkZxhNHXb29dHMsNTJW
         PgtA==
X-Gm-Message-State: APjAAAX8jV+bzbtCA6hFGw+3zpqrjWFX5lbpFf+UnGsUfSXa+rdSnlHS
        AXq0OTshgUVigNlVqy2ROF3RqQ==
X-Google-Smtp-Source: APXvYqwkg3fYqMkXYkDLaUx4A5DaCyfOdV8V80LFNP95ZIVfk1YxCPgbYsVd5C1H9IvyqLjm5YMfxQ==
X-Received: by 2002:ac8:3629:: with SMTP id m38mr52141880qtb.369.1554079470927;
        Sun, 31 Mar 2019 17:44:30 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:422c:9885:a6c:81b2])
        by smtp.gmail.com with ESMTPSA id d205sm4622495qkg.66.2019.03.31.17.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 17:44:30 -0700 (PDT)
Message-ID: <514bc70458ce6360189f03fec96b565e5a29c461.camel@redhat.com>
Subject: Lock recursion seen on qla2xxx client when rebooting the target
 server
From:   Laurence Oberman <loberman@redhat.com>
To:     linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Himanshu Madhani <hmadhani@redhat.com>,
        "Madhani, Himanshu" <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>
Cc:     Marco Patalano <mpatalan@redhat.com>,
        "Dutile, Don" <ddutile@redhat.com>,
        "Van Assche, Bart" <bvanassche@acm.org>
Date:   Sun, 31 Mar 2019 20:44:29 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This who have been following my trials and tribulations with SRP and
block-mq panics (See Re: Panic when rebooting target server testing srp
on 5.0.0-rc2) know I was going to run the same test with qla2xxx and
F/C

Anyway, rebooting the targetserver (LIO) that was causing the block-mq
race that is still out there and not yet diagnosed when SRP is the
client causes issues with 5.1-rc2 as well.

The issue is different. I was seeing a total lockup and no console
messages. To get the lockup message I had to enable lock debugging.

Anyway, Hannes, how have you folks not seen these issues at Suse with
5.1+ testing. Here I caught two different problems that are now latent
in 5.1-x (maybe earlier too). This is a generic array reboot test that
sadly is a common issue with our customewrs when they have fabric or
array issues.

Kernel 5.1.0-rc2+ on an x86_64

localhost login: [  301.752492] BUG: spinlock cpu recursion on CPU#38,
kworker/38:0/204
[  301.782364]  lock: 0xffff90ddb2e43430, .magic: dead4ead, .owner:
kworker/38:1/271, .owner_cpu: 38
[  301.825496] CPU: 38 PID: 204 Comm: kworker/38:0 Kdump: loaded Not
tainted 5.1.0-rc2+ #1
[  301.863052] Hardware name: HP ProLiant ML150 Gen9/ProLiant ML150
Gen9, BIOS P95 05/21/2018
[  301.903614] Workqueue: qla2xxx_wq qla24xx_delete_sess_fn [qla2xxx]
[  301.933561] Call Trace:
[  301.945950]  dump_stack+0x5a/0x73
[  301.962080]  do_raw_spin_lock+0x83/0xa0
[  301.980287]  _raw_spin_lock_irqsave+0x66/0x80
[  302.001726]  ? qla24xx_delete_sess_fn+0x34/0x90 [qla2xxx]
[  302.028111]  qla24xx_delete_sess_fn+0x34/0x90 [qla2xxx]
[  302.052864]  process_one_work+0x215/0x4c0
[  302.071940]  ? process_one_work+0x18c/0x4c0
[  302.092228]  worker_thread+0x46/0x3e0
[  302.110313]  kthread+0xfb/0x130
[  302.125274]  ? process_one_work+0x4c0/0x4c0
[  302.146054]  ? kthread_bind+0x10/0x10
[  302.163789]  ret_from_fork+0x35/0x40

Just an FYI, with only 100 LUNS 4 paths i cannot boot the host without
adding my watchdog_thresh=60 to the kernel line.
I hard lockup during LUN discovery so that issue is also out there.

So far 5.x+ has been problemetic with regression testing.

Regards
Laurence

