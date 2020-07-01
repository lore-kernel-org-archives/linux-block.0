Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B61C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 16:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711E72085B
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 16:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Vz8YN3nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbgGAQmr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731394AbgGAQmr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 12:42:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F896C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 09:42:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x72so1805157pfc.6
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AzJIPSx9o7jzhC73zv9WoYKZyS/uStAQcWPkPydxUUs=;
        b=Vz8YN3njEjUgatK+87TD9am9spDu6YneCeWQZ1dyK3WQsoXifde9e1mtAX4U68TSn9
         UcnYqAj7YcxwiO/hIe7eNbPRIDk5Pk2uu9hZ0GSRp/QPtXOhecCD2SoHdS6THaJeihH0
         Cj7nbYI9fNOC2Bmd1OasDwVZnjfEUZ6W0Bi7u4oZ96EmZP83K8d6odDbs/Nmb1abCj4j
         25Un5iWBY0rNPXfT2Ja+mj9vu+6871+4Vhk7p+xdvj9NYhUd/8YHRU/DsfrHq495XirE
         GXCsmuYOzb7YRIG2pPP9JZuWSMpF6qmA8R6vSp0QNuAMcWmfXDQBHOafEKRX54AHJrpJ
         SS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AzJIPSx9o7jzhC73zv9WoYKZyS/uStAQcWPkPydxUUs=;
        b=CFql6NW7a7kr1T6nPmsVKkrCyChnRopEvJBTuF6gHHADyo22HIHK89nQdykHaufuPa
         fDmI2VRrOuGUns3VL7NdKVcUUy05aQBrO5SKaI2yvSOJkAhFjWwg7jEHYwCfHTnfr2cF
         KD9GbawLqB5Z1gAY/CA72jy7iuXOzS5akVj0FZuINeV3ccwV4B7p+x3Y2/LhsQLsoQxm
         hvbvy7InJ7l7kTETXR+tRHx1g/YZxsH+yWsYxzQmAKSCAd9NSgYW1beKBOmdyMjZmRpn
         KETbwdu8fqNbvnVQmOHTlfSoEO+DmhP0/Hfna4jDqvlaDsw0kYDbW+wRdREM1x8Ek6WC
         sKRw==
X-Gm-Message-State: AOAM53395x3SVsObUBmkwk1xE3484NW7UWmEgec4Vj/tzPu537NKg6Q8
        p4i2lJNxNs+biGMrQmEiULty+GGuit3SeQ==
X-Google-Smtp-Source: ABdhPJyT7g1vjTyRu3KvHYjQNVx4MC86Qt9B5yZqptRvROteqRFzjk2IYnLJfRclgq7zq04nnF4FfA==
X-Received: by 2002:a63:1a44:: with SMTP id a4mr6615722pgm.281.1593621766715;
        Wed, 01 Jul 2020 09:42:46 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:a48e:6306:8f4:9d74? ([2605:e000:100e:8c61:a48e:6306:8f4:9d74])
        by smtp.gmail.com with ESMTPSA id n19sm6379165pgb.0.2020.07.01.09.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 09:42:46 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=f0=9f=92=a5_PANICKED=3a_Test_report_for_kernel_5?=
 =?UTF-8?Q?=2e8=2e0-rc2-c698ae9=2ecki_=28block=29?=
To:     Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        linux-block@vger.kernel.org
Cc:     Xiong Zhou <xzhou@redhat.com>
References: <cki.6F69C04B6D.Z70BF8WNV2@redhat.com>
 <8388a5c5-e5b9-e17b-1522-cf742bb23ad9@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a856bc99-eece-f56c-dc79-0ba37979f3dd@kernel.dk>
Date:   Wed, 1 Jul 2020 10:42:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8388a5c5-e5b9-e17b-1522-cf742bb23ad9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 10:37 AM, Rachel Sibley wrote:
> Hi, we're seeing multiple panics across all arches, I included a snippet of the call trace for both
> xfstests and boot test.
> 
> You should be able to inspect in more detail by viewing the console.log under each build/tests directory:
> https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/06/30/609250

This was due to a bad patch series, which since got reverted and redone. Current
tree should be fine.

Now it doesn't matter for this one since I guessed what this was and found it
before the bot did, but I do wish the reports were easier to look at. I should
not have to dig through directories (which were empty when the report went out,
btw) to find logs, then download logs and leaf through hundreds of kb of text
to find out why the bot thought the tree was broken. It should be readily
apparent and in the email. If there's an OOPS, include the oops.

I'd much rather get a separate report for each arch, each having the oops
that got triggered, than get one massive email where it's really not obvious
where to look.

