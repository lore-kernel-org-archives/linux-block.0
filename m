Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237F9C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 17:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiGORWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiGORW3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 13:22:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D25685D48
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 10:22:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGHeMW027311;
        Fri, 15 Jul 2022 17:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4dPsMSgVE60yVSAx/xTA5OFDPq3/3hGaXWfikNWs3qI=;
 b=le6954YDpQ4NJlq9viSFo5CGBLHx1+thAPJhU3pWsbqFRzfNQ7DJCPTAUk+ocDP5CE2+
 NlTey4mO3QRiwa3Lq/Z2mZl3DFlLwFluveeonU0axQ2Ap/ir1DJftc5VC8WYNj58Tw0U
 oac44LFA6BIYV40TlrscyaL4JitR+9hrphqIjpmeLkMUfWRZ1wqSAeNP+Fizi+ljgEnq
 MGfa9FAzaN0LukfjSsKMaFSP1nKkWERgN7Sj+DPtOkjo85vfKQy4rFPPh+21wSIxdp5Y
 3Kp47NdyKATrR1Y2bhUzDQZDlJaJVZeLc/K2cf71F6omau/M1KmaaBtbTJhZF7t/Qit5 Gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rg8d16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 17:22:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FHAvds028372;
        Fri, 15 Jul 2022 17:22:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047afre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 17:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhNFOZy50pIJFzcZa84aLoloA0DF2L4zqgDzk7iN2+lMB0GXGslPmzT07VrIEPwfasb7/Aa88UfuJR9iPitXK8OVcsd1lZKAMPg4Jiur88sMRp0MHvIGv8nCYA54j2KW+0jj+mY8x5lrmReeuN2sDCj4/v7tNSfOBlgxUatQ7VPEvdMvBY+smMV8EEIkrIJq6WTFAImZjS2zciq9wga9Ngb/kVkinGggwJCNykERJWFvdbZuJ3b37BKhZlLKFvK74HnPJKD/6Q0nZ1NkcgtuQcPhSx1z/GNAdOsgy1u+N54roz6+68VrkVK2DwVnFL+tU9LmWuM2l8Q2EWxvfwcobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dPsMSgVE60yVSAx/xTA5OFDPq3/3hGaXWfikNWs3qI=;
 b=HREWhuPu2aNw4eIhSgcP6bp/HwsqtWquIICKreyJ81tnevqU8SPTDuNA4Qnac/Mh9GWfwDK3ZPHe1mb6rnKhuua/GC9HI/fVnsNwSgTsD3WwYgNVV2uHInEjPWU/T5cRV9fmJ4ijB84IUBy1vfiGNpP6GEzmU3TQ+dpBazVkjLfQGzqnNS9QyQgSDmOsc91/JnZBuP6auz3EsQ0KgG/n7KGulAuPWXozTgO95bNQcCvnz7x+1iche4fF9Zlo/vd2igzt+732EJcOfzhGAd4QSTPEeuW9PAuG5tpHqF/CiB817WiuDC5K+I1ogiKqpDvVelkpX7VBQa34nAmJeGJzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dPsMSgVE60yVSAx/xTA5OFDPq3/3hGaXWfikNWs3qI=;
 b=wlfCV8j56Pl2BoeKcyQcDJBmDDz8hA/cpLyFKqsZdNZYwW5qjs6Lu5u8yRTSNXd+X/0NWCofEjhenQB0ZJusQVHqoXo6tEE6+YJUF7A/PqGbWl7FqvfMjjQmYwK3A2hp4240KEwzalKqrjKoyTNMCVdpqkKF6Xf1D4rTp0i+0YA=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 17:22:14 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::711c:ac02:36af:925c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::711c:ac02:36af:925c%3]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 17:22:14 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] tests/nvme: Set clear_ids for passthru targets
