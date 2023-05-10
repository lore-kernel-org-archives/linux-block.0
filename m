Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCBEC77B7D
	for <linux-block@archiver.kernel.org>; Wed, 10 May 2023 07:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjEJH4Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 May 2023 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjEJH4W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2023 03:56:22 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 00:56:13 PDT
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93E01BF4
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1683705373; x=1715241373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=avg6RKekqe/Gd4vqUuMlfkxVYQtW5lgZKeWIzplMLV8=;
  b=t96I9Yd9GKvW5ik1bw+2GKoV4hJ0iFXTNj6QGTLS4jxy+dhBFHLgJmhd
   QBHPM3r66q9/jTYj/FhRpZYevK9d20XZAMELrzgZ0EQWpaeNOnECrsJ9o
   UbHhSGHrIlXG+FKq+10+urdiu/iqSuTaOKOkSnGD+9j8uMMWc1/bdcTzS
   RUWkcYU9YHJOyieTF7oaIDnRuvzzwHp/NDOB/zoCdvhsmd45B4bioeo5W
   6+TpQjeCCCnO0FQdfYMyAHLu084WhZdyJsWwQ+H08bQXhwG9toAWxYJrb
   yIYsq7XGdR4NQASGVCbtEKKLIDR9xYhNY2yl+SoBjuZaStchKi8Sv9wwn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="84248444"
X-IronPort-AV: E=Sophos;i="5.99,264,1677510000"; 
   d="scan'208";a="84248444"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 16:55:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMpyECGnj56XEeHTCe50w6uyXnOICwKCqRdgpOLQzG4P3N1w8498qeNE2KvLp0/6Dk48KUD4mHTnazwJ7xToNH213PEfr9L/Xd9NaX7iLzKlc6WHjaPVIvUGxkUvzsLchSOvlszHAhxPFvShDcxU8B8qzuFBHmLF/Kz3LSVhkqA4CdQB2gHzjMtk/TpKZgyB73oglCXQ7j+PyA/Jkoj0RCUGkNLyNuoOGXdgSTFPhTYFH05q8U+FqvZsxZ/4JBI3SfQdOXxoR6dp78xdpYSzb+mpgAgeE1au1EhbV18LdieRDIyRRxRjjVD09qmf5L/+vB5C/0IXXAyjMZFqUqdtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avg6RKekqe/Gd4vqUuMlfkxVYQtW5lgZKeWIzplMLV8=;
 b=L1AjO6ZAK0lQ8f1Y2+UZqF5MdI05DTbtjezBxCpWzU0WwL3pL0TjUuiav3WMPZ0j+sORKuxueMwrPAqcL/k0UEi/5EP+eCjzD4b6Ip6Jsl8OGDJsozB4su/zbS5y9Uv+eGHMSFqnI9wDo/1qHjlRBYSoDwAn82adxgmqq2srNcfSk5mZETVjhnCN07Plp70ZWVHVvhBzhEjJ+4obTV5lzwz89dA3CMpBchsQi22YU1W3AW+QzyL+tSFs1LdCK1IduqJCgaldDMI3zUD2yTu2i3kQzSfrFpLjmpgxCARH/bbZfhcN8GqkVbzpzRDIAVSxki4RQQnJZiTC0OGgXqcmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS3PR01MB10357.jpnprd01.prod.outlook.com (2603:1096:604:1f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 07:55:03 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1%3]) with mapi id 15.20.6387.018; Wed, 10 May 2023
 07:55:03 +0000
From:   "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
CC:     Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Thread-Topic: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Thread-Index: AQHZgw1y7RgZnDRyM0uHcXHHUvTGz69THeoAgAAFZYA=
Date:   Wed, 10 May 2023 07:55:03 +0000
Message-ID: <1f2061f8-de32-15cc-818b-56ca0024c5da@fujitsu.com>
References: <20230510070207.1501-1-yangx.jy@fujitsu.com>
 <9ac0b861-01a0-9dce-3d2c-5ff9e265c994@nvidia.com>
