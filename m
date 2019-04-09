Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4955C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 18:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C402133D
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 18:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="E3TvCbzC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="I1oqDOEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfDIS5H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:57:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47910 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726529AbfDIS5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Apr 2019 14:57:07 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39Ikmsv025732;
        Tue, 9 Apr 2019 11:56:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Z9vFFyn/yZ2e15vn0E1YnuvsKhzJFakjY+2fDJzxYus=;
 b=E3TvCbzC3TNy+YqKxWKCutWrEPAY2uBbBLPwkSUnCQsWRkKCbaZgMAnGsfkzRxFtQ79H
 LOCjVBxpC3K+I8U+aAvcyeTC5INe/hHcW+4kOUx/LT//w/3X8gUBQ6tH14HGdJ581eza
 su3+oHIQvBtvgkvmlZ4mzhyUDsmX/MIpahE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rryj6rfvn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 11:56:59 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 11:56:58 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 11:56:58 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Apr 2019 11:56:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9vFFyn/yZ2e15vn0E1YnuvsKhzJFakjY+2fDJzxYus=;
 b=I1oqDOExxIlYNmAdvPXxEia+CSQxOU3oMr3mHGNvoHvi9prztmPTroczIonM3kuTdWlNdaGe7Nhn6Uyk9zkS6uppI/4qXUIi3J5rtTog16wP04NDN1YNcMuNIfGT0+uaCb/QcS6SlO3uO1usFv4mQPJs7Du7UulkN49fYaLcMEE=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.209.148) by
 DM5PR15MB1356.namprd15.prod.outlook.com (10.173.224.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Tue, 9 Apr 2019 18:56:56 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::e828:23d4:87c9:b7f7]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::e828:23d4:87c9:b7f7%5]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 18:56:56 +0000
From:   Chris Mason <clm@fb.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] io_uring: add support for barrier fsync
Thread-Topic: [PATCH] io_uring: add support for barrier fsync
Thread-Index: AQHU7vEvvXtetWT7+EuXEpZlgauUcqY0IygAgAABpACAAAVjgIAAAPOAgAAC+YA=
Date:   Tue, 9 Apr 2019 18:56:56 +0000
Message-ID: <FBAE8433-865B-4D4D-B658-27E234FE829F@fb.com>
References: <7c7276e4-8ffa-495a-6abf-926a58ee899e@kernel.dk>
 <20190409181742.GA24925@infradead.org>
 <5f8d9644-9e8f-c9d2-611e-4b144c62539c@kernel.dk>
 <5BF7FDDE-212E-4F9A-9B50-26BDA99E952A@fb.com>
 <a7f00629-f822-7271-7a4e-ad3b802752e4@kernel.dk>
