Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C695C48BCD
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 00:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A70A613EC
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 00:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhFJAdB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 20:33:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15776 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJAdB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 20:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623285114; x=1654821114;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0GwzGL18A4GpLOEvehZoK65RCAZGrjEOuBwQeT7ZlO4=;
  b=I7a71eo+1nOSZvRCfcqX/r5ojTHcYKFOwnPTdLYAbN2G2Cw/dpmo2Ued
   zGqhD7MxbIubVZdRTlD0GdGqJQeLJkl10+dWDLvSvZ6jlcMA4HdRyfpx+
   IJViR0pCVty0Sw8h8tPIY2YMpsGNtTWlvCh9w8DLguJR5cBlperXYNoqz
   ytSK5rUIvRobcJ1b4p8GOHW6A/OJLCUYVYO4N5B4Za6Aj2o3bHJEHdNDO
   qcGs4uAggJaPF08iLdGDy/MPRj0ZubghtGkBEaKoYOGjBIgakR3LnJuIL
   C1uRx5yMNutQvJiKS7lAZ8bmZdzlMLBODiXhAKZsYXQp5h6dOVAx8KBBF
   Q==;
IronPort-SDR: mlZBx3duf7GHxaNB80e48bSeaBXEh9JeKhhoNqTuEEoIKqoW7+jb8cFuXSVuRKBusgYEQcPJer
 A2dO7mP0M3VAv3II98Mm0WQttt+ArdJq+vbQ7ycNn10LnXaY4KQVNaXR8MUz3SyaN6jPzx6c+f
 ZumrlKtInp5Xa9jwC0h7Qqe8BQom2p1rIzqesTNWz1yceBOO35KgcM9sPDUja1L3+Jpor9iMTr
 pgu7e847b3H3vepq08l4BhtA55XkQCs9at3xTBrjIo8iYW2Bp/jShgnYyQk20CN+ZXSe0/FVKI
 kiY=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="275187158"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 08:31:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuD6RDiv6I7Pz3Qsd4Hjkodk4XMTD7ZkkOwVC7qVd/yH75FwW361J+2FLIIFCfRkBTzNw35DyWzqtCcN5tbRQvAr4xU2JjvOPIh+bKGGp0XmzRuPOcWtyWQ00L5hhxoPQqADYREDWKa2mVxURIMlvPxM4OhoIlzD3K6Q2fAF1wg+TIBhaLmGqoRWjGxyS6BlsE7VEsq7Pibqi+qxVPGImxjUyr62f5RGPdJIZCbk8fWM3xWRVSHEOBqogXcxJThjUKiVtArzghWQL5/o3lrmXvEWBvgSaC2sC0Qr4WQjhXAaBfCr45kpV8MvnXvaBaTEEx7aliMo/UgwgKxkqtsqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdNNOTsWcHG9zA+dzZ71dA1gpt4Zj2BCpxBRIUUV1kQ=;
 b=Vlt9d79guMn515MssdrADH/MIn0eQoEeaMDQMS3Vg5/jBriRY4I2z8wCYPt0tYu1Rdigcx2lYIPC0C9n3o/3PWCx+7vFuHR4htHAq7ixGHrDO4gnFIh0gYZjz5FrR80bEuXjgoBYUa/XjHQyWTosFOOcDvSjCsM3MGVgKbNTsuPmW4JZ7WrEEGNs+yILUJ9pKb1CGuprPpnEWA6wakX+B9talaZFE6LV0q5a3Kdj02pmYSyS8CowwWpuxSCHhRKB8cCOXTJrbPt7iqnkT6joA2IN5XjarCcgfZvx6gil5mc5NPWXTw65kci9Spi+B0vVF12Q/1IHAyvmSLukz4GtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdNNOTsWcHG9zA+dzZ71dA1gpt4Zj2BCpxBRIUUV1kQ=;
 b=s6UtxFdBpG6HOVNGkUalBR8i8ki/yd0jVSTvUQwXcjJ5IMBWIyxzS95X09J36XlFDESgPiJx9WPuIcm4EWXH23njxLUugCjIIQLsqugfY1Nw6ebU3xknZ123RGKs8pvqT8CY2jPN9s/Uee6p1vajKTb9xjHT1vdupgHWbqGbqqI=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5100.namprd04.prod.outlook.com (2603:10b6:5:16::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Thu, 10 Jun
 2021 00:31:03 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 00:31:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 10/14] block/mq-deadline: Improve the sysfs show and store
 macros
