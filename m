Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C76C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCBA2082E
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j6AL8b/5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YJ2lXMjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfDDPbZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:31:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726942AbfDDPbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Apr 2019 11:31:25 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34FK3ts002867;
        Thu, 4 Apr 2019 08:31:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=QF7he8Tpy49vo8T39w10wUHMFIQN+MnF6LcYJ09W7kg=;
 b=j6AL8b/5daGksb94jj4KWkh9+xUMVCaD+qBPe80ye8rfAnfmobM4tuHFv53g7TqUPTUn
 nZ8+ZjmyWe3vrwn1HcmelPgZd+WKnhI6M4L2BWacslg/MZtBDzeO5Ga0C8Gb8Nj6eRp2
 703EPeDiLh2A3MXeVZM+tGL0XFjepYVWeBY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rnmay82y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Apr 2019 08:31:17 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 4 Apr 2019 08:31:16 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 4 Apr 2019 08:31:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF7he8Tpy49vo8T39w10wUHMFIQN+MnF6LcYJ09W7kg=;
 b=YJ2lXMjW7bmZ2ONEg3jy8JrQQ4l1GVgR7m6oY1XLDbYPsjik9aURREPEzCjNdbxRPAcGSM95J3NeLILDBZXbzAru43jCHdNJIlEG18g5GrnWIrlE9L6MbV8KFh4Iw8UxIwje1EsBQam7nS1qEQmem2RmoX7i+PZWlcmYCmwkWp8=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.159.10) by
 CY4PR15MB1255.namprd15.prod.outlook.com (10.172.175.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 4 Apr 2019 15:31:15 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::71d3:9510:2e64:f39a]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::71d3:9510:2e64:f39a%7]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 15:31:15 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
CC:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        "Linux FSDEVEL Mailinglist" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] block: bio: ensure newly added bio flags don't override
 BVEC_POOL_IDX
Thread-Topic: [PATCH] block: bio: ensure newly added bio flags don't override
 BVEC_POOL_IDX
Thread-Index: AQHU6f3Spwfxtyj7Y0+/vg5lyZIb4qYsIuIA
Date:   Thu, 4 Apr 2019 15:31:15 +0000
Message-ID: <4ceb2391-dfd7-bfe8-5202-78db2f6ebabb@fb.com>
References: <20190403091519.13376-1-jthumshirn@suse.de>
In-Reply-To: <20190403091519.13376-1-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::36) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fa::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [192.40.64.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb236046-b2ad-46e2-0c22-08d6b912931e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR15MB1255;
x-ms-traffictypediagnostic: CY4PR15MB1255:
x-microsoft-antispam-prvs: <CY4PR15MB12550CBB22CCF18A49F02409C0500@CY4PR15MB1255.namprd15.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(54906003)(99286004)(106356001)(105586002)(31686004)(316002)(25786009)(229853002)(478600001)(6116002)(3846002)(6486002)(14454004)(97736004)(256004)(8676002)(476003)(2616005)(2906002)(66066001)(486006)(68736007)(81166006)(81156014)(11346002)(6436002)(8936002)(446003)(7736002)(4326008)(102836004)(4744005)(386003)(53546011)(6506007)(305945005)(52116002)(76176011)(6512007)(86362001)(6246003)(36756003)(5660300002)(6916009)(53936002)(186003)(71200400001)(31696002)(26005)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1255;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: APLH4ACqOs2kDFMSQdWmRGRZVPkbODAJpn5NBZBHoq08irYFSQZY7ZzenrRCNDbyIE/evD+wsYsQh1CQIEVExvxXIZoJ+eNQoSvEztOSv+XZcRiaoyoxRZ5xHuss7EqP8b4rZW2zXFYUxGA7yQg3lF0qIWDCkuj9iyUzWUI09YrDUkVedAE8V8FncIsOrHG7mn9B7PbQ3cj8TWHmZAz9e55EtEX0AJIWrVpZrMzdOq5LkwhX8a7rdPLUYOsPv0+IY/Sug5SEroU/HpM+1C3gUyrzigc4CVC/LIjD+eEutD23SPQTl4qKd1LJyZUCS82JiR9QqAL20FxIo6QR8NRleTU6/DTvCeGckcfOlq1hawdM63GmTJxfX8KqK0qqDMIBvEF7/nWZX3I6ds28aUoDZawyY1+/nJDn7rRz4CxnKu8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F26CBE0FCFCFEC43B45A8C61BAA08559@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb236046-b2ad-46e2-0c22-08d6b912931e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 15:31:15.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1255
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8zLzE5IDM6MTUgQU0sIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gV2l0aCB0aGUg
aW50cm9kdWN0aW9uIG9mIEJJT19OT19QQUdFX1JFRiB3ZSd2ZSB1c2VkIHVwIGFsbCBhdmFpbGFi
bGUgYml0cw0KPiBpbiBiaW86OmJpX2ZsYWdzLg0KPiANCj4gQ29udmVydCB0aGUgZGVmaW5lcyBv
ZiB0aGUgZmxhZ3MgdG8gYW4gZW51bSBhbmQgYWRkIGEgQlVJTERfQlVHX09OKCkgY2FsbA0KPiB0
byBtYWtlIHN1cmUgbm8tb25lIGFkZHMgYSBuZXcgb25lIGFuZCB0aHVzIG92ZXJyaWRlcyB0aGUg
QlZFQ19QT09MX0lEWA0KPiBjYXVzaW5nIGNyYXNoZXMuDQoNCkFwcGxpZWQgZm9yIDUuMiwgdGhh
bmtzLg0KDQotLSANCkplbnMgQXhib2UNCg0K
