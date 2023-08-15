Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6356CC0015E
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 10:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjHOKCT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Aug 2023 06:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbjHOKCR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 06:02:17 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1890310F
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692093735; x=1723629735;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=UwWqzmzQAXtvPQyiAKvDembDCeqoJefS47LDo9dveoFVXQuBgYCnbQMt
   Mlx566UTSkhR7yjgw5Z9u2tTNn9WzzthiodZx/qMt3MH6SfNsC3hITcC/
   CuNbMMJN6pVRAbrz+DaxYNktCeCBxfi4di5KjvP+5bG0xPansEqXiK5CE
   DiKvM0B5h5td4en5yesaytty8TcgcBQ/ZOJGtFpb7LDpkZ6z3Oa2OQmd4
   FPfEyXK3YGRQ0E+0250chV83nZJ5HTMWyrg0VH78bVQ0bL7Xi6ktCtdIR
   IGfIWNwey2CI0iytWRMUlrKpMPas8MCdBdj9jSvHCje46vrxOEdBrjciG
   w==;
X-IronPort-AV: E=Sophos;i="6.01,174,1684771200"; 
   d="scan'208";a="241046219"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2023 18:02:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqJbN9wStb+PIHbblURRMR7whPFS6TK6KjQUgxsPxT1lyPvjkypunsHPbcU0GPFeoJCgbSdqu/09s0+AoL6stR+r6IosV1r6Wzf+zwPiCwj72lry1IpREVEinhCa2mvQamPnVzi5ms8bRr3Hlc0KfQDlY02XtwRFPsjv5msvqMhe5vphYHYFVuHxzf+BOuFib1CESGT5YBwwYtlldo148qJuoyWLXieWBPMtf4xIG+o1BGOqB5k7rChJpnJdOsHnnKiGmEYE8JcOkKhZvjnbmnUVxE6rk8bZs1Z69YnRhdteoxKputAnETpPssdcluyrqmpC4RuqWe6P89RSxY5KXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=R+Q3ZYs7A8xL2SqY482V1xT2VRVujQ4WD/PwfNjBroO3VFuSCzulltxK0UEsbN2ST7DPCRqipuvt0pBm47/5z4a/bPzSnSSNR2JEO1hjb38t7ehV4AHD2sVILL5QWlclqNp07wPBXYsNAMjVp3RpzVLmpbPp19q6+b3dElHiehPNWLU6Uj/uU/aakdyXc7ztVax5Vxj+RSxdWjTY9XWFsy2Cd8dWxoYCq4yfKRgKGk6wpVgGIX8ME54KopJ36s+XjF2k58ElkFLJTc9WjXyZOWPGegZgepBXm56LmCmMIAVrlcrpAJWXbD6QejhZgfS5rI3xq0d7BbU/a1xFTGB7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=zVw3LxzwVfmQUObffPWv4TTf+Dh9/fCUwP+oD5Mc8nwUkcXI5WfDoZ60OPYQSBbeHNRIedM9YiKyE+5zeTrcophVus/9dRRpQ1gEajLkW/yOeMCNANEwRwBsqdvnV82E0ekZl1RE/DTPi7Dhzfk842176hW/LjYPHtl9z9s+Roc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6284.namprd04.prod.outlook.com (2603:10b6:5:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:02:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 10:02:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/5] block: use pr_xxx() instead of printk() in partition
 code
Thread-Topic: [PATCH 3/5] block: use pr_xxx() instead of printk() in partition
 code
