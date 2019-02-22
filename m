Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC22C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 00:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252B920836
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 00:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PboUN2sC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UcZ+2ad+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfBVAAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:00:46 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22831 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfBVAAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 19:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550793646; x=1582329646;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8MBL1DsUWSxQ4YJg9YDJoMzGwuLmzDffYAgGlukod1I=;
  b=PboUN2sCcF9amV9XC/wL/Tw5JA2MGwYIK7LNSQWMBgH314jyWqRJ+JPC
   10gP3KKj+IH211zUB0xspV5IWzF2WEI6EiJ2Z3yrwqbKxyZYVqCegTG1j
   FcuoUk5C/uvB457NjXhwD7FlR4gfDYI/DwwY3OREiNpw1afSUjXtJNjQ0
   yDzEKsRGHKyV7WmNv1DHT3nGO6o8/7SREoX0q9HaXgPrPtIN/pUvwG6Kw
   tw3ryggrQpUAkLwyD09tofNIp0ABQ7XhXSE966gVDg0171lsxRmeX+KUh
   OAahhi9MD+ZcBrfnDkg7V9x1xoKy3gDXEajOtEe3A007aHFXUJJr0AHAe
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,397,1544457600"; 
   d="scan'208";a="101889079"
Received: from mail-dm3nam03lp2056.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.56])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2019 08:00:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiCu0Sbf0Gc7U8tuNxfr5L0ynARzNUJ3mgcHXzbm7kg=;
 b=UcZ+2ad+2gTfin8ma0XZxZcLCE1hUY2v197t8oogbZFC55rbtnYY6qmc0Ch6jyOhnJwkA7AKrUvSMitRWv8wipDbar3pEbfSFy9Y7wNZSK/59QHiAzJx0KywpjYRPqQLuiN9rDQFCbToS8V7z+bJ7mV5iwcyla38Q1AGHcuW11M=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5424.namprd04.prod.outlook.com (20.177.254.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 22 Feb 2019 00:00:43 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a%4]) with mapi id 15.20.1643.014; Fri, 22 Feb 2019
 00:00:43 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH BLKTESTS V2 1/3] nvme/002: fix output format
Thread-Topic: [PATCH BLKTESTS V2 1/3] nvme/002: fix output format
Thread-Index: AQHUyJEY9x4bFajxGEW2DBTu4VxXVA==
Date:   Fri, 22 Feb 2019 00:00:43 +0000
Message-ID: <SN6PR04MB452790045C42F3DEAD63BE76867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1550607835-11755-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <1550607835-11755-2-git-send-email-chaitanya.kulkarni@wdc.com>
 <20190220180327.GA8325@vader>
 <SN6PR04MB4527D0FAE8B353AEA45E0CD8867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190220193500.GE8325@vader> <20190221150418.GB4062@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbd7f3cd-fd9d-46cf-1235-08d69858ca3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5424;
