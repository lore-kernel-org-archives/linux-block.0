Return-Path: <SRS0=r/dS=67=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54422C433DF
	for <linux-block@archiver.kernel.org>; Sun, 17 May 2020 22:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AED520735
	for <linux-block@archiver.kernel.org>; Sun, 17 May 2020 22:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JeYn2RCc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kuRXkjmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgEQWqW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 18:46:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12019 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgEQWqV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 18:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589755582; x=1621291582;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Xvq/bOe8nFwKenjNRVb500LHn2LRgaf0af6BY34z96w=;
  b=JeYn2RCcrkvhovpQwxazu4Uwp0TC8j8LUHKkMdq0T7u4RyHnL3NuNVKJ
   rzKKirnG/qAFqWNSoWDrgrL9jAdQWQZfU81Pxzppzvos9XBJXH7zuPOSC
   /hDpSyONFnr/txCcxt04vN8zwTYw3x60n3gSa0Tr1CVfxjRk637FPfgN5
   K0qZLg1LLttATKavM8oNZ997A2E8K1uLEs7e/JzUpglJlWx5qQMeZg4Hm
   5HgYI8ekwUlUb0eGLoj7q07KGU6dJOmuJA7ZB+KvWXN2DdLnnE0u2uBrH
   gyFatteWsdcIczzWw8WfK/x+T4QHpFIeOaR+U7qEvpYxR8pgF1X2bh+7i
   g==;
IronPort-SDR: j6pe55RE4Z5BOKOvQ35X1Whj4xVAZ9aiBNEnYJpc0T/P8B7B+Nut3Qq5UxHldkQIDydnx4n0NT
 qd9Zyrz4zRRLo6YHwW+dqA/yXT5tklRn5oXmhMYhuqk7J8WKHkNmM9B8jYOUXGPlm9P1Z/y/nI
 iJg/7l7AVgYX5AizRO6o4QMk/8SleuRrd0VHpOVSUohr0Eoqdav2mko6EqB01vonhZ8VlJJKaZ
 9B/fis/w9GFKhB4OyoZ7hP2BOeXVuRE19pOVlriplc7oiAmxrWypHFV1AQocgl1ofqaNh4iiuW
 Wmg=
X-IronPort-AV: E=Sophos;i="5.73,405,1583164800"; 
   d="scan'208";a="139331533"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2020 06:46:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUTL224sK6KTtr8B605Aibgk1SzmKWQaBarJmUQD6esUd3tgOr5G55vGA5/PJaa3/kxbYbDgXF7MHosz6HjLFg2y60id96kaIDui0Bt3hZGhxO643LBURnC0G2pSZimfcsQVzC6AHxuBDXuyKZN5sTmWVF7O681XTS7yi/g28ctV+54Bs9TzIgIZM8/7P7FzOio96yPXCR4I1G8/8lV4IDvTXM5mlTE5N5w5Uwq0A3r9gDa3yzrcYFNcZ5tIKBQnAE1ld/laPtsiZug96tl8qJFaG4KJj5sYM28ujRqIPXVY871Ld8e5PerdbgQN5axM/J2IvDzai6Zr5ES0nqDYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvq/bOe8nFwKenjNRVb500LHn2LRgaf0af6BY34z96w=;
 b=ZQt9cvGKGu55+TN0X2BHp/ukACslW/lJ3jFhM/9hCSU/5Io7U8HZHqTexq1gABLU6Xgon5cDzhj62JmbvvXkXFN+ZR6AfocpWgx+sjlJirXvIfJy6e64znR7/+t3fD6h/z/eGdjhRMukg5Q2ImoBu61D9AMJbSBnsPn0SPi0CWBRpunP1Zz80PfuueRlYwwTUtGwJ6LRtmtuYdyI4pKtxlbqSuMSZ5hSb92egJF9My33uHxP87RMa1stH25ChX9FIvtcsMobMIoZSyR6yhsH6ylC9xSwxHWl4E4WTs7VKxBBzQFPi5OYawSw5hwDhI5NrmcK+fF06XCHiuT8f2dZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvq/bOe8nFwKenjNRVb500LHn2LRgaf0af6BY34z96w=;
 b=kuRXkjmPmnbbnasCWQppxPkAEesaPF+sH0leATm8l9Lkzwng9tmn1H79ktencshTAkKsRsoGqIIgnz3hSM20BUPqqf/PwXTx3t3Z/pBwoDVW4iffstggKc0ZlWUshT6MKBdK0bznXZTKRPXeMIpMyTATzVS8W9DMFVRbDVK8cz0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6006.namprd04.prod.outlook.com (2603:10b6:a03:eb::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Sun, 17 May
 2020 22:46:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3000.033; Sun, 17 May 2020
 22:46:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 2/5] bio.h: Declare the arguments of bio iteration
 functions const