Thread-Index: AQHZyiHPQ7ihz8yMNES2G3MNvGyIsa/rKtqA
Date:   Tue, 15 Aug 2023 10:02:12 +0000
Message-ID: <bb029958-5b64-450c-847a-929c535945b5@wdc.com>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-4-dlemoal@kernel.org>
In-Reply-To: <20230808135702.628588-4-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6284:EE_
x-ms-office365-filtering-correlation-id: 82ead9f0-3a52-497d-f59d-08db9d76b22b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPdcCVO5ZcJqYRghPlq5htl/31wOHiFMmBZCRPyxKVK+p0Au0m7EV/RBfF23oxHcRNrtQhk8b1ADcRW1FyfAH1ZoUMZmtlW0Oo9KYWlSElCV4UYhBCGp0z4wVBMjnq59CYzLFGOXrrIGoiJy2835sZM1oYvpDrU+VAJPApG91H7ad5ye85TiQt+eLmcdxB6W3bmkrpzfbO84GXEER21pN8umaIwW8QIDlx3f8JyIfiD/gHVkA06UQW6+3HcQiT48248u8clCZaU71aiOhb1UzM7YY+ydUba0emgOGH68DZnvaKojg2alWTzXsoEwruEK44CVftgVGwXI6IJEymz7fkEyLw5FbHz6Qwk68cth33sHsaBcClIRarDdWtsnICz3zyTEJBBg7VRZTWlp6cnYzaNwfu0CMoEFIlsF6OPnh8ItRKLrYFzZDogdTI8sa2KXcs9XQly6dFcbp/iHp2lEzzbC4i6Dy38lo/wRhLG5/v8LNDI/D7ducqlO/S8liQIDfjNXTHXmpzpZsG6KfnATKuGPuSYy9tY9J6LJwKml5ajsRE4fQwuuKvy6Y4m4SG9Td6Xy/K8yiwjrk4ZAwa2QyJTIgRD4oMQZ7L+rwzvv9admk8Q9fObYcbXBNUpce+DqXptBOn2PukKeoZiLP1hmYHgJyw09zowmoVkRs4fl2BQJ00LFxN6qBaAnwbTezDOF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(186006)(1800799006)(19618925003)(4270600006)(2906002)(6506007)(2616005)(38070700005)(478600001)(41300700001)(5660300002)(8936002)(6486002)(8676002)(71200400001)(558084003)(31696002)(31686004)(86362001)(110136005)(316002)(91956017)(66946007)(66556008)(66446008)(76116006)(66476007)(122000001)(38100700002)(64756008)(36756003)(82960400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmpYeXAzUUlHRzZjU21lb3Y3YzBlQ1JDRHVEN2poNTVsOWFXZTB4Q0tZWFJl?=
 =?utf-8?B?K1FrQ1NNbGdDZUEvcm9RWGhBekoreHVqZkhqTGtUOTFkM2p5OXRteFVyRk5S?=
 =?utf-8?B?UEptODBUMFVlbGVUVDJDZ2NRMGkzSjExbm9PZ25SUUZ5RHcrQmZ0MHRFemtk?=
 =?utf-8?B?RWJDVlFSWkRPek9ZV3FudW9FQmFZd3ZTQ3gxM1lnMS9QVlh6K0g4cTRPWGZN?=
 =?utf-8?B?VXE1K01qMllOMWNjWWhsMUlzWVhIR0pPYmJwdmFZS25Gd1A0UjBZWnIvR2Fy?=
 =?utf-8?B?NFZsMUt2QWhCNVlBdDdqN25qSDJ4T2lXZ0s2TWFLU3dsWFZWbTRxeDF0aWdz?=
 =?utf-8?B?eTNOekw2QjNHajZad3RBMFlwemZ2WUNxOGFMUEthSHUvbEF1M0xraFVxd21j?=
 =?utf-8?B?Zm5TNzlmMnhSd0dKUmo1b2xqTENWUlpyc0dLSFNQaXdpYTgxeU82ZTZFekdv?=
 =?utf-8?B?Z3pIU3gyRTZCREJycmtsT25RM0JiSXFwY012N3hhMit0MDUrTHA1SjNKRUVx?=
 =?utf-8?B?bUJlVm1XSGJrSXRLNHpydm9jUjZWMFh0ZTJkVEk4TnBEWUIvNUNNWVBCSTRP?=
 =?utf-8?B?eDlabW1NZU5mbWtuYkU2aU1yUjM5WHkxSEMvOHpVM1RFUFVWa3cyYVc4N1Fr?=
 =?utf-8?B?TkhOZEdHVHpDeFRySk5MZFl0Y09UcTBKVXZpWjl5U0FmZDdxaDRJSVgxNUY0?=
 =?utf-8?B?YVVCUEcwUXR3OVN4N0JuTFVBcFdJUnVjbmZ0KzFpdnV6NXVLVFZvT0EvWkZ2?=
 =?utf-8?B?a21iY3p3K3dtRGw0eTNZcW84RnVmK2xUTFRlcHBZQ0NQZVVxZG1kT2J2bGd2?=
 =?utf-8?B?SUQ0dnVEYkVKa2Yzb1gzVm9RSW8ya1IvemRaTFNJWk51anJqMVNpMFpWY0l0?=
 =?utf-8?B?UENmT1dpOEk1b1M1aTFINXhNR3RHTjB0dU5wTGxaalB5Z2hXbFRaSDNOL3di?=
 =?utf-8?B?b0FQeU4vRDNqbFFTcW5BeGFVd3R1VGg0cktHQ05Ickc3OCtoVHhHR045R0tX?=
 =?utf-8?B?UG1pN1loN3lZanR4YlJtZzgrSjg5REg4b0dIL0Z2TmlReVVLOGYvMms1WlZx?=
 =?utf-8?B?UHRId09hcVp2ZEt4bmxMeU9DN2VuWlZFc05xb2xLMFlXTTR0MDlyb2JhUDVq?=
 =?utf-8?B?Y2xrRm15K21JVDhNTWRhNDE2S2htNnkwQWQ2cDVrbXUySHg0Y01RT2RMamho?=
 =?utf-8?B?TzR4cVV0RE5KcXUyYVlTR215R3ZBT1luTUNWbDFMd3BVSmxzbmxUd0puTGMz?=
 =?utf-8?B?dTlNb3FlU3NVb0RQOXk2aFIzci9uUG1NSU01QjVrQlpnVGxXTlJiQnJjZ0xE?=
 =?utf-8?B?eGd2aWtlcG1aRzg3a1VZdnJhOWtranArOHlOR2xGakdGODJ1SDZWWXNGNVdt?=
 =?utf-8?B?WnlJTm1TK0xkQXhLM3B2SjRHamtYSVEzUFJZby9NOG1tbkdjNzkvbmV4U291?=
 =?utf-8?B?WUZaVTBXeWVRdFVmZFgwQWVUU3VsWEwydDZVRFhQenQvbS9lbjlVMzF1a2dK?=
 =?utf-8?B?QStxd3VMZk4rSVorWXIvNFdjQmd0Q1RGM2htR3NlVzVzbmJJeXhuYjhSRHAy?=
 =?utf-8?B?eFhwOXBzSm11QnU0azlreTZ2bFVJTVh0T2RzRXBMamFWMUhHa011UjM3emFr?=
 =?utf-8?B?QU1RdVdBMVhCM2V3Mi9pUkkvUFYyU0VBVGQ5aXZJWFBCMzhuQ05HNkozK1or?=
 =?utf-8?B?S3l6aXVxa204UkI1OFo5OGhTanFJUmhpYStmYVVNbXkxbFlzMVl1OE9wVGlG?=
 =?utf-8?B?ZkdkdmloWERTTys1WmN0SWdEY0hWYi9qbm8rcXNsMHdjQUVvSWZCRW1pdVBM?=
 =?utf-8?B?ZXVDalBacGtzR1h5SGpCOHlwRUh5aTdKaGJ0TnlXdjZaYnhQWk1kQkkrTmJU?=
 =?utf-8?B?dUwvR01mZHZ5NGw0dkhNK0ZkQW1maGZ3T21MRHNTQkNTVFpHZEdpcVpCcENB?=
 =?utf-8?B?MWpqanRZaXI4bjFpcGZPU0NDNjl3YXJra0pldnpyMFMxcEFKaGI4WXdlMnZF?=
 =?utf-8?B?azdlaWJnQ0pTTzhhc1hEYVpoRUk5R0tqRHdqUDA5dzMreVRvZGxBOEJwMVNB?=
 =?utf-8?B?NS9SdG4yR0wvb1lBU3lYbWZ4aW05ekJZQ0dFeWkrYVpQcmZXNFl5Q1NQM0pL?=
 =?utf-8?B?eWY3UFZ2eHFXVFZ0VHlKN0RURTlZbXpxWWxHN2htUnlITXJqRkdRT2JvcE9v?=
 =?utf-8?B?bzg0elUrSXp1M2N0bjhNUGlycFdXNEpCNEJJeGI2ZjFNdGlPZktTOFZIdm5w?=
 =?utf-8?B?WFo5cXRQbzRLdytzRVJZL00vb21RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <208E2A5296181E40B756DBD391528418@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AWjvdQ6AAVZsFhezwyaqlx5ULgIV/poRreChAjPkbhGSomE2Ae8DiFxtIjL6pcfZWX/VO/8IbH06N1SUSwufWcuRfUeRv/qek0i9aeK02Uiq+eHghgXnTa3fqWLkUrnFSsNpHsunK5txbog3eG1NEXpNzEX/33sohyZ2AaaP4mc/QMvql4i6x9HFs9MRAui/yAawTLti34tMZrG6aKsd6wt4qPJjLreAiNJOrrUO3FeVwGdOTcVEX1qPLSfAqYEbRM/0aom2gOQE+RPPD1rpaMlMoP9Vv8zoW9uFNB/BMikNRpXDYkJBsqden5U4bOimX+USldmw34cKMJOER3TsSr2USKy/60XDKG1U6CtY4FIyaS/pGr0kixVngIO+/LQigNl7ozM8xT5p0K9qpzy/8c86Tf8NYPKBvQRRrNMDYL9ikp/YuaW9IwH2yYh0jVr60zQgxkzMHg1HDM9RfkMR4qU5qMBrVv81xRHsyq3SILVN8wHu+mCJqgqs81hbW/9lQ4a9Msi2a2nNuyzm0WjmmpjQelGyyhv9xgubWwPTm3M60hbGQDN42BcPQZG/2ML5FiQlgPwUvAq+CYTm+Kh0sO8qxXJOeFC36QBan5RDo1L2nt3uncsGJM/ASPM4DiCjIgIL1NkpEFYGnDyZHm/zNBvTZss3xo6QjH4ZS1K97xVuNfWEQ1TtUZRke1OXXk2BQE14jjkRVMAKSiwdHQKsp0hxpvrKJUEB+OjFLTorE2/Nu9fzPLb4fZKEBrMMfSCIqOwbWfTemwYDzqM+M/4MsJeK+j7i0wU57YzcUYsFxRdA3koU4gkwudUYgnq93hW26Jcqx3N/NXlzGB2503On0A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ead9f0-3a52-497d-f59d-08db9d76b22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 10:02:12.3956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMFIUmxib8Oat7JeeZNEm+58Rb0pgoNsuINDwneJP0kl2FK14lw++AVCyeqRdmCAK+/m/eE2kFDoLChP4nDkCVCQWGNdWAV3Srk7AG2jI6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6284
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