Thread-Topic: [PATCH 10/14] block/mq-deadline: Improve the sysfs show and
 store macros
Thread-Index: AQHXXLsU2GDeuvY6R0ez1NAOsbFOwg==
Date:   Thu, 10 Jun 2021 00:31:03 +0000
Message-ID: <DM6PR04MB7081640D3A83F3621E94433DE7359@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-11-bvanassche@acm.org>
 <DM6PR04MB7081916EE79D419357373085E7369@DM6PR04MB7081.namprd04.prod.outlook.com>
 <8547812b-c8b5-93c1-0189-f8ce4c01ff99@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5d2fc42-033a-475a-aa14-08d92ba7078b
x-ms-traffictypediagnostic: DM6PR04MB5100:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB5100E74BFB448D84A0F3FDBDE7359@DM6PR04MB5100.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hEGuDVQdDs4pjMay+w1doB9ybXRlI9jXHBhWy8OyRDz5ZExGXvZtCroU5jpUYbCw2jl5stAKjjPxdbAeokOGC53TlfRc2RDafmWxIWV5LE2Iuqw7Lv1cb+CPF3pSNtPkS8+dFmZQdor1Y4nPtde8wChVz4ol6UB1H+BoG6gSl8GJrgfSSf7ga+6wthqRqzsdQJxdEyTYXaNbOhefr2Co2EDswsHt2O+eFtyx4m6J0tSJwgfjCPQV9Nuw40Zi15fMM6UPHX/Ff3jQHpQKbjyCLBLtyHEs0GgStjbUMwuCimbjRaHumdCHAlWy2zXZRzkKhlAyu1fh5Rs2UC4E5I2ikmEJUDlKCS23iMDzvJbIhqL0GVkkleGQ5KiGJu7iiiwX1NA3MiP9PVrY6S3l8Okz9z09dP/HoelPvnVdO2IwTklZ0FcpCIArytmmrW8bTHncgxtZ+hxu1iB4sCwB1vcLMY0WNsZkkTzXrkgI+EcsvI7kGFZxnWqqtNTxvhHktoyEwpPobu50YF7fcEj5R1+6N6XIzmOz7VXkrgcBwUjmoLOb7zgMFRMljp6Yk6yOOdLi2YyRmJALBjbooasb2DFM2ussSFjKBUcgE3kYNuMY0pI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(5660300002)(8676002)(8936002)(6506007)(9686003)(33656002)(122000001)(55016002)(54906003)(316002)(76116006)(4326008)(66946007)(66476007)(110136005)(64756008)(478600001)(2906002)(66446008)(52536014)(71200400001)(7696005)(186003)(26005)(53546011)(38100700002)(91956017)(83380400001)(86362001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O9EJWPK0R0w/1BtEIB53v2USMfg4JBmJ8V+MkriNDswVtTzJ4r9Qi/kV8l1s?=
 =?us-ascii?Q?65TQBkU5LzXcEQHK+jTSRZOO34XuNnOKpeiuZ6PWCV8/35ZLOMZ2TMhWmb3F?=
 =?us-ascii?Q?IEfm426Mv1l6IRhhAj4cjZAQlN5RTAgz2qDXXnXRuhe3p3CCNd8IHdldwLJ+?=
 =?us-ascii?Q?kC4oMShEU9rh1K5bK7li3cPm1cMPtfIiyoWUMbPIRpZpsBFV6lrMk7vkLe+1?=
 =?us-ascii?Q?8cwRqIFkLulxupfFcjtLWAXblOQOVX4JG8YKqG3dQ1NCibh96QfV16OQ/GEN?=
 =?us-ascii?Q?gCyZvvM6cPbjHjw2hyK4KmYemHTN8C07vL6DnFq+cvutBjxThMku93AdvxIg?=
 =?us-ascii?Q?I7uAXEpVyQ9HXjVvu4nFyhAGZUP1SiGls8qJVfewC24X/yDT2X0TPGcXLznE?=
 =?us-ascii?Q?ChEqYeQ570ME/LOFUOrg8uJL/A4rlHa8d9zTcft8Azt5BH8IbqJqlGtYi4Al?=
 =?us-ascii?Q?exmfJM6oeArVVPeqloUMObReM2+r3ptPWUX767YuIpH91XkFuwo7Wbh09ua4?=
 =?us-ascii?Q?bI/L3VFkQx6zFBeHCAKwMgrl7bGoF140ul/MlBd7B5DGv/0Dvkhkhg6pbim+?=
 =?us-ascii?Q?Q0msCT5mWhTk9vQ/NYCP2DY4XHmVfz+LxCKpWaxRfuxt8revqMSRUvJNXl4F?=
 =?us-ascii?Q?/rnPFs0y2mYID1QeZxBjRYCM5IXWHj/SY6ibTTua1GNdi0nSsb7j5F2MFl48?=
 =?us-ascii?Q?QrOsU21GRYTLc55D2YQcytwoMe/NnxWo9JxHBV+gke+RnI2IGLSCP9ArZmx2?=
 =?us-ascii?Q?yuYuadfxGhr3/1gSZ2klbtAQGtlFrvHsPTfmIq2DZvCCtJv63h86TfCPwv23?=
 =?us-ascii?Q?pRPZViOwj0VZhO1RTutSodZ/PgNwQGWXJ2iABx3nGrgfshSpm5x1iiG1R9kW?=
 =?us-ascii?Q?G+UuDluJWBcpqyn4kUOOwKFKVHbzva5k+SGrn4glgcqW1LRtqp5qFUV81gaR?=
 =?us-ascii?Q?5/2m5GbA+bGKYejuLw9pLbZFfL5Ln+dERe2bJH1wozHaifK1g3a1nJ0756lw?=
 =?us-ascii?Q?UtopHgr9aB/GqLKtOHHSO2bshyNvyRBzgPhaqYykMe9rBnFzUx9YUJQEgArz?=
 =?us-ascii?Q?cBJOH60CN173oOCaO991ovhd3ESDMfYcUMbKxAH+NoLPruxRbem6ijNmX4nK?=
 =?us-ascii?Q?oztS20WCCkyUyvU01ceu7i38NxPdKuTOL8FegoXONccwgjsvnN4iiamE+Aax?=
 =?us-ascii?Q?g8XNjcQTTh3KX4j8b3SORc85hTGnvTG1V6s6fKnqA9qqfOWB7LeIIz3ROWVN?=
 =?us-ascii?Q?ccH8V2jhZkwy2Zblw8Mk8Mi3MWBWbV2jvcnsD+LjpGgotbJEjpjSjMbkUxnZ?=
 =?us-ascii?Q?KA8EjCh3++KBOnEQdR/rFNc9uny1oX7AtpmjiInsYMvDUw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d2fc42-033a-475a-aa14-08d92ba7078b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 00:31:03.4577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsFZWOI9tcACRiQpcdBIoNpK/zp45IyOhK5byCJOP2bG156s52DgmfMhJkai2rTPtlD5ZRP+tg/wfco13N6Icg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5100
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/10 1:54, Bart Van Assche wrote:=0A=
> On 6/8/21 9:46 PM, Damien Le Moal wrote:=0A=
>> On 2021/06/09 8:07, Bart Van Assche wrote:=0A=
>>> +#define SHOW_INT(__FUNC, __VAR)						\=0A=
>>>  static ssize_t __FUNC(struct elevator_queue *e, char *page)		\=0A=
>>>  {									\=0A=
>>>  	struct deadline_data *dd =3D e->elevator_data;			\=0A=
>>> -	int __data =3D __VAR;						\=0A=
>>> -	if (__CONV)							\=0A=
>>> -		__data =3D jiffies_to_msecs(__data);			\=0A=
>>> -	return deadline_var_show(__data, (page));			\=0A=
>>> -}=0A=
>>> -SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[DD_READ], 1);=
=0A=
>>> -SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[DD_WRITE], 1=
);=0A=
>>> -SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);=0A=
>>> -SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);=0A=
>>> -SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);=0A=
>>> -#undef SHOW_FUNCTION=0A=
>>> +									\=0A=
>>> +	return sysfs_emit((page), "%d\n", __VAR);			\=0A=
>>> +}=0A=
>>> +#define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(=
__VAR))=0A=
>>=0A=
>> jiffies_to_msecs() returns an unsigned int but sysfs_emit() in SHOW_INT(=
) uses a=0A=
>> %d format. That will cause problems, no ?=0A=
> =0A=
> The corresponding store functions restrict values that represent a time=
=0A=
> in jiffies to the interval [0, INT_MAX] milliseconds so I think that=0A=
> using %d to format a time in milliseconds is fine.=0A=
=0A=
Missed that part :) OK then.=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
