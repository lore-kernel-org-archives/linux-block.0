Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15684C47089
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 01:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31E7613B4
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 01:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhE1BoC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 21:44:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50845 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhE1BoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 21:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622166149; x=1653702149;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=juQ+rZgFAPbvVImUJayK6jiuYs53lCNrFV9D/OO/6aQ=;
  b=ceCUrCl4Bx81W4X+QoaQHtgcQGveKm6+CGuZOzsUqKjr9Fjk7DAeKIdR
   IPk0TkcZSOormsUyRCoDs7CbaJa7yr99zsWEcPwqtAVrgP+mTaqyLoXRa
   Kg2jUNkpXjmdg1/cDuApaz+yjV+dqTYBpFba3Dui8feLcO716nuIZ2NNw
   S1YNvg96tcLUJEoY+pbx2SnAM6NpdzAcnefWnd3Sbk2ang/5CWhS/ciTE
   zJEvX+WkEI5ZThGlazdy119ss5A9kPWL5fOok3hla4RPa2oE2HCr8q7jC
   Uy62hfl5yVslfR+dYJfjfA2geBvitSitrUtXACJsTtOC/sO/OK2yf66L2
   Q==;
IronPort-SDR: NnuaaSC0pRbyAdQuw4DucZjRf2Lt3rceGZtNe3AJ5uOzuEu4A7bSv1f5jTGrD31qBRs6ffy6tN
 CywMFRiaLmAVr5sUqFyqVE9IOwH66nLeSL4v8NysF3MPsDygTjQ9bIyQIMI1xv4eXPVYfsT+qF
 IyucrQbGD8kd+ZgnsRXTSCQlkrhXhsYlU0WJfA5HxSxLFdgO52QMsk/3AnXB4uDzJbj91OdQFh
 fWK5zjCd4ahA02oRaLTeSRPKIEJGn66OnFahcqtYOJgB+oQNQ8NgtLzCB1UjeT7CW1gl/l96Y1
 Uhw=
X-IronPort-AV: E=Sophos;i="5.83,228,1616428800"; 
   d="scan'208";a="170275814"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2021 09:42:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBzHz2lpljPJx2ewB8JhMcivqnU5XuYQVVjRytf4AntW1zx0gq/u/SRFMLxYsa8lY/Qyp3QGRxEGL16oOGMSBV/zJ1shsWSUe8kEqNd2mAQMdT6qyMShdt8syx78IH0uwxmW9QYz9FC1RKl5QjiwLbku19fmIOCKA1REG8jOpaG3njk3FDZWaaHz57d1DoBNhkt9ctv/0bk/PLLBCKSXvuzTA9ivUdeg+KG/4PuE0GlD3W7+m6jjOiXqYzmbUFZSVlUY7k7Ozvq8zoTjICJtWRNd0UaYQx0YxdMTHMzEb8bBA4YNyrUj6SIRrpiW4dYZ0jsSirLpUo9BTHxu2g16sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsknEWKvA/EemiveItTAU/CWKavKCR8vB1m07IAfxs4=;
 b=Ug225PIu8MDYtaCL4zRDoxXi3+7BefeJ525jGRw4sVeN/PPySjKdFhyHGRdqH8e+r/tLdilwPkpDSwyuzT6ne4xB37kqaYbSQxFEYtv+Hn+VlhhtMBg+Gn1wrUEHoDos6YNb3JfKUN9FEYZDp6sbempnT6e4wWsWt8a0wCLuk8lZSDSadathb00eR0PBLeuO2cFPiOtVvLhgCanghgcydd/U0pJO93gTfox7awFK0heIjxKbk6y6mw5X9Kdpue9jgdJIH+GWLWnHuU3VOUj+u+g33ga6Dx5ViPlA6T9F1GrYRrJzzMiiZW9fODIOQZHLelZd32pbV4E8U+uI6/0MOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsknEWKvA/EemiveItTAU/CWKavKCR8vB1m07IAfxs4=;
 b=eR2vXoY1B/BFoSRb0EC7ocGdLaLkktf7hVPPYMe1uJSmY8Z8fLhO5uDd9BZNNvGde05bzQCbh0hmih1lG8Hd5wrYreXPe6IvDbANlyqF/ZvdG053VhxKvVNFBvD48x1FIkUK+HGLHS/3F9nZ0Da9C/e/unDAtsEEljV9Rf+4AkA=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6940.namprd04.prod.outlook.com (2603:10b6:5:241::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 01:42:26 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Fri, 28 May 2021
 01:42:26 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 5/9] block/mq-deadline: Improve compile-time argument
 checking
