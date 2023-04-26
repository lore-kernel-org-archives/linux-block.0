Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DB7C7618E
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 08:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbjDZIeR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbjDZIeQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 04:34:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731943AAF
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 01:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lijkCcBNZ5HQF7PPYt41xcybxDFl785E+1//PuBBswIKPuluPbqqJrCX3jIf5Fm/8fr31aBgGIclGdwa65CmIOOvGe4nJWhD9hzKfzgmIw3D7UbfFwQYztl9d3sRvfYGWtwXENx1BxRIfi8x1iH5J65qmrbrKIDUPAPtrxd8YIuBvypcZDCMHXJHD9Fwo88KOaVArlZz3gkPavjUp7nNXVKAb+4M5DQ11uXbQytCLKHSCCvA34DPlv5tP8si1yEs3Pe8uj8LZ6pEU0ynXJOyGWQFhLlZRntXEZrcTLUKnl/+1mx2UlQ8qNQeUWYmObfKoiKaDPjbtuH13NgjUHmo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfZ3uTR7mohzP3NpGCCBP2oGepAhCYITBHklhYW7Sz4=;
 b=Kg0htqfRTbhxqURIYv4M25DDO3ksr57d2fbdSALGYJ1m3cBhyI5U1jZMXJ2HIgadqYeoHfPFytK6TArHrnKjJsRmvECi3QRMvJ97yO7hzbs7ECg3UAGtSdLDmzPFE0gWUEQnZ3RdKOdsO6qodqfnQJ6dhsJNa5C7knxL4h+byUgp35rVb5nArltfONR00Ggw4JzNWrKcgPnYoDQHbl/u9MAyM2Om982nIryaWAs+hmw09GBweLhDcD99NUNW7j22+jhma1oorWIGAUnIOCuGjfaeiimX37OrxlKQXRaOk0kvYhsqyJgt1WtwBcXwdvcwOaZ612luys6ydlu95sTWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfZ3uTR7mohzP3NpGCCBP2oGepAhCYITBHklhYW7Sz4=;
 b=QDf1pl3MtNCCuvLsP78co6fi5R5DjZ4QpjxEp1tkqw5J5Mx7xtMnKTmkJ0AORQS+jxdjeqqaMhVDBx8nQqWjOWrZ16LviZ+/XmUaIvkx2iVKKtAhNPo9vkifmH6UTIU19FKtn5D+8Pelc3ddxvaPbTHnxoslYWvG7KH9hxJBXGi4DPkpNTmwfZ9lzxOhqE9/qy38uXpDNNgl4rhjUMuPAYppwrBP5LS2vbNA1tOGvTqgLeNzwIDpcGNvAPAvjZEMwlhGFFGCyNZljbzE6HP05RjS8ip8dCMM7ignH6kwPbHV/v9GijfNgziUoM05jhyEoz3a/jRI3UZFuXuFpeV0VA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 08:34:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 08:34:11 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
CC:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme-tcp
Thread-Topic: [bug report] kmemleak observed during blktests nvme-tcp
Thread-Index: AQHZc+mY2jx2hr2USkKlPx30OJqaia849EYAgALbpQCAAXkUgIAAAu2A
Date:   Wed, 26 Apr 2023 08:34:11 +0000
Message-ID: <763959d1-8876-31f0-25ee-57ddb2049c75@nvidia.com>
References: <CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com>
 <6e06dffd-e9a1-da5a-023f-ac68a556692f@grimberg.me>
 <CAHj4cs99us_r4Ebth5oAJMqHHA9aXZCpq0A3uu1BEdNw2GeRww@mail.gmail.com>
 <f74df8a4-03c6-6687-7ada-35aa268f44b9@nvidia.com>
