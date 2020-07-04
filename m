Return-Path: <SRS0=lYHe=AP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F91C433E0
	for <linux-block@archiver.kernel.org>; Sat,  4 Jul 2020 11:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE3A20890
	for <linux-block@archiver.kernel.org>; Sat,  4 Jul 2020 11:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8W6H/Ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgGDLiC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:38:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42296 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727918AbgGDLiC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Jul 2020 07:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593862680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpHNZSWTvNpdjCnV42CBeVUQTVizWFE0z5sdll89oss=;
        b=T8W6H/RylzgrX86yMcQoMO82LSfKvRgOednEmfK8mj16uCFMnb8uGQwOnSN/32LkPgvYHb
        HRDZlb+Qbb3v6dp8YNc8LnSSLY9S5rvYE334ZgyQzro2EODKotyfIlA41YFJF6nLBfH+p6
        6K3DShlkr2ebVIuid3OJNZ+rs0lPJLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-IcbLSqOvOC2sZ8CnHwwiLw-1; Sat, 04 Jul 2020 07:37:58 -0400
X-MC-Unique: IcbLSqOvOC2sZ8CnHwwiLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8401E186A201;
        Sat,  4 Jul 2020 11:37:57 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D46973FFE;
        Sat,  4 Jul 2020 11:37:57 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 230EB1809542;
        Sat,  4 Jul 2020 11:37:57 +0000 (UTC)
Date:   Sat, 4 Jul 2020 07:37:56 -0400 (EDT)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     chaitanya.kulkarni@wdc.com, axboe@kernel.dk
Cc:     CKI Project <cki-project@redhat.com>, linux-block@vger.kernel.org,
        Rachel Sibley <rasibley@redhat.com>
Message-ID: <44170938.33551884.1593862676831.JavaMail.zimbra@redhat.com>
In-Reply-To: <cki.3B19A2362B.9VSYF9B2I1@redhat.com>
References: <cki.3B19A2362B.9VSYF9B2I1@redhat.com>
Subject: regression with commit "null_blk: add helper for deleting the
 nullb_list"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.68.5.41, 10.4.195.21]
Thread-Topic: regression with commit "null_blk: add helper for deleting the nullb_list"
Thread-Index: jA4NTAI/SHQ08aY7SUabbvu68snI8A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

commit[1] on linux-block/for-next introduced one regression which lead kern=
el panic, could you help check it?

[1]
commit a65dee60e5384a648bc49c4ffbd3960d3fa354b0 (origin/for-5.9/drivers)
Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Thu Jul 2 18:31:30 2020 -0700

    null_blk: add helper for deleting the nullb_list

