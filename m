Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B953FC10F27
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 16:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F86924655
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 16:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2eyDqZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCIQmP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:42:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32824 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgCIQmO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 12:42:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so8293264wrd.0
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KuLNvzeyVvGLltHx3+bbVL+qtfjLzeaJ7yeN666G1fU=;
        b=z2eyDqZRLNbUpP54DzfIV8NCQxaah5XHM9s2kmGal5EYOiHNGQyXCbP7AokJG/33pg
         NH5MaupO2Ievn6ILP+ve+prpq85jDd/6qydVFwGmQwlMYfdb3T2CBDlv9ckZMlxQQV59
         K6wByiHaqSlnEpD6+h5dlhXXOxH6m78SdkBIcbYE2BQ54TghA7HL1Zu0ZYNxGq8Dpv1s
         4R0MlAvxKQALbTDfkB4XFb9o5FQi2yD4pfACAC5WAU1b4Uadyj6XKN7P4oo/QKJHurlb
         DxFxpmAJhq/OO5lmgquRc0xAX+pdAiAtcUBFJWoHihBtmtadQbKB+NzlaRDSqIAUSmAV
         RYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KuLNvzeyVvGLltHx3+bbVL+qtfjLzeaJ7yeN666G1fU=;
        b=K7tFHKRQPPIpNgrnyjjLmg4VjMu2W+0m1/BUvui+9m1u1QimXUuzQ+sujlpQ1eRq8u
         aZiMcFoY7VXcXE1acMUqB6r5JANCjjUDYToNCwtrHLSzSAMZxwRfiuiMummxHkVAUhHA
         Y1xUVpOFSLQ7mZQxKrUlO/JFgR1rgljzBDwe8qy8Miy5PLc9xB7KNxAjjnwm+oXfYrm1
         ZEgDbpUmeP8eUz9zsC8t9oB0AsRBqFF/eTOB1DPck5aEeVgKSbg2F3YKU5/ryBcRHDeJ
         GZxz/qqWL3Zbswx/3yVRdC74TSqsWKJWy5CyImB4+VQwUj4TlxZZ/rXzdzOlqVjGG+1Q
         zH4g==
X-Gm-Message-State: ANhLgQ0PljlNLJzt7HuB+cZnCdKdwO3y1LtkhiuExz36JjLJHMm+wQZq
        pkpLJ80EuVHxqtUIMV4mahnkjg==
X-Google-Smtp-Source: ADFU+vuQnaOtd59I963CnI/l0FrOXWVOeQ76ezi4bnOW5eohiIgR0DWvnMX5AKi00d9mfbF5/iBp7g==
X-Received: by 2002:a5d:5681:: with SMTP id f1mr9546462wrv.137.1583772130831;
        Mon, 09 Mar 2020 09:42:10 -0700 (PDT)
Received: from [192.168.0.102] (88-147-36-163.dyn.eolo.it. [88.147.36.163])
        by smtp.gmail.com with ESMTPSA id e22sm96498wme.45.2020.03.09.09.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 09:42:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: =?utf-8?Q?Re=3A_=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E6=2E?=
 =?utf-8?Q?0-rc4-61a0925=2Ecki_=28mainline=2Ekernel=2Eorg=29?=
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <ba09351f-0a5a-824a-dbf2-021360581cd7@redhat.com>
Date:   Mon, 9 Mar 2020 17:42:17 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        LTP Mailing List <ltp@lists.linux.it>,
        Xiong Zhou <xzhou@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86A42362-D355-4885-AC68-B43E46FBB109@linaro.org>
References: <cki.FEFA879F6B.TFTZ93YIF0@redhat.com>
 <ba09351f-0a5a-824a-dbf2-021360581cd7@redhat.com>
To:     Rachel Sibley <rasibley@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Rachel,
IIUC, you can reproduce this bug reliably. If so, I'd need you to test a =
debugging patch (on top of one of the offending kernels).

