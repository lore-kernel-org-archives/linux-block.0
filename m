Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74425C352A3
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 16:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AEC20637
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 16:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qk/Vpw3p";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qveyiXgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgBKQqI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:46:08 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24311 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgBKQqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 11:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581439568; x=1612975568;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3O6wx/D0mT0J+sAfw+nKPYOWxOOHYcQTYvczaet5rII=;
  b=qk/Vpw3pEQ57x2UG0DfN3YJXOMglcs1zqMg3fn6BTvrVRKlUg58wnGaU
   ohVuyFTPA/jsEnh6C11UXD8bL1QWJRGi9XJt8ypqIom3bL2cuq60ADQ8i
   Bkvdz6DTe7iO7I3PoqU5J9aT1t0OgnsnF4bSHUeq+Qo2jR+vb0RAU4+x4
   sPPSAxfKX8YOl1Q4JB443nElCo40KRZKjqg7fwREcyjr++cOVMD+GtWLg
   UsbMevwFcub98Jb8E5mrfvBCHi/OhtRaNVpqP/hkJQ4M/OSkYEBj0R/vB
   fAfJEfGaoF6DnkXU40iVNoNjgMH46dPyCqJT2nzCeFY6NkQbp05TXOnU0
   g==;
IronPort-SDR: vVXY6BEwGG7EIHcJHHFnhNl7iaTez+eS/DqI3XpAJEISgS/Apnk9JLseTKBxKBixe3RNUbeFAe
 IpAKN04JSQ/LLKTnXfZOaL5onHnnWosS3IhFEEZyHh6wqqz3H6bucROJN8OZ4Uf83U3SR5X7de
 TklYRuyeUwMc/fU6pyOaxpUaHtYr8Q40BtKtEci7SSjo2g90ujXO1gyNn11LnHR4raSdJnYGsR
 jM5rvCLCa4f7M4kCLdhMLRn8JiAJxN0EuXaca24EJ7ZdbzrUGOBeaCfVwoWA4l0k1QbZQOn1O/
 Ctw=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="131049164"
