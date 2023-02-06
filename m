Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A14C61DA4
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 04:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBFEnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Feb 2023 23:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFEnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Feb 2023 23:43:21 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235F115543
        for <linux-block@vger.kernel.org>; Sun,  5 Feb 2023 20:43:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1tlglc75rczgGjHoIgqel9BSldEHIug74j7QgShJkvRFkCcgvfeq2R0MuWPKtgfoc9N/MDxXlhUBa34d/AlcpzBA2EeMKN8RCli8I83B+AgiIK9tLW9z81cZYsD59nu3HiuCTgJ/cFVDpTqgg+nJO1GKhvsVkv76edUDvSVDZ3mTzna8vwpM9TZKtLCyAHbovmYwRtt+eyZCuGTn4itDhrnAEuWnvF7sg2fci7p8aH339t5PUeOvXY90wH9xJuoBoksh+V1rOWyouuiiJ3RDu49TS1Xm6TXuxgGvtphVIHXi2TLaMtMjQPWd73XSUO1n55qngiXHDUBTDVfpqjJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBJ39CKJNtFSJAcTVrS9Eo9SJ92WJd57fQHb5hy5O+o=;
 b=THZL87Jv/LT67LwotTvpjRvbFHJOliNnfDdeIec2MD7wkbn8oMJtu/ly8dSXUQkiQKZPisdMVndPMtsTWhDwKJiOcZCuVXgEG15238MKwNGUMiHC4qNSzO8hCUUzdEq/yhzwri+mY9lDqEUuzeSy231TbyAo6oClSjWqbwmBb/DG36UwEmhrzO+txBuXOAE7PzxFZgt9/ZuPGdpJSqgJKyC3iKfe1RRHKb4TgT+K3CF2q5Bb0r1bQEXHbrlPWs/EC89Pm26cVwBdaQeU9ZCHJezxodJv+HWYraXhAAD+OVup4xpYi/4OKCd5NBel3nEOhCKwb3v8lCcd9K/9awjX1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBJ39CKJNtFSJAcTVrS9Eo9SJ92WJd57fQHb5hy5O+o=;
 b=JGBdz7X0lhJbQu90nLlw/VeXFzNJ8/cwOyIljauTP9fNdk8+HiDoV1+kdY/uTFxbLMIbdp+Nb994bKIdojo+4+5VRqWcVh2CQnTy5KbQYxcTyt9h5yLh8Htu8oZNc4gLMDBMik+FjMr+7nVgQ2zi6J5/OFhpdymwRcC5v8WjLAAyi3OXCIHt9aO9ieIIr+OSYkqb66ZtyVojicqCr82vLzs6V8dgA/5hp8XJnUXBdzsMeVW8zUAXutC30ytcsg1CWwZ9WRbl1nFrQAjzzSKqBNJT3wUuxm7AYKAojgDWqU+yuza87gnPS1ICf6lxKJt3Ww07MSnfJkI6WEHo6RsV9Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 04:43:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 04:43:16 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: stub out and deprecated the capability attribute
 on the gendisk
Thread-Topic: [PATCH] block: stub out and deprecated the capability attribute
 on the gendisk
