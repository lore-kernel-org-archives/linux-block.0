Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1404C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D922082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UKrluqjM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ASoZvqJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D922082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbeLDSUp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:20:45 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50836 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbeLDSUo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 13:20:44 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB4IGsgr017757;
        Tue, 4 Dec 2018 10:20:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UHttHisSQm+ffl490L8uZLhedLUlWpo9RO557fCP+7s=;
 b=UKrluqjMv0rmy6VSQxV2dBfMsqP57exgX5lAf1fr/IQfLeJd1f9PmxdJxnTmCYIctgad
 yxuvVvg/yZkSuG2/NxUl5rx7uBkQfHowRJjdp45LocxmPaMy6OEtGyAqE/xeV7ZXTAEp
 PK++xf1x1JYkTvoxz16jrWKwrTqHeGTjerQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p5x5h06ad-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 04 Dec 2018 10:20:19 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 4 Dec 2018 10:19:54 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 4 Dec 2018 10:19:54 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 4 Dec 2018 10:19:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHttHisSQm+ffl490L8uZLhedLUlWpo9RO557fCP+7s=;
 b=ASoZvqJfE6/CmP+bGKCTLoPAchePDSMeDXpLFRcgocir2lo5rTCdXHsAWpDAROE8kjDm3ROyvlByUEaI+qie7TwG8v8dF+Dw30BLpMMjcyhh9okDNDxxIa95oVpmS3o/wRFylTSlTxhDJS3Q/bDv/PYNQxVC3My6S75se5bOiQ4=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.161.20) by
 CY4PR15MB1591.namprd15.prod.outlook.com (10.172.162.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 18:19:53 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::6c4b:dae9:81dc:f850]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::6c4b:dae9:81dc:f850%7]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 18:19:53 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC:     Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 06/13] nvme-pci: refactor nvme_disable_io_queues
Thread-Topic: [PATCH 06/13] nvme-pci: refactor nvme_disable_io_queues
Thread-Index: AQHUil7J1dGfgosf20CKH6JuL4neHKVtxOWAgADr5YCAADZdgA==
Date:   Tue, 4 Dec 2018 18:19:53 +0000
Message-ID: <0a96d78e-91c6-8367-e50d-35c239111a79@fb.com>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-7-hch@lst.de>
 <0997230c-a13e-65ea-130a-cca366336989@grimberg.me>
 <20181204150517.GC3630@lst.de>
In-Reply-To: <20181204150517.GC3630@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:4:16::13) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fe::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.160.245.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1591;20:VVRy9esyoMyb/LYgvh9B/lNVwsAZm8OHukxZdwM6nImgrYH1jpQu2PW44dirDtt+f/iR2qBXElvDzg0BJW7m+M4Z2poD5jRyl/2gBQzwyE1j7h3Udt4lZlCh+bbUUXd03Z8UXTUuWE6XGu/ZM3dKvQCDX04xY2rpyz6fdwe6NsQ=
x-ms-office365-filtering-correlation-id: 4a6ef861-3f24-4a55-d296-08d65a151613
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1591;
x-ms-traffictypediagnostic: CY4PR15MB1591:
x-microsoft-antispam-prvs: <CY4PR15MB1591AF6CFCE57AF070157CB3C0AF0@CY4PR15MB1591.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231455)(999002)(11241501185)(944501493)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1591;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1591;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(7736002)(478600001)(31686004)(305945005)(105586002)(31696002)(229853002)(446003)(2616005)(476003)(486006)(6486002)(11346002)(97736004)(25786009)(6116002)(3846002)(66066001)(14454004)(6436002)(2906002)(5660300001)(4326008)(110136005)(316002)(186003)(52116002)(106356001)(8676002)(14444005)(99286004)(81166006)(81156014)(6512007)(36756003)(86362001)(71200400001)(68736007)(71190400001)(93886005)(6506007)(386003)(53546011)(76176011)(256004)(102836004)(54906003)(26005)(53936002)(6246003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1591;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZP1e/DQI3xToCEose+Gt7w3KgBu+9SCNrksTNjp0ADmWEQ78Om246YuktZbfo5i9rkB/6d2/pPt0GXAOk4bHBu6RVO4qeN5eYVDiAQnky2pgRo8o+Zr8/urHmET/Vye7PnGzf38c6tOviOA+ifCWneQ5lA9jNqf6qYLYwVPzp0jDUgI+cYdvMC//RvEsGcmEfOxbQd/3oVqzerJw3oNJT7CwhL2H0GOQKLxetL7uI4pUPd752jEZJNU+vBi37rMU/sQB1lhNnlLqCqvmAM1rbuA6Xen/m+bz8GVWmarVAo6DJC6605cGXbjF8nb+rUmSVNpXMJlLvslQb3N4UtDY3DMfjZmHl1+TMy9t7LRGh2I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6DD57BB478F5744BF6555BD4582DA69@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6ef861-3f24-4a55-d296-08d65a151613
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 18:19:53.3737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1591
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTIvNC8xOCA4OjA1IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gTW9uLCBE
ZWMgMDMsIDIwMTggYXQgMDU6MDA6NTlQTSAtMDgwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4+
DQo+Pj4gQEAgLTI0MjgsNyArMjQyNiw4IEBAIHN0YXRpYyB2b2lkIG52bWVfZGV2X2Rpc2FibGUo
c3RydWN0IG52bWVfZGV2ICpkZXYsIGJvb2wgc2h1dGRvd24pDQo+Pj4gICAJbnZtZV9zdG9wX3F1
ZXVlcygmZGV2LT5jdHJsKTsNCj4+PiAgICAgCWlmICghZGVhZCAmJiBkZXYtPmN0cmwucXVldWVf
Y291bnQgPiAwKSB7DQo+Pj4gLQkJbnZtZV9kaXNhYmxlX2lvX3F1ZXVlcyhkZXYpOw0KPj4+ICsJ
CWlmIChudm1lX2Rpc2FibGVfaW9fcXVldWVzKGRldiwgbnZtZV9hZG1pbl9kZWxldGVfc3EpKQ0K
Pj4+ICsJCQkNCj4+DQo+PiBXb3VsZCBiZSBuaWNlIGlmIHRoZSBvcGNvZGUgY2hhbmdlIHdvdWxk
IGJlIGtlcHQgaW5zaWRlIGJ1dCBzdGlsbA0KPj4gc3BsaXQgbGlrZToNCj4gDQo+IEkgYWN0dWFs
bHkgbGlrZSBub3QgaGF2aW5nIGFub3RoZXIgd3JhcHBlciB0byBzdG9wIHRocm91Z2guLg0KPiAN
Cj4gS2VpdGgsIEplbnMsIGFueSBwcmVmZXJlbmNlPw0KDQpGaW5lIGVpdGhlciB3YXksIHByZWZl
ciBub3QgaGF2aW5nIGEgd3JhcHBlci4NCg0KLS0gDQpKZW5zIEF4Ym9lDQoNCg==
