Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE9FCCA47C
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 09:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381347AbiFQJ7x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381020AbiFQJ7w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 05:59:52 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D76620C
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655459991; x=1686995991;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=feQdXVN/toMBd/HXYx396sgEmOvvaUekA6ATKMZsBNOkBRrnzyN1SErR
   ROTGNDsbwg9a197t3PvkQYQx+pb1RInFp0tH73lUBp5M9fXl2oAU8TuUT
   arEjqERaebFjOjMWXNrgYFUZnTEr4dY1L+W8HB8V7Q/rL2cIB0QvQfn8o
   G+I0+MnWs+Qi3p0HZT0xH6jrfbmPBozrE2et1VbaPZOzn2p0ZZUhp2Sz8
   0O7k6ejzW9sv2l5pALWX2mTslwe1UXpSiN6w4qHFOxSZhJXSi5Uc5q0XE
   ohEJ2lss0OTrMqHavN/0eoiIqcB3t2ckSUCRMNwBf/PBsKI/U/EDKBfak
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="202125235"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 17:59:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNSGAYRJ6MLBfl5uznnZT+4hLZkdR2j9ayi2rPeTzP/IuQLugjCN8nvcJsWv1xuiqNwcu9kQScBkOCX7nSVlkxj8Sio+kHrBRa9bdJYMcYVhjPJhCjT7FJlRsLL560WspYI9K5+xH1MlbFxC75nx3vMM1GVilL+Eg45E8vd0pyls2YGvh3V6BobUIe4WCEfM4MixsyiyJyimB7XTRj66sLWpBACPPPJx8NJxwMmJe2SJpDvyJnl2XMVkSMUUPlP072ZWRTIL4zxIm+LDLABRgesrd0d3q2JiTLhoLdXe8mt9ta6xOW/J7GziKez/rdEQBX4sZugF6quIR/OgFGLkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TQhVDLJjvVZJuxIa0UlLC5bKqJw25g2NukcsvPA03ovMjz8T+62WUMUZo2LImqKXlESCEmpviJV41Evoaw5Kw9XviWOmvFQT6KLj1wfNTlqol/ww6TXlQzO89fNEU3fycanvGIgC2WkhLxX78Vk7fsImfFiOg3l4QiSft27CNc0Z37bZVUR4Bt3ks82Z7TmgzqPrETb1iGKx5vOY/GVntZrdic7jsBV4e1us2Fk4d2/M4trXRtncNFZJxoy8ipqnVvymg4/9ACQXrAQGBaFjIIBj+ijAGI6I3XRafzPnT75fsaD8LKoQAPB7mqgq2C6CtBGaD3mJF6x8MXQVyEZBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=kdLZg3HbcnxWQkJZPBOb38OBiFDikSVxHR2FZc0hFfH+IHuE1gZ7lFz6xSM9HpDZd0ncM4ZaDm2sbHUFe+oM1vWUg201CWBEM0Zhmj2E4qY6Y/lKAyOBSokXuAavf+bNqjdijyUAIK41/4w9Fqz1vsCxQvdx/ZYqLAsEzxiQw1M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB3933.namprd04.prod.outlook.com (2603:10b6:805:4b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 17 Jun
 2022 09:59:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%7]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 09:59:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/3] block: Rename a blk_mq_map_queue() argument
Thread-Topic: [PATCH v2 2/3] block: Rename a blk_mq_map_queue() argument
Thread-Index: AQHYgPsytwi0FXmskEmJx0XhPO6aHg==
Date:   Fri, 17 Jun 2022 09:59:46 +0000
Message-ID: <PH0PR04MB7416047B546683AB57A59B3B9BAF9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220615210136.1032199-1-bvanassche@acm.org>
 <20220615210136.1032199-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d9cccea-a17f-4b95-ef86-08da50481c34
