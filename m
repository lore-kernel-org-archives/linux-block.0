Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CD5C38A2D
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 21:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJUVmd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJUVmc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 17:42:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C592A79C9
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 14:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLm0/t6CR/8xBeRePXJw3zuZTrwyGpAvdzId+ZuDYFXwkZWEBTBV0h+/gqnyLyIfGVw7sp7L0KyRE1ggzmJj5isBqPNRFlj9Bp1fyF1iQsxq6sTaimIvzGAkVaygg11hioM7B3WXUS3gisXa80B9jxtaqmNxpDfoGwjcFPSQz0bH8g8VYjaJl88i6DNU+IY8G+KD9jfnQj4xO2Sw2i6RFngz2A/fnBJIYGIculsy12ctAc9G+LY6s9QR7/2kmkxp3MfCHIC7Kj2C2ijn1K2WHRfoArWOAY4o2tV9sOwXyMCjVAKYxp/c6sxqvyIzfcexA8b80mRIGN3PvkE9iNSyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YPaQQcVg01lFbHMCqI5cgjqwK0uMI99zT3+RRRpiv4=;
 b=fM8Ge8AZBnkmKOjxeOWn3py8g/47nsCUeKL8jujxGfOFVKSO4TfYbitFCx8CrRs9PCgyhlt9j0up8UGg2IROoJ7W++lJyi9GFQWpCmyVesTbhl/7SJGXRQhjNnqckgvNYpOK+IqnuyMzsSvkvIylE/T/y2Y7LTOreEerjOVS+AR9MbHoia70UkZoEeLSlOTM8xmzU3kLD0gmblnIJpoG3CsoHfflq5td7WhzBTQTWVkE2/Fcv16M5vUT6LhFLSDZTf0OFO6Lyt4XBGZSiRKFvTuCkza1XdFhoFrF14w6hKNQTpYXSYPxqsNFTJFd6fJXPr4BFQ7iWfr+wVJIU0wvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YPaQQcVg01lFbHMCqI5cgjqwK0uMI99zT3+RRRpiv4=;
 b=bFVgWhpozLyiuLOF1KSh/rnhKB/GryzdknFdsgQcmwhctyKB1lWnUueIcxwFOomAyQ2PWI9M8653/YPOtXrBtOPE56qkCDc4ABS2J9ha4nKpqFJZq01LLBHkDf/GWvEhMoTkfPJD85Lr+jTtgNSnWgMjpXsukqU6yA5ynuY6Leg51TgS7LcXBzmCTP9uQy7hi4PczCd/UUQRgv+XHF+muBu0z+j+6sAddTKWX89dQgnYHV0F3fe4hmuAZhm05S06jre/+dGIM20FMx2J2RbAW0I2mpnhTKEo4vIux0rJ6cZRDCAGaiLpCLozYE3SYXHAQbyLiYQ/7Kuw4rcIPDyAvg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 21:42:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 21:42:29 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     Eric Sandeen <sandeen@sandeen.net>, Yi Zhang <yi.zhang@redhat.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Topic: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Index: AQHY43l60hl7Fc9KsUGQcUgAzbInn64VPZMAgACG/oCAAFOEAIACd3QAgADVjIA=
Date:   Fri, 21 Oct 2022 21:42:29 +0000
Message-ID: <0f2957e1-2b05-73ec-85b1-91cb643ccb54@nvidia.com>
References: <20221019051244.810755-1-yi.zhang@redhat.com>
 <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
 <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net>
 <d3688d8d-bcf7-9cbf-7c99-74cb1a05a9dc@nvidia.com>
 <20221021085809.zkzw23ewnv6ul3b4@shindev>
