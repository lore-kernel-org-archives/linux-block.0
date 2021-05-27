Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB99C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE516109E
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhE0C2X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 22:28:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6472 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbhE0C2X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 22:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622082409; x=1653618409;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kazA9rtnIiiLyulQxNzRy9gi8vnn3adYxqcIlxx6AVA=;
  b=mBAc1kRJ0G0qoagGsyoWc4mypq8u04nvcGVrRzXvhD+G4qEF4UumJl+e
   srNNdiNig56pbfgvQrvvC8ptDXw8OBfpH1/GpAAzdAx8f3bdqbwl51dsQ
   4HBPjkuvxvgfhznLgJik8m8sCSmNmz93CFYDfjdRSoX/ITAgkYEkLNTiK
   v5ISsdRKD1EQkJkUlFQ3wcjRvaXuKjFO32NmKciF0ibOCAWhWEP9ihnQ5
   MiKY88rOrZFpst+pM3LYIFeZK6g0ZU3J+h1lfRK22iAjoR62wqw4rmxL0
   PdFVtpvR8ypTD4sih8VO+nGPddV+xUvd77NRLOAE4dy5K7psnV89gRaMk
   Q==;
IronPort-SDR: 6Gi+TwOvYN3fMhHEI1bcOZu6Hf66cwwoSNhg4DTSz7DY1yzHi8ReZ5THJqYsBG+0dGd2Jo4Zfe
 P2q+OdbPqeObHbboVtUSpcZ66vQmjnVnIboKGY7dvBQZVYKh0kF1EwhqD8fc8cZLHx9FhBoXAe
 18XB1nGXdN4xgFivwV+tRQFZXVC8wbI1blnKoQhmX6EviuFHZ8+fX9+wRzuCx7hDlj6TSUK9ph
 p6yZSqLJ1dRgoYMKYxa7jR52vYycGayjRjMNoATrOoLLiB+YgfJxu+BrhXVHuIXy227S4sGyoB
 79o=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="169580589"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 10:26:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsjAKWURuYmVevxG/S68cH292vFKG/qcq64kHq1BsD8PY6vVLpusQjA1fwPJBhFAc1R3bkLocUtC3hmKNhLSrrm9SVA2Fe9YoCyw+1gvMGEtY1Njya+Ru/HvKFmoB+JJos+x5wMfGPfHZ09tSDuyIqC6zSE9BohX1nQwFrF08oeo9CV1Rg5WFSpA61mj/ld7OhXeK2Fj0Tj470ybp14Y9OSdoeOZHDbFkFNvurBPI6ALW5RVpcJEJrkRRFUJLb0ARJOtri6OJjSlisLEl1deBlQvJsGUkZbpjjgnbRwlhDqImPpdk0vzwddm9rrG4XbkvencEtTdw93LLyW16vbNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kazA9rtnIiiLyulQxNzRy9gi8vnn3adYxqcIlxx6AVA=;
 b=U157Y4R+SprVBpzj/NbRk7LNpyQO+W5w9qLf3DQ7jgz+aQkoMfzEq/wZctJ9HgFHonbGhQ51Qcf0xG2B3GZxOZMR6zlzA7tbu40W274fWm0NvrzFZCVuO871khUFwScr1io3bWWkGdqyOxB2Vzd+Ve5Fm8hDxTAjymylXND6NDMYy8KWP/KmlwKyYCjxZJ3zPfSHLWzII+SyhyGH/bIX4W6pTrhfeeYbVsvzuXDuqYPTebwPAHlcTyiumON4RkL66sPyu1iE+7XPEvl+nX30NGe98y4ibKsrFTTU3hZkmINZQBoLZpOXOZ/zZP5apanYKezEWuQIuR9lPDCmMWhNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kazA9rtnIiiLyulQxNzRy9gi8vnn3adYxqcIlxx6AVA=;
 b=ev48zJ/7t2kLig+JXDn0HGZvmuHte/FAFT6P/i2hYFMu3jhP/8/ILsp3H8mVfr9IygVIX1QacX6tf728Ic3Hw6YjOYFoyFk4M3rfYHriSpFIwUAG6+QzBA5LHxbaVjXqjUWc6URiJUveTTACp3hhz/lJjuh5K0a5rmRecKlteY0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3781.namprd04.prod.outlook.com (2603:10b6:a02:ab::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 02:26:49 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 02:26:49 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/9] block/mq-deadline: Remove two local variables
