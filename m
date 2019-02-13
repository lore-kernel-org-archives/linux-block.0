Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898EDC282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B0D222C9
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 18:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="Gsep7byT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404801AbfBMSIF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:08:05 -0500
Received: from mail-eopbgr700125.outbound.protection.outlook.com ([40.107.70.125]:43424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729522AbfBMSID (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 13:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRx/N3E9S/sMPaPch1VyZvWc1aBTaQtpGx9DHMFA1Ek=;
 b=Gsep7byTO4xpx8UgUY5yTC6v8yLc25WED5kQu7iJtPzdT9qmHRfvRPQqcBtF+VbCzIcaqIG7vswvpUcYBc0/gQHbM7h7Fv391YOvNDs51dHOkvNJCEWmLcMo57uwwGZrHrKAGYMQtAXG+6Oy8yDVvoBRQsG/lYd6BtSitoJQ34I=
Received: from DM5PR0101CA0020.prod.exchangelabs.com (2603:10b6:4:28::33) by
 BN7PR01MB3844.prod.exchangelabs.com (2603:10b6:406:84::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 18:07:58 +0000
Received: from CO1NAM03FT007.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by DM5PR0101CA0020.outlook.office365.com
 (2603:10b6:4:28::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Wed, 13 Feb 2019 18:07:58 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT007.mail.protection.outlook.com (10.152.80.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Wed, 13 Feb 2019 18:07:57 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1DI7sOc005399
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Feb 2019 13:07:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D71947A5755; Wed, 13 Feb 2019 13:07:54 -0500 (EST)
Date:   Wed, 13 Feb 2019 13:07:54 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     <lsf-pc@lists.linux-foundation.org>
CC:     <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [LSF/MM TOPIC] improving storage testing
Message-ID: <20190213180754.GX23000@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(189003)(199004)(54906003)(47776003)(75432002)(478600001)(88552002)(246002)(33656002)(305945005)(46406003)(90966002)(2906002)(97756001)(8936002)(26826003)(316002)(786003)(58126008)(42186006)(8676002)(16586007)(336012)(50466002)(126002)(476003)(2616005)(486006)(26005)(2351001)(106466001)(186003)(356004)(1076003)(36756003)(14444005)(23726003)(106002)(6916009)(86362001)(103686004)(6266002)(4326008)(52956003)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR01MB3844;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT007;1:eWkPQCe7ztfpYQqV/OiDH4iC3DpUBtr5M1fzUU8z5Ed6jM2BIKI5abmf1UuLlwSuZHCvAXVSYM0FwGa/UXC8z2D0KiPcyIFdJOC/qUdeeFpsbVHENGk52qfVp3J21ilS3sQyEnni9uxDf4d3H8U1Pg==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0a9778b-ab83-4919-87ef-08d691de2ef0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN7PR01MB3844;
X-MS-TrafficTypeDiagnostic: BN7PR01MB3844:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN7PR01MB3844;20:lWayvbFO7AymTOZpszux2PwWrc19pA1ZeM6U+AhVhpjrUeKzjN7vM/NBQTP9tK9OsSqimrj9qKXMA1PV+10RhWLQc2t0wvCd8nATMrihVeKp08Xq6YqhHT3QnWxgFagThzrgHQoefsHWJ59vwP8C8f1QHJl429OniuDRfTwcs2JeJYFwAqCIvWbrvK9S2tsk+QOPNbbyVNr7CK9U3dFYZLOclSOcmxccWs4uI9jCUV6uGTqk8YuYqlpSvV+5UaD7fQX/hnhTgPJq3AT8OyfJlOdCvm7ARo4xUvFbeHGGsBRXs8+0y3yi0i607JpUGKLcC+qIY1qkVzWJgg11M9vLXwS5VWVvijkXMoWyem/HOIO0y0ASJfvw+bheBCM0v1J60f7NxY5k7dbKY0x6l34r5/wADJl0roN51jVbuFUXolN/2CbUiKOjK+IRqP0YG7ju+FPKIb+YM713AW2iNhWfqNTHPnd9Qf8ChRU3rrWz7PdLy8LpieMkkMBVZdiWHzbq+lJ/218MzSBHnR6QbJcB1n+sUc4g9uA7zNl35JyvvOoHjoR/yNH/k03j0BuundLlE+RQineVhBdVVlt3dgTO6GW7/7H3paNTnkLJMWkT14c=
X-Microsoft-Antispam-PRVS: <BN7PR01MB3844EE8AB252AAAA2D9DE0E1B5660@BN7PR01MB3844.prod.exchangelabs.com>
X-Forefront-PRVS: 094700CA91
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR01MB3844;23:P9ByBbfxCVEvPWpZpNVncmcFWR9JSvqkDK+aRnrBY?=
 =?us-ascii?Q?5E1hbjSjSa3lABCG8MV9wDVbXMI87C6rnAo2Pfq153XGYgqQ1+u0wZDQ5x2A?=
 =?us-ascii?Q?6Vpr/qhTGFp73V9T7PAmYmVuB4C8fLPwlUws2U9ZP5eJoQowHwScDfX73mIV?=
 =?us-ascii?Q?PNHFdJX8F57L0uqi9xiWdJ0Mur/yq8SFzrBVkWVsyG9LwpmKwvIKgZAcTuhr?=
 =?us-ascii?Q?ygJpYn6WQwjRZcHKH5a1+ufK6e8zudV4vNC4H1STnZPVeXjLn7pHPl5px8yt?=
 =?us-ascii?Q?Dd3jvVPzHXHzm8SFk/yHIL2raCZkiGLUM3yiOprd2BXaBnY0s8dSAZoB4035?=
 =?us-ascii?Q?nKVvI9G3pjrQEFbfkqlrzNh0PjFRA/nI7z3dtlB0nPj+31oT1OxB6wDp7dxc?=
 =?us-ascii?Q?SUPk7Htme+NBAueBBZCVISR6Now/bIO1fVPEPBUFgoNj4+VOGcTGUX+Wx5xe?=
 =?us-ascii?Q?A+L9V6pilZr+oan/1vTMcM0iR1HOIpO6w9CJlgOVcUBvBh0S67FjiifOTS2y?=
 =?us-ascii?Q?4Ne6NT2pwwf5OvLnnX0cozYNjoGhzUcfcaGGJSz3gESz9JOGdpDk7Ewfbc+8?=
 =?us-ascii?Q?/OmcQp2Hxmk+mSef62SUmasHEUUJHEkoVyAF+MYkIry0zPpx8i7HhoR5IrQ0?=
 =?us-ascii?Q?5Sl/KgTWPrFZEWNSkXJmQZFjhkAM+JoUIdbtiZ4MByGJvsR25GIo9q1j33HG?=
 =?us-ascii?Q?J4VvutOhMNCqryzQh2HT/RWgZRHT7Ux52d1gsPOqN4GRaOtxglfO/DaNxRIv?=
 =?us-ascii?Q?hloO2gnXBxo9wteqJLxDoWCa4H1yPXXfr7yVnXUOWv3ToP7OK6v0eX1Xb6xn?=
 =?us-ascii?Q?SLoSCNU/eLOBcvHMvih78m7xLdVlwMg1zdeMvoC4fCZSNqnEDa+fCm4zUq52?=
 =?us-ascii?Q?+dVShynwNuO/sV0s0gJrhP5qh6J/B5jU6uEmMxd/odfo5DdJmUzN1A8DWlf6?=
 =?us-ascii?Q?LdGdBi7Bk1clCE/VsmVHLrL3U2xD90U78UDRJG3J3kBpUwrYj2jM5Rbqnqqz?=
 =?us-ascii?Q?vGh28+ymg6LOEn7wjHWRWj65wHEQt05XfJhPPJT60uBezdUxs+/KiNdH8bBg?=
 =?us-ascii?Q?u5ZBKq+DkCcMqZAkcmVVuE1UChwEDygwbeV5iw2feEB1nrHrMDYb7QJTQpYQ?=
 =?us-ascii?Q?PYUpkHjdCBmT68T5174CP70j9qBsZNfyhSIiUXHuwCxGQT4+rEbGw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 9/7ROHhEn9pf6TMG8W6lu0UIAHBd484JfoBVDwA6xGViXrhLUcWf/szjGkTc27zp2zdpflKL+m7KCxELua/NeN0Lc7sm7mj7HtJ1t5MbK+xefys72a3PHD1qsUYDoO4vMO76CO2gtgd7LO9LIixaxhMrVm6wy7Ae7GaEIN67oHT42s9HR6tcduvVxS/p5idrZ21bRqo15v35mmA6IIKWRjxjnqKLLxohMq/OjVmQWAtLsCPjFiqTjvgt2dE6LKK7ANvxaf+MxgHXxiobdGKdIdmyLONmb+sfmjkHbccY2jBlegyYzQahEtCl74cL1H610xqxtQmGcKSwZfQqMM9E3l7+uarZN2c/BwmOL4Ba6fhy1dXtqaulQyhCKMcOoSsTxZ2WDGwxpl2Iv/5OhX5DZR5BgipX6Wua9qRpRRZ3xeU=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2019 18:07:57.2573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a9778b-ab83-4919-87ef-08d691de2ef0
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3844
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This should probably be folded into other testing proposals but I'd
like to discuss ways that we can improve storage and file systems
testing.  Specifically,

1) Adding some kind of "smoke test" group.  The "quick" group in
xfstests is no longer terribly quick.  Using gce-xfstests, the time to
run the quick group on f2fs, ext4, btrfs, and xfs is 17 minutes, 18
minutes, 25 minutes, and 31 minutes, respectively.  It probably won't
be too contentious to come up with some kind of criteria --- stress
tests plus maybe a few tests added to maximize code coverage, with the
goal of the smoke test to run in 5-10 minutes for all major file
systems.

Perhaps more controversial might be some way of ordering the tests so
that the ones which are most likely to fail if a bug has been
introduced are run first, so that we can have a "fail fast" sort of
system.

2) Documenting what are known failures should be for various tests on
different file systems and kernel versions.  I think we all have our
own way of excluding tests which are known to fail.  One extreme case
is where the test case was added to xfstests (generic/484), but the
patch to fix it got hung up because it was somewhat controversial, so
it was failing on all file systems.

Other cases might be when fixing a particular test failure is too
complex to backport to stable (maybe because it would drag in all
sorts of other changes in other subsystems), so that test is Just
Going To Fail for a particular stable kernel series.

It probably doesn't make sense to do this in xfstests, which is why we
all have our own individual test runners that are layered on top of
xfstests.  But if we want to automate running xfstests for stable
kernel series, some way of annotating fixes for different kernel
versions would be useful, perhaps some kind of centralized clearing
house of this information would be useful.

3) Making blktests more stable/useful.  For someone who is not a block
layer specialist, it can be hard to determine whether the problem is a
kernel bug, a kernel misconfiguration, some userspace component (such
as nvme-cli) being out of date, or just a test bug.  (For example, all
srp/* tests are currently failing in blktests upstream; I had to pull
some not-yet-merged commits from Bart's tree in order to fix bugs that
caused all of srp to fail.)

Some of the things that we could do include documenting what kernel
CONFIG options are needed to successfully run blktests, perhaps using
a defconfig list.

Also, there are expectations about minimum versions of bash that can
be supported; but there aren't necessarily for other components such
as nvme-cli, and I suspect that it is due to the use of a overly new
version of nvme-cli from its git tree.  Is that supposed to work, or
should I constrain myself to whatever version is being shipped in
Fedora or some other reference distribution?  More generally, what is
the overall expectations that should be expected?  xfstests has some
extremely expansive set of sed scripts to normalize shell script
output to make xfstests extremely portable; will patches along similar
lines something that we should be doing for blktests?

Cheers,

					- Ted