Thread-Topic: [PATCH 2/5] bio.h: Declare the arguments of bio iteration
 functions const
Thread-Index: AQHWKxes/EceEZpND02aCQ2Fai2syg==
Date:   Sun, 17 May 2020 22:46:16 +0000
Message-ID: <BYAPR04MB4965F2C39CE5854A98F540A086BB0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200516001914.17138-1-bvanassche@acm.org>
 <20200516001914.17138-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94fab8b8-e22c-4173-ee26-08d7fab41c47
x-ms-traffictypediagnostic: BYAPR04MB6006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB60062AB5092E85F8FC84DB8186BB0@BYAPR04MB6006.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 040655413E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/xG7c8gfCJ5tX79VnEnqMqX+SSzJvUX0sj5NQKpH0eW8zKyNTDzjgIVLDpDOxQnAWfS3XP/CWdUSuOFMRlQoa0lZ2TWrDchb8LKCS4qbWk3DKGJ1lLDvQQ8eRMQHO8OkqvdVUulnmmBGqhIv87U7gwT6B2gLRrXLPLLigRq64AwdCq5WjZ1l2JfsFoBjjdCUNaCEV2aPbK/nKC+qWgbH7FYt8sZWArzfIB6JxS0ZLTjHW5PG5W/Cb5GC8Dhwd/Fk+eRIhYs47uZqdiBSxZCMMD96KRBoiA0Biy4/F4eaRwbo7fU6xiWUHXpEzxpRJxZUVvGIPVeJFBLPguDK72a09I4GQGuljgLo7aFRgBN7NjeomaSCdY8vgPPCP8Svqw6IHby+GWhAQhworsv9CZRK3a48QEqPgca0lOTt9qs6aI8pfk2u4FkSacTyCHSbV7A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(52536014)(66446008)(316002)(110136005)(54906003)(86362001)(4744005)(8676002)(6506007)(53546011)(478600001)(4326008)(64756008)(9686003)(71200400001)(186003)(26005)(5660300002)(2906002)(76116006)(66556008)(66476007)(66946007)(33656002)(55016002)(8936002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: z8casxuUnPng8sosroxceW4HL9XkjhluBejlUPYfyXLlHNfmONVFUpIojsQTS4j6RkkEO5Cd2p0NSGbUaUlhNf/fCpwkc6Ok3yt9Mur5jNLor07P3UHt4QYuW0q/K0q846QMI+ZZZIyOCd4MEuL5bJ7q1eLsFTMNa2GUHkUbaCphBMMHfXhGIK4n6ilE6PWqXQbZYG3on1bGOEKohO47JaeRSbo1ikdI/sz5RiT5rjpLSr1c9A02m9fU5Af9+2RMDk2m2WcpAYK/tBaI7Flb+Zz4vIqE5cIkJt8lZDwxnXVtwoOkvVOvc6R0XZUnbvShNSX6CEGcIzTIBwxYEd14qcAU+YZS8zOWZEZFj3YsLXy7tF0NcA7K40YfmWIyJN1ApK4inzBL0qSenFsrKDupCp80kXYhezJXjw2RTZJCNscip68Q/8Q33TcreRfXJudVkjILYovdOJuY00tespfzlXwoPNccWlmRvgYzouaxwCg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fab8b8-e22c-4173-ee26-08d7fab41c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2020 22:46:17.0078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8R1yFHMXE0GUxfgUfcFX2aibRU9a0vQoun3RbIrpP/klzUC23+Nty5a8lTnca7aH6zS/RGWuK/0t+vZP4YINko65qPw7mFWIUXOJSPBZJko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6006
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/15/20 5:19 PM, Bart Van Assche wrote:=0A=
> This change makes it possible to pass 'const struct bio *' arguments to=
=0A=
> these functions.=0A=
> =0A=
> Cc: Christoph Hellwig<hch@lst.de>=0A=
> Cc: Ming Lei<ming.lei@redhat.com>=0A=
> Cc: Damien Le Moal<damien.lemoal@wdc.com>=0A=
> Cc: Chaitanya Kulkarni<chaitanya.kulkarni@wdc.com>=0A=
> Cc: Alexander Potapenko<glider@google.com>=0A=
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
