Return-Path: <SRS0=Jk+C=3L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719A9C2D0DB
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 17:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2890524656
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 17:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BLxkJdDn";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CKw+N1XC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVReb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:34:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgAVReb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jan 2020 12:34:31 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MHT3Rv024470;
        Wed, 22 Jan 2020 09:34:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9ikigDQWioGUMN9jy0X/P0bJBgPbp4gwfzlBdNffQL0=;
 b=BLxkJdDnnJiVIXZXKVGSIW2aXQqs9TJT2VetsHLZylpkzX/JR+l7eRwvpjZwuCC7rUr+
 OxptBqKW18CFJeM2hl065xJQ/CuAAaDMQTFB3g5J2S/6ILg1taK7TYHoHVosyzJW/4jg
 QfayCqQkoD6C7ih9TgkhhZDiq7L5UdjUTJY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xp72pcv8d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Jan 2020 09:34:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Jan 2020 09:34:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkfu4Sf1AfGel0T8on27nNBIbssF8OEIEDS/eGBWQC+G0oYLcx5b4GcWiJ3D9Re0/xrSu64nVAoTFuBZpdE/5XvHkuLbnBDHeloUUalLKlUtnBCGa8/Uil9aq3fxmW4L2bQFRws+MWfHv4v/4WW96F1P1JfdbsLmSkUodZQiPJrjnZULE9cRCWiiIK8t8k/HV/njFmdru0HgmkOun3B/gqRHSzN8nmhTNkXpVwiFj689wrizEYNCLQZjFrfiDvXtJm4nPhOvJPpFl/sdf+27wlSGisIsQ4Z8uAU1oeRooY+6WW3XJ4H3Wmwp8NFRfkXBuAs6OLsOHY/qcmg8vs2W4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ikigDQWioGUMN9jy0X/P0bJBgPbp4gwfzlBdNffQL0=;
 b=gCb1seWpwRgC1kcxMoSdatEd9nBJPH6Iu5DCS5s4KBTdYpicTcHAZunz0hdEVkby+QJ+v256S7r6hOJXQlz2iNpwVlBzAeSfh8B7z3QQCC+iWBvg8rAyoE2EfHEyn8CfYoum+el1OFRsNcT0esdw5tF8tOybO71b1sJdnZ0mWx+vgcpmJ0HhbYg36yx+EZRSyVMX56gXUU17VdDwhXbrTezHtwULeCwPgFokMA8oq5eVndCSUaUOhJEi485sKAYlYcPNaHY2KnjM7cvQKcVJCAlhWAw7QhKnN8GL+2sQesVuk305g6TDIWn4Jx4Ri7fIjzbNkhmhwXXDNtiFBbIjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ikigDQWioGUMN9jy0X/P0bJBgPbp4gwfzlBdNffQL0=;
 b=CKw+N1XC13D21AX0VuSUR2pknNKdFDpg/8c3I1xqriC+OCDcM/Gl+cApMTf4MARHjjsBsWvVhqJTylFD5Te79E4yDH6v0SIkOafAelG8ybHcbFBEqR7yF3390fFOL+kAiWMAeSD1yxlaLX2ed5hH5oCcI+eo0xj76imUEW6v7V4=
