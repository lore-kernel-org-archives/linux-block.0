Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DD6C25B4E
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 16:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjAXQDy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 11:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjAXQDw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 11:03:52 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021014.outbound.protection.outlook.com [52.101.57.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F6470B4
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 08:03:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD55TQ2nedESBGMVdGGnGOXwzq7yws+3guUag2uR1PQCDfIm8WFlA0q1sGtDFh9asNJeJ7YIEZMqssnbzJhXyJG4wEYaTwRjR8+3yZy+wg3ohkGa6nyNNur6IafP9kLeTAMHPUapyvIMgTWuc4nsmO4PuWt5X7o8ykVWpp8LvogUUs9uIOaI3yUvPRUpWv7g6nm30OMZqD8OAy1ORJgkV3UPGL9QUnH2BLUtlA1RS9niJvrmqGOf3TZpUnh7JmLiCS1Wxkl5OL1atTnRPY9pzaMR763Q8z7d/Ga7SW7O4c2mfoMF+VmL2ymLRkRKYzO+hJDMnKg+sVwrGe/LludVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mll6zCJ5Tb2rVKlM22C02E5AyQVwggJDA0p11S87WHc=;
 b=bzdzq9EX8V9kngNV14CRr5sQlVJNhI3Q72jX9BrttNYtD2TZQCUETXsljD8H5amF8r5ZbC1J2GWOWZdOUy7QfHCVkIsXgnXhm6pnlgSnXEwuxvcd29qMgkRZ1kPIa0bOOByewcp84ghHYYGU6qzR9hEuGEojX5Dquh4Ij4bM13+uGJ53K1dO3uDG7PlxhBKShtdYc874GzZAriGfABAFq4srfoBzH53knZLI6Z1SNHD82fFLlYjPfgwp/fcUenKQbCdp2GcF90A/k75FCGwcPEkHcSo2Mx1qvwKv13maXGEZoDWz+ajHgEJSuwtkl79XtvCB9Gw5UWiXTIte5FjlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mll6zCJ5Tb2rVKlM22C02E5AyQVwggJDA0p11S87WHc=;
 b=UFbE2YzO+0IULXa/z9Jg3IavMN2ViPMMOURQboyLZ1rfD7IWGzVLMt97dhy2JsIRkvmWmGqa2VZmc1YoTJyoxv1xBKxPadiRVU9R9j9gGxBjQzEuD4lfvHohGkZZemkS4fs53IiAcYNukPGIvNDwZwoOabUzbrZ4GiR9zzNiOL4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3270.namprd21.prod.outlook.com (2603:10b6:8:7e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.3; Tue, 24 Jan
 2023 16:03:48 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%8]) with mapi id 15.20.6064.004; Tue, 24 Jan 2023
 16:03:48 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT issue
Thread-Topic: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT
 issue
Thread-Index: AQHZKe5eY4YKqF4/rUGyGUKn5WFEPa6oUYAggAEUTgCABF8qgA==
Date:   Tue, 24 Jan 2023 16:03:48 +0000
Message-ID: <BYAPR21MB168820EEC294D8A951AA20EAD7C99@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
 <BYAPR21MB168890325173FD3A35CB89DDD7CA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <167f918d-8417-8f3c-e208-5a4cc3004004@kernel.dk>
