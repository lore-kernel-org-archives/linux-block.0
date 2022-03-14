Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952F9C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 23:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbiCNXUn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 19:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242316AbiCNXUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 19:20:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3D2B2E
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 16:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4ccsMksZ1n5DYUhSt+WWbPzOf/oOcjjD+iQHSRe/LSIfwru8BE5fHxIYOhAdCe/aAP1rjj5qvaZI78vd3yjdx9UdD+8pt/CdvcGQ9vF8bBVEG0yqQxBX2E0Nc1y2ME+rrGSrGJoUMGsS2F6zUwwuVp74jGroJeh46TyXATC6oUK6+N++i1hFi0YItwvUUCaZJMn6weRVj4M8hbELmy2TXTwTur7czXkjKraLu51SH/Sogjb9WjOHQTBMOMfxyE7xLt8xDO/7vY3uQTrmL5T0tRMZQ5Jn5E2ZvV6FNuc1elp3uizvisKKAtG16DPfAgW3bT+Yz/oBOiTgmzhK4V+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDBVWp5toGDSHuyJgnFnUCa0Ciqy+BuVFQisFbeuzto=;
 b=YbBU7E/GAjo7XE1QRk16VLAV9ATs9l5ERxCR/cPNhQ7dfXrGq1lpd6fi8qZnSpjHqfUVq/nOK5v3GFFU3Fv27dpIphQDblIuNL5ZcPYf10WiNu3Cm7lunek6wmrmQV08qH+Aa0OHn7zqVz9vyUv1NOq9j1c6DUxMIEsk4Qi4P4B7L2ZES+/sOfSKM5XbeHkAJZIakVeY3f/GZ/A1fJHsIKD41Y0olcjmwt6xYf4PhP1Kdm57jBd6d6fPM1nNtXtTPaHgylVidNWj5cxDaafj3KKiu0btnDRgDPMybZzc3RhNSWr8l/6lGXAzAlRfEg0hiOCmLviSP/wC03ofYP6xcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDBVWp5toGDSHuyJgnFnUCa0Ciqy+BuVFQisFbeuzto=;
 b=XR4ZsaW0WEdrw0pzvrMpxwix8tTzCN/7T73nwxVwgVMubxcfT2iFvLCsOOS6cx6Bn2WsuJclPHEvSjHJRm5f7NAbq2MN/SZwp7j6W2wmZEY1Jz+bq3MNeKvQt77E8cyEPZIIuvVBC6oHAOEL3RJPb+JTaddk8DMpPDjZ+FIhhhB7kUJdCBZ0Wwa+jHWbY7pHxAEpz2LxPt1e9qNOAvC5F4CZQfvJADILmUA8JrJkczwfiF6oWespZnNTY/xVJFLefahkWJ2gDqjr7ksd1F1f9mMaWX6FLvsqGSmMg+zhHlLtEg/2t6UKn68r674vb6fw6d+Jx8NiKgtQKqtMcSTF8w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 23:19:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5061.026; Mon, 14 Mar 2022
 23:19:29 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/1] null-blk: replace deprecated ida_simple_xxx()
Thread-Topic: [PATCH 1/1] null-blk: replace deprecated ida_simple_xxx()
Thread-Index: AQHYNAFuVF+H/2N9n0qCSm+TSOS4bay3tZsAgAAm5wCAAAFdgIAAA4IAgAeqgwA=
Date:   Mon, 14 Mar 2022 23:19:29 +0000
Message-ID: <72870d6b-6d92-f068-18d2-22a19ff6bc2a@nvidia.com>
References: <20220309220222.20931-1-kch@nvidia.com>
 <20220309220222.20931-2-kch@nvidia.com>
 <1dd210d4-a3d7-30d4-341a-d7b308679008@opensource.wdc.com>
 <78d45c05-2e9d-47e8-89db-331553acd433@nvidia.com>
 <bcf0efa6-6fa0-5e81-64f4-b78a07e4dd65@nvidia.com>
 <26978007-81ef-2249-c6fb-593be5aed907@opensource.wdc.com>
