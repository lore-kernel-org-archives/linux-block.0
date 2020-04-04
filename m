Return-Path: <SRS0=MH8N=5U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C086C43331
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 00:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF91720737
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 00:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="x0k0b0g8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDDADT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 20:03:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:4062 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgDDADT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Apr 2020 20:03:19 -0400
IronPort-SDR: TU30eqepJitpf+tC0Bsv78TdxJF6NtW1tjmCU+TX989T1PAPOwW50MAHiEe6sKYy7X+4WZT79W
 NvV4dhisep1A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 17:03:18 -0700
IronPort-SDR: /JZcpx+2w9ZIpxLomSQI8ck6DiOjmUIfjiXy2EhYfe7Zy0ofFlwiMEXVOWA9c6uKOY/hYE+Tfu
 3g+E4BKjj94g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,341,1580803200"; 
   d="scan'208";a="423700740"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga005.jf.intel.com with ESMTP; 03 Apr 2020 17:03:17 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 17:03:17 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 17:03:17 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.56) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 3 Apr 2020 17:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJ//tTCFohoZa5QcrD2H84kyAqRFBxRdcwTpD1PScQGHAZJXId4jWzuZSTuDzk0FGfhQkui1Ne9nolN1sNJdcPHREeBhd7zdYlRewal/VTMPxRvP9pcZCXOJHsmFfv3047OStakncfF86X8sCGkXhP7DUKFu7dRmAW1qPTXYX+1p/0CVd7ZPfPqnqZgV4Qpq61GhX59lqzz6rcUTHO2KwwcvGg6KaHGApH48JS++hzx5onAJgiJeOUdzFKT/bBIm2507aRMRyCcFFlWEccNdpFkbzKkwNpGrNXOrBH1o0pemO3i9MSYBykS9K5If/zNU25ksU2ZPMqBAThGoNDeWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puN5rhVUUCdwq4J91Blo92y3RK7IogBOmAHD10PDU9Y=;
 b=WYYFKam49s6ikyzXnQbKbgsshbhDEN+6w+np34HbluU7euBmd9Vovlf72rYuxrlNSzqN25mRpgHOVIxy4AdT5nqvKuw73ZTEhy/SndMqLYpRW3+75kYCq6pesNgUTYYqXBkGDueHxp+22rMGHQNidjpK89gyZUrV58Gy2BkaSj7VSxOZvvIB5PpcgqTMjn9zEudn3TqrSqTy9XAZjgJ6ity4xcj37iWeGI9tVxJ5K4m9VlvxH2XdnMQ64cL7g7Dxv9oExtHsv1+3PH7gCGLruVKtp3UHucXF3JQiiCWTXg8Zgmp956Z5hzL0l1LUmDzVzanNgxYGCj7R/26gKZ/eiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puN5rhVUUCdwq4J91Blo92y3RK7IogBOmAHD10PDU9Y=;
 b=x0k0b0g8DFPzH9PLn0fenOWgO7K8vNqKjFWEtuVxDVrHMdHP0eD6sNL9sdrTYMZ4q3tVo18O17jd1QvaQWjJ+D5k06AAeN9jJTnhHcNuiHxukMkA7SsS9LYrTuAN+TMHSxQwqRl9rHj1a9NB5P48XVdjfQEzKV3vgbzK87BBWSg=
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MW3PR11MB4604.namprd11.prod.outlook.com (2603:10b6:303:2f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Sat, 4 Apr
 2020 00:03:15 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3%6]) with mapi id 15.20.2878.014; Sat, 4 Apr 2020
 00:03:15 +0000
