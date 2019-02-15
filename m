Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8156C10F04
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 03:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D75C21B68
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 03:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="hmt8KZkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfBODCP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:02:15 -0500
Received: from mail-eopbgr750092.outbound.protection.outlook.com ([40.107.75.92]:9003
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfBODCP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 22:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9hGmWTeBxOd1583485JaJuwdJjt/uxADPVdoli419E=;
 b=hmt8KZkWxTA0DKfdNBLq3imnnY+gyH+gd8DPvHREGLy68QtK+x4krRjU75gTmvC03Sc8kkfrsPMcEfVDXVamqEDTjBAzWwSqQA14bpKTh9etDks6RsSXtrSSZusR9tN1GojDHdjzGOkAq1fYs65/C1U67Y1zuyRHLorvNK/hSik=
Received: from BYAPR01CA0022.prod.exchangelabs.com (2603:10b6:a02:80::35) by
 DM6PR01MB5610.prod.exchangelabs.com (2603:10b6:5:157::26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Fri, 15 Feb 2019 03:02:09 +0000
Received: from DM3NAM03FT023.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::207) by BYAPR01CA0022.outlook.office365.com
 (2603:10b6:a02:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Fri, 15 Feb 2019 03:02:08 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 DM3NAM03FT023.mail.protection.outlook.com (10.152.82.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 15 Feb 2019 03:02:08 +0000
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1F322dc014661
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 22:02:03 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3B46D7A5756; Thu, 14 Feb 2019 22:02:02 -0500 (EST)
Date:   Thu, 14 Feb 2019 22:02:02 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Omar Sandoval <osandov@osandov.com>
CC:     <lsf-pc@lists.linux-foundation.org>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM TOPIC] improving storage testing
Message-ID: <20190215030202.GA723@mit.edu>
References: <20190213180754.GX23000@mit.edu>
 <20190214215634.GD9819@vader>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20190214215634.GD9819@vader>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(199004)(189003)(14444005)(229853002)(5024004)(6266002)(1076003)(6246003)(8676002)(246002)(71190400001)(478600001)(966005)(106466001)(26826003)(356004)(52956003)(6916009)(486006)(476003)(88552002)(235185007)(86362001)(11346002)(2906002)(126002)(446003)(2616005)(26005)(186003)(90966002)(336012)(33656002)(36906005)(316002)(36756003)(786003)(16586007)(6306002)(58126008)(63394003)(42186006)(75432002)(103686004)(84326002)(8936002)(305945005)(4326008)(568964002)(2476003)(54906003)(106002)(44144004)(76176011)(18370500001)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB5610;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT023;1:derGz/T/didA77XMqSzoZJGrxW179utbagZPxZ3XSjbHwz5lvlCdAMukSSnwjJSx59HVMbM68y1MOsh1Y4+ysHaAjZV+2yR9/FpIhUjy2eFNIIJwzsj0WGxMVqbFUuWWJhmD9YQbYdKvwjBs5h3qmA==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f717cff5-24de-400a-9ff9-08d692f1f945
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(49563074);SRVR:DM6PR01MB5610;
X-MS-TrafficTypeDiagnostic: DM6PR01MB5610:
X-MS-Exchange-PUrlCount: 2
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB5610;20:uplPSy88LZipbmazmdBJX5IsYyGColFZhsO8gjs25WIHs7CZmX1+hRADkNVfxs0dkfhF+mllhnbZdH3Zq31GZkYvxH77dbv2nPj3nvbkzcN26WRIbHYboiPdQrRJD5GoiJRWQ5kpZBeVmmJZedmObwxXazzW2ZZo7vSXS9f26WXbPtZOWLF55M3YlrK1Cc0f2PjzIEb67fwb4a8NqbXHKJR7GrkZQNOiz6tnRpy9kfzJSq+0c+w7Zh0zXlNcp+kAru9SEJGz6/yJ00nOsTRnY6tdptBa9K2qsJoTRfFr7FSfRxWXRZDaK/Ifcrr2EMgtnY5k2md6Jub51NnjAKz3pNrnS1X22daLZ4x96aXHUELsqWCskwN8zS8+RK2qERthqee5Akr/p2pQCcBB7EkG1KPIZ3ox4vMK0MhQ5QO0vN4vJXK+EMSiL9O5bZvT1ipv58ZeVqR8m9yu8vOthENFGZhlNghWICPlbHbWX4HWhpOCOR0Sh+01OMoAfUeCx8Pl2h+E+1rOVBdAl+Zo6rpKp52DrQEBwoB5KCz1roboZGg+QeQ+S39r2YSmLdygSBfvdJrU797li3bV5cYPyuumS6GV0czxs5Dn0k0daXozKZc=
X-Microsoft-Antispam-PRVS: <DM6PR01MB5610060D7EE417BF506CC86FB5600@DM6PR01MB5610.prod.exchangelabs.com>
X-Forefront-PRVS: 09497C15EB
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR01MB5610;23:fhKj45Ug6daGBWa/vm9HLwwPkMu/3WVP4suS3D9iD?=
 =?us-ascii?Q?9AAnH5hCyByf1bmkqg4gnDitz12KGxvsNALs/5Di4Wunp+UWalmioAMR7iKS?=
 =?us-ascii?Q?2BamjTTwcvHnLKW2yvJnApz5j47uy2XMU2r4lk5QlrRqt6Ob+eCZM5pBA92i?=
 =?us-ascii?Q?urcaMXffwiUljiEuahssxdUNGO7fe/xykbsDPLUoFn/FH3Nx2ZzQIcAYXEMy?=
 =?us-ascii?Q?RWso9TxS9wBo3wH6zZdeRHWwslrS2e7mu/bQH4UIs3CbUvkzE0n8j84v0ngE?=
 =?us-ascii?Q?s0Y4e7TKju4ISgRAhJXUPzoQnh3JDQlB7Sh+MFHQ7228EuY7EFua+d9wa4ck?=
 =?us-ascii?Q?36kRqFpSkcHh9SadjwKA1zs+2W5QL4gUUsqJEf+Ce4Q2q1OhLoAaTYDov52l?=
 =?us-ascii?Q?rlD7dsVC59wUkIiLPKW/vWdp0Y0n9hSyGjL4KSx64MhUSLxxKr3QUgCC0QeD?=
 =?us-ascii?Q?t+RGiRtvgvwcBDHWNMmhdqKiTn7c5bMxWuFnm9JaOF+QQ38BpfllwuKtlVLs?=
 =?us-ascii?Q?CKGW9UHRjFgYLrNpi4tgE51BFRJ+ZBxlmzafly9W5xbpLfgEg2Y6/hftQ/Yq?=
 =?us-ascii?Q?fEAg/sjsFyru6c3RiTR9VaDmbeYRr55qyyDApEY2SMqhClGP+BwLYiayyBFP?=
 =?us-ascii?Q?7qINLevoPB1jfoLc5DKCPyL/ceLExCjCZyxgY42VJshDGCORHcC5m17VahGP?=
 =?us-ascii?Q?ArSv0RSED47J+rnf33bbMWVD5kH1ysMUDByq/ONbhBM4Do/elIRKqgHgZD0I?=
 =?us-ascii?Q?2gwZyntTs6xivyXez071HfziPqV9qZlGnT3rGNC5Vqq02RMOFFxkO0Z5Gn8P?=
 =?us-ascii?Q?pD3C+bXP5qyqIAOJNM5hIWBguJ+FLYPgBfc721uzBTzqdhcvYQqs6WGN1tT8?=
 =?us-ascii?Q?5icPiGS6418r87YAI5WtD7+baXYVA4hpefltB7B4NQJZffntHTg+9oPN0PiF?=
 =?us-ascii?Q?024nWVw5LFSILisRYFmfv88UXrsWO4K2OmcfXzoY2qPAiKamSHjz25sEmOyc?=
 =?us-ascii?Q?IJ0gQfHZDoe1A9gIfm+abys1kab399VHJ17MG5LfIuOczXyde6Zmd+DEzFkT?=
 =?us-ascii?Q?faJSR6/y011YNWJ5xBhbNwwCIkxpyTdqpRjcDsTt9LNA/hGpv9kcqPgwRIWg?=
 =?us-ascii?Q?u+WwWM/B4HsJwl2UlfWfyGcrNGLEK+4iIcG6L8Hot2ypVmvRQWcsf02Q0in1?=
 =?us-ascii?Q?k2M7LjnW7PO+Q4ZAy51PWhH/dxnri6QNTKVZN5eoosofQNA7LCbgONMyzL5H?=
 =?us-ascii?Q?aMa7v/vV4LJ5cOhPbVTfB9yVs+qsQltSfPfxeTR8YlDhKEM4tkB8weXp4OYI?=
 =?us-ascii?Q?bw5bVeZ+pF2fjiCfgrs8/1duIMSxY5psb8FzWI9cDrvzZsXZGQQ03LV3Ei17?=
 =?us-ascii?Q?WZd0w=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Wj73J0y2sL3ErJlLY2BkJDGmAZThv1xk7Hl+IZpqQlRoXCZ8dYBJXjpiyPPi5FkFlcRCy+gAEmXoQ0R3Zob+usTQfeMjOQ3BLQI39TgpGBDXQmP57sDbhGapVnLqreWSkFMkHZQ0+oZIdyXXLVlCmDpfvnSKxArdXLhOAty80CmN0BubNfmDYcrNzsq0s3Yt+2sAfXrQZcSaQwhKcg98WwtmI53zk/Sd8Jew8EB/dOh+L6lBNRpHFkmnUIhpYPzDNlLbBSmaK2IuqhhFRDIkSscKuLPwHJU6NiPPdC0AfZhHemt3n/2h338415Fupvh1feJ/HfLy9Iecq0nPDnTL5NNw2CPGbvIhrQji88eDmH50skSwo/h+ePGQcrU7TQpKBKK2Tq9Tm4AQNqswm9VkDz1j/boLmyx4SxP0ztVzBW8=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2019 03:02:08.2634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f717cff5-24de-400a-9ff9-08d692f1f945
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5610
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 14, 2019 at 01:56:34PM -0800, Omar Sandoval wrote:
> > 3) Making blktests more stable/useful.  For someone who is not a block
> > layer specialist, it can be hard to determine whether the problem is a
> > kernel bug,
> 
> From my experience with running xfstests at Facebook, the same thing
> goes for xfstests :) The filesystem developers on the team are the only
> ones that can make sense of any test failures.

