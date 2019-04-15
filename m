Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCC7C10F13
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 02:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1C12084E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 02:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AXKdvLSS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R3PaO/L1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDOCGL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 22:06:11 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46933 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfDOCGK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 22:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555293970; x=1586829970;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=c9M1sLa8vVOkRZvIT986PL8LGmuozv52HXFK5KIkhTg=;
  b=AXKdvLSSiBRLrxwN2sXYv6OZwAKtuilSZ8AbUN7Hg6AearJJRLz7BnbM
   mAbWIqWXzUSkgC97J9JBIJ1ZBugUjNvf8Pir1bZ16Y/x+ceoM5eFXIeca
   iefWwdh2MKmry5ydMY5Ynuq++7WoU//I37bXcsTGt0pi6Qa2MXiPaHFYd
   SzJT++fXL5zfX8UbrbnrAigDy9zfLGmvDlGG+BrvccglYmdVJfBhtcCjT
   VrouePzuR8lGL+/js7qGyNZXzEsDEjfq5b/6Tp4eIjMGwLHmARAChtXDS
   uCh4DSaeHEemhxH577TarC3TcBJe7t4JLmDDsxkRlhzHYt0Gv2qGTglME
   A==;
X-IronPort-AV: E=Sophos;i="5.60,351,1549900800"; 
   d="scan'208";a="211690459"
Received: from mail-dm3nam03lp2055.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.55])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2019 10:06:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLXRw5qJfq3EfyVE9zGxnL4mJ0zkure9dEfI5gwezME=;
 b=R3PaO/L11tdK0nCTm3jSfOM7i40gBVFHK3BJGdQqz5iGSrNs4ztXd+WW7WbcgGxl+h+3PfmBBBlkJ6YpEDaKjO6sfguKNcA1JiaWJAgJ6+d6gog7fvz6eeStt224iGKxUXRKwjsmj5f+7d00nLpSc2gA+bxlTf84K+mJY9tCIV0=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5311.namprd04.prod.outlook.com (20.177.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Mon, 15 Apr 2019 02:06:07 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 02:06:07 +0000
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
Date:   Mon, 15 Apr 2019 02:06:07 +0000
Message-ID: <SN6PR04MB4527CE00058ED7118310BF2F862B0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190415012229.20689-1-ming.lei@redhat.com>
 <SN6PR04MB4527DD7C84A15184AE5F7947862B0@SN6PR04MB4527.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55bb1f80-56a2-4ce9-5efb-08d6c146ec6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB5311;
x-ms-traffictypediagnostic: SN6PR04MB5311:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB53111FED1376D6179B8395E8862B0@SN6PR04MB5311.namprd04.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(396003)(346002)(366004)(189003)(51914003)(199004)(52536014)(97736004)(316002)(55016002)(25786009)(3846002)(486006)(6116002)(4326008)(6246003)(476003)(9686003)(81156014)(81166006)(8936002)(66066001)(68736007)(53936002)(8676002)(446003)(99286004)(33656002)(76176011)(102836004)(6506007)(53546011)(7696005)(93156006)(72206003)(105586002)(54906003)(2906002)(186003)(86362001)(106356001)(6436002)(71200400001)(14454004)(71190400001)(229853002)(305945005)(478600001)(74316002)(7736002)(256004)(5660300002)(110136005)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5311;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 94ylDiFkLnfT8jnoxKRvGiuYngH2zs7uSe8NpYNbhHe7F6kWfSJUvPKcbRs7wMMPYxfCgRrxXhPM3UBta1L80pEQqa3ryBr+MypgqO8UAwZBexP3Ogt8OPmsILCYpT/b85APkMSgtjbYjvNC9+HDet0326benehls5xrbwUytKXaYh0Bso/QxTWYzpDXrkiphgP7JuXVSQceZnhMikldtD/pgcsMgIXPAG1DJcWwoO/xeU6qX7GkCfDdWKMiOSiuy7OlyV8mjIgQ2ClGOqhEGhRnI0rbObYKdjPzP/ziIDLjTdERpoDvICFLCduLQiWFV33LmkWFbJWlK6Rn2GyvzCaneiyYp37PQyIpUw7tNSexsQKaiaiSqoX1mtldGZQBXbeZctDPrmwc1lDWyEz9EgWTDdxRYTNC7dgECL/ruDo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bb1f80-56a2-4ce9-5efb-08d6c146ec6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 02:06:07.7094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5311
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/19 7:01 PM, Chaitanya Kulkarni wrote:=0A=
> Thanks for the patch Ming. Couple of comments below.=0A=
> On 4/14/19 6:22 PM, Ming Lei wrote:=0A=
>> It is observed that nvme/012 may take ~17 minutes to complete on aarch64=
,=0A=
>> even worse it may trigger IO timeout on nvme-loop.=0A=
>>=0A=
>> Eric and Dave replied that it is because of too small log size on small=
=0A=
>> disk.=0A=
>>=0A=
>> So pass '-l size=3D32m' to avoid the issue.=0A=
>>=0A=
>> With this patch, nvme/012 can be completed in one minute.=0A=
>>=0A=
> Then we should set the QUICK=3D1 if its taking shorter time.=0A=
> =0A=
>> Cc: Eric Sandeen <esandeen@redhat.com>=0A=
>> Cc: Dave Chinner <dchinner@redhat.com>=0A=
>> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>=0A=
>> Cc: linux-xfs@vger.kernel.org=0A=
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
>> ---=0A=
>>    tests/nvme/012 | 2 +-=0A=
>>    tests/nvme/013 | 2 +-=0A=
>>    2 files changed, 2 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/tests/nvme/012 b/tests/nvme/012=0A=
>> index 9a6801511df7..d7a8751ec752 100755=0A=
>> --- a/tests/nvme/012=0A=
>> +++ b/tests/nvme/012=0A=
>> @@ -46,7 +46,7 @@ test() {=0A=
>>    =0A=
>>    	umount ${mount_dir} > /dev/null 2>&1=0A=
>>    =0A=
>> -	mkfs.xfs -f /dev/"${nvmedev}n1" > /dev/null 2>&1=0A=
>> +	mkfs.xfs -l size=3D32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1=0A=
>>    =0A=
> As a part of this series lets move this to the helper mkfs in the=0A=
> nvme/rc and use that call in all the file-backed ns related testcases.=0A=
> Let me know if you want me to do that or you want me to do that as a=0A=
> part of this series. I'm okay with anything.=0A=
>>    	mount /dev/"${nvmedev}n1" "${mount_dir}"=0A=
>>    =0A=
>> diff --git a/tests/nvme/013 b/tests/nvme/013=0A=
>> index e346cd4baa35..bc435f752dca 100755=0A=
>> --- a/tests/nvme/013=0A=
>> +++ b/tests/nvme/013=0A=
>> @@ -44,7 +44,7 @@ test() {=0A=
>>    =0A=
>>    	umount ${mount_dir} > /dev/null 2>&1=0A=
>>    =0A=
>> -	mkfs.xfs -f /dev/"${nvmedev}n1" > /dev/null 2>&1=0A=
>> +	mkfs.xfs -l size=3D32m  -f /dev/"${nvmedev}n1" > /dev/null 2>&1=0A=
>>    =0A=
> Extra space here but can be ignored once we move mkfs to the helper call.=
=0A=
>>    	mount /dev/"${nvmedev}n1" "${mount_dir}"=0A=
>>    =0A=
>>=0A=
> =0A=
> =0A=
=0A=
