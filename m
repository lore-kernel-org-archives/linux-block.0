Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C189C54EBC
	for <linux-block@archiver.kernel.org>; Thu, 12 Jan 2023 13:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjALNSn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Jan 2023 08:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjALNSm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2023 08:18:42 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243481C437
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 05:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673529521; x=1705065521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jXtlv+/5z5wEBMiRbU95xIYzz9HQ5VDLW050MNEXa98=;
  b=DoMJIGs6YpOOmBKI7TTitY8VDU1yPTDKpgt2DvkqfliRoh4DBUKHvmb1
   w6KD05uiCxJVwpGpQwrB4GAK5SXTeJ+EqtkVqSo4uFil/VUg97vAFuWm7
   4pcy342wY9oSEBVzBqPVZDTqG73KNz0eR4sKHNiGTZH/pXSBGJJrC7UnB
   cZO2c03fE3d2GQOnqTSbuY073lBewW0r8JTee80dqcL3xcGa19UybbePZ
   E60UgDgUQDp+VY75yjZ8Al/X/yASxd29pFifcs+3VG0tuQyPSmQN65Hs8
   rRHPfMpMKIzi3y+2t3WUuyTAIDCq2+q1J4500eynv1CIyLfPaZsuPtn9S
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,319,1669046400"; 
   d="scan'208";a="218953931"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 21:18:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jak1IFro5BvRw5V57BuXxSTDk/gp72xKzKUB53fblE3mIEgNddE7lWcrImu2LtvaGMKOxeOSiGzZeqKTpdVA068BX8KhAqJ6qmfBDS2kl8kWbFUBF1vFL2t3UH69O5qVz0Wk1xwGzVgBG5dt499If7CHywvjIF2TDUOokDJA3K8U/iOrnapfdHI3xD9UkF63emsqejOjSgS0V/5NzEdg57swY9cmpf3tmAZStc3A7pUgT9E8Wd7iN4IOUhj2RKiwNFLsgnMXblj8wbAEdUO5sylugf0j5rvCpoci9h/R+8o5lStZKoXMpV20J6Pv6A2Odd22pRDJbcTsvTinQFb0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXtlv+/5z5wEBMiRbU95xIYzz9HQ5VDLW050MNEXa98=;
 b=Dekki/zPdVLlvYDKhwi25kkuoLjkNiIP42GUsVYjm2VLO8ptwOX4ik97J6y8UCUmrHI9w3QlNZX5Cscce0+c0pZGFiWAMRFc2rfn2Xt/SEZtULmT7zZKTjLp3jIZaIgB+I/qAIyLaGNJoW9GfRd3r6ogBv3ZCH+qAZDt2cEVwLAIDwGN/AKjd2WM1Gto50YxrhwzeyBWbT7C1duj50vHjKN9ppog6pANGhwXAFQXp9kXp8lHCkaWCUlfImXVwzI6wsHGHR09WcKcCkntA8Z7f2nGktIZvWU2MPdfAjXWB52d+RLcMA6GttIuMlJaloRSnXaecvu4/Yo6PDVMlI1wDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXtlv+/5z5wEBMiRbU95xIYzz9HQ5VDLW050MNEXa98=;
 b=RBTNGUMvbmoGdMYOUZY6J9wH6omUMNY0jouqI6re4jYvvhMAhzH3ZOyBT15o/hcL9qAdg68nXPO7OGPQauyqBjWv7DWZUJCjsnSWnyF189C31KGQNPzlEVwLtWivq4PgguO9XSS/PFqU/uOzIBFwklkJ79HVPbkm7MzGCYt23LY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB7127.namprd04.prod.outlook.com (2603:10b6:610:99::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Thu, 12 Jan 2023 13:18:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%9]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 13:18:37 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] BUG: KASAN: use-after-free in bic_set_bfqq
Thread-Topic: [bug report] BUG: KASAN: use-after-free in bic_set_bfqq
Thread-Index: AQHZJnpnPtmIPiOF+0WDV5g4YvQloq6aqkOAgAABqgCAABffAA==
Date:   Thu, 12 Jan 2023 13:18:36 +0000
Message-ID: <20230112131836.vvbckhhefjp5bmgn@shindev>
References: <20230112113833.6zkuoxshdcuctlnw@shindev>
 <6933fa2d-014c-8773-39d9-680ad9fca98c@huaweicloud.com>
 <3cbab38c-5b8d-131a-d80a-886a0febc692@huaweicloud.com>
