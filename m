Return-Path: <SRS0=tc1V=YV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493B7CA9EA0
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 04:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009DD20873
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 04:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Aui4K5wi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="r0zwPCbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfJ1Ekk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Oct 2019 00:40:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:57696 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfJ1Ekj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Oct 2019 00:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572237640; x=1603773640;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qIrZQjJEEtNrgdrZYDa1lMVfNQZym2b8vY57g+RikdI=;
  b=Aui4K5wiMB4Xwxkvw4LeowyaOijt+AmrxYUCAR9aC7SUnMVpIcRfs7UT
   DJRi9ZpzZ5u+/pSwLIPq2tqyjaDZcN3PSBiiHSE+jV7DZZMTf82lLvTG/
   noVXPMnVNZk0864P72nHHNd8As5FiM/7PR3o5cjFdAKXTqT3cI7KAtXYO
   R6vkMtutCi1VxdgZiBPyNJgam7IBy0srtpgjsRnZeQ3tuvHptQkqzMw2A
   AxXLj0UFfTYFagML2l4Z93PhwOW0UjjrPvz2lWVbFgKU4S/P9136/ByNU
   I6TYgRvC0tVtLENWPI0HUIMR1R5CmCKaNaN/N48KqAy1NWcdgFl2VZ69E
   Q==;
IronPort-SDR: mNZCectZXDY50nK3HAlbpfQ1MRk0VvbxD+jNGZqpnR+1LyPezFjIVIQo72Mdw0DVbjhsn2Pklg
 zEdqgY6dsGKyDn1/matMSPTGzjoC0Lze3RdmUy68/b6N0E6qk+5LcwCeI4WHCadSGzKbFG85qv
 BFhTTlKnB/eztWUl67s2V9CfNap5t4H+wGy8qardqAilDRJLtpmW3+/KQbyDOeTcc23Rm5AMP5
 P32/RamxFPkg9xXwN/bQpSU7Uk/cntHIoNzD7AGDIlmCu+M0FK4pyhvmrpxk7MUotRWGagXgoM
 P8U=
X-IronPort-AV: E=Sophos;i="5.68,238,1569254400"; 
   d="scan'208";a="122227444"
Received: from mail-sn1nam01lp2053.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.53])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2019 12:40:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhUS8wqgnfZmY3CihrWyMrjuQfA3AkK+vSQtwfZNVWcvKsH+q8aUiAdUbtG9ttKeJymX4XgmUp/np+75TMHJUlTPqwMt8UzVywuA6cxLKZrk17e8tEFO8CQLwlD3Jxw0Gtyd5MEMgsfv0dhPDG7lkmzvjrT2scukZYcJut15ZiYZBFGEGFnirDt51mWovD84w/SiPE95w2IinaybfupPG65tLkATGkp4bk1BvFirivHnTIiHSvqaAKUnrTbrrMV/NuBsoJprkVUj5EcK/7JJVN/RjseSB/NElvh3Y7f7i/3jkBMXniRW1e3GudNUZCFdhQejU8sdSDGER/XMKAajDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qP7PW4JL1NoSWgJRC2nH1A99shUYOQCjk4jUjZOCYk=;
 b=mVVYdscEwKFnLWnTsZoOJcsKBxq+hnCyxVQhlu226rjVGd9iMqauvw8eUMnV9R1UZN/GrXFVFAWCTEVgggSUxzgQtH7HStV7UvVWH2naSqtoR2dgaoU48cY1/UlfKi1gTH6dy9n12BlfdXrEq3/ETI4KYqPl+BcJfQ28Fuvk3ZHpKaJ160br0ee5PC0SbZTgJVvNyohUouVJc14UVPECYpxx0nu6vBGKfp4cPkiI2Rj/J0Xs3uRXUuTrF1VufxCJpnEy8hmlNz0BizDFRJF/WT2uQCTue+iKKHHpLNza1TprT64KJJJA/buDX8MWeX+o7DGBjZNYANI/al3XyQSiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qP7PW4JL1NoSWgJRC2nH1A99shUYOQCjk4jUjZOCYk=;
 b=r0zwPCbQ09MVZQePY763D9SbOpoIUXALEek+1bEaEcH1402sPIBakyWpGgbaIac7VEf7MaTnimVY6dBKkGTarmYnhgm5SPhHnZcY242uiJuBxuFV/3w060+JCAyRCSVDksKufClzhQBgr92+IDyuc68gfzgdnL00h3/tGksMeAg=
