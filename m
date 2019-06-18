Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44BBC31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 16:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC2A2147A
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 16:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gmNjJGjw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tuEjyE9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfFRQED (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:04:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32776 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbfFRQED (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 12:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560873843; x=1592409843;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DjuNtPd2N6RK8D3xXOzlTRMZa3RAkJeYmfb7VazTrXY=;
  b=gmNjJGjwdBUyKA/FjzNj24K5PVFl3ZICvHIa5AI2BlpOzSBtEKJmeOSp
   baIvIuK4Dy7vXIz7nGp1GuFFo8/wP0502eG6ANiN10XrsThTfVN/MS56Z
   IApB041JrozmSGpAJ2F13pToz9xPdKi7S/XIkgVho/aRLxvAySpC9BAom
   HUeUV+EM8iG4DBLXNm4CY2WQwma7v9Vs5IKguTqT4Lq42xCLiwch18wFV
   GZIEwpsYOjELVdeVtFHBd6edkHfnsMaUAHGJ5WHEuQRTA6IVPr6jIKPQr
   lTQMZW0IPz3nQ5+UbPpFXvvudFwNsX5oylloexOZMDiwgVmZwHhUfE1PE
   g==;
X-IronPort-AV: E=Sophos;i="5.63,389,1557158400"; 
   d="scan'208";a="115782603"
Received: from mail-sn1nam02lp2050.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.50])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2019 00:04:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkV7w3cI8MRZ4dZsdgAvaJcvK6YjnV8IcHhBNROj/0A=;
 b=tuEjyE9EBG3usDxFUpu5m/L6sQbQniJdMPrpvrb61+/o3kqAUf7AHvm4+wTInaLgi++yWAINhY/ANVnC+qg13IHmlrGJ/0AywHta7DadXwQqSOHwLalQ9xGi68xXPJb696qmstF/vI4ToFtSRUmTrNyrBjGAG2FhABd8o1PJc9U=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5957.namprd04.prod.outlook.com (20.178.232.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 16:04:00 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.1987.012; Tue, 18 Jun 2019
 16:04:00 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>
Subject: Re: [PATCH V3 2/6] block: add centralize REQ_OP_XXX to string helper
Thread-Topic: [PATCH V3 2/6] block: add centralize REQ_OP_XXX to string helper
Thread-Index: AQHVJZikjbQiXp4c80eE8SX7H+AKHw==
Date:   Tue, 18 Jun 2019 16:04:00 +0000
Message-ID: <BYAPR04MB57490A7C160198053806ECF786EA0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
 <20190618054224.25985-3-chaitanya.kulkarni@wdc.com>
 <97487a45-0a53-970a-8237-86eebfbe7ad9@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1d4295f-fac1-410f-ab20-08d6f40693cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5957;
x-ms-traffictypediagnostic: BYAPR04MB5957:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5957EA401B2C1A658CE2A9F686EA0@BYAPR04MB5957.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(53546011)(256004)(5660300002)(8936002)(76176011)(52536014)(6436002)(4326008)(55016002)(486006)(186003)(7696005)(68736007)(6116002)(25786009)(73956011)(14454004)(6506007)(478600001)(3846002)(9686003)(74316002)(110136005)(66946007)(66066001)(66476007)(33656002)(71200400001)(76116006)(102836004)(229853002)(2906002)(99286004)(316002)(53936002)(305945005)(72206003)(64756008)(4744005)(476003)(81166006)(81156014)(446003)(8676002)(71190400001)(66556008)(26005)(86362001)(54906003)(66446008)(6246003)(2501003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5957;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 14zFVTCEbicpbByr0alnbOj+o9WV17LcvHJWumZ647pj9a1pWrVSmVfwufGL+QwsKLXQBWwDq45PI1TfnIjdd5ptcwHgFAoJ5rTukuIgNXjIpw0WtJT3j09t99SBbMoDgSUSYnc+MVllK9jYTrZ7416xH0xi8iIPAwpwhmaSLu2x76JxEsVw5YJn8kbwtbRzbECkIsWEuneDlBCtvFNNtyhKOTqmHpTmKNDXR7lNAuMURCf4hzUGfqOkb0Zd0McdJ0AdqRMLvUJTgKl8qgOzpg3L7D1FldgLFYO6HjGQGBYMoK2o6bYNZSCInMCI33sz3rQoH6aEZJxl4upfwZTVSuUXJ08PU/iDV46dBNfI2aWqEhgXnqrRGgS+9zqqQEQeJzZikBvO/Ngh85FKLD/bf4oa5Z1zyWI84WpGOzAcBF4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d4295f-fac1-410f-ab20-08d6f40693cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 16:04:00.5309
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

On 6/18/19 8:26 AM, Bart Van Assche wrote:=0A=
> On 6/17/19 10:42 PM, Chaitanya Kulkarni wrote:=0A=
>> +inline const char *blk_op_str(int op)=0A=
>> +{=0A=
>> +	const char *op_str =3D "UNKNOWN";=0A=
>> +=0A=
>> +	if (op < ARRAY_SIZE(blk_op_name) && blk_op_name[op])=0A=
>> +		op_str =3D blk_op_name[op];=0A=
>> +=0A=
>> +	return op_str;=0A=
>> +}=0A=
> =0A=
> This won't work correctly if op < 0. If you have another look at the=0A=
> block layer debugfs code you will see that 'op' is has an unsigned type=
=0A=
> in that code. Please either change the type of 'op' from 'int' to=0A=
> 'unsigned int' or change 'op < ARRAY_SIZE(blk_op_name)' into=0A=
> '(unsigned)op < ARRAY_SIZE(blk_op_name)'.=0A=
> =0A=
Will change the op to unsigned in next version.=0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