In-Reply-To: <3cbab38c-5b8d-131a-d80a-886a0febc692@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB7127:EE_
x-ms-office365-filtering-correlation-id: f3d14e3c-0d16-4dd5-b9ff-08daf49f837b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hPrT/3RaehjkPwlWe75if1Wh2ndA0EcPmZKiK6of/cHN7S2XKqx5sF6dNy3Og3341/hWoAvFK5RnC5UuMLV5nDz5jhx2e0OmxQBRCXUWcbBhN3+UjklE0zLfd2iWpgvtd9GcNCQh5WYWyiMjtMkdsXSBQtsvXIWpTkpP8mbROReLlJ7XSwAFjOf+IkruXyeKpgKP37xyh3xy25GrQge+oHCMRdGHcrQSNZlLoUWmxUYjThAA1tRyejvjlbWDmR4XSK7fgVazINCTzIF1CLay0zl1Gkn7CCuNTULMlH0wQoBGte/oLKRNFkKI5bif4LQ1RU69BdQ1D3GqFOk9Ve2h69LwYCdHzW5zSLwu1KkdUdBJjzHZu5cVbfcCRUA0l0ui8Lc2H1+ubfOjHsFAskXTTW/bTxk+4k1w6+uAQ86TigNWY+dOBhxMZAdjJanMc9HiGxOiiq+2K8Df8PT+kkJghdJ6/4rjRgweSLO2DLhCWOPqbPEvASPfcNLeEnxg19qdPl0V+73h3hMAr3NTmNV+qQo4JmA+rPDiQumLXP75bxjBaiP4aAF3vSR159iEloiwLZigh/0h8vVQdNp4NFgd43JPLM8xS0YoqN7wIzloy8o51lhwRfd2NYEtYY9xiguz072bAWn6EFhSpBll3SezL733gQ1777pOUpdhNDd5Gjk8CtQ0GttpZetUtL0KS4tsFAddS9hZXvkZuKpog3PrDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199015)(6506007)(2906002)(4326008)(5660300002)(8936002)(122000001)(44832011)(83380400001)(91956017)(6916009)(64756008)(8676002)(66446008)(38100700002)(6512007)(82960400001)(9686003)(478600001)(41300700001)(38070700005)(6486002)(66556008)(33716001)(66946007)(26005)(76116006)(186003)(66476007)(86362001)(1076003)(71200400001)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVdNN1N0NWd4eFNuRlNyK2w5elE0aUc4TUd0d3IrSjd2SDhUSTc2SE81L0pC?=
 =?utf-8?B?MnlzY1BYYU5wbHFVTUxCYmZWU0wzbmhYUzVjdDMvSGpqYlFuMmFsbFArOGlH?=
 =?utf-8?B?UnMwT0s4Y2pzbVJBV1BJeEhHRUpVdnlQc1habkZsVFk1SXpNOEhqWHU3M1NS?=
 =?utf-8?B?TFZoVUswdVNaWmFIakEwa1ZWZm1EamhQN0RUN2tJMjhhS1NDQ0N1MEY0aWZw?=
 =?utf-8?B?Yk5nREtXcjJvL1VnWTFzeThKT3BhT1VoSXlIaThjVjIrY3dlVzY3SFJLZEFO?=
 =?utf-8?B?Q2hzUXdVRzI4aEdKcFdBWXpBUjJXeVI0LzJXcEkzQjRBbWQ0Vk90K05ydk4w?=
 =?utf-8?B?Nkx6NUNpMjBjU0U1U0lxcmpMSUhGeUpoUmZ3d3htdFB2MGJrRVgrb0FMNHhH?=
 =?utf-8?B?NG5QcjZNMG1UTTFZUkVMREpvaUV6U2NJV2NDYVNOSFNZa1lENFlYZzQ4ZTBq?=
 =?utf-8?B?a1RDYjBkekExNlhPRC95TEpNNGE2ZHZCZ1pVMTAveE5jNTAxT3lxai9SVUZt?=
 =?utf-8?B?VWIzRHdDK3R5WENob3JrS0c0aFBNcm90a3N0dkJaWUxQVmc1a0hZYXBmQnRM?=
 =?utf-8?B?aDlEZFNQL0l0U2d4VjdaazFET1lJNFFwZDlVbE9sT3YwV1BRQlAvTC9oOWZM?=
 =?utf-8?B?dHA0TXhDUDlvb2JGWXp3TjBlb2dWNlBXZ1NTN3k3NURvTG1LeUFoeTYyOHdR?=
 =?utf-8?B?TnV2Sld0UnZYRXl5ZFUralRHYno4b3RLSVJDRmlyak0zQlpmcXVrb3djcHdj?=
 =?utf-8?B?WDdDL0VCMi9GQW41Q0ladXRmZmk5MlhLcURabUJyTlZEWW92ZkRRS3Yrc1BR?=
 =?utf-8?B?TUZMdFBLK2w2ZnIyYS95NEx6K3RpcVZGSlZuRFVnRkJ4aXlDRStsazFSY1Ry?=
 =?utf-8?B?M0QzTVZvNy9XUVMxQU9hZDYrbHcvaDRUN2IrZDZUcCt5c2NRLytiYXNiWCtG?=
 =?utf-8?B?WUVuL3VFVDM2QU53ZXBaWlZJbmszU3VNbzFSalFQZEZMcDg1Mm4rZkpvVU9D?=
 =?utf-8?B?QjRMUklSOW1vUGMycmRNd2kzRVNseDAyVUx6amRTaDVjeWFiUmx5SHgycjVr?=
 =?utf-8?B?TDYwaDB3dDdlQkhZSDF3cnhrU1I3WFhYQkdhMlUzaXVoSmlaUE15Qkw4WWpM?=
 =?utf-8?B?YjRjY1dlaVhUait1RERrT1c0SmNTNEVqWXdhbzJTVCtoZk5zMnhCTERFRkF5?=
 =?utf-8?B?VHVxUitBd0JPZTh3MHkwMCtBNXkrUE1MaFhnZmJ4SFlBTUU3aUZiZXZZNHhX?=
 =?utf-8?B?T3BldVExa2QwRERXbHpGdWFZeUw5c3YxS29QTzdEOFJkWlg2dzBKYXh6dGUv?=
 =?utf-8?B?VGw3TlhhelFDSGd5blh5UHlWa1ZFdnE1OE1vR29sbWJGWWFQNEhwOTRsNmtZ?=
 =?utf-8?B?QTRoUTdidnlvNzRKakRVMHRoZ0k4RTczTndNRnQ1VnY0UHpiMkhTVVJkbWR0?=
 =?utf-8?B?bytwbEpZaUprbGFWQUw3TGdEQjUvWW44bTNFOHZIQ0pNallsV2N3aEVJTmNl?=
 =?utf-8?B?WHdWUU8vdmN2ZjFEVlR5dTMrRzZkdUMrcXBBcFBzYjg1QTgwQ0IrZTN1eHhM?=
 =?utf-8?B?YkNmaWhmajB0NElGTzArNWhPbjZrZXlwQWwrcHFpSkFUT3VuSzQyb2FiZUhB?=
 =?utf-8?B?T3hqckJXN0JucjQyYXZJeEwxUC9URTRzdkpSZmNyYVl5dDRVOUVUZDRzRjV2?=
 =?utf-8?B?RG82WGgzZXFwQ2tpd0JxUXJSU2RNa0xSMURtdTNyZ2oxK2lINkVrV054OFVT?=
 =?utf-8?B?aWFqcWg2eGQ1L1cwQlViZTIyRjduQ2pxeFNuSzRPQVB1NjVBQ29hUmsvak1R?=
 =?utf-8?B?eGVFamRyZE9pVis0Rk5hMEQ4WHhRUzZiYUIzQlJSYVRSeHBrSC9hQWF4Tngr?=
 =?utf-8?B?dWFUempqQ1BUVWpzUFNrbzdlTkhCMDBKekh2dDRxdVBoT0RPTjVZajd2aEdJ?=
 =?utf-8?B?YktPV3VueFJnV1k0MkhJNFpnZ3JtRWdIT2ZDNWx5dmFHRFRyRVM3MFZ6bVp6?=
 =?utf-8?B?T1c1SENVbFYrZzVUcm0zcGhoZDVra1p5cjNodmVGYW5xMTBZUnRUT2R4Mzd6?=
 =?utf-8?B?SkQ0dzFGQUhoTjhocXBQbUlxUFV3Y0wweEkrT0NxNDRWN3VTOGZYSm45ZW5P?=
 =?utf-8?B?Rmc0RUdaK0QzRHJRUGNxN2lkcVFuc0FRVmIxOXRlenlEM3VIMFFDdzFKb1RG?=
 =?utf-8?Q?mO4c449QhTzVReCn4PDLqN0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAFE59ADAB360E4CBFE1A5A3C0CB8E60@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nb3OfJHpBbjrrxv7NO5BmuQeHGuTlLqYrMoq/SzZqqw75tabnZ8SzPWJRDod98VPgma6sQ44aa/lv8RI30IkeCAj0zhpIcltQeWaSXMbCuw5CWyAe2ZeUCCipEi2u1E53EwzQ2W0EsRC7pxa5LJw43xEKkPtxN8jPNf/pgOULOzu1pi8HMdjCCP1Eod+3XY+DxjzQpzz1lmssYap0fmpps30rsxq/dFVqSIhAGE15KohElKb+A0DCO+lv/lQtp0eAKZ7x7xTm62JtdkV6N/CFAS0ofKfyUU0gIJTAplKPQR8NtqCKrxLiEFtSGsrOQKoWyS8B3/snVa2cfEvCwATD0ET+ZBjyJfXgqmWVbdHazVod56Pb7co5ZyR4dOkafGHBgQmsvkZYS82yuoWcKX+nVoyhZ+fDmGZsEDOH7bNo+1AimFeXbUg/48lhXRA+jI+eYc3WAZzBOzJ6RMobvhl6CbYAvwngmITNlR82NeOjvCoZh5Hmrr2ZwE6C6ho4kp1IadxiCkEcC91sT5Z5/gv7wXavVRkFLMCIn6OsL0IF+0odsDnVC9WI4jUiRctSPziO/Xp3FtsX3iDJucbEvAeBhKbTZGLAy8E1SccyLgM/Okr2P03WRzqQvkessxkKYaHxmZVan+3LnB4VwXlnAekLU+2lnEk6/0qFx4Io1XTtiOGIQiqpwzjsiQLq5obkJnntGk7h21EIpbdzy2AaQTw//RYnQy4cjzpx1+0GkKqai7XW+jzUKFy//KsGDjmKcrsJYbIFFs+Hb5E+nJazU5IRdiK6iOrJpoy1mETsU/+dqcpIEWCQqy0cl/96inexLORwAimFb+lT5vmSk/L3KsSlpLpI/sQcumsuQT/3Jh5ojiPwqE3fQvozVZ1cNKZqMo5GoxMG5K+h+TRco5rQYcerA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d14e3c-0d16-4dd5-b9ff-08daf49f837b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 13:18:36.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Dk4XyZRDZAgdWlwOAhhHNrxdDHWMQ213CgvS4LDm9k7SZ2bJpEHcV5Iconi8FYyGfNXIXGpOA/RHfrLvaNPEhwRoDkriPxyWeavz4wncIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7127
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gSmFuIDEyLCAyMDIzIC8gMTk6NTMsIFl1IEt1YWkgd3JvdGU6DQo+IEhpLA0KPiANCj4g5Zyo
IDIwMjMvMDEvMTIgMTk6NDcsIFl1IEt1YWkg5YaZ6YGTOg0KPiA+IFRoYW5rcyBmb3IgdGhlIHJl
cG9ydCwgaXMgdGhlIHByb2JsZW0gZWFzeSB0byByZXBvcmR1Y2U/IElmIHNvLCBjYW4geW91DQo+
ID4gdHJ5IHRoZSBmb2xsb3dpbmcgcGF0Y2g/DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Jsb2Nr
L2JmcS1jZ3JvdXAuYyBiL2Jsb2NrL2JmcS1jZ3JvdXAuYw0KPiA+IGluZGV4IDFiMjgyOWU5OWRh
ZC4uODFkMmY0MDFmYTNmIDEwMDY0NA0KPiA+IC0tLSBhL2Jsb2NrL2JmcS1jZ3JvdXAuYw0KPiA+
ICsrKyBiL2Jsb2NrL2JmcS1jZ3JvdXAuYw0KPiA+IEBAIC03NzEsOCArNzcxLDggQEAgc3RhdGlj
IHZvaWQgX19iZnFfYmljX2NoYW5nZV9jZ3JvdXAoc3RydWN0IGJmcV9kYXRhDQo+ID4gKmJmcWQs
DQo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKiByZXF1ZXN0IGZyb20gdGhlIG9sZCBjZ3JvdXAuDQo+ID4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKi8NCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYmZxX3B1dF9jb29wZXJhdG9yKHN5bmNfYmZxcSk7DQo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBiZnFfcmVsZWFzZV9wcm9jZXNzX3JlZihiZnFkLCBzeW5jX2JmcXEpOw0KPiA+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
aWNfc2V0X2JmcXEoYmljLCBOVUxMLCB0cnVlKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJmcV9yZWxlYXNlX3Byb2Nl
c3NfcmVmKGJmcWQsIHN5bmNfYmZxcSk7DQo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfQ0KPiA+ICDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gDQo+IEp1c3QgaW4gY2FzZSB5b3UgaGl0
IHRoZSBwcm9ibGVtIGluIGFub3RoZXIgcGxhY2UsIHBsZWFzZSB1c2luZyB0aGUNCj4gZm9sbG93
aW5nIHBhdGNoOg0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JmcS1jZ3JvdXAuYyBiL2Jsb2Nr
L2JmcS1jZ3JvdXAuYw0KPiBpbmRleCAxYjI4MjllOTlkYWQuLjgxZDJmNDAxZmEzZiAxMDA2NDQN
Cj4gLS0tIGEvYmxvY2svYmZxLWNncm91cC5jDQo+ICsrKyBiL2Jsb2NrL2JmcS1jZ3JvdXAuYw0K
PiBAQCAtNzcxLDggKzc3MSw4IEBAIHN0YXRpYyB2b2lkIF9fYmZxX2JpY19jaGFuZ2VfY2dyb3Vw
KHN0cnVjdCBiZnFfZGF0YQ0KPiAqYmZxZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKiByZXF1ZXN0IGZyb20gdGhlIG9sZCBjZ3JvdXAuDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmZx
X3B1dF9jb29wZXJhdG9yKHN5bmNfYmZxcSk7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYmZxX3JlbGVhc2VfcHJvY2Vzc19yZWYoYmZxZCwgc3luY19iZnFxKTsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBiaWNfc2V0X2JmcXEoYmljLCBOVUxMLCB0cnVlKTsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiZnFfcmVsZWFzZV9wcm9jZXNzX3Jl
ZihiZnFkLCBzeW5jX2JmcXEpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAg
ICAgICAgICAgICB9DQo+ICAgICAgICAgfQ0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmZxLWlvc2No
ZWQuYyBiL2Jsb2NrL2JmcS1pb3NjaGVkLmMNCj4gaW5kZXggMTZmNDNiYmM1NzVhLi42ODcyODU2
MTJlNTcgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2JmcS1pb3NjaGVkLmMNCj4gKysrIGIvYmxvY2sv
YmZxLWlvc2NoZWQuYw0KPiBAQCAtNTQyNSw5ICs1NDI1LDEwIEBAIHN0YXRpYyB2b2lkIGJmcV9j
aGVja19pb3ByaW9fY2hhbmdlKHN0cnVjdCBiZnFfaW9fY3ENCj4gKmJpYywgc3RydWN0IGJpbyAq
YmlvKQ0KPiANCj4gICAgICAgICBiZnFxID0gYmljX3RvX2JmcXEoYmljLCBmYWxzZSk7DQo+ICAg
ICAgICAgaWYgKGJmcXEpIHsNCj4gLSAgICAgICAgICAgICAgIGJmcV9yZWxlYXNlX3Byb2Nlc3Nf
cmVmKGJmcWQsIGJmcXEpOw0KPiArICAgICAgICAgICAgICAgc3RydWN0IGJmcV9xdWV1ZSAqb2xk
X2JmcXEgPSBiZnFxOw0KPiAgICAgICAgICAgICAgICAgYmZxcSA9IGJmcV9nZXRfcXVldWUoYmZx
ZCwgYmlvLCBmYWxzZSwgYmljLCB0cnVlKTsNCj4gICAgICAgICAgICAgICAgIGJpY19zZXRfYmZx
cShiaWMsIGJmcXEsIGZhbHNlKTsNCj4gKyAgICAgICAgICAgICAgIGJmcV9yZWxlYXNlX3Byb2Nl
c3NfcmVmKGJmcWQsIG9sZF9iZnFxKTsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIGJmcXEg
PSBiaWNfdG9fYmZxcShiaWMsIHRydWUpOw0KPiANCg0KQWgsIEkndmUganVzdCBub3RpY2VkIHRo
aXMgZS1tYWlsLiBXaWxsIHRlc3QgdGhpcyBwYXRjaCB0b21vcnJvdy4NCg0KLS0gDQpTaGluJ2lj
aGlybyBLYXdhc2FraQ==
