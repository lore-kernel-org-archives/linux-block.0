Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83FFC001DE
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 02:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjHICI0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 22:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHICIZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 22:08:25 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6A01999
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 19:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7qu3yb5k+ecCskXSNj/svO3ktpifcmBIlLRADFg1FdcF6w+5gwmf1BIXlQJ0qx+guCEwzLFLJRGMDwvrhRVAZ+V3Gp64QRJKaBmKjVk7cIBYmqvUBldREzccBPkAClsqlrljCZacquevPeCbMDK//x43f3LHrlSMqcsA5aqTjOxNvfCqod6LeCaAE0dVgt3qkF5oTvd5tbohHwc90gmdr3mYJk6f7J/UxD5LaNyI6a6LkYQ4cYenCAon2a90XUOA8otNxvacf7FNoJz2gL9aAm4beomELosHZ38d/+N8YidjgfGGpwHXwphJ6N4Qfgv93adtI60Eca5phWJ1j4zdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTEoUlB8BUZX8Lum4Kj9Zm37x/a+NLW6NTwShVFVeU8=;
 b=KZxqYInX2E45ux9FYtrYZhcNwJBqE2qdzWyKr8J6VbcJKdb28h6JnW3sS8SSJOwhlC0mf+docKoDbFbO/qrTjckuOUkHv1n6cbYxfgAqB0V1/DfXLkwEaPPVlHcVjEGw/FtDe3wVfmaOLOD/+F9D26YO9a9WXFksz7+XaqQ3sdGmB7lGWVbhdvI0Sz08wOKCw4z7zvJVZiFZ66Q+p5zzz/2ht1KsUCvjiOFBcU9sFb/eOge4I2gWM3SRr+fCasdsvMPkI5nfXyLkAVW99GaeEzLphQnA1xyyCIal17ugoNaK2x36lSD0zr3eBMeZh1j2X/oWOU7/VRztSF7dJLupqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTEoUlB8BUZX8Lum4Kj9Zm37x/a+NLW6NTwShVFVeU8=;
 b=rx6j+rinNYIL9+KF3WtN+DZBumqa/Yev8GtZtxKKY81LY/VP2sWUZppumSkynJxQmEPpbas2ql0bk6dW95hKnyLyZ2US7zL/PPd0kaTxb4oZPppId3R4UkNxl8j0J39fJhUVOVo5L316DaTaw/Qv/gHnxUcT6r4Fgu0jm/T9HVrQZBzFOtGXsE9LBLkHnO1NbarjV3Ah+UCB2obPHOtAyP5zMmNEdqZbprHc/5+eCYE+5vVKDk7Doci2RIPjAemWlzYplT8HATFh7k1MZX8tB8SqI9jPplz7WuJB0Ao48y6emiRcgay87X2RYbve/7U81l/H+GYq6Zk+z0YbZpMNUQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 02:08:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 02:08:20 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 5/5] block: switch ldm partition code to use pr_xxx()
 functions
Thread-Topic: [PATCH 5/5] block: switch ldm partition code to use pr_xxx()
 functions
