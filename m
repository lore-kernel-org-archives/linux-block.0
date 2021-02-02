Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1D9C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B2F64F58
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhBBJ4k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:56:40 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33601 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhBBJ4L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612259770; x=1643795770;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MNSWFEU6o5QFgQ4pCECq4D3Vk9pKAlOlbFa0sVC/AEQ=;
  b=T5vyKParCZ05EUgsl5mBYfuF+56D7owkfrRZx60Z0dWEmUIW1mAx73TA
   yyv/9kb9gCuw2pugCaqEmGLMnTHquRUJpVeE7RPnFudZBYDd8TJDMPW3B
   Yfc+26AmfG1kQvklXOJY2w2fetpH2LS7u5lE9QQPcbnEsonN2lx47XA4b
   UaDRzxxHjrriEhC/5DoggnwEmcB6LIHMN4Kh7nf8YtgQaCcnb5AbEySdL
   gzAZDEk4gjSWnh1Dfty3/3blXpPkbXzjK5trMj8145XHG/U08i9uuvcJl
   GP+7nr2XBy2QKr8OsVXjVYD4QuFJuhkfZ+l+Fjj7wP67Dj8v0yS2gr+CE
   g==;
IronPort-SDR: 7YczTTbg10vU6v4pFOk4PapAgpQLhzzDqRWM7UjdeIehYBengleqT79IyWeMeBPqbuwgKxab6O
 PO8RgekBrfuGNxKc5uCipI4kr8CEm6RuR9sqPWGKe1tkTvXDP2sM78pfsnOzk4HB6+knGQsREl
 TRNe8mNlsP2arLeTdUaix46AkAEhk6fiQmxFcLJeRWor1It9OVNeNRlbvP8pyMhI2KqS6Ai1t1
 l6kbWeAD6gE8P3+dn5IUxWLF9jUjB9TSHo4N5by3Pr+f9TMVmzzIavO3QUkrx5uJ4lBNtczbGf
 0Js=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158906145"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:55:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wesa/d9Q/ItI1B3tl5x/G7Z2aWqm72SFh2PBut5NEog/oTnHLDwcyE4bnkyEmFTAGGURaneg5q58tTvznsq1xmeTT4+XV8sNPtdWLsfVDwKZNmKfx4oZPJXkRR5BU6YZfRnqhNBIAA01XDDTLcNG8MEDR4Fhjw2Tg3Y0/nPS5UxfsphXW8FJvAFDWWHxvAkGXjSDPNU/kfIJvIhZfkcCAazsqN5l1n/2sfMd2Jnqjz7yAi+ShPCGnyH+V2WUx8HDXYnr8cq1zyyUUB3GL2juj7WUIrbBdaP2rptlBszv29Cafl0NYaJ/Qa8PMcjgfSacFA/AfsUKgyDBiCL1aVb4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4SArLOLGQf6/eSu/H/3/dC/6rKbE30JZ9sbdjC+8S4=;
 b=M1MbXa6gB1rI87T8/SNsuwNEckt5M6ecnWilDdg70/I0hGWViC3duke7teAJca0aLJKXjKjk1GXef8xt62TmT0VM5/QOgaj1OMKKGi+1+cA7ReupCrDrQ25o4sFE1IHmHSqOxePI0MMkVwtWApMgMXRnwMC8zVWH15CtSJYaIxbXSp9L6ehVX/eGJs7LQld5Gm0t3Fn9jrHlfK0zl4OWBNchDNYcDygTSdYI6VdOzs9wqA4XE1/p+c9muioM9WjuEUJIrur6TTRh8h+hs5H1VWSN7r/w4SUdcCT9pZJRWiEOEPEtZcmDkhA+33w9iDy/USEIvqrJ35OS5ief0JfT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4SArLOLGQf6/eSu/H/3/dC/6rKbE30JZ9sbdjC+8S4=;
 b=wmoU4qZo8WPG9cSfkrTBJduftNV1AP8Mz1pRmPnr3TO4KGmCdgXEJvg0nOv8kWxOMfI45puUsDJm3QXYpsflfoHRWn8bm1ERZUiiTHs+BmMQGyPrjuj1eCh6I+DyW6x8Od/9My2QBoxJNw4vOAGH1m/e8iC9FAl+KwUUtYVzPz4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4319.namprd04.prod.outlook.com
 (2603:10b6:805:31::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 09:55:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:55:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 2/7] blktrace: add blk_fill_rwbs documentation comment
