Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD3EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 20:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjG0UxI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 16:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjG0UxA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 16:53:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93714F5
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 13:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqeYzYaI1Tu3jP2aowf0GTgxYZPZHbovKL79hlskOAhg1k3Iz1veVB3OCDYVKiDDvJeakN48M8T9GuP20m8OAP65YUlmOFpIWtbZ2cQBl6pw4ICpjSGHm7oiJx0JS8Xwbe1V1lFy/XFxBbI+/H4VyZKt+F7NgSGCT/Xyhm7umDJN1DvvUNqI210et7t0jmXdT2s66FXhD4DzSinQkRv0ANlqmPqSQQMrnXZk0gVl45yGztDEHy/r9meeZ0U6v8Rv7oekv81BLvRnkJgxP6vOSBLpUci4syUnjA79uFnqHLvXggvbFdSjXCw0UoqiUMp/V9MpMiAtWYi1m0JVmod7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ChmZvZq+dstefvJBlDGd0nwC/nQo0+2APTnPksBZyI=;
 b=EkShDas2BcXPZnw3A2WxF92mkVOfqiFWZQ9zGvm6xHyoQi+mvbk6ZCvn7bxniUF9jewaM3tW6BluzmmRPrt+kKscZJNgDKNzWfl8p4TVQmJbKQYN75fxVhuT4NCCnpXaO73kibqPspqQV78eVOaP2t90ld/DN9XL/rCBvVtFxtMQum2toJjiTAXI4MxMicm6LBxWPcXsjqd3lOGQQYEUhj7xlN2IESJIDt7mpSU6EIeiMLiLp+vvIAEoey4jte5UfQlwyj0WZo3h1YjzGrpYOzmJe+vmeD+9lvEj/60IPrvPW+jkOtZaoJkizGJ/6ZKehBrt+1iRgTKO3wpP9K/wJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ChmZvZq+dstefvJBlDGd0nwC/nQo0+2APTnPksBZyI=;
 b=BCTjvawKtQKTvmi9nAxC1I2VQ0FHeTeDbgAlyvD4VmfzN/Got+/NPkwXEYQKDyHXCHoBxVWdlFGn8hSGCl/qWQfV4nz/mM3yiTQlCBtyCgFOWjMmQdYCl2QC/Df4m0+TWkgkzf1Iy6CTFSuv42mM7gWVv3veACJB69BXh/lqovIasiK/pVY3x4H9ZX0MZ2WlCZjvQIoOnZEM3nS5F4W4giF0lClTTx9TZ4hhVkFM3xj5AQhh254DMzrLGyqEBYj5YGIWrEEMFyqyQBZ6KfpIxL+PeYO9mkX9+LGIxkePsAE6OrGw2Ve33e/0pH3hPR1LS6WCt7wsQ8nE1d1C++PypA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 20:52:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 20:52:56 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 1/7] block: Introduce the flag
 QUEUE_FLAG_NO_ZONE_WRITE_LOCK
Thread-Topic: [PATCH v4 1/7] block: Introduce the flag
 QUEUE_FLAG_NO_ZONE_WRITE_LOCK
Thread-Index: AQHZv/hKWygJSaeDekuQfFIP2Yehg6/MyewAgAFFlICAAAkxgA==
Date:   Thu, 27 Jul 2023 20:52:56 +0000
Message-ID: <00c643bf-3bb6-44ed-4d8a-29e015961703@nvidia.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-2-bvanassche@acm.org>
 <65bb97ce-f0e4-8174-0d27-64a8543d4bbb@nvidia.com>
 <d3193436-4e16-693d-f69a-f2d21cac11f3@acm.org>