In-Reply-To: <a7f00629-f822-7271-7a4e-ad3b802752e4@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.4r5594)
x-clientproxiedby: BN4PR10CA0001.namprd10.prod.outlook.com (2603:10b6:403::11)
 To DM5PR15MB1290.namprd15.prod.outlook.com (2603:10b6:3:b3::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:180::2ad7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 805657c3-46f9-40c9-fce2-08d6bd1d236c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1356;
x-ms-traffictypediagnostic: DM5PR15MB1356:
x-microsoft-antispam-prvs: <DM5PR15MB135666F46FA089E797C16766D32D0@DM5PR15MB1356.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(8936002)(6512007)(83716004)(305945005)(71200400001)(71190400001)(76176011)(68736007)(2616005)(7736002)(6246003)(4326008)(446003)(11346002)(486006)(476003)(53936002)(14454004)(52116002)(25786009)(478600001)(6116002)(14444005)(186003)(256004)(6506007)(386003)(53546011)(102836004)(46003)(316002)(99286004)(54906003)(2906002)(50226002)(93886005)(82746002)(86362001)(106356001)(105586002)(6436002)(6486002)(33656002)(5660300002)(81156014)(8676002)(81166006)(229853002)(97736004)(6916009)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1356;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5NYxtHbJAvovG5DALy1pSkek1CqS33ASnGTkzQj690Kp1SyAzzbcbGDJEr9za2yWHs04kZicnKcaLcniSe6Ied6XUKt17GBnNyl2145EIIeP8r1f0w1QIwArTTa2S3lqTc3mQBc39aIXAvspVXohrBSvE5DlozpNDaH8rLGhvYiPKjsh27sONb9LlZyWoKQNtoJX6g4tpJzUBc/C1cNHR0ma0bJp/F4QmzDKHkM+6t7GIP5WRbotwRASf/VlB1MKWSq9VK9U1t41hDyzZXiDhfmlPCkxyALkQUIO33WbIGJsqYJ8Vh8wqpQmEmydwqMh1LaCBc4Zgd8CcK8zPTGBoeLkU4eRORKQZj8ThHExeVZrSu12fm9SVXXkUmm8ZUZcFwU7JhUnKNFvqBd7Gg8uQ+Y6V8FI8kMfo1+Ci1GToDo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 805657c3-46f9-40c9-fce2-08d6bd1d236c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 18:56:56.8122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1356
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOSBBcHIgMjAxOSwgYXQgMTQ6NDYsIEplbnMgQXhib2Ugd3JvdGU6DQoNCj4gT24gNC85LzE5
IDEyOjQyIFBNLCBDaHJpcyBNYXNvbiB3cm90ZToNCg0KPj4gTG9va2luZyBhdCB0aGUgcGF0Y2gs
IHdoeSBpcyBmc3luYyBzcGVjaWFsPyAgU2VlbXMgbGlrZSB5b3UgY291bGQgYWRkDQo+PiB0aGlz
IG9yZGVyaW5nIGJpdCB0byBhbnkgd3JpdGU/DQo+DQo+IEl0J3MgcmVhbGx5IG5vdCwgdGhlIGV4
YWN0IHNhbWUgdGVjaG5pcXVlIGNvdWxkIGJlIHVzZWQgb24gYW55IHR5cGUgb2YNCj4gY29tbWFu
ZCB0byBpbXBseSBvcmRlcmluZy4gTXkgaW5pdGlhbCBpZGVhIHdhcyB0byBoYXZlIGFuIGV4cGxp
Y2l0DQo+IGJhcnJpZXIvb3JkZXJpbmcgY29tbWFuZCwgYnV0IEkgZGlkbid0IHRoaW5rIHRoYXQg
c2VwYXJhdGluZyBpdCBmcm9tIA0KPiBhbg0KPiBhY3R1YWwgY29tbWFuZCB3b3VsZCBiZSBuZWVk
ZWQvdXNlZnVsLg0KDQpNaWdodCB3YW50IHRvIG9yZGVyIGRpc2NhcmRzPyAgQ29tbWl0IGEgdHJh
bnNhY3Rpb24gdG8gZnJlZSBzb21lIGJsb2NrcywgDQpkaXNjYXJkIHRob3NlIGJsb2Nrcz8NCg0K
Pg0KPj4gV2hpbGUgeW91J3JlIGhlcmUsIGRvIHlvdSB3YW50IHRvIGFkZCBhIHdheSB0byBGVUEv
Y2FjaGUgZmx1c2g/DQo+PiBCYXNpY2FsbHkgdGhlIHJlc3Qgb2Ygd2hhdCB1c2VyIGxhbmQgd291
bGQgbmVlZCB0byBtYWtlIHRoZWlyIG93bg0KPj4gd3JpdGUtYmFjay1jYWNoZS1zYWZlIGltcGxl
bWVudGF0aW9uLg0KPg0KPiBGVUEgd291bGQgYmUgYSBXUklURVYvV1JJVEVfRklYRUQgZmxhZywg
dGhhdCBzaG91bGQgYmUgdHJpdmlhbGx5IA0KPiBkb2FibGUuDQo+DQo+IEluIHRlcm1zIG9mIGNh
Y2hlIGZsdXNoLCB0aGF0J3MgdmVyeSBoZWF2eSBoYW5kZWQgKGFuZCBzdG9yYWdlDQo+IG9yaWVu
dGVkKS4gIFdoYXQgYXBwbGljYXRpb25zIHdvdWxkIHdhbnQvbmVlZCB0byBkbyBhbiBleHBsaWNp
dCB3aG9sZQ0KPiBkZXZpY2UgZmx1c2g/DQoNCkJhc2ljYWxseSBpZiBzb21lb25lIGlzIHdyaXRp
bmcgYSB1c2VybGFuZCBmaWxlc3lzdGVtIHRoZXknZCB3YW50IHRvIA0KY2FjaGUgZmx1c2ggZm9y
IHRoZSBzYW1lIHJlYXNvbnMgdGhlIGtlcm5lbCBmaWxlc3lzdGVtcyBkby4NCg0KDQotY2hyaXMN
Cg==