Thread-Index: AQHZyiGkGfGs/2C1x0u+e2l/rNq68q/hOHeA
Date:   Wed, 9 Aug 2023 02:08:20 +0000
Message-ID: <96360bbe-1169-c977-5932-e974972e27b6@nvidia.com>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-6-dlemoal@kernel.org>
In-Reply-To: <20230808135702.628588-6-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH3PR12MB9395:EE_
x-ms-office365-filtering-correlation-id: c018aead-9447-4db2-3bf0-08db987d80c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DbUp52Oj8kBvnDchKk5AYsqu2idawHkD3N7nrmIaWlWlY0qiyuLJCc4rOknPb/rkT5CDf/uTEDnfX21DyjwQu8eDmRBPYfZ6e6Nl5YlrPawtpeDb4fEcHiK1Y+Sa4TCe0DIfADTodZM+3uGrPHT5ohAeeevDnlsuianWI/a/qjdIXfvFQ/nRbQWJmXUVNq2clpnesjdwaIYW0XQBnQvU2IeeOJHoTCeGBs9gpvD3m4Ip1l0pQnl1iZ7QcAZRtcpFyjGEDeAiiixcI7UZCM+cm5QVxfozbH+JsWqo8g49hmX1qLZUefD3qIqTYkbLNwrXpGVMA0tH0CoRTRIMWS9ARkX0TsJOYYQqGU0QKEy5EtzVq7XufxYn/M8h6BgIgqR0LpePcndg+/YhTA1zM3rWa3dkF/lHTlBHozSepEeYrG7oKRqyfILhi/Km89Lys/2DJ8xv//Ob2AcyUaZRYrK8knumMMoJgswLFwn1ekjtw3DfozwY+D3Qkv8pcYxixT8sqfCsR/zOuMIezmj68Fa68Fmv0arV6QZhH0dJEL9sCvzPyvCuvA+ejFk+b6Y7dTtxyE+BbRrJUZW/PeXO/EVRxOsMzPoLvkrud7hHqkK1Bcy08TshJROwDYIiMwjtbDBg8IG3TNBHXX58ArwIszQce626cVD/zGyWTquIRLK+8o6Br+BPAtkj7sAXGBJO0xo0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(1800799006)(451199021)(186006)(8936002)(8676002)(38070700005)(5660300002)(66446008)(316002)(41300700001)(86362001)(83380400001)(31696002)(64756008)(2906002)(4744005)(6486002)(6512007)(71200400001)(2616005)(6506007)(53546011)(26005)(36756003)(91956017)(76116006)(66556008)(66946007)(66476007)(122000001)(478600001)(31686004)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YURoS2gvRXhsVkVuS1BFQjVVcXF6clRnVG5Ra1VxWk1xL3ZXLzFxRzl4NWV4?=
 =?utf-8?B?M24wZ0xNRzNxZzRKU1NjeU1FeWptTFFickwxc3NIbEgvNzFYalZkeFNUV2ZG?=
 =?utf-8?B?YURldTRpSU9xcXF6VHp4ajVJSkVuR0VOanAvd3U2YVloTGtiMEE3QytQMzI0?=
 =?utf-8?B?U1FVbVRGbDZFNnlOT2xta1FELzF3Q3NFZTIwd2VrNDluRmJVTTZBMHJLejFH?=
 =?utf-8?B?bzcvK2xKNnR1Wms4dlFta3Rqc2JIcHNYbVg5ZVBUSlhTOVExUjRzcXpHdzkz?=
 =?utf-8?B?VmV3SjVKSkcxRnRveVJmRktYWDFFbk1WUVp6dG8vTEo1UEw3R0xrVTVkMWFn?=
 =?utf-8?B?VkNjaUZSd2RrbkFLT3FMaXNVZGlMTk9UVk04TlkyN24yR3NUT2RSTXc4bXlt?=
 =?utf-8?B?VVlwcU5kTGNSZDNobmdjSlVQazZQbUFkMC9qbFRkaFBQOVNDbWJ1SFlDMFZL?=
 =?utf-8?B?VFFpMHdVT0dvL1hTMFQrL0s3ZWlLbHhpL3doRjZIVjRUNHBjcXlBNnhCblZ3?=
 =?utf-8?B?eStwRnpDM3VQMEhNOTl3bjBNUFlUOEpabDNydmdidC9oS0NENndCY0FjUWJr?=
 =?utf-8?B?UHZkZWRzQWxLZjdybzZ0MkFseTRIeEdZVVRPTmsyY3ROU05SNUI4cG9DNXcw?=
 =?utf-8?B?djRyNHFFVDFBbkNJT1VCZGRSRklwejRWajVMSnRjaEdhSlZ2a2UvMjRtSXpP?=
 =?utf-8?B?R1lDUFpzUGVtbUdmenRTV3NhbGFld0lUS2MvbWkzYXFYVzFqNFRBMkdoWGJB?=
 =?utf-8?B?cmNrc0RxSzZtamtpNDdKMFlqejQxTnVZdTRzZ05uNHdWNnNwQkJMNk90aDFC?=
 =?utf-8?B?Qm4zTEJ1K3MvRWZxblBXVTArU0pudkkwRzFoaHNHWk1pOWtMOWpmMTU5ZkY5?=
 =?utf-8?B?L2tjSE9pUytlUjQzeFY4ZDlyb29wa29pVTBZMkFIQU0wd0gwRmcyWE8yWjJy?=
 =?utf-8?B?Y0hha3ZmUFgra2ZhL3N1MENjcEZpbWJBRVQvcEhjeEwwMWF6bnJBSWlURjdx?=
 =?utf-8?B?Ym16NDU4WlZNRmh4SXBtT1gzbGJRYTNwVXE2Z3g2SUdHUW1oZTM4czdYYmN0?=
 =?utf-8?B?alUrMHFFTWRBZkk2V2M4U24zTnVHOUR1c3BhRk5jeS9lYVVNMUJjY1VhZTNN?=
 =?utf-8?B?L28wR3R1RTNBZmo4V2htakkyVHZEZjRCWkJpZG91ekJsNDdPMVVDY2JhUnFV?=
 =?utf-8?B?UTYwejhxU0VvRE5SSTBXQmFaYzFPQnlCYUxxNktzR3pObnZDYm96dVlRRHhh?=
 =?utf-8?B?QTdGbHFYSy84SDRqQ2NYdW8zM0doREx4NUhScnNjczBDazJHVCtqUHVwa1Rz?=
 =?utf-8?B?a0w4aHVuRnc1enIvMVZlUmsyRXNkT2dSQVJFczFTbDE2bGVvdFdMMzdRQ3ZJ?=
 =?utf-8?B?RzM3ZFN2VDh5MDBUNXVFSGM5T25TNjgvdmZkSUJUWm9LNzFqRWhBTVo2Z1hU?=
 =?utf-8?B?cWxFRElCaVJYWFhaSTRIRlJtVzFTVjhzU0kwdjBnTzdUTVN6Q0NNbDJ6ejd5?=
 =?utf-8?B?QkpHTGxIb01yVm54eGxmR3ptV3BxTXVmUXRqWExPWkVJdUIrSjk1cGw0azdI?=
 =?utf-8?B?VUUwRGhiL0RnNVNVZGJvOG8yMUoyRGUvT2RVUXBXbllLWUlScWI2SDUzQ3Nw?=
 =?utf-8?B?MXdiaUYycWZNQ0poa3VnL1R1bTBkbnVVY00yOEcvSXNrZFNoa09pZGFneGsx?=
 =?utf-8?B?L0pSam1EdVlJbCtSaHRSclA4SVFDVFQ4RFp1RkRtRm1oUUFsd1ExT01kZzZq?=
 =?utf-8?B?alBkZ016RmhRSWE0QkJIbmhBMCtOWUNmU0NTcE8yamhzWGdFRndCVStSM1FG?=
 =?utf-8?B?VVJ3UGIxZmFFaGRwZ3JmSlZQT092b1hnZkI0VkVjZVBHWjhqUVNPVU5udlEv?=
 =?utf-8?B?Y1FWWS9JcWFNekxnOEIxN054dzR0RXcwOVlXTHJlaFhGZ1dJYW5Wcis0TGNl?=
 =?utf-8?B?U1pvKzlIUDJtYWxiRHE5VXp6dk1uMUc4aUdtVmJOQmlZUWErdXVHeDQvY1Uv?=
 =?utf-8?B?UzNxd2dZaHBuNUhJV3lNdXNXdk4ydmRST3RtbEJYR3Q1aTl5Nzl6djN2YWFu?=
 =?utf-8?B?L2c2ZEYwVXkvTFp6Nm05M0prMjk0VkNLY1ZMcW9CUzBaU1ZBTmFwVjlkMUFt?=
 =?utf-8?Q?fwvKo0TpDgk28SXvf2KB2vSoL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B346030C89CB340B10CB84257D7F4A1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c018aead-9447-4db2-3bf0-08db987d80c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 02:08:20.1343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkInSHXHc62z2+TVB0GiTPSIHUU2Or7DMfiWq+JJJrzgA0XQqePhTDet7PmErni3wKkYoSCOhzrQkJBH3hPcww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC84LzIwMjMgNjo1NyBBTSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE1vZGlmeSB0aGUg