Thread-Topic: [PATCH 3/9] block/mq-deadline: Remove two local variables
Thread-Index: AQHXUpPwanTx2oo8EUKtrEWljuQ0sg==
Date:   Thu, 27 May 2021 02:26:49 +0000
Message-ID: <BYAPR04MB4965F4BA27BCD9EEAF102C9686239@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e9156d7-59ba-4fde-cced-08d920b6e1bc
x-ms-traffictypediagnostic: BYAPR04MB3781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB37816C9D09472320C4005D3386239@BYAPR04MB3781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kbjC+o700ks9N2cnx11X5LNHvfkEjL2FpmeURolBWeN4UCFDAOFzUjurqpJ/U3mOMnH6Z2K2pqXah2IFTQugwNpPNY6DvRfy52Zqw2uIwgqJeAPKXMac9gb+prRXsPranY5kj/mrBQoOA8O59ay13mf8Bj7JGXg5cdjLR4eyjOzQWPDPj2pAGtEZf+ZcEYYOQxpHepG914irpLKQTKAkq9Yni/17AVzz+jUZHf7Tyd9/NzyQzORxZeuf/Kwx01pWpq7E61mKr1LsWf6dUVQ1pjIY4vN3rL7JOGHrzowO/XxTvYINw9fM0PJrCosh0/8/9SZjXcLmcmVrbCYZPfY8AAQXPB1axjHndJnaHvE1LOuSk1qAy6gAFCWJDsm7wKfqZnr4nQmbAv9VOZZTQXNIkP2Zcc+EURtUzGcuDUmRx2JO1pYdc5ZszVmiXGWiPr/ksx4eOASihhT25VCtFp0ZWGleisTBOlUKY6+kMXA9Lkz/0cL3ujRZz6QkixyTkEVhOyGxhWh0yHocryCDJwjZ7z9mTnq0Vjd6MZKEPz0Q4zQyeuVK0xypGgLwKOrI6KZU+T0ChllYOyj02gcwMEfaWAObnIkcLYzcBIsXX783YtI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39850400004)(136003)(66446008)(64756008)(83380400001)(66556008)(55016002)(9686003)(66476007)(38100700002)(66946007)(76116006)(52536014)(33656002)(8936002)(6506007)(478600001)(26005)(8676002)(186003)(558084003)(7696005)(53546011)(86362001)(71200400001)(2906002)(54906003)(316002)(122000001)(5660300002)(110136005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+heudTpezjwZFNMaLzXeWznG7EJhIUKgJdUqdqecRjkxAMzmvxoiDg6LWX8J?=
 =?us-ascii?Q?uxr4weMq3DFHkjGloPyZMWO8B5prD0CIfMrqUz6bMfCUtrpCjzTo7o5+TWhG?=
 =?us-ascii?Q?LHNi+iXuavSqplFYsqSXTBQlqG8BmUYAzDX3TYHoiEJUwzmYmJzMhj7zKJ2x?=
 =?us-ascii?Q?Bm4VAWp3tc3zYBjufHV6mZ+v1ZE+ONvLbAdxgHEb1Vyc2qTpcNU9PDD5HJPv?=
 =?us-ascii?Q?W+4DTksIQR8yzBXJUhsH4q94LgKdNJjfbpdZLCg2bfRs7Ncmm9sBiYuy5m+F?=
 =?us-ascii?Q?yn/XKYXYAv5iq9cpW90qTfwVGrM53k1qTzsp/43eJ5sDtTSnUkVeSAkpxO05?=
 =?us-ascii?Q?m+e9rDhjtkQ0gIyV0ueh2+FFIcXeQ8hjAC5Raeykh2pbLYChK1T3uAlcpyw7?=
 =?us-ascii?Q?I/18ek54E70L7yfgzgVMtwGSKPcSalldYU0+DA/oAdNYeSisiD9mB0G7W1Mj?=
 =?us-ascii?Q?CuUwjNSU+CfI/Q3APf1RRGqDmvfOdVW5e9prJFFSqj8tp37kS82ul6TyIgj5?=
 =?us-ascii?Q?MgU1y4+P2H6nlAbLjJ1NWbOXCMB8co5JTagfaY0IE0hRQysfzOH0jPTU4fAD?=
 =?us-ascii?Q?ooB2/oTUwe3M4t/mN86zI6SSwqmj0T7og+gCMPSHHdy2NyJYE9XT/h9DFyJl?=
 =?us-ascii?Q?EAJTEsrWiC8d3V8QG9d3GZeDJXco2/7VED3psXLjmOlnmZbJeblWyOlrp7bd?=
 =?us-ascii?Q?+3axM1Ian2hRnxN5mO9pjQICmpq3g/nO7Y/EdgaPPDT2eNnSQly0hw3i/piz?=
 =?us-ascii?Q?RwxcjG1ZfrjIqXZUvtFWeYGBhCpSmvfpCC9VxJYx9QJ+OwV7V8du2rUIeWHH?=
 =?us-ascii?Q?o/nYnA+AofSR/EfPeqdlGX6fqYsXqkFIQ4kPS5ee1yvVCXSrHP32gKFy3pjn?=
 =?us-ascii?Q?1CYimedYe2jds0JP0/OYhBa6d/467SQnHZ3FMM0+jnIgQlY54ZbPoVk4tY+g?=
 =?us-ascii?Q?EP6Cj2rJkKyp0RZ4HHoc1sDwBStAbN6cTZfKIDXQ/NO5QRxjhAf/GEMRV7V+?=
 =?us-ascii?Q?CCnDPrNPNeq3j88BPPdXMU7v6gHy0nWZ63KZ6j9ToyATIxwuUIHYSBtipv6n?=
 =?us-ascii?Q?0reULwsGCTFBXSDssf6qqNyH3bQV0iEkJj7xh+p4TJQ1qNLs7Q2VLKHRNXKb?=
 =?us-ascii?Q?iaslwgUAtWUUjULAqIu2sra3TYuhdr6xqPz+lzxjD05RTFp1NnpkowH4SNkF?=
 =?us-ascii?Q?068F9lNvP/W0h+Bbj3CwpX0ccMWCH9+6Rj9VA88QelrY17v4DtbBSh4CDt0S?=
 =?us-ascii?Q?GCtn3qPWvKiuItpk16mcJLGkLfdyD2BBjswZcclw+ZF75zlTdQtrK9kauZV3?=
 =?us-ascii?Q?+vK9PPkg9ZolCgvKYK1ay23Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9156d7-59ba-4fde-cced-08d920b6e1bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 02:26:49.1410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXE6rKhrK9jiY9OuCbHUx4SkOY4oAou4uwSEpSXNFOumGT5vcz0nqjjwnG9PaE6aDEgpkZJ2eJaDWqnB0BW3aul25q8IuPjaQ688jfPVMhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3781
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 18:02, Bart Van Assche wrote:=0A=
> Make __dd_dispatch_request() easier to read by removing two local=0A=
> variables.=0A=
>=0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
