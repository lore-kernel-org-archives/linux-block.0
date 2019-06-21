Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E4BC43613
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 09:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DA621537
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 09:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NAniB6lM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="m7FhTSeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfFUJPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:15:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60282 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbfFUJP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 05:15:29 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5L959OU013692;
        Fri, 21 Jun 2019 02:15:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=flqjpcj4fWLOyAG8SvHboxGOc+E72I/m8STWy4fDd2g=;
 b=NAniB6lMCdtP6q3N5NLBrmVNjQBlWSudza4J8q/W1xR98UxxlB6r8ZMqabmpZeQIK4Sd
 U3AMU8YuoXnm1aEweYh6Qzz15lU/rU4e5gX3se+HQLoaKh20qQXUdgJDQMsVMSUw/UJu
 2n/TkuTrnl8rNkaSyT94ivtJPO4jORSoStU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t8tnk8aph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 02:15:27 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 21 Jun 2019 02:15:23 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 21 Jun 2019 02:15:22 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Jun 2019 02:15:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flqjpcj4fWLOyAG8SvHboxGOc+E72I/m8STWy4fDd2g=;
 b=m7FhTSeHXDSLp7Gn4LZSv/B3sKKXV/Xj7X+cJPxznNxBXUNkKNG0exf6Nhg1KqXvBJjGmACfZ4NTJGz3dF7DHPvkgrFRaXaYgAhFH0Yi6ayNpggG2DRfDOK9FZ39QTg9+X8euNw2QAGkkW9Lsz//YLPEMXdnEKGxUSqWU6iiGMc=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.159.10) by
 CY4PR15MB1814.namprd15.prod.outlook.com (10.172.77.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 09:15:21 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::39f5:87bb:21d:2031]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::39f5:87bb:21d:2031%10]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 09:15:00 +0000
From:   Jens Axboe <axboe@fb.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL 0/2] lightnvm updates for 5.3
Thread-Topic: [GIT PULL 0/2] lightnvm updates for 5.3
Thread-Index: AQHVKBFxHHI1YIZeCES8RExyO+fe0Kal02qA
Date:   Fri, 21 Jun 2019 09:14:59 +0000
Message-ID: <a3ca86b4-42ad-006f-e2f2-6c63049ad5fb@fb.com>
References: <20190621091200.23168-1-mb@lightnvm.io>
In-Reply-To: <20190621091200.23168-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0306.eurprd05.prod.outlook.com
 (2603:10a6:7:93::37) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fa::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.186.115.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccc7b057-747b-44c2-0500-08d6f628ef4f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR15MB1814;
x-ms-traffictypediagnostic: CY4PR15MB1814:
x-microsoft-antispam-prvs: <CY4PR15MB18143FA7969D0EC25984A964C0E70@CY4PR15MB1814.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(366004)(396003)(376002)(199004)(189003)(316002)(99286004)(2616005)(26005)(102836004)(6916009)(5660300002)(52116002)(476003)(76176011)(66066001)(86362001)(31696002)(14454004)(71446004)(53546011)(68736007)(3846002)(11346002)(6116002)(25786009)(386003)(6506007)(36756003)(446003)(6246003)(4326008)(186003)(6512007)(6486002)(2906002)(486006)(6436002)(73956011)(66946007)(66476007)(64756008)(66446008)(66556008)(558084003)(54906003)(8936002)(81156014)(81166006)(8676002)(256004)(31686004)(53936002)(71200400001)(71190400001)(229853002)(7736002)(305945005)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1814;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VmaITFq7xK09b4aHiUx5phubQGtdyoKRW2SMmWB5TdDMhEyi/9yi2hQxEhp1C1udoRgSUTpXlL70Agky7g8weQmJnoTenMQXzpcmnaYPUhRfU+8a7eCAepG24HRnzkgs8eogyz+OMRe8ZXuZJk23HSUXdUS0w/d9cYIS9F1nQ1aI4VcqO9LFxkW3Z76wDYl7TY8wDOpaXopWDn1A2ioExu3P+2r7+R40frqZjlPh/CEztweHw7krZJQ76Lx3snXLcLPZ3Z/mGaNubjHCxTEBrgtBy/DJQ2s+kLnuqItWWdeLbuQsd6+LgWxRFvTsOI/vIVRBGayElEasC47DJp7mQLrWzZcoiNCtAdW65oHQREbLyUQQkocacdhZgcQmpXouPqTjLRLNn+5OrBqPkw99V3tqtpexXfmI3Q4IoZe4jIE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFC8252CF0F4B243AB2D07557DA31C5E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc7b057-747b-44c2-0500-08d6f628ef4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 09:15:00.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axboe@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1814
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=825 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210077
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi8yMS8xOSAzOjExIEFNLCBNYXRpYXMgQmrDuHJsaW5nIHdyb3RlOg0KPiBIaSBKZW5zLA0K
PiANCj4gQSBjb3VwbGUgb2YgcGF0Y2hlcyBmb3IgdGhlIDUuMyB3aW5kb3cuIEdlZXJ0IGZpeGVk
IGFuIHVuaW5pdGlhbGl6ZWQNCj4gcG9pbnRlciBidWcsIGFuZCBIZWluZXIgZml4ZWQgdXAgYSBi
dWcgd2hlbiBtZXJnaW5nIGJpbyBwYWdlcyBpbiBwYmxrLg0KDQpBcHBsaWVkLCB0aGFua3MuDQoN
Ci0tIA0KSmVucyBBeGJvZQ0KDQo=