In-Reply-To: <9ac0b861-01a0-9dce-3d2c-5ff9e265c994@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OS3PR01MB10357:EE_
x-ms-office365-filtering-correlation-id: 91b2bc01-aecf-4ec9-b2a2-08db512bdd18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pCuVK8qfTMQbKbRqDH0hD/0OanpA89aW7w/z6dN6HGvaUFTjv5jto6a+yGHHfqL5EAR5OEhsGZYUK1MNfB7jI+yKe5Y6NSQTsISo5pSYRrV2jJJwP6kh/uMJxyxiBlaxayZnKIuIA3HKBRvvl+eQXW2t/6oDDiOXdeOXzG8L/JfOkaM1tLmtfTSrJADJW/LsFq+yf87rpoC5vowLqKVGoGmk3ZwBYP7VlVgJXsWJNpkou67Wu4+lyxQmj+f3KOKFuOcG2h4oVTxBPV+Su16VzkSqJMgiaZUhIQeLe6udFviYg7IBkupf6odIb13Gp8Jv/a5M0aVwFxRDDJMGFsUpxpzcd5i5dcJittkxTAbS/dyIq3SCDqEOdlCC6YFcnfpnfg30PckdWLFIXA4hoke9rYTyk93e2RzLu68H2ikRGSSoF4FZBZJxjTQX1BtdyTk7zrzuFUtM95xzIT7x6/CkgyruCtfJKtX9eL/fXQUZHnhGeboeZbjesiZqn0CVOUE7Gi9ix7e/vqPVTNN5Fc/eMF9Hl8WGDmF3CAWAt+GSPTzWQZB++c1TdNkIaoc8AcFUnUjGlcIHhwKdh4K8wpYOoRXg9lxHkPGDutUf+8sWU4D4SggZ9M9dRoiw9mdxMEGBjLkH/OWcGIWzNNW+R/vg6EswFm31Zb89+w4+I7NUEc0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(1590799018)(451199021)(186003)(2616005)(1580799015)(2906002)(38100700002)(85182001)(36756003)(38070700005)(31696002)(558084003)(86362001)(82960400001)(122000001)(6486002)(8676002)(316002)(8936002)(41300700001)(71200400001)(5660300002)(478600001)(31686004)(110136005)(76116006)(66946007)(66476007)(66446008)(64756008)(66556008)(91956017)(4326008)(53546011)(26005)(6512007)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE0xNkxpaUJ5b2I5T2RhVVQ2MzJSMXNScGF1SnMrRVMzK0NEVkIvZlJJU0xT?=
 =?utf-8?B?QndrV2ttTmdQeS93YUNUZVM5aGpTcG5oNUdmdzl2TTNqenhWOEE0Z0NZTGxY?=
 =?utf-8?B?L1dDSGdSMXg2NWFieEtWME5YaStJTEdsdjB6UWI5Tkx2dUNCcU83Z3lCb3FM?=
 =?utf-8?B?aWVCdHFPQURaRk1lMG8vd2xzVCswdUR1U3RsSEFVLzZSN2pTMFNhcXhkVGdr?=
 =?utf-8?B?M2FnR1RXN2hnb1Y3djVHeW94elhGUm4rRmxpNFdHb0tadFZzQ3R5RkFtdEo2?=
 =?utf-8?B?Wm1Vd3diT0tiS3RuVlBxUE9mNGdJL2xhckROSXp4WDFOWktKbmY4UzhjbDI2?=
 =?utf-8?B?ZkV1bXlJTDVnd1l0dkI3dGMxRnV0ZXZtNHUyTzhNdk5scDNwMHpPOUdodnFV?=
 =?utf-8?B?QjdrNkRCb213ekdsY1F1UDJDemh2WUlOT3dyV2xxaW9ua2ZTYU5mYU9nVzFr?=
 =?utf-8?B?T1JXbTd5aFJLWlc1QzlUT1E4SnM0dnJEK09ybm5hV1R0bCtxdlFhSmQwejF1?=
 =?utf-8?B?c3M1VXg5RnQycEZMcGFHUU1GN2x2Z1JSaHFBRXpjOVpwQmJ3UVFnbTR0M0RG?=
 =?utf-8?B?enZjd0lIVzBRYlc0Ymh5WXRxSXdDQmJVUkxQUzViRmRUVGVGdlVSTWViUk5J?=
 =?utf-8?B?UGFITVhqYmpTN0VzTjRsL3g1QUliV2pqNTN4K0cvazBBZzhtU2VCQUsxTktn?=
 =?utf-8?B?SmFYM2lkd0J6V05TN1lKYmpGR1k4Smx0aUpJWkJUemhHKzRhRmxaVmQ1TWwz?=
 =?utf-8?B?RFdISEtlVFBDcitSenpLS0JZZUxTZXpIdDI2SG9aN0ZQTk5SVXZpdURCRThR?=
 =?utf-8?B?Y2p1QkZrUkM1WkUrZkZxSnNtQTQxZUZXYkdYdExsL1B4NW5VbWYyQzFtdjhC?=
 =?utf-8?B?OTZvSFRKSW14amgwa1dzVkZnN3plcUVuVWdoRy9TVDJmTWhHa0VSWWJTdUV1?=
 =?utf-8?B?ZFcxbTNXYVpjYzZEa29XODBoTVJDN1d4QXpLMEQvd2pNNnY5KzZsOWp0a3lG?=
 =?utf-8?B?WVk1eFhIN3VkNXBKZFdaTWtrQngwYmtPMkRPdmpLZllOR05XWUdUNUdZZUx2?=
 =?utf-8?B?cCtrZTRZVFR0NEF1OUptd3hEbWFyd3Q2c2Q1MnljWjVvalpONGFPa3NCdGVi?=
 =?utf-8?B?MHFWM2llai8vVXpHdk9OWkpPTmluMXZoaXljQ0hKZnJucHJGc1VIRGdYTHdq?=
 =?utf-8?B?eVNydXhXMzFwL1l1SXJzOVlUOE9RTytLZVJPZUw1MFAzNnJURHg2dnQ5MmN0?=
 =?utf-8?B?WGljZWw4YXdjaGVBYmhkbDhFVDlWTllPckJMZjlrZnBTWmlTUDBjNjd3YjNj?=
 =?utf-8?B?Zk5lRTFFSGNoU2syckduSGZaK3JtWlNCSk5Tc2NzcFpDR1ZnK3RYY3AyQnpF?=
 =?utf-8?B?UlNtbXM0OS9IVjY2djRzZTdYQWZtK2RXV0VyenVzQzI2bTk4MlVRdVl6dnhj?=
 =?utf-8?B?cDFEY1BGNXBEc09yMEVMbDVEQkpUL2tzVW5STHh5UWN5UTRheG9qMVZHcWNi?=
 =?utf-8?B?anIrR01pWFYzWlRRRWtDNTlCY0ZjOGlDS2dCUmZ2bTkvRGUvdlNpeTY2VnJw?=
 =?utf-8?B?OHNDeGhSY3F2UXhTcndRTEtLQUdoSGozR2s5c3ltQXgwdS9jcW84bXZKYzJt?=
 =?utf-8?B?cExabU1STjBBdWYvTmZCTUY2WFlEVDQ5Q1gwTXl3MlBnSytsZ2FkK0dQeHJo?=
 =?utf-8?B?UmpQalNoeEpoeklOcXhzL0ZXYW05THNhM1ZPbHd2Ukhmd3dYejBNcmFrTm91?=
 =?utf-8?B?dDNuMWpXRFVCRER6bHI4bXFrWUJJVXorS1ZoUXVlS3RiRTFZbUFSS3A0VlVo?=
 =?utf-8?B?L0sweWo4N2lKZytKY2xnOVZXK2E0bHVqMjA4emdoaE16U1c4ekVsWUlPVkc1?=
 =?utf-8?B?c0JueGhJZUtFbUJSL21nODJLbU1aWXA4djFvK05PbGFtT2x4aG9yWndRMEY3?=
 =?utf-8?B?NFNrWVpIVkFPV3ZMN1h3d2FycndVMWlYWm5VRlo1YjZJSmdncm9uVmErN0Er?=
 =?utf-8?B?S2NKQmhWYjk0d3hlbjY2NWIzcGl3V1JZU1B0RDBuVHlQQjkrMTBacVlPdVVL?=
 =?utf-8?B?cTYxM0R2Q1JZMzZkRkkwcEo5MmRScjNWTkZsMlEvMWFrQkQ0eFRDTWFjdC9B?=
 =?utf-8?Q?Xku2IPlMDsVPDaKXKdorQydFv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <012913AAC9B2984596A1206E4B0E7B32@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L4PBZHo4ettFeROuXVwWV88/h5dFcnMnLfhu6n5N2kZeyMRYQVRV7we94/9hx1t1AWokD9JyqZikmIzSt9OMjlZc0dZrpvnuOLjYtjloOcU33CNcKl7S8wDdgXTwUVio6gLeMM8ph90TKbyopne2RMMN3qEwy0gUdMTCyjgQvrVKl08a6TcW/ziSczLvnzHixK8ioeyyqkJLsLfU231ET5c9Y/n9KEpolzvYjGJdI6Dhjq5yW5cnQcKqVIMgCHciWncLjMYjaI1pLvGnlZmCUkzLBpcseXLuk7l2RCxBU9eTsc437mYLKvTwbXSWx27fgN3KwV7eIVZn3BF7TMJ2sQlpprQdwDk68lr2kfzzZojyYaNgM/fkGXI2Y2wiVAUW26XBBCgX6jCEkTcinbCK54aGeb6wieMYPxw2I6IXQT4mtbXszMCTo4Qa7iKdmYvwPxyhT89K0a5iRIR49lokXQ9oJjcsW6wQL+GAbn1Cu+FX0GijGcWTGbmORqbUk7mR3M4LVBNU+ZaSoCm5CrHt77AIX3V/C35mne62/fOA+PkeLQ1/8/BdroZ9PnqQg/cMGtQUjDVYdS60Td1CTP2AxY7WLoezKg1IHzthpm/+ESIZqVZDc8azzgSTSS6WnC0IVUlszTxBfeuBTZuC5RH/fWuk20KihSjtMNdtT+R9ap7+wa2E4GhnTibYYk0mz+bwgYrSEl+qId+TMchWSlT4Jeuk8ajjvTwpmvoUfizYA+1nqUUvJVL2NrLH+drmCKJWeqbc2Y+qXXlFktov+PVuihddqeCwY/DsBU6SsyEXrAhum+HC/Zp5lnaLDq3gW9H4v210Jfxa1AaM+M8WRbODiw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b2bc01-aecf-4ec9-b2a2-08db512bdd18
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 07:55:03.7628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eelOVIlWqddruBegBc8aJSZU0W/duRZS6jgoXtYxE+VdputWlYul45YvKO4npGQZrdrR1VEcjoXbbny47UCSjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10357
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMjAyMy81LzEwIDE1OjM1LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IHdlIG1pZ2h0
IHJlbW92ZSBudm1lb2YtbXAsIHNvIG5vdCBzdXJlIGlmIHRoYXQgcGFydCBpcw0KPiBuZWVkZWQs
IGxldCdzIHdhaXQgZm9yIG90aGVycyB0byByZXBseSAuLg0KDQpIaSBDSywNCg0KVGhhbmtzIGZv
ciB5b3VyIGZlZWRiYWNrLg0KQ291bGQgeW91IHRlbGwgbWUgd2h5IG52bWVvZi1tcCB3aWxsIGJl
IHJlbW92ZWQ/IElzIHRoZXJlIGFueSBVUkwgYWJvdXQgDQp0aGUgZGVjaXNpb24/DQoNCkJlc3Qg
UmVnYXJkcywNClhpYW8gWWFuZw==
