Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32D5C43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 00:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbiF1Aht (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbiF1Ahs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 20:37:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9205C13D21
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 17:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHRiqmVHDbNiEJBTSQYBo495Cfe46wzK85sFT+v4QfUq0bNOJaDmOS+UxCCciALOAFzmHbR19s5FXGJDUzTEPluQ/936ylMzl8DgrCoiI4HQqZ79KRBQxDB4t8ymKZW91weJob+6bPi+c6dJImxP3yWFf3tLwn/QgSNkrIAL1JUrYyPD2TrE/COT+ZXYyU/O9CcYCZmCZZ00A6tz5jLxjizTMe7J2sSwp5Ug+SnGdt5M9uEty8rlFTI94PSXwjONKIKbvqp9WlHUzpiAO6eY1clE1WkKTBatLjVXDnscca19RxyvRWOGv8W7fh3P84JhRwiW0BD5qGFdFJa4JkXAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/RVg8/7v8FuqrwTu/RmSNFy7J+KeCFNAmQBx5pR25I=;
 b=PrdVI0qAGJjTPvuIMr5/XeVCRnpomMX4h/7ceAX2z9kXIAZj7805BglrNb0wCVaUVE0WkLX12mR4ZONdxmJnEi/OwAyOos5Bssj7kX2Aux1WHh085Zn98YN1Mr5faCN/AjKH3Kd3dixIPE+vtdPw7n62BRXWh590j9cEunaXYsWmNURzdSp5w/axiwetsCnjJN25IXXriZFSmi5e+NBVC5d77LcMQigHBQ3JUl7iJ4QuE+B5kO0pow1ki1yLMSh5dYEgVaRr/sMuPUCwIAXYOIUQZh1pPIffSrA87QMTpH0kXRb1qbFeUOTFckas6+l0Cj8MLqly1YMkcS4jzVU4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/RVg8/7v8FuqrwTu/RmSNFy7J+KeCFNAmQBx5pR25I=;
 b=R3Cbw/E0JkBqUBp3+saLDMjpqY/nIJMfMdkRo+g0dFD/aMp45UNALkJ3IVD1HuBATRJ5Rpkshh2vnWRPB7aj1OfblGgsLeFhkAPCSvMZy6USRdhr9h+3OMwbBcVNYROh0L7hG/miEhf9pHo+Q+0a5JHMpR15ctw8kV6CwqmXd2TowSDtMdVWdQk/xRWye67XZ1v/Nb0D12cJIRdiQW/hx76UAHX6i6zdU5tM1bptQE6vEXGprMmfr16UK8OpTDMk8jIkJjCWMpqNJA03V7lLqGDrAgG1ExukK3NxpeGwri7lgaxd5TLIKv8jjo/EhJuo4MyKPbhny59cboA8OXZtnw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 00:37:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 00:37:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v3 5/8] block/null_blk: Refactor null_queue_rq()