Thread-Topic: [PATCH 5/9] block/mq-deadline: Improve compile-time argument
 checking
Thread-Index: AQHXUpPnRe2tZsOQw0aU6HOrY5bcLg==
Date:   Fri, 28 May 2021 01:42:26 +0000
Message-ID: <DM6PR04MB70810CBE8C005970F71A8843E7229@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-6-bvanassche@acm.org>
 <DM6PR04MB70810C07E70C25EF512B4A45E7239@DM6PR04MB7081.namprd04.prod.outlook.com>
 <c7f41b26-997b-45a1-55fe-629f9613b12b@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:4140:5e35:28b2:297]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20bd51e5-e7b7-4f38-a970-08d92179d933
x-ms-traffictypediagnostic: DM6PR04MB6940:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB694036BFB76054C4F9BB761EE7229@DM6PR04MB6940.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bYv2CaKiqez5hRBm4STBOnvwhgJbjtxL6j8WCV3JWEeKCwSUxWJrD6sx2QTCjdk3tRieCznyJaFlb/zvNKCuPBjqlCknRSKf2WNcdR6I4ord6+btn1NOQgDAV7mSOPBeSt2ycXT1XoAikUjx9DXTkJmubOYD63uaj9IhLTyk4yY+s8WlS/LmHo+9csPsxs5jpv9e5Vas2FKXO4jmKrhZm5um4J+5jRbY+EG4L9O0G+XWIq2X/4BJT5Z+T450qypHfavqv8FXx9++B5OHuAv7sEDM2WF79wXewwr4SknhynHlF08tCElwHK1LT0Xdk8g3r1P+QUhzS47eqmkAfAxNyVA4hIiCpyIPNd9JcVS068rn4UlNNh5IZxpl9dFB9kigedR3uLgScPey1M8WEpwOAZ8/HRXrx5octMhb0ZuLxuaMwO/HTYQv00Ukc2gPCSrMITkV5myV16d/aImN5WeARCV5Cs00VcpDJ+wrDxpTW8xWEpbyxqyLrWqnm7v1ZRQQdgpMWw30sjmM7ETpeNKfpfHlmidHKPkuElcEd6KgOKsv3kQP2V4uE6f2d0bNs9VgtMdBrrDp7Ajk5cWYlmJhvYr9GJvgQ0kGTMuIgR86q8k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(53546011)(186003)(4326008)(478600001)(6506007)(8936002)(7696005)(8676002)(55016002)(122000001)(54906003)(110136005)(38100700002)(316002)(71200400001)(66476007)(5660300002)(52536014)(64756008)(86362001)(76116006)(91956017)(66556008)(33656002)(66946007)(66446008)(9686003)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NxA3RDz56rxgrKetdREcQ1JmgVIiK2Dy3aqV2htPxUQB7asF/KT8cvvsWHiF?=
 =?us-ascii?Q?VvAvMVqo7WNCUbhPbS84JRZLFFh473k3nVBS8Bsx7DVOljDsrDu2IzG2MOmj?=
 =?us-ascii?Q?alWWbcZlWuUJOOarvf3+/LkHYiQ16X6M5pooPHFIMalzEKgIv8m6PXSr1Chz?=
 =?us-ascii?Q?+Y/Nvs5srAigAT1aFRE2xA4SrLHIhf4kZOf4nBs5yIGemYeP4QmYj6Gu23RA?=
 =?us-ascii?Q?iWWOKfiwH2iOlcFNIqTGixOCU3vFFBwW1imL7jaRlerTYyIFOvWfC+lDgJmC?=
 =?us-ascii?Q?Bs9iVBdZgBrdY/zCGhrPhYXOAHMpHRgzZoy+7MQai3qswtvZx3JyKmkaUk4E?=
 =?us-ascii?Q?i+WmXMm25f3SmC5nhOYvdIOR3MVxyCu3r9rOcYY585SCQY4TyFmpQ7Zl/zWI?=
 =?us-ascii?Q?Ec30xbiSKJslh4Pb1JcfKuUD8FiClqFshUntmocEkjyxIXI3gohaZ9BXcuRH?=
 =?us-ascii?Q?ZEfVPCuTyiTlb9qK4H33x/TXBt5TRoI9ekZbu5OKtw7JDW01WaaQXAuwJJ6p?=
 =?us-ascii?Q?7W7cVbUlaTkrCA2Fgy3LrMmQwdx3lnA3taoxUstIh7PRFQ/P85GJeAFfE+8X?=
 =?us-ascii?Q?Kz1gDmDlnxXqTlr639dPZQ4jB9IPef1FErlVC+s7u8kdhYC1HZPCqpZ8248W?=
 =?us-ascii?Q?QBxFcL/YP9seXW2FDGmXf6Ek/0texdevJTIdGMBsafeeQSnnSwooMEJsaUk9?=
 =?us-ascii?Q?3QFtQQ0jywgyES3p/Cmx3jKn+2h1M4FlpXhgLl41gtyE/rwmE+clNgyLSt9o?=
 =?us-ascii?Q?rtAo2H9CZ8P1MPQlYgJR9qxRgK4ifUSAUxTf/IBPCJ4cHVVejvU18m8OngeZ?=
 =?us-ascii?Q?i2D2jQD5KFTSU7IhdUAtc1UGgOV7z5SqN5cCl34c8GcCKIn+udtrx4sh//DT?=
 =?us-ascii?Q?Dwc+l24azC3DNa+6ZrKuJWL2M3wNeEqshCTzgXEfKh00np+a39fiWz07V59Y?=
 =?us-ascii?Q?DVMou958C6E1E9SShpJ94sfBufqg48Mz1V1rM5gCks5L7K6UHdOn6PgUHyfz?=
 =?us-ascii?Q?oZ2xw5nYAQl6+/ZzxyhBieSvzS8bXVuGqJwxQ6AE5XN250eBpREUsBEUZ1uv?=
 =?us-ascii?Q?ZIdGctv7X5Bm0my6EGSWf7KTtYy5hi3m49iwreo5jvi9nAgmNNf20NHja/wc?=
 =?us-ascii?Q?lJKQahcEg3Z8Pfg05N6DGAywgQE3P+th+yy+NgmVLHFVWFaqZNyVBPIqcwEg?=
 =?us-ascii?Q?hHrQPsH5fHx0ggOmKA3iAY7z0YvxgXPwRov76oxGvxh6RSwtgTfaVYwUdpul?=
 =?us-ascii?Q?eqWbkMGPYXKmdwB2QEFfKCScsmqsRJwFmItGJ7u0LM00+93LGMNJqw0s1sus?=
 =?us-ascii?Q?40hjsmJ9I8FosPc2TsEXAxTzx8yMFYB2t1jsvzeDd2kmlz5raZuFJDb+WiKB?=
 =?us-ascii?Q?YMyj9c0JLINxcFoBOh68oQRbKL6iwnCYWe60IIdY/hUzw3NxyA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bd51e5-e7b7-4f38-a970-08d92179d933
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 01:42:26.7700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LdNez5kO1BSnL9ZMaOuj6twa61ZJD/tuSSo8f57RYfaEVuegwRI1xW/xtuc+CmfA/+iyScDI/I5vjKq3lO44zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6940
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/28 4:38, Bart Van Assche wrote:=0A=
> On 5/26/21 8:24 PM, Damien Le Moal wrote:=0A=
>> On 2021/05/27 10:02, Bart Van Assche wrote:=0A=
>>> +enum dd_data_dir {=0A=
>>> +	DD_READ		=3D READ,=0A=
>>> +	DD_WRITE	=3D WRITE,=0A=
>>> +} __packed;=0A=
>>=0A=
>> Why the "__packed" here ?=0A=
> =0A=
> I agree that using __packed here does not have any advantage. I will=0A=
> leave it out.=0A=
> =0A=
>>> +=0A=
>>> +enum { DD_DIR_COUNT =3D 2 };=0A=
>>=0A=
>> Why not a simple #define for this one ?=0A=
> =0A=
> I only use the C preprocessor if there is no other solution. As far as I=
=0A=
> know there are no rules in the kernel coding style guidelines with=0A=
> regard whether to use a #define or an enum to define a constant?=0A=
=0A=
It is fine as is. I just find it a little too verbose compared to a simple =
macro=0A=
definition. Just a matter of taste I guess :)=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
