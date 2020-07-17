Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B315DC433E3
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EACB20768
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TAps9+hX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G9KJsHfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgGQIWs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:22:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:51868 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgGQIWs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 04:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594974167; x=1626510167;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zHDQJ7q8Rie5HNOhFAY6qrB1XMpgtuXiitJgD9OMhVw=;
  b=TAps9+hXUclOtfbBXEar1BpCQhytACk0KxO2dTmNL5sGh2gVuRWVRLTL
   t3KcBFrI8+qWZE6/q+KdGGnqzy0HMC0mT6Jq8NfIAzdatvmYt0v0Z6+Ep
   zKf4De6WpaDIEYAXvV0NlTrX5yvToZ6aytNJORD2ZrVTRx7Q/CeK9VqPl
   Pm9UF37UMsDmYCk1SF1eRqId5mvg3QL/z4084gdUZXib1zSoYJJ51Me7K
   P2KgfFBL9C4vVElky9bQUfbQ7s1OJkAw/H1655teeFt42lu6q5KqfuE1c
   4bUGcpsvJCBWQC3RkXuoHDXUgkkcnkPAUAejJSY6N+zsUNcSnzP0p76kM
   A==;
IronPort-SDR: n+95i1rho4nFylH5eTscgIWVDW4wNsVJwsU4uIyUwjJT+oNWhdpnkRGl8KIg57EOQVa78Wpf5w
 AcWPJuyRfpoDFdLBr5QqD+vTYZS7z0ctCvCh3c551cfSnJNZuoT5yjKsVi1hst4MdilgU2nr36
 9Mfnzj14bBaja0XLN7BRnGZXyk4/FwTnVPqxmSSfnzBYVQisvBXr7eiinltuNErIqjbAAo0+SL
 PkVT1DwLGwxABC82fFQsyE1z9xkX0of8edSDwrpTAX5by2myf+XZiQ/dP4wfU6I9awaR9D8iXd
 fs0=