From:   "Wunderlich, Mark" <mark.wunderlich@intel.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: RE: Sighting: io_uring requests on unexpected core
Thread-Topic: Sighting: io_uring requests on unexpected core
Thread-Index: AQHWCgEltkX+4cuRTkWl1GGJC1Snn6hn+QnA
Date:   Sat, 4 Apr 2020 00:03:15 +0000
Message-ID: <MW3PR11MB4684F11D860948EC7A2E184AE5C40@MW3PR11MB4684.namprd11.prod.outlook.com>
References: <MW3PR11MB46843ADF1AEED8FCEA66BB8FE5C70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <1b9aa822-2516-4eb8-1472-7e7b66c32d45@grimberg.me>
In-Reply-To: <1b9aa822-2516-4eb8-1472-7e7b66c32d45@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 495b2baa-7590-47d8-05d9-08d7d82b92f6
x-ms-traffictypediagnostic: MW3PR11MB4604:
x-microsoft-antispam-prvs: <MW3PR11MB4604C211C184D67BFAE5E9B4E5C40@MW3PR11MB4604.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03630A6A4A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4684.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(39860400002)(136003)(366004)(376002)(396003)(8676002)(33656002)(55016002)(316002)(81166006)(8936002)(81156014)(2906002)(110136005)(86362001)(478600001)(76116006)(66946007)(6506007)(5660300002)(52536014)(9686003)(26005)(66556008)(66476007)(71200400001)(7696005)(186003)(64756008)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWgbnijv+fYCl0c6kMFspfdGGA5cInC5vxEfnOlKNYd9y1A4foTw7Xj9UhDKgBPkCvqhk0hCH3QphUa4GPnWxhNk69V/zcIfHuifqWhavgTAJxySWnSjlqR1piAW4E5k0DNkvqafFhpwr+1q2zdrUxppfXzrd3qWSq7UxJTkVWlfrmneDhl7aP2fEBoMOKgLx/0QO+W0ZfEqqRoxRh4D68JNUuYbHN8tFFVDuVthgUj013C8s7XbE6n9CPgkR1MspAwq7hGAtPKUyphn3k1FT129d0cd9Ecc/7ulQ16AYJCOChTegbJqHo1y6a8tJXLXLTV0Sj/tGQuUWVMcP1pexLkRlnFQqaJBdPtwWf0mTBRsvhyzY7fdZww+Q/bkKz08FwK9cglOmFCcs2RGM7C92bhGYqsqLahO475b+YGdYJp2eJo9Kb5/7UoqsXIJWs+L
x-ms-exchange-antispam-messagedata: DVDcFvVPVOJL9s5aom5pdyYkJRyFvLouYd/709HvtBg58fhE/xcCzf8rJfk56z3rCsfZr5zPjcD7FdpPBHk5Ygplbgb6D1VEj7fQfFEKwdXhyTeS1N5DG2C+EXBWthnCnlS67rnlm968d3Ip+PyCQA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 495b2baa-7590-47d8-05d9-08d7d82b92f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2020 00:03:15.5630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HanTMFZKknztQfocH72Oz7QkO/FN59XYCYZnvoy3ZRcpsQKZX1Wd84G+k1zc4AXNXWRnkNxKdmHm2n8txU6qfSrvCXd6+YPs4BewgrJdWDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4604
X-OriginatorOrg: intel.com
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pj4gSGVyZSBpcyB0aGUgaXNzdWU6DQo+PiBXaGlsZSBwZXJmb3JtaW5nIGFuIEZJTyB0ZXN0LCBm
b3IgYSBzaW5nbGUgam9iIHRocmVhZCBwaW5uZWQgdG8gYSBzcGVjaWZpYyBDUFUsIEkgY2FuIHRy
YXAgcmVxdWVzdHMgdG8gdGhlIG52bWYgbGF5ZXIgZnJvbSBhIGNvcmUgYW5kIHF1ZXVlIG5vdCBh
bGlnbmVkIHRvIHRoZSBGSU8gc3BlY2lmaWVkIENQVS4NCj4+IEkgY2FuIHJlcGxpY2F0ZSB0aGlz
IG9uIHRoZSBiYXNlbGluZSBvZiBudm1lLTUuNS1yYyBvciBudm1lLTUuNy1yYzEgYnJhbmNoZXMg
b2YgdGhlIGluZnJhZGVhZCByZXBvc2l0b3J5LCB3aXRoIG5vIG90aGVyIHBhdGNoZXMgYXBwbGll
ZC4NCj4+IEZvciBhIHR5cGljYWwgMzAgc2Vjb25kIDRrIDEwMCUgcmVhZCB0ZXN0IHRoZXJlIHdp
bGwgYmUgb3ZlciAyIG1pbGxpb24gcGFja2V0cyBwcm9jZXNzZWQsIHdpdGggdW5kZXIgMTAwIHNl
bnQgYnkgdGhpcyBvdGhlciBDUFUgdG8gYSBkaWZmZXJlbnQgcXVldWUuICBXaGVuIHRoaXMgb2Nj
dXJzIGl0IGNhdXNlcyBhIGRyb3AgaW4gcGVyZm9ybWFuY2Ugb2YgMS0zJS4NCj4+IE15IG52bWYg
cXVldWUgY29uZmlndXJhdGlvbiBpcyAxIG5yX2lvX3F1ZXVlIGFuZCAxMDQgbnJfcG9sbF9xdWV1
ZXMgdGhhdCBlcXVhbCB0aGUgbnVtYmVyIG9mIGFjdGl2ZSBjb3JlcyBpbiB0aGUgc3lzdGVtLg0K
DQo+R2l2ZW4gdGhhdCB5b3UgcGluIHlvdXIgZmlvIHRocmVhZCB0aGUgaGlnaCBwb2xsIHF1ZXVl
IGNvdW50IHNob3VsZG4ndCByZWFsbHkgbWF0dGVyIEkgYXNzdW1lLg0KDQo+PiBBcyBpbmRpY2F0
ZWQgdGhpcyBpcyB3aGlsZSBydW5uaW5nIGFuIEZJTyB0ZXN0IHVzaW5nIGlvX3VyaW5nIGZvciAx
MDAlIHJhbmRvbSByZWFkLiAgQW5kIGhhdmUgc2VlbiB0aGlzIHdpdGggYSBxdWV1ZSBkZXB0aCBv
ZiAxIGJhdGNoIDEsIGFzIHdlbGwgYXMgcXVldWUgZGVwdGggMzIgYmF0Y2ggOC4NCj4+IA0KPj4g
ICBUaGUgYmFzaWMgY29tbWFuZCBsaW5lIGJlaW5nOg0KPj4gL2ZpbyAtLWZpbGVuYW1lPS9kZXYv
bnZtZTBuMSAtLXRpbWVfYmFzZWQgLS1ydW50aW1lPTMwIC0tcmFtcF90aW1lPTEwIA0KPj4gLS10
aHJlYWQgLS1ydz1yYW5kcncgLS1yd21peHJlYWQ9MTAwIC0tcmVmaWxsX2J1ZmZlcnMgLS1kaXJl
Y3Q9MSANCj4+IC0taW9lbmdpbmU9aW9fdXJpbmcgLS1oaXByaSAtLWZpeGVkYnVmcyAtLWJzPTRr
IC0taW9kZXB0aD0zMiANCj4+IC0taW9kZXB0aF9iYXRjaF9jb21wbGV0ZV9taW49MSAtLWlvZGVw
dGhfYmF0Y2hfY29tcGxldGVfbWF4PTMyIA0KPj4gLS1pb2RlcHRoX2JhdGNoPTggLS1udW1qb2Jz
PTEgLS1ncm91cF9yZXBvcnRpbmcgLS1ndG9kX3JlZHVjZT0wIA0KPj4gLS1kaXNhYmxlX2xhdD0w
IC0tbmFtZT1jcHUzIC0tY3B1c19hbGxvd2VkPTMNCj4+IA0KPj4gQWRkaW5nIG1vbml0b3Jpbmcg
d2l0aGluIHRoZSBjb2RlIGZ1bmN0aW9ucyBudm1lX3RjcF9xdWV1ZV9yZXF1ZXN0KCkgYW5kIG52
bWVfdGNwX3BvbGwoKSBJIHdpbGwgc2VlIHRoZSBmb2xsb3dpbmcuICBQb2xsaW5nIGZyb20gdGhl
IGV4cGVjdGVkIENQVSBmb3IgZGlmZmVyZW50IHF1ZXVlcyB3aXRoIGRpZmZlcmVudCBhc3NpZ25l
ZCBDUFUgW3F1ZXVlLT5pb19jcHVdLiAgQW5kIG5ldyBxdWV1ZSByZXF1ZXN0IGNvbWluZyBpbiBv
biBhbiB1bmV4cGVjdGVkIENQVSBbbm90IGFzIGRpcmVjdGVkIG9uIEZJTyBpbnZvY2F0aW9uXSBp
bmRpY2F0aW5nIGEgcXVldWUgY29udGV4dCBhc3NpZ25lZCB3aXRoIHRoZSBzYW1lIENQVSB2YWx1
ZS4gIE5vdGU6IGV2ZW4gd2hlbiByZXF1ZXN0cyBjb21lIGluIG9uIGRpZmZlcmVudCBDUFUgY29y
ZXMsIGFsbCBwb2xsaW5nIGlzIGZyb20gdGhlIHNhbWUgZXhwZWN0ZWQgQ1BVIGNvcmUuDQoNCj4g
bnZtZV90Y3BfcG9sbDogW1F1ZXVlIENQVSAzXSwgW0NQVSAzXSBtZWFucyB0aGF0IHRoZSBwb2xs
IGlzIGNhbGxlZCBvbiBjcHUgY29yZSBbM10gb24gYSBxdWV1ZSB0aGF0IGlzIG1hcHBlZCB0byBj
cHUgY29yZSBbM10gY29ycmVjdD8NCkNvcnJlY3QuDQoNCj4gbnZtZV90Y3BfcG9sbDogW1F1ZXVl
IENQVSA3NV0sIFtDUFUgM10gbWVhbnMgdGhhdCB0aGUgcG9sbCBpcyBjYWxsZWQgb24gY3B1IGNv
cmUgWzNdIG9uIGEgcXVldWUgdGhhdCBpcyBtYXBwZWQgdG8gY3B1IGNvcmUgWzc1XSBjb3JyZWN0
Pw0KQ29ycmVjdC4NCg0KPj4gWyAgNTI0Ljg2NzYyMl0gbnZtZV90Y3A6ICAgICAgICBudm1lX3Rj
cF9wb2xsOiBbUXVldWUgQ1BVIDNdLCBbQ1BVIDNdDQo+PiBbICA1MjQuODY3Njg2XSBudm1lX3Rj
cDogICAgICAgIG52bWVfdGNwX3BvbGw6IFtRdWV1ZSBDUFUgNzVdLCBbQ1BVIDNdDQoNCj4gSSdt
IGFzc3VtaW5nIHRoYXQgdGhpcyBpcyBhIHBvbGwgaW52b2NhdGlvbiBvZiBhIHByaW9yIHN1Ym1p
c3Npb24gdG8gcXVldWUgdGhhdCBpcyBtYXBwZWQgdG8gQ1BVIDc1Pw0KQ29ycmVjdC4gIEkganVz
dCBncmFiYmVkIGEgc2VjdGlvbiBvZiBkZWJ1ZyBvdXRwdXQgdGhhdCBzaG93ZWQgYWxsIGRldGFp
bHMuDQoNCj4+IFsgIDUyNC44Njc2OTNdIG52bWVfdGNwOiAgICAgICAgbnZtZV90Y3BfcG9sbDog
W1F1ZXVlIENQVSAzXSwgW0NQVSAzXQ0KPj4gWyAgNTI0Ljg2Nzc1NV0gbnZtZV90Y3A6IG52bWVf
dGNwX3F1ZXVlX3JlcXVlc3Q6IElPLVEgW1F1ZXVlIENQVSA3NV0sIA0KPj4gW0NQVSA3NV0NCg0K
PiBUaGlzIGxvZyBwcmludCBtZWFucyB0aGF0IG9uIGNwdSBjb3JlIFszXSB3ZSBzZWUgYSByZXF1
ZXN0IHN1Ym1pdHRlZCBvbiBhIHF1ZXVlIHRoYXQgaXMgbWFwcGVkIHRvIGNwdSBjb3JlIFs3NV0g
Y29ycmVjdD8NCkFjdHVhbGx5LCB0aGlzIHByaW50IGluZGljYXRlcyB0aGF0IENQVSA3NSBoYXMg
Y2FsbGVkIHF1ZXVlX3JlcXVlc3QgZm9yIGEgcXVldWUgdGhhdCBpcyBtYXBwZWQgdG8gQ1BVIDc1
LiAgU28gdGhpcyBoaWdobGlnaHRzIHRoZSBpc3N1ZSB0aGF0IGFub3RoZXIgQ1BVLCBvdGhlciB0
aGFuIG9uZSBzZWxlY3RlZCBvbiBGSU8gY29tbWFuZCBsaW5lLCBoYXMgY2FsbGVkIGludG8gbnZt
ZiB0byBpc3N1ZSBJL08gcmVxdWVzdC4NCg0KPj4gWyAgNTI0Ljg2Nzc1OF0gbnZtZV90Y3A6ICAg
ICAgICBudm1lX3RjcF9wb2xsOiBbUXVldWUgQ1BVIDc1XSwgW0NQVSAzXQ0KPj4gWyAgNTI0Ljg2
Nzc3N10gbnZtZV90Y3A6IG52bWVfdGNwX3F1ZXVlX3JlcXVlc3Q6IElPLVEgW1F1ZXVlIENQVSAz
XSwgW0NQVSAzXQ0KPj4gWyAgNTI0Ljg2Nzc4MV0gbnZtZV90Y3A6ICAgICAgICBudm1lX3RjcF9w
b2xsOiBbUXVldWUgQ1BVIDNdLCBbQ1BVIDNdDQo+PiBbICA1MjQuODY3ODUzXSBudm1lX3RjcDog
ICAgICAgIG52bWVfdGNwX3BvbGw6IFtRdWV1ZSBDUFUgNzVdLCBbQ1BVIDNdDQo+PiBbICA1MjQu
ODY3ODY0XSBudm1lX3RjcDogICAgICAgIG52bWVfdGNwX3BvbGw6IFtRdWV1ZSBDUFUgM10sIFtD
UFUgM10NCj4+IA0KPj4gU28sIGlmIHNvbWVvbmUgY2FuIGhlbHAgc29sdmUgdGhpcyBwdXp6bGUg
YW5kIGhlbHAgbWUgdW5kZXJzdGFuZCB3aGF0IGlzIGNhdXNpbmcgdGhpcyBiZWhhdmlvciB0aGF0
IHdvdWxkIGJlIGdyZWF0LiAgSGFyZCBmb3IgbWUgdG8gdGhpbmsgdGhpcyBpcyBhbiBleHBlY3Rl
ZCwgb3IgYmVuZWZpY2lhbCBiZWhhdmlvciwgdG8gaGF2ZSBhIG5lZWQgdG8gdXNlIHNvbWUgb3Ro
ZXIgY29yZS9xdWV1ZSBmb3IgbGVzcyB0aGFuIDEwMCByZXF1ZXN0cyBvdXQgb2Ygb3ZlciAyIG1p
bGxpb24uDQoNCj4gSSdtIGFzc3VtaW5nIHRoYXQgdGhpcyBwaGVub21lbm9uIGhhcHBlbnMgYWxz
byB3aXRob3V0IHBvbGxpbmc/DQpZZXMsIGlmIEkgdHVybiBvZmYgcG9sbGluZyBieSBub3Qgc2Vs
ZWN0aW5nICdoaXByaScgb24gdGhlIGNvbW1hbmQgbGluZSBJIHdpbGwgc3RpbGwgc2VlIHRoZSBx
dWV1ZV9yZXF1ZXN0IGJlaGF2aW9yLCBidXQgb2J2aW91c2x5IG5vdCB0aGUgY2FsbHMgdG8gbnZt
ZV90Y3BfcG9sbC4NCg0KPiBBbnl3YXlzLCBpdCBpcyB1bmV4cGVjdGVkIHRvIG1lLCBnaXZlbiB0
aGF0IHlvdSBoYXZlIGEgcXVldWUgdGhhdCBpcyBtYXBwZWQgdG8gdGhlIGNwdSB5b3UgYXJlIHBp
bm5pbmcgb24sIEknZCBleHBlY3QgdGhhdCBhbGwgcmVxdWVzdCB0aGF0IGFyZSBnZW5lcmF0ZWQg
b24gdGhpcyBjcHUgd291bGQgYmUgc3VibWl0dGVkIG9uIHRoYXQgc2FtZSBxdWV1ZS4uDQoNCj4g
QW55b25lIGhhcyBhbnkgaW5zaWdodHMgb24gdGhpcz8NCg==
