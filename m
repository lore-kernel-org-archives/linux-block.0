Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13017C31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEAC2082C
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 16:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LLMSg1I/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B4blXUfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfFLQTL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:19:11 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39080 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbfFLQTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 12:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560356349; x=1591892349;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QoyaB7FbZLkhObryB4jU2IESGEVYd2USgXocjR2bIBI=;
  b=LLMSg1I/rEdrSlEs7fP2g4iuhTP8xA2C7rs/ubdAxf+GNr5+uvCIwAFD
   jyJoDMny5rWo2jQJPCPOmQGOs16Ct+csOlnYobXDxyhyQN4APfwFaLX/D
   o6XI4nLyStfgyOm5Hc+i92z9c9RIlZeQARwoardbQ47xdtTJ/yUuaSMqS
   NhPWwrgJIYL9iPrltDoCRV8lue93wSNGrkfZ9935FtYUd/wmJdphprk6w
   dX2zgGnMBknolc+VVwtAqJ6OUwSjbOduDp0UGo+VjleXyuRYHn72PLyFG
   az4Av0Yb5i6kCgIOmxLQvCvcwCAfsHPn2dkoZrmy5L/6GNxjZwfPODAnm
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,366,1557158400"; 
   d="scan'208";a="115327135"
Received: from mail-by2nam01lp2058.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.58])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2019 00:19:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuteOjmzHVLkK3fGQ9IKBm2eCzhIWK4ZaVAPXQ6V5Co=;
 b=B4blXUfF1d0qtQdHVm5u6+ryLrEoghB4vzUzIx2DpJx/an/pbPjG2fi5i9dh2q51AthZRJd71Pq2x1/jiJJioHl4yo36/kodkh2OvPQMD4pN+1+90eAbi8fsqwg8i01KpJvWP9VOksRa1cNeZ+Fs/kadyDds6e4dS+YV7WXXU/k=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB6105.namprd04.prod.outlook.com (20.178.227.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Wed, 12 Jun 2019 16:19:07 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::749c:e0fc:238:5c6d]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::749c:e0fc:238:5c6d%4]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 16:19:07 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH 2/2] block: add more debug data to print_req_err
Thread-Topic: [PATCH 2/2] block: add more debug data to print_req_err
Thread-Index: AQHVIJCVXtXT2DJFWEymWp+MlTrWSg==
Date:   Wed, 12 Jun 2019 16:19:07 +0000
Message-ID: <DM6PR04MB57545CCD2B1BA077CA0E36F986EC0@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20190611200210.4819-1-chaitanya.kulkarni@wdc.com>
 <20190611200210.4819-3-chaitanya.kulkarni@wdc.com>
 <3ab93dfa-523a-c5e8-05fc-2c974fc8778e@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdca7ec6-1e0d-4230-9928-08d6ef51b1b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR04MB6105;
x-ms-traffictypediagnostic: DM6PR04MB6105:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB6105019B0AC65D0E105EB05286EC0@DM6PR04MB6105.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(66476007)(53546011)(8936002)(8676002)(68736007)(66446008)(55016002)(33656002)(186003)(5660300002)(110136005)(9686003)(25786009)(3846002)(54906003)(229853002)(6116002)(81166006)(81156014)(66066001)(74316002)(6246003)(476003)(72206003)(99286004)(86362001)(446003)(305945005)(14444005)(66946007)(73956011)(486006)(71190400001)(256004)(4326008)(53936002)(2906002)(71200400001)(316002)(102836004)(478600001)(26005)(52536014)(66556008)(6436002)(2501003)(76176011)(7696005)(91956017)(64756008)(7736002)(6506007)(14454004)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB6105;H:DM6PR04MB5754.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jANi/H1Zjm2IacX/3M46uP0/P/7KB4IXT/Iz5MZVwAt/ymMtSS05HAwOA/rkS4juyUIm0PotxOrYgrgwR6JaMlZQmxz7oGxMW6H9yFcNr22n/rvXWWLlZckzq4eitS7jNgUdwPYAYCw8Sz8iwvUTXPsDtYhWJ2SlJB79LTFLfcVd2UzXk6hrcUA3KUmYzdO7QoDpyFFJYbauGgkKqkMEX5P0e2z//XqRLZ8WXF+A6UVyfElDvd6S+GRs5BO1DTtz0Z9hatsj5HEV0JSGBGgNl1Aru79QiTP9RHLWOeJR861ru7S2pmjYVuVmzZwXzgmfhhVsvqZEUGcJJIMTkCKPPUtV6HZ/t3hxDlvaUkdzagWuPkcREJfjSnN2dfG3aQTSURne5gjFyZxFNGMmmohqhO5ut0/7PyTCMXM1Zsp+Md8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdca7ec6-1e0d-4230-9928-08d6ef51b1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 16:19:07.0757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6105
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for for the review, I'll send out the V2.=0A=
=0A=
On 6/12/19 8:22 AM, Bart Van Assche wrote:=0A=
> On 6/11/19 1:02 PM, Chaitanya Kulkarni wrote:=0A=
>> +static inline const char *req_op_str(struct request *req)=0A=
>> +{=0A=
>> +       char *ret;=0A=
>> +=0A=
>> +       switch (req_op(req)) {=0A=
>> +       case REQ_OP_READ:=0A=
>> +               ret =3D "read";=0A=
>> +               break;=0A=
>> +       case REQ_OP_WRITE:=0A=
>> +               ret =3D "write";=0A=
>> +               break;=0A=
>> +       case REQ_OP_FLUSH:=0A=
>> +               ret =3D "flush";=0A=
>> +               break;=0A=
>> +       case REQ_OP_DISCARD:=0A=
>> +               ret =3D "discard";=0A=
>> +               break;=0A=
>> +       case REQ_OP_SECURE_ERASE:=0A=
>> +               ret =3D "secure_erase";=0A=
>> +               break;=0A=
>> +       case REQ_OP_ZONE_RESET:=0A=
>> +               ret =3D "zone_reset";=0A=
>> +               break;=0A=
>> +       case REQ_OP_WRITE_SAME:=0A=
>> +               ret =3D "write_same";=0A=
>> +               break;=0A=
>> +       case REQ_OP_WRITE_ZEROES:=0A=
>> +               ret =3D "write_zeroes";=0A=
>> +               break;=0A=
>> +       case REQ_OP_SCSI_IN:=0A=
>> +               ret =3D "scsi_in";=0A=
>> +               break;=0A=
>> +       case REQ_OP_SCSI_OUT:=0A=
>> +               ret =3D "scsi_out";=0A=
>> +               break;=0A=
>> +       case REQ_OP_DRV_IN:=0A=
>> +               ret =3D "drv_in";=0A=
>> +               break;=0A=
>> +       case REQ_OP_DRV_OUT:=0A=
>> +               ret =3D "drv_out";=0A=
>> +               break;=0A=
>> +       default:=0A=
>> +               ret =3D "unknown";=0A=
>> +       }=0A=
>> +=0A=
>> +       return ret;=0A=
>> +}=0A=
> Please use an array instead of a switch/case statement to do this =0A=
> conversion. See also blk-mq-debugfs.c for examples.=0A=
>=0A=
> Please also make show_bio_op(op) in include/trace/events/f2fs.h call the =
=0A=
> above function.=0A=
>=0A=
> Thanks,=0A=
>=0A=
> Bart.=0A=
>=0A=
=0A=