[2]
[  301.942805] run blktests block/006 at 2020-07-04 07:28:13
[  310.483587] ------------[ cut here ]------------
[  310.488208] kernel BUG at lib/idr.c:491!
[  310.492141] invalid opcode: 0000 [#1] SMP NOPTI
[  310.496674] CPU: 9 PID: 2261 Comm: modprobe Tainted: G          I       =
5.8.0-rc3+ #1
[  310.504498] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.6.4 0=
4/09/2020
[  310.511982] RIP: 0010:ida_free+0x140/0x150
[  310.516076] Code: 00 48 89 ef e8 e1 75 fd ff 48 3d 00 04 00 00 75 ce 48 =
89 ef e8 11 89 e3 ff eb ba 48 8d 74 2d 01 48 89 e7 e8 92 02 01 00 eb b5 <0f=
> 0b e8 29 65 46 00 66 0f 1f 84 00 00 00 00 00 41 55 4c 8d 6f 08
[  310.534823] RSP: 0018:ffffa84d40fd7e50 EFLAGS: 00010282
[  310.540047] RAX: 00000000003fffe7 RBX: 00000000ffff9c5d RCX: 00000000808=
00001
[  310.547171] RDX: ffff9465fb695b01 RSI: 00000000ffff9c5d RDI: ffffffffc05=
46740
[  310.554305] RBP: ffffffffc0546750 R08: 0000000000000001 R09: 00000000000=
00000
[  310.561435] R10: ffff945746955760 R11: 0000000000000000 R12: 00000000000=
0005d
[  310.568559] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[  310.575683] FS:  00007f8d250b7740(0000) GS:ffff9466bf840000(0000) knlGS:=
0000000000000000
[  310.583760] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  310.589498] CR2: 00007f8d24553230 CR3: 000000101fc96003 CR4: 00000000007=
606e0
[  310.596622] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  310.603753] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  310.610878] PKRU: 55555554
[  310.613592] Call Trace:
[  310.616049]  null_del_dev+0x2b/0x120 [null_blk]
[  310.620579]  null_delete_nullb_list+0x2c/0x38 [null_blk]
[  310.625890]  null_exit+0x2f/0xc4d [null_blk]
[  310.630165]  __x64_sys_delete_module+0x153/0x210
[  310.634782]  ? __prepare_exit_to_usermode+0x6d/0x1c0
[  310.639748]  do_syscall_64+0x4d/0x90
[  310.643327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  310.648377] RIP: 0033:0x7f8d24583e57
[  310.651958] Code: Bad RIP value.
[  310.655189] RSP: 002b:00007ffed28bbf68 EFLAGS: 00000202 ORIG_RAX: 000000=
00000000b0
[  310.662748] RAX: ffffffffffffffda RBX: 0000000001727410 RCX: 00007f8d245=
83e57
[  310.669879] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00000000017=
27478
[  310.677010] RBP: 0000000000000000 R08: 00007f8d2484d060 R09: 00007f8d245=
f8a00
[  310.684136] R10: 00007ffed28bb360 R11: 0000000000000202 R12: 00000000000=
00000
[  310.691267] R13: 0000000000000001 R14: 0000000001727478 R15: 00000000000=
00000
[  310.698392] Modules linked in: null_blk(-) rpcsec_gss_krb5 auth_rpcgss n=
fsv4 dns_resolver nfs lockd grace fscache intel_rapl_msr intel_rapl_common =
rfkill skx_edac x86_pkg_temp_thermal sunrpc intel_powerclamp coretemp kvm_i=
ntel kvm iTCO_wdt dell_smbios vfat iTCO_vendor_support fat wmi_bmof dell_wm=
i_descriptor ipmi_ssif irqbypass crc32_pclmul dcdbas ghash_clmulni_intel ae=
sni_intel acpi_ipmi crypto_simd ipmi_si mei_me cryptd ipmi_devintf i2c_i801=
 sg mei glue_helper dax_pmem_compat pcspkr i2c_smbus lpc_ich device_dax wmi=
 ipmi_msghandler dax_pmem_core acpi_power_meter dm_multipath ip_tables xfs =
libcrc32c nd_pmem nd_btt sd_mod t10_pi crc_t10dif crct10dif_generic mgag200=
 drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fo=
ps drm_ttm_helper ttm drm ahci libahci libata tg3 crct10dif_pclmul megaraid=
_sas crct10dif_common nfit crc32c_intel ptp pps_core i2c_algo_bit libnvdimm=
 dm_mirror dm_region_hash dm_log dm_mod
[  310.780000] ---[ end trace 61a20a5d291b22f8 ]---
[  310.811342] RIP: 0010:ida_free+0x140/0x150
[  310.815444] Code: 00 48 89 ef e8 e1 75 fd ff 48 3d 00 04 00 00 75 ce 48 =
89 ef e8 11 89 e3 ff eb ba 48 8d 74 2d 01 48 89 e7 e8 92 02 01 00 eb b5 <0f=
> 0b e8 29 65 46 00 66 0f 1f 84 00 00 00 00 00 41 55 4c 8d 6f 08
[  310.834190] RSP: 0018:ffffa84d40fd7e50 EFLAGS: 00010282
[  310.839416] RAX: 00000000003fffe7 RBX: 00000000ffff9c5d RCX: 00000000808=
00001
[  310.846549] RDX: ffff9465fb695b01 RSI: 00000000ffff9c5d RDI: ffffffffc05=
46740
[  310.853679] RBP: ffffffffc0546750 R08: 0000000000000001 R09: 00000000000=
00000
[  310.860812] R10: ffff945746955760 R11: 0000000000000000 R12: 00000000000=
0005d
[  310.867945] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[  310.875076] FS:  00007f8d250b7740(0000) GS:ffff9466bf840000(0000) knlGS:=
0000000000000000
[  310.883161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  310.888908] CR2: 00007f8d24553230 CR3: 000000101fc96003 CR4: 00000000007=
606e0
[  310.896040] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  310.903172] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  310.910306] PKRU: 55555554
[  310.913019] Kernel panic - not syncing: Fatal exception
[  311.326108] Kernel Offset: 0x1a400000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)
[  311.351017] ---[ end Kernel panic - not syncing: Fatal exception ]---


Best Regards,
  Yi Zhang