What I've done for xfstests is to make it so easy that even a
University Professor (or Graduate Student) can run it.  That's why I
created the {kvm,gce}-xfstests test appliance:

   https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

I've been trying to integrate blktests into the test appliance, to try
to make it really easy to run.

> Have you encountered issues where missing config options have caused
> test failures? Or you want the config options for maximum coverage? If
> you have examples of the former, I'll fix them up. For the latter, I
> have a list somewhere that I can add to the blktests repository.

There were a few cases a missing config caused test failures; most of
the time, it simply causes tests to get skipped.  But figuring out how
to enable the nvme or srp tests required turning on a *large* number
of modules.  Figuring that out was painful, and required multipel tries.

One of the things that I've done is create kernel defconfigs to make
it really easy for somone to build a kernel for testing purposes.  The
defconfigs for suitable for running xfstests under KVM or GCE can be
found here:

   https://github.com/tytso/xfstests-bld/blob/master/kernel-configs/x86_64-config-4.14

I've attached the defconfig I've been developing suitable for xfstests
and blktests below.  I try to create minimal defconfigs so I can more
quickly build kernels, especially if I am needing to do bisection
search.

> My (undocumented) rule of thumb has been that blktests shouldn't assume
> anything newer than whatever ships on Debian oldstable. I can document
> that requirement.

