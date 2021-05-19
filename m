Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B839CC433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B20611C2
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhESHuc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 03:50:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42570 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbhESHub (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 03:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621410552; x=1652946552;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=ZttbTuElFC4yKC1bMEHlfTj+RAnVb5T21cseNShey2Pmzt4vXeJB6lEQ
   yVJoppG/5VMqsH72kiTG3YMR1/8cAXEfL1c7QzgkC1UagPKlFNkzkGZwE
   Mq6SZ9F4zAl71ZWuXYcS8B0y9mYcV3Ue8ahmG+7A9MfpvD19M7YazrmbL
   GLc9Qjn9e89KMw00Bn8bG3gMSAzF3LoioJneknkNxGxMSIvLIoMwOMlkx
   3D7DTqxOEzm8aQvpIymBP7OVI3gugAL9H8xxAFWtnNAVWJWGlaBbJteuN
   pagmp+FHTvSJTRo2t+NanSvZjcZi7/6nBmCWyEhX6ojIZ7JHlwB2jlS0E
   g==;
IronPort-SDR: U1V/dFF6sdnYgBnpsXIlnt5xr5HEOU0aMn7xR2i44W0nii6LiUCSE147rg73vkDi7eQIsB+gjd
 M1hd97QUG7zJyc3CXLvHym+sCPO3hYhdAm4/cuvNmnljgILnqDcT6FzLYiatKvnWE2+DcCOH36
 zxPNU6E6n6t/lZpoaGEApnAMhfg4LdhoPpcjeFKW+8b/OAQLCWwOo5Y519ComF0SeLQMKmoapY
 1RXZEbXZODu0oucjtApae/AgWNMw+C4cUx8edlPqymCWm2+YDbKLDEil55+67F/JmCoECjMaFo
 yJw=
X-IronPort-AV: E=Sophos;i="5.82,312,1613404800"; 
   d="scan'208";a="167979349"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 15:49:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1ES4uoHE8o7JhC/amgfWU10no1LwBOouUzSvk6I7a15eGZi4G4onAsN35HRycEowSZwUKkeetGvsWwr6LIZcerF6b2Dxpc6ZAkGGBdnH6FV/2RJ9VMFN/6NikxKzQq+zNuDNOVcmx2PYEvfXfw9xJxpvirU8yQNdLo7XNYsp1RsR4vrbmw4tdJzm2NdvcSHNl49oD6V3qqMcB3eXB3nqAW8ynII7P1KOuOSPK8/y5j7Am4Q3/C0OXt0QXq0WQ0gXe70U8ff9aR7i0fROhjBbry8oETwVsIBITlz49vr6CB3xLqGPNz48tOl9nxNhtHAzQCUgjYZ+skY7APsHJZe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=RgHTvFfuYCErmeisv6Bj3fIU7NVl4s6MkWZRB+GSFuNMGepiLQXGeIq/OeqcViGxg+4LcvoOV3ZVd5AdXrTU8I6oVyRklRUZ5uBq+KD5iG0viYvXZNBy9IlJ6QnNSFV83rjGY3ZGc6pKala7fa/MFXOw8soh7SGxMO/LVL4BG+lEiSRSwym9q+pjhvXUGjCfPzcYOAIeItG5X4WyERveihciLzZJZiBQf2YIHdvUNWqc+J/z8y/3SXBd37GFc2EaJ6svy0u7w+kJ2Xp8i10LTwveDpCTLzxy2ampg6meJac+dUIa2Ciw1rJg76MG+4tVKLpHsIe253bCqWd8uzU6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=NMf4JzeLhV4a7Lq77alyr5dplR1UANQUFr0FT3ib7VYqp/BoHGe/gpDNZIjC/9eSq1Rom2DiN5RfIIw/mZvn0HNoig11JTC3tcoGUNbDamMqZllQ3NiZTnAX/IYC1oV+2SKPrFkECb1rJBPeIN8wCg8ZqKKI0OKd/1j2VD1SYUA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7142.namprd04.prod.outlook.com (2603:10b6:510:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 07:49:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 07:49:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 07/11] dm: Introduce dm_report_zones()
Thread-Topic: [PATCH 07/11] dm: Introduce dm_report_zones()
Thread-Index: AQHXTFp3R26QKya2S0yqO6KcCDwllQ==
Date:   Wed, 19 May 2021 07:49:09 +0000
Message-ID: <PH0PR04MB7416A5E5DE88C39F66FCD3689B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-8-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:95b:718f:422f:1ec2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b28d42bf-d97e-4f7a-65b9-08d91a9a9676
x-ms-traffictypediagnostic: PH0PR04MB7142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7142961E3359957127DD67659B2B9@PH0PR04MB7142.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: plvZ3txuHTUQjS1UVz/B8+bz3YM3qB8PzA0RDoYHUw0Fm75V7O5er7p395C3oQU4KiM7vv2vlowXn6QiWSkAq6mu8p4/4qoQwzIs3qJKX4ZoVXQftjZLttJ0oGKyIeENKMdda5UWMNoGh5IGIy7grrww/Py4K3fbMTl6jfufaFa4AZRxScjh6ac6bHLo+QBUZRUMY8Us/YlFfDJ6Pju/NxbiTo4u8tOhS3LGI5kk0BIKVSwRuWxnfHkpnVhLRlHHUtHRWbO69Z8FSCnadAftZo8S/TCwBtaDMu64UUa7RrKl+5vbwv6JlhfpDNZAj3qBlIiKmtBSqAdQXz7XcQDZ9dedwNx9MhxdSEBfCTqbahW2bEgfCj0Y9IHsTh1qz8FvoKJfuvaEHhyW4ctDRQnuVdyZ/wAdenb+o9el76xcw4r2V/FY/nPqF2f7haa5/pl3ujNhCK9XThpnhVPOBbBYZrwVW+rEbyCGVDNm/K5oCIriJk76CBNW8Bj5gYiws3tZaV9lZiAxkxz1hKhL6ZrUonxn87M1z0QBwhzOEY+9grOzX4uiHh0G6fshGNd6QgDdKaWeUJTR6uzEyPBrYC1oCwHWL4IrXEI4x2N1ZBLPFqA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39850400004)(136003)(346002)(366004)(122000001)(8936002)(19618925003)(558084003)(52536014)(38100700002)(6506007)(110136005)(8676002)(86362001)(316002)(71200400001)(33656002)(478600001)(55016002)(7696005)(2906002)(9686003)(4270600006)(5660300002)(66476007)(66556008)(76116006)(186003)(66946007)(66446008)(64756008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zGSMPtd3ubFiVD/WZrnc5vKu0Ln5oVlTa2RZSCKExNPnQscPfXztRr3M6z1W?=
 =?us-ascii?Q?ykfHP62rpyDSHQZGTx8algotT7/GzBtk7kaKNHHmcM+qRueFs/l2YPVOixES?=
 =?us-ascii?Q?vTRY4Bnw8Op+mcqhrS2knv+3xlCq0ikRLkzLzXvFEchdN1O/PmZOMNJfrzfu?=
 =?us-ascii?Q?USZCjuIg3tz+SmviJoO0bZ6bnJHVpu9/+2xzk5Vo4CmuSaciuWWYH4hZJjY4?=
 =?us-ascii?Q?Yn5wa6M3rfmWnxWW58VNRltoIjbddEm7FLhXJwNrxpCLQgd/3wSyD7rlLisY?=
 =?us-ascii?Q?Hk1fKe0cw4HuhaWIFJjwBLLTcxCeusgaBtyELMXeE8kxn7sMODDe0rm4Jq8R?=
 =?us-ascii?Q?Eqle/uGrGjDJv/XyYjFjwYyTK8CJzjFEGVxktLZ1tpCcRagI0t0+lVt+QQXg?=
 =?us-ascii?Q?npJcf2Pe4sSlx7V/QlGC52ocd+qPQunpfkGBw3FgzE+XsT1jK2vScmTX9TjM?=
 =?us-ascii?Q?/9OI250cs9bZ61e70wVD33+MS1waUF4bU+V5mHszjzjlN//uiiySb/UaoAEk?=
 =?us-ascii?Q?61bpPT/b7kANH5QlxuHyuxJwLrdJflQSNr+W0QeXa6V2ONA0x7Yon1VVgMKB?=
 =?us-ascii?Q?r5hWty2agy9Tq63Yp4Rmea8AVKI2tUirxi+VnTMlkSZq5o0RzwNbDH0Kecnp?=
 =?us-ascii?Q?G5ADXGOGjp6IHVu63+dKzYd2igkVMOlZiX3wC396ecc0KfV5gsQwK87yt2r0?=
 =?us-ascii?Q?NjBYsCeW7uQw5IbGYH8UKRWU6RYUJDxLdTFs7cFeNqEgPBxM0XYKFbEPXexB?=
 =?us-ascii?Q?6a5+Ot08woZ/O5t0M4hM4ztlXRLJ3VnL5TUvsaPK3ngS5bhhuZwJ6WYyUap1?=
 =?us-ascii?Q?GrsiQz0E51sVoPcOYhdq0OVo1mGZgzZEXM8ebVELtdNAxU4FAXyCmh7ZbNs6?=
 =?us-ascii?Q?dEPr1DkAzQPaUirFYO2LPjJNiu2upIYpZUJ9xhm2R+v8lqjk87UgtmZgh43p?=
 =?us-ascii?Q?GKbTWyj7RbH7/3oBc33M6lcmZjPy+so1S6jbL/OQEcH58yLwgn9EAC09HLNA?=
 =?us-ascii?Q?CNXmXk/LmwdR+x/8lhJEFWiC8r7YhGKuCiVucwEORnQW/adrLb+HyQPNLwAZ?=
 =?us-ascii?Q?Wyh3xLHKyfIjkfOyChgcWxpdCTsYk0GhJkQT2MWhLfIfuSSS/fuehoOyKlCw?=
 =?us-ascii?Q?D/t3PY5DwM2zYTOYUkF6Jj8YXCaD2MJBQTInXe/QABkcPceVRAZtdFkkQffE?=
 =?us-ascii?Q?uull7sa2TcBp2VJ6HQWXow88OR/9n7HHXZ/D1UiX8NGw6+pESGgaTyO0VDfq?=
 =?us-ascii?Q?nKYE3RdzVTRka89CURFs2sKJi4fnbhMt9V1PY2VRup2iQ1YZZ9j5rYhpvNLK?=
 =?us-ascii?Q?bX5p6RylxmStfV8nf7PuoI+dlfpFV9Y00/WrEVNUZNcH5M4uT4KFmyY50016?=
 =?us-ascii?Q?h6ps2O8WH58+1UNo98VFd1CKAeeO9a582C+C+er7L0Lc3KvKlQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28d42bf-d97e-4f7a-65b9-08d91a9a9676
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 07:49:09.9510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adWBpLN89lq68FQscI6ARgZrQwb7Szfs+wWZtZOjzOdH+Wu3wKjUXvastZGs6JQtMrfAz/d8jmwudE61gqSI4FrNYNhbseCi/moJhiVuZDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7142
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
