Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C3DC433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 22:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4F564EB9
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 22:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhBJWQ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 17:16:58 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32746 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbhBJWQq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 17:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612995821; x=1644531821;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PvLQH2Z5vDaJNX54Ev27Tor1rvcJ2KP+yKAgXi/+Xdo=;
  b=FXePOnidqpZ13wvAua276nDK0KUzityrVC6wn5yt6VnjtkhStGGPSZ/Q
   yzvfvI56xe2YhyEUm5260UqaD17JlYIJ1jH/m3uq0EiZQxisYQ4gy63yL
   w6RqrrIFlmjEBwJBXBXLcFBHYTf9TYFvFKhX6B9I33CW6WwcKybng6lfM
   tYgilaiFjzuhaWkBNWL69ui6bb5ddRpI5Dy5Ef5BJZR5e2iCOctU+o9wG
   KQanMtvb3j8xGJWfCQD0kC+O/dOzJUYfKvSpSkBZ6xKy/ZXQItMk3Wkrj
   D29Q9LP8DQhn8g74OqvZizfiyqWxxC+IbfUvu1gK3lYGW1QW7hstVpbo4
   A==;
IronPort-SDR: LNgjrz651Kh1/ySqo2Y7AtV0Omq/bAjm/q4oXTjhpkoNK8gl/ReJ/zdJ+0o8QjPE1sNEEQr0/Q
 k2arOFvKX1PyqJMy/qsRdVvrQ+X/vAKdu81bqgUZOaNoM3KCn2FcewCX2iqiVr9LLG4bVfVeK8
 hgT2ZeFUNG2Ef9tlmbyVq5C/+HNFCoFyGYHt6kSwh3u4eHaAXSvsIRHHcaW0aWiAvXRK5+wfDG
 cY0K9RbW0RFNho2zam869rMVGKYFo0d64kVmawbVURCzXTYMDZ+9NacLBA366/SDoZ5OXrALJ7
 wFk=
X-IronPort-AV: E=Sophos;i="5.81,169,1610380800"; 
   d="scan'208";a="263824597"
Received: from mail-cys01nam02lp2052.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.52])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 06:21:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP3yQqJsIcwxxAm+daXF5r9ONrgVEoEGMC94rTIcZrMq4Vczheo3xy7u/pJin1OAa/PsZJ5G606PTSyDxnXHxZLdxSfdTJc8QGdTXG5uPe52WTxeCuffxQ8PzuKMx38EviZJnbuGI7RezytMSNb+du5ZUixRqcERzi5yCROb0ZuMiJ0rzMXzg3Xm8rSiIEmOkn5/4kw5F49ayETDdmAsIcd22rRTjD0uQv03JZ+8ADQ+d4YUOjFfyrxQMCyuUJ+bzpJZQFFoX31E9C5aHD/wcYzZZ79vsSGA8xhcfctbG70thuRvzbWcMNZ6N/4NFK4LhfTbjLzAsfmLVclrPnrNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahs6KwEIAb/PsnYdGxN0P/WoyYguZa479pcuIH8hgAo=;
 b=Sowmu5k+udcNJ+R4Op9pz3GEKraoERXx4CmmTLJLVno1CQt83P4BTWpb0i5KA63s9O5hA2FmsDhklj3QNZrsmDA+YrtDHQhiAN1Gl7FEonpA4OtC6W4AdR6bZBYbUGKJyW5YAvnvgClOVNfQf1IG6/SyCdsa4hgoTY6FNifCRxLiA/VON0BVzZLQsyFutanR3IJQIaf5wyUatZa+8ZY/F0uoWSegIwRXFuk/3vlGJTHOE8lSV1fnhj+t8QR6YnnfRbhDOcV55JtIkrCVNx4BITNhVPiOqa662YJQLDgLEgoYgEJNId7ZxtmYbwdh4rg1+dVjRrYxRr9gvJQYPxTYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahs6KwEIAb/PsnYdGxN0P/WoyYguZa479pcuIH8hgAo=;
 b=xWtgH0Oghd7N6u3Y5r4fXTkps4sFEZqsmLdaLlzFrDZRYR+3BRF/gUwUi0UDtO9kxujhAORcVA9Hb4QkgnzUbnv9lPvkq+wq1eBCZH/zDAgmkE8Ik1ipDsONcUOtSWwx1rPb73hUwtP17JVrlojwlYXSfkQWkjM5hMNS3VgsT4k=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5526.namprd04.prod.outlook.com (2603:10b6:a03:e9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Wed, 10 Feb
 2021 22:15:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 22:15:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Thread-Topic: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Thread-Index: AdBd7/Jehsbeb/mKAfYcWAj9LaDbog==
Date:   Wed, 10 Feb 2021 22:15:36 +0000
Message-ID: <BYAPR04MB496552DEB31A02A06A3DEE0A868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
 <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
 <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
 <1a520912-ac7c-1a3c-c432-b382a5da6177@redhat.com>
 <BYAPR04MB49652279710E99EBB6F8AC67868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <502e8d85-90cf-9533-0f83-364bee2fd34b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2607:fb90:482b:10d6:f4fe:f24b:7108:1811]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed1f0df5-ec65-4608-b32e-08d8ce11648a
