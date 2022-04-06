Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8F0C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 16:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiDFQbG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbiDFQan (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 12:30:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1297D304E10
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 18:45:00 -0700 (PDT)
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KY6kl0YfCz1HBSf;
        Wed,  6 Apr 2022 09:44:31 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 09:44:57 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 09:44:56 +0800
Subject: Re: 5.17, WARNING: at block/bfq-iosched.c:602
 bfqq_request_over_limit+0x122/0x3a0
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
CC:     Chris Murphy <lists@colorremedies.com>,
        linux-block <linux-block@vger.kernel.org>
References: <CAJCQCtTw_2C7ZSz7as5Gvq=OmnDiio=HRkQekqWpKot84sQhFA@mail.gmail.com>
 <d6626daa-94a3-6f76-53d9-a350e1db2d53@kernel.dk>
 <5C015FDB-B35D-45D3-9CE7-E3B2544DAA67@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <6f72e1fa-6651-005a-7935-93b0450dce9f@huawei.com>
Date:   Wed, 6 Apr 2022 09:44:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5C015FDB-B35D-45D3-9CE7-E3B2544DAA67@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2022/04/04 22:35, Paolo Valente Ð´µÀ:
> This seems to have to do with Jan's patches on tag allocation. I'm CCing him too. Jan, I'm willing to provide my usual dev version for testing, if useful.

Hi, Paolo

I had observed this warning for a long time, and it's very to reporduce
by our reporducer for the problem that Jan fixed recently.

I thougt this warning is due to bfqq is associated with wrong cgroup,
which should be fixed by Jan's patch.

What do you think, Jan ?

> 
>> Il giorno 2 apr 2022, alle ore 19:47, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> Adding Paolo
>>
>> On 4/2/22 12:39 AM, Chris Murphy wrote:
>>> Looks like a regression of some sort in BFQ, but I'm not immediately
>>> aware of a manifestation in user space. I've also found four other
>>> downstream BFQ related call traces with xfs and btrfs joining in. I'll
>>> list those before the trace...
>>>
>>> [   45.263999] kernel: ------------[ cut here ]------------
>>> [   45.264006] kernel: WARNING: CPU: 4 PID: 73 at
>>> block/bfq-iosched.c:602 bfqq_request_over_limit+0x122/0x3a0
>>> [   45.264014] kernel: Modules linked in: uinput rfcomm snd_seq_dummy
>>> snd_hrtimer nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
>>> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
>>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink
>>> qrtr bnep b43 snd_hda_codec_cirrus snd_hda_codec_generic btusb
>>> uvcvideo cordic btrtl ledtrig_audio mac80211 btbcm videobuf2_vmalloc
>>> snd_hda_intel btintel videobuf2_memops snd_intel_dspcfg videobuf2_v4l2
>>> btmtk snd_intel_sdw_acpi libarc4 videobuf2_common snd_hda_codec
>>> cfg80211 bluetooth intel_rapl_msr videodev intel_rapl_common
>>> snd_hda_core ssb mc x86_pkg_temp_thermal intel_powerclamp coretemp
>>> ecdh_generic snd_hwdep rfkill kvm_intel snd_seq bcm5974
>>> apple_mfi_fastcharge snd_seq_device i915 joydev snd_pcm kvm snd_timer
>>> irqbypass snd mei_pxp iTCO_wdt mei_hdcp intel_pmc_bxt bcma applesmc
>>> at24 soundcore iTCO_vendor_support mei_me rapl i2c_i801 acpi_als
>>> intel_cstate ttm
>>> [   45.264066] kernel:  mei intel_uncore industrialio_triggered_buffer
>>> i2c_smbus lpc_ich sbs kfifo_buf apple_gmux sbshc industrialio apple_bl
>>> pcspkr zram isofs squashfs crct10dif_pclmul crc32_pclmul crc32c_intel
>>> sdhci_pci cqhci ghash_clmulni_intel hid_appleir firewire_ohci sdhci
>>> tg3 thunderbolt firewire_core mmc_core crc_itu_t hid_apple video uas
>>> usb_storage sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls cxgb3i
>>> cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp
>>> libiscsi_tcp libiscsi scsi_transport_iscsi loop ip6_tables ip_tables
>>> ipmi_devintf ipmi_msghandler fuse
>>> [   45.264101] kernel: CPU: 4 PID: 73 Comm: kworker/u16:2 Not tainted
>>> 5.17.1-300.fc36.x86_64 #1
>>> [   45.264104] kernel: Hardware name: Apple Inc.
>>> MacBookPro8,2/Mac-94245A3940C91C80, BIOS
>>> MBP81.88Z.0050.B00.1804101331 04/10/18
>>> [   45.264106] kernel: Workqueue: loop0 loop_workfn [loop]
>>> [   45.264112] kernel: RIP: 0010:bfqq_request_over_limit+0x122/0x3a0
>>> [   45.264115] kernel: Code: 1e 48 8b 5b 60 8d 78 01 48 83 c6 08 48 85
>>> db 0f 84 0e 02 00 00 89 f8 44 0f b6 63 18 45 84 e4 0f 84 f4 01 00 00
>>> 44 39 e8 7c d4 <0f> 0b 8d 58 ff 44 39 e8 0f 85 24 02 00 00 83 fb ff 0f
>>> 84 d8 01 00
>>> [   45.264118] kernel: RSP: 0018:ffffa8e34034f7b8 EFLAGS: 00010046
>>> [   45.264120] kernel: RAX: 0000000000000005 RBX: ffff92914c004098
>>> RCX: 0000000000000000
>>> [   45.264122] kernel: RDX: 0000000000000000 RSI: ffffa8e34034f800
>>> RDI: 0000000000000005
>>> [   45.264123] kernel: RBP: ffff9291435c5680 R08: 0000000000000800
>>> R09: 0000000000008000
>>> [   45.264125] kernel: R10: 0000000000000000 R11: ffffa8e34034f8e0
>>> R12: 0000000000000001
>>> [   45.264126] kernel: R13: 0000000000000005 R14: 0000000000000004
>>> R15: 0000000000000002
>>> [   45.264128] kernel: FS:  0000000000000000(0000)
>>> GS:ffff9293a3b00000(0000) knlGS:0000000000000000
>>> [   45.264130] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   45.264131] kernel: CR2: 00007fa7a5755000 CR3: 000000010a9ec002
>>> CR4: 00000000000606e0
>>> [   45.264133] kernel: Call Trace:
>>> [   45.264136] kernel:  <TASK>
>>> [   45.264140] kernel:  ? mempool_alloc+0x4f/0x170
>>> [   45.264145] kernel:  ? bvec_alloc+0x62/0xb0
>>> [   45.264148] kernel:  ? kmem_cache_alloc+0x162/0x2c0
>>> [   45.264152] kernel:  bfq_limit_depth+0xc3/0x220
>>> [   45.264155] kernel:  __blk_mq_alloc_requests+0x237/0x2a0
>>> [   45.264160] kernel:  blk_mq_submit_bio+0x3d3/0x620
>>> [   45.264163] kernel:  submit_bio_noacct+0x1f3/0x2a0
>>> [   45.264165] kernel:  mpage_readahead+0x133/0x180
>>> [   45.264171] kernel:  ? isofs_get_blocks+0x210/0x210 [isofs]
>>> [   45.264175] kernel:  read_pages+0x61/0x2a0
>>> [   45.264178] kernel:  page_cache_ra_unbounded+0x1a8/0x200
>>> [   45.264182] kernel:  filemap_get_pages+0x4ab/0x620
>>> [   45.264185] kernel:  ? copy_page_to_iter+0x2bd/0x410
>>> [   45.264189] kernel:  filemap_read+0xa8/0x2e0
>>> [   45.264192] kernel:  ? avc_has_perm+0x7a/0x170
>>> [   45.264196] kernel:  ? check_preempt_wakeup+0x125/0x2a0
>>> [   45.264202] kernel:  do_iter_readv_writev+0x149/0x180
>>> [   45.264206] kernel:  do_iter_read+0xde/0x1d0
>>> [   45.264209] kernel:  loop_process_work+0x68f/0x8f0 [loop]
>>> [   45.264214] kernel:  process_one_work+0x1c4/0x380
>>> [   45.264218] kernel:  worker_thread+0x4d/0x380
>>> [   45.264221] kernel:  ? process_one_work+0x380/0x380
>>> [   45.264223] kernel:  kthread+0xe6/0x110
>>> [   45.264225] kernel:  ? kthread_complete_and_exit+0x20/0x20
>>> [   45.264227] kernel:  ret_from_fork+0x1f/0x30
>>> [   45.264233] kernel:  </TASK>
>>> [   45.264234] kernel: ---[ end trace 0000000000000000 ]---
>>>
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2068723
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2049004
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2066214
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2064732
>>>
>>
>>
>> -- 
>> Jens Axboe
> 
> .
> 
