Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B47C31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 16:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B8E2080C
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 16:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lARlQ4lK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="angTyvX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfFRQCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:02:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:44302 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbfFRQCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 12:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560873762; x=1592409762;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wxiDlqDKjJlmBso8UN7bHkVUOvhZArE0KO8G8tgchPI=;
  b=lARlQ4lKaLhh8/0HT8phXKIm2sTAMpvxxONmTRCrgnLnC2zRRdTvl680
   41fXeyWmXmLeIHevI6bI9Gx8zLe6odx401BZAdGMq7YnkAPEsnMyynM1G
   hoGKscTOItsCNIVMms2D8+BUa3v6jhK8ULIv4DhVHN5bGUI8ABBWod3xW
   Tb/v5jf35qiS4DEv6m/ViF9W0fD3WYjzvjtist8fB+pP+c4e0yWWCV71L
   35K4nzc9Ny6ImY1MIhgBec9xyOv29sxQmHfs+QEBhQ0/syw7iiDUX9NxN
   aViZ/35+h1A70Bq3nnnWeHyBY5R9mg4GHDTR70XSPgHfQ+hj1O5cpx6wa
   g==;
X-IronPort-AV: E=Sophos;i="5.63,389,1557158400"; 
   d="scan'208";a="112115712"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2019 00:02:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxiDlqDKjJlmBso8UN7bHkVUOvhZArE0KO8G8tgchPI=;
 b=angTyvX3ftVd9ROdsgmzYkevvxAYiQf1aL3ET3wd7prvjJRCFy0228FPPKQgTDzuNQoWLxtWIm+G+ybKPs6fEQV3s6LmqtZ0/2tt/X+4tW9qFOEuK68x1K+s/+87V969Fi+Z9pQJFkEZd4vwbKFXFtLTFYUJWmTF8SEzbiTiOQw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5957.namprd04.prod.outlook.com (20.178.232.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 16:02:40 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.1987.012; Tue, 18 Jun 2019
 16:02:40 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>
Subject: Re: [PATCH V3 1/6] block: improve print_req_error
Thread-Topic: [PATCH V3 1/6] block: improve print_req_error
Thread-Index: AQHVJZihzAnPp5ruk0GE0H02ZD/S7A==
Date:   Tue, 18 Jun 2019 16:02:40 +0000
Message-ID: <BYAPR04MB57492DB98A28D5081AF5D31A86EA0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
 <20190618054224.25985-2-chaitanya.kulkarni@wdc.com>
 <790e2fcc-d46a-cf8a-874a-da70f8897d2f@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2140eacc-357d-43e7-79c3-08d6f406641a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5957;
x-ms-traffictypediagnostic: BYAPR04MB5957:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB59579775F12F5AD3E8CEAE6F86EA0@BYAPR04MB5957.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(53546011)(256004)(5660300002)(8936002)(76176011)(52536014)(6436002)(4326008)(55016002)(486006)(186003)(7696005)(68736007)(6116002)(25786009)(73956011)(14454004)(6506007)(478600001)(3846002)(9686003)(74316002)(110136005)(66946007)(66066001)(66476007)(33656002)(71200400001)(76116006)(102836004)(229853002)(2906002)(99286004)(316002)(53936002)(305945005)(72206003)(64756008)(4744005)(476003)(81166006)(81156014)(446003)(8676002)(71190400001)(66556008)(26005)(86362001)(54906003)(66446008)(6246003)(2501003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5957;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nv0N3BwoXmR04Myucs51OQ+s/YJFG79QS20Dnnmi+jDhmJFEdQ3uyMbqecmdrC5vC9PgTPlG/7ByykEXd/FSlE431eARJboj7q3BDEvd2aarU27JnMNm+OUVtIGPdeqStF1vf1QLhMn8nNb399A/KLfEQUQTRtkvaldQFdY4etUAHWkL8ZcC4lcW7I6CuhXpQyoGpKunm5w4UVCii2V0HDh8qAw+eJicYd8+itS+WhuTL1FaspYeL24u7jAPN5E7KUgH5biap+mFTvJj9IC1mIjqT+nVqYZ+KtEdMNL8cxrMkS2IrierTDuGYJetPS7WLInd7yQtAMwIJ1WG7YWS2zuUCe47IPH8hnSH8Nz0SKmpdJoAhc0d89fZsBnCpZe8XMApnGnw5nJoRXyl0RLRjYfSfQkX7IxVL51kjQPvG1U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2140eacc-357d-43e7-79c3-08d6f406641a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 16:02:40.5032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5957
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/19 8:21 AM, Bart Van Assche wrote:=0A=
> On 6/17/19 10:42 PM, Chaitanya Kulkarni wrote:=0A=
>> From: Christoph Hellwig <hch@lst.de>=0A=
>>=0A=
>> Print the calling function instead of print_req_error as a prefix, and=
=0A=
>> print the operation and op_flags separately instead of the whole field.=
=0A=
>>=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> =0A=
> Is Christoph the original author of this patch? In that case I think=0A=
> Christoph's signed-off-by should occur first and yours second. See also=
=0A=
> Documentation/process/submitting-patches.rst.=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
Okay I'll do so.=0A=
