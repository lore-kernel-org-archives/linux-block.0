Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E852C001DE
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 00:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjG0AhG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 20:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjG0AhF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 20:37:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407E62688
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 17:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcVhNMRevCP99uqwoEe/n2zy4xsfQsId18X3RFEkkZHna+PRG2OMdFzIE9QbTRVSa9Q/98E7a2HbNCE/bYJuxt4A1mi0xnW42f3tIZ99rWSoc4UuHQEK3AkkMZU7LHv4l9TUom7B4ghHRJnZzDs5WuG1DWjvqK5QDJBmouLdM7vDnz9fFq2HeqWK7u7QQZG+QXPxrogNhatDbeg+Y7XxQRwo2rOLsu95WXUK+bsaHm0NTI95dSsi8udZcJxGtR0tlRC3bxN0Gsdk16Jjbjhyc7WrbFRAy573p+lJaGXq3d7xZVRjePOOIbucPVnmu6mxpGaL+UT6f2LjtPJS9F2C1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64mFU8twFak9NxByhkagUg/zealGihnhj+HXcMAeP+w=;
 b=aSfotjgtEzvq5neqRSr2pytpTp0+6quuOwL6zy6xI/GAzY79op8azBSXc1Zfy7N4fmcVVVdjq+Yo7SllWNaeTqFRgwzEX5Q2M6hbFqFLkzxRJ6/Yx4eHKqvXI2YVNLTE6SyWQwz9bq4RrA+TdB+UO1v9D+iZDIwCYU4CK1JSZymASOxWO4M20bvvgM4ztidqJRXsbBX6+I/vT5QO7WrQlxfcWQodDWm1bxGyGaigefBmc5BpeuVWFu49Kup+dljncK31O/D1HH69Vo2yG2ALBLiKPkorT9+7ZzB494RVoS8RKt0SzViGQyjv/aRIIvJhUM9/mUh853uO2shGt868Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64mFU8twFak9NxByhkagUg/zealGihnhj+HXcMAeP+w=;
 b=gT3g32uBSUlPV/ozrq9alqHffB1N1N3bl1l6t90yornv6WlrDjrE8cWMQZWHzE0NJ/nEjv8rsxZQlUYlSgp8eo/IhuO/kuV4ZeJHRL+n5ZsSr4hHyf3bLw/MnEc30yoBUvbW0dyK33rijB3JXf1/OXa+pAIlTlrgSzFwL2ez77XApFwxasGALge7eG9QYAvVqdVJmdJkxB8KnU/0XB9gDKQPMBsXH1AYeADi7E6FemaPB3XmbUhC9OexFyu+Smx2lknvXtbFDSHmxeMBh6ng4PQHblo1mDJ5PBYlo336026Q9jzCytojm6NjRD5fzxNOR6P/shpyS4xW2l/cfRnfsQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 00:37:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 00:36:55 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v4 4/7] block/null_blk: Support disabling zone write
 locking
Thread-Topic: [PATCH v4 4/7] block/null_blk: Support disabling zone write
 locking
