Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB454C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 07:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5222229F
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 07:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YwJ/61+U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L1m/4s20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfBNHhx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:37:53 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48440 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfBNHhx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 02:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550129872; x=1581665872;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=apAij26hlenIPsdVi1R1+zJ6Qousy+MtkNysO3A2siA=;
  b=YwJ/61+UR0/DQ8J7LWHtnV1cGVCHW+CI4pY9xXcybmleKQBYvgmL830x
   sLTGc5L9m4vnuv/zUWyKAYxHk9bAGXg5prI1rnzo9B90ROzNRVmpFf8LK
   rjL3O3WzR1DNuRldZVmNgmXQ6ComckI/UuN8ud5dPk889beZJhloDbfr+
   ApTrCjNu9uSIv4WT+ZBR8kt8IOWZakq+vVOyXMDdNXFpEMRlGwMFluJxA
   zfcpdGd7RXJNpDpO7uZgggalKFq+4TZmb1vhYFVRPgS549sHD0QrF00Zb
   GtLgqg+A/gMDkKrtKMQ+qdbdlz0wBWw1f4a5OTvHekVNmHUlhVXZ6wvuV
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,367,1544457600"; 
   d="scan'208";a="102526834"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2019 15:37:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op0SrAF+Ig8MKYu7QzfWXc6ZZL50hV0QaLcjqnXJqKw=;
 b=L1m/4s20QoR01kedXB4kDoQvxw+CY4oRmaI5dFUoNRBZoZDmJqKzZQJj3edGcf+EDgTsTmySwz3bmuzri9EfBrccmxe8a0SCdopX5/qIDXBNOdjZgDrWO9hb8JsOw2uRS+/+lIBqpenEl9zDGtIoj8xmlnxugm6PW/R77AhFfSI=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4005.namprd04.prod.outlook.com (52.135.215.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 07:37:50 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::f827:c296:5af6:c2f7]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::f827:c296:5af6:c2f7%5]) with mapi id 15.20.1622.018; Thu, 14 Feb 2019
 07:37:50 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM TOPIC] improving storage testing
