Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F358C6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 18:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCVSQp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCVSQo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 14:16:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72C5A1A0
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 11:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJuh3d+5i4acyKeCQ7CQ9tFJL1e/QWYlha/3EL5LDqcPPSFA4Z9CUxKpPxKjZI8zYoZtk9qSQli74MOiq/Rel8/EYOSCnsClBeeXB2xJGUn1JQTX71EwXZ0KDaZ/bopUrmSzVCSPM+NKXvURb0N0T1FwT8nwRqip7Z9i+qkL4eTI/a45wtdJg0TMnoIGNO0TRyP5ohHMXye4KoUizW8DBQrBZcHyW3xzeVjAOsd2kCcI8xerLuHAMug3jO8Z9HSpCTqpfN0IvF4q4WcaDYwwXN2Vg2b3TGkepb6QZ5hvGotqhMwGkxrxbIOotexkoBsvbCGad29jDx+tTT3CcN2xgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf0FJFko7DEkX2H3uZ5DhM2QtqdW7YxBAtDpnsD0h20=;
 b=R8wwp7uABi1vvw4MAsWIo0e8VihB3nEe51W4zuvoit4GCWva0rXK4Rj2FvoYcbZ8Fa5P2C8oQcoUUIxxNaBBu6xUqc2mbfa0tT7jvOwek3QrmGwwh1gN4RLTJGVZRKgkDkzXmcXZfQYBtjywIA23aAi/FFeib1z6KJSBuVaFcjTYT6C6fnTLkklVZJgB2ugNLuS5hvkCUHFrdyM8mzRAyV7k806sph7NcPY6uN/aBdSdjT6yMm+yERuH3+Y/0eNP6GwXY0Bw5ZKQIxTXw3FXOlEmDana/YaPM0ylhFO4g+GY4sNdm1W6X35y6E/Nv9el/G4VjcOcWHQ6WY8b36E/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf0FJFko7DEkX2H3uZ5DhM2QtqdW7YxBAtDpnsD0h20=;
 b=pFdlFuWr+dglHZb5om8hOSHH+dA+u7Ka7Du5x6oLSzai+EJ8Tz2JA6boKk702FJRkJrKZpkAiF+H+4Cx4M9kPE9EFFKZ1JIltJcdz64lwzyx0h5Pbio7dyHwQbNZHchoqKCudeOi+EP1MaBNBwNdXQDo25NR8GodGPF4DfN3g1AuOTbW2FW3Joc1P/S1pyZ/K0qU0tETcPCMvpCNu7bqhjcY8nRfJJPfMOhAuhz6n2iXQ4Np7Mc7pbvOheb8D8+UY9rPl5R5O3DnLTJh0hvUQRYJTzLejgaSGTY2AF36ps32ZCSYXIhk5D9+BaDJ2uuZKH9gC5YKCCAK+La7X4YDRg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5298.namprd12.prod.outlook.com (2603:10b6:610:d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 18:16:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 18:16:41 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@meta.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH 3/3] blk-mq: directly poll requests
Thread-Topic: [PATCH 3/3] blk-mq: directly poll requests
Thread-Index: AQHZXFSi57iJ9TAJcESDFDwMjWsKEa8Gen+AgAChvQA=
Date:   Wed, 22 Mar 2023 18:16:41 +0000
Message-ID: <3f670ca7-908d-db55-3da1-4090f116005d@nvidia.com>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-4-kbusch@meta.com>
 <20230322083747.ljos4iqkklworudl@carbon.lan>
