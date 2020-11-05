Return-Path: <SRS0=FEuC=EL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178E8C4741F
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 14:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8976C2071A
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 14:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g3DMkDWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgKEOTG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Nov 2020 09:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbgKEOTG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Nov 2020 09:19:06 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E5C0613CF
        for <linux-block@vger.kernel.org>; Thu,  5 Nov 2020 06:19:05 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id k21so1928633ioa.9
        for <linux-block@vger.kernel.org>; Thu, 05 Nov 2020 06:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/MQtvXIFXXUYij5z2uEqrbE1EOi/PMf63nYryHwj4mg=;
        b=g3DMkDWWyGLNpfy0vEsypNHVE7Jp5gF99zgM6s2Pq0kynJis9vyIkTyoGNdIdRlkcT
         MExKZbSzlNm8/g7JFMxhr+7yYqbwfuDk68z9ah5+MW0vgboxbrx5AKJGpHIF5elgEzxr
         mLKz0DQ8lSZjbwqPUK1R2h6asMy97eKmmvJy0dJqPas6wzrEitMiVHMuEWOfZ/3VTD6g
         WDjPl+n5z2Kdszmsr5oQEMqgA/oQCzQlFRFFxZL97FPSSHbyzEErfXxUCzgJ03Rse+2T
         zqa+9kLKrtRdm761J6nF6f1VQfox6yLvegyhlHaatZEi7mGIJvV5o6Q8vNe8jz1NQIDj
         gQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/MQtvXIFXXUYij5z2uEqrbE1EOi/PMf63nYryHwj4mg=;
        b=MgxeTe5uOF4NlOwvsPWulsvXiTrdds0+GZejzHE3cELfLv990rmGiBjd5OrhNo37An
         FDIDNjn9G7VioFzN6I7ytnhAD8ElnGO4ivHTVgOwXxiEOze7D2etX8NLKTErgrg3n/a2
         FPd+MOohp7GI7ooZGonR/WoIv4zJmcFIwXkN3GpYXL66MmCB4mz94uFIr/1GUsDn1Qj3
         w2JEMMKImGM2HvxJS1nBN5C1j8tJ9h5qc3ytfeVK/15uT9BRmmRVInMgggGK2A+I2Po3
         UvCTX7MqiOhnUCADiw3S9EH9BdTv0dxMatoU89/4lbfdd1yZDf54o7NEGW6RB171ONfk
         uPcQ==
X-Gm-Message-State: AOAM532ZidOrsHhohX1MWHeZnUUWIx7Hhh8DwqEAWNGV1lsgk+t8IPNU
        OHITZ4v1mswcrtAAIBLh/Ni4mjhvuFVEhg==
X-Google-Smtp-Source: ABdhPJzO1/dvABZE0Z91SscWZw59QT9mkGgpejQEE7D42s3OyLrZ9+93Vi7ztSCbnfObi7/yqimx6g==
X-Received: by 2002:a6b:6016:: with SMTP id r22mr1751310iog.93.1604585944018;
        Thu, 05 Nov 2020 06:19:04 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c82sm1472288ilf.53.2020.11.05.06.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 06:19:03 -0800 (PST)
Subject: Re: [null_blk] aa1c09cb65:
 BUG:sleeping_function_called_from_invalid_context_at_include/linux/wait_bit.h
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20201105024145.GA31559@xsang-OptiPlex-9020>
 <3783b7839a6b4b5efec261f5692968c2d3ea6212.camel@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3524a5a-8f3d-e2dd-9d62-5f4da830262a@kernel.dk>