This:

> https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/06/30/609250/build_ppc64le_redhat%3A926155/tests/8501352/ppc64le_3_console.log
> 
> [  890.198174] run fstests generic/040 at 2020-06-30 12:03:02
> [  891.055910] BUG: Unable to handle kernel instruction fetch (NULL pointer?)
> [  891.055942] Faulting instruction address: 0x00000000
> [  891.055956] Oops: Kernel access of bad area, sig: 11 [#1]
> [  891.055969] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
> [  891.055982] Modules linked in: dm_flakey rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache rfkill joydev i40e at24 sunrpc ses 
> enclosure scsi_transport_sas regmap_i2c ofpart powernv_flash mtd crct10dif_vpmsum ipmi_powernv ipmi_devintf opal_prd ipmi_msghandler rtc_opal i2c_opal 
> ip_tables xfs libcrc32c ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea vmx_crypto sysfillrect sysimgblt crc32c_vpmsum fb_sys_fops 
> drm_ttm_helper ttm drm i2c_core aacraid drm_panel_orientation_quirks
> [  891.056077] CPU: 25 PID: 84211 Comm: systemd-udevd Kdump: loaded Not tainted 5.8.0-rc2-c698ae9.cki #1
> [  891.056095] NIP:  0000000000000000 LR: c00000000070eef0 CTR: 0000000000000000
> [  891.056110] REGS: c0000007c25474e0 TRAP: 0400   Not tainted  (5.8.0-rc2-c698ae9.cki)
> [  891.056125] MSR:  9000000040009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24488248  XER: 20040000
> [  891.056145] CFAR: c00000000070eeec IRQMASK: 0
> [  891.056145] GPR00: c00000000070f050 c0000007c2547770 c000000001cb7f00 c0000002b6059af8
> [  891.056145] GPR04: 0000000000000000 c0000007dcf6f000 c0000002b6059af8 0000000000000000
> [  891.056145] GPR08: 00000007fc940000 c000000001c97d78 0000000000000000 0000000000000000
> [  891.056145] GPR12: 0000000000000000 c0000007fffe2e00 c0000007c2344400 0000000000000000
> [  891.056145] GPR16: 0000000000000000 00007fffc9b7cb50 c0000007c2344400 0000000000000000
> [  891.056145] GPR20: c0000002b307bdd8 0000000000000000 c0000007c2547ca8 c0000007dcf6f000
> [  891.056145] GPR24: 000000000000000c 000000000000000a c0000007c2547790 0000000000000001
> [  891.056145] GPR28: 0000000000000000 0000000000000000 00000000ffffffff c0000002b6059af8
> [  891.056260] NIP [0000000000000000] 0x0
> [  891.056272] LR [c00000000070eef0] submit_bio_noacct+0x2f0/0x5c0
> [  891.056285] Call Trace:
> [  891.056294] [c0000007c2547770] [c00000000070f050] submit_bio_noacct+0x450/0x5c0 (unreliable)
> [  891.056312] [c0000007c2547800] [c00000000070f228] submit_bio+0x68/0x2d0
> [  891.056328] [c0000007c25478c0] [c000000000505fe8] mpage_readahead+0x1c8/0x290
> [  891.056345] [c0000007c25479a0] [c0000000004fd6f8] blkdev_readahead+0x28/0x40
> [  891.056362] [c0000007c25479c0] [c000000000383980] read_pages+0xb0/0x4a0
> [  891.056376] [c0000007c2547a40] [c000000000384474] page_cache_readahead_unbounded+0x244/0x300
> [  891.056395] [c0000007c2547b00] [c00000000037445c] generic_file_buffered_read+0x9bc/0x1120
> [  891.056411] [c0000007c2547c50] [c0000000004fddc0] blkdev_read_iter+0x50/0x80
> [  891.056428] [c0000007c2547c70] [c000000000493c64] new_sync_read+0x124/0x1a0
> [  891.056443] [c0000007c2547d10] [c000000000496e30] vfs_read+0x100/0x200
> [  891.056471] [c0000007c2547d70] [c000000000497368] ksys_read+0x78/0x130
> [  891.056487] [c0000007c2547dc0] [c000000000030564] system_call_exception+0xe4/0x170
> [  891.056504] [c0000007c2547e20] [c00000000000ca70] system_call_common+0xf0/0x278
> [  891.056518] Instruction dump:
> [  891.056529] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [  891.056545] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [  891.056564] ---[ end trace 14197a45ec121b51 ]---

Is what should be in the email, that's the important part.

-- 
Jens Axboe

