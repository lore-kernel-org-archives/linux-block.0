Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AAAC6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 03:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCUDRk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 23:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUDRj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 23:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879C301AF
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 20:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679368605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bF5buev3i8KquyGxySHCKJe6zjRd5xfoGPifHREiigk=;
        b=NrMO7EIQ2aRhyiGLlpA5Sddri8+EjHZ7z+MZtQy391+moCa2h1/uuf7US114khX+DIAFJ1
        ek8wOZ63IRGOt68X7vpGRpDuOtAI4Lk/3/nvpOBqIFD8aZjck/fvwCIUvuswFTPkGqUmIz
        ip2q6/spOTjFeFi+Sbu0iKbiEhuk2kA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552--F0PmVIWMwer49gDW8CVag-1; Mon, 20 Mar 2023 23:16:43 -0400
X-MC-Unique: -F0PmVIWMwer49gDW8CVag-1
Received: by mail-ed1-f71.google.com with SMTP id en6-20020a056402528600b004fa01232e6aso20088777edb.16
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 20:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679368602;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bF5buev3i8KquyGxySHCKJe6zjRd5xfoGPifHREiigk=;
        b=T4XMkg0FtQ6rbKaKaZugN+1ollEpWRnjCpXinHHSLzyuBb2t3/3Wo+1P46VoU3LGLp
         yEOd3+6HGhdLM7EJKGX1jGpbvezNglGdiMhokg53OoEWviXMW7fRpx1PqXmUwQm/KaJg
         gdtWBtHYp3FwDh6jwhzunZszH+zL89+ThAwCMMEyjB9Zf5GD4oaUtKCxKhW0pGy6rvNB
         oafR5okbrKEXT+BstUdjO2sFWUzGjAX+U/nw9duRi72fA8RAKgpN/Ey/E3TsaGBi1FKw
         ZuI2bbdX8uYUPYUoWvTZsBfw78hdJd7DcbwnMFmmAEy7CchRve3SMgdyehWFGgp0qDHU
         FdSQ==
X-Gm-Message-State: AO0yUKUzIfexJiQgm1D6KrKK+eoDV7cvfJ5nsMfK15Zt0GsWLPxMe0hH
        WQvUgyRVxX/znqcJrjRT6CT5afRiI6kpX4jRETLmE5NIf+fJb0j00Sw+6sWgsOzWSiv31LSB/hp
        7oNf9EuFa1lVhL8aAeI1XgSzc5kVam7SaDZZp104Vh0BkiLgdY9MY
X-Received: by 2002:a50:f683:0:b0:4fc:7014:f91c with SMTP id d3-20020a50f683000000b004fc7014f91cmr855590edn.5.1679368602187;
        Mon, 20 Mar 2023 20:16:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set8WXIf7A1f5zKPeIf+4nwfJBx/QXwY24cEarJ6w2MQy7r/teni/1FfIgerOKrpB/ubIb3cnCCC+1rZwYzH7M5c=
X-Received: by 2002:a50:f683:0:b0:4fc:7014:f91c with SMTP id
 d3-20020a50f683000000b004fc7014f91cmr855582edn.5.1679368601827; Mon, 20 Mar
 2023 20:16:41 -0700 (PDT)
MIME-Version: 1.0
From:   Changhui Zhong <czhong@redhat.com>
Date:   Tue, 21 Mar 2023 11:16:30 +0800
Message-ID: <CAGVVp+VB8_8uySZgX2R-rXrTWaL+P0SB4ghKe_4uObqwAgHQHg@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 11 PID: 4009 at fs/proc/generic.c:718 remove_proc_entry+0x192/0x1a0
To:     linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Below issue was triggered on blktests block/001 testing, pls help check it
branch: linux-block.git@block-6.3

