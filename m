Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E62CC05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 02:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjBBCNm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 21:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjBBCNm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 21:13:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F8E15C82
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 18:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlWtA+nZtDpDU7fx6xGhHObO/ELol0zn5wkxoRmKT+f7v69W8sz+WyLIXVkIKq+FyvKAzgFJwfe/LfAVH/HenWSO1YrV2qUIEwds5mFa+8O/oNEtVlCHGlkle+JHsfBKj+ZxHEbN4TufcbJ9H6qSyHJMhHOle5aiG+U3uoLomli3M8fCW2PtzBHDyL1dgJNUN+NMinq0+Ukptv/IW5Ik5Rl5bKUQmOWP6mIpR+wGcrush9lA9r1exfiBXNfrtg46OHGXkMnYtF1m6X9DJQGzWzgoo2RUW5A7Ptpk+ajvTJswepgzKWaw7K9em+SVLYv3FBp9GjoLAYgl/dlDBSauHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heg49l8gsoS+3GmUZ9wJyv31dy0p13ikpS8iJ34yrQU=;
 b=EOXLswxLHcLe76Z5nSzhz/aCIaQo39UyItSDKKDjcIIvrPraZ7n7+svUQiVRA+QRiErDAaAitl+ydD8lXEsVux2ER3zEwfr+RiEkTTFXwfH4/ZRIDyC0DNlT0RVcWIUJxMhrbgpvHzJziTAU7Pwv74bBEumrEqL3TmlRzChnECUOvuee0PLKDD4jNoHdNRRKK2Fa+aY0/J7ZRLAVNKv006cFuu/uEaw0MKlUeXur08UFBoxWSAGfcwDZZoMaOyQKWaV+fO4Vl2EJv+9203eM7J6v/U7c/RDbCT3p1kDogl/s39RxbnyVeaubLxbAsNaEZJtCPp772k+IsjnVbwuXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heg49l8gsoS+3GmUZ9wJyv31dy0p13ikpS8iJ34yrQU=;
 b=ey/XbGGNPSbeJCiKzX3Kz96V+zTQeJioZ7/wWcHyiViLwCDdvBnsUPxm6/3ABtks8P4xUQ/rPZ+RLjczL5wl9Vr9dXNMjfscfDoJcBiP8ZOAdfgT4M7HREHTA7kJY9BWqjekHmMy5O2x00blMTmFTnGRSWwpH6IooKMjkpGYpKJ30Wq5fRy+7trYPgWQ90yFek2D9OdHBtnKzd2ygzOZlHqcSWItaSWD9R3MZewSjOJXbAPDzGrKUQuUj1h4/W/Z6hcWSiXS/0X7GEfS3HoVdSMJqZZiNpUc/9Poh899DcU6gAg+Andgsja9GNNfktHQJUghMX1NL8usBW6DONqxGg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 02:13:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 02:13:38 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [LSF/MM/BFP ATTEND][LSF/MM/BFP TOPIC] BoF: NVMe VFIO Live Migration
Thread-Topic: [LSF/MM/BFP ATTEND][LSF/MM/BFP TOPIC] BoF: NVMe VFIO Live
 Migration