Received: from mail-cys01nam02lp2053.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.53])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 00:46:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvr8T+ke5jk85/LvN9rU4zZ92ZoFonw8UBRq2UTRFHOHcTqimIFQZnrurGfw0FwKu2BRYXELqe9AssGwqm2h3eP/YO6sztmToNgs++ZzA3UOngxVTUR+pzF2ONMex2CmK7zEr6xfucApLra5UhI5/soomITRkPkzKKGxIggxX8JyEQosN2ZXKtxDpturUFOeHjwKFscHfz0UsLll9shmhkcOSh3KwCjCbbYxQ0IwvRzIQqHEIPI6k2kUD6cYzWKpAuI2SIsgop3o6ijyI9n2lmU65OB3mGZJwsozU5f5Zy3O/VgN1JJwqUDtqQ/ugEpmHIpLE9hoQHhngL3TYGcWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK2hSEp4jMM6v2IjJpcflPASxvwoUb96KGQqZtZgxXA=;
 b=BsdA/GPIJsP5RE5QhLas9V7AS4AmaKsjw64C97e9hFRBMCAc8vjiMRjt/o7UgrtuJci8OurLO3u96UDsd0wiLuKFnjGnz4B8QMQE33YxtFhoH1htiNjMI9TgQ/9IJz7Ap1Oc3C+Gz0FHQwDfl6abGvB2Mhw3NrDaEHjutnS+iXrjhOFnpc8OAp0p7oymB6b8JB+x0DZ6DUgWMLZsA8wQZ16Rik5Lyu2w2DPg1kSFkYSzxAyJPgk3KnCpSXQqK4NtxOzOWuSjI56b8wffpg3HSTvKA05/Qk01Ugo8xCeQM+hRfZy8434wSUHQAiw83tEj5kv3qZUuSOCPbWyBwPn79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK2hSEp4jMM6v2IjJpcflPASxvwoUb96KGQqZtZgxXA=;
 b=qveyiXgrVUAkR7MZstnrbQ1b97LJeAFBvI3CtSWLWTUmesPOTyOHyJw6yg4gWues133Us9gyBJQTmzr2mk9FqN0mhWxxcH/FsDOmyswTbgVsslcY1w78Xn6eoxX8oinNu3ufJVyXvX0Aq6XhDuyQvnvGfbsxcxPSJiID4kftREE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4053.namprd04.prod.outlook.com (52.135.216.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 16:46:06 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 16:46:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Thread-Topic: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Thread-Index: AQHV1vvxPjad+7sLRk2UwG5mK03ccA==
Date:   Tue, 11 Feb 2020 16:46:05 +0000
Message-ID: <BYAPR04MB574971DCB7CF63F7A4A269B886180@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB5749FE36341AB61547C1218A86000@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9396c376-abfd-4903-4f87-08d7af11e369
x-ms-traffictypediagnostic: BYAPR04MB4053:
x-microsoft-antispam-prvs: <BYAPR04MB405363F30133A18D6FB5757286180@BYAPR04MB4053.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(199004)(189003)(53546011)(81166006)(2906002)(8936002)(6506007)(7696005)(186003)(8676002)(81156014)(55016002)(26005)(9686003)(64756008)(66446008)(33656002)(110136005)(478600001)(76116006)(316002)(66476007)(66946007)(4326008)(66556008)(86362001)(71200400001)(5660300002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4053;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /pWZxEeWwhnBfa1F9DGQGENZNC7lvvNUN8wW2Dfk9yZBUw/5HAvnVWNpGkT87MsvjvyUWipOdnuhKO8GXIIaLn50p3IuQKT+P5BdsqYvkS//IeJRz3KyCa2fnimALwV0qUye4T+I+6wwO1l5Ske9KJwSKFneE/pIhNU+rU8gvHZAQTeOObiJ0Z351zMjqaRzDQTANM51guWv0tPNBG5ispIARVurK5nDYGOSCIDA7DZhdV1Ff9tR//RhgsmV8CjE7pBUAa8IPxmlpRTQh8CMEWNbNanRfHKjIBJvjVN9kBLvwPnkD7tK7XyIWLNZEYr+mIUVlPjN9MTlJW78Si8R+VUlPZC0QtNJDx5j1Fnals9ywhF4GO7i26zNuCw8Z/gnmqOHvJ5Bv1fpmBFQ3umW5i5UXdKBSd8EKLDRS6huGWXj4gCC6nkC3tItCEAH8Dom
x-ms-exchange-antispam-messagedata: ySLy5kH6O/cEck+Ge+eSxNv4d1Ur4UVHqQzu4t4rq4YWmyyW5N3qgxjygvWjR86szRU70N1uLY26r646S2vGAhqovN1zmqAl4Sx8uLjk9wWr7Sq5weRj8fdxwI1wyZ4haTLLzUQ1vt64aGd6GBUKOQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9396c376-abfd-4903-4f87-08d7af11e369
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 16:46:05.9299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /yd9+LeQYT1tsaYDWscRPf9yLctjhWPlKfQixmtsLT+hYfcF6Yw6dJ+iW83ogEr6wr5l+De59m6LW+y6THfwdQ5AVM+75IHT+47Lr900dMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4053
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping ?=0A=
=0A=
On 02/03/2020 02:48 PM, Chaitanya Kulkarni wrote:=0A=
> (+ Omar)=0A=
>=0A=
> On 01/29/2020 03:29 PM, Chaitanya Kulkarni wrote:=0A=
>> This is a small patch-series which adds two new testcases for=0A=
>> setting up controller IDs and model from configfs.=0A=
>>=0A=
>> Regards,=0A=
>> Chaitanya=0A=
>>=0A=
>>=0A=
>> Chaitanya Kulkarni (5):=0A=
>>     nvme: allow target subsys set cntlid min/max=0A=
>>     nvme: test target cntlid min cntlid max=0A=
>>     nvme: allow target subsys set model=0A=
>>     nvme: test target model attribute=0A=
>>     nvme: make new testcases backward compatible=0A=
>>=0A=
>>    tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>>    tests/nvme/033.out |  4 +++=0A=
>>    tests/nvme/034     | 63 +++++++++++++++++++++++++++++++++++++++++++++=
+=0A=
>>    tests/nvme/034.out |  3 +++=0A=
>>    tests/nvme/rc      | 24 ++++++++++++++++++=0A=
>>    5 files changed, 155 insertions(+)=0A=
>>    create mode 100755 tests/nvme/033=0A=
>>    create mode 100644 tests/nvme/033.out=0A=
>>    create mode 100755 tests/nvme/034=0A=
>>    create mode 100644 tests/nvme/034.out=0A=
>>=0A=
>> Test Log :-=0A=
>>=0A=
>> Without cntlid_min/max and model patches :-=0A=
>>=0A=
>> nvme/002 (create many subsystems and test discovery)         [passed]=0A=
>>       runtime  15.246s  ...  15.053s=0A=
>> nvme/003 (test if we're sending keep-alives to a discovery controller) [=
passed]=0A=
>>       runtime  10.057s  ...  10.063s=0A=
>> ./check: no group or test named nvme/0004=0A=
>> nvme/005 (reset local loopback target)                       [not run]=
=0A=
>>       nvme_core module does not have parameter multipath=0A=
>> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed=
]=0A=
>>       runtime  0.057s  ...  0.065s=0A=
>> nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]=0A=
>>       runtime  0.036s  ...  0.038s=0A=
>> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]=
=0A=
>>       runtime  1.233s  ...  1.240s=0A=
>> nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]=0A=
>>       runtime  1.203s  ...  1.208s=0A=
>> nvme/014 (flush a NVMeOF block device-backed ns)             [passed]=0A=
>>       runtime  14.572s  ...  16.051s=0A=
>> nvme/015 (unit test for NVMe flush for file backed ns)       [passed]=0A=
>>       runtime  13.584s  ...  13.948s=0A=
>> nvme/016 (create/delete many NVMeOF block device-backed ns and test disc=
overy) [passed]=0A=
>>       runtime  9.877s  ...  10.750s=0A=
>> nvme/017 (create/delete many file-ns and test discovery)     [passed]=0A=
>>       runtime  18.902s  ...  15.584s=0A=
>> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [pass=
ed]=0A=
>>       runtime  1.217s  ...  1.237s=0A=
>> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passe=
d]=0A=
>>       runtime  1.204s  ...  1.193s=0A=
>> nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]=0A=
>>       runtime  1.204s  ...  1.195s=0A=
>> nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]=0A=
>>       runtime    ...  1.334s=0A=
>> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed=
]=0A=
>>       runtime  1.218s  ...  1.231s=0A=
>> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]=
=0A=
>>       runtime  1.207s  ...  1.196s=0A=
>> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passe=
d]=0A=
>>       runtime  1.191s  ...  1.195s=0A=
>> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]=
=0A=
>>       runtime  1.192s  ...  1.196s=0A=
>> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]=
=0A=
>>       runtime  1.211s  ...  1.191s=0A=
>> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passe=
d]=0A=
>>       runtime  1.204s  ...  1.211s=0A=
>> nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]=
=0A=
>>       attr_cntlid_[min|max] not found=0A=
>> nvme/034 (Test NVMeOF target model attribute)                [not run]=
=0A=
>>       attr_cntlid_model not found=0A=
>>=0A=
>> With cntlid_min/max and model patches :-=0A=
>>=0A=
>> nvme/002 (create many subsystems and test discovery)         [passed]=0A=
>>       runtime  15.053s  ...  11.918s=0A=
>> nvme/003 (test if we're sending keep-alives to a discovery controller) [=
passed]=0A=
>>       runtime  10.063s  ...  10.058s=0A=
>> ./check: no group or test named nvme/0004=0A=
>> nvme/005 (reset local loopback target)                       [not run]=
=0A=
>>       nvme_core module does not have parameter multipath=0A=
>> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed=
]=0A=
>>       runtime  0.065s  ...  0.065s=0A=
>> nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]=0A=
>>       runtime  0.038s  ...  0.036s=0A=
>> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]=
=0A=
>>       runtime  1.240s  ...  1.239s=0A=
>> nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]=0A=
>>       runtime  1.208s  ...  1.207s=0A=
>> nvme/014 (flush a NVMeOF block device-backed ns)             [passed]=0A=
>>       runtime  16.051s  ...  15.345s=0A=
>> nvme/015 (unit test for NVMe flush for file backed ns)       [passed]=0A=
>>       runtime  13.948s  ...  13.977s=0A=
>> nvme/016 (create/delete many NVMeOF block device-backed ns and test disc=
overy) [passed]=0A=
>>       runtime  10.750s  ...  9.698s=0A=
>> nvme/017 (create/delete many file-ns and test discovery)     [passed]=0A=
>>       runtime  15.584s  ...  15.514s=0A=
>> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [pass=
ed]=0A=
>>       runtime  1.237s  ...  1.232s=0A=
>> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passe=
d]=0A=
>>       runtime  1.193s  ...  1.192s=0A=
>> nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]=0A=
>>       runtime  1.195s  ...  1.195s=0A=
>> nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]=0A=
>>       runtime  1.334s  ...  1.340s=0A=
>> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed=
]=0A=
>>       runtime  1.231s  ...  1.218s=0A=
>> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]=
=0A=
>>       runtime  1.196s  ...  1.205s=0A=
>> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passe=
d]=0A=
>>       runtime  1.195s  ...  1.191s=0A=
>> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]=
=0A=
>>       runtime  1.196s  ...  1.186s=0A=
>> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]=
=0A=
>>       runtime  1.191s  ...  1.192s=0A=
>> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passe=
d]=0A=
>>       runtime  1.211s  ...  1.187s=0A=
>> nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [passed]=0A=
>>       runtime  1.213s  ...  1.200s=0A=
>> nvme/034 (Test NVMeOF target model attribute)                [passed]=0A=
>>       runtime  1.223s  ...  1.204s=0A=
>>=0A=
>>=0A=
>=0A=
>=0A=
=0A=
