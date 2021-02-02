Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B117C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 12:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F1264F55
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 12:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhBBMAT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 07:00:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21834 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhBBMAQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 07:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612267216; x=1643803216;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=BgXqpxx55jQNMEfaas3oXDQ/c/CQ40Aoyqqaqpue6b08vvJbKGkkX+vH
   mDi+hhlWLd4qnuu9do07yjj5MXdYycvRf9yIA+AYZaYVa4HLv3TPvra1y
   066tvwn0vlzvzQ8EpDxfZXJ6XhTOad4FQJRFqe/VhVhiN1WgH33rAZb/t
   Xp+oGoSIFA80OCFnpkuWEMbOcn034ZRjZrPEBGUnSSSqgzY/ApU4utMK9
   aQWwCsMI2pk690deG9qGfrBDUZPRoYlNdI3MpTefLb6Qn8zYFK+0/FR2+
   M6fqmRIp6JgQmfsLUEJtMfcvGcIE+Q7QakdffIojiBoKMxCY2aj8D4ZLA
   w==;
IronPort-SDR: 4IzdKat5tNHvtdFAp4Y51eNQwDaqHY2xc0krALScVPwxW3YAhu9ZBxJi6IETdYCVvQwAU1d+EX
 w1syWCvFTup/Qyh51dbt9i8mAmCWJS9v9LXdgz8qEccRwrV+niNrbbuGuIX4MpeXB5fVo0MRUw
 LPzNBIOM29hKtNKDNKk8NTmh+g2XJIHw5oHETwGcym5QXyKme4lkGZQXsCdt/NRzV9SozB5Pop
 wmkrOyHZ6KqKlFl+++o1ie2Kf4XHm9WAejJFuBJHRKA4GXNT36BU4+6oJGH1PsbCSlzToImDvN
 2YA=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="160097522"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 19:59:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOWNx6ixdrWfWmoDv4ruoERG3UOMtRc9UjHY2sklXj8LOE0ugTbLuL7A6MWJrfp4rqSTFWjaNsw0QgnYlVFd1XrnDMXUAcYeWFyY0JDY5PClh/Rxqr7n4gEp0tez1n6/FXiQGYCfX1G1bZ7VYCMAEEtcZsxqGwuaAD4OF+msxRAcu5VcOtaaNNW9CWdKq0uYVu0ZPqUB7WykbcBf9yPq61ETjYzeD4uEuYXfOfu+EEUSBkrqFvwn8VDZopyzmVj+4QWnP4viIW3en3HsRiMciPl7dXf3utxrDjwqnne1IMceo4EsuKfFlH6588QsHKjPDOsQDGOTjwK2RwV6cyMqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=noMHKHztdyCv28mZJVOzXfhAs9Kw27zqz9fCw6baJim0yjUz7QY9K9GqMFJgZ2WLbp0zZbN7LkRX/2os3O9yn1Dtp/r9dGwXnoDQcHQmUZjgzY7elHXUSlrC9ffn+FQKmyLPbqUIyewOY13MoEwH/Rm3tMulXdDPfeM4ZyKo+zxTQaXVlnNv4UZY2pY68HUu+FZ4xR9B3UoeBEJ7vt1nRqi1+VThqzrecPXux4XabDUfQ0Fp4M/q23Qi/8MjTD2/JcmMtaPl/Mg10fkLxvxzLYMaBds46zQU6rEM0tgyIkuYCMgmmIs9OcuXO9xO0FXI4ZN0dnlu54YK1dH5Y9Kt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WrOwuadaAnrfVtQPI8s7y+lS/lQOR0pXMRMowFsWxCMyrfVOkFDVVVZ1q94+EMlkknd94XAKxX387B8nuO3pSP2eqkM+RPAweXCBolI5pU6OgoFyznTsrC6TP1jSqyFTNLvqkrqMQdkAql9ULpLZIK1QvMFAFbJ8WWEhV3F2Xgs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4864.namprd04.prod.outlook.com
 (2603:10b6:805:9b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 11:59:09 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 11:59:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 16/20] loop: remove memset in loop_info64_to_old()
Thread-Topic: [RFC PATCH 16/20] loop: remove memset in loop_info64_to_old()
Thread-Index: AQHW+SYDkHPh0yHSX0mS96+kBgKgFA==
Date:   Tue, 2 Feb 2021 11:59:08 +0000
Message-ID: <SN4PR0401MB35983249BDAF4744D0D301309BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
 <20210202053552.4844-17-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec648731-17b9-4cc6-4f4a-08d8c771f2ba
