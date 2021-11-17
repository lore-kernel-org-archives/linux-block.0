Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6823AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A12861BF9
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhKQQAz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 11:00:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237243AbhKQQAx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 11:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637164674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=iTaY1XzScMM3wemVh2a45EOAp3qRshCPTons9dgthoA=;
        b=Xu9fjZQCX5BVToCtNRWUkLW3+V87WPqF3zR7pSYs9KNwtYEFQsrdWMH3Ubz5LycJi4ZWtz
        W+tj7eXKw5y7ecO3W4D5Z/3VGSZLWNtASKRmylXRSaLx9N91pObyx9C4cTSa1ort3ZG6H+
        ehYF3F7Od3IglmFerbfiZ8F9hc8e2II=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-MkzT4TwZMRmitr8c_B_ZOQ-1; Wed, 17 Nov 2021 10:57:53 -0500
X-MC-Unique: MkzT4TwZMRmitr8c_B_ZOQ-1
Received: by mail-yb1-f198.google.com with SMTP id d9-20020a251d09000000b005c208092922so4560677ybd.20
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iTaY1XzScMM3wemVh2a45EOAp3qRshCPTons9dgthoA=;
        b=ewTW257AIc9NgfyGvREKLq9yZ5L3bxzgkMCENWDZttvdfoYExfge9jgp4hKriAhjT9
         ewrve1+tvRGM8U9xtVuW3vvnsHc00YwNGvV6f8ZlOw/JcAKr8ZdaxVp/A/W6OCKBKqjn
         bMBINZDVuyPyRM65EHyzyv3v4z0hnJSyKkFSdCrH+InKhe1o/IBRmwnEt3vRIbK0i+yx
         KAyV4OG9mdLJgmLsWitWWsiUHXXwFGbFRLghfpPDW68Bazh/AdinQEekQXRocr3IgmVy
         NmQV6ZwTon1FmvNePGPUeh0MGHDkQYHeTjcHftuELYsgSXdhwT9ugVo2snASYkw2TOXY
         Fs1w==
X-Gm-Message-State: AOAM532+zCv25U8bu5GCDphiwZWKlWBkbsAqgbVKCD+A3JVQ2WpIGRTC
        Yl8HBIhLFiaNwWktFdGSWaPLvWqnTysbwUNBAjl6Nu3lGai6sl/qzDmaqHFW7km4J6WjwKWm9k0
        p+5AXIowv+MbWKiydfhhRZeglVmgMqfON2uOYcpc=
X-Received: by 2002:a25:73c7:: with SMTP id o190mr16710948ybc.522.1637164672623;
        Wed, 17 Nov 2021 07:57:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6OIpatvlpVxOVtahBKWfZDlCO5LJuuPugUpz4ukvSSUfCgdxmUtCd62jR6V6bQYYoaOFERHJMfOkkRvKtClQ=
X-Received: by 2002:a25:73c7:: with SMTP id o190mr16710905ybc.522.1637164672343;
 Wed, 17 Nov 2021 07:57:52 -0800 (PST)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 17 Nov 2021 23:57:41 +0800
Message-ID: <CAHj4cs97spcWGFjz4JPzaRuzHnRGZkKP6HWMSPkbKLS9EmWMJA@mail.gmail.com>
Subject: [regression] nvme pci sysfs remove operation hang during fio test
 observed on 5.16.0-rc1
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

I found this regression issue on 5.16.0-rc1, pls check it and let me
know if you need any test/debug info for it, thanks.