Thread-Topic: [LSF/MM TOPIC] improving storage testing
Thread-Index: AQHUw8cWY/Lzvrp1zEiECHyARXLTBg==
Date:   Thu, 14 Feb 2019 07:37:50 +0000
Message-ID: <BYAPR04MB450201D85D62C810A4B83F4686670@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190213180754.GX23000@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9085357-c069-42b8-710a-08d6924f52cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4005;
x-ms-traffictypediagnostic: BYAPR04MB4005:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR04MB4005;23:+pB4rJEhn4yhFPZyZtTRBJNvxL0MspfZYm4cRR8eD?=
 =?us-ascii?Q?xq1sCtS5kxTpZPmfTCXJmlvXLRizZlL5kL5g3NglwAEVm2WignKm/EyZV28N?=
 =?us-ascii?Q?lBn+ZBE8MbldJvLELeDKDq6k20j8iIPizsv8Jh4e2tefnnEHsCoW3gOIV1Ms?=
 =?us-ascii?Q?5lhh3CxALauLWbVq4S5fsvJPhLKKCS8QFHOB7K20VrA5YkqEcSspbgG2pieS?=
 =?us-ascii?Q?4lzXKBT1BgEuPxQWwTITJUwZhalXON8VaXpT5W6y6Zojn4oKIy1aJDIK6z6V?=
 =?us-ascii?Q?GsGcoM1lbWt+6lC8NMwJAtTZqd6uYKzcdValeVU3ODgIR50L0W1C8xdFUXrO?=
 =?us-ascii?Q?/HIWOAOu90e4UzZhV0MmsUkTMZeJj71vY6L2I3t/PYzKNBQOHt6yDi5+MX5f?=
 =?us-ascii?Q?WMavDHWRtdg4ZK34++QA0yzxf2YCCpl9wzAEwV2lr7wK7sBwcce73STvBrn3?=
 =?us-ascii?Q?MvRkhLmamcNWTmUEoDwG9WYGs5Alkh0LJni5Q+k2LnKERPS4sNFThGa3IwR9?=
 =?us-ascii?Q?jYArtb04DSlRtWRoGvu1+IA2E/JR9iNcofh03XmcDxNwvf5SbY3gfuTM9jww?=
 =?us-ascii?Q?v4d/KO93JwEgHG6bnSs8ivlkgARBqrBEpmyv6+Yt4d+c62AMLPwLIZmf27uA?=
 =?us-ascii?Q?ll3o7tYTxOyq3zA7ziE/rFps+LXxVsKZ9c5+HAMNBIyjJRCu9vaq9JhxeEMk?=
 =?us-ascii?Q?HkhsMAS6moAPXMLyPHRDp+6rgUeuikIbCoviAMvhZrWVUm9Eso7GQqnPvZaF?=
 =?us-ascii?Q?BXT9mC4Qph9+KBeQHYFKv+EipqNBF3fb3yP8Wib/RyC5+hjmP1PEWR266D6E?=
 =?us-ascii?Q?eqOQargnRfiBB/2b86ep48rzoHtk9/kXXPGY8fH3VYbBQg/12srWzfEhLkXw?=
 =?us-ascii?Q?/2lFCkkRuqlgpbgI+FT4SFgM+Bsf27bUm6t40BEL5fKE27FcP5V/fPrrB+Sk?=
 =?us-ascii?Q?wUnJ5Bga3Z0G3HorfwH6MjezeaTuwEnHeG8SHyzYS7C+KDPaHqgJTUSb0W5M?=
 =?us-ascii?Q?mqll8Rk7RgVTs3caLRqggseYajQQLxZ8g+PcZHt4XA7vquCBQSSKxalTL5/T?=
 =?us-ascii?Q?J4fnzaHhDncZnQi4CwU5Khi3XKJB2Ga4i4pRz/BU76YBFrP8vBjMYD9rwBPy?=
 =?us-ascii?Q?BsXL197olBdhYGu5u+j1q4hvBoPWmkLbWXO8nZoY1Fx1YFXl2uZ2k7aMmKGS?=
 =?us-ascii?Q?5mZs3iwDN7KD1yLVJ8GmVdTqcGoGH8/KJrpt2vrpIjRn62PK9JblcjnDCgtA?=
 =?us-ascii?Q?nHK6vFkw24JnDAYTgGpUMux4OgThq0CaDpJeeTNx4a+KE3A2XWUVdL05IicC?=
 =?us-ascii?B?Zz09?=
