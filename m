Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FC1C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 06:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiJJGvr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 02:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiJJGvp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 02:51:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5888EE76
        for <linux-block@vger.kernel.org>; Sun,  9 Oct 2022 23:51:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG6ByBOoOgmTpYzyElIOCQheIJ1yKRr3ICLcz2Z+29zObsjKI4m4kJnWekmxyqzsIy8giN7eSl9gEKN9QqfdFMmtX+TNepHYCD6fAbMugEWXxUSz7FdzJ2ULu+LlK9oKYYyVptwOkXR09YJS3qGKiHygMZJhQCaWnkzehq52NcJsD/56kGUnrC6iTS6FWgAA/xtTlgl3Ob3NInSz8oTsxfBDtJ8U4594E2MOkXZEthE/sx0pYApGo4DAMCsecJqpGIg3shZnM9L6tpnHy0Xp10VoySdJKDOMCZ2OA/MRtN5b+sYlisCOZbqeOe6ITnD+fRdkRYFE5/D/QIDNIYLZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B1E0vqArqvlDKYwgWSWgWe2vG/OALsdWn3fW99jEkw=;
 b=AFqclIAltYZI0qbW0Zlth+3zVWy34zOJRa8uuXHcaE/0SuZ3tn2Q9/vVHcbGVx2mHI9MAki4FNvy37oKfSMRQcmutc9qyGmLps8DD2O5znxsfIOFt4ZGUnioVNIGA2hB9D20zPdk8lFfWoO97aB9G1Ta1GvXF9U5UfAHH9xdGCfvefrHzCylg02xGk58EJb0wuEPCM1zrGMqGv0M0X2wwOsV58ukW9Y9iLBYVlu3XBg6xQZZ/ppw0qQgpnnzR3DcHXnGL7yhivPeK2DvxgtrNLeXNmxJ+Sl0TV+BHhUPSjoOJGRQ4vxYltrblKP+Bzdxlmqg5H8bjhKXK+zN/ullmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B1E0vqArqvlDKYwgWSWgWe2vG/OALsdWn3fW99jEkw=;
 b=h9c9vvk+zWs/U1EpMuY+J2hVTwuOyZOKebEPJHPpOt+YNJZpvnVmCEygKjbVVMYWcwHmZIRqnRUPnpYpnUaDz4ONh8SCV9xbrzhu4mi/UYpXzep0eTztpbjPm8INw+ABfRy7oMMaQEMBk9i47J9hGe+8tz/voJ6vFyMGgqZAbYB0VsuMSk054cUEqXL7ovdZodkft5zRdhSk2FXRWgmbRq0v26NsfUUP/87dtupuvkfrrrHq0sxx3XA9vLm5O6N7g+h0cDJJEqapkk8EWMWMzgzRcrw5c1iiPq7LegzwApJbrmZ05L0X+/LbViWq6j+2z74+NnbwGNCiWCdQ8cKRGA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Mon, 10 Oct
 2022 06:51:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947%4]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 06:51:41 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@meta.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv2] block: fix leaking minors of hidden disks
