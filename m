Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BCEC433F5
	for <linux-block@archiver.kernel.org>; Mon,  4 Apr 2022 14:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377562AbiDDOh2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Apr 2022 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377571AbiDDOhQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Apr 2022 10:37:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3593F302
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 07:35:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so13264300ejd.9
        for <linux-block@vger.kernel.org>; Mon, 04 Apr 2022 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gcXeN8v+fBW9rJbzPQGzazRdrLOuzrN1tuPiNbaCkEo=;
        b=ZlyXgQwQX182azoHK4lhuMIRKM0hT1IwEIVavReXqgO4y4g2Sk21i0PIRNrEdz2RT1
         yXLQGOAQ5MQnhkYYly/tmOXckG/Wv3DJVKJWifTvcWEKMeg1CQWLeUo1iZcT5Cqy7NJH
         2+445X5X+P81CnRbunvMK5Myly0MTKTyN01MH5SHw+y+tTda0k4hTkHPYs05hONmbnwu
         2IGepz7wg+5J5SrShdvxSWfLduzjTUhM3Dz0EDOEYvKNm354vAu8SNqkd/GqZO+uojNB
         5DkSTeEPxQ0i5U+H57tHKq22Ul1v2oFZbJa9/Ea+jmcP5mknBpzSBX+hIroXl+v1b4PG
         a4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gcXeN8v+fBW9rJbzPQGzazRdrLOuzrN1tuPiNbaCkEo=;
        b=eztrUXEQjz9lzzqUNgUlLya5MGGHsrpNQrLroA2YjXhHT50uIY1aqPaUf4npCgAooU
         iKt7vDw42T4TePXkZXaE+A/0BNMpl4dlaSvet9vm9mlm4nl6RqhUyuMcKxWtoa8sfMSD
         /hDJaNISAro41NZtkTw4FDkpzOto90/MbN6ikPVflDPMFWbZX8RwEJ/Iap/PJdKSVVLM
         QPuY9CoyDeL9MDZQLrsG3Kg6fCeVGrx3mWaYoH7INJGr0fTDf+4vtzKh1whNpNwwvLgO
         zWknELksnw4OB4IInzxubx181ADVvQENikDkyD5ozUise38nnltbKtFDJgrylGLclQyT
         S+YA==
X-Gm-Message-State: AOAM53394FGMa13vaT2L3kmBH5ruzrwY8N3JJSgjZTZ41DV1aW01DfMu
        D0CKXD9X05r2E9srA2JXKLL4QA==
X-Google-Smtp-Source: ABdhPJyLYhNWtdvEEGN4ub10dQA53gULhuEBl1kFSB+p1tN/Ei3Sq2FWr7gXBjJf8ia9kVRQqpPN1g==
X-Received: by 2002:a17:907:1b1d:b0:6e4:b5fc:e8e6 with SMTP id mp29-20020a1709071b1d00b006e4b5fce8e6mr329862ejc.215.1649082914274;
        Mon, 04 Apr 2022 07:35:14 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id x3-20020a50d9c3000000b0041c8ce4bcd7sm4153946edj.63.2022.04.04.07.35.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Apr 2022 07:35:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: 5.17, WARNING: at block/bfq-iosched.c:602
 bfqq_request_over_limit+0x122/0x3a0
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <d6626daa-94a3-6f76-53d9-a350e1db2d53@kernel.dk>
Date:   Mon, 4 Apr 2022 16:35:11 +0200
Cc:     Chris Murphy <lists@colorremedies.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C015FDB-B35D-45D3-9CE7-E3B2544DAA67@linaro.org>
References: <CAJCQCtTw_2C7ZSz7as5Gvq=OmnDiio=HRkQekqWpKot84sQhFA@mail.gmail.com>
 <d6626daa-94a3-6f76-53d9-a350e1db2d53@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This seems to have to do with Jan's patches on tag allocation. I'm CCing =
him too. Jan, I'm willing to provide my usual dev version for testing, =
if useful.