Thread-Topic: [PATCH] tests/nvme: Set clear_ids for passthru targets
Thread-Index: AQHYkLG+bIDx62xWtUmXo8eTsGiyYa1weoyAgAEGqgCADJoxgIABEeeAgACQJoA=
Date:   Fri, 15 Jul 2022 17:22:14 +0000
Message-ID: <AC6DE81D-849B-4DE4-9487-96B059DE2FEA@oracle.com>
References: <20220705205632.1720-1-alan.adamson@oracle.com>
 <cd910676-cf1d-ae13-94f2-e1ccd59d431d@nvidia.com>
 <85D002C4-B3F7-4EE1-8C0B-B2E41F234046@oracle.com>
 <4AB40A37-F3CA-496D-80D9-13845D6DC3E1@oracle.com>
 <20220715084617.evi53gtxem7npkii@shindev>
In-Reply-To: <20220715084617.evi53gtxem7npkii@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98b6e9e3-4e5f-478d-c061-08da66868f8a
x-ms-traffictypediagnostic: CO1PR10MB4705:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: la9s8KtjCvRsz/DE8WEaQaal6UN4rqtE5wWvGR1Tys4JsEnX1jHqwNC/SAcN2dRF/XwEELu/6o3uzF3DVsIq2rEbNY4J43pNCVhXY+EGsV1DwAdOfaN11ArS0tOYWzP/4SB2WHTbetVEpU4l/E17LYlMo7D3ebStSh2P5j4cegGj/VmkNI7DMvwZyxuHHRaVYuAAylG9Z1vJYv6DJqicrkf0TpxRkh4nz6D6gMi1DCGScbfQXH73WBcYFzfO/8mi8XQ37z7fhu7HDqqkPAE6LC9kxxutMME3MnTDToE4ahwp518MRhmshA8Vcc5BEvT3M/CivuEdBmiWWM+L4VGWDGxkEumzhhQ55gj/fLwV8/gs76352JqvwYbVfSrOyI5crg54/D9xzo4UxAERdm8+btN0pv0mefg0ggzTwnwTMv9nv/p/sJIUnkOj42xdneHC+LXWHEvq+TChAYeRKWBJcXM3BQZR84hu/PxQZe4Wm4UAX6usx8yPFrtOeSfgBjjkyR5nBvTc09bsNNY7xCikBvhZHlg+Xwq1RSpgZaXmt5TXo6REsWTjohJthTPaTnS19/mB37GZsUMRMwRBzpMh4cL9UWm/PO93DgYqBiCTUDyvBKLWm+bSTVHy/YqJWvbf2/hvTRj8KuWPEOieYBV3r6EH4Ef2xKnWk/Itn9vDmn1LjQO/k4BHnRgDjJTcIxJscioYm0cScFTXz7sDtBYutUHLmrQFtDgTb+tTV+b2ZouhH4A9vJFpE73KeluKFJkJcttF6MY8UY8Wv0xRyxPeetxo3PKbEywysyjyJ3JJLciFcg8SpFyOw24yIh5axXpbYZtuPytAQEQrsjDcDWA7C78s2Zbd2F5whhmvtvEhpes=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(39860400002)(366004)(396003)(6916009)(6506007)(54906003)(6486002)(64756008)(478600001)(122000001)(86362001)(6512007)(76116006)(66556008)(66446008)(66476007)(53546011)(5660300002)(41300700001)(36756003)(38100700002)(66946007)(316002)(71200400001)(2616005)(38070700005)(83380400001)(8676002)(2906002)(8936002)(44832011)(4326008)(186003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elNFR3pncEVEVmxsOG9xNG9oRUw2Vmhnb3MxSTBQemFuRWc0NlFRQ1BmdkdU?=
 =?utf-8?B?cDJxcHpTQ2crclZKcGxxQ2hyNjc0YWhCQmZycmVUd2I5WjhIckdNSU9lcmFh?=
 =?utf-8?B?d2lSa3pTT3NuaWdRYmlKSlFnMXdrbzFCWU5PcUNLcmpJWFhYNzM1STVPS3ll?=
 =?utf-8?B?MXIrVzllMHVtak1TTTBtMDhrTFcrd3NWcFlhd28yR2t5MURmY2VDZ1RhUWtn?=
 =?utf-8?B?a25zTC91elBxODc2WFJwQ2V0aVVtQkY0Wldnd3JwcmdBUklyaVJQdkFoMHlT?=
 =?utf-8?B?MG1jVHliYUpOSTBFZy9rTGEzR0NEUk1WaFF0dUNkZEZIRjVlUUlQQ2QwWFhE?=
 =?utf-8?B?Y3dBenE2Z3pzektpd2VRUFB1VzZPeDI1cGpaT0hOd1d2c3FGc21IdzJIVDZX?=
 =?utf-8?B?YnY1WXgyeURwWWJmcEFlb25WdUpJT3ZjRXl1RTNtb0ZpMHVGbXVLQVVEem1t?=
 =?utf-8?B?RFZQYWFEV0htM21uRlRaeDJFMVpkaVgybjUrdmN3TUZsbzloWDFDZ3dod3NJ?=
 =?utf-8?B?UUZDYmJid1hzSTFBWlZUTkNwUHhpY0VsaVo3UXMvWldlS2thWDU4bTY3U29J?=
 =?utf-8?B?YXg0WVVTWE8rdFhzQ1htOElScnhUTUNHOGJwc21UdHVEbk9yUnNiUDRFSzl2?=
 =?utf-8?B?eEdxQi9pQnpxejZYRXkrOHo3RFgrcVR5a1YwQ29nUVd0bGkzajVwd0ZsTm1n?=
 =?utf-8?B?eHBsSm96bVMvcG1wSW9JTjZyWlhNczV0cFArelhBR0l5eHlmVXcyN1NZTmto?=
 =?utf-8?B?U3dZZFFFK1diOUE0UG52Wk5VQTE4dVJySXVlUTY0N3U0YjJYa1IyWFluMFJn?=
 =?utf-8?B?d1ZSNDFKWXhvczNpbHgrenQyV0djSDY2ZzExSHBIVmZRUlFHOUhXSHAzTTVX?=
 =?utf-8?B?KzY1Unl3SFRQTnFqTDJITWs3czBCTG5ib0hORkNsK3YvelBwSkl4WGZMTWtN?=
 =?utf-8?B?aHFPUFlsNlBCb1pKUDA1Rk5teHRWM2lxSUh2VHZ2MGoxZU9sekl5SnB6aUV4?=
 =?utf-8?B?WE5kbUsyeVJEUmxkblgyVVcrRWU5SlVXeVJkMDNiSGoxODJBemw2cUlPTnQ0?=
 =?utf-8?B?ZkIwOW9tbFlRRVVieHlSd3o5S001V2M3eE9jRGZxWkthaHZ3ZkVoeHFjVlND?=
 =?utf-8?B?ZmJDc1kvVUNFODNRUGVuejB3ejhSRUNCS0w1eEM5cm9PVmNUTGRYeHJBd0lp?=
 =?utf-8?B?TFpuY0NEaE9WSEl5Z2xQUVZNOWdhT0R6aldRb20zMWtHc21yS1dPanZDL3hm?=
 =?utf-8?B?VUltdGtiYnNQd1ZWT1pLSjFIcG9jazdCdU1ydk9hNTVhM20vWC9rSkxLSjgr?=
 =?utf-8?B?TEtDaEM1T21NYlJUK0d0cTBQbXBzVVR2bmtXcEZsSWlQelNJWGRIUEhIMlpo?=
 =?utf-8?B?SjFxMnprRlF6MFFFdncyQno3SlpKalpVeG9MdjZmVjdUT1J5cDYzaVpxeVJB?=
 =?utf-8?B?VHlkT3k2SUdTTkxUanlWUTNhVWJqRE9reUw0RTFnSi9ON3JPaTlqUkpSOSt4?=
 =?utf-8?B?NldCdzlxN1NZQXdyZ1h2bk10TlhNekc4eExSR1FabER0NURoS1M0RmtRZkNp?=
 =?utf-8?B?dnNxcE1UR3lRdG9WM0VROTd0QWVUTGdUVnRobm5JQmoxMWxVZXdISVNOeXp3?=
 =?utf-8?B?cTNTLzNkYy9SMWtPSGx0OUZFUUdoaDVyRDdxRU5rdEFTNTVMeVExN0VFaXRY?=
 =?utf-8?B?L2ZYVit0SXNQYmZJbkF3YngxejA3cUdpeTQvUXVyeHhzRXJlUk11Q3VxS3R1?=
 =?utf-8?B?TlhPc0xUVlBFTVpzMmVSVW1uc3hmQXptV3FaMnVLbnpoeFZRNCt1UnFVZThE?=
 =?utf-8?B?dmUwV1NmajNDQmtuMjNDMkZGTVFjMzh2bC92cHhpOFJWd1dzZ3o5V3pMT04z?=
 =?utf-8?B?bzk1SkJrTjB3K1YwSytVLzd3U1NzWEhaWnJjMlR5QkxabS9hNHJGZDJNQ3h2?=
 =?utf-8?B?YjVWZnBZOXRrT2N5VVZpd09EUG9VdWs3NHRremFMRzNwd3NnclN3aWN0QWlF?=
 =?utf-8?B?aHZ3aGdTK2ptT0tiV0JYbWNoSVNMZTNEaHhDYlZEaE0rK3pMK3FYZ3RDd1k3?=
 =?utf-8?B?WjRKSVVTdjZQckZ4SFJIZmM3VVE3ajRWc1ZzV1J2WnpGV1ZSSEwvcldxU0xr?=
 =?utf-8?B?K2VJTEFFRDFtVDQ1ZHZiWldLZE0xbC9ld2RmS2ZOMlAxMThWZmIwRG9ZYVkr?=
 =?utf-8?Q?oxfvBZMA7QAYOuy/PFZaeaoFMGlcelHfTJhVpucj7oHH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A03B10B1749CA043846136F960BE5885@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b6e9e3-4e5f-478d-c061-08da66868f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 17:22:14.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKzp2OqtgjFw806j+0HQgoSmBwZyTAj8mhh3TdPsWwjBrw3YWhG/OkF+wCei5Ri1Bz8GHZDf9bXdc6rK1ZDprg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4705
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_09:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150077
X-Proofpoint-GUID: 21-XbsmWHQaGfosWux4vyO9yol93jmU6
X-Proofpoint-ORIG-GUID: 21-XbsmWHQaGfosWux4vyO9yol93jmU6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gT24gSnVsIDE1LCAyMDIyLCBhdCAxOjQ2IEFNLCBTaGluaWNoaXJvIEthd2FzYWtpIDxz
aGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+IHdyb3RlOg0KPiANCj4gT24gSnVsIDE0LCAyMDIy
IC8gMTY6MjUsIEFsYW4gQWRhbXNvbiB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gSnVsIDYsIDIw
MjIsIGF0IDg6NTggQU0sIEFsYW4gQWRhbXNvbiA8YWxhbi5hZGFtc29uQG9yYWNsZS5jb20+IHdy
b3RlOg0KPj4+IA0KPj4+IA0KPj4+IA0KPj4+PiBPbiBKdWwgNSwgMjAyMiwgYXQgNToxOCBQTSwg
Q2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWFrQG52aWRpYS5jb20+IHdyb3RlOg0KPj4+PiAN
Cj4+Pj4gT24gNy81LzIyIDEzOjU2LCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+Pj4+PiBUaGlzIGFs
bG93cyB0byBjb25uZWN0IHRvIHBhc3N0aHJ1IHRhcmdldHMgd2hlbiB0aGUgY2xpZW50IGFuZCB0
YXJnZXQNCj4+Pj4+IGFyZSBvbiB0aGUgc2FtZSBob3N0Lg0KPj4+Pj4gDQo+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBBbGFuIEFkYW1zb24gPGFsYW4uYWRhbXNvbkBvcmFjbGUuY29tPg0KPj4+Pj4gLS0t
DQo+Pj4+PiB0ZXN0cy9udm1lL3JjIHwgMyArKysNCj4+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKykNCj4+Pj4+IA0KPj4+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL252bWUvcmMgYi90
ZXN0cy9udm1lL3JjDQo+Pj4+PiBpbmRleCA0YmViYmM3NjJjYmIuLjVlNTBlNjlmYjNmMCAxMDA2
NDQNCj4+Pj4+IC0tLSBhL3Rlc3RzL252bWUvcmMNCj4+Pj4+ICsrKyBiL3Rlc3RzL252bWUvcmMN
Cj4+Pj4+IEBAIC0zMDMsNiArMzAzLDkgQEAgX2NyZWF0ZV9udm1ldF9wYXNzdGhydSgpIHsNCj4+
Pj4+IA0KPj4+Pj4gCV90ZXN0X2Rldl9udm1lX2N0cmwgPiAiJHtwYXNzdGhydV9wYXRofS9kZXZp
Y2VfcGF0aCINCj4+Pj4+IAllY2hvIDEgPiAiJHtwYXNzdGhydV9wYXRofS9lbmFibGUiDQo+Pj4+
PiArCWlmIFsgLWYgIiR7cGFzc3RocnVfcGF0aH0vY2xlYXJfaWRzIiBdOyB0aGVuDQo+Pj4+PiAr
CQllY2hvIDEgPiAiJHtwYXNzdGhydV9wYXRofS9jbGVhcl9pZHMiDQo+Pj4+PiArCWZpDQo+Pj4+
PiB9DQo+Pj4+PiANCj4+Pj4+IF9yZW1vdmVfbnZtZXRfcGFzc2h0cnUoKSB7DQo+Pj4+IA0KPj4+
PiB3aXRob3V0IGxvb2tpbmcgaW50byB0aGUgY29kZSwganVzdCB3b25kZXJpbmcgd2hldGhlciB3
ZSBuZWVkDQo+Pj4+IGFuIGV4cGxpY2l0IGNoZWNrIHRvIGVuc3VyZSB0aGF0IGJvdGggaG9zdCBh
bmQgdGFyZ2V0IG9uIHRoZQ0KPj4+PiBzYW1lIG1hY2hpbmUgc29tZXRoaW5nIGxpa2UgY2hlY2tp
bmcgbnZtZV90cnR5cGU9bG9vcCA/DQo+Pj4gDQo+Pj4gSWYgbnZtZV90cnR5cGU9bG9vcCwgdGhp
cyBjb2RlIGlzbuKAmXQgbmVjZXNzYXJ5IGJlY2F1c2UgbG9vcCBkZWZhdWx0cw0KPj4+IHRvIGNs
ZWFyX2lkcywgYnV0IGl0IGlzIG5lY2Vzc2FyeSBmb3IgdGNwIGFuZCByZG1hLiAgVGhlIGNoZWNr
IGlzDQo+Pj4gZm9yIG5lY2Vzc2FyeSB3aGVuIHJ1bm5pbmcgYSBwcmUgNS4xOSBrZXJuZWwgd2hl
cmUgY2xlYXJfaWRzDQo+Pj4gaXNu4oCZdCBwcmVzZW50IGp1c3QgdG8gcHJldmVudCBhIGVycm9y
IG1lc3NhZ2UuDQo+Pj4gDQo+Pj4gQWxhbg0KPj4gDQo+PiBBbnkgb3RoZXIgY29tbWVudHMgb3Ig
ZmVlZGJhY2s/DQo+IA0KPiBJJ3ZlIGFwcGxpZWQgdGhlIHBhdGNoIHdpdGggYW4gZWRpdCB0byBy
ZXBsYWNlIHNpbmdsZSBicmFja2V0IHRvIGRvdWJsZQ0KPiBicmFja2V0cy4gV2lzaCB0aGlzIGVk
aXQgaXMgb2sgZm9yIHlvdS4gVGhhbmtzIQ0KTG9va3MgZ29vZC4NCg0KVGhhbmtzIQ0KDQpBbGFu
DQoNCg0KPiANCj4gLS0gDQo+IFNoaW4naWNoaXJvIEthd2FzYWtpDQoNCg==