Thread-Topic: [PATCH v3 5/8] block/null_blk: Refactor null_queue_rq()
Thread-Index: AQHYioUemXZJ7FSg2kSeFdS/Pgcfaa1j+YaA
Date:   Tue, 28 Jun 2022 00:37:45 +0000
Message-ID: <e30aaeca-ba82-978c-2236-bd743583d3d0@nvidia.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-6-bvanassche@acm.org>
In-Reply-To: <20220627234335.1714393-6-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8161f05b-0159-4b35-b09d-08da589e6b92
x-ms-traffictypediagnostic: BL0PR12MB4931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w3xl6pH3X51AbXUfcvpL6Lu1wEJvoXCoH1wtDoWYFUA5Jm6LXyN55X1JDzVo9sFtMolg0jIgbSE995sKRekQr43Hgyd3Rlm3Wh0bZ4m3mZ3S20nZyKHDSQSHn4tnNmLIiowIyNAeEXaFKpmJXnriWpQXrxGBIRWwKNdhMRV1X25Ib2A/H1WFX+DeXCKwrTK1EijtdB5Qzi2ui9RX8Uz3+ov0Fcjn/G39Aq50hXG6oZJQhFX3ZxGFFuev0pjtzIcSKIdUMk3oCzO9qS8QX6XBNRH1brHOxCbN8sJKuQxKJUODzZnSWAgt9DFRq7IEzYeCBDvurXVmneEIcGYzzaHhPeCZmgloWcCzut+K1TQAhpTGBTk1z7tOpGDE+iPucz+84NjU1X1iZ1yTopcBnpT/OcPSjilUOnB7ajqiMV4l49sfaGPYHkY/ZHTfjpSSIrFNVGXFEAzCkT+suhQ1gZFKOXeIqpTOcyQ34OrMko6ukrh4LBa8POwLjZPgCihXEQfI3aOkCRpO2/v06qmEf85VV92yw8Zm6suwqFjq2gRRwhh12K3Kyjr6/6TFKo0vf6JpcuSHGVyp/HMBYNn4X0g31EZ0XFnth5VF8nWOuw0vAKS+VgkYpdVPUBOHuQvWaZQSzxKw4/cUMr45f4CEHBsMcU8jAxMzou4x1Pd/ZfqlvfbtylJKkA5vkVQ5vmXnkE72P9lCeslj5LGILaPcagtXnml2X388pkiix1D/pRxfmZGqUsgOX6UtFJ2+GvaDKrX2Ve0OdJwsPkmqhLHyOC/2NUvcNsXxI+IWLhWe2iX+pYBFmmN/jFMBslfdhLDJfgsG+ZZulgIm8A4d/nSHAust5HL078kHmwrY41/8ZJDiE9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(66476007)(316002)(2906002)(66446008)(66946007)(66556008)(91956017)(64756008)(122000001)(558084003)(8936002)(31686004)(76116006)(38100700002)(38070700005)(4326008)(31696002)(8676002)(5660300002)(6512007)(36756003)(86362001)(71200400001)(53546011)(186003)(6506007)(478600001)(6486002)(41300700001)(2616005)(54906003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTZBRkg5dUVZbStVWUlFQVFSMlRHVjJsSmNYNTAySDUxTUxFckhheHA3cysv?=
 =?utf-8?B?Qi9NN3duZThYLzAyREFCVGlkZVV6cWFPNXM5SGFMWUQzek5XNVN6Y0lJNWRP?=
 =?utf-8?B?Z1hkNTJ4RURWTFY4TWkwQmVmV0xnY2dwa3VuVzl0ek13bmVmNDdRdTNNcGQr?=
 =?utf-8?B?UzM4R2t3SzhFY3V1aHVkckRvd0ZTQ1NmM2gzd3VxZXJGb2JyekRPY3B5bGxG?=
 =?utf-8?B?UzAzaHFZSUxDS1lZaVl1azBORHlhb1hVdzVLWlhpOE1OMDVHWVB6aytEU3Rm?=
 =?utf-8?B?bkRiNnBPZDR1RWN5VzJCaCt3OXZUNjB6Q2pYa04zR0pxVGN4UTZxQXlPNFMv?=
 =?utf-8?B?UndJYkM4VTdmZkJ6dVNPZTBtY091SnpyMmFCQ0RjaXIyZllQRFpjdkVqNVoy?=
 =?utf-8?B?a1BDelFRdW9LVUFaWURIUm1ZY2UvSFBUNkNzZ1VLR290RFdnNW16Sk5RSlFl?=
 =?utf-8?B?KzI0UW1ZUkFHd3QydHg0c3JZVGVRNUJYZzdQMEhwdzJNZk05OXlHK2hZT3d2?=
 =?utf-8?B?eDdieWVJb202a1NmelJCNFVORHVTeEJuZ1dvalRIMzNpWUlHUEluSTNGaUVP?=
 =?utf-8?B?TEYxMVdZMW1UV0VRd3VwenU0ZXpKUjIxZkdjZ3M4OUhRVFNvcHlVdzlXUVR5?=
 =?utf-8?B?TUNUaXd2V0NKRHNGWHVVbVp4WnJsRHNOYy90eUkwR3lDVFNZQmpBM2pwbG92?=
 =?utf-8?B?azR0YmIycTFzLzA1cXB1dWw2eHFacG5ZVUV4V0RoVVhJUEcxNWNiS0YrZ3VC?=
 =?utf-8?B?ZC9YVC92SXY2bmM1TEFjYVNqZmhsSjB4SHI3TFliVmFwa2JUblNWbm95dFJG?=
 =?utf-8?B?RUUrUnlnSHpzN3pRNlVXYlZvb0h4aW8vTk4rMnY4MFRnYkpjREV0OHlmdGcr?=
 =?utf-8?B?VysyZG5tMTA3Q2pZT1RoSWZvY0NWUDQ4Sk1iTmtFMGpVaHVsbEZyUndTNHZP?=
 =?utf-8?B?U3Q5eWhJY3pzdGxwM2piczkxM2Y0MHFpckltTmQvMTNsNmhQSDd4RFI4RCtN?=
 =?utf-8?B?TmFmOG54TmMvY3pKZUdHZ3ZacFlXdlR1VHZkbkQ2dFhqSnB6VTAzVk14YXBp?=
 =?utf-8?B?eUJZL094c3MxU0RocHR2MUE0R2ZvK3hFWFJSV0ZHUStoTUpONGZISU1TK0JD?=
 =?utf-8?B?VGh1bEJNVUxFSE5kYS8wS0YrL1lXaUFuWmFxeHBybFFDYVNhN0NpdTYzVGJi?=
 =?utf-8?B?NnZFVWhSbFI2N3FHY25kcUtmQjZaaVBKZ2haWjdSSVdtN05jbjhrM2RTRlND?=
 =?utf-8?B?MVJlbXhMODNrNTBjY2F3N0lGTHczN2xNM2t4NDVFRTZZYk5NM0o1cTZlMDFZ?=
 =?utf-8?B?bmkvVDQzTVd4RS8wQ0hFN1JMbWUyUkJTRklnUDB4aU1wV0xHOWF0eUQwL2k2?=
 =?utf-8?B?RUlkS2R3OU8rYk5pUHhMSTVCbi9JblluY3Avc0Z4ME14N1dJRUREdURvQTVt?=
 =?utf-8?B?d3lzTjRSSzNGaW1YczFDbUFQVThlMm9uZlh1VUlYd2FQaWdZWXBkdFFUbG90?=
 =?utf-8?B?Q2pIWm1PaVZxM3BkeGMwelhqYUtKWVBra3BWR2VYcExuMnNRSWFsa1l0blFw?=
 =?utf-8?B?ZmV4RERxNWlIZEgvNlIzRVZvdEM2blE2aVkwbGNBMzNtWDZEak01TERjYkZD?=
 =?utf-8?B?U0huRFMzV0ltdCtrbm1sTjdUa1VUTE5wSFRxRjJDNytrTXN2S0NOa3N6RzZD?=
 =?utf-8?B?ait4QjlWcDRJaHZleEJ3REJqcFpHTmhCY3Fld0NyMStnZkl4Rld0THNnRUNF?=
 =?utf-8?B?bVE2UnhISVJuMFBpb0NFeklDUVBhOHFPK3BZa2diSWV1akRBK3BOM2w0NTJJ?=
 =?utf-8?B?SUVlRms0TDF5bUgvYmp5RnlpMFlGL2NuT2lnR0lTYTR0aVdEVjJORTRGZk50?=
 =?utf-8?B?MFpGUG1YM0lwbUpsci9wM3pGY1h3RXlHR0FRbENYL0hGWVNBZ3JtamNNcDVP?=
 =?utf-8?B?RnY4U29jcmVOUUxOL0NrTGZreGpzTGtSODNJNTdlOWd5WWlDeFhNMVdJWTE5?=
 =?utf-8?B?UStpN1lsNlNtTEhIYnRoWk9PZFdNQVQyOSswUDF5Q3pMdEZiRTcvNWMvSk1U?=
 =?utf-8?B?QVVtK1hTTS8yTkNlOVU1K1R6WDRnOHVvRi9idm9aWTQ5Z1NFQ1JSdHFnRjRx?=
 =?utf-8?B?cHREQlR3aEQxUk9WWmovcXZucVJhQVJmUmNtWE03bHR0amMvUWJKaHRqcVo1?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3C0199C95393348BD180741D06DDB6B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8161f05b-0159-4b35-b09d-08da589e6b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 00:37:45.8730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsVO+OAZjDfEsWdKWjBHKEXHIMSolR+ovHBdKxphrdcDYraa7w6K+BNSojoxtQ2sCvTg8aEmgm17+1zC7eGmMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi8yNy8yMiAxNjo0MywgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBJbnRyb2R1Y2UgYSBs
b2NhbCB2YXJpYWJsZSBmb3IgdGhlIGV4cHJlc3Npb24gYmQtPnJxIHNpbmNlIHRoYXQgZXhwcmVz
c2lvbg0KPiBvY2N1cnMgbXVsdGlwbGUgdGltZXMuIFRoaXMgcGF0Y2ggZG9lcyBub3QgY2hhbmdl
IGFueSBmdW5jdGlvbmFsaXR5Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IERhbWllbiBMZSBNb2FsIDxk
YW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQmFydCBW
YW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
