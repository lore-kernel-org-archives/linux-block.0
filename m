Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E9C61DA4
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 08:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjCOIx2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Mar 2023 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjCOIxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 04:53:24 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB75E618B2
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678870394; x=1710406394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=fEZCb2BmEiwkHQmTCV/LCdcY9kZBiX3N+6lbNlAzOnpVZaff6EYVGyeK
   MqrYttIhgnW6gx0CIVVUlpfTqWb/jaftHM6lqN/ecrRZZx8MccwBL2TRQ
   ZKITVe4h1aitlT5jvRA2Jlx+Iah/8KAEtJ5pOs4U81ByzDSVitsPCbt2+
   oEzfhtqUmVLRMn3NwQ+gGEqNpLQUIcMho3Ih/CR8r8AmFoSDLqF2gLR7U
   C8TLTFubt2kdFBSZHPEiaGkJcuNKg1YAHSjpmTjmM6dUYo9/P1MNgP/zE
   EaBheEZQsNWP0AIf1pPXGeOuK3vITAzhjl/JR9biKQCrVZt+HpM7K80q0
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="223958538"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 16:53:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V43RcdDLYghtFuDN9ZVwE4jD2Xa0eTzzImUBAvhI4Pi4CrJYiGa6DpbwZc257CbqKZPorhmW9fZxKxHuBfsDXx577NDezg9EKIOrRm5DwO6sDZme4Cq4c5XBoo6liJpIBr3ZtB0bufzqBRLOEL0dhHwptCqfCJOpHiqCdS7QCciqkpU5H7xAU8BBfd+2jdWCgCaRzswj8rULK8jfD0LCzgHUVDQH9LnDIyIsGDFEWJKu5vm18wLCNWSN94w5kVtD4fBn4IQJxSkxMEdQuOEcWN1IbQpqwnqgo68VELqzTWojcwaspSC7I94+cVXE+8rL4VU3JD2hpvthqBmPFo6DQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ENVvhN+SAyaqottqLCb9bZMgcb8lPgzYp1WC2oKQAmbfBXihh9MA6vnBJpJz/L6aguJsnXtejGT9vIjecm483dcYvy9EAV88ETJ9wnKR3EAoxkNLm4+vwCWN1otqMbsvVj0EKoK9H8XaiePY1gPUOzgogbgjMPRRNpnibLpcWt5InBh62MWxbB4U3QC5EgFnVf1zAPaTqvqTNBxSOhFFhJrVjujIGmDm7Cje5N9oROaaGU5DNWpH2+vOmIAcv/H82BJShyzmr6mYPBS52rAlWmZSAfN01wOuiTQNjIhEfE01VO7DbI1PHTVEOiHaW8Ou+WiEdSv0EzokcB7tRdJHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=cr7l/54mN5eLx1Xp+k+dcHiFgjx1Qpb3sIpyaQr82JbNooDell4vb9toHrsalxGO4x0ieBFi6PiU7gBGYzXnR0uhP6U7i+hruLXoD/HmnXpcHMKdmadj62odSaH6WYXI7wxzKO6mee4bU0EtOriezqlZuCE9wa8t+EZc4ClUffw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7875.namprd04.prod.outlook.com (2603:10b6:303:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 08:53:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 08:53:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 2/2] block: null_blk: cleanup null_queue_rq()
Thread-Topic: [PATCH 2/2] block: null_blk: cleanup null_queue_rq()
Thread-Index: AQHZVisKl+E0Q9qaHkGyrX3OOitCyq77isoA
Date:   Wed, 15 Mar 2023 08:53:10 +0000
Message-ID: <682b7e3c-0941-84df-609e-0bdd4c393768@wdc.com>
References: <20230314041106.19173-1-damien.lemoal@opensource.wdc.com>
 <20230314041106.19173-3-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230314041106.19173-3-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7875:EE_