bGRtIHBhcnRpdGlvbiBjb2RlIHRvIHVzZSB0aGUgcmVndWxhciBwcl9pbmZvKCksIHByX2Vycigp
IGV0Yw0KPiBmdW5jdGlvbnMgaW5zdGVhZCBvZiB1c2luZyBwcmludGsoKS4gV2l0aCB0aGlzIGNo
YW5nZSwgdGhlIGZ1bmN0aW9uDQo+IF9sZG1fcHJpbnRrKCkgaXMgbm90IG5lY2Vzc2FyeSBhbmQg
cmVtb3ZlZC4gVGhlIHNwZWNpYWwgTERNX0RFQlVHDQo+IGNvbmZpZ3VyYXRpb24gb3B0aW9uIGlz
IGFsc28gcmVtb3ZlZCBhcyByZWd1bGFyIGR5bmFtaWMgZGVidWcgY29udHJvbA0KPiBjYW4gYmUg
dXNlZCB0byB0dXJuIG9uIG9yIG9mZiB0aGUgZGVidWcgbWVzc2FnZXMuIFJlZmVyZW5jZXMgdG8g
dGhpcw0KPiBjb25maWd1cmF0aW9uIG9wdGlvbiBpcyByZW1vdmVkIGZyb20gdGhlIGRvY3VtZW50
YXRpb24gYW5kIGZyb20gdGhlIG02OGsNCj4gZGVmY29uZmlnLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg0K
