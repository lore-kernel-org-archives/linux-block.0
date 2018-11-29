Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDDDC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8803821104
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mUtL9+k1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fk2qtxkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8803821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbeK3G5b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:57:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46734 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725788AbeK3G5b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:57:31 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wATJlAZp006249;
        Thu, 29 Nov 2018 11:50:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uFD6DVrCBNL6+ZsYPBg0JmCRVoeXLl+ihJBZ5rNjXrk=;
 b=mUtL9+k1Enyhi2gyNlv0mBjQQKpp2ZSN8dw251xrrt3CdwVfC8B5UzV1IXOCuYExOTfi
 lIOORyO0WMehY8E5DtnqFueEwNkFqIilSV4oLdquO+mvS3diBy/JRpc4i+mrccSIrA/r
 y7zIqq1skqvAUcYhxJatTPvqzS028pR5l2I= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2p2nuur662-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Nov 2018 11:50:27 -0800
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 29 Nov 2018 11:50:26 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 29 Nov 2018 11:50:26 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 29 Nov 2018 11:50:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFD6DVrCBNL6+ZsYPBg0JmCRVoeXLl+ihJBZ5rNjXrk=;
 b=fk2qtxkYZHJl5qlTuixg9cQgJwNBTo5tfSXgzcWENTrPrhiLuybQuKquPTbn0CpFcnsXk7giQ8skIA6B829H+5WoBbyIFttFwTFbhRYS+RBVzF33rqGaQVMahBH/rhr2OLYobTkpueG2NO20MRair9sxHwvufCEfL6Td0n4yeKo=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.161.20) by
 CY4PR15MB1463.namprd15.prod.outlook.com (10.172.161.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Thu, 29 Nov 2018 19:50:09 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::6c4b:dae9:81dc:f850]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::6c4b:dae9:81dc:f850%5]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 19:50:09 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "Sagi Grimberg" <sagi@grimberg.me>
CC:     Max Gurtovoy <maxg@mellanox.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/13] block: move queues types to the block layer
Thread-Topic: [PATCH 01/13] block: move queues types to the block layer
Thread-Index: AQHUiBekNufv0tFZikKkocWWcUPRhaVnKUQA
Date:   Thu, 29 Nov 2018 19:50:09 +0000
Message-ID: <c20e4d66-0fc5-ab65-2805-c4b22012c1c5@fb.com>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
In-Reply-To: <20181129191310.9795-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:4:3b::29) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fe::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.160.245.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1463;20:DZDAf0oWtxuOgmIaGcQYLdYxQpuHp5X6WZKgIJU8OpydKLDSwqo2mG4e+LBZ5Jv6VHUiaOjDQG8kMbySJQeltPFecbWXdBt3DbVa8mmqDBlP+xJO5DC893337wGIL2g/lnDxFxkSDv7j1FpGfeVtUQ5BSFfSnKSorXkGmpdAaRw=
x-ms-office365-filtering-correlation-id: 0055a392-d589-4111-f469-08d65633de24
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1463;
x-ms-traffictypediagnostic: CY4PR15MB1463:
x-microsoft-antispam-prvs: <CY4PR15MB14639C41E1B2808690F9B150C0D20@CY4PR15MB1463.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231453)(999002)(11241501185)(944501449)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1463;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1463;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(68736007)(81166006)(256004)(6436002)(316002)(229853002)(71190400001)(110136005)(71200400001)(54906003)(53936002)(8676002)(81156014)(6512007)(6246003)(4326008)(8936002)(6486002)(102836004)(386003)(478600001)(31686004)(6506007)(106356001)(105586002)(53546011)(26005)(99286004)(76176011)(66066001)(31696002)(52116002)(25786009)(86362001)(186003)(14454004)(2616005)(476003)(97736004)(446003)(5660300001)(11346002)(36756003)(2906002)(305945005)(7736002)(3846002)(6116002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1463;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yH7rzPI4WrR0jgMvoYtyI8QDmhSibH1LrQAUhBRas69BM+7p19K6GzpwGhpippQscxrZjUbhJTiLPHljgfbidxfhehdfg9yQ60Q8hPwnFRc08j5jsSVcAyBSqt6EtFe94FK4q2tGR/k25EybU7tBdB+ElR3Vsiz6cIlenKd2G7fmYGUdPltiinkoc7fv/ur6XPF9mPB11T2ro+pM//juabW4tDork1CciDQ6eAcwoXte9V+R5TUcymm4KDKOPXPVY+ZKwgvWtnwUUIwgNRBFWLoYruSbJoYYK9jn7mbK2CD0sEiTxZfWx4aPv/7oT2Aghty/HnVIwVlpUCZmqU+KZtCJHY4+KKD27AfekRK2yXc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C293C7325534E41ABCAE8532EE85DAD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0055a392-d589-4111-f469-08d65633de24
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 19:50:09.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1463
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMjkvMTggMTI6MTIgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIYXZpbmcg
YW5vdGhlciBpbmRpcmVjdCBhbGwgaW4gdGhlIGZhc3QgcGF0aCBkb2Vzbid0IHJlYWxseSBoZWxw
DQo+IGluIG91ciBwb3N0LXNwZWN0cmUgd29ybGQuICBBbHNvIGhhdmluZyB0b28gbWFueSBxdWV1
ZSB0eXBlIGlzIGp1c3QNCj4gZ29pbmcgdG8gY3JlYXRlIGNvbmZ1c2lvbiwgc28gSSdkIHJhdGhl
ciBtYW5hZ2UgdGhlbSBjZW50cmFsbHkuDQo+IA0KPiBOb3RlIHRoYXQgdGhlIHF1ZXVlIHR5cGUg
bmFtaW5nIGFuZCBvcmRlcmluZyBjaGFuZ2VzIGEgYml0IC0gdGhlDQo+IGZpcnN0IGluZGV4IG5v
dyBpcyB0aGUgZGVmYXVseSBxdWV1ZSBmb3IgZXZlcnl0aGluZyBub3QgZXhwbGljaXRseQ0KICAg
ICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl4NCg0KZGVmYXVsdA0KDQo+IG1hcmtlZCwgdGhl
IG9wdGlvbmFsIG9uZXMgYXJlIHJlYWQgYW5kIHBvbGwgcXVldWVzLg0KDQpMb29rcyBmaW5lIHRv
IG1lLCB3YXMgaG9waW5nIE5PVCB0byBicmluZyB0aGlzIGludG8gdGhlIGNvcmUsIGJ1dA0KSSBn
dWVzcyBpdCBtaWdodCBiZSBtb3JlIG1hbmFnZWFibGUgdGhlcmUgaW4gdGhlIGxvbmcgcnVuLiBB
bmQgaXQncw0KaGFyZCB0byBhcmd1ZSB3aXRoIGdldHRpbmcgcmlkIG9mIHRoZSBmbGFnc190b190
eXBlIGluZGlyZWN0Lg0KDQpTaWRlIG5vdCwgc2hvdWxkIHByb2JhYmx5IG1ha2UgdGhlIHN5c2Zz
ICd0eXBlJyBhdHRyaWJ1dGUgYSBzdHJpbmcNCmF0IHRoaXMgcG9pbnQuDQoNCi0tIA0KSmVucyBB
eGJvZQ0KDQo=