In-Reply-To: <167f918d-8417-8f3c-e208-5a4cc3004004@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2eeedd6-7a3b-418d-8b2c-edcbf8aed144;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-24T15:56:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3270:EE_
x-ms-office365-filtering-correlation-id: 1bcbd60e-ced0-4b64-1395-08dafe249415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DijyXSXsbFxV2phnYyjarxYm8dZtRodlIRLxVDicB/J0ByKlU3edJfTydCXgqo1pWqBNMiY7wkWJfSJ/XPUU6So+exhZTB7Sa3LtCH2iJDSfVNJpaMsTb7ngqpvfL7V6DeaHuuBx//FYle09GH0U6WV4XalOVaSBxgruoLG3AGgduMyS6ACp19PwjrMgPh3xVsq20ZTciAVu/TlVY0gbz4WfyFTMo+Rx1aUK7KOF2YAkZMVgdKB/H/DBJQ8uqJm7OUC+i1oed1sr9bKtFKeFyBC9H6O0/CVBKY4tPTB1AbBkY3LOLWRwiYOSFeVfOF56G5iLQwBGFAIr5xpqIcllU3n1QansYi6wKsD4PSdHzmqbBcdpLyWhofIIo8XsXp2CFXPfNLIJP0IaAV5dhAziWjIr/+q9lmEhcgdxodg6yGUowlIoaYwpjSRoQXe9yM6vgPKke26ri+V8bqD80Fc2V2qvBvsHG4qwgng8rY9PCij9t+qj6aizjYkpFK1m8k2JhDlNdhHghP17cPH82yGQvEJimOCoCn3usGqMGM/zurxfipKFth9930lGwYWmdcZIIL9hOAf9/34H7MEor1jl/fTlukVXbuO8gBD0ZjWYtO33q9CxCpL9zFwHzLTiAOdBq3ZUPl0iWkjRXaX6W+jNmctNuwp1ClGJ8m34hIz7Srkueymg/+ueBakzgEWAF0hmJ+KeKGod8K+fCHAoX9tOv3cHRCgGIoNAFson2I+drv4XMTG4NHsZEKtLZAwnjO8w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199015)(38070700005)(82960400001)(38100700002)(82950400001)(6506007)(122000001)(9686003)(8990500004)(186003)(478600001)(7696005)(2906002)(26005)(86362001)(5660300002)(66446008)(33656002)(4326008)(66476007)(64756008)(66556008)(8676002)(66946007)(71200400001)(83380400001)(41300700001)(10290500003)(55016003)(316002)(76116006)(110136005)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UyY+7UU9ixOQjwN1Prs86ESZKaaIP3Fj9RnGoC3VKXizp94dLzbjh/m2j47h?=
 =?us-ascii?Q?ykKpe5VYCq48v6Tim5xrUHZBgaF0NblBIW+jrrn/fmz0pntjANRHQqH96UL7?=
 =?us-ascii?Q?zFZrju5YIg6JgIQHjkXBRZzUayUE6h/orEslXF9glpy2d20I8U6lt8kqwrob?=
 =?us-ascii?Q?ZcBNw79KQHzYTtETpGM2ARSTMY6FGeKLwlpl5FuN8D108vrUaDhLHfTMXJyU?=
 =?us-ascii?Q?jzPfRgtnJ2CqLunsoHvGXgLH2TzL3NDjEzDBgcF4qtqmJyaOD5JTiw3gFQAd?=
 =?us-ascii?Q?H04731mZETYAsOvZFJnJkGnuqBHV+wmDtUKaJYc2UP2GTgJxPW2QO7PMtxd/?=
 =?us-ascii?Q?kGCcgJclTQaOp7w15jSuWOMvhMky47EQ5HI3tffgbwjhT/zUHygq87zkHexj?=
 =?us-ascii?Q?Ups8g0Xj57CpCYuEd2XPulbSeYrqDmxdra5vTul9MbYlM5lrPYmkgeJzESRR?=
 =?us-ascii?Q?bcnf5nwCmDGOpo4bAdR3WBD4sfuz2jwJXTlHr58fqtdpR1MawmCbk7AGsPy2?=
 =?us-ascii?Q?dTqhJ3o5jRJ0/rEnclTlbVUrzelLU+NZYKWfkE2Tda+7GkhaMep+LGj7cLFI?=
 =?us-ascii?Q?LvFmRBWD0cDqpWsap4izFMOf+5V8icvDcD5x0lA+QAgSlJvKEnxlgFpTfI52?=
 =?us-ascii?Q?3Ai9ROQveK3YXMu4zW+oCC+NJUDcEVTAPutCaQ1ZnPqDJBB/3WEQMzTLK3ou?=
 =?us-ascii?Q?ufV0u6kEcq6Yhj1b5GI+NY6w85N7zYDtMhxO7g2/AtmIqyX+WrF0uTm+b1VB?=
 =?us-ascii?Q?xy3eYvEBQeqAl+7HnQfwc52RwV1/+6ZbSjbN+AXzvpf6Zc16If7iHQp0Y39W?=
 =?us-ascii?Q?OhchUXrAbKZmHnPd9uvKGF1v5y8fDtewWRFefLgTCg3RIQUykdNcU2oVvTSr?=
 =?us-ascii?Q?p2uxj+6gVQjf+9ft6uiIwtJnOw4RC/beeJwUX8N1+IDaNbW+mTYKf3oeR8OK?=
 =?us-ascii?Q?A5AlAAzfcbfYsGbTiOc1GDs6npOOg1oscOE8LCkKOKfB2Y/fY2Oo0bMFP0SB?=
 =?us-ascii?Q?DnE2sMVoQ0zxufee/Frz6DE3ECzIBEKs1WjsLwKX5CBh41H4/8JoNHkZtpVE?=
 =?us-ascii?Q?NmwR1B23i5tJUB20mpVsyWkQQs58HpF+Z1LZdbp5ugdzeTDfSTu89KkDtv9+?=
 =?us-ascii?Q?BAL+TTLH4Ilge5ZouiTjlGQhTbDxyD2h2KG3fJeq76UF+iyaqE8Gg7ZBxbyr?=
 =?us-ascii?Q?0MbuSHjeIV8R2/Ro3mRsT8Sb8WkFXKpnwED4qSrCylPeN80+SdKgAaFnqhMx?=
 =?us-ascii?Q?FU14Il2xLevAHzsdQnHY5yv4k4HboHEI9C0aVI8Udi19E7ToBa39tYOfc/im?=
 =?us-ascii?Q?y3+psbuPsh5i7qEYmPFEUNuNZpN3pchjpodxbQovxyJ6DTWiUICDUj5dPdkg?=
 =?us-ascii?Q?uS8SHanjz3mnBdgNk7ydzN9R9KKVj3lk8QB++UOt2ZOh9ldK1a9rPq9aUJ3+?=
 =?us-ascii?Q?Hrww74+bukyVRCmP2SlJZctaR6OetR6F6AMXPDO8LGQq7kgGwGoURvKFmQld?=
 =?us-ascii?Q?rub3jtO5/DKO/3TWMhk1Rrs4IatP9ettqLjZjjhTjoWSzCND3jxKkG0LdCEb?=
 =?us-ascii?Q?uXauS3kFtveYZXfivEKSKWFyqK7Kj5anaw3yrHBqclEDWcJjAS4AuNCYXKLQ?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcbd60e-ced0-4b64-1395-08dafe249415
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 16:03:48.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybUTDA2zrWyuR8QS61oZNZ7Vb8xEpWycbUGkvJ8HI2nbrtZ9ijzG39wo3D4mEQchpZIpgjvarc0P5f6kFdUHqtbvXGUkewPSEckdMmHazpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3270
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk> Sent: Saturday, January 21, 2023 1:11 PM
>=20
> On 1/20/23 9:56?PM, Michael Kelley (LINUX) wrote:
> > From: Jens Axboe <axboe@kernel.dk> Sent: Monday, January 16, 2023 1:06 =
PM

[snip]

> >
> > I've wrapped up my testing on this patch.  All testing was via
> > io_uring -- I did not test other paths.  Testing was against a
> > combination of this patch and the previous patch set for a similar
> > problem. [1]
> >
> > I tested with a simple test program to issue single I/Os, and verified
> > the expected paths were taken through the block layer and io_uring
> > code for various size I/Os, including over 1 Mbyte.  No EAGAIN errors
> > were seen. This testing was with a 6.1 kernel.
> >
> > Also tested the original app that surfaced the problem.  It's a larger
> > scale workload using io_uring, and is where the problem was originally
> > encountered.  That workload runs on a purpose-built 5.15 kernel, so I
> > backported both patches to 5.15 for this testing.  All looks good. No
> > EAGAIN errors were seen.
>=20
> Thanks a lot for your thorough testing! Can you share the 5.15
> backports, so we can put them into 5.15-stable as well potentially?
>=20

Certainly.  What's the best way to do that?  Should I send them to you,
or to the linux-block list?  Or post directly to stable@vger.kernel.org?
If the latter, maybe I need to wait until it has an upstream commit ID
that can be referenced.  Also, you or someone should do a quick review
of the backport to make sure I didn't break something in a path I
didn't test.

Michael