Thread-Topic: [PATCHv2] block: fix leaking minors of hidden disks
Thread-Index: AQHY2oR6n6Pj70e85ku91VvDhNs3Z64HNHYA
Date:   Mon, 10 Oct 2022 06:51:41 +0000
Message-ID: <44a694c4-1cb7-244a-a9a8-84e17c41502a@nvidia.com>
References: <20221007193825.4058951-1-kbusch@meta.com>
In-Reply-To: <20221007193825.4058951-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA1PR12MB5638:EE_
x-ms-office365-filtering-correlation-id: 9776cf26-a24e-4c40-4138-08daaa8be30e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6TDYeLI7aX6G/hQDh2ZgIWcJR4Bl48bOK5Uip8cQdAXrJeWU9K66rXtq/sdslq0swr05anSibBQ3y0ZXkhYY4zo5L5OI5usIH1xD85SU1eRXLWvHY9W0eWdRJDBZw62IQO1IXOHOrrXsmDJFkeojNzAoE6UjslRWnDmNC6kB3xLG8opR8W2hz9nJP2dTKdlPfvUZLicrR7/a9NxnBL53bGBtscuk7YFuLy3qkitLV32vhRpJwstEgyfMPLth+5VSp3bWs/HaQqiigdx2mYwNdCVhWmAuxd+0RdtCIO6dRCGQIsKQy8E3MMDGzW5DrFAXClmM4n5xyzPkswArCYzkW/nofr1GB3bD8Dz5a3buNKbmm8nk/k6ZVfsBK4xbrY0cmmI/iqt/8igTbnZ7OiZ2Wwy4JbxoXDjJbEtqUjHOxNdtQliAxdJhL7a7lNYhCtrZVEdwGuSu5Veyf1skUhNrv2qu8p+jIeI7ns8Mm75v9yWr314FcaaYZBx6nWr/s+xQOfcKxI70HiptOpAYFZ9l1oiQOlIwNPNFhB2xnqMPOfK5PVWcVMpNcL63oLPVJ4GhUddCfPOnkz6LEU0mRcd4vhaO9xOksnXD5Gifo+Pne6Y3aUD5I55Dw2SD2o4fEhHta3/rN4I3WT2x/373cUJVoDNgXWqjEe717OkkPjHmcfMNTJtHKo6WK0QNrdIkq0vYvS6ZoUFD58KIjU+4YUEGmkv4fARZNg5yAqs+js9dWr427ZGMzPajp+OJogfrNUmp3AKC/RFgZpNS5bGPVZ1Z0AKZgbF6+9jh5SGjiaZFWuFqd/JjLXJY51Pq6k3dNO298yeM5QJeK+dAqKBuDH+2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199015)(66476007)(66446008)(54906003)(66946007)(31686004)(316002)(91956017)(76116006)(4326008)(64756008)(8676002)(110136005)(6486002)(31696002)(478600001)(122000001)(38100700002)(2906002)(66556008)(6512007)(53546011)(36756003)(41300700001)(6506007)(71200400001)(83380400001)(38070700005)(5660300002)(186003)(86362001)(8936002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTQ5bkJPZitac3FONWprWFVlMjcwVWsvcERYLzJ5N1JGN2Q5SDBTbGZkeVJZ?=
 =?utf-8?B?Qk5VVk5rZEp4dlRibXAwYm00WGRidHRTM09iTVZFa3pOUG9SNGZJMlN6K2dL?=
 =?utf-8?B?Q3c4dkg1dkxJS1ZwQUtmT2EzQmF0encwUmlNK0dJSjM2VWRkamJqM1IyZmR3?=
 =?utf-8?B?a1FXRGNkS2pINHVvSDRNV2EzYXM4TkNyNStPWXJoa2hWOFQvWTdTUmwzZm9S?=
 =?utf-8?B?Q2NFY3UvbkIxcGxBMWxMNEcraG9BdEI2RnhJNjhTUVg2aWxvVGR4QkxXNHJm?=
 =?utf-8?B?Y0xzRkkwV0lPMjNsbnVvRWpQZGRHR2gwZ1UrZWo5cXFmeTg2aFJ5dEtYVEo1?=
 =?utf-8?B?bEZ5aFdOdnNkREFWVTBJRFZ1WU5FMGRYV2dvQTQxL0lnTk5qZTAvVW1IRy9Q?=
 =?utf-8?B?aWpCcEZHNENHSjkwMXpmeFN1VThqSXhNTGpVd2pMMXpBTlIxUFFDQ005YnVr?=
 =?utf-8?B?L24wQUNWckNnb2RWMGV4WU9FcW9HUEx2SjlqYjR1VWFQejZHYi9RR3hFUllq?=
 =?utf-8?B?U2tsY2ZObFkwMm5DVWpqRUVjQTNCWE1ocTdBMVJibEt1OTRpTTU0Ly9DQ1BZ?=
 =?utf-8?B?M1hBL1U4eTg2V2pnMWgzYWc4YXR3dUJoaUkyRFFSUzl3OWM3eks0dmZqSG96?=
 =?utf-8?B?aHhlOCsvWEU1Zmg5V0pJOHE3ZTZDM3VVcEpIUy9mZDBDdkU1RGhZMjJSNy9x?=
 =?utf-8?B?UmJiVGswRC9hc3dOQjNSUGNBYUlmRlkzLzAzMzhMenozcUVhU3JkT01hQmsv?=
 =?utf-8?B?bnpmRG5ucmJ3bzNUOTk5M2VLWndvV1JZTFBYY001cTNiU29SZDgvTjkyaE1M?=
 =?utf-8?B?d0UzNEhWd2FUMDVkR2d5RmJ6UktFak94Y2Q3d3VTbkpjTW5CRVJiUFAwZE9P?=
 =?utf-8?B?T2c4M2FjT0IwbDc0SHlBTlhIb0pmc2RNYzNzUXFGdnByemlyMXVQUUFYZzNS?=
 =?utf-8?B?aThNSXhzM0duQnpNS21yTXRsMEVwRWh3SkVjOEhpeGVhVEdzeHhjS0d4WjNx?=
 =?utf-8?B?S3pKbElGa2cxVWdnVFFFK1YxMy9CZUxPazBkeU5zOEtkZjJEdjZEUlRHOHNy?=
 =?utf-8?B?cHdBdXA5a1ZYZDdqU1libWVIb3RxaFgxUGRGaGkxeit1anl3WnRKVGh1QmR6?=
 =?utf-8?B?NTZLZWxWMm5ZN0xNcUdaV1dsYTY5aTVzdGtDU3lnYnNkQzJ5M0ljQm1EU09r?=
 =?utf-8?B?WFpGTFdCNTlFSFRtQWgvaFNJTUdLSUt1WW5ZR1gxL1RWOXArcFNQTVZUYWN2?=
 =?utf-8?B?czZ0TlVGbms1ZWpHcFR5MlFEeDFhb1pCTG00bHRtRkFZcEF1Vnc5TjFwS3FI?=
 =?utf-8?B?a0h5ajJKQmNSU2ZPaXRqYkx0eEZKcDJ2eDUwdzY2ZlpjckNFU2lOUmVXay9j?=
 =?utf-8?B?T2FKdk5BQXVLR25kM2wvZ2pySUdvNTRPUzY3QjFPSGY0NEFUSmNPQmtrUnE3?=
 =?utf-8?B?Rm40aVAzUnhWcjhxemExNFJ5R2tZNDE0Ky9VZmljTGJCMzlhRXRNTlJjSlI0?=
 =?utf-8?B?cWdvQThFUXZsSWptNTZra0lRcGlQcXNTTkRUM1pnbEpBODcrK1RVVUNnYkgw?=
 =?utf-8?B?QUJQOGlKTXc4NGpLYlRUWDZJdWJBMUFJc1dWWkg3MFhWblNoelRxWEsxUzRV?=
 =?utf-8?B?clR2bllYV3YvMmdHbkdSSjhPelVEaGNPWHh2TS9UNmp4R3RjcGIvR2M0T0tr?=
 =?utf-8?B?UEdFSCtQbWVQZlVwWFkyK3poVFRBR2Z4VTd6clAxci9TS3pPQUNRK09ZMDNr?=
 =?utf-8?B?VmdPZS90UFczSngxNS9xa25WL1VJN2E3MVkwOEVoN2xXRzhsWUV0ckF4QUZR?=
 =?utf-8?B?TjVNWmFjV3AyQWNldWFiVGc0U1NsREd0aVVYQVFDdWttN1J6N1FPdk13SjN6?=
 =?utf-8?B?NU5jeWZZUFQ1SXIwQ0YyQmE1SU4rb1RwZ0F4ODd5TnVTSXBKNmdsV2h5YnN5?=
 =?utf-8?B?ODI0YWtQd04rNnRNMk1wWHBaRDhhZGlCdG0zTTZGam5lWFdEYzg4L0pjbUM3?=
 =?utf-8?B?STRVZ3VLN1hWanA4Y0tPM2tGd24wTExUTDBVSTM5OEtCMlJZTVRtTkVpNDBr?=
 =?utf-8?B?QThrZk94V3grS0RzN3VDQWR4dUo2QzRKUFJnNGpTaXRuRmxmYitoNEp4NlJK?=
 =?utf-8?B?UmUyRFUvK1VtWWFWQ3FrYnJkdFBuREFPNy9zaG1naTFZZUczT3drNzJKVEcz?=
 =?utf-8?Q?FhHAgsD86+c/R0tapEX5eslzwzC/IQDUu4m0cTTaNJXa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87698AF29F427945A65F27D628A2814E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9776cf26-a24e-4c40-4138-08daaa8be30e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 06:51:41.2416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KP7qyqQ+nCNtkfaJtKZlRtws2tAFg556t6pPqHsdwMwNGKM4pS/gXNRdfACzrSINfpIu4PaVZTaG5Y/8lQn+1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvNy8yMiAxMjozOCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFRoZSBtYWpvci9taW5vciBvZiBhIGhpZGRlbiBn
ZW5kaXNrIGlzIG5vdCBwcm9wYWdhdGVkIHRvIHRoZSBibG9jaw0KPiBkZXZpY2UuIFRoaXMgaXMg
cmVxdWlyZWQgdG8gc3VwcHJlc3MgaXQgZnJvbSBiZWluZyB2aXNpYmxlLiBGb3IgdGhlc2UNCj4g
ZGlza3MsIHdlIG5lZWQgdG8gaGFuZGxlIGZyZWVpbmcgdGhlIGR5bmFtaWMgbWlub3IgZGlyZWN0
bHkgd2hlbiBpdCdzDQo+IHJlbGVhc2VkIHNpbmNlIGJkZXZfZnJlZV9pbm9kZSgpIHdvbid0IGJl
IGFibGUgdG8uDQo+IA0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJl
cG9ydGVkLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+IFNpZ25lZC1vZmYt
Ynk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gLS0tDQo+IHYxLT52MjoNCj4g
DQo+ICAgIEFjdHVhbGx5IGNoZWNrIHRoYXQgdGhlIGRpc2sgaXMgaGlkZGVuIGJlZm9yZSBhc3N1
bWluZyB0aGUgbWlub3IgbmVlZHMNCj4gICAgdG8gYmUgZnJlZWQuDQo+IA0KPiAgIGJsb2NrL2dl
bmhkLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL2dlbmhkLmMgYi9ibG9jay9nZW5oZC5jDQo+IGluZGV4IDUxNDM5
NTM2MWQ3Yy4uMGFmY2RiYjc1NzVjIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9nZW5oZC5jDQo+ICsr
KyBiL2Jsb2NrL2dlbmhkLmMNCj4gQEAgLTExNjYsNiArMTE2Niw4IEBAIHN0YXRpYyB2b2lkIGRp
c2tfcmVsZWFzZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgCWlmICh0ZXN0X2JpdChHRF9BRERF
RCwgJmRpc2stPnN0YXRlKSAmJiBkaXNrLT5mb3BzLT5mcmVlX2Rpc2spDQo+ICAgCQlkaXNrLT5m
b3BzLT5mcmVlX2Rpc2soZGlzayk7DQo+ICAgDQo+ICsJaWYgKChkaXNrLT5mbGFncyAmIEdFTkhE
X0ZMX0hJRERFTikgJiYgZGlzay0+bWFqb3IgPT0gQkxPQ0tfRVhUX01BSk9SKQ0KPiArCQlibGtf
ZnJlZV9leHRfbWlub3IoZGlzay0+Zmlyc3RfbWlub3IpOw0KPiAgIAlpcHV0KGRpc2stPnBhcnQw
LT5iZF9pbm9kZSk7CS8qIGZyZWVzIHRoZSBkaXNrICovDQo+ICAgfQ0KPiAgIA0KDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0K