That's definitely not true for the nvme tests; the nvme-cli from
Debian stable is *not* sufficient.  This is why I've started building
nvme-cli as part of the test appliance in xfstests-bld.  I'm now
somewhat suspicious that there are problems because using the latest
HEAD of the nvme-cli git tree may have had messages printed to
standard out that is subtly different from the version of nvme-cli
that was used to develop some of the nvme tests.

> blktests is new, so we have some rough edges, but I'd like to think that
> we're trying to do the right things. Please report the cases where we're
> not and we'll get them fixed up.

I have been graduately reporting them to linux-block@.  Here are the
full set of test failures I've been working through.

My goal is that eventually, someone will be able to run "gce-xfstests
--blktests" in their kernel development tree, and in less than 45
minutes, they would get an e-mail that would look like the following,
except there wouldn't be any failures reported.  :-)

						- Ted

CMDLINE: --blktests
FSTESTIMG: gce-xfstests/xfstests-201902111955
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests	5f1e24c (Mon, 11 Feb 2019 10:08:14 -0800)
FSTESTVER: fio		fio-3.2 (Fri, 3 Nov 2017 15:23:49 -0600)
FSTESTVER: fsverity	bdebc45 (Wed, 5 Sep 2018 21:32:22 -0700)
FSTESTVER: ima-evm-utils	0267fa1 (Mon, 3 Dec 2018 06:11:35 -0500)
FSTESTVER: nvme-cli	v1.7-22-gf716974 (Wed, 6 Feb 2019 16:03:58 -0700)
FSTESTVER: quota		59b280e (Mon, 5 Feb 2018 16:48:22 +0100)
FSTESTVER: stress-ng	7d0353cf (Sun, 20 Jan 2019 03:30:03 +0000)
FSTESTVER: syzkaller	2103a236 (Fri, 18 Jan 2019 13:20:33 +0100)
FSTESTVER: xfsprogs	v4.19.0 (Fri, 9 Nov 2018 14:31:04 -0600)
FSTESTVER: xfstests-bld	11be69c (Mon, 11 Feb 2019 18:57:39 -0500)
FSTESTVER: xfstests	linux-v3.8-2293-g6f7f9398 (Mon, 11 Feb 2019 19:42:24 -0500)
FSTESTSET: ""
FSTESTEXC: ""
FSTESTOPT: "blktests aex"
CPUS: "2"
MEM: "7680"
BEGIN BLKTESTS Tue Feb 12 00:41:13 EST 2019
block/024 (do I/O faster than a jiffy and check iostats times) [failed]
loop/002 (try various loop device block sizes)               [failed]
nvme/002 (create many subsystems and test discovery)         [failed]
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [failed]
    [ 1857.726308] WARNING: possible recursive locking detected
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [failed]
nvme/015 (unit test for NVMe flush for file backed ns)       [failed]
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [failed]
nvme/017 (create/delete many file-ns and test discovery)     [failed]
srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
srp/011 (Block I/O on top of multipath concurrently with logout and login) [failed]
Run: block/001 block/002 block/003 block/004 block/005 block/006 block/009 block/010 block/012 block/013 block/014 block/015 block/016 block/017 block/018 block/020 block/021 block/023 block/024 block/025 block/028 loop/001 loop/002 loop/003 loop/004 loop/005 loop/006 loop/007 nvme/002 nvme/003 nvme/004 nvme/005 nvme/006 nvme/007 nvme/008 nvme/009 nvme/010 nvme/011 nvme/012 nvme/013 nvme/014 nvme/015 nvme/016 nvme/017 nvme/019 nvme/020 nvme/021 nvme/022 nvme/023 nvme/024 nvme/025 nvme/026 nvme/027 nvme/028 scsi/001 scsi/002 scsi/003 scsi/004 scsi/005 scsi/006 srp/001 srp/002 srp/005 srp/006 srp/007 srp/008 srp/009 srp/010 srp/011 srp/012 srp/013
Failures: block/024 loop/002 nvme/002 nvme/012 nvme/013 nvme/015 nvme/016 nvme/017 srp/002 srp/011
Failed 10 of 71 tests
END BLKTESTS Tue Feb 12 01:18:37 EST 2019
Feb 12 01:11:34 xfstests-tytso-20190212003935 kernel: [ 1857.726308] WARNING: possible recursive locking detected


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=defconfig