Thread-Index: AQHZNqv2GHxYWxAbHEutNuOTgv/84g==
Date:   Thu, 2 Feb 2023 02:13:38 +0000
Message-ID: <a0ef2710-43e5-b856-f9ce-e6f1ba99df51@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN0PR12MB6197:EE_
x-ms-office365-filtering-correlation-id: 217406aa-edec-4426-3146-08db04c318fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBI6T1EehJxJCu1ZLMHjVS0W17hW7+XLiQkHJZqqSlthnV5Vg6d18aL2hcPxj4OeFQnlsBn30DyEYrvrvcOnUT41XYqW0GHHKmpC5gkohTxM4CqGMAUr8aMt9iuc+Da98Ih8YVm7IxnDJvHAviNbVUyGkaq6Ljg9f2vS768xupXRh4p3ZKIL2nZTROYj+wfC+wwJb8NIXgpEpWZZkOE3peNRjM/EduNR2R6nlYOCZsbSHAZ2ErAIS1O/dV3i7MkBlPY06nJMEFRbiBKaku137PNNzpXSfLNVeShU34S/pBpnWVNA20+lUmlhTXLuLiPONaI1XvnC/PFta6lw9gU6wDXoRD+FspdFybRagfugOZtZo9X2FgEw66TP5EjpvX6DK0IhOwfhG5xRDw0moDtXUs3kZgGnlNeP55oaRFTE7GjdFZ4i3N0ncMpQ7d91hQvdI4sJwKJ+utp0DKTWNVKfUCqUTo1dyya1SI/qOVm1P4l0dXyRZwrfZiP7ntOISKADVe5IMI+mOYYuYhaVA+IuokbOTDwwXqgl/+rMQvR1L1bBeT+nWoCoCCGOD0TuiHw+Y20ZLN7wQ79wTnLhp1HxPTUek3rrZtbQUuIBhUfxXBv0zWqlzIN4tBGMPiO7A2jQt4pHbddu5R1HiOaDTFuDYGBVTNpbXBFMxQCqIdNDXPOoHTjX+pc9HL+WJZRjlelTRvmzBeX3NWJlmj4XdxkGiUFoXmYgqRm0eTno27HMIrgWkjy7Sm6fusSUn2TYcA8PMFzOLbJo3ucH4HPRVHW1+iBJlYJ8YIMvOpYYx5rndhaU00HkjRNo4dZuu4DLEei+xwIKD26wjap9pIFHjhwxWpxBaR3zjWes9kK8TfVP218=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(6486002)(966005)(478600001)(66556008)(2906002)(86362001)(76116006)(4326008)(66946007)(91956017)(6512007)(71200400001)(186003)(6506007)(31696002)(5660300002)(110136005)(316002)(31686004)(66446008)(8936002)(38100700002)(122000001)(66476007)(64756008)(54906003)(41300700001)(2616005)(36756003)(38070700005)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlFvdlU4OUpPdlJ5V2E4OC8xRXBGK0VSTEQrT215cDg1M1c4RVJ0bHFEeldo?=
 =?utf-8?B?OEVrdnNTMUNVd0hKNVQ1Nm1lV0ZhZmovWTNnZVExcmZIWlRoSm9Sb3hPSkZa?=
 =?utf-8?B?cGtCejN3eEF4R295Q1p1VFN3eVg0djVWWHpjU0lFTDhxMFNxZ0dXeEJQS1I5?=
 =?utf-8?B?Lys3Y3FGeDBVQU5MMVNmd0lPYmlJT3R0UVRJeTZINHpqcVFib0xpdGxQajJG?=
 =?utf-8?B?d3pJelJpTUxGR1BUMGZTdCtKNERVQTc3Y2NjSU9Ea1JOQVRLN3hFek9RUkFL?=
 =?utf-8?B?ZDBaOG50bDF2NzM4aFVLbnpIZzExb0kyREtSY29kbFdvbDQ3NUFESW1IRWN0?=
 =?utf-8?B?T3FMaUc1QkZIQWlPZlp3SzZaNmdIR1hGc1RudEpDb2pJNDI2ck1oaEd1YkhI?=
 =?utf-8?B?Ti9WdzJVYUsxcDNOVXNwR3R3SGRFUTd1VnVQT0JVQk1UMnFYS1ZiWGZWelJs?=
 =?utf-8?B?WGZRcEl6czhpQUNPbWJSOExuWXVGV0FLelVQb2NvdnR1alRkem8zZmQ3Ty80?=
 =?utf-8?B?U2dLSkU1OUNvKzFnU0FSSnl1Y0MxRW5UMGlnbGdKenQzTXpMRjJWVUNhMVhN?=
 =?utf-8?B?QmRHejlSTC9jeWUySjZabVk3Yk14UlEzbVBuVVNENXFMWU1ZbFVKeU5Pczl6?=
 =?utf-8?B?bGxHM0VFcnRlMmV3N0I2K2FsZi8vM1B4VnN1dXZqV3Ivc1BNeHdsYjhxdWRO?=
 =?utf-8?B?TGoyQnJmdGRsM3k4MVFDWDJ5VDdOelpFZHhmeSt6ZmhuaFc5UUpOcjdTZC9t?=
 =?utf-8?B?NjhBQlBIZkRHSmhSZVFZNlpORlY2K1JaZTc3dzRlZXFNR2tMaVN5WkJNUThH?=
 =?utf-8?B?b2JHalFGK011MEtieEkxQmJFWlhnRU9EREQzc0UxTVU1RkcxRUtFbm5HaXI1?=
 =?utf-8?B?R2ZCbk0yK2cxblpGMkJ0elJzdXlEbXZtUkUvaXJTYm5rdm1PcWlUcEp0NnZZ?=
 =?utf-8?B?eEpJaW5QQk9ROTYxRHNhUVJ0QjUwWjV5WU5GRnh5MEtnaXNEa1l0eXUvYVNa?=
 =?utf-8?B?R0gySzR6MFRoaVVNamV2bHdiVlhOZFh2ZHFWTzNYYWhXNXQ3RnlLb2puNGdR?=
 =?utf-8?B?NlBvRHZzY3d0RTJrUFlGWlV5aHJscHh4a1E4Rlo1MEljNEdINm91VUlLbFIz?=
 =?utf-8?B?aTlrdERBZFhzalI1QWsxY3lETklpSitBelFBV2Q4MGZ6Y0tXQTRURTQ2dmZV?=
 =?utf-8?B?MnBIc2tGV0YrNUhqQTJIZ1F3NnV1R3RidkNQcWdWTFRxeTkvaUVya0xhL0dl?=
 =?utf-8?B?SjcrOHk0cExxd2lNYUJuWE5WNlBHU00valVKaXhWTmdBTms1SlBaU3hCZ3d1?=
 =?utf-8?B?UXpWdEVkbzc4amdBc1YwTjN5RnZlL0tZamx6dWdXbUJmTks4bkdUSkNtb0Ra?=
 =?utf-8?B?V0hYd0F5SzN0cWtzVjl2OVZGNkRRTFVkNXRYUi9IbWdhRW5XY2s2OTcwZDBm?=
 =?utf-8?B?eTkxcnNiWjc0NlJwaHlNWkhtZkVCMUY2b09TR3BxUW55a0N5OHJPUTlxc3NJ?=
 =?utf-8?B?NUY2YytYOEU4U0kvZWN5NVJObWZmaWorZ0NPa1NUQnlhWU5XTzZCWnA1Z2M4?=
 =?utf-8?B?WHNZelNpOGMveU85dU9JMWlnUEduVHRnWWF2ZGFNN0VBbEd0bjV3MDlkOWNa?=
 =?utf-8?B?YnFnVEpTN3V1aVdTWXBXc0lTdkJJd21ScVlJVXhpN3ZZUlpiS0p6TlJrcTlr?=
 =?utf-8?B?T1BYbVpIYnFCUTl0QmJmYWRaNGFDZzJWZFZJNGRaUUgzV2o4Vlg1L2pPYzNB?=
 =?utf-8?B?R1lwb3lyNVpFN3Y4Tkp2TFBENXpoRGVFaGExL2VUTXhLbUxHZUNlQXEvV0p0?=
 =?utf-8?B?TjFneDJvMU9iUWd4dmVwYS9NRDFacjRTckRMUHJGeTNSZXBJZklRSFh0ZHlI?=
 =?utf-8?B?a1cvZytBZml3OEhJVjFidy9qVy82MUxOTFFrdGl4VUE1M2xhakF4a1VXN2xP?=
 =?utf-8?B?Qkp1MnM0TVlEWFBlZCtWYnY4dUFqL2Q0Q283QUozT2ZWckdXdEhsVjhjTXA4?=
 =?utf-8?B?QVFCVnFLMHQ3MWx6dW5wYSs2ZThKQ2FjdFBSemx2RWZQcFJlcktNQUFTMmhs?=
 =?utf-8?B?dVdRazZFSnN5SkJjTHJ2dCt2MXU4UGZwVFI0dDFiWkh5bnI3MGtWdlQ0WGc5?=
 =?utf-8?B?TjBzblgwZ1RRWC93Vk1iQzRONlNpZVVrSUtzb2xDM3FsQ1MvL2R4cG9LZFlH?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD0720F6E297354B8289143269E3CDC5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217406aa-edec-4426-3146-08db04c318fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 02:13:38.6615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7J84q/qNqbIYyR8Vuoy/LL37vNwx7F1jy9KCLMKPifBPbmhCSL+iQIjGNsGUowinX8rC1+azxOpKG93MPAfqwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQpIaSwNCg0KU2luY2UgSSd2ZSBjb25kdWN0ZWQgTlZNZSBWRklPIExpdmUgTWlncmF0aW9uIHRh