Date:   Thu, 5 Nov 2020 07:19:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3783b7839a6b4b5efec261f5692968c2d3ea6212.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/20 10:38 PM, Damien Le Moal wrote:
> On Thu, 2020-11-05 at 10:41 +0800, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: aa1c09cb65e2ed17cb8e652bc7ec84e0af1229eb ("null_blk: Fix locking in zoned mode")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>>
>> in testcase: blktests
>> version: blktests-x86_64-20445c5-1_20201007
>> with following parameters:
>>
>> 	test: zbd-group1
>> 	ucode: 0xdc
>>
>>
>>
>> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> kern  :err   : [   22.713558] BUG: sleeping function called from invalid context at include/linux/wait_bit.h:205
>> kern  :err   : [   22.722172] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 315, name: kworker/1:1H
>> kern  :warn  : [   22.730436] CPU: 1 PID: 315 Comm: kworker/1:1H Tainted: G          I       5.10.0-rc1-00007-gaa1c09cb65e2 #1
>> kern  :warn  : [   22.740256] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
>> kern  :warn  : [   22.747649] Workqueue: kblockd blk_mq_run_work_fn
>> kern  :warn  : [   22.752349] Call Trace:
>> kern  :warn  : [   22.754809]  dump_stack+0x57/0x6a
>> kern  :warn  : [   22.758121]  ___might_sleep.cold+0x87/0x95
>> kern  :warn  : [   22.762219]  null_process_zoned_cmd+0x180/0x532 [null_blk]
>> kern  :warn  : [   22.767703]  null_handle_cmd+0xa1/0x260 [null_blk]
>> kern  :warn  : [   22.772489]  ? null_queue_rq+0x68/0x160 [null_blk]
>> kern  :warn  : [   22.777278]  blk_mq_dispatch_rq_list+0x11a/0x7c0
>> kern  :warn  : [   22.781890]  ? update_load_avg+0x78/0x640
>> kern  :warn  : [   22.785896]  ? elv_rb_del+0x1f/0x40
>> kern  :warn  : [   22.789394]  ? deadline_remove_request+0x55/0xc0
>> kern  :warn  : [   22.794008]  __blk_mq_do_dispatch_sched+0xb8/0x2c0
>> kern  :warn  : [   22.798801]  ? set_next_entity+0xa3/0x200
>> kern  :warn  : [   22.802813]  __blk_mq_sched_dispatch_requests+0x143/0x1a0
>> kern  :warn  : [   22.808215]  blk_mq_sched_dispatch_requests+0x30/0x60
>> kern  :warn  : [   22.813271]  __blk_mq_run_hw_queue+0x5a/0x100
>> kern  :warn  : [   22.817630]  process_one_work+0x1b7/0x380
>> kern  :warn  : [   22.821643]  ? process_one_work+0x380/0x380
>> kern  :warn  : [   22.825826]  worker_thread+0x50/0x3c0
>> kern  :warn  : [   22.829484]  ? process_one_work+0x380/0x380
>> kern  :warn  : [   22.833663]  kthread+0x116/0x160
>> kern  :warn  : [   22.836892]  ? kthread_park+0xa0/0xa0
>> kern  :warn  : [   22.840551]  ret_from_fork+0x22/0x30
>> kern  :info  : [   22.845057] null_blk: module loaded
>> user  :warn  : [   22.864358] run blktests zbd/001 at 2020-11-04 14:59:13
>> kern  :info  : [   22.941643] null_blk: module loaded
>> user  :warn  : [   22.964171] run blktests zbd/002 at 2020-11-04 14:59:13
>> kern  :info  : [   23.057674] null_blk: module loaded
>> user  :warn  : [   23.080189] run blktests zbd/003 at 2020-11-04 14:59:13
>> kern  :info  : [   23.203825] null_blk: module loaded
>> user  :warn  : [   23.224124] run blktests zbd/004 at 2020-11-04 14:59:13
>> kern  :info  : [   23.386738] null_blk: module loaded
>> user  :warn  : [   23.572119] run blktests zbd/005 at 2020-11-04 14:59:13
>> kern  :err   : [   24.068107] BUG: sleeping function called from invalid context at include/linux/wait_bit.h:205
>> kern  :err   : [   24.076717] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 863, name: kworker/2:1H
>> kern  :warn  : [   24.084984] CPU: 2 PID: 863 Comm: kworker/2:1H Tainted: G        W I       5.10.0-rc1-00007-gaa1c09cb65e2 #1
>> kern  :warn  : [   24.094804] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
>> kern  :warn  : [   24.102195] Workqueue: kblockd blk_mq_run_work_fn
>> kern  :warn  : [   24.106894] Call Trace:
>> kern  :warn  : [   24.109339]  dump_stack+0x57/0x6a
>> kern  :warn  : [   24.112654]  ___might_sleep.cold+0x87/0x95
>> kern  :warn  : [   24.116748]  null_zone_write+0x76/0x2e0 [null_blk]
>> kern  :warn  : [   24.121535]  null_handle_cmd+0xa1/0x260 [null_blk]
>> kern  :warn  : [   24.126334]  ? null_queue_rq+0x68/0x160 [null_blk]
>> kern  :warn  : [   24.131121]  blk_mq_dispatch_rq_list+0x11a/0x7c0
>> kern  :warn  : [   24.135736]  ? elv_rb_del+0x1f/0x40
>> kern  :warn  : [   24.139226]  ? deadline_remove_request+0x55/0xc0
>> kern  :warn  : [   24.143853]  __blk_mq_do_dispatch_sched+0xb8/0x2c0
>> kern  :warn  : [   24.148640]  ? set_next_entity+0xa3/0x200
>> kern  :warn  : [   24.152646]  __blk_mq_sched_dispatch_requests+0x143/0x1a0
>> kern  :warn  : [   24.158040]  blk_mq_sched_dispatch_requests+0x30/0x60
>> kern  :warn  : [   24.163088]  __blk_mq_run_hw_queue+0x5a/0x100
>> kern  :warn  : [   24.167442]  process_one_work+0x1b7/0x380
>> kern  :warn  : [   24.171447]  ? process_one_work+0x380/0x380
>> kern  :warn  : [   24.175626]  worker_thread+0x50/0x3c0
>> kern  :warn  : [   24.179286]  ? process_one_work+0x380/0x380
>> kern  :warn  : [   24.183466]  kthread+0x116/0x160
>> kern  :warn  : [   24.186690]  ? kthread_park+0xa0/0xa0
>> kern  :warn  : [   24.190349]  ret_from_fork+0x22/0x30
>> kern  :info  : [   24.422777] null_blk: module loaded
>> user  :warn  : [   24.607211] run blktests zbd/006 at 2020-11-04 14:59:14
>> user  :notice: [   25.006293] install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/ntpdate_1%3a4.2.8p12+dfsg-4_amd64.deb
>>
>> user  :notice: [   25.020000] /opt/deb/libpython3.7-minimal_3.7.3-2+deb10u2_amd64.deb
>>
>> user  :notice: [   25.028912] /opt/deb/python3.7-minimal_3.7.3-2+deb10u2_amd64.deb
>>
>> user  :notice: [   25.037237] /opt/deb/python3-minimal_3.7.3-1_amd64.deb
>>
>> user  :notice: [   25.044998] /opt/deb/libpython3.7-stdlib_3.7.3-2+deb10u2_amd64.deb
>>
>> user  :notice: [   25.053741] /opt/deb/python3.7_3.7.3-2+deb10u2_amd64.deb
>>
>> user  :notice: [   25.061469] /opt/deb/libpython3-stdlib_3.7.3-1_amd64.deb
>>
>> user  :notice: [   25.069002] /opt/deb/python3_3.7.3-1_amd64.deb
>>
>> user  :notice: [   25.075706] /opt/deb/libatomic1_8.3.0-6_amd64.deb
>>
>> user  :notice: [   25.082896] /opt/deb/libquadmath0_8.3.0-6_amd64.deb
>>
>> user  :notice: [   25.090156] /opt/deb/libgcc-8-dev_8.3.0-6_amd64.deb
>>
>> kern  :err   : [   25.096023] BUG: sleeping function called from invalid context at include/linux/wait_bit.h:205
>> user  :notice: [   25.097197] /opt/deb/gcc-8_8.3.0-6_amd64.deb
>> kern  :err   : [   25.105145] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 315, name: kworker/1:1H
>> kern  :warn  : [   25.105147] CPU: 1 PID: 315 Comm: kworker/1:1H Tainted: G        W I       5.10.0-rc1-00007-gaa1c09cb65e2 #1
>> kern  :warn  : [   25.105147] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
>> kern  :warn  : [   25.105151] Workqueue: kblockd blk_mq_run_work_fn
>>
>>
>> kern  :warn  : [   25.117668] Call Trace:
>> kern  :warn  : [   25.117673]  dump_stack+0x57/0x6a
>> user  :notice: [   25.128170] /opt/deb/gcc_4%3a8.3.0-1_amd64.deb
>> kern  :warn  : [   25.134880]  ___might_sleep.cold+0x87/0x95
>> kern  :warn  : [   25.134884]  null_zone_write+0x76/0x2e0 [null_blk]
>> kern  :warn  : [   25.134887]  null_handle_cmd+0xa1/0x260 [null_blk]
>>
>> kern  :warn  : [   25.141077]  ? null_queue_rq+0x68/0x160 [null_blk]
>> kern  :warn  : [   25.141078]  blk_mq_dispatch_rq_list+0x11a/0x7c0
>> kern  :warn  : [   25.141080]  ? elv_rb_del+0x1f/0x40
>> kern  :warn  : [   25.141083]  ? deadline_remove_request+0x55/0xc0
>> user  :notice: [   25.143217] /opt/deb/g++-8_8.3.0-6_amd64.deb
>> kern  :warn  : [   25.145016]  __blk_mq_do_dispatch_sched+0xb8/0x2c0
>> kern  :warn  : [   25.145017]  ? set_next_entity+0xa3/0x200
>> kern  :warn  : [   25.145019]  __blk_mq_sched_dispatch_requests+0x143/0x1a0
>> kern  :warn  : [   25.145034]  blk_mq_sched_dispatch_requests+0x30/0x60
>>
>> kern  :warn  : [   25.152782]  __blk_mq_run_hw_queue+0x5a/0x100
>> kern  :warn  : [   25.152784]  process_one_work+0x1b7/0x380
>> kern  :warn  : [   25.152787]  ? process_one_work+0x380/0x380
>> user  :notice: [   25.157669] /opt/deb/g++_4%3a8.3.0-1_amd64.deb
>> kern  :warn  : [   25.161675]  worker_thread+0x50/0x3c0
>> kern  :warn  : [   25.161677]  ? process_one_work+0x380/0x380
>> kern  :warn  : [   25.161679]  kthread+0x116/0x160
>>
>> kern  :warn  : [   25.167965]  ? kthread_park+0xa0/0xa0
>> kern  :warn  : [   25.167967]  ret_from_fork+0x22/0x30
>> user  :notice: [   25.248060] /opt/deb/libdpkg-perl_1.19.7_all.deb
>>
>> user  :notice: [   25.254976] /opt/deb/patch_2.7.6-3+deb10u1_amd64.deb
>>
>> user  :notice: [   25.262613] /opt/deb/libboost-atomic1.67.0_1.67.0-13+deb10u1_amd64.deb
>>
>> user  :notice: [   25.271466] /opt/deb/liberror-perl_0.17027-2_all.deb
>>
>> user  :notice: [   25.278995] /opt/deb/multipath-tools_0.7.9-3+deb10u1_amd64.deb
>>
>> user  :notice: [   25.287034] /opt/deb/virt-what_1.19-1_amd64.deb
>>
>> user  :notice: [   25.293915] /opt/deb/gawk_1%3a4.2.1+dfsg-1_amd64.deb
>>
>> user  :notice: [   25.301619] Selecting previously unselected package ntpdate.
>>
>> user  :notice: [   25.310237] (Reading database ... 16553 files and directories currently installed.)
>>
>> user  :notice: [   25.320889] Preparing to unpack .../ntpdate_1%3a4.2.8p12+dfsg-4_amd64.deb ...
>>
>> user  :notice: [   25.330331] Unpacking ntpdate (1:4.2.8p12+dfsg-4) ...
>>
>> user  :notice: [   25.338357] Selecting previously unselected package libpython3.7-minimal:amd64.
>>
>> user  :notice: [   25.348949] Preparing to unpack .../libpython3.7-minimal_3.7.3-2+deb10u2_amd64.deb ...
>>
>> user  :notice: [   25.359785] Unpacking libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
>>
>> user  :notice: [   25.369225] Selecting previously unselected package python3.7-minimal.
>>
>> user  :notice: [   25.378717] Preparing to unpack .../python3.7-minimal_3.7.3-2+deb10u2_amd64.deb ...
>>
>> user  :notice: [   25.388863] Unpacking python3.7-minimal (3.7.3-2+deb10u2) ...
>>
>> user  :notice: [   25.397211] Selecting previously unselected package python3-minimal.
>>
>> user  :notice: [   25.406312] Preparing to unpack .../python3-minimal_3.7.3-1_amd64.deb ...
>>
>> user  :notice: [   25.415450] Unpacking python3-minimal (3.7.3-1) ...
>>
>> user  :notice: [   25.423301] Selecting previously unselected package libpython3.7-stdlib:amd64.
>>
>> user  :notice: [   25.433639] Preparing to unpack .../libpython3.7-stdlib_3.7.3-2+deb10u2_amd64.deb ...
>>
>> user  :notice: [   25.444115] Unpacking libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
>>
>> user  :notice: [   25.453041] Selecting previously unselected package python3.7.
>>
>> user  :notice: [   25.461670] Preparing to unpack .../python3.7_3.7.3-2+deb10u2_amd64.deb ...
>>
>> user  :notice: [   25.471015] Unpacking python3.7 (3.7.3-2+deb10u2) ...
>>
>> user  :notice: [   25.478866] Selecting previously unselected package libpython3-stdlib:amd64.
>>
>> user  :notice: [   25.488823] Preparing to unpack .../libpython3-stdlib_3.7.3-1_amd64.deb ...
>>
>> user  :notice: [   25.498355] Unpacking libpython3-stdlib:amd64 (3.7.3-1) ...
>>
>> user  :notice: [   25.506420] Selecting previously unselected package python3.
>>
>> user  :notice: [   25.514828] Preparing to unpack .../deb/python3_3.7.3-1_amd64.deb ...
>>
>> user  :notice: [   25.523387] Unpacking python3 (3.7.3-1) ...
>>
>> user  :notice: [   25.530228] Selecting previously unselected package libatomic1:amd64.
>>
>>
>>
>> To reproduce:
>>
>>         git clone https://github.com/intel/lkp-tests.git
>>         cd lkp-tests
>>         bin/lkp install job.yaml  # job file is attached in this email
>>         bin/lkp run     job.yaml
> 
> Jens,
> 
> I am failing to recreate this problem. First time I see it. All my
> testing, including blktests, never showed it before. I am trying to
> install lkp on my Fedora test box to run the exact job mentioned but
> that is not going smoothly (running Fedora 32 server). To be sure, I
> ran blktests again with default nullb and one with memory backing, as
> well as zonefs tests too, and all is good in my environment. 
> 
> I fail to see how queue_rq() end up being called in atomic context. I
> do not see any spinlock being held, and the backtrace clearly shows
> that this is a worker context, not hard IRQ. In any case, even without
> the new wait bit zone locking, the problem, whatever it is, existed
> already since the page allocation for memory backing may sleep.
> 
> Still digging to try to understand what is going on here.

Well, from a quick look, you're sleeping off ->queue_rq for zoned
devices. That's a definite no-no... If you need blocking context, you
need to use BLK_MQ_F_BLOCKING. Alternatively, the zone locking should
have a way of doing a trylock. But that might require other changes to
make sane progress without just hammering on it (eg returning BUSY if we
can't lock the zone).

So I'd say it very much looks broken right now.

-- 
Jens Axboe