Thread-Topic: [PATCH 2/7] blktrace: add blk_fill_rwbs documentation comment
Thread-Index: AQHW+SPvQ+VZVj9GO0WjjX5Zm8+fvA==
Date:   Tue, 2 Feb 2021 09:55:01 +0000
Message-ID: <SN4PR0401MB3598E08720D76952488133A39BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1d1f445-1aee-4920-c895-08d8c7609bbf
x-ms-traffictypediagnostic: SN6PR04MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4319E922D02D66122F4D360B9BB59@SN6PR04MB4319.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYRP3CveINJ3G4H5elB39sqhTFVVrdBkf9Yt0KT3yAug4KpMhYlb9gfUc1tTUTDwZVC+B0eMWiV8Xq4ab13+PpJMlTJeEoRQDJy/3j0AkxfPIASfVNpzq0GZhSSicinkQy73n6EyVCJwFmPXARt6pggdHBrpE9ZFk+eUWE8On31T47Gx+p01VWOq/nLdFpkzAUr0fEzXWpZawJPTTfQ8g+1QE8cEi9CCPU8QLV/xCX26wT3JLmX1QQzPGyyzbI3lYzow56ZU9OGC5BOnS9GE2dQiO4AMGzYBKP8xz7/fDjs2voQP6Y9GFhbAAk4HGOkXhpg3OMNx1qVbWF8+gmE+EsuqUK5v0jGNnDy0UK0X5IKmllpIlnOETs1meZl+wZQTE0ztVjVAJ0wB8qMbeQw9NLQ6jtEvw3iq5bwFw9dmAdg/kAL6+NDdfIie/i2K+jdb6YF2fusfiAsNxCoEuefOGyZGV74GISKOVPFXxnJjB2CeJJS2B8z96sb6hTd9fUvY/i5PN8shpTeqsrQRvRJFaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(33656002)(64756008)(71200400001)(9686003)(316002)(54906003)(53546011)(55016002)(7416002)(4326008)(66446008)(6506007)(7696005)(2906002)(76116006)(478600001)(66476007)(91956017)(186003)(66556008)(8936002)(558084003)(52536014)(8676002)(66946007)(5660300002)(86362001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AK1cpIUJvz/YkrJNYOxgcC2BxLetn62XQOCE/Ybzkz/sX6ucb6aeMV8mOSph?=
 =?us-ascii?Q?Hw+uJOaFdQoxabDj+VxmZ8VdLxD/iMoPW2u+LyavP1yw5eC2xwyfkJ5RI3WY?=
 =?us-ascii?Q?3DhsJDjxVd1FGTk9z9LpKRQ+EMFTR46Tf1cnpDmWAYbGQXLiL8GpK1wy1a6x?=
 =?us-ascii?Q?0EBxZTn+dyDglOvaf7BZG1rVg+pec/5hUpXP7mUR/18yLPKYRtwEji66fD8r?=
 =?us-ascii?Q?osTcs6dOxXTzqBPaPaHfmLXy3HC5x+RrE0DqP2VmEprn4Od24KSDfe0r2ap7?=
 =?us-ascii?Q?kEEZvy/SDmQeCzs2YL+XmvEhmvu8vhiLzx880HBMgRp93aYxwq4n+StQDo+o?=
 =?us-ascii?Q?EimG+5TArWuvzS4JAmnRXMvyl5LLHB6zdQwEdR0e0f2VJsqOGTAOKG5ocNx7?=
 =?us-ascii?Q?M4J4YQ0vO4NhZ5X07860IRANePwBn5gMpK6u8uM9mlXCY3IwR+6tCQrhkym4?=
 =?us-ascii?Q?NxV2TmaGh+xMmOXWKeqnNm9l9Jfv4GQS56fz/gsA5NjTdvnzRH/ZmWZQhHon?=
 =?us-ascii?Q?beK8LZDT3vDKNWSTDulskkrbpj9C8wAv15+z/SOsMnwXoJ4111KXrXBxgVh0?=
 =?us-ascii?Q?jh3TpfltH3cY2mJdyd7Os2gsYr+PenSMgM1E7I0TUfaE7qDwdr5T2Fy3kfm2?=
 =?us-ascii?Q?T6uIc6rZbIgpg44mh+u4jqX+GEJEj+Qh7GU79Z80lzQL17iFx2aJBXOnjbui?=
 =?us-ascii?Q?XW+wsxhj6V4MJdwJiH3v9/MuHBprEmxENz/sfxIQAiLEQNWQgJEVq3jaHRpb?=
 =?us-ascii?Q?xOkc7o79zhAtJfFjcmqnva4p3RdqmKv4TrQA2USwVCqInXGXjZmHSDb30hKi?=
 =?us-ascii?Q?YlLg1I3giCf0RIk74lh3RGvrVpYLVL+cZsTuzMEMAGJWpPh6VaZDddbSv8sD?=
 =?us-ascii?Q?juDZHerkvIC1K88eFw2afJtPTn+sNb+avT8bbuQnm/3yF5spc6H7ntLC96Ew?=
 =?us-ascii?Q?fp/S/+9blo1Ag/BVAAnCIYypjj/cnZ3ojwK5q+zD13w91Xl2ifRvVoo5kRCD?=
 =?us-ascii?Q?b3TuSmPK2nNGT5l3MYUdE2gn8vMI2TaKXrG0NmIHS6yvdxmeWt54zB8m+zNV?=
 =?us-ascii?Q?1jaGM4+RSqsCkZIpR3hbhRXiPQUq3b6GYNJK6p17XiV+pEUxnAS7ukdKovmW?=
 =?us-ascii?Q?SqOj07QkrgvF+zbCVsZp4sL1d/tgCIPq4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d1f445-1aee-4920-c895-08d8c7609bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:55:01.5550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BSHvj8ePAvRqAbz+NWQj+umkSx1zWPPFhnZsB+AIRsBmukfFSNlOxRqSkrR3ZG5JFV/JZcRycyDiLS98P5Frsdv/f53oDpj3YknbeBYxdCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4319
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/02/2021 06:26, Chaitanya Kulkarni wrote:=0A=
> blk_fill_rwbs() is an expoted function, add kernel style documentation   =
            exported ~^=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
