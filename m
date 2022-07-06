Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85071C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 15:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiGFP7L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiGFP7K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 11:59:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDEB2183C
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 08:59:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266E3dLU006141;
        Wed, 6 Jul 2022 15:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Sc3mEHSe+I/rcNAXAJpBucRDF5AlARh6o6SxFjMrt3c=;
 b=G0lr2BMDLmOS9GOVfzKsdNoOaS6mbOLS4XZO+8gW3xqkrcOpw8TT8GBE8VYDKsyuTJv/
 TFLtLCPXNcxBInnDomOcoOMzEP2SwCAVXQ57729IS9/UAi6f7HSjpKLdBEkuwQdTsI7s
 ywgw9SLyncxEj6iCT9Gz9FRxuq8cuGXs9MMotVLiA+1qK+Hcu/+5PyKGkLecjekW1ROC
 3hsMukL07OgIi9gXGFjeNCO0wcZ9JnOJLXBFPfJ5yz3Jz+FRPQCZRd7ebNrCW0NPs1Gs
 5RNeG8wJkweNIpjRhQFp4Btaug2m5uGi8LU04tXCQX6cEoPhrj9q/ZKQTRhTbEoUSuP7 UQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubytee9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 15:59:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266FpRfI032121;
        Wed, 6 Jul 2022 15:59:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud86592-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 15:59:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1zgvFDSePzoC7fVlSolx1/bkFGeWraKaAI1lCgw+wZqWmTcWnWtQKT/hSF2ZXApO4nl7ixLJ5rUHX3nlNXMWZeMMygJtbLadKj08/6wkM8l6SPaXwd/Yw7i55xJNViiWU/Ag6edQwGnKKC6zIUe52UbqI2D2ynH9Ux0/zTOOkzuUDvN7TJ5SVI+yMtefYOV7SW5Bsm/ztdVcq1OGTPBaU0kDHvAH8FJZ3yakfnUmGGx0M3iVZzDt54nGKU/BNxVjmZ9ogM+ARwqy9/oK3CIfVzXMdSHas0Zr0pChoSxZrMaOlHqP555BREGJnJwsZXuPtIz7EYUtsaLh2MLv4CmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc3mEHSe+I/rcNAXAJpBucRDF5AlARh6o6SxFjMrt3c=;
 b=Ibduq9Q7V4WYQgpFfpruA9qC0jUB3cTpJYl6NyCbE8KMJZXmKUunA6QcaVQ0zMQ6kCzXzY7vtyGfox9cIOF1Y4yCZ48QWXrITtEvT5sz6KNmYuatW7lHPjCc4M8NLyqSfFFUIAXJ2IrT6+DXMhCqMF7Z/26qK7MEzJ6fGWcz/UqaGMl7S4hZXc/txvLC7ivHS7moxYBpXlcf/Ov/BvqzA8y59dr7G9BFhJ6uvPNJAjSfp8CB7Og0Rz4YopvEwWvzReQljB23Z3EvhUoTHqmi9bDjRUdby7iRIu1nk4UKG8TzliNXGsbSmvn2BHN3GjizHMDqyhDHAd3URcNbjWG/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc3mEHSe+I/rcNAXAJpBucRDF5AlARh6o6SxFjMrt3c=;
 b=VseUfhhzm2bCCWzjtuMGNyDaggzNQy3z5n4I0pRCRZdL1el7IYh9MAwZPoqy+Uhc9VM4dT6T6DbM61pabXUbvJRcE8NFitIGKB50gk1qzO1Kz1dYQON72dVraHWjYlpy1YNhn16EHkRhBAn90kgOYA593hD+mHxotUPp8z1vpWA=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DM5PR10MB2011.namprd10.prod.outlook.com (2603:10b6:3:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 15:58:59 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::711c:ac02:36af:925c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::711c:ac02:36af:925c%4]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 15:58:59 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] tests/nvme: Set clear_ids for passthru targets
Thread-Topic: [PATCH] tests/nvme: Set clear_ids for passthru targets
Thread-Index: AQHYkLG+bIDx62xWtUmXo8eTsGiyYa1weoyAgAEGqgA=
Date:   Wed, 6 Jul 2022 15:58:59 +0000
Message-ID: <85D002C4-B3F7-4EE1-8C0B-B2E41F234046@oracle.com>
References: <20220705205632.1720-1-alan.adamson@oracle.com>
 <cd910676-cf1d-ae13-94f2-e1ccd59d431d@nvidia.com>