Thread-Index: AQHZv/hU/2vrqIxsD0eCZEoqldeo7K/MxPMA
Date:   Thu, 27 Jul 2023 00:36:55 +0000
Message-ID: <0d4e873c-199f-3c47-7c27-3ebd5624fee6@nvidia.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-5-bvanassche@acm.org>
In-Reply-To: <20230726193440.1655149-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA1PR12MB7222:EE_
x-ms-office365-filtering-correlation-id: 996f5b9f-7316-44c3-4a0b-08db8e399434
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /4DvnVZnm1V2QBa+SWiKQzciv0sFLKXQkdLHuyf9uWBWgMaMzzjTKVSrJrUP5h6K+lX59b+uzXji9rgMXUefJRoiZfSwmKZuIxyTRY7ph99Fbb/80EsJAqzmlSFZMZV0Q2eqctfiVsco+lB6qv+ZUTKlz2Wxx8/yHQmGrrlhS2stkkGbtD8zElAlJifWM9ACoeQdEurlJ/9D3Q3UvPqqxqUBKI2a6D0VAbrpMCrxvYnu51l/XkgHZobfXsWv1ULOeLptze4talUqM5XwY1Lh4v1dK4T6Iebujm0kbeaqLw9D4fCG46YtWYnb8mpq53yKSKSfEbuZzUvrSKgpwf3I7zkb8zpoQKlz29igYcKKdfVr8aCtXHG7djRwm60U8TBgjN3sf9Wp5CN0kshiuzOxGKPgJh9z67lo7VdvViEbBahkb1NCcO1+uG7KMOZlZDmWAKzPSuDxw6eafRxapRR8iBVSD7ESrSBhdJB5t79OHoC39o6n3nd7mAKAY1Hgng2QQ+QibHJ9siwOUDQjd/NviBikJ/gAw7vlaAYn7oRFPrzdYCbjpEqoxnT7gKVIoou8cqFdKaYv9X2pfvgflR9Nt/tA4TwdZdKY7xH/JymeAg3RvfMl8snxD0p5iMEGa4ZYhMt7JTMIeF+t0FTpx62VA6ryS2aVWla/Ur0uxtkE1e7ekc5W+ua3+widVjgCK/NA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(71200400001)(6486002)(122000001)(2616005)(31686004)(6506007)(6512007)(478600001)(53546011)(54906003)(186003)(6916009)(4326008)(83380400001)(91956017)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(38100700002)(5660300002)(8936002)(8676002)(7416002)(38070700005)(4744005)(2906002)(41300700001)(316002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDIvRFVZWHo4R2dTNHBVVXpxT01EYlMrcFpGdSt1L0tCUkQ1OWVucUtaT0ho?=
 =?utf-8?B?eGUvVjNQR0RHNWQ4bWRDbEJwV2Q3SnludWZ6WXZBSnN0RXh6OHlmTVJxQXpy?=
 =?utf-8?B?MjJtTDNPSUZZZndMK1NRQ2VQeXRaaXd6MnVtb29nVENseE4zVVhDRjY4U1Rn?=
 =?utf-8?B?b3c3SzN6TEtJTVJpZmxpYVQycmdWc2x4UVphNmdXN3F6bkFiSkgwQWQra3Na?=
 =?utf-8?B?cXJwRUxaVm9LYk40R2tlaVR1UXB5akovR0M0c1JNOGVlcGpwRTZ4b2dQbEVN?=
 =?utf-8?B?WDZja1RPMm0zNkd4cUx3dE9WcUVQVlNBU21rUElpWU9LS3pkZCtlSlVqbUY2?=
 =?utf-8?B?QjVPV3l1d2NSZDN3Ymo4TzFseU4yeFdudjhUREJFT2x1R3ExVU1HK1J4c3lF?=
 =?utf-8?B?NGtWR0ZpN1dzdFRxWkZiNjAyNGREUlNBSmRZMk1ZMGphbkUyVEp3ZTY4TE5n?=
 =?utf-8?B?MHlkei9kU2xXK0MxOCs0b1pCeHNLaHNGc0lKTEFXb2Y5VlFLQkxEa0J1djBr?=
 =?utf-8?B?TVVkRGNvTnA5VDhhMkYyWC9BcFJxdHZNVUV0aHhJSmlDK1ovK3BiSFF3VXR3?=
 =?utf-8?B?MGVkb0k5SmthQ21pUldVTU5kR2MwT3RVQXh5bUErUkVPOHl4OVdIemYyUVZS?=
 =?utf-8?B?Q3dZVHRPeTZKVjRaVFhIeWJUaWxMYlMrRHZIN2J3UXN2d2FqZ1RJdWtGajc3?=
 =?utf-8?B?SGJYQ1VuRkpxSEZWbjdnWnMzWi9rUEhEd1c5WUl6WmErNUFsUExTUTRqSWlV?=
 =?utf-8?B?OW0rRFl1TUJNMzVDM0JmRTBRbHlhOHd2MExtOEtHdnBsNTRFMi9FbXNSd0JU?=
 =?utf-8?B?THNsRGlkRkprVTAvcEhkZVNQMitkZ20rRHMvTEh3OGVDS2VXQ25IcXdubGli?=
 =?utf-8?B?N2NOc3hyUHR2SVMwcTcyZlAzWmVhd0taaDhvczd2Ynllbi9ZeFJIUXh4TXNR?=
 =?utf-8?B?aG9pRnJ4ZDRwVExEU0Zmbml5Z3M2ZCtBbXA2OXF6bWI2aHBtQk1jbjJJcEZs?=
 =?utf-8?B?cHNDOUU5UHJnT1pIZkwxKzJpQ3YrUDJ2VVc1M1NRbmxnQ3hCQytvbGovV3RI?=
 =?utf-8?B?Sll0Q2hHbmJRenZ1SExkRVF1OUxxNDltbXNXVkkwcFkxd1RUSzdBa2twZ3VU?=
 =?utf-8?B?em1GZjFxZFFLVDhsUGxiQ2VreUtVZHRMeTBBWExUb0hMbkVsL295Smd0OEhj?=
 =?utf-8?B?TmtCckprQml2TCtlOGhYMG5zNHlycG11U2hpS3o2aTVOQzhxREdMV3E3am01?=
 =?utf-8?B?dU5zY2tkU0t2cnROQUZkUnV0Y25DUDJTR2tIY3VOemJTaXJQNzdtTUgzR0Z0?=
 =?utf-8?B?NVpTdnpKNXpKOGkwc1N5S0hEb1pRdmpPVXNPVkRwUmd5RXkyUkx1bWE0ODFU?=
 =?utf-8?B?MEQwN1VhWXR5U2Z3N3RKZEFTeUdaWkpNZklEZWdSYmhlN05RbU13NHN2Y3l6?=
 =?utf-8?B?bkFoeUR4R3YvbE1MNCt1VXQyV2MzSmZUNEgzQlF2dXNoZFdBZXVtK0tGRWZt?=
 =?utf-8?B?cG1aOG94V2VpajB5NDU2VUh0MzJkUEhBUHhCUUZ0ZlJuQnBrOXZPRzBTbjV0?=
 =?utf-8?B?alg4aENVQ250TGd6TGRSOWRya3RqN0dHUEI1RzdVUGIxVk5xTTJTcjNVVlF0?=
 =?utf-8?B?eHI0VWZzTENRK3l2RWM5V0UwclRsdnRzbUMzVGFvMzBQeWhubXBUZ2xQUGEx?=
 =?utf-8?B?Z3YxNGdaSGdCM1FvRE1yWnNxaW9pYlkrQ2w0VnRGS1VLRmN4U1Fwd00xb1NW?=
 =?utf-8?B?N092L2lyTGxIK1ZIMVBqNE55eWVvTlFid0RMelNXb0M3eU9EclZBc1l2YzhD?=
 =?utf-8?B?cEpNTGdSMVV3UmJIRXd4L3dpbWhZUnNYbGFhaFFkR1ZVZUhGV1UrRHRHa1JB?=
 =?utf-8?B?MWlwTDhZMzh4RWlHMUxxRzA3aG5naWNTNmtWMlFOQUEwUFE0ZldTK1NSdXVm?=
 =?utf-8?B?RDFtcGdrbXJGcjhxZWQ2ZmtsOWZMUG9VQ3hvb1RsSVg0YUMwSmY0WGRZRUZj?=
 =?utf-8?B?a2FRS3l6cjBRRlVlaVRpYlg0cnYwK0QyNE5GMnNTQlhjZFNidm5kaGV3cFl4?=
 =?utf-8?B?ajVHSHh1ZVZMYTZaYTh3THpIUzlwZWcrL0xQWTRrYVVYZk5pbmF2aFNBNlFW?=
 =?utf-8?B?cG96aXR5RGxzVVl4WTZCd1QzQUVBS3hrSEN3Y21JcmtvalBBYTJDSHd0a2Mw?=
 =?utf-8?Q?JkXrHr8sDt9L/rEMAsAqHQhqJv/85x7J1cC08o/JWSP1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A09F5D1C140F23469D4E40C61FC25986@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996f5b9f-7316-44c3-4a0b-08db8e399434
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 00:36:55.3479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkSTrhELBkP/+viGyjBscOqxbvMV5NbhobB9PHIl1ZoX5IaHY01M3yTXagvKtiIohSr6PITO99PQ5KrIGYV4tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNy8yNi8yMDIzIDEyOjM0IFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+IEFkZCBhIG5l
dyBjb25maWdmcyBhdHRyaWJ1dGUgZm9yIGRpc2FibGluZyB6b25lIHdyaXRlIGxvY2tpbmcuIFRl
c3RzDQo+IHNob3cgYSBwZXJmb3JtYW5jZSBvZiAyNTAgSyBJT1BTIHdpdGggbm8gSS9PIHNjaGVk
dWxlciwgNiBLIElPUFMgd2l0aA0KPiBtcS1kZWFkbGluZSBhbmQgd3JpdGUgbG9ja2luZyBlbmFi
bGVkIGFuZCAxMjMgSyBJT1BTIHdpdGggbXEtZGVhZGxpbmUNCj4gYW5kIHdyaXRlIGxvY2tpbmcg
ZGlzYWJsZWQuIFRoaXMgc2hvd3MgdGhhdCBkaXNhYmxpbmcgd3JpdGUgbG9ja2luZw0KPiByZXN1
bHRzIGluIGFib3V0IDIwIHRpbWVzIG1vcmUgSU9QUyBmb3IgdGhpcyBwYXJ0aWN1bGFyIHRlc3Qg
Y2FzZS4NCj4gDQo+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gQ2M6IERh
bWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IENjOiBNaW5nIExlaSA8bWluZy5s
ZWlAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNz
Y2hlQGFjbS5vcmc+DQo+IC0tLQ0KDQpUaGlzIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUsIHBlcmhh
cHMgYSBibGt0ZXN0cyB3b3VsZCBiZSBuaWNlIGluIHpiZA0KY2F0ZWdvcnkgPw0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
