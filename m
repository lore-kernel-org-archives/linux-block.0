Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED55C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 08:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjDFItt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjDFIto (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 04:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72267EDC
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680770929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mKQfLpcx+DsG/8tfNFoke4qNVoM/Ai+Q7L9CZtur3S0=;
        b=IqQAw0W4gwE8zOqASTSDE825pfn0xxkb3YVBeraC30+LY454VB2CXKEkH6cGGanwQrIzKQ
        rqVXCM6JIDGquINh6jUHJ9EWI+wGK7nVCRBPX7C8zoqQ3udTShPRecVs5D3un/eU2NUsfR
        93tzat3gfLp7aKVjqdzh0kWGRsuay2Q=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-2K82vzcoN7OkRlQCWDxwKw-1; Thu, 06 Apr 2023 04:48:47 -0400
X-MC-Unique: 2K82vzcoN7OkRlQCWDxwKw-1
Received: by mail-pl1-f198.google.com with SMTP id l14-20020a170902f68e00b001a1a9a1d326so22306708plg.9
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 01:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKQfLpcx+DsG/8tfNFoke4qNVoM/Ai+Q7L9CZtur3S0=;
        b=EUZglfWwI13gQT7G1XpuwL5Zf9KyxHTJjqrbeKUbU4/g2cSXVZ95w4Z9Fp16YD22bC
         yEdNLPHZSmduZxmFz09BIUZKqbeJVN3yOnxdGAtpsRobC0wH0oRe+PjhFs+GRw1znd//
         8bL7xNjqTPWj5LlWy5YNUdf4S4VFyK2y7u9Nkd+KPQgxNix3xWI4FwoZiwH2MJuSSUua
         JFeLMfII49SXilyXfps1Q1jTWTGZciOY38bfmWDdAB3yAorSaq2ZP5SuEqxDLU+RLvFQ
         qj2snB5esZpY3hjvKCm79vvKactxmS47mHAvqPW2ckfF7eR8GZov3EGrwp2aG+OoaKBC
         JB+g==
X-Gm-Message-State: AAQBX9f87VJTSAu7FJcEVq6k9uEei3fNlGH/h0tEAyLP326I/Q9hHHM+
        PLUX5byG38WEichc/WPc2RL/Ep71z1tGdEi1XXIuCagSHeIqGbiYTTD9qWCVzaGlai8H70Ill0O
        /gqvVB7oJhsnKKawxzQdwqb5kIaizQr+pFgPiCskWDBzkGkIwOWZf
X-Received: by 2002:a17:902:bb95:b0:1a2:a843:d363 with SMTP id m21-20020a170902bb9500b001a2a843d363mr3832941pls.10.1680770925522;
        Thu, 06 Apr 2023 01:48:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZdRTadiLtsrf//7LPR0WkA9tI0FLGVKqfKl4B2RADRyetKh3MFUJAXb+wFJBvGggiwW/e7lXWuRFMm2bAF5gE=
X-Received: by 2002:a17:902:bb95:b0:1a2:a843:d363 with SMTP id
 m21-20020a170902bb9500b001a2a843d363mr3832934pls.10.1680770925198; Thu, 06
 Apr 2023 01:48:45 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 6 Apr 2023 16:48:33 +0800
Message-ID: <CAHj4cs9i-OSiLuFwo5+ZwNTnYBiP_OZQB7SPs-1QOxRRXjJMMA@mail.gmail.com>
Subject: [bug report] blktests nvme-fc nvme/003 lead kernel NULL pointer
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
Running blktests nvme-fc tests on the latest linux-block/for-next
triggered below NULL pointer, pls help check it and let me know if you
need any info/test for it, thanks.

# nvme_trtype=3Dfc ./check nvme/003
nvme/003 (test if we're sending keep-alives to a discovery controller)
    runtime  10.337s  ...
WARNING: Test did not clean up fc device: nvme4

[ 2825.578026] loop: module loaded
[ 2825.608636] run blktests nvme/003 at 2023-04-06 04:29:02
[ 2825.664353] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2825.718843] nvme nvme2: NVME-FC{0}: create association : host wwpn
0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[ 2825.734930] (NULL device *): {0:0} Association created
[ 2825.740727] nvmet: creating discovery controller 1 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0044-4c10-8059-b5c04f4c4732.
[ 2825.758832] nvme nvme2: NVME-FC{0}: controller connect complete
[ 2825.765498] nvme nvme2: NVME-FC{0}: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[ 2825.778363] nvme nvme3: NVME-FC{1}: create association : host wwpn
0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[ 2825.794448] (NULL device *): {0:1} Association created
[ 2825.800272] nvmet: creating discovery controller 2 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0044-4c10-8059-b5c04f4c4732.
[ 2825.818336] nvme nvme3: NVME-FC{1}: controller connect complete
[ 2825.825004] nvme nvme3: NVME-FC{1}: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[ 2825.838044] nvme nvme4: NVME-FC{2}: create association : host wwpn
0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN
"blktests-subsystem-1"
[ 2825.852578] (NULL device *): {0:2} Association created
[ 2825.858388] nvmet: creating nvm controller 3 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0044-4c10-8059-b5c04f4c4732.
[ 2825.875227] nvme nvme4: NVME-FC{2}: controller connect complete
[ 2825.881896] nvme nvme4: NVME-FC{2}: new ctrl: NQN "blktests-subsystem-1"
[ 2825.889976] nvme nvme3: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[ 2825.911611] (NULL device *): {0:1} Association deleted
[ 2825.917363] (NULL device *): {0:1} Association freed
[ 2825.922913] (NULL device *): Disconnect LS failed: No Association
[ 2835.847208] nvme nvme2: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[ 2835.870520] (NULL device *): {0:0} Association deleted
[ 2835.876270] (NULL device *): {0:0} Association freed
[ 2835.881820] (NULL device *): Disconnect LS failed: No Association
[ 2835.890176] nvme nvme4: rescanning namespaces.
[ 2835.921308] nvme nvme2: NVME-FC{0}: create association : host wwpn
0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[ 2835.937389] (NULL device *): {0:0} Association created
[ 2835.943193] nvmet: connect request for invalid subsystem
nqn.2014-08.org.nvmexpress.discovery!
[ 2835.952848] nvme nvme2: Connect Invalid Data Parameter, subsysnqn
"nqn.2014-08.org.nvmexpress.discovery"
[ 2835.955520] nvme nvme4: NVME-FC{2}: io failed due to lldd error 6
[ 2835.963481] nvme nvme2: NVME-FC{0}: reset: Reconnect attempt failed (167=
70)
[ 2835.970290] nvme nvme4: NVME-FC{2}: transport association event:
transport detected io error
[ 2835.978027] nvme nvme2: NVME-FC{0}: reconnect failure
[ 2835.978047] nvme nvme2: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[ 2835.978083] nvme nvme2: NVME-FC{0}: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[ 2835.987481] nvme nvme4: NVME-FC{2}: resetting controller
[ 2836.017514] (NULL device *): {0:2} Association deleted
[ 2836.018502] (NULL device *): {0:0} Association deleted
[ 2836.023271] (NULL device *): {0:2} Association freed
[ 2836.029012] (NULL device *): {0:0} Association freed
[ 2836.034556] (NULL device *): Disconnect LS failed: No Association
[ 2836.058511] (NULL device *): Disconnect LS failed: No Association
[ 2836.059556] nvme nvme4: NVME-FC{2}: create association : host wwpn
0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN
"blktests-subsystem-1"
[ 2836.069844] nvme nvme4: Removing ctrl: NQN "blktests-subsystem-1"
[ 2836.079837] (NULL device *): {0:0} Association created
[ 2836.092403] nvme nvme4: Connect command failed: host path error
[ 2836.105501] (NULL device *): {0:0} Association deleted
[ 2836.111259] (NULL device *): {0:0} Association freed
[ 2836.116818] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[ 2836.124579] #PF: supervisor read access in kernel mode
[ 2836.130312] #PF: error_code(0x0000) - not-present page
[ 2836.136045] PGD 0 P4D 0
[ 2836.138872] Oops: 0000 [#1] PREEMPT SMP PTI
[ 2836.143542] CPU: 0 PID: 20 Comm: kworker/0:1 Kdump: loaded Not
tainted 6.3.0-rc5+ #2
[ 2836.152187] Hardware name: Dell Inc. PowerEdge R730xd/=C9=B2?Pow, BIOS
2.16.0 07/20/2022
[ 2836.160829] Workqueue: events nvme_fc_handle_ls_rqst_work [nvme_fc]
[ 2836.167842] RIP: 0010:memcpy_erms+0x6/0x10
[ 2836.172423] Code: c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 cc cc
cc cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 89 f8
48 89 d1 <f3> a4 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90
90 90
[ 2836.193372] RSP: 0018:ffffba2a80177df8 EFLAGS: 00010287
[ 2836.199195] RAX: ffff9d280e083fa0 RBX: ffff9d280e083fc0 RCX: 00000000000=
00018
[ 2836.207159] RDX: 0000000000000018 RSI: 0000000000000000 RDI: ffff9d280e0=
83fa0
[ 2836.215124] RBP: ffff9d29a9b89400 R08: ffff9d29a9b89ab8 R09: ffff9d29a9b=
89ab8
[ 2836.223088] R10: 0000000000000007 R11: 0000000000000007 R12: ffff9d280e7=
d8000
[ 2836.231052] R13: ffff9d29869c5780 R14: 0800000002000000 R15: 01000000200=
00000
[ 2836.239016] FS:  0000000000000000(0000) GS:ffff9d2977c00000(0000)
knlGS:0000000000000000
[ 2836.248048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2836.254461] CR2: 0000000000000000 CR3: 00000002fc220002 CR4: 00000000001=
706f0
[ 2836.262424] Call Trace:
[ 2836.265151]  <TASK>
[ 2836.267492]  fcloop_t2h_xmt_ls_rsp+0x3a/0xc0 [nvme_fcloop]
[ 2836.273629]  nvme_fc_xmt_ls_rsp+0x4f/0x90 [nvme_fc]
[ 2836.279085]  nvme_fc_handle_ls_rqst_work+0xbc/0x1e0 [nvme_fc]
[ 2836.285510]  process_one_work+0x1e5/0x3f0
[ 2836.289992]  ? __pfx_worker_thread+0x10/0x10
[ 2836.294760]  worker_thread+0x50/0x3a0
[ 2836.298850]  ? __pfx_worker_thread+0x10/0x10
[ 2836.303616]  kthread+0xd9/0x100
[ 2836.307122]  ? __pfx_kthread+0x10/0x10
[ 2836.311307]  ret_from_fork+0x2c/0x50
[ 2836.315306]  </TASK>
[ 2836.317743] Modules linked in: loop nvme_fcloop nvmet_fc nvmet
nvme_fc nvme_fabrics sunrpc intel_rapl_msr intel_rapl_common sb_edac
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel mgag200
dell_wmi_descriptor i2c_algo_bit ledtrig_audio kvm drm_shmem_helper
rfkill drm_kms_helper ipmi_ssif video iTCO_wdt iTCO_vendor_support
cdc_ether ipmi_si irqbypass usbnet syscopyarea rapl sysfillrect pcspkr
lpc_ich ipmi_devintf intel_cstate mii dcdbas mei_me mei intel_uncore
ipmi_msghandler sysimgblt mxm_wmi acpi_power_meter vfat fat fuse drm
xfs libcrc32c sd_mod sg ahci crct10dif_pclmul crc32_pclmul libahci
crc32c_intel nvme ghash_clmulni_intel nvme_core libata tg3
megaraid_sas nvme_common t10_pi wmi dm_mirror dm_region_hash dm_log
dm_mod
[ 2836.390183] CR2: 0000000000000000


--=20
Best Regards,
  Yi Zhang