bGsgYXQgU05JQSBTREMgMjAyMiBbMV0sDQp0aGVyZSBoYXMgYmVlbiBzaWduaWZpY2FudCBkZXZl
bG9wbWVudCBpbiB0aGlzIGFyZWEgaW4gdGhlIE5WTWUgVFdHIGFuZA0Kb24gdGhlIG1haWxpbmcg
bGlzdCB3aXRoIFJGQyBrZXJuZWwgaW1wbGVtZW50YXRpb24gcG9zdGVkIGJ5IEludGVsIFsyXS4N
Cg0KQWx0aG91Z2ggUkZDIGltcGxlbWVudGF0aW9uIGlzIGZhciBmcm9tIHRoZSBhY3R1YWwgaW1w
bGVtZW50YXRpb24gc2luY2UNCnRoZXJlIGlzIG5vIHN1cHBvcnQgZm9yIHRoZSBzdGFuZGFyZHMg
Zm9yIE5WTWUgTGl2ZSBNaWdyYXRpb24NCmNvbW1hbmRzLCBpdCBkaWQgYnJpbmcgdXAgc29tZSBp
bnRlcmVzdGluZyBwb2ludHMgYWJvdXQgaG93IHRoZQ0Ka2VybmVsIGltcGxlbWVudGF0aW9uIHdv
dWxkIGxvb2sgbGlrZSBlc3BlY2lhbGx5IGJldHdlZW4gVkZJTyBhbmQgTlZNZQ0Kc3Vic3lzdGVt
Lg0KDQpJJ2QgbGlrZSB0byBwcm9wb3NlIGEgQm9GIHNlc3Npb24gZm9yIE5WTWUgTGl2ZSBNaWdy
YXRpb24gYW5kDQpkaXNjdXNzIHdoYXQgYXJlIHRoZSBrZXJuZWwgc2lkZSBpbXBsZW1lbnRhdGlv
biBpc3N1ZXMgd2UgbmVlZCB0byANCmFkZHJlc3MgYXBhcnQgZnJvbSB0aGUgZGlzY3Vzc2lvbiB3
ZSBoYWQgb24gWzJdLg0KDQpQbGVhc2Ugbm90ZSB0aGF0IHdlIHdpbGwgX25vdF8gYmUgZGlzY3Vz
c2luZyBhbnkgTlZNZSBUV0cgc3RhbmRhcmQNCnNwZWNpZmljIHRvcGljcyBpbiB0aGlzIEJvRiwg
YnV0IHRoaXMgc2Vzc2lvbiB3aWxsIGJlIGZvY3VzZWQgb24NCm1haWxpbmcgbGlzdCBkaXNjdXNz
aW9ucyBvbmx5Lg0KDQpSZXF1aXJlZCBhdHRlbmRlZXMgZm9yIHRoaXMgc2Vzc2lvbjotDQoNCkNo
cmlzdG9waCBIZWxsd2lnDQpKYXNvbiBHdW50aG9ycGUNCktlaXRoIEJ1c2NoDQpNYXJ0aW4gUGV0
ZXJzZW4NCkphdmllciBHb256YWxleg0KDQotY2sNCg0KWzFdDQpodHRwczovL3N0b3JhZ2VkZXZl
bG9wZXIub3JnL2V2ZW50cy9zZGMtMjAyMi9hZ2VuZGEvc2Vzc2lvbi80NDMNClsyXQ0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMTIwNjEzMDkwMS5HQjI0MzU4QGxzdC5kZS9ULw0K
DQo=