x-ms-traffictypediagnostic: BYAPR04MB5526:
x-microsoft-antispam-prvs: <BYAPR04MB55269F2688B29FB1A61274B9868D9@BYAPR04MB5526.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0YvVB4TMFAGs60ngjJOUaQTgEtwbARVc33GBBa6RsSiqwOH0E4ldr0n3pWFxjAQKIIEjTaWkjg9u8mS20mVgRKbjb0cOmQBD3n8qiAj6In3s9PsyhQ6GoyiP9JZGYblA4coiHog4wHbI/omesz85IlhzYo8IUn9xhruFgJpMHGV4UrxhtspNYhG7TscSScQWicfKWxk3khzC70i41kHF6NF1i0mBE5mo00dK3c1MYVncU/enCAHonL8S6St8BVKaHMjJU7u7pVkhqyAXhbMXIkgJjRoVxxp3kpMFFw1IpVQPyTiGUGTnu/scMYkUQBikcNekaqQGp1D8qcjsvwTpUtgFCXKCeIhnAiKDlAsWFzQN3gUKa8gIK8GTmF2KMRkUSmGYpqskOngRYTKmEt+nNEJ5Yzuhoi79sl2Xw6BSNhwad8Me0dIP+SsRcy6MYcH2/nXqofFeQKsWxT+dhMgCp7xv+yJQeJu/QMU8Ig3O+3iPlokfVaxF4kO8AdV3r/hHZe4/7gqu6vZxa5nVY33i9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(55016002)(54906003)(4326008)(8676002)(33656002)(478600001)(2906002)(6506007)(53546011)(9686003)(110136005)(186003)(316002)(83380400001)(66556008)(66476007)(8936002)(7696005)(71200400001)(76116006)(52536014)(66946007)(66446008)(64756008)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?u4Qa8lknC+xf1i5cNlz607BIkGv5bM+W9FL5fk3GrWlo17sxpxKK1q/ZoKA1?=
 =?us-ascii?Q?/5Q5cZsLoKO4a9UOglPDLG4AAigPlAOYUh3+upQpfHDJ07t3W9SZiUR79bls?=
 =?us-ascii?Q?rW0ZwK4fcCOk7vZsgqL2B/WmSInF2Y0Ibw+zMlGcPRQcKnNIOmBIS4ubd+ZE?=
 =?us-ascii?Q?DXe8U4FmnI9AvUPzUwhWJFjFDLKgd3UEI0qIiBWBd5eqacuTlTrkp6aWNGbW?=
 =?us-ascii?Q?CTjXtvw+LoIs+k6ecgLJW0wqVAMVkW3LnUHhNFcE+TFwPaxElZFi01ZK0/Mn?=
 =?us-ascii?Q?whXWv6M/i8YxsbyytS51QbLoDOqAaTlPSAxtFzUu9HjBHjPhkfQ3zTzKEAnl?=
 =?us-ascii?Q?SytiAabFJaihjMIYz5JKtQqABT3Bq8PysUSBpJ6v82F4PKMUjJPvQM6EC3UJ?=
 =?us-ascii?Q?96bsOypRdLByFRzwSXqe5h9x+837XuBoyDcqmwTGUcPkUUfNEvjtGl23ker4?=
 =?us-ascii?Q?/++JJRhKcu71rC67DXMVD4mht9WhYxRC2omisWJUpV1XsEO2Bh9U6FmfH6w/?=
 =?us-ascii?Q?nfVftXY3tb6g5UFI/cQOnIOXcZ/4ChFcMTEfl4zdNIJM7ZyxVBNmgz4xApqD?=
 =?us-ascii?Q?7rBMMf625CeknpMeff2GYSR7ItkzTdGldSNVGkq/EtkANMyj19xYXqcYlA+7?=
 =?us-ascii?Q?2Ms7PC6BNliDss/5LITGa59Ly0jvby3+j+285QiJZ/ZAlHCqRqaI2+gZnEC3?=
 =?us-ascii?Q?DNCyCAEAu9hbyVEFm2JjpIB+609XCLZZJoCIG+XE66QiYajGe7ivutNlKctN?=
 =?us-ascii?Q?UmlpKAYTEo9Sa5fAq1WzB1kfzHryDVTdcvaTt9ZpHAsjcLIezojedD7FJFHB?=
 =?us-ascii?Q?WhUJje+hiCUxy6MDf0SNdYwn/g75ABaM8oqFAtWfvhKcXjN8/eAb+ePU1gq3?=
 =?us-ascii?Q?kyaPO5gdksbgTagOWcssjunawyzbB8d7mV09/kPPLRFKAUurCTTYxj+rShY5?=
 =?us-ascii?Q?2ryZ6ajBce5UoUaJTi9KoARHEvMVBvpUk2PzmLUMEgMxCz8ptwix/WQ9U49Q?=
 =?us-ascii?Q?zbNfnCyxKOJPh4MfXMHEMjHt/ln032z9P5za8fl3OesB0W2Fn+SJVOplbiX5?=
 =?us-ascii?Q?mzAfBuCZVwo5Vpf627Cvnnpgk5edjEV2riDgkowrSLt8ZMgwimtZ6JXqUlMq?=
 =?us-ascii?Q?nBs5D0Ns3ESWaz+5CNW4ENLLlcdbfXGJ1ltxqVVlg1kndJJ+djlC0U50+l6D?=
 =?us-ascii?Q?athbPXgoXu1FBJRsnn+NcExRilarJ2qOo7VoYxczZKZnFmPTqcPlv3/2YpaK?=
 =?us-ascii?Q?v+k0FZnOCG3O1cgX/cl7CX/IizHxrHehOdYQF+X9uvlVo3jrpJ89g0TAY5Ag?=
 =?us-ascii?Q?fxvtGJf7zJObn1+DtvPN8/g4whnFLGnjNGOLiyghAmnrlfr336vV996kZ0bY?=
 =?us-ascii?Q?3uK4N2kxLozH3UtFesjEYeES90MPa1QCOD+rvuG6SjVgU59AlA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1f0df5-ec65-4608-b32e-08d8ce11648a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 22:15:36.8183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTvG3rerU/c2PoxuxSdH7BB7PIOC353pksq6XKk5bMVogrebIkTcOvs/NdvXTousXJpINhG/PRnwvk1Ev0Z0hN2Xenf3mkfohvZ65aNqTzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5526
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/21 2:06 PM, Sagi Grimberg wrote:=0A=
>>> [   75.235059] nvme_tcp: rq 38 opcode 8=0A=
>>> [   75.238653] blk_update_request: I/O error, dev nvme0c0n1, sector=0A=
>>> 1048624 op 0x9:(WRITE_ZEROES) flags 0x2800800 phys_seg 0 prio class 0=
=0A=
>>> [   75.380179] XFS (nvme0n1): Mounting V5 Filesystem=0A=
>>> [   75.387457] XFS (nvme0n1): Ending clean mount=0A=
>>> [   75.388555] xfs filesystem being mounted at /mnt/blktests supports=
=0A=
>>> timestamps until 2038 (0x7fffffff)=0A=
>>> [   91.035659] XFS (nvme0n1): Unmounting Filesystem=0A=
>>> [   91.043334] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"=0A=
>> But write-zeores is also data less command and should not fail.=0A=
> And it has a bio, which means that nvme-tcp tries to init an iter=0A=
> for it when it shouldn't. So the actual offending commit is:=0A=
> cb9b870fba3e, which cleaned up how the iter is initialized but =0A=
> introduced this issue.=0A=
>=0A=
Looking at cb9b870fba3e, that should work, but really surprised that it=0A=
never=0A=
got triggered even once in my testing since the issue is reported.=0A=