In-Reply-To: <20230322083747.ljos4iqkklworudl@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5298:EE_
x-ms-office365-filtering-correlation-id: f767414d-f776-43c1-ccb8-08db2b0195d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G5rDSzT/b+cx/+SFnjWZJNjlBHtTtlcvC60I8Vm2wIck8MONtaIY6h/IBVYKxnojSKpKgQ5SXSVd1jNtB/3FR6eeEJxaD9Ia2lUX855iQdyB3Um5dcyFvGHV1kDS8IeoC5GhNZ09mCiKL6TfL3Xy47IZTW4Nr4i9G9TTWHQ7xivt6TOLDowXCgWQlZzVQ1MMVe56rbKAFRVqQogOhxkgiusIQPutG9pLiQwOLgk5bm4CZg8uCpgVOvq7mJWHNhwhmcT8ggMc028BLJlnmb5ic8ocxRO+9gIgKNYkakVgHdaYNQEgd9nnzVGufVFkYIlw3/ud02CTMY8W2vTWqoMxvBWcsTeBTemkePxUeIhpaWaQX/mraw9NfyxY9cPXdPLqyOZ9kkaeG1B/1VSmTs40y92b9zOIlI4rDygu5PxROS4xNkLpBrAoRXNn2FvdCr8UJ6oXe2cAzdEM+bSuvM7RItx/p8fLfVighjCS3CFDA1Io+ZGiozgZ7SO/v0IUDoyyBOm+26hCfdyT2/Wcmcx7V/fEXTIXvTAiLWz3Pvq8OrGoXrmGmsyVv6MWHh+vjV4j7i1wUB2d2OzfSn5LquJ4vc/gz8i+BD/eSDJweVpmSojEe182YcOFTRPd8k8ZwA5oLbJHgl4X+xrvI7BTQWcdQajeU+ZluQkLCwbDpfK05cSKbYnscyE7nfQ4qEKtv6eaEeWW5wKT+RwswmTcvRhHH6mmrzDzBpyDAnXedOlBQktnoqfAB/NNvujtQHiFAc5hMsB5YydngdpKRdVeWlNKKf8epySvNigpKX/6OCY9lLvwqEZLtsY3GlPxwcthWfoq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199018)(86362001)(31686004)(2616005)(6486002)(38070700005)(966005)(26005)(6506007)(6512007)(53546011)(186003)(71200400001)(31696002)(38100700002)(478600001)(122000001)(2906002)(4326008)(83380400001)(91956017)(66476007)(4744005)(54906003)(66946007)(8676002)(110136005)(64756008)(316002)(5660300002)(66446008)(8936002)(41300700001)(66556008)(76116006)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzMrajdqYWtNZVpqV1R2cWZLdFFTTndYRHhtd0FwUkV0bHpCUnhpTW90cGFE?=
 =?utf-8?B?THdkZmhPSHR2MUI1ei9SN0hJM2RQVEdheFJ4VGg4WjBNTzRZRGxhWWdoSEV4?=
 =?utf-8?B?dGxjOXhhWmt6ejVnZEI5Z0EraVNUVDVoTTRiTC9VTUh3azdDQnl2VzBuWGt4?=
 =?utf-8?B?WjNEbU4waGlxTUxYV3JYUDgrcHJVdjJ2LzlSOElxaDVaYzB4MXc2Uyt1UlNo?=
 =?utf-8?B?dXY0WVhrOEFPSXlWbVFUVjdvcFpXWUdUV2xRVlZkeVJoQUhiM1VVdElyWElC?=
 =?utf-8?B?NGxWSHFhMWY0REl5SEdMTTRBenM3R2xPcHo5Z0NqNXFEdHh0eDMvSVo1N0M1?=
 =?utf-8?B?T3pJN292SFJGWm9kakZFa1pzL1EwRWpDN0dBcHRjVWlaUjlKUFhMeUFXS2N2?=
 =?utf-8?B?ZkIxRkx0QURqRFBWeTRXWGlxVndoYjFPTFN3cGJTZnovNmJTNmNnTk9BMExC?=
 =?utf-8?B?azIvQnh2cG0wVnYyUk5aRjRMTWJrQVo1Nkw1NlBlbFl5UTkxWUwzUHFQaytm?=
 =?utf-8?B?aDFRNGhtRUxyY21FYjF6QWdINnJqMVJMNVZMa0ZXSHdMNWs2QXVaNkZIaXF0?=
 =?utf-8?B?TTZ5ZlBEQS8vT2VpUzRzRkVGcUgxZ3A1RkVqd0lMNkpjWktNUW5zTmVuK3N0?=
 =?utf-8?B?Rkl6Zm0xcHlKRWkvUEpONU9VNzZHQndRKzFOaDlWR3RKZE5ZUDM4U25vY1RT?=
 =?utf-8?B?dlB0aDdsYm9ONG9STkliN1EwSzNzMEtpTGUwY1ZrMG1FWnlmU0pNMDRZUmox?=
 =?utf-8?B?a2dmaFZockt5Y0IvVk1hS3EwdUtsMVc0TmI0Q2FXRUFPa2E3RG1kcG15T29i?=
 =?utf-8?B?M3pYK2RvUGtvcW45SU9wMlNDVGRUWWJMUHFJZndsZ25xVFlzS3J5OWFrTUty?=
 =?utf-8?B?NHBzYWpkN2QxZWNGdHk3dGplelNoVUVwMG9DcU9RMFM2ZmFBQjVSc1JqNTVv?=
 =?utf-8?B?RjkxMXcweTNBMlVjZTJYZER6YmdVUitHVmFMNmRzclR5R2JxM2hpL1hEVzNP?=
 =?utf-8?B?cCt0YTgyakJ2MUNPZUdaTjdFcGwxRjJLMmNFTlZoV015UUNJL05scjFNY3pY?=
 =?utf-8?B?V0FycHVjKzg4eFdFVC9YdXFyU2dWRTJlSlhYMFE5MlMwenJEV2M1OTA5WEMy?=
 =?utf-8?B?VnJCQW5Pc3pGd3JLS203aXVibHZBRlpyeTJwMmFINTUvL04xbEtQejhpZTRH?=
 =?utf-8?B?YmxQdGJoejFHczdGZlFUUzZKUndpZXkvNmhMeEk4Zkd6VkJVZTlsSE1MTlhk?=
 =?utf-8?B?S0hHNkVGd3V1aGRrdnZKM2d6MGZtMEMyeGxmSlE3MnQ0bDhacEdwbEFjSldY?=
 =?utf-8?B?TVdSU0E5WU1HSjlGSlRUNmJCUzg1dlc4M0xVSFFDMHZaVXFDZldxdDRmZXN4?=
 =?utf-8?B?ckFzd3dMd3ZxNE9CeE1BaXVWdkc0eitHRkRCNGNiczlhQUVCNWRiNjlydER5?=
 =?utf-8?B?RnZaa250QUdPbjZpOGZZMS84VUVuS1ZlWXl1cHhYMkpDQ285djdMc1FpN2k5?=
 =?utf-8?B?QnlCbjhnZWZWTmRudDE5V3dyZGhMcysvM3RGbkhBNmYzNktkQUpQUnFGM0pB?=
 =?utf-8?B?YkRmL3k0YnlybVpocWdTd3NrTlFrdGZjclhMdTQwMGllTWlkNXlrQkNEUXNK?=
 =?utf-8?B?SWk3VDluYlFpa1ltd1M1OUxvVStJVE81MmhNZWJqVVJuUW95MkRtVUREWS9O?=
 =?utf-8?B?VjhuVjlWaVVaSGMyN0tDVFB1RW8vZ25SQzhnZXRhbUhuV1JvWmlnekcvcUtR?=
 =?utf-8?B?V2NIZVBjVEs0cmc3dnIvQ2xISEtnVFo5RlJ4ZnBySjBnWHJpOFFzam92NmUx?=
 =?utf-8?B?cnhWZ1VnVit3SVBLRWlkazFkdWxMaEljWlVKbTdjb01TQkhDWG85WUdnVUJa?=
 =?utf-8?B?U1NocmRGYlFFc3FlNXAzL0luYmpnZmYxUkJyakJBSWZsRUZpaFdvTXRWWDhv?=
 =?utf-8?B?M0FwY2prZ0FIa1B2NG12NytWNlh6REtrMkdnRVlUUGQxcm82b1ErUGpFajBQ?=
 =?utf-8?B?Qk5HVTc3aUZ3aGtzTW8vSWZFR2RKYVdzb1UxNCtOUFJ1cFByZTBhQXkwVldz?=
 =?utf-8?B?ZHBIaVQ0V2pSR3ptU2JmWUVtRjlHQmRiNXhlOVJUWkN5ejh0WUx1UlpKeklW?=
 =?utf-8?Q?Ue4YRjX3+gzQHOmpD2erejB/Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90AECBEFBF50564FA14DD100B9CE176F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f767414d-f776-43c1-ccb8-08db2b0195d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 18:16:41.1039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sjq7vZSlqKQafjmmEHoMWXvYzMrAxzTBL5sANucmzSRxbLLR/kZQTOxI7k/THgQxgaho1/DY5PpzvhgB0ilu/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5298
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yMi8yMyAwMTozNywgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gT24gVHVlLCBNYXIgMjEs
IDIwMjMgYXQgMDU6MjM6NTBQTSAtMDcwMCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+PiBGcm9tOiBL
ZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+Pg0KPj4gUG9sbGluZyBuZWVkcyBhIGJp
byB3aXRoIGEgdmFsaWQgYmlfYmRldiwgYnV0IG5laXRoZXIgb2YgdGhvc2UgYXJlDQo+PiBndWFy
YW50ZWVkIGZvciBwb2xsZWQgZHJpdmVyIHJlcXVlc3RzLiBNYWtlIHJlcXVlc3QgYmFzZWQgcG9s
bGluZyB1c2UNCj4+IGRpcmVjdGx5IHVzZSBibGstbXEncyBwb2xsaW5nIGZ1bmN0aW9uLg0KPj4N
Cj4+IFdoZW4gZXhlY3V0aW5nIGEgcmVxdWVzdCBmcm9tIGEgcG9sbGVkIGhjdHgsIHdlIGtub3cg
dGhlIHJlcXVlc3Qncw0KPj4gY29va2llLCBhbmQgdGhhdCBpdCdzIGZyb20gYSBsaXZlIG11bHRp
LXF1ZXVlIHRoYXQgc3VwcG9ydHMgcG9sbGluZywgc28NCj4+IHdlIGNhbiBzYWZlbHkgc2tpcCBl
dmVyeXRoaW5nIHRoYXQgYmlvX3BvbGwgcHJvdmlkZXMuDQo+Pg0KPj4gTGluazogaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52bWUvMjAyMy1NYXJjaC8wMzgzNDAu
aHRtbA0KPj4gUmVwb3J0ZWQtYnk6IE1hcnRpbiBCZWxhbmdlciA8TWFydGluLkJlbGFuZ2VyQGRl
bGwuY29tPg0KPj4gUmVwb3J0ZWQtYnk6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gSSd2
ZSB0ZXN0ZWQgdGhlIHdob2xlIHNlcmllcyBhbmQgdGhpcyBwYXRjaCBhbG9uZSB3aXRoIHJkbWEg
YW5kIHRjcC4NCj4NCj4gVGVzdGVkLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+
DQo+IFJldmllZGVkLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQoNClRoYW5r
cyBEYW5pZWwsIHBsZWFzZSBhZGQgbXkgdGFnIGFsc28uDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
