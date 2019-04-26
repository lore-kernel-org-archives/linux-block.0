Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F27EC43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 18:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C6A2077B
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 18:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TQT2vQ/d";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SwJSU0Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfDZSYM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:24:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19969 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZSYM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 14:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556303050; x=1587839050;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=o76s8JFwOh5j8SGvBsX4QXeSXMSuXWHg7CDH4t2CEo4=;
  b=TQT2vQ/dp/EniRkADnFwq6aXYpYHsicMv4QyEI5LDwteyAeMymZk1Ro5
   kgyt2W5K9CgLQj0sJSdtSSaP8p77BoTfdQOWMAVk+ZbOqzdyYcoHcuUI+
   5U7m5BPLsh+GZ690WPLeoKWg1uLttj8OE8PUAKhVwMwl64bKWAmJFqFwf
   UkcAKxP7V50BKrYX+c+xTfGGcLj9YT69bqTX/B8uectkYso5zjLooIXm2
   QKRly+WAk6WT2w97yJqRRQwzlELT7N6zewd5+BylfNg9pZY9h7CnOjVqm
   +Cteq4dp+g7g8mcB4VZoaGttFzzogXQiNgGQb2ehP5RCqwSv61AVvTMd2
   w==;
X-IronPort-AV: E=Sophos;i="5.60,398,1549900800"; 
   d="scan'208";a="111887461"
Received: from mail-sn1nam01lp2058.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.58])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2019 02:24:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o76s8JFwOh5j8SGvBsX4QXeSXMSuXWHg7CDH4t2CEo4=;
 b=SwJSU0Te+DYiww7zgvoezPvUUC6l9n6ylrzA7qEq+vVwbIAhL5ZtTLRq3Mnheg/0bmjHVaebJArrCnd4FI1LP2/5XXpGRi5o2FQbZLor19klG55DDdyIX64kCLxxmNo664czkg0o/9xhG4d7/Vznlfx8gq9io+N8CzaOqWCuFCc=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4782.namprd04.prod.outlook.com (52.135.122.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 18:24:08 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1813.017; Fri, 26 Apr 2019
 18:24:08 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
CC:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block/028: check if T10 verification fails
Thread-Topic: [PATCH] block/028: check if T10 verification fails
Thread-Index: AQHU+/FQSzR65fIaLky7wQv5PejQ6g==
Date:   Fri, 26 Apr 2019 18:24:08 +0000
Message-ID: <SN6PR04MB452733A7DC62133964DEA4E9863E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190426023937.19584-1-ming.lei@redhat.com>
 <20190426145711.GA12338@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17d0aca3-e8f9-4a76-5ecf-08d6ca745f94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4782;
x-ms-traffictypediagnostic: SN6PR04MB4782:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB478209CDA887FB0F83E3B4A4863E0@SN6PR04MB4782.namprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(396003)(376002)(189003)(199004)(14444005)(86362001)(55016002)(97736004)(6436002)(229853002)(256004)(9686003)(81156014)(53936002)(81166006)(8676002)(316002)(4326008)(6246003)(7736002)(25786009)(305945005)(26005)(186003)(74316002)(478600001)(14454004)(72206003)(486006)(15650500001)(3846002)(2906002)(6116002)(446003)(8936002)(33656002)(99286004)(110136005)(54906003)(7696005)(52536014)(66066001)(76176011)(6506007)(53546011)(5660300002)(102836004)(4744005)(71190400001)(71200400001)(73956011)(476003)(91956017)(76116006)(66946007)(66476007)(66446008)(64756008)(66556008)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4782;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yUmB64/6iw0heIKybSwHUPZmEB7gCReFJBgXofUAmXVbZI4UagVNTmQk4Vm7LBv2Dn6m6Dv13HInSzQ+WXIyk0/ISwoeUJzz+L44VKP13fukWHyMSoLBm1dfKCJ7XjJtsO2PDTLhy+eKVmW0Xg9nEFwzgwOu59GF8z39Sgk2f0BYeRrIQxAiz9Y1o2IzsKM5rYBwPxveZgDrIe65VsdD3MfRE7Jr00pt2+Gsa2e8r0gF8pkJmL1rBKiA2JpcK004nGQo7a2yum9MU+WaU+n2URGYPJn1pJVSs7scAKCqiGYt7kTBEzWer3L0xfYY0t8D5Z7b/aQSGufzSaApaf6inWOLwu8+a8GcbFDnXwC/rTm2A2/ND0OTP04rmEsfBTf4/iP9A4cDj42Tih2dR51OhePTyBAYk2VEC5GsGBQyyhM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d0aca3-e8f9-4a76-5ecf-08d6ca745f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 18:24:08.6659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4782
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Until we fix this, I'm okay to have this change in the blktest, if this =0A=
is breaking any exiting behavior.=0A=
=0A=
On 4/26/19 7:57 AM, Christoph Hellwig wrote:=0A=
> On Fri, Apr 26, 2019 at 10:39:37AM +0800, Ming Lei wrote:=0A=
>> When T10 verification fails, the error code of BLK_STS_PROTECTION=0A=
>> may not be propagated to user space, see mpage_end_io().=0A=
> =0A=
> Well, we should probably fix that instead of papering over it..=0A=
> =0A=
=0A=