Looking forward to your feedback,
Paolo

> Il giorno 9 mar 2020, alle ore 15:27, Rachel Sibley =
<rasibley@redhat.com> ha scritto:
>=20
> (cc'ing linux-block@vger.kernel.org)
>=20
> Hello,
>=20
> We are seeing a kernel panic triggered with LTP and xfstests against a =
recent commit for mainline,
> wanted to share in case it's not already known.
>=20
> Kernel repo: =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> Commit: 61a09258f2e5 - Merge tag 'for-linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
>=20
> We have also seen it with 2c523b344dfa and 378fee2e6b12 commits as =
well.
>=20
> LTP: =
https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/03/08/=
477469/x86_64_1_console.log
> xfstests: =
https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/03/08/=
477469/x86_64_4_console.log
>=20
> [-- MARK -- Sun Mar  8 02:45:00 2020]
> [  762.315610] BUG: kernel NULL pointer dereference, address: =
0000000000000158
> [  762.323385] #PF: supervisor read access in kernel mode
> [  762.329119] #PF: error_code(0x0000) - not-present page
> [  762.334853] PGD 0 P4D 0
> [  762.337680] Oops: 0000 [#1] SMP PTI
> [  762.341575] CPU: 9 PID: 87 Comm: kworker/9:1 Not tainted =
5.6.0-rc4-61a0925.cki #1
> [  762.349927] Hardware name: Cisco Systems, Inc. =
UCS-E160DP-M1/K9/UCS-E160DP-M1/K9, BIOS UCSED.1.5.0.2.051520131757 =
05/15/2013
> [  762.362453] Workqueue: cgroup_destroy css_killed_work_fn
> [  762.368387] RIP: 0010:bfq_bfqq_expire+0x1c/0x940
> [  762.373540] Code: 01 00 00 c7 80 f8 00 00 00 01 00 00 00 c3 66 66 =
66 66 90 41 57 41 56 41 55 41 54 41 89 cc 55 48 89 fd 53 48 89 f3 48 83 =
ec 28 <8b> be 58 01 00 00 65 48 8b 04 25 28 00 00 00 48 89 44 24 20 31 =
c0
> [  762.394500] RSP: 0018:ffff9927c03bbd50 EFLAGS: 00010086
> [  762.400331] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000004
> [  762.408301] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
ffff8965a3913800
> [  762.416270] RBP: ffff8965a3913800 R08: ffff896592d41098 R09: =
ffff89657aa8df00
> [  762.424233] R10: 0000000000000000 R11: ffff89657aa8df00 R12: =
0000000000000004
> [  762.432200] R13: ffff89659f0cd9b0 R14: ffff8965a3913bf0 R15: =
ffff89659f0cd898
> [  762.440175] FS:  0000000000000000(0000) GS:ffff8965a7c40000(0000) =
knlGS:0000000000000000
> [  762.449211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  762.455622] CR2: 0000000000000158 CR3: 000000065afc6003 CR4: =
00000000000606e0
> [  762.463599] Call Trace:
> [  762.466341]  ? bfq_idle_extract+0x40/0xb0
> [  762.470821]  bfq_bfqq_move+0x14f/0x160
> [  762.475011]  bfq_pd_offline+0xd3/0xf0
> [  762.479112]  blkg_destroy+0x52/0xf0
> [  762.483005]  blkcg_destroy_blkgs+0x4f/0xa0
> [  762.487582]  css_killed_work_fn+0x4d/0xd0
> [  762.492066]  process_one_work+0x1b5/0x360
> [  762.496547]  worker_thread+0x50/0x3c0
> [  762.500641]  kthread+0xf9/0x130
> [  762.504153]  ? process_one_work+0x360/0x360
> [  762.508813]  ? kthread_park+0x90/0x90
> [  762.512909]  ret_from_fork+0x35/0x40
>=20
> Thanks,
> Rachel
>=20
> On 3/7/20 9:59 PM, CKI Project wrote:
>> Hello,
>> We ran automated tests on a recent commit from this kernel tree:
>>        Kernel repo: =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>             Commit: 61a09258f2e5 - Merge tag 'for-linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
>> The results of these automated tests are provided below.
>>     Overall result: FAILED (see details below)
>>              Merge: OK
>>            Compile: OK
>>              Tests: FAILED
>> All kernel binaries, config files, and logs are available for =
download here:
>>   =
https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=3Ddataw=
arehouse/2020/03/08/477469
>> One or more kernel tests failed:
>>     x86_64:
>>      =E2=9D=8C LTP
>>      =E2=9D=8C xfstests - ext4
>> We hope that these logs can help you find the problem quickly. For =
the full
>> detail on our testing procedures, please scroll to the bottom of this =
message.
>> Please reply to this email if you have any questions about the tests =
that we
>> ran or if you have any suggestions on how to make future tests more =
effective.
>>         ,-.   ,-.
>>        ( C ) ( K )  Continuous
>>         `-',-.`-'   Kernel
>>           ( I )     Integration
>>            `-'
>> =
__________________________________________________________________________=
____
>> Compile testing
>> ---------------
>> We compiled the kernel for 1 architecture:
>>     x86_64:
>>       make options: -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
>> Hardware testing
>> ----------------
>> We booted each kernel and ran the following tests:
>>   x86_64:
>>     Host 1:
>>        =E2=9C=85 Boot test
>>        =E2=9C=85 Podman system integration test - as root
>>        =E2=9C=85 Podman system integration test - as user
>>        =E2=9D=8C LTP
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test =
Utility)
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking bridge: sanity
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking MACsec: sanity
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking socket: fuzz
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking sctp-auth: sockopts =
test
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking: igmp conformance test
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route: pmtu
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - local
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - forward
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking TCP: keepalive test
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking UDP: socket
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: geneve basic =
test
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: gre basic
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 L2TP basic test
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: vxlan basic
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - =
transport
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - =
tunnel
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 audit: audit testsuite test
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 httpd: mod_ssl smoke sanity
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 tuned: tune-processes-through-perf
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 pciutils: sanity smoke test
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA PCM loopback test
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA Control (mixer) Userspace =
Element test
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: SCSI VPD
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 trace: ftrace/tracer
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 CIFS Connectathon
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest =
suites
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 jvm - DaCapo =
Benchmark Suite
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 jvm - jcstress tests
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: =
kaslr
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 LTP: openposix test =
suite
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking vnic: =
ipvlan/basic
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 iotop: sanity
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Usex - version 1.9-29
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: dm/common
>>     Host 2:
>>        =E2=9C=85 Boot test
>>        =E2=9C=85 Storage SAN device stress - mpt3sas driver
>>     Host 3:
>>        =E2=9C=85 Boot test
>>        =E2=9C=85 Storage SAN device stress - megaraid_sas
>>     Host 4:
>>        =E2=9C=85 Boot test
>>        =E2=9D=8C xfstests - ext4
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 selinux-policy: serge-testsuite
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 lvm thinp sanity
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: software RAID testing
>>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 IOMMU boot test
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 IPMI driver test
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 IPMItool loop stress =
test
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 power-management: =
cpupower/sanity test
>>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>>   Test sources: https://github.com/CKI-project/tests-beaker
>>     =F0=9F=92=9A Pull requests are welcome for new tests or =
improvements to existing tests!
>> Waived tests
>> ------------
>> If the test run included waived tests, they are marked with =F0=9F=9A=A7=
. Such tests are
>> executed but their results are not taken into account. Tests are =
waived when
>> their results are not reliable enough, e.g. when they're just =
introduced or are
>> being fixed.
>> Testing timeout
>> ---------------
>> We aim to provide a report within reasonable timeframe. Tests that =
haven't
>> finished running yet are marked with =E2=8F=B1.
>=20