In-Reply-To: <f74df8a4-03c6-6687-7ada-35aa268f44b9@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL3PR12MB6571:EE_
x-ms-office365-filtering-correlation-id: 25f06cda-2076-4662-6394-08db463102b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lYBQl91cKBmI/kjN34Eu+Yt1s9fFfXiYvhJUKu+208uf4lO7a2uFpcKL5yYel+TpCJez7n3TXSt9hO67dh2YdDJHKVjFoZ7MISQIzgyAuqkGUpgFwDlfcTvm1bVm40lIxOQvCJG8h67WKVMD8C9iYKeo77Egpnao00VE/XqUJy+1s9j7XU3Us3gXhQUXVAx3xTc8rWZBk7pxUd+fWDUXBT2xLQtbw5JCZgvQAoFxEcdruanMoSTE//FFjofMj89Vajo+pYr2NOhE/1PF2MZdPDKQ2F930HQgR+9Io3Qykpp7/RWLzzmpueWW1bYO/8J/O5yq8jKW+zs7dk97ov9jmrA5Q9S3c3oTh7H0bz0XL3fu1LSssEFUvMT9zN9NUsblIVgb+5Dau+SHTzs+Tv2Zd46sZc09bu5AkL0jUr55VFxBExhmoxb8JMs7rQrJBnrOOw07b9aGyNIeqV67zgN7ccbqn6n6v3s0USNmsJX0+3kVRzOFKqL1y5oktXSJfy9niFvFIvA+avSZCF/ClIbtbCnVnuLChd6ClQiI9172oVqVaR51Bti+bor/7g0RRaMh8OGDKVDamS/uSGSGEWakkcyEsqGyKLP6xZdcnDUmi42Nk10OKm/Q3SZbl7z0vJpBmrxaVAoztSpgbjA/xVqFjlcXL2F68cxu3Fhcq8/l3mWONzrkdX2wreXYWZGsXUfO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(31686004)(66446008)(64756008)(316002)(4326008)(66476007)(66556008)(38100700002)(186003)(2906002)(5660300002)(41300700001)(36756003)(76116006)(91956017)(8676002)(8936002)(478600001)(66946007)(54906003)(86362001)(110136005)(71200400001)(31696002)(53546011)(38070700005)(122000001)(2616005)(6486002)(107886003)(6512007)(83380400001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjhBenlNTTVkelhDK1I4dDJBTW53VmVSazN1dXdDSWRnVmFJUmthbDJlTmdS?=
 =?utf-8?B?cWMvb240U2Z1RHhMek9wMHplMFhGWWZmaUZRQzBiTFhmWklkN1FsdnU0Vjdk?=
 =?utf-8?B?c0JENjcvQlFuQnYvKzI2NWwyT1EvdXdsY0djaGUrTmNTU1NRbzVkUkNDWE5W?=
 =?utf-8?B?VjJuaTR3QXpOck8rYkVpdVFENkVvbTRKcG80c0VNWDBKMmJjMkljcEJtZ3Z3?=
 =?utf-8?B?eU5QcnIyOWloMWZhZkZlL1F3d0NTell5WllHVS9sVHNNWUtMNUdSNjlBNy9i?=
 =?utf-8?B?MzdYeTRSU1l6Q3NnTjRiWlBvZ0ZFTW9FQlVsUGxoM3E2ZzhqTGNjVkdZcGVD?=
 =?utf-8?B?SE9jeGFpSGg0bzhlbGlZMkJDbGNDSUYzZnp0Wm5CbWtoNFBuZUtEVWRsZ3pv?=
 =?utf-8?B?NE9kckp2UEpRQlY4dzdWK0xkU3F1NGNDdHh0c2ZOV2FoMDlUMGZ5S2QzcnJw?=
 =?utf-8?B?MHBBckZ2YmhzM1NwaUxTNEVTd3Z6OVJQMWZ0bk1sT1ZTVUVVYVh0RUFxOE13?=
 =?utf-8?B?SXVCc0R4em9UemkzZzNwM1J3QVhmYmlzbVB2UmtpZW51cHpXSW1zSDNPMml4?=
 =?utf-8?B?UzNPd1BGdDZaQTJScUVZK0NvcmRpRmxBTmNRR3B5YS9pTjNxdWRyMFo3c21q?=
 =?utf-8?B?cWhzbFdoNFA2cXhUc3dzR29NMVBrdyt1dkRaUWR1UXNudHBFWHFJajY5VEkr?=
 =?utf-8?B?VXh4UHBmRk5iQjEya3c2SjNDcVJwMG9JZFd1bE12YjBjdWhxbWdLdHJwMS9z?=
 =?utf-8?B?WCtpZVE5MlgxVE1yT29HVjF4UnNqaWtHSm9VODBvUTlXMklzbFUvVEorSkVO?=
 =?utf-8?B?dkN2SXVKaHVRMmgrcWMxZVpqSHFnVkNXUC9LbW9OTWRyRlRyS0RlRHBBTEY1?=
 =?utf-8?B?MlFNM0VrU3lHTDZWZGtCOFgwdVFjZTNRNWJUN2N2d09pb1VwZ3lZb1pBemNw?=
 =?utf-8?B?RVlPRFdkNFVwQ2k4ZWpiVnJUSWk4REFYd0NPWlM2QUZnYWR2dlNlV2VWNEw2?=
 =?utf-8?B?dVZVUS9tbzNRTW5oOUhZUTV4cnpneWF1eXZxWTJVeTRPS2l1YmtDLzhyS2NU?=
 =?utf-8?B?M0x0YVVySCtvUXkrWmFRbTZiSUpvVXAyUm85VXV6aUpJbi9kRXdCVFdneUdh?=
 =?utf-8?B?Mkk1WGQzNm1YREhSb1B1Z0l6ZFUzMDQ2TjVUeEx0OTBPOXgySHN0TkxXTEtk?=
 =?utf-8?B?ODhJUHJ1K1U1Q01kTDBlMDFPdFNRRjF0emVOeURyLzIvZnNKQ0thRXJsa3Ev?=
 =?utf-8?B?REc0SkxVZkxJMGRmV0UvQ1FPVWJJVTlKdVFISk5sbEI2UHNVV05lNEI4dVBO?=
 =?utf-8?B?L3ZCaG4wc1hkZzc3YmtKWjRzL2U2eVpqaVpTeU5sa3NsV01MbzI5cmxVR1pr?=
 =?utf-8?B?dzhxZS9DUi80d0V5U3I3L09wQkJORWFJOFVCdWNTb2c0YkZ1RVh4TWw5ZTc1?=
 =?utf-8?B?V1pmYWQwcWx2QUhZYWxqdUlDVXJXbzU2bVFJalFrQWhmQldZUUJ2YzUwZ0dz?=
 =?utf-8?B?ajhra0c5SXB4UmRUTXEzNVpUcFYvMzFndFBPL2trUTQxZTZVSkdSNlY3VVk3?=
 =?utf-8?B?dEkvaEdjUmtkY3JqSUp1ZGt4eUcvVmpCdGp0SnJaaFhvaFpQOXg1VXV4YzNQ?=
 =?utf-8?B?ZGh3cndEY1VsMkFwU1ovRno5ZkNyRG1kejcrb1BqVkE4TDk2ZGk1Wkdsb1Np?=
 =?utf-8?B?YWZJbjZoalJFSFlWQjMxZDJxNXhuSjR0T3VBZW1GcHh1R3daY2RaUXV0N24w?=
 =?utf-8?B?VjVzUCtSaC9kTWZZL01XOXhERTk1bVFqV1JxZHpIRThueUZwSGJOaXJNNFZw?=
 =?utf-8?B?ckZmT1dDQ3oxM2NwMnNwVnVDdjl4WjczcVRNUDNLeGFrU3o4TDNHRGJhSk00?=
 =?utf-8?B?cHEzbXJBRm9IaytyMm9HSUN3OUtWR01QQjQxWTkwbTRrWDZjaXcrazhXREhk?=
 =?utf-8?B?R1VBL2R3Qkw2WnE3N0dTTkJrdHAwNzJKLzRTRFlUdFo0VWdXeERKcFlnZ0pP?=
 =?utf-8?B?c0tyT1EydG9HcVFjNU5uSVJIN1F3TnRETnc0bmluNkpNTmRZUCtPWGZLZmpM?=
 =?utf-8?B?aTBtamNOYWIxYWxzdytQbXF5RE1VVVFsMFRpKzI0RHRQenVQUENxOUR2SFZZ?=
 =?utf-8?B?M1ptejJjVGFxdlRFVkVRUjMyS2doU1hCbGkvS0t4Mnd5b3hyb3VkcVpZOEJ4?=
 =?utf-8?Q?Wu0FaRUnKl+3BsWJG+pf4aKEncsTaYPGFkdzQ1KVnGr/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0192B91E6573BB4F9DCA909C9D1895A7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f06cda-2076-4662-6394-08db463102b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 08:34:11.5658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFuWpLNAJjH8CJn5hQw/ESNpvNuVlheV1YO+fF9+HgJpXdbCPsDLV2PHnGodp+YnfvichH6B12YQOoGWw9v1fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8yNi8yMyAwMToyMywgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPg0KPj4+PiBbPGZm
