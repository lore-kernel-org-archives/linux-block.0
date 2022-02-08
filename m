Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2CDC433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 07:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348473AbiBHHrO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Feb 2022 02:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiBHHrO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Feb 2022 02:47:14 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 23:47:12 PST
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEC6C0401EF
        for <linux-block@vger.kernel.org>; Mon,  7 Feb 2022 23:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644306429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xfBPJw0kHlHhv0h8SAZMi7q0Sn4oKOTaqY1078s4yQ=;
        b=QOpR5pAyU0kqvAcvlXfT58oGPwLH+havmKbEI8IvfQCuygwnb8SjM+EquhL7dwq2M7FFY9
        Dt0xp9gmODvC5v9yJctCwiq1IyGTPA4UM1DFA5vCyu8dEeMmrXy4UT2q6ZgFySCfp+a9XJ
        LoPmaWFgh/KB6yCUQM4h0Lhux//9AVs=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-zYhR7yOZOwaVVOHfe_7PBg-1; Tue, 08 Feb 2022 08:46:04 +0100
X-MC-Unique: zYhR7yOZOwaVVOHfe_7PBg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKbvhYN/9utH5kLdqmPZAhOwdsodHUpr6nRFkS6Cf8d29PZj7budhs5upydOC8KAzIORndO9kSa2yt6qdlrijnBj+GiuMU4Gy66oFMpw9J5l06dZXXre96BQQbliwUC34p9ZWv4uFgiJXBoEodh7iwn14w5paHXl6I1KL3WJgsX+4SC4xrMpYJMKIuhV/A7r4KhO1S/xsdSheYP4RCrXyXZdl947HH6Evlj8MrpR6pOyXoXI9aDUWzdjoqGV54XrQ7kC/QVSdsltn31WoUMdgcqajE8AwbSNFcVqWZ6dBCgo99Ju6iwaMhwnO4wyZcqiTm6Q6ZzUZtN9Zg+EaPZzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xfBPJw0kHlHhv0h8SAZMi7q0Sn4oKOTaqY1078s4yQ=;
 b=ew7wqokoStNYLjb50WNq98M2UazCpoZ+rJ2O1NIBbXe5EXYHnAKa00xa1mF9sPCX/vmVLPMqBV2HCLSks/3xdDqqfd2pQLskPThXMRb+C56W2cXHvjnACZkOyjxqNjBxmPfeCOitopoIxCdp0hU/MlyZZfNZq9+oyrHmBkOh6hJ/VXDvwc/MqdBQZnEOWT9YEcJ3cr1B/CmGWu7+3yjyFUdmuQoXMxgYfoXZt9XPLExsQ/6EuEqObhHXEHxv7zB32XLYbqgV4X4cxGl2dbrYFk/HCHsViA+fsf8MPckKKIhfhQsCNjiSclHfSmqs5LDql/hF/t6zqSUStCSi5Zfa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com (2603:10a6:10:103::20)
 by DB7PR04MB5420.eurprd04.prod.outlook.com (2603:10a6:10:8e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 07:46:04 +0000
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::4081:2960:b740:3d47]) by DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::4081:2960:b740:3d47%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 07:46:03 +0000
From:   Martin Wilck <martin.wilck@suse.com>
To:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2] lib/sbitmap: kill 'depth' from sbitmap_word
Thread-Topic: [PATCH V2] lib/sbitmap: kill 'depth' from sbitmap_word
Thread-Index: AQHYBfPlQJ/r5rWDKUWl+NJaQ/Ita6yJc+4A
Date:   Tue, 8 Feb 2022 07:46:03 +0000
Message-ID: <0f28be75075d260651b215fa435a40152feef93f.camel@suse.com>
References: <20220110072945.347535-1-ming.lei@redhat.com>
In-Reply-To: <20220110072945.347535-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9269f419-13a6-4f50-38a3-08d9ead70edc
x-ms-traffictypediagnostic: DB7PR04MB5420:EE_
x-microsoft-antispam-prvs: <DB7PR04MB542099D35B230161325B9865FC2D9@DB7PR04MB5420.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t7bE8pIOnOMiufIsgX7OGVJJKQqwKLTn0iOSiKAghivcxFv+YT0l+IC1ABEaM+U/WKF4KqEe7fRK5D6gkPzF3V5i5xrUg97voTGlEBnLMdtOxskf/UzdqOHw/h6TKdsKb9Y/3E+oR8xVfxw40O/ANj8Qnvr0nXdHMSFxcayfB7yXCpfVYNgFxdYhdIJOgFof2Ih3B6OU6xwHcENxOv4dvXTfosBpEkbPqpdayJCtmRl4+L3aGXt/MbDYyTk5hTHMKF+xvYyOB+UaNDDpPWP8Ik34NYuKkHOKfk6IGx/BhBk4pwlr+mf1OA9z3mnM30ZaE3rM7RnbEtF/seDsJy+68hUyD/zDN65IvmobwWI/zpTgYo/2zTM+WBGtHF+u9mic9Ng/8+EubPlGYK+7ifTzvW5QPiVrfHGPp4G08WSkOyRGcPpxFY6RftMN7rSXfWf8Z3AhC9c2NX+TtKW7pRRBZ2c0KdSMlSqUrk0AIaRoaOAuifmxyYJRngvrDqlxEKq9Pa2J3yo8LEchNTexb1law5+CnkDl2uQG9LHlJ1fInzEk+SnkCrh4qfMGDewy/LhcZAAyfWToK4vsJFlAy6qXq+ZZV5N7WLBeNb7AX2BoR9lp6Mh+1FVK6Vw/OBvxD4dHRK00A1WQGI19R7Uy1d1qjecxQngov0SzkvA1lBt8pQcE2pQRaFzl4LqpLENEUCf4udo4fHs3Z/zaiFOPh28OAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(36756003)(186003)(38070700005)(6506007)(6512007)(71200400001)(76116006)(66476007)(66556008)(316002)(122000001)(2906002)(110136005)(38100700002)(4744005)(4326008)(86362001)(44832011)(66946007)(6486002)(8936002)(5660300002)(508600001)(91956017)(2616005)(8676002)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?ymDHNnWqWtmOc1JUjsdXjASOCAGQm2TMyBwuiRYhpVkmNRTWfF8EnTqIq?=
 =?iso-8859-15?Q?r9mwRfsZHBXW+F+q3eJWjl0O/9uDqfZ56rre2dVBkt9sjJaOYiWAQIFw+?=
 =?iso-8859-15?Q?ig7gazo8KfqTjRWQJrnMgnoRamDW2tgB5bRHkYBGT94HJm9n4fPbw/vNe?=
 =?iso-8859-15?Q?kGlAN7jDmdcig8f2j/elrBClY2Ccsoj7vWLgL6acSd65NAM0tL5U7ssVG?=
 =?iso-8859-15?Q?IYwg/PAGU2YCe/Sx2fRJUINUEqcY8Sk7425H15+HyandqqhzcPNLHuwqN?=
 =?iso-8859-15?Q?kprzteVT1vYNziH4mEPFhazjcvewpgI8A4r2egqi8RmAdz6anPMw3GoGE?=
 =?iso-8859-15?Q?0A1heaGOjk6j6oc5h5U5gjEu00yzK7y+yn/YEWoiVJ3DdHhMAVvdOinvS?=
 =?iso-8859-15?Q?1IdSITLcDMHkeBFW1Zr6xzCflHkt5SA6ZNTdZg8KEmhhwQbpE+pfRFNSI?=
 =?iso-8859-15?Q?c+5G3dgcqZ+45KtQlNai1pv8+gVfOYi+fI39DVntaehnmV2bR1DRFCQKx?=
 =?iso-8859-15?Q?yZzYwImPiyxYO5T6pWitggVYjhHgWdIrm6O9EsgBpnLGDr0cckGJZk3d1?=
 =?iso-8859-15?Q?eDEQ+SA4y3ozFnKiZvq9D6AVffY9dt085quNAMUwJha8opefObiIPcgXd?=
 =?iso-8859-15?Q?mRT3PM6Oru7ZJ7LbbRG41pF5jIwS+eoZrfs85nZ+sZeI/xFT0Nb7FGWoR?=
 =?iso-8859-15?Q?x0uN8DEKT/8xPVhmHX551Lt7ctGsCc7xS72WPVgqqEdWfO8gFNzu3siY4?=
 =?iso-8859-15?Q?mFpaTCjSws/tNgRoO5JpiodX1tTgDfKCPB7MWGcqbnrfquKGgNutT6iYu?=
 =?iso-8859-15?Q?McP0AKHZ7DdHK4BU+2n4i//4MeKZIQeaN+pT1fe8YTBdlm8XguFyD8Gbq?=
 =?iso-8859-15?Q?17LT7cGGOGswdx0VCnwVb9MCIGAsUoN4vfKWe86mUKQoQqbf+3VDT0YSP?=
 =?iso-8859-15?Q?+Usbxv+2F13WqCYaHB0hAcFIuVxMMyeAlEZHEgTqMyl5Blf+54OwVTbJ0?=
 =?iso-8859-15?Q?Bw5VgqTjJ3IJ7Pofn9J0FrNJDr8gbru0y9MbAfsI/km/y6VLgS+crkeE3?=
 =?iso-8859-15?Q?2GsfiVbPamZWrZCCAzwbtpGrVJl3zeeij3lwrDPNNvmbPX9d0gCFvbMUt?=
 =?iso-8859-15?Q?WnZR/mB3nUtyRRjXc59WFrfhjI6EiJwDf8scSf6pRFPKpwVnHPjDTtdEO?=
 =?iso-8859-15?Q?49qwlL6FIQgkr9porxtJwI+P8O0nnRRGdjW8/3zPwqvU6E9FMxGiQbSDT?=
 =?iso-8859-15?Q?G7RzE3KpJl1nuYsac1XICIFt2KxlyJCnIp7EVjOasYB1u77lSCX0YIluo?=
 =?iso-8859-15?Q?Rqz82VSAf+KpwcFKKUvHA8IcBkEhpnrd4/qBqePqXKhTK66qSsQ7bT/xQ?=
 =?iso-8859-15?Q?+7P1wT6BC1069MrWZDBW2RRbo2ZzOWkCkPeEpQjM9rVIvwY+eiJM7CKRV?=
 =?iso-8859-15?Q?fq1XnsxiLJLRFreepaXuIiYI+/epiDPvu/Wg6O8hRaLP7YOzmgeyOYsIe?=
 =?iso-8859-15?Q?aQ/l92cc0Kr9b7Hkc5nyIkNqCdAC8dx/XSgtfNgvR3DluqjwoLXn9k/kY?=
 =?iso-8859-15?Q?SP9pPX+UJXKdKTKW98WTZc1rFszLPyj6RX3iUOMqkrW97Rz/W8q5QHd98?=
 =?iso-8859-15?Q?BJPhxolFA4cfwFhEwVF+xoH+ziE5WijX/uPVm6QwqQif7NhDwHfb6kbkm?=
 =?iso-8859-15?Q?K7Ym6y81oZ0ybxIaHkC7qIVntI1PQdQmZeo9cBPU7U7Lpf0=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <E567739253A20744B1677FF987D1000C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9269f419-13a6-4f50-38a3-08d9ead70edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 07:46:03.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mdvu3bVQxSlLK65iVXM9gU26l3NWTDxevhe1hzVpaOrhpvalibR/FIeknpFOEwI/X1M+2NBVyTXrJ7DCNFMD3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5420
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2022-01-10 at 15:29 +0800, Ming Lei wrote:
> Only the last sbitmap_word can have different depth, and all the
> others
> must have same depth of 1U << sb->shift, so not necessary to store it
> in
> sbitmap_word, and it can be retrieved easily and efficiently by
> adding
> one internal helper of __map_depth(sb, index).
>=20
> Remove 'depth' field from sbitmap_word, then the annotation of
> ____cacheline_aligned_in_smp for 'word' isn't needed any more.
>=20
> Not see performance effect when running high parallel IOPS test on
> null_blk.
>=20
> This way saves us one cacheline(usually 64 words) per each
> sbitmap_word.
>=20
> Cc: Martin Wilck <martin.wilck@suse.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Martin Wilck <mwilck@suse.com>

