Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646A9C001B0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 15:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjHJPJz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjHJPJy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 11:09:54 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C4826B7
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 08:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691680193; x=1723216193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kzI4ykKydUS0sON10ixzt6RpbEHRz0kZrgFEYbImGvw=;
  b=MBdLyJ7lsiNFA9qLlwnyeqAE9bQyUftgLab/EXr0Raz1QdGM+5cfIBhW
   wwNf900UHRenYaKqAFestGs4uO0dvnbdhU+P6jfTjzE9o87Xd+vxNpUmk
   9J/BWwlIYYMp5byOr6HMvOUMsJ+gwrzp0bPKZxNgkTeHe7ZC4dyFXL2Qc
   H4qxgjSDsJs82fuEqx4cxL70TJIoBK4SBnDLdFOtwKifwFuCGJsLrS6pa
   KspME+kMYpBgvdo8VUlsGssLGTzaeckP7oeQittq3Fh9cgM7KfyMUFHw3
   HYjZiQS/mSuksQoolcNn3azfZHT25ZzD/ghncPVDVGr9iwnogPUGpjWRC
   g==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="345800636"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2023 23:09:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYzFL5T387183fdETBZ9QORZfHxLkY9PVILVVmSuYBJLyxnhPVQaHguskFH0GE3fuoejJ7p6NKrPPO+fGBouw2IRpI8TFOhoXKxmvpd0o2AyA1I0TjJlmvu/e7Cj3F2pELqvEcw/16ScV+ELj3VmtVwdZCI9l3qAfZyLjoDpFydsZdRcLQ9ZCzhUSH6Mn1dk11LLnqNkr6TTyh7JRrjvOA7Bulw6nIhljJKUXiUfiIKSf4gbgoB8Sk9BDt00VUy6rw/mbG8Hsvd1emG+WilTPTAZWP4HeHMTkDtVt6qW1F/N5dDBUvNdsOBGIgmfH5dNhW8GlabZdQVCFx0lrOLM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzI4ykKydUS0sON10ixzt6RpbEHRz0kZrgFEYbImGvw=;
 b=FVY+ALakMQTge2TZ8gcJvNUTawr7C53uM91EBJ4FuGKLDlARgNVN95NH077NesTSxY/ulQ9CFS/cd/seVhp7ds43RW9/OA4vnG2KujL5H8NOYfDzdAIUgIa/fWPqXC5qr37svlilxwLnH1hssbSefbaNUuhHA3I42xGan1TxitZa4pZF6iN1w7LITZBtOhYh15JnZ2w00KbVRzoDoyqIkaQvLWwC2LdsW0+qW9LzfhextssND4J0x0Sy65nDX99MYRSflJPrOI5gnqPR4ljPq+eoAqnL/lHHaz9+czyBs15S8bSePwML1kbzyMNgwsUnl9gkll7aNC5l2EtbCILe4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzI4ykKydUS0sON10ixzt6RpbEHRz0kZrgFEYbImGvw=;
 b=C8uwpdDOjRfHXEQU8vsMylxNBXtLdOPXhUtFwQ9LhyfR/cHKD06ljDzRsKTCRar+z6/Di1pMyhVrLjPOdGiFL9lAa1q7kXUi37QPaQtvoqmPDk9f7TX0mO2WBTsvWJbFxnQLRqhuWKxO8vov97cnqXPyPfi22Fi6L8sZ+MzDWdU=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH0PR04MB8115.namprd04.prod.outlook.com (2603:10b6:610:fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 15:09:51 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 15:09:51 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHZy4hMzEohYWMWrE+MOG55GSQMF6/jgPsAgAAN7ACAAAZMAIAABtYAgAAGSoA=
Date:   Thu, 10 Aug 2023 15:09:51 +0000
Message-ID: <ZNT9ua6noDjP+CI6@x1-carbon>
References: <20230810124326.321472-1-ming.lei@redhat.com>
 <ZNThwMBAqqVUGtek@x1-carbon> <ZNTtbpNCiXPvRlvI@fedora>
 <ZNTytlego591Zmin@x1-carbon> <ZNT4cjB7bh4jDaNl@fedora>
In-Reply-To: <ZNT4cjB7bh4jDaNl@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH0PR04MB8115:EE_
x-ms-office365-filtering-correlation-id: 89af18b6-1789-4bb1-9f5e-08db99b3d86f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YuoV2ku4x7b6x7gaGCj+3X9DtY5mpIKK78SCkfZa/8K/6cvDFAfJ+0GDGtq3IuKrhaN5VG34FTVqdyjfC+w4v/RrbFycOlBUaEef++xXVeiODnVjRV9GNy9TGXXG0PkSuwkFg/AL/QaXos2JC+yM2mJImvdB3PP5HUhU+3jBvAN+NBwR+ZuqUAPgdjxhqQAx8qZ4qOUnI4Ld5hGnRMnyded1DcpZV8DSgseLY7+C1JHHkr/yTQgdYJqUwF9b8JycywIIcRyj1i5J3P7qJQOL5PhWsuwjoEnqcrNU60MLZaiRphaioClYNfrwOLWa5M/QWnnA5BGwjk82v/pCcC6uJu2IXeByg/qxl6GWMnhvgKCTIW0/WPLrsiSaDxzkBQIaow6CaezH2RBuIHPm7YsbeWGddjPhdW0G5nG4358FFtKJpqqTioFMO0IrrSTTCNmWoSzuu76Ip+Xs7O6YxyDr6YvUTDjTEkU26MFIAiug7ERzBBjwUpHohcwmv31r31JvuvZNEjJPIGtTbEIdMKushZSmSxSRtdSHs98SBbJt7+qXRwYhVBfjCbb9/kk6ZBDRRfHM57XclqDL3ksCNbrBJlRgpKeoKerxC3me5jfxLyZ+N9Q8HZGbCvQ+iu93NJdseublY+ZEBekztzWvy2tCug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(1800799006)(186006)(451199021)(122000001)(478600001)(6486002)(6506007)(26005)(82960400001)(38100700002)(54906003)(71200400001)(66946007)(66476007)(66556008)(76116006)(9686003)(6512007)(6916009)(4326008)(66446008)(64756008)(91956017)(316002)(8936002)(8676002)(5660300002)(4744005)(66899021)(41300700001)(2906002)(86362001)(38070700005)(33716001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Cp4yN+5GZ78yYvEzbUBHLhbvrOjWPvsbWLz4M2NMp3nRZCDgVYNpM5cMpmX?=
 =?us-ascii?Q?g7uOFqGj8TcPxxEvYVM3qGZxdSfnmCaQMgoD7XP/yoeLxb36nMmMhyPCaxnV?=
 =?us-ascii?Q?XBmphhna6aGcFNk34VPSmTBWUg2uW+pVfX+yFi9tabkLuP/rM4+DCUNOPIfQ?=
 =?us-ascii?Q?TwJ1c7SNRVNOPT59n3G9S7FnGW71Ulf0sVyX/CD9NM/lo4B5OKMSO2uT1V5j?=
 =?us-ascii?Q?lYoF/cXQUZocKP/PwSCm0+OGUJUcbSRXQKUxn7VKY5J8PnT3798BlTBVoon9?=
 =?us-ascii?Q?mwZegXbaTDTKBI1s9u/SVgxU/2bSEHFapyBUX9E8HNb93eKEuLMJEiTMTzJ6?=
 =?us-ascii?Q?z8PYAOcc4Ftarm9loEidl5M31xIIZhvk6jQDQ5a4HRC7186gjMht30Y7Nkog?=
 =?us-ascii?Q?84gAZCxPKyhPhWFytA87vbNm8+PCalcGM6a0HL8VpY0lsr3qgqYCAJLI8/Vl?=
 =?us-ascii?Q?EkZl8H3u3uhICG7ePXq3zyEYHlGRwlQydheftM/QnCncLRqiGGeTNpFPgHQO?=
 =?us-ascii?Q?jcXjWXPwioGwBpxkev5A7v68UQrs2n1pkELVFFoQZqHkZEWTA8JF/9Ww8V6x?=
 =?us-ascii?Q?89oStnazARu/IkuHTtl9JAUJRUNYSOgXllyxGc6mfZxbpQEK1xGUdKaL/aCX?=
 =?us-ascii?Q?cZUIWkOO6KVh51ixgQfUN5ky/GVB6QNAMRcgseOAqHRTuHr3lpndN2UueFAt?=
 =?us-ascii?Q?BkA1b7yFc3LiNTrGCEDqjLbFW1ECs527QE7tGppo6drvLkRP1Ms52+IT+GLn?=
 =?us-ascii?Q?xalaA/U42ndhyfZ9ldMzV2jUZKd4PAtOmwAdkX6A7v1bFkB/PZEHnCzzkVcX?=
 =?us-ascii?Q?xak9nTmOBcqiqNKm8BCCqfSeGcayMthesUSgOr1qUSwFDYTXZkLX79e/fwsB?=
 =?us-ascii?Q?uiNEmRMi2x8Bb+R2rKZeDfllGwnTSqH1r3ZqSepTMXPVRluOY8SiCNKwkjug?=
 =?us-ascii?Q?OlV6AuZScOqnXbUJmz1+bxK4FxgQceUzjBjowMpduPPCvb7+2xoN7yUTfQFd?=
 =?us-ascii?Q?3Vs98GdNZ4jyVAEmbHq19+w5DfKi0yG9hpG6xfEIjc0jk5nmDvg5E3jlb4WT?=
 =?us-ascii?Q?T/ff20x1WNf+ofL1C65BaPxNpvZFau/wxxENxCqGcGO5gtoHk/NZvNbO8M2r?=
 =?us-ascii?Q?hNmcKMZ03qgbZIAx9hvz8WHwd4/vrAuCsznefVkX2xq06OliNjU4a4y70bt4?=
 =?us-ascii?Q?NKeV9RfPiOpihBb1PTgH/SaZQDmn8/zWL4iUkaYc9AQ+enu9ItZRQ6mw0XF4?=
 =?us-ascii?Q?26GkFj8B6sqk6Kj6D/ybwa7TgtIIVOTbIlK2dWnEvsWuwOZ+FDEVvjP3aA+h?=
 =?us-ascii?Q?FPL368RfCs53Finn73RgnjPf5493bKLwpblVyQoTj8SjutO8cGSyD6fo3LS+?=
 =?us-ascii?Q?T9dB75RxIzGvETsseSZjjuyZsSZQGjs+bD4DmV7Jjj+cnVR2YT1dcNsDKj2z?=
 =?us-ascii?Q?oZNZTBbvY6y61CPd1tR4zOwR0RzrN7kh6xSPB9YSBFkdxjmXXojY3sm487tm?=
 =?us-ascii?Q?djaFI4dmNX3ZfVInAsByxRJjHon9LqjO7ptkmtZ+9fmupOQbZhIjoMb6MD0/?=
 =?us-ascii?Q?JJyu+cLdKdQ0xCYGZff5o/WlBFCYS0EbEn3Gxk1U59EhDMUngYCFt7O4dGQJ?=
 =?us-ascii?Q?Jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A54D796BCD6B9648825637FA8E1ACF88@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aUQWhqoJVOZquEjcTSBOdQErAxS0NxFwoRN+8ycdOtgcfqq+jQeei/Rxse2QL5akIBUD6ZHpCr2qCl5OJFKxfpnLOVBZcG0eWURP601sL7Ss97FIiRZ4GOXVCJmY+xCYb8MRf63moRRG5RyXnX6LJH9vUWdKClThkVWrw7cRrVnB1eWTVdStVEH4L/nBEjjlyfPTLGXZWNe9Ln2RZNUeJjXvw6BrFBxN998ol439WQjU0H+YyGqrTDmE22r2Xb8WfvWBnt3am6kOpmf3++/2TQcx1EdJ//1RWG6gkoVqVWFyQ/SGkQRP+EQqPDMVFsRAA6l+nbjGpIQTJrYPH1YoX4o4BdJ4gmH9acIEMWU6HLwnVrbb39zEFA1YDl8SyuInCI7z7oofD8TaT7bk107iP8qHHw8YxgfoOoppptbETXON17uGSO6myCj+V7vIbzOIHeQP/OOkxePt5cauKIYZHvpS8tgHdxW00OZcXw/Aw0tSyHiGUhxfjuSDQe/c73P2LsZAKQDQDj4SCC9QI2KQxt7VJvCtvONuom9J9dnazzZalES1lESNkI8OjUj5KfE/biKmiA73aQPchXSNd5Bb8+xXf/XJg+b802k8FIDdK0ISS5OUkf2OdSoTTQKtoiv672ZwwtgAcO3JBdNtEqCyWGHYKi37Ed1nUWgyZpXCxrAgjvRcIcH3hsm+gkVTNfiJ1BEkv9EPaLykQI0NF1RC0gV1QrZLV9l6CWsHz+QP7B3PNeQHaIBxGCJJKAtkyO5kDOKJI0lj7CwIJGRTYmdSeL0UU+bURFqqkNJP8xafii42ZcCFIC+MeNnbz26uiDdw1nBthsUueDXufgUv6ujbqhg1nKNzScebPzN2wF1t26X8+e+asNdXG73t10WmtULGxSiRBERu3iN+InhX0Ke3wA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89af18b6-1789-4bb1-9f5e-08db99b3d86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 15:09:51.2156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6GXfhkb3AUUjEN9fgKDEpbStzGgpvWAJcuCiVUOlX+T+ST3zCM0N2xhETREdeO6BcmQP4NSN9mH8FsBi2PEIIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8115
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 10:47:14PM +0800, Ming Lei wrote:
> On Thu, Aug 10, 2023 at 02:22:50PM +0000, Niklas Cassel wrote:
> > On Thu, Aug 10, 2023 at 10:00:14PM +0800, Ming Lei wrote:
> > > On Thu, Aug 10, 2023 at 01:10:30PM +0000, Niklas Cassel wrote:
> > > > On Thu, Aug 10, 2023 at 08:43:26PM +0800, Ming Lei wrote:
>=20
> We have 256 OP available, which is big enough for future extend, and OP
> code can be used from any offset, but still more readable to group them
> according to their category. And it isn't big deal to use which number
> for which command, what matters is that we can extend, and keep
> compatible.

I see your point, cheers!


Kind regards,
Niklas=