In-Reply-To: <20221021085809.zkzw23ewnv6ul3b4@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7489:EE_
x-ms-office365-filtering-correlation-id: cd6a57b9-5ffc-4ce6-e847-08dab3ad2772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 83QWtObh3cDJNfyPBC8SpVr3MscK/KSfYDkn32ASUCtFUSDvesye9XPsdQFUmcLcTh4UuzWC8EgSOgEs4RzorleNYh58HXN7gE4V6+6D4dKGs9+h8v6LmVxLCMHVof+0neaMqWbyuyKk5NhkMrVVylw+Lg7K9Uj3OiKHV3JJwpVs3ey+IcEPh3rhtsAoh7cz0pPbBLVcjcAfRErpEqYf/bWH0wr5vPpNgXnWlplbDZBG+a8FEz8K2Vi7YcsHAo2cIQ+fCc6Modu3NAZ7vmh0YqPTvMKHN+MHkTyUyv7IJHsfu+ICLt3ZFEEWWdOjCew3i1gF83ae4gtj2cBLlm+3y13Mnu/EfwKJGT8BO8RswWiK2BpnLZ8rR/yqM4VP4KUE9iL01RFIm/9hZAUGjfhURBT2IzhPYE8gYTtTDy1eoptVJ78gdZJlz3pg4p8NHvsunOmndp+RTK2HrTWNeL23o9RUVUZ9msY94q4Oe3DOf7HitiolLPIKs1Gqqs8C5GvgvY9oNvjyjuCBg3axMfviM1rcfiVEiWyN35TbHouL8mOdCdklZT0VCmrhNVo06z8TBNCg2gsoGzSVymld7mhsFt31Msi1Uj0+4tbHo7qWK/1bWEZ4wuco0pi9QlB00OuD/V/+4f1AvpJ5Ig8EmJLQ6HEppYT1vUA80+27Smt1CmP50z4/Lg87OI+5YmIO5prHQX2pddsCFhsVR7TtJ2rsbsH5ILDCg1TrcfqbdZyv4ib8UnaLQiMdEy4bDPLGCRwfxcg/4TGhgoudUCSpEOLb3+ty0JaASdZWehQ8VPgml5oJisEzHCTnJcyOVIqhtYAyYUaK57KujSY1+goLzH895g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199015)(6506007)(36756003)(2906002)(38070700005)(186003)(2616005)(122000001)(86362001)(38100700002)(54906003)(6486002)(5660300002)(71200400001)(83380400001)(31696002)(478600001)(6512007)(316002)(53546011)(66476007)(31686004)(76116006)(66556008)(66446008)(66946007)(91956017)(4326008)(41300700001)(6916009)(64756008)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ti9SeDZvQXROZ3pHcEd0cHlueVJ2cWxONUJEVTFlWTVpMENmN1JYOTZDVHlI?=
 =?utf-8?B?QzZTelBXK1lDOVZiUFJsMlBnQnI3U3dzYXpxZnE2VzlkNkxnTWtVN2x2VkFU?=
 =?utf-8?B?d0VTTlNjQzdoK2VveHZCREtjbllQbGd2ZHNhM2RKQ3FFQk9pQndjdGNVRmQv?=
 =?utf-8?B?MisyNEt6WjZ5SXZhdzBMT3ZmcUFpdER5YmQ2eXFRVzhScmx6YWVDck1ubDVi?=
 =?utf-8?B?VUYwV2lnSU9LZlN0K0dtb3lvZSsvQUNBVXp0NVI0QlFjQkJLMU5OandXS2dP?=
 =?utf-8?B?SzJldUhWenVYaS81YXRxRkVZdnkxelRXWlVIeElVMEVPdUlTYzE0OEhUc1kx?=
 =?utf-8?B?blBOWWZ3eHpwY0lQamJERkNJMG9OTVU4RGpIWVFKVkczQUtZTDdSNEc1VU43?=
 =?utf-8?B?d3NDVGRmRnNhK3duVmhMVGQzT0MvYkx0S1N5WkNGS0pIS3I0bXdJQTFyeEs3?=
 =?utf-8?B?M0txaEE4Y29keTlFSDJ3Kzl6a1cycDZzRjlJcXkxQ0hHZE1BOGpOTEZpbWlO?=
 =?utf-8?B?M2VFT2xnaURJM0JhWElIWHlVZFI4dTRPSHg5Y0pqVCtGRWZaMTVWVXZkRHU3?=
 =?utf-8?B?NytJdUx0QTVFTUZaZHRIQ3gzUEpxVkl0Mys4QWQydnYveUdRMXo2YS9VaTI0?=
 =?utf-8?B?ZnZLK1hZZ2Fkd0FrK1FFYUpEdTUrYXI0SitNbjUzdmRabVhWV2huZEhVU21u?=
 =?utf-8?B?MHN2YmgvUE4rWWNDNVpPVHJ1RUtiMUFkVndYalJUYlVIZDdHZnVZUlJhdzRG?=
 =?utf-8?B?MkZ3REpuYmJZZ3pOMEpFdlNiUnVRVHVlTUIrVEwvSWF1YkhsUHpLRk03Q0NP?=
 =?utf-8?B?dWZIQnE3d1lnUnpHU2JHd2hydlIyMEtCVzFPT0VTMEpWYnd2VG9NdXVFT1dS?=
 =?utf-8?B?bDlVbzdxWTgySkIxWGd5aFVmNmZhZ1NaeUFqeXNDUEM4RXQ3cSt1ZHpuSURq?=
 =?utf-8?B?aHArbWtzVjVOQ0RWU0lPSmRZeDVNYnE3Q0RZQ3ZGVlN3ZlQvMWlNRWJ2eFFU?=
 =?utf-8?B?QytneGJWMk5BaWovL0htY1lTOEkvcE5lcFNWajRObFJtTUpUS3NnWEJOWnE2?=
 =?utf-8?B?L1VHenNmVW12dUZGZ1p4cGU0NEJoemo1OHEwNXExVnkwcENxVW9Pc1dzR3V5?=
 =?utf-8?B?dXFNWjBDMDFwaUszWGpmWnlDQWl0M2Y1VHQvZVFVOVYyYUF1TzJJaHB5WkZQ?=
 =?utf-8?B?QzhqZDVYVUt5NVFRMlEwS2dHRWVjVW51dEljV2RrTjVrdkFyM1BhamZOMWd5?=
 =?utf-8?B?T2gyOFdBdXZlNXdRMHN5N3VkaXphc1JFQTdlMlp3UXE3MFBPVlpoNzlrbG5w?=
 =?utf-8?B?ejhpckNNZ1dhZ1hyaTYvV1ZmaDAycEFIdmhEVVlqQnVRSDBmVjR1YXNCQ3lU?=
 =?utf-8?B?dnVXVEIyQ0pLL3YxNkJ0R3BtN3lIbDZNd1hrazEvQ3lXVnF1dzB0V08yM2Ja?=
 =?utf-8?B?aEVqcWNjTUZ5cDIxbkVST2RDQTBneG5jN2tCdkNpcmt3WXRaNFBidklMbXBM?=
 =?utf-8?B?anRmdThDYkJVQzFVanR2VzFraWxlQ2xFS1ltZlZ3WUtvNUVBdC9TaEZoYnUw?=
 =?utf-8?B?aG1SV2lJN2xyN0llaHdJS1JxU1hGWGFCTzE0RUNVd1ZsRkJpTG9MZ25BYmZJ?=
 =?utf-8?B?U2FFVmMreEtkdXJMbk1BSWFCc0lTeTBoNVRmVnQ5R2R5R1JhYTl6ZUp1a3pP?=
 =?utf-8?B?MGtxenM2dzV4MEpLQklPbUlYT1ZOaVJlczMwUFRvT0hzU3IyeHpoWW1sdmJo?=
 =?utf-8?B?NmszQlpGOFRJYmdaREl3MGM5VHpEME1GcDR3Y2toZkRSdHNxYk1iVjFlMldQ?=
 =?utf-8?B?Z2xUOU9jRHB5UGxTeDlEVmFBOE01Nk9jMlZjckZnaGlUanZXM3FJY3B3bTRw?=
 =?utf-8?B?SWxpWHFDYXg3SHZwdG01VFZZdUFZcjE2SnArbmxXR3hJSHU4VEpqOStLTlk3?=
 =?utf-8?B?K1A2ZFVUMFhYWUdJMDdJTCt2N1dmOHk5dDBBWXkveWVITG91MDRJelVRNW90?=
 =?utf-8?B?WmV4ZWpPOS9BN3JsM3hGeWpsSEQ1aHdrRWkxc1gwa0VBZnI4ZlFBZXBzcXhO?=
 =?utf-8?B?TUtmQXpFQjMvV2w5S3Y3RUZYNzc2UDVtL0t4V0wxN3lGOFdKU2oxWGNqZEkw?=
 =?utf-8?B?VkN1aEoxak05KzFoV1JpMXowZmp3NC9ONjNQQk1haUhYdmNpZTFkU1F0Y1hs?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C988FC2D3604844BA17D9647F1704DDC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6a57b9-5ffc-4ce6-e847-08dab3ad2772
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 21:42:29.8590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYn3Tq5Lj2+DWtgpz/1gWsZohEpJ8+iFYGU6ornV6oP1nZ0dTQVH+mB7zkNmBQ7frkl5SJ3CMJVSXx7jxyQXbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMjEvMjIgMDE6NTgsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IE9uIE9jdCAx
OSwgMjAyMiAvIDE5OjE4LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBPbiAxMC8xOS8y
MiAwNzoxOSwgRXJpYyBTYW5kZWVuIHdyb3RlOg0KPj4+IE9uIDEwLzE5LzIyIDE6MTYgQU0sIENo
YWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4gT24gMTAvMTgvMjIgMjI6MTIsIFlpIFpoYW5n
IHdyb3RlOg0KPj4+Pj4gVGhlIG5ldyBtaW5pbXVtIHNpemUgZm9yIHRoZSB4ZnMgbG9nIGlzIDY0
TUIgd2hpY2ggaW50cm91ZGNlZCBmcm9tDQo+Pj4+PiB4ZnNwcm9ncyB2NS4xOS4wLCBsZXQncyBp
Z25vcmUgaXQsIG9yIG52bWUvMDEzIHdpbGwgYmUgZmFpbGVkIGF0Og0KPj4+Pj4NCj4+Pj4NCj4+
Pj4gaW5zdGVhZCBvZiByZW1vdmluZyBpdCBzZXQgdG8gNjRNQiA/DQo+Pj4NCj4+PiBXaGF0IGlz
IHRoZSBhZHZhbnRhZ2Ugb2YgaGFyZC1jb2RpbmcgYW55IGxvZyBzaXplPyBCeSBkb2luZyBzbyB5
b3UgYXJlDQo+Pj4gb3ZlcnJpZGluZyBta2ZzJ3Mgb3duIGJlc3QtcHJhY3RpY2UgaGV1cmlzdGlj
cywgYW5kIHlvdSBtaWdodCBydW4gaW50bw0KPj4+IG90aGVyIGZhaWx1cmVzIGluIHRoZSBmdXR1
cmUuDQo+Pj4NCj4+PiBJcyB0aGVyZSBhIHJlYXNvbiB0byBub3QganVzdCB1c2UgdGhlIGRlZmF1
bHRzPw0KPj4+DQo+Pg0KPj4gSSB0aGluayB0aGUgcG9pbnQgaGVyZSB0byB1c2UgdGhlIG1pbmlt
YWwgWEZTIHNldHVwLg0KPj4NCj4+IERvZXMgZGVmYXVsdCBzaXplIGlzIG1pbmltYWwgPyBvciBh
dCBsZWFzdCB3ZSBzaG91bGQgZG9jdW1lbnQNCj4+IHdoYXQgdGhlIHNpemUgaXQgaXMuDQo+IA0K
PiBBcyBmYXIgYXMgSSByZWFkIGBtYW4gbWtmcy54ZnNgLCBpdCBpcyBub3QgbWluaW1hbC4gSXQg
Y2hhbmdlcyBkZXBlbmRpbmcgb24gdGhlDQo+IGZpbGVzeXN0ZW0gc2l6ZS4NCj4gDQo+IFRvIGhh
dmUgbWluaW1hbCBYRlMgc2V0dXAsIGRvIHdlIG5lZWQgdG8gY2FyZSBvdGhlciBwYXJhbWV0ZXJz
IHRoYW4gbG9nIHNpemU/DQo+IEknbSBsb29raW5nIGF0ICdtYW4gbWtmcy54ZnMnIGFuZCBpdCBt
ZW50aW9ucyBkYXRhIHNlY3Rpb24gc2l6ZSBhbmQgc29tZSBvdGhlcg0KPiBzaXplIHJlbGF0ZWQg
b3B0aW9ucy4NCj4gDQo+IFR3byBtb3JlIHF1ZXN0aW9ucyBoYXZlIGNvbWUgdXAgaW4gbXkgbWlu
ZDoNCj4gDQo+IC0gRGlkIHdlIGhhdmUgbnZtZSBkcml2ZXIgb3IgYmxvY2sgbGF5ZXIgaXNzdWVz
IHJlbGF0ZWQgdG8geGZzIGxvZyBzaXplIGluIHRoZQ0KPiAgICBwYXN0PyBJZiBzbywgaXQgaXMg
cmVhc29uYWJsZSB0byBzcGVjaWZ5IGl0Lg0KPiANCg0KSSB0aGluayBjcmVhdGluZyBhIG1pbmlt
YWwgc2V0dXAgaXMgYSBwYXJ0IG9mIHRoZSB0ZXN0Y2FzZSBhbmQgd2Ugc2hvdWxkIA0Kbm90IGNo
YW5nZSBpdCwgdW5sZXNzIHRoZXJlIGlzIGEgZXhwbGljaXQgcmVhc29uIGZvciBkb2luZyBzby4N
Cg0KPiAtIFdoZW4gd2Ugc2VlIGZhaWx1cmVzIG9mIHhmcyB1c2VyIHRlc3QgY2FzZXMgKG52bWUv
MDEyLDAxMywwMzUpLCBpcyB4ZnMgbG9nDQo+ICAgIHNpemUgdXNlZnVsIHRvIGRlYnVnPw0KPiAN
Cg0KSSBob3BlIHNvIC4uDQoNCi1jaw0KDQo=
