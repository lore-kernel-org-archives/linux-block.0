Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23399C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEB22183E
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Oo5Huvxe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Yu5n6uTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfCVPoe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:44:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38340 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbfCVPoe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 11:44:34 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MFXXRc021397;
        Fri, 22 Mar 2019 08:44:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=gbcRzu3il8lkwnpBhtxrKi6joWc8uzj/9c+Wcc+TS3U=;
 b=Oo5HuvxeHOQK3d7zbgJck+ZPYSIYxo3kYAMNJj+ZzQjArSa7XTSXTFz/+C2DR6GXjyg4
 c1kCvqe6dCsyUdVb1HNnxftlTA/Vv3xGCskcsdMmObId9DhVB7jg+hM7vV56faRRicGk
 Tn170VSrcb8wRU3r+fYgwHClbukw2/JX2Lc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rccn3me93-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Mar 2019 08:44:20 -0700
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 22 Mar 2019 08:44:13 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 22 Mar 2019 08:44:12 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Mar 2019 08:44:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbcRzu3il8lkwnpBhtxrKi6joWc8uzj/9c+Wcc+TS3U=;
 b=Yu5n6uTFk48HYzrokVZHYYgfcNNn6v5VfmOgw1rKCs3ktA3KWoHkFO9scPyM0XaZ8LfHPuejPVZE5yhNprFxtfxCMMD0CTRcY6vSZOwUMrPQJxRAZjk3oEryYmZvWk82C1KqKILm5SiG6gE2a3iXUhQt8mmUzK3Yr0bu//BL90M=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.159.10) by
 CY4PR15MB1896.namprd15.prod.outlook.com (10.172.78.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Fri, 22 Mar 2019 15:44:12 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::4119:34fe:7e7c:1919]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::4119:34fe:7e7c:1919%11]) with mapi id 15.20.1709.017; Fri, 22 Mar
 2019 15:44:11 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "Sagi Grimberg" <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC] optimize nvme single segment I/O
Thread-Topic: [RFC] optimize nvme single segment I/O
Thread-Index: AQHU4Dtxc4F5QSUGwkuwUWY0dsUuRaYXy7aA
Date:   Fri, 22 Mar 2019 15:44:11 +0000
Message-ID: <302780ee-8721-2039-63b9-0d64bf3b519b@fb.com>
References: <20190321231037.25104-1-hch@lst.de>
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:3:101::13) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fa::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.160.245.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf321a70-b5f6-470b-a433-08d6aedd3ab4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1896;
x-ms-traffictypediagnostic: CY4PR15MB1896:
x-microsoft-antispam-prvs: <CY4PR15MB18967A99B6E1E5843DB81A65C0430@CY4PR15MB1896.namprd15.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(396003)(376002)(189003)(199004)(53754006)(110136005)(305945005)(26005)(6512007)(71200400001)(71190400001)(97736004)(102836004)(3846002)(68736007)(186003)(256004)(106356001)(7736002)(2906002)(5660300002)(14454004)(6116002)(25786009)(53936002)(81156014)(446003)(229853002)(476003)(81166006)(31696002)(316002)(11346002)(66066001)(4744005)(6486002)(2616005)(31686004)(54906003)(6246003)(76176011)(6506007)(53546011)(478600001)(86362001)(99286004)(8936002)(8676002)(486006)(105586002)(36756003)(52116002)(386003)(4326008)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1896;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YcIWNOG68Dpx///g8Kq8vAQgXFcIMGlGkW8frB5JDQoj1NBNafXMzTB29A08u5FcaKZr1U67JNpHdtI3QqhCwZaTg83tu/ERtbusQqFF0u0r/I6lvwdBqc5E6gcqkDKsV3c0ncaNQq0VlvY8Ejy90Ql3zC+SMExx9KvxshfainxjQDeTzZQtEeGKUNRwoyoYmZpZ+0f02EOmEoQSuj1WoFbDsQh6D5OLDiydYPqzqzUVArudM5ZYlciQD38Kq78GMalaQE8w4PLomdVgL1PohqVqCC5PN9j0tqkrOekEiosZBqnd8usJvaETiOFhMTPkNdFaGqamsrZ69W87yyiLcRCuiGE6cgSwaEWBqac3R//J76h1ACHAmgqIJveqfWChDjy3w7/yWah9p6dwG5WwaN64OdWCbVN1r0VK1bk/Dx4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45DF886C1EC93145A7FA663D3104BF6F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bf321a70-b5f6-470b-a433-08d6aedd3ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:44:11.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1896
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yMS8xOSA1OjEwIFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gSGkgYWxsLA0K
PiANCj4gd2l0aCBhbGwgdGhlIGRpc2N1c3Npb24gb24gc21hbGwgSS9PIHBlcmZvcm1hbmNlIGxh
dGVseSBJIHRob3VnaHQNCj4gaXQgd2FzIHRpbWUgb2ZmIHRvIGR1c3QgbXkgb2xkIGlkZWEgdG8g
b3B0aW1pemUgdGhpcyBwYXRoIGEgYml0DQo+IGJ5IGF2b2lkaW5nIHRvIGJ1aWxkIGEgc2NhdHRl
cmxpc3QuICBJJ3ZlIG9ubHkgZG9uZSB2ZXJ5IGJhc2ljDQo+IHRlc3RpbmcgYmVjYXVzZSBJJ3Zl
IGJlZW4gYSBiaXQgYnVzeSwgYnV0IEkgdGhvdWdodCBpdCBtaWdodCBiZQ0KPiB3b3J0aHdoaWxl
IHRvIGdldCBpdCBvdXQgZm9yIGZlZWRiYWNrLg0KDQpJIHJhbiB0aGlzIHRocm91Z2ggc29tZSBx
dWljayB0ZXN0aW5nLCBhbmQgaXQncyBhIGJpZyB3aW4gZm9yIDRrDQpJT3MgaGVyZS4gQXJvdW5k
IGFuIDglIGltcHJvdmVtZW50IGZvciBjYXNlcyB0aGF0IGFyZSBDUFUgYm91bmQuDQoNCi0tIA0K
SmVucyBBeGJvZQ0KDQo=