In-Reply-To: <26978007-81ef-2249-c6fb-593be5aed907@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce6c26b6-d383-4936-d095-08da061116c3
x-ms-traffictypediagnostic: DS7PR12MB5981:EE_
x-microsoft-antispam-prvs: <DS7PR12MB59812FBB0136CBCEAAFF185AA30F9@DS7PR12MB5981.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6NBpI77iJTY9tHpwc3dVniuNvT9wNbbfXhaJ22rqMvghMFBRTt9HSHkhnKIMMHDsjeaTs/eTcJUKSuzhBjyX7lUOcBk9LuZ3KdtHCu7Eemb9NzTtCxnnZzrsX+Em66KqfJXSx8uONdTy64kMjccS5rO1nxnz83k2l5FlYSco1+fiM9QyNm1/71H0MA7eN1tyr5aviCss0t4QhRGfuK4ImwBj8W0Q3CUQBcnvL6imzYllkZExsCE26ihHGVLRmG0nLfIWfsphGB2HruCENwx6r+ousiBU23Z6Koli9kFyzIxQk7a1Ij2eBhGklqwWhezpzCQB5TFLhcf9sd+qq/UTrKmHscWfTJExI8oPEMW1zIS4DShci/zfYMWgzORT/TDclOKzvPbeXvPacF7Cy9QHorMhaZmDlIlCvm42o7PfQ+mTgQn5LUokXJDTFaSQdWYxn3WNK0RIMpxsmCHDzwxjfR5BczurrswIZtvUL5F4E2L53iuPwgSM+4r7UVs81hV2R25SZO6+AoGd4uLVwCEsCZaaId2Y772doAdGRmqxiMy6HmMMdOwVZpJSKk2Wrx8pUurOWUc/MVzbfvgH/rEGnQzZg18AZRCORKXSm2N7vyAR3SvvcwV6NvK5rvRXAvmrZIu9+C8r1ZT2joF5uYXFHdffsO1AutEC4G2K9KVfbomVy9/v2qkHr0Xs1gDrLm6DxUycrzVOeyeJndwg45xv/BABsbNsaiFOY8mFWSnBBvXrXLxIaeJjpBU6dh2lHghHtAHyHAo/MlhgYkMdhxK9cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(8676002)(76116006)(8936002)(66556008)(26005)(66476007)(4326008)(64756008)(66946007)(38100700002)(53546011)(66446008)(71200400001)(38070700005)(6916009)(6486002)(54906003)(508600001)(86362001)(91956017)(6506007)(316002)(31696002)(5660300002)(31686004)(6512007)(2616005)(36756003)(122000001)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1ZabEVUSjZWdjlFU3MwL3IvZ3UzY25QVFFyNDlaWXBpbDVnRTdwbXkwQ2dB?=
 =?utf-8?B?elBxazZSS1ZBRERVMDlhcWpuZEQzNEVwWHRnV1pxTXRxZ0dwZTJ5eEkzRTha?=
 =?utf-8?B?bUpVNktjWjQ0NWFwN3dUcEQ4WjVJZlU1OHM3M3Jwc293bHNrd3ozMElLUEtv?=
 =?utf-8?B?eWxzejFzVm5aMzFtZkFzNWU1bm9FY3Y1WFBCdmVDSm9NNUdsaSszdEZqdGF5?=
 =?utf-8?B?M1NTTUZxT0pwUUg1R1JuRzN3NUtpS0h3WTd0eW1KYzdhS2MxVDNRZGx3Nm1C?=
 =?utf-8?B?ZnB1VW1mcTFtU1loZmxobE9ubWtuOVZEdVh1R3RkOUh4UVc5Uy9ZRVhqTDdy?=
 =?utf-8?B?TGJ4ZTNGc2xJaUlxUEw5ejI1bXlDWkRYcERacDlBbWYxVm1kaG50QVZMU3VJ?=
 =?utf-8?B?Z09ZdjBEWUd0Zk1DN3NPMlovazFBeDlHWTlaMmEzeU5oN0JTNU9ZVFZiZm91?=
 =?utf-8?B?eWpOR2U0d3h4SnVPTEM5Q1JBa0lNUGhVSXBBVkREdVhWczVITlNIL2ZvTHFM?=
 =?utf-8?B?MGk1eDQ5dll1SVRraDI2aFlEOVhPSStzTWg4RFYzejRMSUhuWUlYT0xKU3NI?=
 =?utf-8?B?SWhsekMvZStEbUxYbjBXM1h6aW1jMm5lYkJJeTZzTCt5T2NNc2xnVEh6bGJP?=
 =?utf-8?B?ZkZJR0xHNldMeVV6dnV2YTdyNnNhK3NCL2wrRm1uaDdlTU00SmJkMThEZVVT?=
 =?utf-8?B?UEJlMDBjWW1YNmNyQkZrejI0RXF2b25lemVXZjV0VXduTUtVTmcwaFVQdTFJ?=
 =?utf-8?B?YlJOSE5KUHVuZWtrcW5uOEZ6aXkrUnAxSEN5U2h0UjBKVkpNcXkwQ0RZT1dv?=
 =?utf-8?B?Zzl5MWh1bWxvbDZXY3JkelY4alJKaWxvQkZOTnJJNk12K0RPN2pZR2lSR0Nu?=
 =?utf-8?B?U0N3NmJkV2FyN2RSVUk5aXp4SUxKU3c4UkpDTytKQkxnUXBFS2VoUzVMOXlP?=
 =?utf-8?B?TnJZcFo4Tnd0V3FXSXhrK0phQTJza2NvSUlBMDcrQ3R1bFJDa2VVQzBxNjhn?=
 =?utf-8?B?OENzelk0RHZaLzlMSU9oN05uY2Zsb0NTcUlQWHpzM0xtU1F2ZVRtR0cvM3Mr?=
 =?utf-8?B?ZWkvVThIakRVaFcrclhFUUFORGUvU2JpaXA2UTNQa2JIRVZRUnVpbWhLVzdr?=
 =?utf-8?B?QnVCMFA2OUVuZ2xEdERFdlY2VzNWL1pYSTYvVjNsOVQ4SHV4dEN6ZGt6MW1t?=
 =?utf-8?B?YWdVL1NlYjh0bnhXbVV6alNyaHp3Q2dlY0kwV2hROU1YdjVROVR5dkFsQXJo?=
 =?utf-8?B?YmFYd3pwSUJVZVBRUHlsQkFnMSt4NGhYWjZ2dHhVdDBrMytLNjdNRisveGZ2?=
 =?utf-8?B?cWZlZjZseHk0aFBzNjJ4RHFHSGRXcWJZczV6SFNEWWpIWmpENFdlR1lhN2hi?=
 =?utf-8?B?SElpMGY5cFhjdFRvYksvNmtzMmdOU3YxSERpOEhDME5NUVo0U3c1NDl0RXpo?=
 =?utf-8?B?TDNUeEJOR1ROVXZWVlVBLy9oRVpudkY2QXpGT1Rrdi81bWJtc0NDTnNpaGNS?=
 =?utf-8?B?eDhWTklUbmYvZklncGd2Q2g0aGxOZUtVa2tHSXozNE5VZVU2UmZKZll2SVdG?=
 =?utf-8?B?b2xraFk0YUduVjlJR0NQL3NkSncyM0Z3SklHNW16YU5HcHFYNWRnS2UzVXNy?=
 =?utf-8?B?WlhzY29jVkV3Z1JYYzc2OGtydEVFQmp0SFg4QzNHYWF6U2ZvS3RaRytad0lR?=
 =?utf-8?B?eEJKSkZtZTROVFh6ejJjaXR0V2QzZUdKN1RKb2dPUXcwcnhETXdHOEl4TkNU?=
 =?utf-8?B?TTBMRzc2cE1mcCtrc3NQSVE2UmcyWWNHQklIM3hTY1YrL0xVRGZnNlYxTmdG?=
 =?utf-8?B?aGxKU3FZT1lEallrcGh3dDdvZUd0SGhxcE5iazV6SlZqU1VMMjM2SHZUUmRx?=
 =?utf-8?B?MDdYelF1VENYaW1wczlwWHM1dlRzOXhYd1ZsUlJVemdGZnUvd3BQaWczcnRT?=
 =?utf-8?Q?4LVEL+4jOfnm9YpAFieXRiYpJNXdLajL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3212AB355B3FB548A3661057288F2076@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6c26b6-d383-4936-d095-08da061116c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 23:19:29.1707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKUusoBSbvFRVpqaU1vP3CzYYW3BqO7KxTs8n65ePPr8liiSAKbzaaezgRyp8LUC6aXGhLaK7qtW9JQFlYJsgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy85LzIyIDE4OjE1LCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gT24gMy8xMC8yMiAxMTow
MiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gT24gMy85LzIyIDE3OjU3LCBDaGFpdGFu
eWEgS3Vsa2Fybmkgd3JvdGU6DQo+Pj4gT24gMy85LzIyIDE1OjM4LCBEYW1pZW4gTGUgTW9hbCB3
cm90ZToNCj4+Pj4gT24gMy8xMC8yMiAwNzowMiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0K
Pj4+DQo+Pj4gWy4uXQ0KPj4+DQo+Pj4+PiBAQCAtMjA0NCw3ICsyMDQ0LDcgQEAgc3RhdGljIGlu
dCBudWxsX2FkZF9kZXYoc3RydWN0IG51bGxiX2RldmljZSAqZGV2KQ0KPj4+Pj4gIMKgwqDCoMKg
wqAgYmxrX3F1ZXVlX2ZsYWdfY2xlYXIoUVVFVUVfRkxBR19BRERfUkFORE9NLCBudWxsYi0+cSk7
DQo+Pj4+PiAgwqDCoMKgwqDCoCBtdXRleF9sb2NrKCZsb2NrKTsNCj4+Pj4+IC3CoMKgwqAgbnVs
bGItPmluZGV4ID0gaWRhX3NpbXBsZV9nZXQoJm51bGxiX2luZGV4ZXMsIDAsIDAsIEdGUF9LRVJO
RUwpOw0KPj4+Pj4gK8KgwqDCoCBudWxsYi0+aW5kZXggPSBpZGFfYWxsb2MoJm51bGxiX2luZGV4
ZXMsIEdGUF9LRVJORUwpOw0KPj4+Pg0KPj4+PiBEbyB3ZSBuZWVkIGVycm9yIGNoZWNrIGhlcmUg
PyBOb3QgZW50aXJlbHkgc3VyZSBpZiBpZGFfZnJlZSgpIHRvbGVyYXRlcw0KPj4+PiBiZWluZyBw
YXNzZWQgYSBmYWlsZWQgaWRhX2FsbG9jKCkgbnVsbGJfaW5kZXhlcy4uLiBBIHF1aWNrIGxvb2sg
YXQNCj4+Pj4gaWRhX2ZyZWUoKSBkb2VzIG5vdCBzaG93IGFueXRoaW5nIG9idmlvdXMsIHNvIGl0
IG1heSBiZSB3b3J0aCBjaGVja2luZw0KPj4+PiBpbiBkZXRhaWwuDQo+Pj4+DQo+Pj4NCj4+PiBH
b29kIHBvaW50LCBidXQgb3JpZ2luYWwgY29kZSBkb2Vzbid0IGhhdmUgZXJyb3IgY2hlY2tpbmcs
IHRoaXMgcGF0Y2gNCj4+PiBldmVudHVhbGx5IGVuZHMgdXAgY2FsbGluZyBzYW1lIGZ1bmN0aW9u
IHdoYXQgb3JpZ2luYWwgY29kZSB3YXMgZG9pbmcuDQo+Pj4NCj4+PiBTaW5jZSB0aGlzIGlzIGp1
c3QgYSByZXBsYWNlbWVudCBwYXRjaCBzaG91bGQgd2UgYWRkIGEgMm5kIHBhdGNoIG9uIHRoZQ0K
Pj4+IHRvcCBvZiB0aGlzIGZvciBlcnJvciBoYW5kbGluZyA/IG9yIHlvdSBwcmVmZXIgdG8gaGF2
ZSBpdCBpbiB0aGUgc2FtZQ0KPj4+IG9uZSA/DQo+Pj4NCj4+PiAtY2sNCj4+Pg0KPj4NCj4+IEFs
c28gbnVsbGItPmluZGV4IGlzIGRlZmluZWQgYXMgdW5zaWduZWQgaW50IFsxXSBzbyBpbiBvcmRl
ciB0byBhZGQNCj4+IGVycm9yIGhhbmRsaW5nIHdlIG5lZWQgdG8gY2hhbmdlIHRoZSB0eXBlIG9m
IHZhcmlhYmxlLCBzbyBJIHRoaW5rIGl0DQo+PiBtYWtlcyB0byBtYWtlIGl0IGEgc2VwYXJhdGUg
cGF0Y2ggdGhhbiByZW1vdmluZyBkZXByZWNhdGVkIEFQSSwgbG1rLg0KPiANCj4gT25lIHBhdGNo
IHRvIGFkZCB0aGUgbWlzc2luZyBlcnJvciBjaGVjayBhbmQgY2hhbmdlIHRoZSBpbmRleCB0eXBl
LCB3aXRoDQo+IGNjIHN0YWJsZSBmb3IgYmFja3BvcnQsIGFuZCBhIHNlY29uZCBwYXRjaCB0byBz
d2l0Y2ggdG8gdGhlIG5ldyBhcGkgb24NCj4gdG9wIG9mIHRoZSBmaXgsIHdpdGhvdXQgY2Mgc3Rh
YmxlLiBObyA/DQo+IA0KDQp5ZXMsIHdpbGwgc2VuZCBvdXQgVjIgc29vbi4NCg0KLWNrDQoNCg0K
DQo=