In-Reply-To: <d3193436-4e16-693d-f69a-f2d21cac11f3@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB5625:EE_
x-ms-office365-filtering-correlation-id: c7874776-8283-4f1d-2178-08db8ee37463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6+v7QF5T80EdQ7TQChczavkAkHo2Q97JnjF7P500c0oqcfuwmipFfHyP0pJFR9w2+TAIqSc8HGVTLJadEQLB2Wlfmfofa6qH9upL+50W5DcFkdPilglGbQFc4K+YYhd3SLv3N3HTDly/IHOInwiJK9qcfBiN6WRgVBrSuiKqCYxOlhp6FYRKHEPszuzj/aylF1UzvJCmEieK1fm4nAuKCcDEVuKi9vbmOYTmZKNHPZoi+rs4mdLwojU7qjdhyVLlmRWzIybMPzKPQUsdAzCWOgHpyp29Rfaui1lk5raMKbKiyF1ZPKEyUsxr41cs5DhH9kqj+n3sjEO25QgyU1Zw3eIQNHNXxziASojBDG9oqyNmI2bPU6AenD25Xid2Sq3nP9h0MgFR3wDU2ezR9yE7GhWR1Q9QNQa4o/XlQ5IJb84lGO8WNyCpo+/df8QJs9zsnDrvF/bxybr0mpz2V1Z3suY2gkCFgODUyMKst8a0YMW3rkDCxuaCGPFnTt1tTrxeBOv2+GPuc/aG9S5EXkEdKBFrfeANiDyis3TdNAS5TAoaHaYAO53MSGhbgL23GxULqTNilI+UOyvvKKQVGav2oqwbyO6Iu6gquekkQLP8KdbrXr4ZpUFCl2Vh6+uvv6Yxh+wl7lEQ20P1lIyV54W0RQT/hLdCOM3BM4GaTQKyen9MJx4bM7Gxieq1ZsF1/u6a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(31686004)(8676002)(5660300002)(83380400001)(2616005)(186003)(6506007)(53546011)(86362001)(8936002)(31696002)(71200400001)(4326008)(6916009)(316002)(6486002)(38070700005)(64756008)(41300700001)(66556008)(66446008)(66476007)(66946007)(6512007)(478600001)(122000001)(76116006)(4744005)(91956017)(54906003)(38100700002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEV3L0I5YXBkV3RTY1FDUU9SWThBZ1RJcURWWkpEaG03WmRycm5tdCtXbys0?=
 =?utf-8?B?QTg0TXFnQmcvSUF0OW5oeGk3ZUV4TllsdG53ODdrWm1TVE5LYWZHb0VUWnFH?=
 =?utf-8?B?bnJIdEs0UTlhdDhmMXdJUTZGYks2aEkweThMZTNURlk2ekZmT05pdVd2ak5J?=
 =?utf-8?B?RWUxZVNlTk1kZWFMWEoxblp4RnhOdWY0MXhEelAwQmNjSGx5K0ZZWUVqNTRK?=
 =?utf-8?B?UUNwVklaeHRPQVJEaVZCakdqZ1JwZzY3SWhuc2NxeEY3SGd6YnB5NHdnMUZO?=
 =?utf-8?B?K1I0czVtWnFlaHYxVnNpR1pVd3Fmdld3dy8yWmVVbE5YMkRwajNjcDNoUVZC?=
 =?utf-8?B?TXdXNjc0eTNLbTU4bXN2ajl2YVF6RTUzRkJRc3hPbXBzS1FGTmNpcGVNV2RN?=
 =?utf-8?B?OWlpc0NSVVZBM3VYV1Fsak9lTGM2ZHM2cGlPT1VuVmc5YzZ6cUphWmJtWUZu?=
 =?utf-8?B?ekdUQS9HZEdnR0hveWlieGJVVzNHaXIxa0YzMUNxRmsyNjJMWGdrTThFTXNs?=
 =?utf-8?B?MkNuNmdTUTlKd2lQN2JJM0dSVFFSek9MQ1IxaDBJN1ZzVW53N3V0RXRBb2pM?=
 =?utf-8?B?OVhJU1IzYyt2QWxJUHNwYWE1YlM5UlllbmdQa0F0YWZRVVpTQnU0UFNnNVg0?=
 =?utf-8?B?MmNFR1pKYWdtNzlPd3dCR0x0VnBKSEZqZlVLK3FIWHVGekVBY0N3eFdFNE5O?=
 =?utf-8?B?SkNWdnRVL3V5d25JVGQ5WFh4VEEvcEk4UE5vV2I4VnA1R3ZSRUZjM2tiVGJ2?=
 =?utf-8?B?b0VZVHdDOEQ3WDBjelJFSzdpdEU0OEsyNlNuSTQzeFJoVktBTUlBdlpsWUZV?=
 =?utf-8?B?L2R0bmFPUUNKRVdDN1JqNW5wOWdZZUNTTWdmeStvSSs2L0VBNmxkbE1KNVZo?=
 =?utf-8?B?dzMzZFhIaERVaitjb2pYL2QzSU5hNjVscmJNbnJUYXJDYjV1RWczZVlGOEhS?=
 =?utf-8?B?dXZ5WVYxWXJlT253UWUzWENWbHJ0QnBOUTVNMzFqSG1RSG9ieGxZT3pvaU5q?=
 =?utf-8?B?TG84aW5acm9tZElkYzdXU05TU1o0bUFXTU1uOENKTnFZb2hiQkdXdWk3eGdF?=
 =?utf-8?B?L2N1alovdnVQS3pPVU1TWU1tVnBBMUZBT0xtb3lldVpPaDZZZThsUUtIMmJo?=
 =?utf-8?B?WWRZTTRNQ3dXK3pjS2Q2L1cycXFvc3h0L3gvUnVhVzZWL3E5VnQwQ3FGSGFl?=
 =?utf-8?B?Z0pRbEVPaUxublFQWVpPb01MZkFDYU41amdQTW91NC9JaDN5RE5Oc3lMOUFC?=
 =?utf-8?B?c1U4RlI4REhyV282Q3kwRWRQTWxTWWtZUDhyTXJ2V3U2S0E0VmxaaGlRK04x?=
 =?utf-8?B?VEUwanYvUHFmUFFocGMyR0pvblJLbTBrR1N1VVFKS3JETjhDYVJDY3Rva0p5?=
 =?utf-8?B?WEg1anM0M2tJM0Jrc1NnSXpmelNidkdFWURkYTFZZDRpRG5Ka05sM25vL0hO?=
 =?utf-8?B?bmU0aWxDdW9YSnN3NjJlcENwYWdrcUZGakxyMmpqemVLMkJWeFRXVUNCbGZM?=
 =?utf-8?B?RmNtdWZ5WFRxMnA1aHhtYnhNbG1kU0VrT1Q4bDU5N3VIUXlWQ2MzSFZkaHFK?=
 =?utf-8?B?Y21tNVp0U1JmU3AyZG5BUlp0OVFqWnZJRXFUU0tiWXczcVg2dlhVSThxQmdj?=
 =?utf-8?B?amUraWExVUpBQ2YwL1BZVzB6WlZuWE5vb254MDRpT3E3N1ozbHZGaXdZd3Rr?=
 =?utf-8?B?b2U2clJmMGl1MVZUNFNqMXlYaVRhbUwxOVROblVKMmlFdXRza2pEV0xNc1o5?=
 =?utf-8?B?UWtWVG9ZRHJsN2R5MU96TGtEcVZBVFhLSVZJeWlPTjJyOCtmOU5sWjNwdXYy?=
 =?utf-8?B?TisrYS9lZHFoT2hKK01HWVRyUU1wUkRuZXZlMjF5anByOE5XamJXMVFTU2J5?=
 =?utf-8?B?VFQ2TnhGRDYvQXhjdElia0o4cmcvd1A0Z0ZJMU5KZzIrRmFlU091a0o3Zmwz?=
 =?utf-8?B?RjFaVDJIL3dJdkdrRDFLcjFuckt5cFhhTU1Ed0U0WlE3Szg2TzBOTzVNOW5C?=
 =?utf-8?B?b3NkbzFqemsxZFcwdE82Tkk3MThDSUFtTWZBK1JHR2lISzR4VlA5Ky92RGdQ?=
 =?utf-8?B?bldGUlhUeXk2T254ZzVQc1hWc3JKS2Jnam5GckdYcWdVRWlCUFd2YlZ2Mit1?=
 =?utf-8?B?QXNLTVA0VTVZcCtEaDlrUmMvUjhOZGp2Nm5KbXo5UEVFWk9QN0tWZm9pTlVP?=
 =?utf-8?Q?uSgdFgwEmd35Ss31f9hrmzilWp4fKqZ03JqybSWJiqF9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <709B429DB1286648B51A57AAA8BBC53B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7874776-8283-4f1d-2178-08db8ee37463
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 20:52:56.4261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lktIEdZeRWtwPORhpsCnorxXnaia4gkHTEfjWbWKpp+r9IVlmEVR94+GDKsl1apWiGLGePSgz8AVjwVPNJJUJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNy8yNy8yMDIzIDE6MjAgUE0sIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gNy8yNi8y
MyAxNzo1NCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gT24gNy8yNi8yMDIzIDEyOjM0
IFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+Pj4gKy8qDQo+Pj4gKyAqIERvIG5vdCB1c2Ug
dGhlIHpvbmUgd3JpdGUgbG9jayBmb3Igc2VxdWVudGlhbCB3cml0ZXMgZm9yIA0KPj4+IHNlcXVl
bnRpYWwgd3JpdGUNCj4+PiArICogcmVxdWlyZWQgem9uZXMuDQo+Pj4gKyAqLw0KPj4NCj4+IElu
IGZpcnN0IGdvIEkgZ290IGxpdHRsZSBjb25mdXNlZCB3aXRoIGFib3ZlIGNvbW1lbnQsIGhvdyBh
Ym91dCA6LQ0KPj4NCj4+IC8qDQo+PiDCoMKgICogV2hlbiBpc3N1aW5nIHNlcXVlbnRpYWwgd3Jp
dGVzIG9uIHpvbmUgdHlwZQ0KPj4gwqDCoCAqIEJMS19aT05FX1RZUEVfU0VRV1JJVEVfUkVRLCBk
b24ndCB1c2Ugem9uZSB3cml0ZSBsb2NraW5nLg0KPj4gwqDCoCAqLw0KPj4NCj4+IEl0IG1ha2Vz
IGl0IGVhc2llciB0byBzZWFyY2ggaW4gY29kZSB3aXRoIEJMS19aT05FX1RZUEVfU0VRV1JJVEVf
UkVRDQo+PiBidXQgaWYgZXZlcnlvbmUgZWxzZSBpcyBva2F5IHdpdGggb3JpZ2luYWwgY29tbWVu
dCBvciBpZiBpdCBpcyBub3QNCj4+IGNvcnJlY3Qgc3VnZ2VzdGlvbiBmZWVsIGZyZWUgdG8gaWdu
b3JlIG15IHN1Z2dlc3Rpb24gLi4uDQo+IA0KPiBIb3cgYWJvdXQgdGhpcyBjb21tZW50Pw0KPiAN
Cj4gLyoNCj4gIMKgKiBEbyBub3Qgc2VyaWFsaXplIHNlcXVlbnRpYWwgd3JpdGVzIHNlbnQgdG8g
YSBzZXF1ZW50aWFsIHdyaXRlDQo+ICDCoCogcmVxdWlyZWQgem9uZSAoQkxLX1pPTkVfVFlQRV9T
RVFXUklURV9SRVEpLg0KPiAgwqAqLw0KPiANCj4gVGhhbmtzLA0KPiANCj4gQmFydC4NCj4gDQoN
CndvcmtzIGZvciBtZSAuLg0KDQotY2sNCg0KDQo=