[  369.657564] INFO: task main.sh:1695 blocked for more than 122 seconds.
[  369.664871]       Tainted: G S                5.16.0-rc1 #1
[  369.671106] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  369.679854] task:main.sh         state:D stack:    0 pid: 1695
ppid:  1692 flags:0x00004004
[  369.679863] Call Trace:
[  369.679866]  <TASK>
[  369.679872]  __schedule+0x3e3/0x9a0
[  369.679887]  ? _raw_spin_lock_irqsave+0x17/0x40
[  369.679893]  schedule+0x44/0xc0
[  369.679899]  blk_mq_freeze_queue_wait+0x62/0x90
[  369.679908]  ? finish_wait+0x80/0x80
[  369.679920]  del_gendisk+0x18d/0x210
[  369.679931]  nvme_ns_remove+0xc7/0x1d0 [nvme_core]
[  369.679954]  nvme_remove_namespaces+0xac/0xf0 [nvme_core]
[  369.679974]  nvme_remove+0x60/0x140 [nvme]
[  369.679984]  pci_device_remove+0x36/0xb0
[  369.679994]  device_release_driver_internal+0xf7/0x1e0
[  369.680005]  pci_stop_bus_device+0x69/0x90
[  369.680012]  pci_stop_and_remove_bus_device_locked+0x16/0x30
[  369.680018]  remove_store+0x75/0x90
[  369.680025]  kernfs_fop_write_iter+0x130/0x1c0
[  369.680035]  new_sync_write+0x122/0x1b0
[  369.680045]  vfs_write+0x1ba/0x2a0
[  369.680053]  ksys_write+0x59/0xd0
[  369.680058]  do_syscall_64+0x3a/0x80
[  369.680067]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  369.680073] RIP: 0033:0x7f99b1159648
[  369.680078] RSP: 002b:00007ffec2a09748 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  369.680083] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f99b1159648
[  369.680086] RDX: 0000000000000002 RSI: 0000564e26ba1b20 RDI: 0000000000000001
[  369.680089] RBP: 0000564e26ba1b20 R08: 000000000000000a R09: 00007f99b11ec620
[  369.680091] R10: 000000000000000a R11: 0000000000000246 R12: 00007f99b142c6e0
[  369.680094] R13: 0000000000000002 R14: 00007f99b1427880 R15: 0000000000000002
[  369.680099]  </TASK>
[  492.536344] INFO: task main.sh:1695 blocked for more than 245 seconds.
[  492.543638]       Tainted: G S                5.16.0-rc1 #1
[  492.549870] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  492.558617] task:main.sh         state:D stack:    0 pid: 1695
ppid:  1692 flags:0x00004004
[  492.558625] Call Trace:
[  492.558627]  <TASK>
[  492.558631]  __schedule+0x3e3/0x9a0
[  492.558639]  ? _raw_spin_lock_irqsave+0x17/0x40
[  492.558644]  schedule+0x44/0xc0
[  492.558650]  blk_mq_freeze_queue_wait+0x62/0x90
[  492.558655]  ? finish_wait+0x80/0x80
[  492.558663]  del_gendisk+0x18d/0x210
[  492.558671]  nvme_ns_remove+0xc7/0x1d0 [nvme_core]
[  492.558692]  nvme_remove_namespaces+0xac/0xf0 [nvme_core]
[  492.558710]  nvme_remove+0x60/0x140 [nvme]
[  492.558718]  pci_device_remove+0x36/0xb0
[  492.558724]  device_release_driver_internal+0xf7/0x1e0
[  492.558732]  pci_stop_bus_device+0x69/0x90
[  492.558737]  pci_stop_and_remove_bus_device_locked+0x16/0x30
[  492.558742]  remove_store+0x75/0x90
[  492.558748]  kernfs_fop_write_iter+0x130/0x1c0
[  492.558756]  new_sync_write+0x122/0x1b0
[  492.558763]  vfs_write+0x1ba/0x2a0
[  492.558769]  ksys_write+0x59/0xd0
[  492.558775]  do_syscall_64+0x3a/0x80
[  492.558780]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  492.558785] RIP: 0033:0x7f99b1159648
[  492.558789] RSP: 002b:00007ffec2a09748 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  492.558794] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f99b1159648
[  492.558797] RDX: 0000000000000002 RSI: 0000564e26ba1b20 RDI: 0000000000000001
[  492.558800] RBP: 0000564e26ba1b20 R08: 000000000000000a R09: 00007f99b11ec620
[  492.558803] R10: 000000000000000a R11: 0000000000000246 R12: 00007f99b142c6e0
[  492.558805] R13: 0000000000000002 R14: 00007f99b1427880 R15: 0000000000000002
[  492.558811]  </TASK>

-- 
Best Regards,
  Yi Zhang