Received: from CY4PR04MB3719.namprd04.prod.outlook.com (10.172.139.145) by
 CY4PR04MB0742.namprd04.prod.outlook.com (10.172.137.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 04:40:37 +0000
Received: from CY4PR04MB3719.namprd04.prod.outlook.com
 ([fe80::7c56:a242:a7d3:104c]) by CY4PR04MB3719.namprd04.prod.outlook.com
 ([fe80::7c56:a242:a7d3:104c%8]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 04:40:37 +0000
From:   Ajay Joshi <Ajay.Joshi@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report] null_blk: return fixed zoned reads > write pointer
Thread-Topic: [bug report] null_blk: return fixed zoned reads > write pointer
Thread-Index: AQHViaLQRyRX8oDJ1E6KhlaFPat3Zw==
Date:   Mon, 28 Oct 2019 04:40:37 +0000
Message-ID: <CY4PR04MB3719FA7043998B66D0E35BBA8F660@CY4PR04MB3719.namprd04.prod.outlook.com>
References: <20191023130623.GA3196@mwanda>
 <658eaf70-beaf-240c-199a-e54a22d7095d@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Joshi@wdc.com; 
x-originating-ip: [129.253.179.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2a9303c-e493-4062-3067-08d75b60fa93
x-ms-traffictypediagnostic: CY4PR04MB0742:
x-microsoft-antispam-prvs: <CY4PR04MB0742ECDFDC3B3949EB7EE4C28F660@CY4PR04MB0742.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(189003)(199004)(66556008)(66476007)(26005)(64756008)(66446008)(5660300002)(71200400001)(71190400001)(14454004)(99286004)(110136005)(7696005)(76176011)(102836004)(91956017)(52536014)(66946007)(76116006)(6506007)(186003)(53546011)(316002)(2906002)(33656002)(478600001)(25786009)(229853002)(6116002)(476003)(6246003)(8676002)(81156014)(81166006)(66066001)(446003)(6436002)(9686003)(8936002)(55016002)(86362001)(486006)(305945005)(7736002)(74316002)(14444005)(256004)(4326008)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0742;H:CY4PR04MB3719.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVIwRzJxckjv1Fo5dFAwAbDS2PyAPCg1M2br1NayHbc0QugMiamPmzPJoFrlG38taaJ/TkRm/OB2YwoIdP0vt7mI60Y49mYSsT9GC8D7x+UB6xW8hu4rn8ke9G3swoLyEbjAfa5yFQ5XvJ2bxCcTGz+wzHZP4E5BZBNumTySORg/U3s4NBcCIN2Uz+HGykNF9Avv1LbBOZkxjQgqA2RAeSNOM9CFR1XRsixcyvKV2TcpzvvoFbPrm9wkfFlJO5LEJLXa3wIQEHY6kg/SqaxafZ0/JwnJGhpRnAVxf9FlJ07g+U/4vxyaTfrReKvWwPEgaJ3O72Da1V5JhjGzb/c1jmf40PPZzXY8kwgNcaV8GedhE/3XFk/kNW+ZXR8cwV8zTFq8uJtnbKUmbeTYGb/w6sugCxJq8h5dz26nwe6VbAwMCK/1kshankgDJLpVgGhk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a9303c-e493-4062-3067-08d75b60fa93
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 04:40:37.2963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4cTXKPCo/bWSE+REIPNFQzrfZtvAb7SHwlOqfPzfsNJ9vPlnmQ1LDWyiWR/u3r6oBgNmyroLqOssVoObW4ncQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0742
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26/10/19 1:55 am, Jens Axboe wrote:=0A=
> On 10/23/19 7:06 AM, Dan Carpenter wrote:=0A=
>> Hello Ajay Joshi,=0A=
>>=0A=
>> The patch dd85b4922de1: "null_blk: return fixed zoned reads > write=0A=
>> pointer" from Oct 17, 2019, leads to the following static checker=0A=
>> warning:=0A=
>>=0A=
>> 	drivers/block/null_blk_zoned.c:91 null_zone_valid_read_len()=0A=
>> 	warn: uncapped user index 'dev->zones[null_zone_no(dev, sector)]'=0A=
>>=0A=
>> drivers/block/null_blk_zoned.c=0A=
>>      87  size_t null_zone_valid_read_len(struct nullb *nullb,=0A=
>>      88                                  sector_t sector, unsigned int l=
en)=0A=
>>      89  {=0A=
>>      90          struct nullb_device *dev =3D nullb->dev;=0A=
>>      91          struct blk_zone *zone =3D &dev->zones[null_zone_no(dev,=
 sector)];=0A=
>>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^=0A=
>>=0A=
>>      92          unsigned int nr_sectors =3D len >> SECTOR_SHIFT;=0A=
>>      93=0A=
>>      94          /* Read must be below the write pointer position */=0A=
>>      95          if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL ||=0A=
>>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=0A=
>>=0A=
>>      96              sector + nr_sectors <=3D zone->wp)=0A=
>>      97                  return len;=0A=
>>      98=0A=
>>      99          if (sector > zone->wp)=0A=
>>                      ^^^^^^^^^^^^^^^^^=0A=
>>=0A=
>> Smatch complains about "sector" being from the untrusted all the time=0A=
>> and I kind of just ignore it these days.  But here it looks like we're=
=0A=
>> checking "sector" after we already used it so that seems very suspicious=
.=0A=
>> It feels like "sector > zone->wp" should come at the very start of the=
=0A=
>> function.=0A=
=0A=
The "sector" is used to get the zone information from the array, so the=0A=
check "sector > zone->wp", would be possible only after getting the zone=0A=
information i.e. after this line struct blk_zone *zone =3D=0A=
&dev->zones[null_zone_no(dev, sector)]. We cannot add this check at the=0A=
beginning, but we can do the check just before the condition "sector +=0A=
nr_sectors <=3D zone->wp".The patch would be something like this:=0A=
=0A=
if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
              return len;=0A=
=0A=
/* Read must be below the write pointer position */=0A=
if (sector > zone->wp)=0A=
              return 0;=0A=
=0A=
=0A=
if (sector + nr_sectors <=3D zone->wp)=0A=
              return len;=0A=
=0A=
What do you feel?=0A=
=0A=
>>=0A=
>>     100                  return 0;=0A=
>>     101=0A=
>>     102          return (zone->wp - sector) << SECTOR_SHIFT;=0A=
>>     103  }=0A=
>>=0A=
> Ajay, please take a look at this and send in a patch if appropriate.=0A=
>=0A=
=0A=