[  259.089813] ------------[ cut here ]------------
[  259.090462] remove_proc_entry: removing non-empty directory
'scsi/scsi_debug', leaking at least '12'
[  259.090947] WARNING: CPU: 11 PID: 4009 at fs/proc/generic.c:718
remove_proc_entry+0x192/0x1a0
[  259.091752] Modules linked in: scsi_debug(-) sr_mod cdrom tls
rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache
netfs rfkill sunrpc vfat fat dm_multipath intel_rapl_msr
intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel ipmi_ssif kvm iTCO_wdt iTCO_vendor_support
irqbypass mgag200 rapl intel_cstate i2c_algo_bit drm_shmem_helper
intel_uncore drm_kms_helper pcspkr acpi_ipmi i2c_i801 ipmi_si
syscopyarea i2c_smbus sysfillrect lpc_ich ipmi_devintf hpilo ioatdma
sysimgblt dca ipmi_msghandler acpi_tad acpi_power_meter drm fuse xfs
libcrc32c sd_mod st tainted 6.3.0-rc1+ #1
[  259.594730] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
Gen9, BIOS P89 05/21/2018
[  259.595169] RIP: 0010:remove_proc_entry+0x192/0x1a0
[  259.595766] Code: c7 08 96 99 94 48 85 c0 48 8d 90 78 ff ff ff 48
0f 45 c2 48 8b 55 78 4c 8b 80 a0 00 00 00 48 8b 92 a0 00 00 00 e8 0e
41 c3 ff <0f> 0b e9 43 ff ff ff e8 b2 c3 78 00 66 90 90 90 90 90 90 90
90 90
[  259.597033] RSP: 0018:ffffb0b884e3bd08 EFLAGS: 00010282
[  259.597294] RAX: 0000000000000000 RBX: ffff90718180c840 RCX: 0000000000000000
[  259.598031] RDX: ffff9074efcec540 RSI: ffff9074efcdf840 RDI: ffff9074efcdf840
[  259.598751] RBP: ffff90718981ecc0 R08: 0000000000000000 R09: 00000000ffff7fff
[  259.599472] R10: ffffb0b884e3bba8 R11: ffffffff94fe65a8 R12: ffff90718981ed40
[  259.600195] R13: 0000000000000000 R14: 0000000000000080 R15: 0000000000000000
[  259.600939] FS:  00007fc82f20a740(0000) GS:ffff9074efcc0000(0000)
knlGS:0000000000000000
[  259.601332] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  259.602008] CR2: 00007fc82e921530 CR3: 000000011c14c006 CR4: 00000000001706e0
[  259.602726] Call Trace:
[  259.602860]  <TASK>
[  259.603330]  scsi_proc_hostdir_rm+0x76/0xc0
[  259.603557]  scsi_host_dev_release+0x37/0xe0
[  259.604148]  device_release+0x34/0x90
[  259.604347]  kobject_cleanup+0x3a/0x130
[  259.604594]  devic_host+0xd1/0x100 [scsi_debug]
[  260.105078]  scsi_debug_exit+0x1d/0x410 [scsi_debug]
[  260.105598]  __do_sys_delete_module.constprop.0+0x17a/0x2f0
[  260.105890]  ? syscall_trace_enter.constprop.0+0x126/0x1a0
[  260.106151]  do_syscall_64+0x5c/0x90
[  260.106344]  ? exc_page_fault+0x62/0x150
[  260.106534]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  260.106801] RIP: 0033:0x7fc82e83f5ab
[  260.107029] Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89
01 48
[  260.108262] RSP: 002b:00007ffd4de9e878 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[  260.109021] RAX: ffffffffffffffda RBX: 00005568c3820d50 RCX: 00007fc82e83f5ab
[  260.109757] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005568c3820db8
[  260.110477] RBP: 00005568c3820d50 R08: 0000000000000000 R09: 0000000000000000
[  260.111206] R10: 00007fc82e99eac0 R11: 0000000000000206 R12: 00005568c3820db8
[  260.111924] R13: 0000000000000000 R14: 00005568c3820db8 R15: 00007ffd4dea0ba8
[  260.112659]  </TASK>
[  260.112835] ---[ end trace 0000000000000000 ]---

--
Best Regards,
Changhui Zhong