> Il giorno 2 apr 2022, alle ore 19:47, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> Adding Paolo
>=20
> On 4/2/22 12:39 AM, Chris Murphy wrote:
>> Looks like a regression of some sort in BFQ, but I'm not immediately
>> aware of a manifestation in user space. I've also found four other
>> downstream BFQ related call traces with xfs and btrfs joining in. =
I'll
>> list those before the trace...
>>=20
>> [   45.263999] kernel: ------------[ cut here ]------------
>> [   45.264006] kernel: WARNING: CPU: 4 PID: 73 at
>> block/bfq-iosched.c:602 bfqq_request_over_limit+0x122/0x3a0
>> [   45.264014] kernel: Modules linked in: uinput rfcomm snd_seq_dummy
>> snd_hrtimer nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
>> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink
>> qrtr bnep b43 snd_hda_codec_cirrus snd_hda_codec_generic btusb
>> uvcvideo cordic btrtl ledtrig_audio mac80211 btbcm videobuf2_vmalloc
>> snd_hda_intel btintel videobuf2_memops snd_intel_dspcfg =
videobuf2_v4l2
>> btmtk snd_intel_sdw_acpi libarc4 videobuf2_common snd_hda_codec
>> cfg80211 bluetooth intel_rapl_msr videodev intel_rapl_common
>> snd_hda_core ssb mc x86_pkg_temp_thermal intel_powerclamp coretemp
>> ecdh_generic snd_hwdep rfkill kvm_intel snd_seq bcm5974
>> apple_mfi_fastcharge snd_seq_device i915 joydev snd_pcm kvm snd_timer
>> irqbypass snd mei_pxp iTCO_wdt mei_hdcp intel_pmc_bxt bcma applesmc
>> at24 soundcore iTCO_vendor_support mei_me rapl i2c_i801 acpi_als
>> intel_cstate ttm
>> [   45.264066] kernel:  mei intel_uncore =
industrialio_triggered_buffer
>> i2c_smbus lpc_ich sbs kfifo_buf apple_gmux sbshc industrialio =
apple_bl
>> pcspkr zram isofs squashfs crct10dif_pclmul crc32_pclmul crc32c_intel
>> sdhci_pci cqhci ghash_clmulni_intel hid_appleir firewire_ohci sdhci
>> tg3 thunderbolt firewire_core mmc_core crc_itu_t hid_apple video uas
>> usb_storage sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls cxgb3i
>> cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp
>> libiscsi_tcp libiscsi scsi_transport_iscsi loop ip6_tables ip_tables
>> ipmi_devintf ipmi_msghandler fuse
>> [   45.264101] kernel: CPU: 4 PID: 73 Comm: kworker/u16:2 Not tainted
>> 5.17.1-300.fc36.x86_64 #1
>> [   45.264104] kernel: Hardware name: Apple Inc.
>> MacBookPro8,2/Mac-94245A3940C91C80, BIOS
>> MBP81.88Z.0050.B00.1804101331 04/10/18
>> [   45.264106] kernel: Workqueue: loop0 loop_workfn [loop]
>> [   45.264112] kernel: RIP: 0010:bfqq_request_over_limit+0x122/0x3a0
>> [   45.264115] kernel: Code: 1e 48 8b 5b 60 8d 78 01 48 83 c6 08 48 =
85
>> db 0f 84 0e 02 00 00 89 f8 44 0f b6 63 18 45 84 e4 0f 84 f4 01 00 00
>> 44 39 e8 7c d4 <0f> 0b 8d 58 ff 44 39 e8 0f 85 24 02 00 00 83 fb ff =
0f
>> 84 d8 01 00
>> [   45.264118] kernel: RSP: 0018:ffffa8e34034f7b8 EFLAGS: 00010046
>> [   45.264120] kernel: RAX: 0000000000000005 RBX: ffff92914c004098
>> RCX: 0000000000000000
>> [   45.264122] kernel: RDX: 0000000000000000 RSI: ffffa8e34034f800
>> RDI: 0000000000000005
>> [   45.264123] kernel: RBP: ffff9291435c5680 R08: 0000000000000800
>> R09: 0000000000008000
>> [   45.264125] kernel: R10: 0000000000000000 R11: ffffa8e34034f8e0
>> R12: 0000000000000001
>> [   45.264126] kernel: R13: 0000000000000005 R14: 0000000000000004
>> R15: 0000000000000002
>> [   45.264128] kernel: FS:  0000000000000000(0000)
>> GS:ffff9293a3b00000(0000) knlGS:0000000000000000
>> [   45.264130] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
>> [   45.264131] kernel: CR2: 00007fa7a5755000 CR3: 000000010a9ec002
>> CR4: 00000000000606e0
>> [   45.264133] kernel: Call Trace:
>> [   45.264136] kernel:  <TASK>
>> [   45.264140] kernel:  ? mempool_alloc+0x4f/0x170
>> [   45.264145] kernel:  ? bvec_alloc+0x62/0xb0
>> [   45.264148] kernel:  ? kmem_cache_alloc+0x162/0x2c0
>> [   45.264152] kernel:  bfq_limit_depth+0xc3/0x220
>> [   45.264155] kernel:  __blk_mq_alloc_requests+0x237/0x2a0
>> [   45.264160] kernel:  blk_mq_submit_bio+0x3d3/0x620
>> [   45.264163] kernel:  submit_bio_noacct+0x1f3/0x2a0
>> [   45.264165] kernel:  mpage_readahead+0x133/0x180
>> [   45.264171] kernel:  ? isofs_get_blocks+0x210/0x210 [isofs]
>> [   45.264175] kernel:  read_pages+0x61/0x2a0
>> [   45.264178] kernel:  page_cache_ra_unbounded+0x1a8/0x200
>> [   45.264182] kernel:  filemap_get_pages+0x4ab/0x620
>> [   45.264185] kernel:  ? copy_page_to_iter+0x2bd/0x410
>> [   45.264189] kernel:  filemap_read+0xa8/0x2e0
>> [   45.264192] kernel:  ? avc_has_perm+0x7a/0x170
>> [   45.264196] kernel:  ? check_preempt_wakeup+0x125/0x2a0
>> [   45.264202] kernel:  do_iter_readv_writev+0x149/0x180
>> [   45.264206] kernel:  do_iter_read+0xde/0x1d0
>> [   45.264209] kernel:  loop_process_work+0x68f/0x8f0 [loop]
>> [   45.264214] kernel:  process_one_work+0x1c4/0x380
>> [   45.264218] kernel:  worker_thread+0x4d/0x380
>> [   45.264221] kernel:  ? process_one_work+0x380/0x380
>> [   45.264223] kernel:  kthread+0xe6/0x110
>> [   45.264225] kernel:  ? kthread_complete_and_exit+0x20/0x20
>> [   45.264227] kernel:  ret_from_fork+0x1f/0x30
>> [   45.264233] kernel:  </TASK>
>> [   45.264234] kernel: ---[ end trace 0000000000000000 ]---
>>=20
>>=20
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2068723
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2049004
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2066214
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2064732
>>=20
>=20
>=20
> --=20
> Jens Axboe