In-Reply-To: <cd910676-cf1d-ae13-94f2-e1ccd59d431d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3176091-a511-418c-4ec8-08da5f687080
x-ms-traffictypediagnostic: DM5PR10MB2011:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MeQt5vg//lbNvHVN+jmtzWBfefF2W6LLEcQMiDgpH9zO1PEGdffdsnSnJCk1XzFdtfvxq6EoBEUN2ASXVh00tTfnP+wAbWp8GIgt44i+ifbkYWLpGZmB8dJzgMrkDbxvrlEDNrlfSUE0NohxJED/mwJa32icLRGaP9zYaJ6E7G1r6GV95Jb+4xU8P9W0Ynr6KiedoMZtphlW2SfQt8mPzSiynRXzdkNtxbP6wj3JvqM3ZOYeu39xFDGi7nmj3ghZQkBOwYfngplQdLnyklOd2j74pi4CQihWOoj73bn3HG1neeqnvZppWJA1agdDyZCvTFrFgLaBSlduD4yNswx3Yp15stq16+YY+eB/91pARTxLUu05XDoa0MgHWFcjcLGOxoTFL+qdjUm4ZU2yKXjq8IUrY+p2NhYuxT0a9zsHYvxCNEfwq5BE3GOik8o2f92X+erT3iu1Jq9Qh4u5s1lNBuEVLmZ4ORBQVuXXPCqInFf5d9ej5GbIYWSuQ/JMTv4k5IQbsSiliFJrEN/aGvRKY2HHLN7h9oymZAnG0qJXeZnjIPOow20WkCI0kTJM4fm3BtR1ry6gBbK5yYN4EBCK3OkgGOtQltdat3EYGSzP8MFdA3R/Rac5VlqP9q40gvStFvUQKMoL3mMP4N5v/TDr1cx/NHsZtw+Lf174DVj0oYrQviKayG905kEp8huRN1qo8K3MTxI1aNkW321GDInluZEF3SO4i/vXNUI/RlAlHDEny385jmhaBbUkjWf5Pph7cN77jr0dAR/RVUgXghBQlXxmyR68tQlW6yFsjnSIxomJu6b1nGf0McJde6yeZCxZba6X8um16tDzyOOVpaO/0a1iRmceQ33/h5S9NSgtqwY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(376002)(39860400002)(396003)(53546011)(6506007)(6512007)(6916009)(66446008)(316002)(8676002)(478600001)(64756008)(54906003)(41300700001)(66946007)(66556008)(66476007)(4326008)(76116006)(91956017)(6486002)(71200400001)(83380400001)(86362001)(38100700002)(2616005)(186003)(122000001)(38070700005)(36756003)(5660300002)(33656002)(44832011)(8936002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXRJM3gxNjVsRzlWSlJZN0hoc0M1ZFdVR2IxYW8vOExrb2VQTHVIaCtmMTBT?=
 =?utf-8?B?K2ZydWxBcy91cnkzbzA5NmJzNURQb0ljWTBCTjAwU2VXR0d4b3hzNDlqeEtZ?=
 =?utf-8?B?VkNJZmdNMzdmeHZudnNiWHBTQW9PdVVyUXB4bG90c0JoUmJJVk5oM1NsZjNJ?=
 =?utf-8?B?Qmg1djYyMzNreXhyN3owZ3Q3Y3hTM0VlSVJXWk1VSXIraEVVYTZsMzkwOWFP?=
 =?utf-8?B?NTdRTDhrOVh0ZVB1S25CKzcrNWVuVmZyMDZDRHc3bEMzeTZhU3hQNERCNFZP?=
 =?utf-8?B?V21PS2ZYbmxINzU0a2NTbERVSGl3MWliVng1VjdnclYxenQ0dDZrTGh0Q01P?=
 =?utf-8?B?Vk84NldqbXpITW9ic0tOOFhMeGVFcXRmYmtqazRlcndncmVORk1oeGJWTWNL?=
 =?utf-8?B?ZDV2dGVmYytnYkpkYXVEM2RJcEpJb0RIejhYeHB4T3YwdjFwbnVoNzRGcUFo?=
 =?utf-8?B?VHJ6Ri8vSXBuckJEM0xpSXkvYlRBWVJ0aHpnVVkweCtLSlpiRmdqVkw2N2Q3?=
 =?utf-8?B?eXlCZW5EMUdQNkpYQm03czBKbzZqbUtwQmlCUUdHbWlVMzV2QkV1Zk9XaVdO?=
 =?utf-8?B?VlorK0dGQXZiTG9jTmZWM1dZbnhXWCsxM3RtWnZSU0kzK0pPZE4xSnk3NGZE?=
 =?utf-8?B?RzRlaWEwUUFVL3RsSFVmSTlrazZrWW9GNXBCODRTaHdzZno0QXhIdWpQQ244?=
 =?utf-8?B?U2ZhUlRqOTh4RWIrVFd2c0JPUWQveElQMnp4VUFMZVRiRzBRc3dURkl5V1Rz?=
 =?utf-8?B?bkpESHBBLzhoUHVMUXhHVmpYSHhMZnBBRGQ0MmdVNXRrb1ZUdnc3TkNPMVVM?=
 =?utf-8?B?V2t1cG5Ia0puNHVXY3NuV2U3QWEyeS9UaFBCMENaSHZoOXk3ZkVLL1dyR0Zw?=
 =?utf-8?B?bm51OWhjR0JhMUJ1SDByT2cwV0ZCbTdqS0tyM3FoWGgrbDZROEdMYitMb0NZ?=
 =?utf-8?B?RGxmakRSMXFyai9PQS9CWGpoNEl6VU5iU3BMZmdQT2hNSGt6aWdYa2RrcjB1?=
 =?utf-8?B?NExsbGJPaVU4WVlOYjNCdDAwS2laM2VIcXF1UTUrTk94cFg3KzlNeTAzM2cw?=
 =?utf-8?B?SDlCWmpjREx0MEozMkhvV0ZwU3hkYkVoN1RwTTFOVEt0ZXFaMStxbjN3WnpD?=
 =?utf-8?B?VzVQUzhSaUgzTy8wZ0EvTk1jYmUydjZoS29ZZndJOU11R3BUeSthS3NMeDZH?=
 =?utf-8?B?RldtMWoyQncwa0F3am5pWWtUb3hhVURyVkxNNDJxaHZDaWdnK2ZFbS9ienJT?=
 =?utf-8?B?SFZTZnlpQndSUG1XQnZZaTZDOFRkWUlXNnc0dDdUOU8yeWE1WkNLRmF2S2lX?=
 =?utf-8?B?cndVKzVOM09tUWdidzVmOFVaRG1zQ0RMb01DZGw4TFI1dXlIYTJyOWlHMVl6?=
 =?utf-8?B?eG1CN3QzNGlJbEJwenNsclJXWTNYTmJTZzFHMTNvYy9QUkRBZjIzdkxqSmRV?=
 =?utf-8?B?L2I5bXUralRETUhwTGN2WUlHWlBMUVR4YmdUZXZvRHdNaUl1RGpSOXVlSGtL?=
 =?utf-8?B?eStjbyttQ0E5TmlaOEdITWQyQ3RMcnV6S2tlVVNRSkhKMGE2WFVOTFZVM3Bh?=
 =?utf-8?B?eDdPOXIyVFhUcTc1VzRHV0sxWnQwVWpISk81VEdSWFI1eWo5Ly8vNWpxcWxI?=
 =?utf-8?B?TkVJV1Nld0wxVjVKUCs5R2lyRDdUL0tWNzA4WStnamxtMmdvWFZvNnN1WnRv?=
 =?utf-8?B?czdYQW8zTmt3dlNlK0V6YUFsTmVWOVcvZUNOVVNzQ0djeEY5YlJKYXppYUhq?=
 =?utf-8?B?YVZvWlVnQ0paV1ppbGVSTUZ3aGJIek1FSlBqVHAxV0J5Vy90RFg3YnBuR1lQ?=
 =?utf-8?B?TGNqV2tTcys5ZlBmOTlhQmN1MVVjNDB4RWZMalVBYXNkTHFnazBaVWM1OEVx?=
 =?utf-8?B?WEh6cE1oejAwb0VXVHdMaHVDLzBzRnp2NDBhZ2RiZzRVU3hTb28vVE1QWEdX?=
 =?utf-8?B?cG9OUGNXZ3RUYmp1cjhLS0lUbExGZVhwUWduZEx2aDNuVVpCbEdQYkxWaXlr?=
 =?utf-8?B?Vlg3c3VmNStuWmlnRlJvdTRPSStPc2pXQk1nUHBKdEJUQUpiL005YXlUTExM?=
 =?utf-8?B?VTNFcUFDdXRDVVBzWlM2UFRxRkU4V0RTcUJic0ZqUGExRTJRSHVrZDIxRk5P?=
 =?utf-8?B?cFh3UndHTGFRRWZYNXRwUDJjWDhBeEozb3V6bHZ6Y2tVWUZxMWVxckI3Tm1x?=
 =?utf-8?Q?YlKbM5Rgy33bD8DzrEiqq9scp1zW70DakfA3MUzrQFK8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C88B556314FC142AE16BBB387BDD69D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3176091-a511-418c-4ec8-08da5f687080
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 15:58:59.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPae2CqevP0KvpLHC/iCAivWV3GhmrnsGYSObUAKNtXoQBhoz1jFi2dwa1jQQ8scKo1AA/fiunFsAF3HYoXxoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2011
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_09:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060063
X-Proofpoint-ORIG-GUID: IFOYMIkFO9B9K903h-9l04inlRmeiUyF
X-Proofpoint-GUID: IFOYMIkFO9B9K903h-9l04inlRmeiUyF
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gT24gSnVsIDUsIDIwMjIsIGF0IDU6MTggUE0sIENoYWl0YW55YSBLdWxrYXJuaSA8Y2hh
aXRhbnlha0BudmlkaWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIDcvNS8yMiAxMzo1NiwgQWxhbiBB
ZGFtc29uIHdyb3RlOg0KPj4gVGhpcyBhbGxvd3MgdG8gY29ubmVjdCB0byBwYXNzdGhydSB0YXJn
ZXRzIHdoZW4gdGhlIGNsaWVudCBhbmQgdGFyZ2V0DQo+PiBhcmUgb24gdGhlIHNhbWUgaG9zdC4N
Cj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogQWxhbiBBZGFtc29uIDxhbGFuLmFkYW1zb25Ab3JhY2xl
LmNvbT4NCj4+IC0tLQ0KPj4gIHRlc3RzL252bWUvcmMgfCAzICsrKw0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL252bWUvcmMg
Yi90ZXN0cy9udm1lL3JjDQo+PiBpbmRleCA0YmViYmM3NjJjYmIuLjVlNTBlNjlmYjNmMCAxMDA2
NDQNCj4+IC0tLSBhL3Rlc3RzL252bWUvcmMNCj4+ICsrKyBiL3Rlc3RzL252bWUvcmMNCj4+IEBA
IC0zMDMsNiArMzAzLDkgQEAgX2NyZWF0ZV9udm1ldF9wYXNzdGhydSgpIHsNCj4+IA0KPj4gIAlf
dGVzdF9kZXZfbnZtZV9jdHJsID4gIiR7cGFzc3RocnVfcGF0aH0vZGV2aWNlX3BhdGgiDQo+PiAg
CWVjaG8gMSA+ICIke3Bhc3N0aHJ1X3BhdGh9L2VuYWJsZSINCj4+ICsJaWYgWyAtZiAiJHtwYXNz
dGhydV9wYXRofS9jbGVhcl9pZHMiIF07IHRoZW4NCj4+ICsJCWVjaG8gMSA+ICIke3Bhc3N0aHJ1
X3BhdGh9L2NsZWFyX2lkcyINCj4+ICsJZmkNCj4+ICB9DQo+PiANCj4+ICBfcmVtb3ZlX252bWV0
X3Bhc3NodHJ1KCkgew0KPiANCj4gd2l0aG91dCBsb29raW5nIGludG8gdGhlIGNvZGUsIGp1c3Qg
d29uZGVyaW5nIHdoZXRoZXIgd2UgbmVlZA0KPiBhbiBleHBsaWNpdCBjaGVjayB0byBlbnN1cmUg
dGhhdCBib3RoIGhvc3QgYW5kIHRhcmdldCBvbiB0aGUNCj4gc2FtZSBtYWNoaW5lIHNvbWV0aGlu
ZyBsaWtlIGNoZWNraW5nIG52bWVfdHJ0eXBlPWxvb3AgPw0KDQpJZiBudm1lX3RydHlwZT1sb29w
LCB0aGlzIGNvZGUgaXNu4oCZdCBuZWNlc3NhcnkgYmVjYXVzZSBsb29wIGRlZmF1bHRzDQp0byBj
bGVhcl9pZHMsIGJ1dCBpdCBpcyBuZWNlc3NhcnkgZm9yIHRjcCBhbmQgcmRtYS4gIFRoZSBjaGVj
ayBpcw0KZm9yIG5lY2Vzc2FyeSB3aGVuIHJ1bm5pbmcgYSBwcmUgNS4xOSBrZXJuZWwgd2hlcmUg
Y2xlYXJfaWRzDQppc27igJl0IHByZXNlbnQganVzdCB0byBwcmV2ZW50IGEgZXJyb3IgbWVzc2Fn
ZS4NCg0KQWxhbg==
