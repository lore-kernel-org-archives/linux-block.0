Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC7FC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A722081B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YZyFkIQE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jq0A35sK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A722081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbeLDSUt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:20:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60157 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbeLDSUt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 13:20:49 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB4IHZUm032657;
        Tue, 4 Dec 2018 10:19:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HKFAyfsCzgzmxTAFaBskK7kaLY7f6tvw+V+5Zt2FaJw=;
 b=YZyFkIQEt/tw3Lj9rtmDIZYxiHlnbta8HTHWFpUOG9ULj3Vfz4iCtUDCarX7Ij2BKCBJ
 TC1zzVbwD5jsz5MqJ4V9LcoEol8+ozw+b+ldDWAUMEmckD2g7yFbBMqSmuwO6vovQnnk
 FHaeaojHOT041NNPwdgEj/CS7KtTna44PjE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p5u8t0sxt-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 04 Dec 2018 10:19:25 -0800
Received: from frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 4 Dec 2018 10:19:23 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 4 Dec 2018 10:19:23 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 4 Dec 2018 10:19:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKFAyfsCzgzmxTAFaBskK7kaLY7f6tvw+V+5Zt2FaJw=;
 b=jq0A35sKD9lVUVfI46eljD0cM2Ylpr72n6dnxxfNFmSd0aNk9RndBFgkeDJwmqzByNaygFV9F0I0KNPg3bNlaY+a+awoMzZx/NvdWC5Ay8sFZJdDLcsnLm3qbX5DlLl82J5whxpa+WNZjaRgkYbQBthEe5quZBdHkKEmjNV22zk=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.161.20) by
 CY4PR15MB1591.namprd15.prod.outlook.com (10.172.162.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 18:19:20 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::6c4b:dae9:81dc:f850]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::6c4b:dae9:81dc:f850%7]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 18:19:20 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 05/13] nvme-pci: consolidate code for polling
 non-dedicated queues
Thread-Topic: [PATCH 05/13] nvme-pci: consolidate code for polling
 non-dedicated queues
Thread-Index: AQHUil7L31c4806+Mk+IItYwc91qJqVtxC6AgADse4CAACQJAIAAEkyA
Date:   Tue, 4 Dec 2018 18:19:20 +0000
Message-ID: <275863f0-bb1f-8939-f6ba-6059b463d10a@fb.com>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-6-hch@lst.de>
 <9abd8fde-58c4-0704-1e42-d066b674bb90@grimberg.me>
 <20181204150449.GB3630@lst.de>
 <687e3fd9-fe73-5205-5656-d4861d7dd274@grimberg.me>
In-Reply-To: <687e3fd9-fe73-5205-5656-d4861d7dd274@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR2001CA0007.namprd20.prod.outlook.com
 (2603:10b6:4:16::17) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fe::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.160.245.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1591;20:nc3tE4g9IkRLnKB4a5I5bM+KpFYoiZ8FuQh0dki/Kjigg6FuWqON/SR3AQ/umFHrT8M8rl5pguVKFl/cJuljDzaXPp7iZrtydgL5gMoO/XRPX2X/lTZiVKQ5/+ahbDCuDDyz5z/MoEsFgCk6Bz9FsRPgFMv4bciQ9UziEWnayOY=
x-ms-office365-filtering-correlation-id: 8d7b4e21-668e-42bb-0c2c-08d65a150251
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1591;
x-ms-traffictypediagnostic: CY4PR15MB1591:
x-microsoft-antispam-prvs: <CY4PR15MB1591C42E26967B6E14336B5EC0AF0@CY4PR15MB1591.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231455)(999002)(11241501185)(944501493)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1591;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1591;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(7736002)(478600001)(31686004)(305945005)(105586002)(31696002)(229853002)(446003)(2616005)(476003)(486006)(6486002)(11346002)(97736004)(25786009)(6116002)(3846002)(66066001)(14454004)(6436002)(2906002)(5660300001)(4326008)(110136005)(316002)(186003)(52116002)(106356001)(8676002)(14444005)(99286004)(81166006)(81156014)(6512007)(36756003)(86362001)(71200400001)(68736007)(71190400001)(93886005)(6506007)(386003)(53546011)(76176011)(256004)(102836004)(54906003)(26005)(53936002)(6246003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1591;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yUsIUTuixhn7b82DnQB9vF3ERos57H9aSMpcLxlcTkzf9Fh+WeTq0L7ntDV7BZEejTZV+LJcTqa4lxdG38nLxcskGmHE01l82MCzDaOKGqeFXFvtTyNre7lmSkFinIgsK6b+7nMNmGTN+iB7Lt7zA/Ypl1Nwvk2wD3hORUTMDx5kX3P68jd3oG8s4uVIBUKuV1hUKXdQgIG0rmGJy6QMm8n0XVXfCT9ZfZz8SRhko4KnnRu74lZ6+VqPHVbO2SpDgPkFOoJ9TyIaGFh0X9efDPqKFBpfPUmKHnoP0esBZI+F1mEWaRFn751wLw2uo9Hj1GOM5LTy+aCMyO436tv8hR8p5kNh346acoAl3aT+EME=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DC9D41E43A8334F8C76F686C10978E7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7b4e21-668e-42bb-0c2c-08d65a150251
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 18:19:20.5698
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

T24gMTIvNC8xOCAxMDoxMyBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gDQo+Pj4+ICtzdGF0
aWMgaW50IG52bWVfcG9sbF9pcnFkaXNhYmxlKHN0cnVjdCBudm1lX3F1ZXVlICpudm1lcSwgdW5z
aWduZWQgaW50IHRhZykNCj4+Pg0KPj4+IERvIHdlIHN0aWxsIG5lZWQgdG8gY2FycnkgdGhlIHRh
ZyBhcm91bmQ/DQo+Pg0KPj4gWWVzLCB0aGUgdGltZW91dCBoYW5kbGVyIHBvbGxzIGZvciBhIHNw
ZWNpZmljIHRhZy4NCj4gDQo+IERvZXMgaXQgaGF2ZSB0bz8gdGhlIGRvY3VtZW50YXRpb24gc3Vn
Z2VzdHMgdGhhdCB3ZSBtaXNzZWQNCj4gYW4gaW50ZXJydXB0LCBzbyBpdCBpcyBwcm9iYWJseSB3
YWl0aW5nIG9uIHRoZSBjb21wbGV0aW9uIHF1ZXVlLg0KPiANCj4gSSdkIHNheSB0aGF0IGl0J2Qg
YmUgYmV0dGVyIGlmIHRoZSB0YWcgc2VhcmNoIHdvdWxkIGJlIGltcGxlbWVudGVkDQo+IG9uIHRo
ZSB0aW1lb3V0IGhhbmRsZXIgYWxvbmUgc28gd2UgZG9uJ3QgaGF2ZSB0byBwYXNzIHRoZSB0YWcg
YXJvdW5kDQo+IGZvciBldmVyeW9uZS4uLiBUaG91Z2h0cz8NCg0KV2l0aG91dCB0aGF0IHlvdSBk
b24ndCBrbm93IGlmIHRoYXQncyB0aGUgcmVxdWVzdCB0aGF0IGNvbXBsZXRlZC4gWW91DQpoYXZl
IHRvIGJlIGFibGUgdG8gbG9vayB0aGF0IHVwIGZyb20gdGhlIHRpbWVvdXQgaGFuZGxlci4NCg0K
LS0gDQpKZW5zIEF4Ym9lDQoNCg==