x-ms-office365-filtering-correlation-id: 914381ff-94b5-4160-10e1-08db2532b407
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ACTnoLDCiC1L9QokDienzNB5fYoX98yUqrIYePMYJqbcmJmxr46t+kKNStZHlgN64uoQuloSTBrOJvGlqCVDcBiGUE7RqSQmGCUtKoYhbU/PNq6TQNKcysg7OiSiyE5QSkwa7UZkr9emu8H3cV08KFOo4l8ALGqSDXPTh3NghLcd36UE6XZq/X2JzQKZvBTX5MoFWAzpoxUZeq040V4ekKI1qegiio5OUS7BMrMBq5afMYVGWgdoIfpEtPzthtgbgkzrFn8Cr/E6ilSj1qqPRujYXLVOLNz8kkzsrAEdERFiBZeROq1kvus/GDvKpnhA5uAhoEnKGlbE0hAPA3B0JOJuTZZMo2oOWjU8nueti1QqIgv482CaCPIW0GguOpeW31UG0TZijA5xhuZB9XJP2KI87cqQYeka43ncWgF56B1cKcG11vq7CdXL04CR4GSse8vZb4Ao5GKoaZ6nqyOtEHZsfFbIYJAkxuEuZv8t9H72yCiRxsy/XqK52V1CbMn6ZJyi9DeLKt0RtvEhVEleRTipbTrOOadJbj4bCYBVquZzQjoZSa0rnJ4pDzPlDWhwOJW9NWS6THSYi9GtkNbfPYqSx4vf73yRtba5dks/KVGB8eFLdmn8aZqHnl0ITJmiiYIz8kcIqW/gnliKCkF8no/67aLRztBLX1oMTWch7P9izYBAk8EdzulWkgo6MkZCtCM65cnQRQ7iGH1TBv3eUQhCuy9c+FS0/UeDLIxRhvVi6tejyEhrZcf/HJVI3wsgzVRk1qUljWnW6HFhxZ0ivA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199018)(31686004)(6486002)(66946007)(66446008)(66476007)(76116006)(82960400001)(66556008)(64756008)(478600001)(71200400001)(558084003)(26005)(6506007)(6512007)(122000001)(36756003)(8936002)(38070700005)(41300700001)(2616005)(316002)(5660300002)(91956017)(8676002)(4326008)(110136005)(4270600006)(186003)(86362001)(19618925003)(31696002)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0VpUWdpeVJPVHhublJyMkg4R2tjVTR6VGNHeUtKWVd1RWRHTHpQWG9Ha0dx?=
 =?utf-8?B?eDRBdXNBbnVxajhWVWV6VjFCaS9BRExmYlhNVitjWDM3bTFvNWUxZFd6Smpn?=
 =?utf-8?B?MWdjbTdNUG0yZXdVdWQ1R25KdjFVRHJWd3E3cE5LajhGMm5oVStPaThiVkRE?=
 =?utf-8?B?Y2pmUXUvS3hRRVNUaUhHWGRTM04wZk9jMW9ldFFiclU1SWZoTXh1cmIzNmpG?=
 =?utf-8?B?aGRjSUlPWWpMei9hUEdITGFoR1RSV0VhV1RsWWZ4SmtSUDVGOE1PL3NwWU9N?=
 =?utf-8?B?Q0VHc2pXMTZRYU5GeW1vMXpvdG1aSE4ySDJwOVRMdnpjRG40QmtrQVVJSXZS?=
 =?utf-8?B?Wk5VK3kyWFlKR1hpbHd1bVowd2Q0S2FKS2lCL1F0T0lBMFE2MUZKaXUwVmFY?=
 =?utf-8?B?cUhKNVcwc2dJeDJEZWJlNVJUdnFtS1VJem1EZm1DQmRnOElDcjVGT2VDbmlO?=
 =?utf-8?B?Y1JtcGdwSCs5UlVTZzRyblVaTi9mMFEwNWp3TThmbkJGU2U1V3VLZWNub1E1?=
 =?utf-8?B?alBZOG94YWNVV1liRXVLc25LZStIcXdOKzVuaDBYRldsUktTQ2c4ZTF0MTN2?=
 =?utf-8?B?bEkxTHZSRThSbEU0WGtPS081R0VaVEwzYnc4MDR2RkpIRXpUSU9odDdLUGY4?=
 =?utf-8?B?c2lkZWc0bG1WVTF3aE5jbGZmSVcrYXpMUlV5TUVON1dFQVJURjZ5blhPbG1Y?=
 =?utf-8?B?NVFGQnk1eDlRS24zZmRXU2VvaXdVaW5JaS9tZml4amtGdUFvNDNPTGc2M1Vp?=
 =?utf-8?B?SDgyTnRCRDFDc09DaEs1Q0JQT0J0Z3NSM3JlRXh0RjhORGNwMGp4OVdEcTdG?=
 =?utf-8?B?dTV2cVdnNjREdE0xVVRIZjNrNkxFclZ4Q0QxcUROaEcvaGVMR2ZRZWZZSzhj?=
 =?utf-8?B?bFVEQ1pQNDlIUWlONmJZaktnUEJjMUpsSnRObnRxRHFYcmFrZGQvbDFmUWlo?=
 =?utf-8?B?VDM4NCtVNEtlZzl1eEg4L2pGcWlmbFNiNXJVVVg1V21BZVQ4RWovSzFxYkNq?=
 =?utf-8?B?UHBHSXhxRzhUTlJ2eFJIRExEWFNZZVFqRzdQTmltME14Z1o0NjkvNlF1Y1hy?=
 =?utf-8?B?NDlVeDk2U09JYlVwZlp0bWVBK25JVUVZOVcvamVHajlpeklVK0s1NjV4K082?=
 =?utf-8?B?b25aRm9hSTFJRmJpM05uRUJNSktyeGcyY2N6aXl3cndjZEcrcFgrb3orSXNV?=
 =?utf-8?B?WTk1SExsQks2Y0RsNWx5ekJJa01UZUVFcFBsMTlHSHlTcHVZdDJsM2dzT2hK?=
 =?utf-8?B?S0dQUDR6a0gwVnhTYysxWUVGb0M5R241ejFscGJNWk1uUUlON0trN0pZeHVw?=
 =?utf-8?B?QlUwZFVvS3JIRE05M3Y3ZDI3SkJ0RnBmRHJBMXVMdEhmN1IrNzM3a2tPZ3Vo?=
 =?utf-8?B?WlBnVmhvUlFZaWs5bEY3YTNBd1poK0VuOXprM2xEb0dqbXpFTjIzSEpGU3Z6?=
 =?utf-8?B?K3FXZDZqYjRvNDlpU0ZIRkRzYjdESWljb2V2ZUpNSTJISFNQU25PVGx2ODVm?=
 =?utf-8?B?RlQ3Y3JMb3ZmcGZWemhoWHpMSTUwczdTVEVZMFlaZWQwcDhsSWVZamRXWGQv?=
 =?utf-8?B?akJrSUhFd1lXK1poQnU2dHI0YTg5M3JyNE1ySmMzcURVbkV6dElGUi9qdk1z?=
 =?utf-8?B?b3FqUldEcHRSMTBlYjJHQVNVeGQyUjd0cXl5dk9VbHJMS0VCY1l3M0xsMi9Y?=
 =?utf-8?B?cVpZZHY2VUhSZXM0T28vMXRETXVpM0hyN2pJZGNjWFhNYkpWSk50Um8ycVor?=
 =?utf-8?B?clJtMWd6ZjBML3YwakpodXRRMXp5ZGZGR1Y4a3RudXJjM2E2YjBNaWVmMXN5?=
 =?utf-8?B?VGp2RDVIR1AyNm56eUZmVW1Sb2ZaVHBIcVpjdndWanlqelNscnh2ODlEaU5O?=
 =?utf-8?B?L0owcnE3ZERGZVVHcnA3aTkxN1VWTElpQnFXUTljWlB1dzl6Y2pHUXBzR1pw?=
 =?utf-8?B?eXltMVVuVzhNTUp2d1l6TUE4eFUvMXlQYk1oMWVUaENCZGM1QmhyY0Q0eE5N?=
 =?utf-8?B?M2pWTEFvU3pab3FBc3B2dEtaZVBzQnYyRFpkZGRhV2ViR05QNGgxRWNCeHUz?=
 =?utf-8?B?U01Mdno0NWI3QSs4RDRTdGpGWDFzS0wwamFGdDFTMXNIYmUyTEg3VldMTC9h?=
 =?utf-8?B?OXRvaFNRWUNXL1ovVmNMcDJsSjIwMFJGdmNCWlF5cUZuS3dGUk5peW85bDE0?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6B9C43CA2FEA342A7469506F2097B03@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tzxo1r50XRvGu4Vh7tl0OkCoCqQAcUgf54YSqQy00c2crkiHthYscTXWmhJ6MfCUtVjxuvJjK1na5UBu8TD/NLMO6wwhn7yDU8A0CyrgqX1ctEPvGN2i1iruG3x/Q002mUbZx1H5rzfPBHqQ3aknEkB/RfS+almROy7pGOPb+lz6jcw4bQjg3EveUohXZmewNpTzib2puRwiY0DDlO77fNgPAQ83WjHPQvun0zIcGiVFtO2NfUROzNqhpR02oWh7wAMvFtDPCxgEm62k0nAn0pnbATmndQO0F33KB0dao/VOlYmPm5LeitjtqGD/q5MwsVAi3geUtldcIJoNiks5oFOjE+LbH3czABxkYZNnMCnWA1wpkRBl15UKu0EnW/ujrpvYeBLyawlEpCLliOxDFITKr9Y7Axur5rEZ9dTkuoGUjg8lWmhbz1RN2vi8SxNl4RCZp141dxQVU9UWbR4tiKbyhDLm6REiNqPVir/ARSgowjURXeEQIXDGJo8o2O1KN6HAGK6Zk/GTwznkBI2y4ww5m51USLpV1XErgOaT34nZ/kmtxjLvFO7XyxcVpwnNCeq4kdgZg7o4da02sVujI+ERzEekVTW76ApV0UkqIMY9WUqyKPnLqv+pkuNt+Y9ubuBdHXWEyQLRZ7MALYMJpor4AKyOq/ErMVRDkj+zAFO1/n5QLkV7PhnaaHYese3kVqvc21IXek5w8HD5h6Vasg908mklcR/sXew9tfgNFk3fFI0F2dlzcEsk93CyuH+chYEv/GhqlVo6l3kj1+8IaUl/zbU+v9sET58blnWXC6/eJBUGXQGpUyyMdB5e2zKmkkSCJxD3200crdSzRxHXEQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914381ff-94b5-4160-10e1-08db2532b407
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 08:53:10.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWxedwbVtHkBwqbjh7Tu6LfeMmF0BlHaWiotn0/QDcO4ryWyazgtGiHL2jkLT0jbB8eU5Wd+YXIzfzgX4dNUnkjHVvV7+h/esx7J8sUgEcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7875
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
