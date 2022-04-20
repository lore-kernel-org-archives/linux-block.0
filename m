Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C1C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 07:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376400AbiDTH7t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 03:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357036AbiDTH7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 03:59:48 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D32344DA
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650441420; x=1681977420;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=NlPgb2CVMXAgjkEhbAt+96Xb2Jhiql5fOAJ3m4mAD3QOaFFlr6gLrzUP
   +aFRNggKnIrXkLhWDTEzSOg0C5jeuPbMz0z0mbtw7V/jPubpeOpntdElf
   zRjju0e9Rvn/1eEKPUg2IGxMHWIbBR17dGZD8WtBgVnUIl1atcuUs7ycc
   jndJRp2Fa8GmOs8ApP7YzuRGY3nLfTu21b5XIXQPndRV01ZCv2rGzE357
   uuHNsGTYwguXNbHIt/jWsOvS+Xuj+bxxEhExziQr4C9mKi+/geWomfZBD
   tPz1K2+0q90bTHfxPYFY5jmCPQ3CRpQlQGDftHXck6EJiHox3tgoBi+/d
   g==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="198341847"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 15:56:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grbRHmwLKXe8noy31hGRXsglRsSf54nKJBTs8hm7mHtEask1GPkYLJv9BMmH40xGxKauiun6DPpUd6y/LpPlb4lZ5RJ4Bu9o6jP7FU3zsYi1tPKoCP1x+KvTTCt2vRljZAw05klvleVDn5lCRMZ9smyK7MTqkJ1x+/MTQnAt9kB1w7ClHX6nX0lxmgV9VufBiVgCaEte+7Lze+5SBnqogzsgeYK2V3YHNLp35qlBmiGnnGMVEQbIfwGC93dcZ02FBtrxw+62zxvT6ZsXsNGU53/K+qOdpps1gIOxKKe1j/n2VXBm/lBlxUA+9zx+luIKJnPFE1yQvx9yiaVGqUjabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RebhZkKkVml9XEz22wMkwWvivIDp0y+n/eWcHG8P1myhLZKqWK3ZqM4EAJeqxWDUlvkWDN2dwYSJz8eBIHy/GLn334An+9/rPd2PBmcX3/zMy/9J0mFrGaZ8tmnRjf+OPNRcacMcY1FdSlpHaQJJWK6SxKY7cnf2EKJRHZsW4FMxvHz8AQd8/Xj8S6jfi8EDJlkNluqqIBdqkUhzZcQS4giB6YorMxT4IHTdw21ouhd7pL8nBkz8069Yl0C3JimYRaZ+/NlmKsQVfaT0dvMVQiDi2kcWEHer+5+jytxpbibhvAnfIiqaeW+HwKzwEd255cjQC5mi55XFlsCnZAaPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=StDozwZ0eIHKMmQhTt6HBRhoEXmvhPMqL1r2dWi/fqUNjZRqyL7Js0l+12WNWTlkLQbuXC8qqxr3PGsqRp5UCA8bie7UY+zdtg1agtAg6xpB5loVRMzATs858NAQV9oTO7f0J2yiUp6JXtIbXIUR033B8fS4Lq2/qHjmRHS5Y9g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5556.namprd04.prod.outlook.com (2603:10b6:408:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 07:56:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 07:56:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 1/4] block: null_blk: Fix code style issues
Thread-Topic: [PATCH v2 1/4] block: null_blk: Fix code style issues
Thread-Index: AQHYVFHpEmydFqSUx0OliDqtfxXvXQ==
Date:   Wed, 20 Apr 2022 07:56:58 +0000
Message-ID: <PH0PR04MB741644A468FE0C96C3BB5D519BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
 <20220420005718.3780004-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b07233c-4c04-40de-a6cc-08da22a3585f
