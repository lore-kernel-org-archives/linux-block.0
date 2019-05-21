Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77947C04AAC
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 01:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AFC2173C
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 01:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="doVMLT9s";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="afI67z5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfEUBKI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 21:10:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44080 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbfEUBKI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 21:10:08 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L0sJ3K004546;
        Mon, 20 May 2019 18:09:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nQCtXFMuuE6mbgcqA+p8t5feE9gTGQdhgGvdWXvooyQ=;
 b=doVMLT9sNs9/7mtF4QkXLzOLwKycTgiFF33Qc1RZd6py45YlKwjsjXylFTKjNmpuE2GT
 Oh5Od/zndGXsKVKTn7bR8VmSmX8cGa0X/k57/H0d0VFaOuouHXPFbpCghhTr8jwQs04O
 9kk3jSvUh2RTejU21+5VvxJab8ecYubsDb8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sm0ahsh6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 18:09:43 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 20 May 2019 18:09:42 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 20 May 2019 18:09:42 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 20 May 2019 18:09:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQCtXFMuuE6mbgcqA+p8t5feE9gTGQdhgGvdWXvooyQ=;
 b=afI67z5LjWV+0Sc+qKmjxytyq6Pgor3oSWvLnhslBhwvh3L1XkuDH5oNu1EwxrI0GwlF9+hbm6Pfbm/zuwTQGRgWVqqzhiJjYxRXfKnNvGqZ3tPhJIgKld99JYR2OX6gHY9p5kpEHXD6e3QPy2+BkB5Hu0XXMMaaV+kr6wI4QeI=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.159.10) by
 CY4PR15MB1383.namprd15.prod.outlook.com (10.172.159.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Tue, 21 May 2019 01:09:40 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::cd40:b055:15a6:ef02]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::cd40:b055:15a6:ef02%9]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 01:09:40 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: fix nr_phys_segments vs iterators accounting v2
Thread-Topic: fix nr_phys_segments vs iterators accounting v2
Thread-Index: AQHVC8M9Ry/R4fzmT0eiqmVDP6gbO6Zz46AAgADojwA=
Date:   Tue, 21 May 2019 01:09:39 +0000
Message-ID: <8ccb3744-53e3-71b0-cdec-6f703b2bd5c8@fb.com>
References: <20190516084058.20678-1-hch@lst.de> <20190520111714.GA5369@lst.de>
In-Reply-To: <20190520111714.GA5369@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fa::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2600:380:b47a:98dd:4c8d:4b8b:78f8:398f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d41f692b-7b7b-473a-cc0c-08d6dd88ffb9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR15MB1383;
x-ms-traffictypediagnostic: CY4PR15MB1383:
x-microsoft-antispam-prvs: <CY4PR15MB1383DD6C5A2D92BE3F019FDBC0070@CY4PR15MB1383.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(6246003)(99286004)(54906003)(6916009)(8936002)(186003)(476003)(2616005)(86362001)(52116002)(4326008)(14454004)(2906002)(5660300002)(25786009)(6116002)(53936002)(31696002)(478600001)(316002)(76176011)(6436002)(229853002)(71190400001)(66476007)(66556008)(71200400001)(558084003)(386003)(6506007)(53546011)(66446008)(64756008)(256004)(102836004)(66946007)(486006)(15650500001)(6486002)(81156014)(81166006)(8676002)(46003)(7736002)(6512007)(305945005)(31686004)(73956011)(68736007)(446003)(11346002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1383;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qB+C7YFlMWPo3lO33h3nA00dBPLrOXnnW/4PDymUrLkRgR9CaKJlu71EmF8OcVNVJ25EuFgfeuLoRiGQmOEoxBYqNCwENQoCOxCngDTUcC3gdAWX3OgG0Rxn4j2Z6j6YR9ZFUtUyIZvKZzwdshgVfxPTWcX3NK9+ixF+HB0Narc9qNSmFmknyTFpVuxjxnkLl99f7U5orPpgLLqggro5XUisDYBGVEIlrRmeHzlMSt+/i0QXhep/aKjK3GAsU9ZBAHBzRW1XKqve2uoePu+bxr4kkeS/aH6lIAi/0OpWJ4CwApdQAYilM02QPl/MyCiZ2TmV8rSvaWIHfTyMMLfAugsWhUUJRNqhZFxJctralFavoCeXF37+mxIpCXtzjoMDGcTGq9y6dqbue3LNB7hWAlRMXc/ojqRoRsTVgsHHDnM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <835AB689ED3E1F4E866E7F588C34E8CC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d41f692b-7b7b-473a-cc0c-08d6dd88ffb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 01:09:40.0845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1383
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8yMC8xOSA1OjE3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gSmVucywNCj4g
DQo+IGlzIHRoaXMgb2sgZm9yIDUuMj8gIElmIG5vdCB3ZSBuZWVkIHRvIGhhY2sgYXJvdW5kIHRo
ZSBzZWN0b3INCj4gYWNjb3VudGluZyBpbiBudm1lLCBhbmQgcG9zc2libHkgdmlydGlvLg0KDQpJ
J2QgcmF0aGVyIGRvIGl0IHJpZ2h0IGluIDUuMiwgZXNwZWNpYWxseSBpZiB3ZSBjYW4gZ2V0IHNv
bWV0aGluZw0KYWNjZXB0YWJsZSBjb2JibGVkIHRvZ2V0aGVyIHRoaXMgd2Vlay4NCg0KLS0gDQpK
ZW5zIEF4Ym9lDQoNCg==