ZmZmZmZmODZmNjQ2YWI+XSBfX2ttYWxsb2MrMHg0Yi8weDE5MA0KPj4+PiDCoMKgwqDCoMKgIFs8
ZmZmZmZmZmZjMDlmYjcxMD5dIA0KPj4+PiBudm1lX2N0cmxfZGhjaGFwX3NlY3JldF9zdG9yZSsw
eDExMC8weDM1MCBbbnZtZV9jb3JlXQ0KPj4+PiDCoMKgwqDCoMKgIFs8ZmZmZmZmZmY4NzNjYzg0
OD5dIGtlcm5mc19mb3Bfd3JpdGVfaXRlcisweDM1OC8weDUzMA0KPj4+PiDCoMKgwqDCoMKgIFs8
ZmZmZmZmZmY4NzFiNDdkMj5dIHZmc193cml0ZSsweDgwMi8weGM2MA0KPj4+PiDCoMKgwqDCoMKg
IFs8ZmZmZmZmZmY4NzFiNTQ3OT5dIGtzeXNfd3JpdGUrMHhmOS8weDFkMA0KPj4+PiDCoMKgwqDC
oMKgIFs8ZmZmZmZmZmY4OGJhOGY5Yz5dIGRvX3N5c2NhbGxfNjQrMHg1Yy8weDkwDQo+Pj4+IMKg
wqDCoMKgwqAgWzxmZmZmZmZmZjg4YzAwMGFhPl0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2Zy
YW1lKzB4NzIvMHhkYw0KPg0KPiBjYW4geW91IGNoZWNrIGlmIGZvbGxvd2luZyBmaXhlcyB5b3Vy
IHByb2JsZW0gZm9yIGRoY2hhcCA/DQo+DQo+DQo+IGxpbnV4LWJsb2NrIChmb3ItbmV4dCkgIyBn
aXQgZGlmZg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jDQo+IGluZGV4IDFiZmQ1MmVhZTJlZS4uMGUyMmQwNDhkZTNjIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jDQo+IEBAIC0zODI1LDggKzM4MjUsMTAgQEAgc3RhdGljIHNzaXplX3Qg
DQo+IG52bWVfY3RybF9kaGNoYXBfc2VjcmV0X3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCByZXQ7DQo+DQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBudm1lX2F1dGhfZ2VuZXJhdGVfa2V5KGRoY2hhcF9z
ZWNyZXQsICZrZXkpOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQ0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KSB7DQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrZnJlZShkaGNoYXBfc2VjcmV0KTsN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
cmV0Ow0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBrZnJlZShvcHRzLT5kaGNoYXBfc2VjcmV0KTsNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wdHMtPmRoY2hhcF9zZWNyZXQgPSBkaGNoYXBfc2VjcmV0
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaG9zdF9rZXkgPSBjdHJsLT5ob3N0
X2tleTsNCj4gQEAgLTM4NzksOCArMzg4MSwxMCBAQCBzdGF0aWMgc3NpemVfdCANCj4gbnZtZV9j
dHJsX2RoY2hhcF9jdHJsX3NlY3JldF9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgcmV0Ow0KPg0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0ID0gbnZtZV9hdXRoX2dlbmVyYXRlX2tleShkaGNoYXBfc2VjcmV0
LCAma2V5KTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkgew0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2ZyZWUoZGhjaGFwX3NlY3JldCk7DQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAga2ZyZWUob3B0cy0+ZGhjaGFwX2N0cmxfc2VjcmV0KTsNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wdHMtPmRoY2hhcF9jdHJsX3NlY3JldCA9IGRoY2hhcF9z
ZWNyZXQ7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdHJsX2tleSA9IGN0cmwt
PmN0cmxfa2V5Ow0KPg0KPiAtY2sNCj4NCj4NCg0Kc29ycnkgbXkgZm9yZ2V0IHRvIGFkZCBpZGEg
Y2hhbmdlcywgcGx6IGlnbm9yZSBlYXJsaWVyIGFuZCB0cnkgdGhpcyA6LQ0KDQpsaW51eC1ibG9j
ayAoZm9yLW5leHQpICMgZ2l0IGRpZmYNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCmluZGV4IDFiZmQ1MmVhZTJlZS4uYmIz
NzZjYzZhNWEzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQorKysgYi9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCkBAIC0zODI1LDggKzM4MjUsMTAgQEAgc3RhdGljIHNz
aXplX3QgDQpudm1lX2N0cmxfZGhjaGFwX3NlY3JldF9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYs
DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCByZXQ7DQoNCiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gbnZtZV9hdXRoX2dlbmVyYXRlX2tleShkaGNoYXBf
c2VjcmV0LCAma2V5KTsNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQor
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KSB7DQorwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2ZyZWUoZGhjaGFwX3NlY3JldCk7DQogwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0K
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBrZnJlZShvcHRzLT5kaGNoYXBfc2VjcmV0KTsNCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgb3B0cy0+ZGhjaGFwX3NlY3JldCA9IGRoY2hhcF9zZWNyZXQ7DQogwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhvc3Rfa2V5ID0gY3RybC0+aG9zdF9rZXk7DQpAQCAt
Mzg3OSw4ICszODgxLDEwIEBAIHN0YXRpYyBzc2l6ZV90IA0KbnZtZV9jdHJsX2RoY2hhcF9jdHJs
X3NlY3JldF9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGludCByZXQ7DQoNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
ID0gbnZtZV9hdXRoX2dlbmVyYXRlX2tleShkaGNoYXBfc2VjcmV0LCAma2V5KTsNCi3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAocmV0KSB7DQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAga2ZyZWUoZGhjaGFwX3NlY3JldCk7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrZnJlZShvcHRzLT5kaGNo
YXBfY3RybF9zZWNyZXQpOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcHRzLT5k
aGNoYXBfY3RybF9zZWNyZXQgPSBkaGNoYXBfc2VjcmV0Ow0KIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjdHJsX2tleSA9IGN0cmwtPmN0cmxfa2V5Ow0KQEAgLTQwNDIsOCArNDA0Niwx
MCBAQCBpbnQgbnZtZV9jZGV2X2FkZChzdHJ1Y3QgY2RldiAqY2Rldiwgc3RydWN0IA0KZGV2aWNl
ICpjZGV2X2RldmljZSwNCiDCoMKgwqDCoMKgwqDCoCBjZGV2X2luaXQoY2RldiwgZm9wcyk7DQog
wqDCoMKgwqDCoMKgwqAgY2Rldi0+b3duZXIgPSBvd25lcjsNCiDCoMKgwqDCoMKgwqDCoCByZXQg
PSBjZGV2X2RldmljZV9hZGQoY2RldiwgY2Rldl9kZXZpY2UpOw0KLcKgwqDCoMKgwqDCoCBpZiAo
cmV0KQ0KK8KgwqDCoMKgwqDCoCBpZiAocmV0KSB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHB1dF9kZXZpY2UoY2Rldl9kZXZpY2UpOw0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWRhX2ZyZWUoJm52bWVfbnNfY2hyX21pbm9yX2lkYSwgTUlOT1IoY2Rldl9kZXZpY2Ut
PmRldnQpKTsNCivCoMKgwqDCoMKgwqAgfQ0KDQogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsN
CiDCoH0NCg0KDQp3aXRoIGFib3ZlIHBhdGNoIEkgd2FzIGFibGUgdG8gZ2V0IHRoaXMgOi0NCg0K
YmxrdGVzdHMgKG1hc3RlcikgIyAuL2NoZWNrIG52bWUvMDQ0DQpudm1lLzA0NCAoVGVzdCBiaS1k
aXJlY3Rpb25hbCBhdXRoZW50aWNhdGlvbikgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDEu
NzI5c8KgIC4uLsKgIDEuODkycw0KYmxrdGVzdHMgKG1hc3RlcikgIyAuL2NoZWNrIG52bWUvMDQ1
DQpudm1lLzA0NSAoVGVzdCByZS1hdXRoZW50aWNhdGlvbikgW3Bhc3NlZF0NCiDCoMKgwqAgcnVu
dGltZcKgIDQuNzk4c8KgIC4uLsKgIDYuMzAzcw0KDQotY2sNCg0KDQo=