x-microsoft-antispam-prvs: <BYAPR04MB4005AE2CAB0CF0B7D60D9C6986670@BYAPR04MB4005.namprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(14444005)(14454004)(74316002)(6246003)(97736004)(86362001)(2171002)(2906002)(33656002)(26005)(105586002)(2501003)(6116002)(8936002)(6506007)(3846002)(256004)(81156014)(186003)(81166006)(71190400001)(71200400001)(6346003)(7736002)(8676002)(4326008)(68736007)(106356001)(305945005)(53546011)(53936002)(99286004)(966005)(76176011)(55016002)(446003)(54906003)(110136005)(316002)(229853002)(72206003)(66066001)(6436002)(7696005)(476003)(6306002)(25786009)(486006)(102836004)(9686003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4005;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qSRgyz6vFfhF4JVOEqf8vZmzPT9IPMLO+URiuuheA4aytM80km/BeBiKCBZy3zhGuR0iU1TdRwzBAHe4tCp7MCQK71xWEEk6xZEmBKkb/OsTq7W6QZwHx9/N8fj01Ocwc+/bfQs2O3GD1zruN895OgYxl8+haKd2VduGRTbXKa2BDmzny18bVOsehGqTevlQA789eVCwA18aDGA8o+iqxRIym+Y+isYoe6+f/RyTrgOvbUF5hUDFs2iV200MFYLWgaTy3Jd66TWo+ismSnC56A06lGFdm0FOqgJYXBpZBjew8POzRIwMf9Q4/V68lBoG5HM10N3x4sXMGcCFiiL1JaQUFRgJexfGOejidDwgqefUMlbOH9z8FIn+7i2gBw3z1qp77J3/iGyzp4X94GkNdv0rqXXAx6BTUA7CEgMthvk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9085357-c069-42b8-710a-08d6924f52cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 07:37:50.7500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4005
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for suggesting this topic, we can definitely fold this into=0A=
the one which is posted earlier.=0A=
=0A=
On 2/13/19 10:08 AM, Theodore Y. Ts'o wrote:=0A=
> This should probably be folded into other testing proposals but I'd=0A=
> like to discuss ways that we can improve storage and file systems=0A=
> testing.  Specifically,=0A=
> =0A=
> 1) Adding some kind of "smoke test" group.  The "quick" group in=0A=
> xfstests is no longer terribly quick.  Using gce-xfstests, the time to=0A=
> run the quick group on f2fs, ext4, btrfs, and xfs is 17 minutes, 18=0A=
> minutes, 25 minutes, and 31 minutes, respectively.  It probably won't=0A=
> be too contentious to come up with some kind of criteria --- stress=0A=
> tests plus maybe a few tests added to maximize code coverage, with the=0A=
> goal of the smoke test to run in 5-10 minutes for all major file=0A=
> systems.=0A=
> =0A=
> Perhaps more controversial might be some way of ordering the tests so=0A=
> that the ones which are most likely to fail if a bug has been=0A=
> introduced are run first, so that we can have a "fail fast" sort of=0A=
> system.=0A=
> =0A=
> 2) Documenting what are known failures should be for various tests on=0A=
> different file systems and kernel versions.  I think we all have our=0A=
> own way of excluding tests which are known to fail.  One extreme case=0A=
> is where the test case was added to xfstests (generic/484), but the=0A=
> patch to fix it got hung up because it was somewhat controversial, so=0A=
> it was failing on all file systems.=0A=
> =0A=
> Other cases might be when fixing a particular test failure is too=0A=
> complex to backport to stable (maybe because it would drag in all=0A=
> sorts of other changes in other subsystems), so that test is Just=0A=
> Going To Fail for a particular stable kernel series.=0A=
> =0A=
> It probably doesn't make sense to do this in xfstests, which is why we=0A=
> all have our own individual test runners that are layered on top of=0A=
> xfstests.  But if we want to automate running xfstests for stable=0A=
> kernel series, some way of annotating fixes for different kernel=0A=
> versions would be useful, perhaps some kind of centralized clearing=0A=
> house of this information would be useful.=0A=
> =0A=
> 3) Making blktests more stable/useful.  For someone who is not a block=0A=
> layer specialist, it can be hard to determine whether the problem is a=0A=
> kernel bug, a kernel misconfiguration, some userspace component (such=0A=
> as nvme-cli) being out of date, or just a test bug.  (For example, all=0A=
> srp/* tests are currently failing in blktests upstream; I had to pull=0A=
> some not-yet-merged commits from Bart's tree in order to fix bugs that=0A=
> caused all of srp to fail.)=0A=
=0A=
This is exactly what I want to discuss in the topic I suggested.=0A=
> =0A=
> Some of the things that we could do include documenting what kernel=0A=
> CONFIG options are needed to successfully run blktests, perhaps using=0A=
> a defconfig list.=0A=
=0A=
Good idea, we should have this per test/category.=0A=
> =0A=
> Also, there are expectations about minimum versions of bash that can=0A=
> be supported; but there aren't necessarily for other components such=0A=
> as nvme-cli, and I suspect that it is due to the use of a overly new=0A=
> version of nvme-cli from its git tree.  Is that supposed to work, or=0A=
> should I constrain myself to whatever version is being shipped in=0A=
> Fedora or some other reference distribution? =0A=
Most of the test assumes that you have nvme-cli from Keith's repo:-=0A=
https://github.com/linux-nvme/nvme-cli.git and latest code should=0A=
always work, if it breaks then we need to either fix the cli or test.=0A=
In this way we are also making sure tools are also working along with =0A=
the kernel code. May be I should document that.=0A=
=0A=
  More generally, what is=0A=
> the overall expectations that should be expected?  xfstests has some=0A=
> extremely expansive set of sed scripts to normalize shell script=0A=
> output to make xfstests extremely portable; will patches along similar=0A=
> lines something that we should be doing for blktests?=0A=
> =0A=
I think this is a good topic for general discussion.=0A=
> Cheers,=0A=
> =0A=
> 					- Ted=0A=
> =0A=
=0A=