X-IronPort-AV: E=Sophos;i="5.75,362,1589212800"; 
   d="scan'208";a="147006406"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 16:22:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaKXh3SfPphN354V31yjAnDz+T1KazbMpRDWcC38NV/tWDU76eUVTope2xuHCXmJqquqXU9pTIlR3E9R9aUgg6wY72lG1cmQiv7AWpTaosQGqa9ym3flfpkn8bS6sxvkjvkTtUbSTRr1kr0JJsCRB4zqfDzAc/tzy/+aSxmfGi+RqqdLpnCxsbrNQPo906sUP0TButNZNnXH6Pnub923GiJADUrhWyY6k2UUY6RnNmB2iCvFQZy1GKIwLD9djFRQY7GHDuhoYSnTkcANSv5H2f0OVTZ25QQlISexl0Y5OdLmTCJAzHQ+/sKrOQhZFKVpkGQeNWaAjHH7vx2hf6YdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHDQJ7q8Rie5HNOhFAY6qrB1XMpgtuXiitJgD9OMhVw=;
 b=c9yHVC9ZBCCEaYUE38EeUpmi5lfdUwvCX6hVmcBuzlaSITH55u6Nk4/NYhxvXGu5Q5XkOgAfjmzQs/xIhq8J0bx9x2zWfJWxRfxhhNmwsv7Hm7FIUh8U9N2vPOZGtAi7NSq35Mve2TRCWALn/+2aDPkahnCIDvys1qkcN12Luaz0R3TDtFXYa5aqc1RdDzM3F2s6EOt+oDMPlUl8lw2NHt+wmLgTg9YTBj7gsTXezu8rbheXVGh059zHvBeQAD8/5R0nahhYiwF1G0Ogdmw1Ne6gaoTxjSclRKKwi4rEkWB6L7oeaIzpcbol73rd700nd2Mhwv1MxEhJPH7pS8+01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHDQJ7q8Rie5HNOhFAY6qrB1XMpgtuXiitJgD9OMhVw=;
 b=G9KJsHfgucCvuYqt3qg2OJdfhIShqVMljznErk1syBKjytYYgXYnliPWb119NmlhuXlL6R4S/54ndzSJZb52F61wiloVXwv12sHSbNuN28D+3Ab1YF9vEsO4JXaUM5RroanxfDrCUWAQ1UWREgoD2X3aIcvkE6rQ6furuyfML1g=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0247.namprd04.prod.outlook.com (2603:10b6:903:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 08:22:45 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3174.022; Fri, 17 Jul 2020
 08:22:45 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: align max append sectors to physical block size
Thread-Topic: [PATCH] block: align max append sectors to physical block size
Thread-Index: AQHWW1k90KwUXjQMWE23AxcUX8lDNA==
Date:   Fri, 17 Jul 2020 08:22:45 +0000
Message-ID: <CY4PR04MB3751DAD907DFFB3A00B73039E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200716100933.3132-1-johannes.thumshirn@wdc.com>
 <20200716143441.GA937@infradead.org>
 <CY4PR04MB37512CC98154F5FDCF96B857E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717075006.GA670561@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d08c2d7f-20ab-4f61-72e6-08d82a2a952f
x-ms-traffictypediagnostic: CY4PR04MB0247:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB02474DEAE37A722AF9D92B3AE77C0@CY4PR04MB0247.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ex2bQXeT3pJgi9G9L9qKdJjLtiQznqj5uZ0aTVqoXtHjSSoMteVsf5BVRprcaZmW5Cyt9cR5iAq6INDs2/RssUflUSwoTPhhscBJviwetmBy67U/q7zPluqr5bMhtQmWnTz013M6eYFi8ZL3MKzjm+/zB/gJJDGbK3hCIRSx7cixabD5935jtct9ZjCIEYqYsnpXERE/uRYbO0cIjxKIxiSnzy5m2/xxNRf/AQ3sTVrykq9t/T2WcjiJpW3Y0fUjVnsfoTWEQYcLVarUgHaO96h4tq4tkaDa+NEZ5kXtshU2YUq70bnqaKzoQD9NMMSdCsMOh0qPUrvdaqdmVoRTTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(8676002)(91956017)(71200400001)(76116006)(66946007)(9686003)(8936002)(66556008)(66476007)(64756008)(66446008)(52536014)(86362001)(316002)(5660300002)(2906002)(4326008)(6916009)(54906003)(26005)(186003)(83380400001)(7696005)(55016002)(478600001)(33656002)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MADYsxlZIC9jp4TzXaeJzJgO8tcNgY6O2nYrFFBUW7Yf4DsohFx1GPp6sGxhBieYIgytbYU+FIlEnZr+ecE+Kmvi1ZZcoTSkbjYSriz/3jVyeoR79gK4TqHhXVkGMkabJLYVatS519CSTghz1v6FEieO1VnNPcjbrPBVyZkrI4Vs1Iwuk3HicfJy9rIK5BVyVUlztull4KNJK8upgfgK/H3wwSDEHsUsYPF8d++4q2crSEt4K8dp4ekUXEgOA0jycNX6uzv7YM2fRsd7x5Ky64eyuphIO2OufaKMEoSYYwN6/eGc9JFx0gia0UlVAkh3Ayoj1jk+ipz9BstGC1bGQ/cGba1xeuGlS7mlrs3JnIY+IWfaUe7B0SOmPqMRLesi9Gr0+0qBUsF9IAv6QtNUmDY6bTQo3+NrVyC5IyA1E5Ue6o0ekWH6OuZpf8dectDonOrQ84b4uTL+O0UyOHpIViuyQC6aCwWPV1ycxlFOroZJMDq7LlyGdLIFwBkCzo+V
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08c2d7f-20ab-4f61-72e6-08d82a2a952f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 08:22:45.2043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YA53CFHrgF722a8P6Zc2oPX5dPzGnjIMBXYqBO60OF/LvssVqijq7kmgE4K3n4JndGRxuzVobVXsskzE5o4tJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0247
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/17 16:50, Ming Lei wrote:=0A=
> On Fri, Jul 17, 2020 at 02:45:25AM +0000, Damien Le Moal wrote:=0A=
>> On 2020/07/16 23:35, Christoph Hellwig wrote:=0A=
>>> On Thu, Jul 16, 2020 at 07:09:33PM +0900, Johannes Thumshirn wrote:=0A=
>>>> Max append sectors needs to be aligned to physical block size, otherwi=
se=0A=
>>>> we can end up in a situation where it's off by 1-3 sectors which would=
=0A=
>>>> cause short writes with asynchronous zone append submissions from an F=
S.=0A=
>>>=0A=
>>> Huh? The physical block size is purely a hint.=0A=
>>=0A=
>> For ZBC/ZAC SMR drives, all writes must be aligned to the physical secto=
r size.=0A=
> =0A=
> Then the physical block size should be same with logical block size.=0A=
> The real workable limit for io request is aligned with logical block size=
.=0A=
=0A=
Yes, I know. This T10/T13 design is not the brightest thing they did... on =
512e=0A=
SMR drives, addressing is LBA=3D512B unit, but all writes in sequential zon=
es must=0A=
be 4K aligned (8 LBAs).=0A=
=0A=
> =0A=
>> However, sd/sd_zbc does not change max_hw_sectors_kb to ensure alignment=
 to 4K=0A=
>> on 512e disks. There is also nullblk which uses the default max_hw_secto=
rs_kb to=0A=
>> 255 x 512B sectors, which is not 4K aligned if the nullb device is creat=
ed with=0A=
>> 4K block size.=0A=
> =0A=
> Actually the real limit is from max_sectors_kb which is <=3D max_hw_secto=
rs_kb, and=0A=
> both should be aligned with logical block size, IMO.=0A=
=0A=
Yes, agreed, but for nullblk device created with block size =3D 4K it is no=
t. So=0A=
one driver to patch for sure. However, I though having some forced alignmen=
t in=0A=
blk_queue_max_hw_sectors() for limit->max_hw_sectors and limit->max_sectors=
=0A=
would avoid tripping on weird values for weird drives...=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