Received: from DM6PR15MB2796.namprd15.prod.outlook.com (20.179.160.22) by
 DM6PR15MB3449.namprd15.prod.outlook.com (20.179.51.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 17:34:21 +0000
Received: from DM6PR15MB2796.namprd15.prod.outlook.com
 ([fe80::98e8:d7ac:731d:43e]) by DM6PR15MB2796.namprd15.prod.outlook.com
 ([fe80::98e8:d7ac:731d:43e%5]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 17:34:21 +0000
Received: from [192.168.1.159] (65.144.74.34) by CH2PR19CA0002.namprd19.prod.outlook.com (2603:10b6:610:4d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend Transport; Wed, 22 Jan 2020 17:34:20 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Wen Yang <wenyang@linux.alibaba.com>,
        Paolo Valente <paolo.valente@linaro.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block, bfq: improve arithmetic division in bfq_delta()
Thread-Topic: [PATCH] block, bfq: improve arithmetic division in bfq_delta()
Thread-Index: AQHVz3kZJxAcCxE2OkKIbzF0Rq3PFaf29WYA
Date:   Wed, 22 Jan 2020 17:34:21 +0000
Message-ID: <b5d9c9a6-2678-6256-0e21-ec88dfc115b3@fb.com>
References: <20200120100443.45563-1-wenyang@linux.alibaba.com>
In-Reply-To: <20200120100443.45563-1-wenyang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:610:4d::12) To DM6PR15MB2796.namprd15.prod.outlook.com
 (2603:10b6:5:1a0::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.144.74.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89cc3572-bc43-4834-818c-08d79f61509a
x-ms-traffictypediagnostic: DM6PR15MB3449:
x-microsoft-antispam-prvs: <DM6PR15MB3449FB59EDEF3318F8D63218C00C0@DM6PR15MB3449.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(31686004)(8676002)(6486002)(186003)(81156014)(8936002)(81166006)(66556008)(66476007)(66446008)(86362001)(52116002)(64756008)(36756003)(66946007)(31696002)(71200400001)(498600001)(2616005)(4326008)(16526019)(5660300002)(26005)(558084003)(53546011)(956004)(54906003)(2906002)(16576012)(110136005)(25903002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3449;H:DM6PR15MB2796.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iwjIbuAlt4Wuhcb9Zh1OrSOXDtdnGlzD1Q0V1HJmuv8k8Ej582uUHFY3KPi5JijoUwdkQS8FeSo4pGtbTksc2cGWUmplWSEpPIQIpKe7sRwMn1IXUbK3Ihsj6DpWdsEi7mNFG/ibTSxyRl66a7b+cWw3V1M7DwBXF9oYdQ8Llip7gkrLKiNEKA8hmzQuAZdjRhMeNfXKRkPjdQ6Zc6+V9mNTJ+ghPQJuA2DiTns3bGTsgUSo4cd8satyyH4hvBhIzhIKz+eNAvKtXbXdTjOwUzvLen5V6HudNnk1zaIUMHqqta+FGBGZRoLtBNJnz3HZJWihFsNDIEwOLIGCQxQtgIbQCX0K5zNnHWjzMraqpL5ZoL9Gq+mND5WoCh+RLa7o01KPUUrdgy77QPFCdHYsRHy8xAA4aV4abLp+exlUConul0LjTyf1NteJmEPLIS5G3EkCGdbk/TTackbm5RFZoZYZZnVrbLCe4YpTKMWbEDzQDUMtaBFwnH3R7RRVCBcd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <149C30DBD6B5F0478C86BF0A04FBCC8A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cc3572-bc43-4834-818c-08d79f61509a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 17:34:21.2129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCTVjb2NCGPEx49jpQ7TbgtFGHn5BtFXM4FAsiG8NJ6DnnYhk9jPvFdRqwWWtqNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3449
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_07:2020-01-22,2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=728 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220151
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8yMC8yMCAzOjA0IEFNLCBXZW4gWWFuZyB3cm90ZToNCj4gZG9fZGl2KCkgZG9lcyBhIDY0
LWJ5LTMyIGRpdmlzaW9uLiBVc2UgZGl2NjRfdWwoKSBpbnN0ZWFkIG9mIGl0DQo+IGlmIHRoZSBk
aXZpc29yIGlzIHVuc2lnbmVkIGxvbmcsIHRvIGF2b2lkIHRydW5jYXRpb24gdG8gMzItYml0Lg0K
PiBBbmQgYXMgYSBuaWNlIHNpZGUgZWZmZWN0IGFsc28gY2xlYW5zIHVwIHRoZSBmdW5jdGlvbiBh
IGJpdC4NCg0KQXBwbGllZCwgdGhhbmtzLg0KDQotLSANCkplbnMgQXhib2UNCg0K