CONFIG_LOCALVERSION="-xfstests"
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CGROUPS=y
CONFIG_USER_NS=y
CONFIG_BLK_DEV_INITRD=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
CONFIG_SMP=y
CONFIG_X86_X2APIC=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_MCORE2=y
CONFIG_NR_CPUS=48
# CONFIG_X86_MCE_AMD is not set
# CONFIG_MICROCODE is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_PMEM_LEGACY=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_HZ_300=y
CONFIG_KEXEC=y
# CONFIG_SUSPEND is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_PCI_MMCONFIG is not set
CONFIG_IA32_EMULATION=y
# CONFIG_DMIID is not set
CONFIG_JUMP_LABEL=y
CONFIG_REFCOUNT_FULL=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=m
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_ZONE_DEVICE=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_UDP_DIAG=y
# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
# CONFIG_INET6_XFRM_MODE_BEET is not set
CONFIG_NETLINK_DIAG=y
# CONFIG_WIRELESS is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_PCI=y
CONFIG_PCI_MSI=y
CONFIG_DEVTMPFS=y
CONFIG_MTD=y
CONFIG_MTD_BLOCK2MTD=y
CONFIG_MTD_UBI=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_RDMA=m
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_RDMA=m
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_BLK_DEV_DM=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_THIN_PROVISIONING=y
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=y
CONFIG_DM_LOG_WRITES=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_NETDEVICES=y
CONFIG_VIRTIO_NET=y
# CONFIG_ETHERNET is not set
# CONFIG_WLAN is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_SERIO_SERPORT is not set
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=32
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_HWMON is not set
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_HID is not set
# CONFIG_USB_SUPPORT is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_CM=y
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
CONFIG_INFINIBAND_ISER=m
CONFIG_RDMA_RXE=m
CONFIG_RTC_CLASS=y
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_IOMMU_SUPPORT is not set
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2_DEBUG=y
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FS_ENCRYPTION=y
CONFIG_FS_DAX=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QFMT_V2=y
CONFIG_AUTOFS4_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_CHILDREN=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_CONFIGFS_FS=y
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ENCRYPTION=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFSD=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_9P_FS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_ASCII=y
CONFIG_NLS_UTF8=y
CONFIG_SECURITY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_IMA=y
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_EVM=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS="certs/cert.pem"
CONFIG_PRINTK_TIME=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=3000
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_TIMEOUT=5
CONFIG_PROVE_LOCKING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_SG=y
CONFIG_RCU_EQS_DEBUG=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_DEBUG_WX=y

--5vNYLRcllDrimb99--
