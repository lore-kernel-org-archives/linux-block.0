Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Mar 2022 10:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiCQK2n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiCQK2n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Mar 2022 06:28:43 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98AB1DE6E3
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 03:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUXKAExDVcrvGmC0wP7BEp5biUf9v5P9Sn1V9Pb6a5luMCmBFgflCe7P8xBefEYz35fos0pZ9z6pgagJrTOODFPzIKIG5TF4x4VRFhAb62Xl2az1109VJx3V5QBEIwWDxR4ARSArGA9ac7Bxl7Yno3xbSkAMnLfEy7rD5M6IFg1Fced4CcBCmzaQFB6SzyWW0fmBooG/+wvlFzFVlQQUPhS2xVDIpBWTuYQO+TmW3bGvD1w8qc/wnj46NnMoLefQfzOlyUfXavugzdmwayF+Acc6rZXWIRwjZNFd2UX6/L11bwYqAnXIEKR4MAf/PQGkfI5GqSObaOUlWpDaN0kRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdM2HO+nuavu4DYxDf4BRg/8+q+DWeFVo0zlqZzPea4=;
 b=AcTynWxEREosBZ4wkL7jLJn4MWY58IDiogaJMMRWF65LkuaGMSdSUIrjcHfhJlY+IcC8v+dFJde7SeV4/LwWOEOQxXpj49oXWfB/0CG4Cjy5ohD6iiRhJEzRmUcNKKMZGTz7vfPUxptujqFZMauwWjfCqgghHYpj9rZ2lkQ/ZlQjtnhvzky82LEWPN3f15bO0pOPgxIXEpZ5doIROBz3+D8ke0Hb38OcbQPMgcGRZck40bscSrpyn9QVm47s6DF2dqygXG+vO17vjpunmzsz1SGLvvSJ+7XLceoQ1GAFNKYArMTEWKv+js9KFKYNu6zwvYn01JCzRKtM39NoN9Pn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdM2HO+nuavu4DYxDf4BRg/8+q+DWeFVo0zlqZzPea4=;
 b=M7+wLfxjB2r/45iOrdBiBYIM6chEtc4JeeT427Kc7rA7xbV7Wc0kl6uny4jtDJVRk7G3iJIKVYsRAHMe8o5keQVL1XV50Q4z2WtlwNjA/zLXIFiyW0mptnd0Oo4glKShj928QErj74KX4EqY1xzphdnSrEuB8OLWzG+en+P84fvK8T/xzmJw8gWll/lw/LnYqShpA4OkviJEe8tXWCCdowCESISU5KKJcEE/OOttyeO3x1upwXOT+gvPZvemOV9ffyWi7oxMf4dDVZWufLPXCaNmn0DLIXGWIdF0EO9xcxkBZc5wkmhQTlD8Qj9i0Fj1/M8dhPP+7oJcKsoSRSfQWA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 10:27:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 10:27:21 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Eric Wheeler <linux-block@lists.ewheeler.net>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: loop: are parallel requests serialized by the single workqueue?
Thread-Topic: loop: are parallel requests serialized by the single workqueue?
Thread-Index: AQHYOac8nCi3kHkmYkGUOXoc1OmimazDXg6AgAABzQA=
Date:   Thu, 17 Mar 2022 10:27:21 +0000
Message-ID: <96e2b30e-516a-92ce-0d31-c88101e6c930@nvidia.com>
References: <59a58637-837-fc28-6cb9-d584aa21d60@ewheeler.net>
 <6349f346-5b23-0d2f-0759-c97a56577822@nvidia.com>
