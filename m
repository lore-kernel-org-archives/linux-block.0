Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA40C10F13
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 02:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0850C2084E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 02:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iOeioJYi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Gv0QayZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfDOCB2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 22:01:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1773 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfDOCB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 22:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555293688; x=1586829688;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/dCJ8u4yvJSCmgs2biIuLL2LjhxNUDJh1LYAH5ciCrc=;
  b=iOeioJYiSiI7YZV+XnbbkoNv00o+KMvqDZheFi4wNZ7ThsyYa4/HJUJe
   zwD9ke6r25kYLw2T9A8jiWG9nxUInZ0H5bHV+K2fORMSE13Pnm7G40MXT
   2tjAPPY8XJva7ydhPQE+xhhZmRnTlRqUxALXehyhlOc2xxrZ+X+/Vj1m+
   yZ90+0jvc6+gKWJqyaUKF2ZHbRllb5waqG8XXXHUqAnAiKWPxjIFAQsrm
   3Np+nVQYGTlDBXH6a5lGr3cclIDqeOEUO+PLTn+gMWSwCz/K1hdPZCd7p
   NE2BiqIKmCB72QeNIC3NO6ypiZuJDwNEb9RTqr9HMPYC7KgD6z58/ExlX
   g==;
X-IronPort-AV: E=Sophos;i="5.60,351,1549900800"; 
   d="scan'208";a="105959256"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2019 10:01:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQvn6b+3IAIcYIo0xVGq3TKFIhfGbS6JyvFyWtZTlDs=;
 b=Gv0QayZrYyWrwSLwH1lA/ra9bu/LPwhJM/BmSYAWm8kVA6NM+HEXCaxPet4Ts59WYADqGatqAzPcaF9ohS1pXSnnIdRgXBqZwAHUIcrAqf614XiPp6gxGFqcPa1iEc2lWC3Vxj1/wqPTg+F+F5ezmo3OagkcVtcWQ1rC66zpydg=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4127.namprd04.prod.outlook.com (52.135.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Mon, 15 Apr 2019 02:01:25 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 02:01:25 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] nvme/012 & 013: avoid extremely slow xfs IO
Thread-Topic: [PATCH] nvme/012 & 013: avoid extremely slow xfs IO
Thread-Index: AQHU8ym7CGbvmSfpy06Znyo5zdBPfw==
Date:   Mon, 15 Apr 2019 02:01:25 +0000
Message-ID: <SN6PR04MB4527DD7C84A15184AE5F7947862B0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190415012229.20689-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe12e822-df9d-4d08-a93a-08d6c14643fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB4127;
x-ms-traffictypediagnostic: SN6PR04MB4127:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4127D6B2E269CB0B14E67BD4862B0@SN6PR04MB4127.namprd04.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(51914003)(66066001)(33656002)(8936002)(81166006)(8676002)(81156014)(256004)(106356001)(105586002)(71190400001)(7736002)(53546011)(74316002)(99286004)(52536014)(71200400001)(305945005)(6506007)(26005)(186003)(7696005)(102836004)(229853002)(316002)(76176011)(5660300002)(54906003)(110136005)(25786009)(86362001)(72206003)(14454004)(478600001)(446003)(486006)(97736004)(476003)(55016002)(68736007)(4326008)(9686003)(6246003)(53936002)(6116002)(2906002)(3846002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4127;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iHyhvrldDhEz1t0oKXL/FsXta3cX5fEzwOa2vIdl19NJkRjc5f3gsg9ExZEQw29d3c4wyBvtjsskAHCLmeEzFcjfoDd7LFrI9SyFAWZ/5A/v56EfLPUrYToYm+67s8PguC26GJfL9fVkQ65IM62Ho388UfL8JbFDh7NLjyXZ0VsErHESjtN9DPYxjZKVcVV7KSrB9i7OGfu2mv3FYK84Pv+iO6KpSsjh6KFtsyohiL5ejO5PFkTeQXKoM0MeC05Jpy1ctAhCbEMqv9UThbrJC4GAAfTjRB0OhrH7mPd0N2LQXvDCwSIVw9Pg0xiuQCpcA3KCCoAOIEXPUMu/oTAhK9fGP65i5WjVFePmXnuuESiXenEpbhqtWCt4eOyM9r1DKt8vFwxQSM9WjUcYEomcZS4CXzOnKW2u/DcO/QTsFVM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe12e822-df9d-4d08-a93a-08d6c14643fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 02:01:25.0430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4127
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the patch Ming. Couple of comments below.=0A=
On 4/14/19 6:22 PM, Ming Lei wrote:=0A=
> It is observed that nvme/012 may take ~17 minutes to complete on aarch64,=
=0A=
> even worse it may trigger IO timeout on nvme-loop.=0A=
> =0A=
> Eric and Dave replied that it is because of too small log size on small=
=0A=
> disk.=0A=
> =0A=
> So pass '-l size=3D32m' to avoid the issue.=0A=
> =0A=
> With this patch, nvme/012 can be completed in one minute.=0A=
> =0A=
Then we should set the QUICK=3D1 if its taking shorter time.=0A=
=0A=
> Cc: Eric Sandeen <esandeen@redhat.com>=0A=
> Cc: Dave Chinner <dchinner@redhat.com>=0A=
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>=0A=
> Cc: linux-xfs@vger.kernel.org=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>   tests/nvme/012 | 2 +-=0A=
>   tests/nvme/013 | 2 +-=0A=
>   2 files changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/tests/nvme/012 b/tests/nvme/012=0A=
> index 9a6801511df7..d7a8751ec752 100755=0A=
> --- a/tests/nvme/012=0A=
> +++ b/tests/nvme/012=0A=
> @@ -46,7 +46,7 @@ test() {=0A=
>   =0A=
>   	umount ${mount_dir} > /dev/null 2>&1=0A=
>   =0A=
> -	mkfs.xfs -f /dev/"${nvmedev}n1" > /dev/null 2>&1=0A=
> +	mkfs.xfs -l size=3D32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1=0A=
>   =0A=
As a part of this series lets move this to the helper mkfs in the =0A=
nvme/rc and use that call in all the file-backed ns related testcases.=0A=
Let me know if you want me to do that or you would like to do that as a =0A=
part of this series. I'm okay with anything.=0A=
>   	mount /dev/"${nvmedev}n1" "${mount_dir}"=0A=
>   =0A=
> diff --git a/tests/nvme/013 b/tests/nvme/013=0A=
> index e346cd4baa35..bc435f752dca 100755=0A=
> --- a/tests/nvme/013=0A=
> +++ b/tests/nvme/013=0A=
> @@ -44,7 +44,7 @@ test() {=0A=
>   =0A=
>   	umount ${mount_dir} > /dev/null 2>&1=0A=
>   =0A=
> -	mkfs.xfs -f /dev/"${nvmedev}n1" > /dev/null 2>&1=0A=
> +	mkfs.xfs -l size=3D32m  -f /dev/"${nvmedev}n1" > /dev/null 2>&1=0A=
>   =0A=
Extra space here but can be ignored once we move mkfs to the helper call.=
=0A=
>   	mount /dev/"${nvmedev}n1" "${mount_dir}"=0A=
>   =0A=
> =0A=
=0A=