x-ms-traffictypediagnostic: SN6PR04MB3933:EE_
x-microsoft-antispam-prvs: <SN6PR04MB39331CB12D83CD71D73C27DD9BAF9@SN6PR04MB3933.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DcljfiVYdU1dgXSkIzZiADlCzsxfvfBjcMczks/dw07mhD+pMhUux0yd2kwpzunVXaBQDMKhuGYKEoIQxVTX2b3+191qMVPOmh69oepVKzKMLe0xEad+szxRMT0GT8zjVuFNyPBxsFaO8cd2uXGnkMzhHX90/J1a8uxFqGLmrOvjjXPo5IRqh25xdRg9qijlYDPX/NFgJtayOjLN5vla7ooJ8rhtq3X/Arr3PbfBCjZCgFSLwqOOHLPlN49CYHywQ2gBVXv1bE5IVnHnJUjLK4dTKt2LEKWe1+unNgm+pWlrGpj84HHZh3qFLEooQGZeOoPEVKFoIZJQQtVycPLdf9Yy4uPlDVZqiEIwq0UZJZbttCCCaOnarDqmoJBH96Z7PvNRRsi4AxO3cHkyklpDB18mWaLVkcB+2v8tlUWZ/mEFtKfRjz9poNmWtYcyMBr5ns84oWcxkuwQzuS9sbHNOkcPZP8wHdxQyLOLV85p8YOWm1gGn1Cl9H/7O1Du6sccyM+AaYaAzEXDW6TsfHRRAikSib/AfX8z7fBFdUgfWtQ0gC0+B490qpZ9tbwKYaaGQDrzjwWBR63kfSlb8fvSTvZc/7YhtTj4J7y4qNiMWQlHzQ9WVsyyDslS2HPAfLvSMubCAu96EaGs0qFmxGGaS8k5tERYZP7Aj0eyJMKjO9h5SsOveLYZh1Vhtm+DS9v5RphFfl4vmSh9huLMB8N6nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(110136005)(54906003)(316002)(498600001)(7696005)(19618925003)(71200400001)(55016003)(66946007)(6506007)(76116006)(91956017)(52536014)(66556008)(2906002)(4326008)(8676002)(66446008)(66476007)(64756008)(5660300002)(8936002)(38070700005)(558084003)(33656002)(86362001)(122000001)(38100700002)(186003)(9686003)(82960400001)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DPEwwzitOoRZkFgsyfCPqhgrzcpYcL+qEhmzDHumpdzmWec9UBbY63N9p6Dw?=
 =?us-ascii?Q?ax3gqMpcUexCPhKo4qWPfD8wiM63ixm9S7MIZa37J1k/xs6bZCyCtS6ZPXyA?=
 =?us-ascii?Q?OB/XqK8uquhApTMnp9gHJocg4r+AoOHG2v2qeRYy5gBDda+PkGotU2T3Rd6w?=
 =?us-ascii?Q?9wltpsQmDEoT1DevYp10z7XTK915OpMZ+hfdaQwyDhOFVcNxUA9R0lnOh/gt?=
 =?us-ascii?Q?87EmekusT9bc3eeTjTeUqYnVDyqxlkdFILrM77tvCrddMhG07/xX3Xcv5/X+?=
 =?us-ascii?Q?vQqH2cNVVJvOIr6ZZYtYl5hue/70P+Gntp+1i9P9a9HpoDFANvWTslXc6oAq?=
 =?us-ascii?Q?PG89jv3vaBaIAQuObZbh3sqqGASdlQgEizk3n9tQqtx8q8vTsrulIoPUuy4y?=
 =?us-ascii?Q?c+1c4Re+I4VEnCZ8hGY56axH+ta0hclFUMtvJjfSkQJPqVk+kTQh9qSvbIJ/?=
 =?us-ascii?Q?Luji5m/LakKX1TIi/GqabjGaDRUi9JyLZu8xOOFI+I357HVazmBow4abj25y?=
 =?us-ascii?Q?kwYwdBGU2g2vrC+4FMSq7CkP2CuxbH8hdVmEkFp2M4CNZQaKhXfgq4K21ruf?=
 =?us-ascii?Q?k4CPYQr/8qbpTjyIFZ3U1sNFf4Gu2rXar6f26fIj9/zo+IfRzKVpJ0yJs5uA?=
 =?us-ascii?Q?bDLf+rMx8Yq/osIbMBXsdZzxQ6GF0YMgR4kVIzQ5tQLgRwz+Ta85aHcQaD3P?=
 =?us-ascii?Q?H0NZMcemEY9Bjm2/g/bvdcRzLGKaJvvuwFZv5wgfXBqqnRrvgrHkRzzPY6LT?=
 =?us-ascii?Q?Lnx2lstytHfffDUI+PY8qHRS88cdwlKQ/ZMVneciRSOSP//NmcwOW8YDo73+?=
 =?us-ascii?Q?pok6wa9uagMAN7WVZs1bqj9yMCqz6815/VQy90XYP/1TdOgOE2vhLvrVOJlQ?=
 =?us-ascii?Q?lSD7MDXOEuuHd9Egs0M7tQ63hMEjB/cCw1TNcqVX2YsVx0jV/07OV7YpFARX?=
 =?us-ascii?Q?KOs9ikFmrKedva2cqdFnZFCIPER9GMUc41rNh3M8xYBksEPxhLAxlIB/MWHa?=
 =?us-ascii?Q?YAzlWZSxzYuk2S3Ue6Tti8OkGPrHroT6KN2QF4/3LkMRPTahhtkCcdyAdIBi?=
 =?us-ascii?Q?A2wTAbPt8S6QQ9K9PQsOdHOGjkl6fwRyllLji8SVuDAgTSfDhu4Qvj5JyJO8?=
 =?us-ascii?Q?rLECjZIRXZnDfRxsijr+RlF2+o0AMXb35aaCzvwftqQfgg2rObC7f2g3c1jo?=
 =?us-ascii?Q?bNA4V50jiMQ42kCopnq5GyKVkcH5cvQtDizVoBWcVU35t7l6mRvcXyVmX9Zi?=
 =?us-ascii?Q?DmtCtll/gXxK33hGYzeDkr9JEDwC6iRTFcZwbLW813WqGe5RthBv6+1ZpqrG?=
 =?us-ascii?Q?/tcaovU3+lAApSnoI+/OKbeK4u8kdFH4rAkh0Qkg2ABS7l2O6XEVZFQrp0dv?=
 =?us-ascii?Q?XLY3wmwaDS1mbt6S/o2a6nKLloS1mA49SFWPJ2acPC1qDgmdqSJ5Yh8WKJIb?=
 =?us-ascii?Q?qGYX1MI6eut+5+tPvy5ym43gtpyCZOdbX/B4QuI+6Hd3SyzysbxYali26upI?=
 =?us-ascii?Q?tp3qboOh38Tv1rzAZSXU+OAfZ9RUMFP5GfrRGrF83uWm+e2W1zGu9CcvlPvh?=
 =?us-ascii?Q?KIHTCmBKeWJqlRMRaqk9ZUn4Hl869YKFgRh7MCQ+tNErjnY+ocPCPAgWVN/0?=
 =?us-ascii?Q?CPXNC8pSjBi4vH7/ibMnD5E9QcMztHeH/V2/BEDS4aPjRoNXmHjYFpgc0bH2?=
 =?us-ascii?Q?hxE7DEbw/xJ/xwTs89uFKZe8/DquQNwJCyBsIjW28hXTkrVECk+Ag2d8Jo1s?=
 =?us-ascii?Q?zIEihAV7TKSMUvRSDikxslg8ZgMJCGHQmY/ROzvYp+Z1USlEFrGwZF+2DhHs?=
x-ms-exchange-antispam-messagedata-1: wHnFUo6pAEDY3ebEtNt5fq8sxffbWfBXjg7T2iyyaNtbiktyFb5NxHDd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9cccea-a17f-4b95-ef86-08da50481c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 09:59:46.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ObFriiZjaZDPDoO9oG5H9Goy4nNc89MDThONzn4+z7hCeTPR4e8C/CUKnAZuuhMD2IKOc7p57DmgOrucFaq6PQD862NFmZJmziFesNQTcvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3933
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