In-Reply-To: <6349f346-5b23-0d2f-0759-c97a56577822@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61130ee3-e231-443e-fd32-08da0800b84d
x-ms-traffictypediagnostic: BL1PR12MB5080:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5080BAE4F7A431802F103D65A3129@BL1PR12MB5080.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFPTHWtdpSmIfSdUQbPgjFGFmvcz9XVtDOVvJnC/g9B5syKqmLrC0FWKcRnBD8avJUnZNrLWkBvq/MRuhC5V2DhzlA6OQobehup5Bs9gyJ9ZJDVwmqOdcJXNmnRuQQ9315gqPWFe13QGXT2t1kz7ZJ53u65V28DKnVSLz9baMvzJnGBD++H4Of0rqiHRPnqlPJ17/SN2RfcYmMqiw0jdqts0+tnOQAdKlPIWylxsQiS8RvGSSrQFLAYXayyegXwp+uUbw67tpeP2+pY6NcXlH0/gOjoTXR9TDHDeJPx2ek8X6uPNnfsco1skc5gnqJcqlUCgihaJaWHYeB/Es0dAhzkhG8q1ufu7kvcnc1k7EYmYp/5/tFK9NT/M5SsQM/4hFzEftnAN8dt7P2VeZZ8jowoMSVjhzLh1GadQhW8LTLjqYCThfFBW01W8cuqoGBOSJ1j12gnsPpcRBYYNp66IuMjAgr/0PHWNoHcTDDQq3QlHN9Cy3RrlwruQTZ4dbiDfN7v01lHgabPrH1gDiJN2nesJgItwBoq5HiG9D84bXkOYZg6vxTKcIYJuYv59DVs0tSyt6PLonXCTeAotiblhulkWOd7ZpDmHNSkShP+N1h1PVI9eMpdgpl3NEk6dufMYat40CKWFXaUcX8buGpkLu3oduTgPszwRqwbmEfMyeiGtLFjaxmBWc5Km83y/CnTMsmFs9Kj2e+JGyjk4D3aJdCkecsIrOPFiciE2Wg016kCiXy8mIanqOlp/CNFGimZ3JVHXWOoygwI6ThcEn2fVgmjjA2Vmz+DB90ZQNuLHVIc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(54906003)(6916009)(6506007)(38070700005)(6486002)(508600001)(966005)(6512007)(64756008)(2906002)(91956017)(4326008)(8676002)(66946007)(66556008)(66446008)(66476007)(76116006)(122000001)(316002)(2616005)(38100700002)(53546011)(5660300002)(31686004)(31696002)(83380400001)(8936002)(86362001)(36756003)(71200400001)(45980500001)(43740500002)(10090945011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWtjb1dlSmJTcWxralMwOWpUbnJySkp4ZUF1aC9VNy9VOHpXY3E5cFRuQVM0?=
 =?utf-8?B?ayttd2hPSGRzT1FuMlJIRmR3Z0VoQWQxQU9IQUVCQXk5YnJ6QmtOUGQ1QzJZ?=
 =?utf-8?B?Nlp6aW9acDBlampCZURoOUoyZFJTNjlTaE16RTMyVzgwQlFISFR3UU9xZWk5?=
 =?utf-8?B?VTkyVXJWNjNBU0hhTVR5NW1iNHJESzZGUWpRU3NHbWdtQnYzMWNPN2wzb0dE?=
 =?utf-8?B?Z1A3Ry9LS3l6Y1BPMnIxNXBDTGVtQXJiQ2NUZi9KUEF4eHZjWnBMRzFTYXhp?=
 =?utf-8?B?T0R2SGhOR09ZOEpQQTdUa0ZIRVUyWGZYZzhaRHdhUUhJVDFzcno5N3lHQjJk?=
 =?utf-8?B?L3N2aWxITEI5VXN2MUtlQ24xbENYK3U3SVVVTWFnSzFFeXk0QUlzNkdXem9v?=
 =?utf-8?B?OWYxRTc3aG82SDdHMEVIQ1cwbDJnWnVDUThHY2pFR096aWZRWlVNQkhEcCtV?=
 =?utf-8?B?SkxTdWJTaXhxYzhVNk1vdzBVUnN3Qnl1WDNmaW9JS3pqZmVEZTVrY2gwWDFS?=
 =?utf-8?B?NzlObFJsQTlZbDNtN2c2cVRRZE83QXg0RDBhSEgxbGlkK1EvanZYQnBXK2RE?=
 =?utf-8?B?TmRoZVlEWTg4MW9JOVJqM2tZaCtVaWl1NzJKSUYxM0x1V3dFSFdDZlVHUDRL?=
 =?utf-8?B?RUpVSSt4MTI2L2F1eWQyQWF5ZU1RZ1B4UC9WcjJoek02UTcyNFVvSnloQ0pL?=
 =?utf-8?B?NDNNVmQ1cFo2a0ZMdVRrSVdmM2pCcjY3Uk9jdFR5OTZuVis5RTRUYTN1ckZq?=
 =?utf-8?B?blBqVHp4NTNncG15UWoxelNsK0I5dGtVK2FxaUd4eC9tOWlCbWZlTEZ6TlJH?=
 =?utf-8?B?dTFlSHRTSDRNTmw4WkJScmFxWjZNMDJTSGlhdFdlZDJ4U2dwMUFtY0x3RDRj?=
 =?utf-8?B?Rkdja1phVUhyU1VpU0ozQ3VpYktxRjJjcmZnYTJJK0w5elRUaVhlVmQ5eFdF?=
 =?utf-8?B?UFBTcDlFODRRN1I0L05pOUdXNnlkNmcwbUt0SG13RklqVmxsam9jSlNwcStq?=
 =?utf-8?B?Vll4OXYvcklLUVdoQ1d0SjF5RDdHeG05WUJRb3dsdXVmNDRqQmQ1VG5NQlcz?=
 =?utf-8?B?VmVwZElEZUtqbXJXN3VRekZFd090Qkx5VG9tSE15V0YzVDlhODJiZE0wcGhD?=
 =?utf-8?B?bDNlMkFZajRTU1NOdG5SNHJRSDloVlZCaGV3SUFMa2ZwMVZ1aGZCb0F2Lzd4?=
 =?utf-8?B?RjVTeEptb1RyTHB4b0YrY0hKb1BFbUpQbHgxS0JHMkVlU3F0Z0s3Q1NETzdY?=
 =?utf-8?B?MFFkdWw0enp5cUIvZjl0S2hHRmRmNlo4NnAwREZsWWUwMkNoWVhOR0RTQnYw?=
 =?utf-8?B?YVUyUjMrUFk1THQ0ZDI4akVoeEVGUG5pNHNTOGxZN3pjNm1mYjBWTU14UUtH?=
 =?utf-8?B?M0hnNEY5bVFWSGUra0VqL1FTMTdVRSs1QWw3K1U3dkxvSWtyZzlqaUNpS2ll?=
 =?utf-8?B?T3RzcXhBdFp4RVFwVWNVZjNwbzJ2QWpDSC9xSG1VaXJwS0pFVkxBSVZvV2FW?=
 =?utf-8?B?M0ZPejhHZVdQSEJKVDd5TFJEVUNoVjNYL0ZQRE1Xc1pvZkFwZG9DNjNmZ1Nu?=
 =?utf-8?B?cWE0bHZSa3BPSjRMS01QT2lDa21SQzNFb1A5bGduYmgwUzhqREJESkg3cUs1?=
 =?utf-8?B?emhrRndmMFB6YVFWTm9UMXI4U2ZvZGN1bHMxZ2ZBU3NPMUNpcGpNNTFHRkNo?=
 =?utf-8?B?WHZrTU9PV0UyeUxCUmcwRnAwMzRUSXEyWFlwejlqcEhlREp5cjh4eHM2OVNr?=
 =?utf-8?B?R2Q3SkVHSm81V0w3RFYrbG5LOEhHeGVQclRPU0tOVE5YTDhWUG83blJIQWxL?=
 =?utf-8?B?RTBiK1d6ZnJZY3JVU2h6NE9pMU1rbzdWTW9ORm4xblY0cXBrSlpkVnVoOFk5?=
 =?utf-8?B?Q29za0lSWGlCZ0RyRTV4K1ExbkZyQ0F1WGxpVEZ2dlBOdW5WSTRVRDJwVDcw?=
 =?utf-8?B?aCtxSjYwUE5uSGhLb08zTEdJb2xOdTRYKzFyaHBCUlVFTGRKRFhDT0pOdFA1?=
 =?utf-8?B?NFVNMmloWE53PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A697A91D9CF0043A5533FC5EE10762A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61130ee3-e231-443e-fd32-08da0800b84d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 10:27:21.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mPysXNZ5ELDHks9XAFMEK3ViF1KkCmrwsCrgm8/G1v6r2qqcRASFJscHL84QJoC+6LTTLMfAjRKSSI5ASMSLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8xNy8yMiAzOjIwIEFNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IEVyaWMsDQo+
IA0KPiBPbiAzLzE2LzIyIDc6MjYgUE0sIEVyaWMgV2hlZWxlciB3cm90ZToNCj4+IFtTb21lIHBl
b3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9t
IGxpbnV4LWJsb2NrQGxpc3RzLmV3aGVlbGVyLm5ldC4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0
YW50IGF0IGh0dHA6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uLl0NCj4+
DQo+PiBIaSBNaW5nLA0KPj4NCj4+IEkgd2FzIHN0dWR5aW5nIHRoZSBsb29wLmMgRElPICYgQUlP
IGNoYW5nZXMgeW91IG1hZGUgYmFjayBpbiAyMDE1IHRoYXQNCj4+IGluY3JlYXNlZCBsb29wIHBl
cmZvcm1hbmNlIGFuZCByZWR1Y2VkIHRoZSBtZW1vcnkgZm9vdHByaW50DQo+PiAoYmMwN2MxMGEz
NjAzYTVhYjNlZjAxYmE0MmIzZDQxZjlhYzYzZDFiNikuDQo+Pg0KPj4gSSBoYXZlIGEgZmV3IHF1
ZXN0aW9ucyBpZiB5b3UgYXJlIGFibGUgdG8gY29tbWVudCwgaGVyZSBpcyBhIHF1aWNrDQo+PiBz
dW1tYXJ5Og0KPj4NCj4+IFRoZSBkaXJlY3QgSU8gcGF0aCBzdGFydHMgYnkgcXVldWluZyB0aGUg
d29yazoNCj4+DQo+PiAgICAgLnF1ZXVlX3JxICAgICAgID0gbG9vcF9xdWV1ZV9ycToNCj4+DQo+
PiAgICAgICAgICAgLT4gbG9vcF9xdWV1ZV93b3JrKGxvLCBjbWQpOw0KPj4gICAgICAgICAgIC0+
IElOSVRfV09SSygmd29ya2VyLT53b3JrLCBsb29wX3dvcmtmbik7DQo+PiAgICAgICAgICAgICAg
ICAgICAuLi4gcXVldWVfd29yayhsby0+d29ya3F1ZXVlLCB3b3JrKTsNCj4+DQo+PiBUaGVuIGZy
b20gd2l0aGluIHRoZSB3b3JrcXVldWU6DQo+Pg0KPj4gICAgICAgICAgIC0+IGxvb3Bfd29ya2Zu
KCkNCj4+ICAgICAgICAgICAtPiBsb29wX3Byb2Nlc3Nfd29yayh3b3JrZXIsICZ3b3JrZXItPmNt
ZF9saXN0LCB3b3JrZXItPmxvKTsNCj4+ICAgICAgICAgICAtPiBsb29wX2hhbmRsZV9jbWQoY21k
KTsNCj4+ICAgICAgICAgICAtPiBkb19yZXFfZmlsZWJhY2tlZChsbywgYmxrX21xX3JxX2Zyb21f
cGR1KGNtZCkgKTsNCj4+ICAgICAgICAgICAtPiBsb19yd19haW8obG8sIGNtZCwgcG9zLCBSRUFE
KSAvLyAob3IgV1JJVEUpDQo+Pg0KPj4gICBGcm9tIGhlcmUgdGhlIGtpb2NiIGlzIHNldHVwIGFu
ZCB0aGlzIGlzIHRoZSA1LjE3LXJjOCBjb2RlIGF0IHRoZQ0KPj4gYm90dG9tIG9mIGxvX3J3X2Fp
bygpIHdoZW4gaXQgc2V0cyB1cCB0aGUgZGlzcGF0Y2ggdG8gdGhlIGZpbGVzeXN0ZW06DQo+Pg0K
Pj4gICAgICAgICAgIGNtZC0+aW9jYi5raV9wb3MgPSBwb3M7DQo+PiAgICAgICAgICAgY21kLT5p
b2NiLmtpX2ZpbHAgPSBmaWxlOw0KPj4gICAgICAgICAgIGNtZC0+aW9jYi5raV9jb21wbGV0ZSA9
IGxvX3J3X2Fpb19jb21wbGV0ZTsNCj4+ICAgICAgICAgICBjbWQtPmlvY2Iua2lfZmxhZ3MgPSBJ
T0NCX0RJUkVDVDsNCj4+ICAgICAgICAgICBjbWQtPmlvY2Iua2lfaW9wcmlvID0gSU9QUklPX1BS
SU9fVkFMVUUoSU9QUklPX0NMQVNTX05PTkUsIDApOw0KPj4NCj4+ICAgICAgICAgICBpZiAocncg
PT0gV1JJVEUpDQo+PiAgICAgICAgICAgICAgICAgICByZXQgPSBjYWxsX3dyaXRlX2l0ZXIoZmls
ZSwgJmNtZC0+aW9jYiwgJml0ZXIpOw0KPj4gICAgICAgICAgIGVsc2UNCj4+ICAgICAgICAgICAg
ICAgICAgIHJldCA9IGNhbGxfcmVhZF9pdGVyKGZpbGUsICZjbWQtPmlvY2IsICZpdGVyKTsNCj4+
DQo+PiAgICAgICAgICAgbG9fcndfYWlvX2RvX2NvbXBsZXRpb24oY21kKTsNCj4+DQo+PiAgICAg
ICAgICAgaWYgKHJldCAhPSAtRUlPQ0JRVUVVRUQpDQo+PiAgICAgICAgICAgICAgICAgICBsb19y
d19haW9fY29tcGxldGUoJmNtZC0+aW9jYiwgcmV0KTsNCj4+DQo+Pg0KPj4gQWZ0ZXIgaGF2aW5n
IGNhbGxlZCBgY2FsbF9yZWFkX2l0ZXJgIGl0IGlzIGluIHRoZSBmaWxlc3lzdGVtJ3MNCj4+IGhh
bmRsZXIuDQo+Pg0KPj4gU2luY2Uga2lfY29tcGxldGUgaXMgZGVmaW5lZCwgZG9lcyB0aGF0IG1l
YW4gdGhlIGZpbGVzeXN0ZW0gd2lsbCBfYWx3YXlzXw0KPj4gdGFrZSB0aGVzZSBpbiBhbmQgYWx3
YXlzIHF1ZXVlIHRoZXNlIGludGVybmFsbHkgYW5kIHJldHVybiAtRUlPQ0JRVUVVRUQNCj4+IGZy
b20gY2FsbF9yZWFkX2l0ZXIoKT8gIEFub3RoZXIgd2F5IHRvIGFzazogaWYga2lfY29tcGxldGUh
PU5VTEwsIGNhbiBhDQo+PiBmaWxlc3lzdGVtIGV2ZXIgYmVoYXZlIHN5bmNocm9ub3VzbHk/ICAo
SXMgdGhlcmUgZG9jdW1lbnRhdGlvbiBhYm91dCB0aGlzDQo+PiBzb21ld2hlcmU/ICBJIGNvdWxk
bid0IGZpbmQgYW55dGhpbmcgZGVmaW5pdGl2ZS4pDQo+Pg0KPiANCj4gYSBub24tbnVsbCBraV9j
b21wbGV0ZSBhc2tzIGZvciBhc3luYyBJL08gYW5kIHRoYXQgaXMgd2hhdCB3ZSBuZWVkIHRvDQo+
IGdldCB0aGUgaGlnaGVyIHBlcmZvcm1hbmNlLg0KPiANCj4+DQo+PiBBYm91dCB0aGUgY2xlYW51
cCBhZnRlciBkaXNwYXRjaCBhdCB0aGUgYm90dG9tIG9mIGxvX3J3X2FpbygpIGZyb20gdGhpcw0K
Pj4gY29kZSAoYWxzbyBzaG93biBhYm92ZSk6DQo+Pg0KPj4gICAgICAgICAgIGxvX3J3X2Fpb19k
b19jb21wbGV0aW9uKGNtZCk7DQo+Pg0KPj4gICAgICAgICAgIGlmIChyZXQgIT0gLUVJT0NCUVVF
VUVEKQ0KPj4gICAgICAgICAgICAgICAgICAgbG9fcndfYWlvX2NvbXBsZXRlKCZjbWQtPmlvY2Is
IHJldCk7DQo+Pg0KPj4gKiBJdCBhcHBlYXJzIHRoYXQgbG9fcndfYWlvX2RvX2NvbXBsZXRpb24o
KSB3aWxsIGBrZnJlZShjbWQtPmJ2ZWMpYC4gIElmDQo+PiAgICAgdGhlIGZpbGVzeXN0ZW0gcXVl
dWVkIHRoZSBjbWQtPmlvY2IgZm9yIGludGVybmFsIHVzZSwgd291bGQgaXQgaGF2ZSBtYWRlDQo+
PiAgICAgYSBjb3B5IG9mIGNtZC0+YnZlYyBzbyB0aGF0IHRoaXMgaXMgc2FmZT8NCj4+DQo+PiAq
IElmIHJldCAhPSAtRUlPQ0JRVUVVRUQsIHRoZW4gbG9fcndfYWlvX2NvbXBsZXRlKCkgaXMgY2Fs
bGVkIHdoaWNoIGNhbGxzDQo+PiAgICAgbG9fcndfYWlvX2RvX2NvbXBsZXRpb24oKSBhIHNlY29u
ZCB0aW1lLiAgTm93IGxvX3J3X2Fpb19kb19jb21wbGV0aW9uDQo+PiAgICAgZG9lcyBkbyB0aGlz
IHJlZiBjaGVjaywgc28gaXQgX2lzXyBzYWZlOg0KPj4NCj4+ICAgICAgICAgICBpZiAoIWF0b21p
Y19kZWNfYW5kX3Rlc3QoJmNtZC0+cmVmKSkNCj4+ICAgICAgICAgICAgICAgICAgIHJldHVybjsN
Cj4+DQo+PiBGb3IgbXkgb3duIHVuZGVyc3RhbmRpbmcsIGlzIHRoaXMgZXF1aXZhbGVudD8NCj4+
DQo+PiAtICAgICAgIGxvX3J3X2Fpb19kb19jb21wbGV0aW9uKGNtZCk7DQo+Pg0KPj4gICAgICAg
ICAgIGlmIChyZXQgIT0gLUVJT0NCUVVFVUVEKQ0KPj4gICAgICAgICAgICAgICAgICAgbG9fcndf
YWlvX2NvbXBsZXRlKCZjbWQtPmlvY2IsIHJldCk7DQo+PiArICAgICAgIGVsc2UNCj4+ICsgICAg
ICAgICAgICAgICBsb19yd19haW9fZG9fY29tcGxldGlvbihjbWQpOw0KPj4NCj4+DQo+Pg0KPj4N
Cj4gDQo+IEkgdGhpbmsgdGhlIHB1cnBvc2Ugb2YgcmVmY291bnQgaXMgdG8gbWFrZSBzdXJlIHdl
IGZyZWUgdGhlIHJlcXVlc3QgaW4NCj4gbG9fcndfYWlvX2RvX2NvbXBsZXRpb24oKSB3aG9ldmVy
IGZpbmlzaGVzIGxhc3QgZWl0aGVyIHN1Ym1pc3Npb24gdGhyZWFkDQo+IG9yIGZzIGNvbXBsZXRp
b24gY3R4IGNhbGxpbmcga2lfY29tcGxldGUoKSAtPiBsb19yd19haW9fY29tcGxldGUoKS4NCj4g
DQoNCndoYXQgSSBhbHNvIG1lYW50IGhlcmUgaXMgdGhhdCBpZiBmcyBjb21wbGV0aW9uIGhhcHBl
bnMgYmVmb3JlIHdlIGV4aXQNCnRoZSBsb19yd19haW8oKSB0aGVuIHdlIHNob3VsZCBub3QgcHJv
Y2VlZCB3aXRoIGtmcmVlKGNtZC0+YnZlYykNCmJ1dCBvbmx5IGRlY3JlbWVudCB0aGUgcmVmLWNv
dW50IGFuZCB3YWl0IGZvciBsb19yd19haW8oKSB0byBkZWNyZW1lbnQgDQp0aGUgcmVmLWNvdW50
IGJ5IG9uZSBtb3JlIHRpbWUgdG8ga2ZyZWUoY21kLT5idmVjKSBiZWZvcmUgZXhpdC4NCg0KLWNr
DQoNCg==