x-ms-traffictypediagnostic: SN6PR04MB5424:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB5424;23:9gHEFpR/6egjrJs3rAejGposnYGYK1oAF7m5hX1ms?=
 =?us-ascii?Q?GSpHwqhdBiDqxBgk0i2Lcy36PH+3TZ/xCu0EkNH9V225voi/6R7ixdQmdGzd?=
 =?us-ascii?Q?6LQXAolyC8Q458TGp6oZFvhBro5BXAzPljxI5jxw8sVvQ4tpO6ehh2aTi6ad?=
 =?us-ascii?Q?twv8h3bQ33baKubRFG21T0IVXP398Vx9G8+cYciXvGTHNy8L6Bcz+hybhc5E?=
 =?us-ascii?Q?nDAJoYRtTTbKvtR6t3nOCR8k6pLqkTAX/b8eN6K3b1yVqlvmvIWQXgLdhIT6?=
 =?us-ascii?Q?sBsMEuMB0UjC/ZcGC8aKe0vA8jVshQ9jCYNte2SBv3snq1i9ijzrohi9l23l?=
 =?us-ascii?Q?Ka/02cd1r2d86lOHLRHH8uLKiVtRAa0h3dtGzDLB9+0IjGHAFhys9jILSIPl?=
 =?us-ascii?Q?i6iPxalFZnfrNTrIKsWr641y8xjvIH4wBqaCiM5jw9MRDkY/W3y5oZYLzOnA?=
 =?us-ascii?Q?PZsLVXJ6PrV3d5yjjEYlRx2LVO0StDnebsDCYvYfZ0jmUjLHjjbyw/RRlv68?=
 =?us-ascii?Q?31n4Y+l+qaWYa2BDqlqi+rS4f66f9XVfPrWHvgZ02wV3SwDnsW4IMqb8ATio?=
 =?us-ascii?Q?/r4KllgSZ58AqkCDQxuX65Et9DLfpe0xCHv82EjWb6PUnVbWRbqNth9Gc3a6?=
 =?us-ascii?Q?GwLpwAprgT6LZMGOKeGdJEvfPwa/ANDhkOhh+RiC2acFiDH3O9HyFHsfquKu?=
 =?us-ascii?Q?c0qwUPsEZa4RqVCPBOAddrtjveYKYrny8sIamcXg9NoJjjqIr8xOmeqhV9b6?=
 =?us-ascii?Q?Rl9xJFIFECfn2sg+RMqOWV6ay6AmQK4EwTdIPd/peKJlFa6mibniP5nBAZmE?=
 =?us-ascii?Q?/qC6mjokI6wGDVxdC0US1z0+EYCJcfB3glS3raOTcUBPB1NfBzpcT379Ms3x?=
 =?us-ascii?Q?N42JTwwZRhBwJRAehY/vVbp8eYpDll81pMZkzytwjcvX2QrETyBgH7fOSugN?=
 =?us-ascii?Q?O1NiXulyf4gR8uUEGM+EbsnB+7ebMAh218OasVx2nExLkOfxnpWQfQp5dUsD?=
 =?us-ascii?Q?D5rizWp2zAQiEI81PWpCme0J1gL2W5cSpQNX46/oQu3FQkeHS8fjd6/hE9N2?=
 =?us-ascii?Q?n49mRGTWqetRt2xHHpy8MWBZuMCmuw7HUfbHgEg2xVe/XEnGPDWBH1ONMjBL?=
 =?us-ascii?Q?N5uABocN0dCK8b/UxhAzmjkvp7R8Lb5YBvRlsegukd3U1Uodkc3qzWhPiAQv?=
 =?us-ascii?Q?isMRm3O1c3eKBmNKJTOgryRazVGOkxPG6h5748zcPZVeroiTNXROQyQeg=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <SN6PR04MB542490D1F79F3668600E5A41867F0@SN6PR04MB5424.namprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(396003)(346002)(189003)(199004)(2171002)(71200400001)(71190400001)(86362001)(110136005)(6116002)(66066001)(256004)(74316002)(2906002)(478600001)(476003)(8676002)(316002)(6246003)(81156014)(81166006)(14454004)(8936002)(68736007)(3846002)(5660300002)(486006)(72206003)(186003)(9686003)(305945005)(53936002)(229853002)(102836004)(53546011)(4326008)(446003)(97736004)(25786009)(93886005)(105586002)(106356001)(33656002)(76176011)(7736002)(26005)(55016002)(6506007)(7696005)(6436002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5424;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +7D6Ym2+Qv2EFpYI9YsgsSv8noLOiZOXwXkvrWEzFLMaxlGYhFwfBh5yvqmXAwe/1hNg0DoSs+BGao97TSW1OBBkYD8BbB+fI+jwqmsjcv9rLHKL/o4OU6C4lTmWu12o1X0bNxxR2wMO0dCy8igAIvLA7CSGXuQfD0Ly0MppVwxzpCxFGEcw8KO7P0ZOY1W/87fOscTkP2csGWGVUAdvTAL5Y67+xTlsso8LVvjAe99qrhKFPgbnJiFY4C0GF28pj+Q/PyHrV4uPWoizxUawuRJG19a1GpfJv8aizpg6uuwaEVmD5Le0XR+XVbLT+B/9JUmOcY1FgcszK5NadAd6RJDBRQDu7d2V1x7LX4FkV4sMoyW2+U5JT8tgAAxaW5Ko2M35kaE8xVqocBoKmxnpPUFLeOqx3ZgRthinNw3suGQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd7f3cd-fd9d-46cf-1235-08d69858ca3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 00:00:43.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5424
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/21/2019 07:04 AM, Theodore Y. Ts'o wrote:=0A=
> On Wed, Feb 20, 2019 at 11:35:00AM -0800, Omar Sandoval wrote:=0A=
>>> It should fail on older cli versions, we want latest cli/tools to be=0A=
>>> used when running these testcases so that all the latest tools are=0A=
>>> also been tested for the compliance, else we might be running tests=0A=
>>> with any bugs with older version(s) which are fixed already.=0A=
>>>=0A=
>>> Actually I'd like to add quick nvme-cli version check at the start of=
=0A=
>>> each test that will certainly help/force user to have a latest version.=
=0A=
>>=0A=
>> Perfect, I was going to suggest adding a check for the minimum version=
=0A=
>> needed for each test.=0A=
>=0A=
> It would be great if we could document what is (a) the minimum version=0A=
> for things to work at all,=0A=
Actually the latest version or the HEAD of the git repo should work all=0A=
the time if it is breaking test or the tool or driver we need to add=0A=
a fix respectively.=0A=
=0A=
  and (b) the ideal version to use so that=0A=
> tests aren't being skipped due to version constraints and so we are=0A=
> testing the kernel as much as possible.=0A=
>=0A=
Agree.=0A=
> Ideally, tests should either be designed primarily to test userspace,=0A=
> or to test the kernel, so that people who want to use blktests aren't=0A=
> having to build the latest versions of userspace.=0A=
>=0A=
At least with the current NVMe infrastructure we need latest tools=0A=
(git HEAD) to be compliant all the time with the tests, since it=0A=
guarantees the tools, driver and kernel compatibility.=0A=
=0A=
We can a little install script to build and install the=0A=
cli if desired version is not present.=0A=
=0A=
> (As an aside, Bart has told me that the failures I'm seeing with=0A=
> srp/002 and srp/011 are due to the fact that I'm using a version of=0A=
> multipathd which is too old.  Apparently both the version of=0A=
> multipathd in Debian stable *and* Debian unstable are still too old,=0A=
> since they are still failing.  Next stop, building multipathd from=0A=
> the git repo....   Grrr......)=0A=
This is exact reason why tools needs to be built and check with latest=0A=
HEAD.=0A=
>=0A=
> 						- Ted=0A=
>=0A=
=0A=
=0A=