Thread-Index: AQHZN+CeQ8iuT3PIOkKLtbE48xaHRa7BW0uA
Date:   Mon, 6 Feb 2023 04:43:16 +0000
Message-ID: <43bd8e91-27d0-5063-d367-0433ebf72c2b@nvidia.com>
References: <20230203150209.3199115-1-hch@lst.de>
In-Reply-To: <20230203150209.3199115-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5091:EE_
x-ms-office365-filtering-correlation-id: 9beca95d-7a70-4628-7285-08db07fca995
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5GqKnUwns3TjJ57y7OoMwTuRas21geGOpe+owBdA/KRwiTk08m4eNJHDOL2fka7p+gksLrxAP3dQ3T43UB7wMH2gamvTfLi+l81LtjDPKRo7dvkuUbj8V/33YjRu9yKMzOJ5eQ9mVKuaoAS1a1UbNlt+cJ1LYxVdDQjYjvihqbJVooJ4DNUt/iX3VzbyK+tJovZGvjPzaATxLZa5e3PYPpSVV5Lz6OJugKtGRuu3ldG2QwnSSQBu/wdtTVRSljAggpx470q/KX+N4GIJL5yvx3MTazAnJxZelCaon8xLlR37JoKe7y43FMI4uIB/lZcVh5+qLFK4I3zykvfGaS3blq8HPlzlF3b+RXaMgfowAy7ugFIBVKJA/kEdaEIMXJ+jbqVIV6XyR4yBbAgTsTsAgWj/e3EJJ9VYI/AZptfW/UDynlqId0230EOyqWrR/gVt0a/xLvUx/rSa3NY6xs9DkowebYoUfRco0mCeD3K5xAernrpZDw19vQnFJwOHeNQwVkTIhM3bM6gbaCBH6g0c+++f9LYdlL0SJJKEc7lFbaDq+VUiwV+61z6G4FgE7D1mNpMFJ2EECHmktFD3VOlzoheGEadLlPrf1EZtESZbcxpofmNgZ+3hCsAQacs+yb6ImF7jDPfVgaINYER7p1PSXYpEaaedOf4A5KozPr9jCqDKB8x5q+VHxgyd4p/I68S3acoBp0fYKdwzdmNZxaz2R6JhbCS9EL3pBe1ZpN07sv34Zk7fZHmOZJ5+Alio2sSH7U6t182sP4nAuR1qz/g25A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199018)(316002)(110136005)(6512007)(26005)(31696002)(86362001)(71200400001)(36756003)(31686004)(186003)(66946007)(66476007)(64756008)(2906002)(4744005)(8936002)(66556008)(4326008)(8676002)(5660300002)(41300700001)(2616005)(6506007)(6486002)(53546011)(478600001)(66446008)(38100700002)(76116006)(38070700005)(91956017)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RStPZHo4WE5rdnVtay80eVFGVEtqNVArQ3YrVGNyTEhpNVc0UkZsN1JqdzM3?=
 =?utf-8?B?ZWN0MDBhYS81Tm5DYi9kODNpdjl1clhtWGFzeWpTaW93QUppZDMrTnFocmVI?=
 =?utf-8?B?cTRTNW1NUVFDUURxMk44UnowUkJkSVhWdnpacWhuRGZZWkd3RmlrU3ZESFg4?=
 =?utf-8?B?ZGpSenQyeE9KNW5TSkxUcFBhMEREVWpGdEw1bHNXWWVneDF5MjFEVDUweWNu?=
 =?utf-8?B?bDB3OGNtcWJLNCtyK3dvdHZNL1FhWGhWMEZIa0ljcTZsUyt1SzJXMEdLWG1z?=
 =?utf-8?B?MHJncVM4OS9rNTJSUys3NXd5VnU2a2YzTkVETnQrbS9pcjJEUzU4WmF0UTk4?=
 =?utf-8?B?emhlVFJ0dWRRUms2dGZGVVZ4TWZqamVYcDNHdXd1Z1hjd3puNWpYZ3hwbE5G?=
 =?utf-8?B?dGV3U2pKQlZFdFRlNGlWUzA4bVpVSGhtY1JRTlBqaktKVS9mQnlERHhxaGFu?=
 =?utf-8?B?RWF3aVRpRENLNStFM1VmV3Y4OE5tMzIySG5oaWl4NUJaeVFDbHBORFNlTVFM?=
 =?utf-8?B?UFBMenFCc2RiSWZCT1l5Nk52SzhrempodHJiVlhWRFJhYld0OXZLd2h2NHJY?=
 =?utf-8?B?ZzZPbzc2NHU0andOaTBiNEhUNXQ5b3R0bzdPWHdDcmJudVdCQUNpcDJLWUd1?=
 =?utf-8?B?NnlQeTMyREJEeDRmeHBsbHZ0cW15SGpKVWFNUHd4cElURTc3cG9mS3JkYWZD?=
 =?utf-8?B?ZmY2czBTaUcvSjNsMVQ3aU9WOTJWMWE2cWw2ZDNjSm9rcjR1QVpTWUVrNjlq?=
 =?utf-8?B?cVVwY0poUGlyOVVXSHltN0lDSFYrb2pWS3ZQQnRROFplUWpOb3hPUWRVK0Ix?=
 =?utf-8?B?bGpSbnZ1ekpxcTFRRnFCNFltcDl5ME9PNnhNNXpwNi9IWmlWYkZJV3lyeXBk?=
 =?utf-8?B?NnIvUU9XZkovT0pCSG5obmJMTnhYWU9IYk5qSncyU2JaZVpTWm1iWkt1d3k4?=
 =?utf-8?B?Um5wMzdzZUI2MFY1Y1UvazhrK1hjd1FyRWtEc2NkZ1VEd0FxZlNDOUlua1BW?=
 =?utf-8?B?bVllcjkweU9GbEZ4SllXc2FkUnpnVFVYdmVQQUs1SGx6Vjhvczd0Q29HenF1?=
 =?utf-8?B?cDBVeVptRW9ZWmZYcWsrNGRuaXg3R0lTRWVQcXQxajdMaVNjdDh3d1I4Ri9x?=
 =?utf-8?B?cHU2enMyQUVWM2UySXE0R3VUdXdsL3MybVE0Qm5Nc3RSazNQTXFNb3dqbXox?=
 =?utf-8?B?M1hLZHVsWmhFaG0yRDdBYmtVOHN3VlltTWpvaUlreE5CL0prZFNKdkJuY0JW?=
 =?utf-8?B?aTlsbllYdmdUVHhKL2hiZTlJYnNQSTEwdnIyZE43bnF4SXRld0xUMGh1ZE16?=
 =?utf-8?B?dTljdWNvVVErTkl4ZmJycUZ1dlZnNG4wMXcrbFVhNjgzSjUzZ2VOeCs5OVQy?=
 =?utf-8?B?dkkwdXVNWTd3dEJEMDlyVm96WmFvV0UwWmh2ZnF2cFhuU3BRMCtwalF5bTdK?=
 =?utf-8?B?aTdudHRFdFI4YmlxaDdGSElqVmU3aVliMTZzMGl6WURSQzQrZUdpd05kaHVB?=
 =?utf-8?B?bllEZEJ3Sy9aWDJuVGhtT0RkYkpPa0tSWDcxTkFjY3BKRE8ydXQzTVBjak1S?=
 =?utf-8?B?VGxkWlJGZ2JPQ3BVUUMrTSsxTkttclpqT0Z4YjZ6VVd3VjdFNzZZMUJPcXdJ?=
 =?utf-8?B?MkFPZjJZNWJudzNGWHZBVk5CNnBIWHJFMDlSeHZMeTZJWjBQRjRHdnNxWWc2?=
 =?utf-8?B?SWpCWTBkZWpwMWJjSm11ZzQwN1dRMnZtVGtCNk5OYmdmRnVjV1dtVXFnZ0dP?=
 =?utf-8?B?L3JRZnRCN2dwbTZmM1poamZQR3lrUEZVODhBTFN3MG1PQ2FybGxUZ1pGcXVu?=
 =?utf-8?B?UEVSaGlDSGZUVHcrVm83bGdmQ0ZpZ3JiV1BucExlNXhxdlNvbll3eFN1S0pY?=
 =?utf-8?B?WGk0M0ZlVUQ0SWpKRU02aC9QTkExNis4MFB2Q0hkWmNpT0dMNkEvZ0hqZXM5?=
 =?utf-8?B?Umt5K3FKZGoyYy82b1YvdkdpQktPbTB3SmVVcWw0ZG03cE1sbUZ1a0hoZHlR?=
 =?utf-8?B?VDBob1hzZEpZQ1luOUNDak1xay9pTVJkNitWNWI3Mkw5bmc0aEdObFFRb1U1?=
 =?utf-8?B?K01DcENmaVZSNGJ1S3JyZExIbHRVd1dJV3BtTFY5TTVuTm5PV3MwZWFjRHgz?=
 =?utf-8?Q?ZE/81NAKqaYoVMkbPGsmgL/34?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AD77C49E717CF48B6871E346546BA48@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9beca95d-7a70-4628-7285-08db07fca995
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 04:43:16.0728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjDGg2Kz6+qAfxTNC+UcZ8EcktjmvXUFJbuZLfLujjknrVdOLLmjHCUyPQ+/W0hjbUw2Ccq7BE8Q1wAQcJAb6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8zLzIzIDA3OjAyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gVGhlIGNhcGFiaWxp
dHkgYXR0cmlidXRlIHdhcyBhZGRlZCBpbiAyMDE3IHRvIGV4cG9zZSB0aGUga2VybmVsIGludGVy
bmFsDQo+IEdFTkhEX0ZMX01FRElBX0NIQU5HRV9OT1RJRlkgdG8gdXNlcnNwYWNlIHdpdGhvdXQg
ZXZlciBhZGRpbmcgYSB2YWx1ZSB0bw0KPiBhbiBVQVBJIGhlYWRlciwgYW5kIHdpdGhvdXQgZXZl
ciBzZXR0aW5nIGl0IGluIGFueSBkcml2ZXIgdW50aWwgaXQgd2FzDQo+IGZpbmFsbHkgcmVtb3Zl
ZCBpbiBMaW51eCA1LjcuDQo+IA0KPiBEZXByZWNhdGUgdGhlIGZpbGUgYW5kIGFsd2F5cyByZXR1
cm4gMCBpbnN0ZWFkIG9mIGV4cG9zaW5nIHRoZSBvdGhlcg0KPiBpbnRlcm5hbCBhbmQgZnJlcXVl
bnRseSByZW51bWJlcmVkIG90aGVyIGdlbmRpc2sgZmxhZ3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg0K
