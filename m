Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1754CC10F27
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 14:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BAE20578
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 14:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7mGMZnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCIO1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:27:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50134 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgCIO1S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Mar 2020 10:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583764036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPkjLKOfKoWwfRVNYyM+HmWPGqv7QTvfA9oc0uqL+DM=;
        b=B7mGMZnPI6EKLYL4m5V9qg19YH3hkNaXTx50pIgxFmLlzrl1GpDNSXQsKvAzvKkd9sh43i
        +q7veaLeAdlJSAIZIOjs6V2tose4HrtPo5G258CJPT2AeFW3iRpMTeLqTJWliXvq3Z/pLg
        OjhBIBOKLmBbbSkE2ltoZGHHhTW8Q/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-_7dH1zBaORGB_FJctz3Qyg-1; Mon, 09 Mar 2020 10:27:12 -0400
X-MC-Unique: _7dH1zBaORGB_FJctz3Qyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 580AA8010E8;
        Mon,  9 Mar 2020 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-211.rdu2.redhat.com [10.10.123.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1CAF73875;
        Mon,  9 Mar 2020 14:27:03 +0000 (UTC)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e6=2e0-?=
 =?UTF-8?Q?rc4-61a0925=2ecki_=28mainline=2ekernel=2eorg=29?=
To:     linux-block@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        LTP Mailing List <ltp@lists.linux.it>,
        Xiong Zhou <xzhou@redhat.com>
References: <cki.FEFA879F6B.TFTZ93YIF0@redhat.com>
From:   Rachel Sibley <rasibley@redhat.com>
Message-ID: <ba09351f-0a5a-824a-dbf2-021360581cd7@redhat.com>
Date:   Mon, 9 Mar 2020 10:27:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cki.FEFA879F6B.TFTZ93YIF0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(cc'ing linux-block@vger.kernel.org)

Hello,

We are seeing a kernel panic triggered with LTP and xfstests against a re=
cent commit for mainline,
wanted to share in case it's not already known.

Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git
  Commit: 61a09258f2e5 - Merge tag 'for-linus' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/rdma/rdma

We have also seen it with 2c523b344dfa and 378fee2e6b12 commits as well.

LTP: https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/=
03/08/477469/x86_64_1_console.log
xfstests: https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/=
2020/03/08/477469/x86_64_4_console.log

[-- MARK -- Sun Mar  8 02:45:00 2020]
[  762.315610] BUG: kernel NULL pointer dereference, address: 00000000000=
00158
[  762.323385] #PF: supervisor read access in kernel mode
[  762.329119] #PF: error_code(0x0000) - not-present page
[  762.334853] PGD 0 P4D 0
[  762.337680] Oops: 0000 [#1] SMP PTI
[  762.341575] CPU: 9 PID: 87 Comm: kworker/9:1 Not tainted 5.6.0-rc4-61a=
0925.cki #1
[  762.349927] Hardware name: Cisco Systems, Inc. UCS-E160DP-M1/K9/UCS-E1=
60DP-M1/K9, BIOS UCSED.1.5.0.2.051520131757 05/15/2013
[  762.362453] Workqueue: cgroup_destroy css_killed_work_fn
[  762.368387] RIP: 0010:bfq_bfqq_expire+0x1c/0x940
[  762.373540] Code: 01 00 00 c7 80 f8 00 00 00 01 00 00 00 c3 66 66 66 6=
6 90 41 57 41 56 41 55 41 54 41 89 cc 55 48 89 fd 53 48 89 f3 48 83 ec 28=
=20
<8b> be 58 01 00 00 65 48 8b 04 25 28 00 00 00 48 89 44 24 20 31 c0
[  762.394500] RSP: 0018:ffff9927c03bbd50 EFLAGS: 00010086
[  762.400331] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000=
0000004
[  762.408301] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8965a=
3913800
[  762.416270] RBP: ffff8965a3913800 R08: ffff896592d41098 R09: ffff89657=
aa8df00
[  762.424233] R10: 0000000000000000 R11: ffff89657aa8df00 R12: 000000000=
0000004
[  762.432200] R13: ffff89659f0cd9b0 R14: ffff8965a3913bf0 R15: ffff89659=
f0cd898
[  762.440175] FS:  0000000000000000(0000) GS:ffff8965a7c40000(0000) knlG=
S:0000000000000000
[  762.449211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  762.455622] CR2: 0000000000000158 CR3: 000000065afc6003 CR4: 000000000=
00606e0
[  762.463599] Call Trace:
[  762.466341]  ? bfq_idle_extract+0x40/0xb0
[  762.470821]  bfq_bfqq_move+0x14f/0x160
[  762.475011]  bfq_pd_offline+0xd3/0xf0
[  762.479112]  blkg_destroy+0x52/0xf0
[  762.483005]  blkcg_destroy_blkgs+0x4f/0xa0
[  762.487582]  css_killed_work_fn+0x4d/0xd0
[  762.492066]  process_one_work+0x1b5/0x360
[  762.496547]  worker_thread+0x50/0x3c0
[  762.500641]  kthread+0xf9/0x130
[  762.504153]  ? process_one_work+0x360/0x360
[  762.508813]  ? kthread_park+0x90/0x90
[  762.512909]  ret_from_fork+0x35/0x40

Thanks,
Rachel

On 3/7/20 9:59 PM, CKI Project wrote:
>=20
> Hello,
>=20
> We ran automated tests on a recent commit from this kernel tree:
>=20
>         Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/to=
rvalds/linux.git
>              Commit: 61a09258f2e5 - Merge tag 'for-linus' of git://git.=
kernel.org/pub/scm/linux/kernel/git/rdma/rdma
>=20
> The results of these automated tests are provided below.
>=20
>      Overall result: FAILED (see details below)
>               Merge: OK
>             Compile: OK
>               Tests: FAILED
>=20
> All kernel binaries, config files, and logs are available for download =
here:
>=20
>    https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=3D=
datawarehouse/2020/03/08/477469
>=20
> One or more kernel tests failed:
>=20
>      x86_64:
>       =E2=9D=8C LTP
>       =E2=9D=8C xfstests - ext4
>=20
> We hope that these logs can help you find the problem quickly. For the =
full
> detail on our testing procedures, please scroll to the bottom of this m=
essage.
>=20
> Please reply to this email if you have any questions about the tests th=
at we
> ran or if you have any suggestions on how to make future tests more eff=
ective.
>=20
>          ,-.   ,-.
>         ( C ) ( K )  Continuous
>          `-',-.`-'   Kernel
>            ( I )     Integration
>             `-'
> _______________________________________________________________________=
_______
>=20
> Compile testing
> ---------------
>=20
> We compiled the kernel for 1 architecture:
>=20
>      x86_64:
>        make options: -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
>=20
>=20
> Hardware testing
> ----------------
> We booted each kernel and ran the following tests:
>=20
>    x86_64:
>      Host 1:
>         =E2=9C=85 Boot test
>         =E2=9C=85 Podman system integration test - as root
>         =E2=9C=85 Podman system integration test - as user
>         =E2=9D=8C LTP
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility=
)
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking bridge: sanity
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking MACsec: sanity
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking socket: fuzz
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking sctp-auth: sockopts test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking: igmp conformance test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route: pmtu
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - local
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - forward
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking TCP: keepalive test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking UDP: socket
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: geneve basic tes=
t
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: gre basic
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 L2TP basic test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: vxlan basic
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - tra=
nsport
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - tun=
nel
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 audit: audit testsuite test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 httpd: mod_ssl smoke sanity
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 tuned: tune-processes-through-perf
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 pciutils: sanity smoke test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA PCM loopback test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA Control (mixer) Userspace Elem=
ent test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: SCSI VPD
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 trace: ftrace/tracer
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 CIFS Connectathon
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest suite=
s
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 jvm - DaCapo Benchmark=
 Suite
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 jvm - jcstress tests
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: kaslr
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 LTP: openposix test su=
ite
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking vnic: ipvla=
n/basic
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 iotop: sanity
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Usex - version 1.9-29
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: dm/common
>=20
>      Host 2:
>         =E2=9C=85 Boot test
>         =E2=9C=85 Storage SAN device stress - mpt3sas driver
>=20
>      Host 3:
>         =E2=9C=85 Boot test
>         =E2=9C=85 Storage SAN device stress - megaraid_sas
>=20
>      Host 4:
>         =E2=9C=85 Boot test
>         =E2=9D=8C xfstests - ext4
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 selinux-policy: serge-testsuite
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 lvm thinp sanity
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: software RAID testing
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 IOMMU boot test
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 IPMI driver test
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 IPMItool loop stress t=
est
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 power-management: cpup=
ower/sanity test
>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>=20
>    Test sources: https://github.com/CKI-project/tests-beaker
>      =F0=9F=92=9A Pull requests are welcome for new tests or improvemen=
ts to existing tests!
>=20
> Waived tests
> ------------
> If the test run included waived tests, they are marked with =F0=9F=9A=A7=
. Such tests are
> executed but their results are not taken into account. Tests are waived=
 when
> their results are not reliable enough, e.g. when they're just introduce=
d or are
> being fixed.
>=20
> Testing timeout
> ---------------
> We aim to provide a report within reasonable timeframe. Tests that have=
n't
> finished running yet are marked with =E2=8F=B1.
>=20
>=20

