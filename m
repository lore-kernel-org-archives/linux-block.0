Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E406C433EF
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 09:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbiA1JEM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 04:04:12 -0500
Received: from mail-bn8nam08on2045.outbound.protection.outlook.com ([40.107.100.45]:64864
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235560AbiA1JEH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 04:04:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd+iBnnS7jeg9oGS+bsjgGPI8DOcwBBcJUViOelwjA+xK/nuddtFbNzJAP+bgKPWiSnRJlIy21GiWC+hloOwpjW3iZiKayip/nsXUfuMiXmq0GPOwyQ31jbIO0XpmDUH1J9yvNsL0BjjCzQVG90zOXTpLlFvmbdBmmmZD90pBZae5yBx1MrKpKoFZuJ7pu8jdCvfi0x8D8qWonWW5Vv2nKetGKsjlvQif2j8KYklwBflrenAE3L03DH0AO10kMP0OI61f6Z24YLYIHX9VdBnHGwt1ddBlRvdCELxNQDLQRjyDwdJVJICHqet6KCdRESaifo5qmRp8J2x1j+PkWLvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyOr2t9iNb8ol9sXlWLqHaMm+velLJxMuakQdjzrvJs=;
 b=oFA+bqSzHvPIaN6P4w39/ySN8hWqPAHHIxzbbt7M1g2HSj7XmKmqigP3RjyAE91IadZD/jQAB7btvz2W8EzTEbFpmyGvT0CHdGDB4FxID3VGzwB9Agc/c1NhA1FebRkPDNwyJND9huOGK4HWtXTV8CKeKWNWSE9sTjOlwoAai8iwewaL26QAOdpfRTM3EvS9+jWMNEWTNccRBLJtC3c6hv5Mzow6YmPjh03u+v3M9D+MrDp6wVJjAQ7GY8rmIfTcDkMKNSvYFh447cBBb6GdBXgWIfOST3k2j2cqWtsuhVh1PaNhsX92f4t9yZVxP70yHj1WNnZum2ftnB5Wc/F8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyOr2t9iNb8ol9sXlWLqHaMm+velLJxMuakQdjzrvJs=;
 b=QzYpTLZ2k7NmfhwN4G3MiaQAERXOjpHRtI5JciQkmj0YF2QLPNgQLpCE8vmEqdMXTZ5KtC6u4cFT1+/30ydhBcL9RjVmeT4JT8oKxaLk8J497N0+FhJOYxEZduBZ77/dGxx+Gi7Q/E1NOkMpvb6ikKPIWt0rsJqAh/86qqN0s7HXj6A8CGeQmWVJIupey1g9SYpZ6xqibb84BRYDhdFjtsK/8AJnHYBlXRxNJLX5ENER1/UJbZhgx0xI3li6OrexZYQpMHEsmuIDWlMIv/j256kbmn1yjnJIFHnCvIp+iDpHWiOFyvQDCOm9TYqOXisagTFrFw+ZwwQV2S+fj2LGtw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 09:04:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 09:04:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Kanchan Joshi <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>
Subject: Re: [PATCH 1/2] block: introduce and export blk_rq_map_user_vec
Thread-Topic: [PATCH 1/2] block: introduce and export blk_rq_map_user_vec
Thread-Index: AQHYE12pR4VfodUwMUuaRk601G3BTKx4JUMA
Date:   Fri, 28 Jan 2022 09:04:05 +0000
Message-ID: <0dfe7d55-6a1a-ca12-0bd3-7be0475d03ea@nvidia.com>
References: <20220127082536.7243-1-joshi.k@samsung.com>
 <CGME20220127083034epcas5p4aaafaf1f40c21a383e985d6f6568cbef@epcas5p4.samsung.com>
 <20220127082536.7243-2-joshi.k@samsung.com>
In-Reply-To: <20220127082536.7243-2-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a0c14c0-faa6-45e7-f76f-08d9e23d22b7
x-ms-traffictypediagnostic: BY5PR12MB4130:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4130CEEBB04C6E7F0F858662A3229@BY5PR12MB4130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/3Go35mNAX6Ga308BH53xU4zvVhnUd/RswMcxA/CblzfkAabYLP93Wjou28VEyaV1Sr20t0D+8/ZUYqttOqWqUcek1tifAuBAmZxUoYY9bRiF5rS/zX2jocNNHBERlclyUR9WXyZI+uY69GeTv+sMqW+mern0LNdRV8QhYyRsr9Y7E5gWBpRuQMPzVuaNwknHZ3JUBw70T3Vt+uSzKWVtYOcOvLtlixcGuVSswxUB15Y7RQv0j3ucKaL/iH2pnGF1yD94mgP/186jNu4WvOKlF6w5E6Fzq7vP5pEj+VHDv++PJehGUhvV/bCrH2dFc5/+WO3s7jXPnL6tkboZCZTgdiKPfTrQo+addnAeUwW2H0g0IoibbD1iQEm/NPNm+8AFWpIfSAugrQBhN9pm2bkL0W6IloRExzThVB1Ns++dcEo23cWxigT99rjRD50n8lm6yOGDz/VB0zaXxWO3gpGrwTFSwwDf44dEdAsjznXicJm2mlF9NfyZnNYn21HFq1vCIaTT11l5OB7jrStRzSpyAazFGokuTAEak1NTehHipQGjDMZ7nm+EvZhbx3noMNv1Ou/goQxUa1EEWU+bwN/4G0ElLi0hXq5KmjEKGaBgyJsaYKvlueAmKbkrni7dZBWtYp+aHXwFEYSuH8agndydJEHzmMpAC2B7oXQNbgq3Yg2TgBIjirrT5ypcAcxisu7BjXSzZHUXkryMmybN7UBw/GM4/7VCv3yIOgrpTVR8JExyr8rWCruA43qMMO0xzgeEFaehCsap9lZj7U1rdvLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(558084003)(5660300002)(38070700005)(8936002)(4326008)(76116006)(36756003)(8676002)(66556008)(66476007)(64756008)(66446008)(66946007)(91956017)(86362001)(2616005)(31696002)(186003)(38100700002)(122000001)(2906002)(26005)(54906003)(6506007)(6512007)(508600001)(316002)(53546011)(71200400001)(6486002)(110136005)(31686004)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEE4Z1V6SXRxcEZlQkRNVTJaNWJWNHByd1k5UUUwOStpdlRCdGw1NjlEKzFL?=
 =?utf-8?B?VVMzQnJhdmxJY2Fzb25Oc0VVaUlqaFVjWklNbldmMUtDMkJHWEF0ckRxMXB3?=
 =?utf-8?B?eXc4T2ZlWVdmT3doTTVSSW1tYm9qV3ByWWRzNEJQVk9JcjFJcGJSNGVvRWlX?=
 =?utf-8?B?ZXJvcGR3V21vM1VzQUcrR2g1T3grQWJxck9MM1JvSWQ5NDZvYzU0RXB5elkx?=
 =?utf-8?B?UHlpTWdyZ0oxa20zQ21XSWVTTCtBL3JydUhHRm9QVk1EcUNrSUVFVS9wait1?=
 =?utf-8?B?c0Z2bWRCWmlSeFlTaUloMW5xOG1pRnBoUTQ5WGZrZWxsZkp4ZGhaY2pxbzc5?=
 =?utf-8?B?eUpZRzUrRGJ2Y1lvN3l4anZDVVpYbjZzSTFNaFo3amIwU1VCRnl3N2ZQN09s?=
 =?utf-8?B?Yi93SSs0UHl5c1FDc3Jvd2FXUk9oQzd2bTFzYllaOVRGOG5UNTY4QVpyYi9W?=
 =?utf-8?B?cDIvSUhKRm5JZXZvZkdSNHZtKzNtOGtHUzFZc3dkSnFTTUhKeXVTMU13cmpL?=
 =?utf-8?B?bFMrUFBscHp3Njlhb3NoK2FLUzllUjJhUkVSRlNBa0owQjZ5ZklvVWoyV1Jr?=
 =?utf-8?B?WDlHV05CMXl0RmRjcmxQSmRFVXJaaXFXVTRWUzlKZEdFL2lqeW5LeVRzVldh?=
 =?utf-8?B?cWRCbERlMW0zd3FidWxnbUc3QmxDczFPY0dYWHo2TVIrd1NyY2Q2b3FEOVRH?=
 =?utf-8?B?SEpLRS83d1JhR3pyRC9lUGh4bXowWVh5M2ZiNUgxSjFHalpSRng2LzBLM0pJ?=
 =?utf-8?B?M09MRlN2bWowWXV1VVVQdmNwcGsrakpwbzlFN25GbkZpT1d6K0ZJUDhoazNJ?=
 =?utf-8?B?MHBjK1dtWWVyYnA2cVZRNTVtUFhXejlxbmtjVWxKRktZYWdGVlVSOXBWRCt5?=
 =?utf-8?B?Mm8zZENTSE1lenVaYm1CU3ZTd3ljbnIzdk1LTHJIbEtFL0psYXlTbTNXbzVv?=
 =?utf-8?B?U0tkK0tkWjNiUUY5TmlRcDQyYmFCYWxHSXMwQlBQMEhxSEk0WmZIb1VaZy9p?=
 =?utf-8?B?aTA4ejQwc255M3FzSzY4Vmo2SVQxK0ZVQk1XT0VOeGpNNjhUcjI5UzVKMEJO?=
 =?utf-8?B?MUlUM0NlbUZwRXhydlFSZ0FsTGJnakdTRUZ3cXVUVnZ3WFJzK2ZiQmhwWCtE?=
 =?utf-8?B?R1hwUXJKUmtiSFFORlltVWFiV2luaHhsY0pDRFowWnFUY2VwN1JWbUFhaElC?=
 =?utf-8?B?Y2tabTRkbHBnWG9rUGhHQUFsTUU0c21iWVlTQUhqR0ZaY2E2WG9xanZhK050?=
 =?utf-8?B?L0FJTittQTg3RXFWWldDZVdWSlI3TWJjRXNGTW9wR3J2TzRERjQxdkd0anBV?=
 =?utf-8?B?bEJGdXE0ajJRZXorNUJKZEFlRUJ2WmdDTENaQm9FRnI2WlQ4STg4ZGJHbTB2?=
 =?utf-8?B?OEVhOU14VGVPbG5PMW55UzNxbXByeG9wM0hzMzdaamY2ZDBPUERWWGZHdngz?=
 =?utf-8?B?TFpXbmZkVTlFSElYYnMwdnNJbTB3UFh6THAxSmRlMjRvQ1IrZ0tteGZWUmJY?=
 =?utf-8?B?d3FHNVhSc2Q3RkZaTUsrNTJjcXNiNWZPeUJDRHBvdENub1VPdEdDTlMrOGd3?=
 =?utf-8?B?SkJIVFFnUjI0T0FVa0NaZytxUnBsWU5rRjE2cUhGdGZBRjgyYksxdnNQNUlH?=
 =?utf-8?B?d0liL2hGallBT05oTThpQnFvR1ZGN05tRFp0OVJUOU9zZ1lPa240c0pVTGU5?=
 =?utf-8?B?eW1zYVVMTExqR3Q5QXc3SDY2TnUxbHBwK3A3YnVKQ3JWMTREQVJRNzBmdkdO?=
 =?utf-8?B?bmZoczZuN29MQ2krQi9TWXlzRC9yNStMWllTTUhTWFRGemVvNXE3ZWtFVldx?=
 =?utf-8?B?ckhjRWQrRXlLRGFrWndaUTJGUkVEcnA1N3RNWFJLU0NxODViRmJNT2gxS3A0?=
 =?utf-8?B?bGh1cXBuelN1YWYrcVJUbUhUNVY4eGt4eHJlY0VWbkwxQlZDb0U2b3JndW9P?=
 =?utf-8?B?dE1jSXBJSWhVbnBwblNoRGwvZVZmL09GZ0N6bndtNzJWSDZmcit1Uk41ZTF2?=
 =?utf-8?B?anJIalJydGFJUkdHWGxYdjN6YXVLdURnRm1DUVNhazk1ZzBJMjFDaWRicnpq?=
 =?utf-8?B?cGRGTDVKSWFBWWd5UUJqbUZiejcxS3B1czB2YmhOTjh4NnZNR0RIN0Nta2V5?=
 =?utf-8?B?RytDSU42UEZJZm56dTBaMmlZUUVPejExRndPR2tXKzhVWm4wMUpWcjAwK0to?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2A0311DE1DCDC498D4426806F2AAEE6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0c14c0-faa6-45e7-f76f-08d9e23d22b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 09:04:05.1750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11DiNwQuyZ5H6GDKFbhBrGTNeJGHYJplaG1LxaBg3toKrIRYulfVKuSlhQpCa3Us6ku0GMNnXI9Um9SjByypOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8yNy8yMiAxMjoyNSBBTSwgS2FuY2hhbiBKb3NoaSB3cm90ZToNCj4gRXh0ZXJuYWwgZW1h
aWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBT
aW1pbGlhciB0byBibGtfcnFfbWFwX3VzZXIgZXhjZXB0IHRoYXQgaXQgb3BlcmF0ZXMgb24gaW92
ZWMuDQo+IFRoaXMgaXMgYSBwcmVwIHBhdGNoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2FuY2hh
biBKb3NoaSA8am9zaGkua0BzYW1zdW5nLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW51aiBHdXB0
YSA8YW51ajIwLmdAc2Ftc3VuZy5jb20+DQo+IC0tLQ0KDQpEaWQgeW91IHJ1biBjaGVja3BhdGNo
LnBsID8NCg0KDQo=