x-ms-traffictypediagnostic: BN8PR04MB5556:EE_
x-microsoft-antispam-prvs: <BN8PR04MB5556D5A5DDD81B5C0C2F4C889BF59@BN8PR04MB5556.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: prHr5yF96Pv9jeLN1EIyg++NoaK4wu7qH55QcZEY4KpPaTbNSeCrhpfA4s7raoiT3QccXINavXGg8yGCiWaLaNuU1E8iRSUyvyXt1RbotJuHPmeNwCdIeOvrNuG22ciBcs86+XrkXXsdYbfZvbgNL1B48WjU3zdZHxW1B3m21eJEZlX783dTNvttxrku8+XVNuVIJdOA3c60gbG4p/KeY8Fw3oXPIiDLft4DEFDnWB3IAedKOodVl439cRvMezcyzQRwQX24pK6MDxw6tB1ttu0ducsTUe/T5tTTXvmz7pyF0kWMf3QRi7xcbeL/tWi8WPBoEXGappmAw6+8BUA53kVrOmffB/5ZUk/oU0QpFpx/gIgBCneDRJC1ErjiOa88XlcNCrB4NXSUMkWxLgI3MyrPV0cQeKgGv+QSQzW921dZWz48+8bUoZ+ZA/Pq9j+599aui0df6icWhizTzD86Qi2Fjq2a1raz66aRwbwUnUaMq7jnxQX7r3PochqktIZU6ahJ5hp4Wnc2KWDyjjjhZvuXcyh73rMy0XKru9WeIlCepAOaZqDvPozlpX8HkREmbmvdZ8Zt0vv0fdUcJOxWAK5MUq5fOzj9oGRJfPxWJYrTXSEzs7tornESuNcBcYc0YZmSpYCgyjK0G+XUbwMPpwhoAzTCpRhL/2nnGwpRmEPj/m4T/h70wBCEZwvDVbqUE06kdjBaiEqdeAqKTIsKlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(52536014)(5660300002)(38100700002)(508600001)(19618925003)(2906002)(9686003)(7696005)(6506007)(4270600006)(4326008)(8676002)(66476007)(66446008)(66556008)(110136005)(86362001)(8936002)(76116006)(38070700005)(186003)(316002)(64756008)(66946007)(122000001)(91956017)(558084003)(33656002)(55016003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nGakRgJA2XVXKgMhzJBh09Z3NiBbiKBhZBkACXeEc/2lHCARg/cPJk/rPa3S?=
 =?us-ascii?Q?F5k02pBNTEokN2jyo1D/lrJmun99NcEBC19ffvW4EqHm46SlGlHkW65b+iuO?=
 =?us-ascii?Q?2yMzGQHyJvNw1X8zxmdtcGPp17+LD1CjNaOpdkM6G40bzXCNZAOK/dCWPyk+?=
 =?us-ascii?Q?h1VIBOUhzbhfIyrtUhi4fpEe29k5e3Va6ijr8mX3QbCCfdRnF5yWdx9td99Q?=
 =?us-ascii?Q?M6JC4k6Z6zheQdf2CDGAz2sk3b8XDcyk7b8ilQIhyj8Y4i/yM9ipE0NfJ2Qu?=
 =?us-ascii?Q?juaWK3KwadyyTtA7xfu44eepOdX1c5WFBbqyg1DYYi+WhiCTR2KiD15clatE?=
 =?us-ascii?Q?70IjPND5pS59rjzdeAUGi/y5GZ4G3Gh+LTbLu1pcRRQvM5RIovELFp0GI13e?=
 =?us-ascii?Q?ZaXqgrDqxSnMUiVfNab2wVu/CHdsj4oBI8dADnEickQskshLYuZNaC3RdJA5?=
 =?us-ascii?Q?h2BgZtOyGD+MJ8Yiqk6OpIScig8zo4GrUeIzOkdnlbAtBHi3NxRBByJ3RkJX?=
 =?us-ascii?Q?/SDbKeXbqKqQsfxWNdWI7/yhLa9NlGNfuD9SL3zpXKkWclrGdwd14OcQiRpN?=
 =?us-ascii?Q?p1ANHVXGsz78Z+4rVcZMRydyOcJxGDDIG+Xd3p8rJg/cGU8AuH9utu67XptT?=
 =?us-ascii?Q?Tavxgo6pwKhClemX7PXH3DwemVCi5cXjLPpTmN+XXDaDM5ftxmbRcQYsGUUN?=
 =?us-ascii?Q?+aRzS6coh56EuUNbkD0qaQ+L8qwEksCiz0+yfT5Sr+u/BAbBsyU0EIAIcn/y?=
 =?us-ascii?Q?aCI8ncr9N7KEhKKrzLjfVa+ErEhtwqPI6bmygGJLAFyezx2UMaladH/wgGuY?=
 =?us-ascii?Q?tbIDTkrPYcQijm8pphjEqILVuoegCp97i+mFcGfzfMOVjPofbzTeSRuA4Oun?=
 =?us-ascii?Q?c0DKcQQTVrrIU6dvPn9iyZMhM0T7Zkxb6MkK9AtnDAGmKmwzDb12mjFghu7Z?=
 =?us-ascii?Q?7EtwX1q0zx6Lk5whHQzSndCtGsjed25GDXWexr3IjjBRFe20CCDUkQ78rvvP?=
 =?us-ascii?Q?tWD0jC70+3+L4Gkmzv27S32zGqB1DIz2FmMYwCDAP1sJ9X+oupSPqVy62OYU?=
 =?us-ascii?Q?L5JuaqGdo8btNUbgoZTPcneARht0pDkkO1G2/9ML6GejCUhgRePEypOSHqy2?=
 =?us-ascii?Q?KtbcYVkWVEzA5PpAgoMqaQC2jGhBRy0CW3hTKc3XlHVwGtoBUAhxUQ4kS9jO?=
 =?us-ascii?Q?HJGm3KRivTP+1/gARLMkb69N586y2X6dt//YsV7qGXUF+j5RN7uMPrmwpS9g?=
 =?us-ascii?Q?dCIr/hMnR3zMRfnNj+HKRzZl6xaA0zKWdCC1xz+3Rfkbgq464O4TXbVvteU7?=
 =?us-ascii?Q?/NUS0LRKovuqs7A222N6mntuNTr+1I3jMiQElPPXHWz78BuaDm+QUmWKO0v+?=
 =?us-ascii?Q?fum9SJ3vUHLTSPRp6jsq8EI5eY8SFaKQY5GtNPBC6e4O7JacEI0u4TsxlA97?=
 =?us-ascii?Q?ixTok4ZqmPybA7PmcrZk8m0iSFMN/9UhNGVRdbZd+USxRPlMDoahlPPnJJXW?=
 =?us-ascii?Q?/JXogLL5KcUT3eAkUok18fpFSKBo3Wbs0Sz3imBAQT9/mv76oC6mNCP7EAqF?=
 =?us-ascii?Q?/HwJA3nFsbDwbXCgEiKgtCTjKctYOQsJClkCRglH6XGpew+3qzg0AbVifiNS?=
 =?us-ascii?Q?RdETeehkShE2s87EFyckEgDPopY6kY21CV+2gKYaNxm+ROR1PsdSCrwCuojU?=
 =?us-ascii?Q?So5gPIp02gHgYUTiIBcUpsUQjm0bl1gj1oDdZ68ZHSlvxCkKwXX4Cqzu+697?=
 =?us-ascii?Q?pGp+c/FsDcCK8mZiT30YyHHJKaKGlxdMzgBQjQHhOTigKlGg1k8rwIyOPsTG?=
x-ms-exchange-antispam-messagedata-1: hjTzjWwKa0ArJxcNQ+p+Ewvbiw/sfWiTAqBFPzNnU1/Hr3+XM1As58RP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b07233c-4c04-40de-a6cc-08da22a3585f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 07:56:58.3555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SsMRBfrJkvNxL8bW4qEqxwX5poa0+cVv0jTb/Lvhwpwd4BFr1SwjTkNvApQ1iT2W6IkirAnYHlBrN5a+Zn2tO2k1s+NerwdKhC4K0+Scr6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5556
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