x-ms-traffictypediagnostic: SN6PR04MB4864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4864036B79EAA4582427F5A99BB59@SN6PR04MB4864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S14SnP7GcZhmYBpRe/AY/jY/yls+j1XqKEb8eWs4fNVL9bZW3X8roYaCJJFufY/y81F+L+u5nU7v5OL4190nWY8bCToo4DxJPNq3cozEo/2tfKUAT2ya3uzdlK7KeKZNnKB0PTGAcqkzqpK94opfUlDPCkjZAFiAmB7JA6LCyWyyr1vNt91iV0nr5ykjgpF/CxIeGtyb+unOT2TaYoW3Tt4NzL8Pr0v69nJOcc7S3E8fsPiEhLScP1RK6DQrTWPUjH7aR3cKSCb+P8inBKGaHZE66c9LTQUPl+UctFErau6yDPYTWdW073RTVeO0u82WVWrkC/kjE0XZM4OVNbiQH/hH60z5gRXS6Q4yiejLerVL1Er2cp1MhLljtuPBpTQYLU2MXpvXwDMoBxVTbaG90OdTxOtu49vc4iUcdP7pXoadeHMELVMxAY+1nyG0VUiTfKQSrP9woLbbjVYjr7O4ZTr8gW5uRNZ/HC8y30nD/JgmF6xUkDDtvSAau4qdkvw0eC9s0rkQhc4/RFmirl2byA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(4326008)(86362001)(33656002)(478600001)(55016002)(8676002)(9686003)(186003)(4270600006)(7696005)(6506007)(66446008)(66476007)(64756008)(91956017)(316002)(66946007)(71200400001)(558084003)(110136005)(52536014)(66556008)(19618925003)(5660300002)(76116006)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sM0bUEgGU7+SCXV1os8kTaYQVpeKrNMCZqHZUcNj1H1ZbbXmjRC0Z1iqe7P6?=
 =?us-ascii?Q?Ye453bUl++sKua2PHICs8FWPlBZJytLUtjDr0BQE9MS2V85mscrYox5/ewwL?=
 =?us-ascii?Q?J0556VsTV24Fy0o81pN2erVoihTOGbdFfv/h5+aEvR/TWsBL3xRj+jaN3orp?=
 =?us-ascii?Q?9RAMgJ/w2Jo8w6a1QDc+F1ncBVcq6FRZZ14oYR5ald5ft/Xm2Ct0wf3u5Xue?=
 =?us-ascii?Q?g8geJ44iIZW6WOGZmrk3oXB26EWP8zhgTWPQWc052aEKs1ZpLHB6G8Tl8Wnj?=
 =?us-ascii?Q?jUuP5CoWJdlmYkLfeSdf48bSi2lqrzWKd7fvW2x46CfqhS4IpRIdXn+1HAgd?=
 =?us-ascii?Q?A1fChw8NIksH2PYg47f2jdWT6P4mBepT76o0JeWcMVVgdFsQzcDnx2c/M8VA?=
 =?us-ascii?Q?+NtLWS+FtqZJrHRMZkRAo2W5HIv3hQQBBxwjsdBQgGIWwCLvcSkrIGNaOk1t?=
 =?us-ascii?Q?YT2KIHuTx/hGRLkQcik0iLdXnRGTzrWToKIjMekcQz/7i3wRB0BjeSMTh9sY?=
 =?us-ascii?Q?0XGjn9s3J4bcR88GCw4IuCb+S+z+Pb+eBMzjW9A56ImHnwHcAw04P04zpwM+?=
 =?us-ascii?Q?Uzr51fvmZweTNgPZQvivTOdy2eoO8+jI5qJdxU3zxBdhYPbmM3ZJ2+mKbVMV?=
 =?us-ascii?Q?Aga2BWr8qYqOBj1nMduna1av0u7zSlFvBRx8SBJDBj3361OARrOs+mzg+5Hd?=
 =?us-ascii?Q?eHKFUQKxCX1vXgNM7dxQoNkYeJGxlDnX8KCw2ulWSJMWbmnNpkCcJQLPZueb?=
 =?us-ascii?Q?6bTo76BkFEOFbY/hfqErwwqDS8Yqj0uoQIfkS8/gaTdXw3D492+NoPfk0KnG?=
 =?us-ascii?Q?Kv8QmglzrLDP7aDumAaER8hOkoGZ0syOHmHUuh3FU8+Qiw3r0A5IWDM1pazK?=
 =?us-ascii?Q?5f/yVnhjCgbK5el8vhBXDuDrv/k0Hesc3Ha5FG33QU3YWnUuYzhT0bNZ+599?=
 =?us-ascii?Q?dNkE92VFmHEKcOI53hJGfRY1CjJdxBrqY42tXXLccptESINB5I3+SJj95FBP?=
 =?us-ascii?Q?QrS/bE46o2Ajde63KZQ16NFecRV+YySivcmZM9C25dd+33Qt7mJYanXAqi+7?=
 =?us-ascii?Q?VGwflL+tWb387zlOM6v/QvQomhFnkVmmWRlFhq/qJhi3F8ag/RiR5cDPeWbG?=
 =?us-ascii?Q?s6OmyIDYX6Xf/yjN0yf+T1kSF3aR6ADEKQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec648731-17b9-4cc6-4f4a-08d8c771f2ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 11:59:08.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKWljtJrlhRfrMTSJMBDSYz7SZx7z/JQ36yEmmeIbdI3BDMETGd7ASzOYtNELAEirFvaG8oQjUPJjI8FRYlXWsHyJieQ3uTPRlFf7q2PbyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4864
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
