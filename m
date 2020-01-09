Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476E7C33C9E
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 02:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D7B20705
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 02:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="btWACvF1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UaO/AFNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgAICFE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 21:05:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36809 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgAICFE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 21:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578535503; x=1610071503;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xHHF1mPHEpJ/wNjkz7yDnkz15ecrSjKkJwm9ilJtLWI=;
  b=btWACvF1K9tSK3NVK7TkM45y/5bSObTRz3gkvcV6/iu+oTq98jfftAA+
   zrEpFZlZYdPEUX4UdbUfyxmnGH+4mFEgBYtGpB9q0TSFA2I4uphePspVZ
   F3Of1+YPIb84luP2eE+EIPLiiF7K7UqQBJjTMwK7j1Ga3TehS9eTjhooh
   tn+OMmnVMlzGLKY5H9LtjP6qRPKFzXr0pHKB4jZZumqKn4kaAIGL4n6l1
   JJs/4J77BsctNA2UrLml8Uwv7YyqfZi4/ifzTwLxjJ1lMyNR/xqgEp6/h
   QE0kS/jVXezXv7mrmPkOAfp+kx/9pRm1j0lWgjpy32X508Y5iz/2GALn5
   Q==;
IronPort-SDR: 6KnVZRn92a89s+lP9Mby7sQ7dpbqgyILLrdWoR+0hB6ufrsvhURdtqvhNRcXMFJ9+KDvObfFKD
 NKzUsyUDsxTpfYKzhDgh0IOEmQKSLdneZxD6c5KmjyrVNQdWRQsT4JrhGUYm6EwPMCxjDYpU5i
 BH/6V486hxEAk74+fIF8U6xWGVZf5HWd2Ua8SANlwabtEFdvXHe+lU4JrIwvdb4ZmD0zFFNPzV
 KiF+lzvcPRjxt6G4D/To1iIZRDfNnOuGmpnjyp0LaDLYQaWjO7CZ/VNhs06NFxqMBAHb8YgscQ
 bOE=
X-IronPort-AV: E=Sophos;i="5.69,412,1571673600"; 
   d="scan'208";a="234800942"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 10:05:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQNZkqTBy0POhn27qnTfQ8IxvuULJoYbgObcIx+5qHLQ0szj7xP2vU/btExwoo2aUA0rFaGsf/cl+iHEHh1NHR5LW3YvVyXPvoE/fNRG8lh00Bgief+6tJOdA1GjWv5dZpqjSxZ7QyVlUq3D4ztrqvwoy7luJSOQjiCXgO5lSYGvpDdCQ9MkELf4685o6tHBMCNfxG1NDCOB9i7E03ytJgF8D+4Rgqlh889IMHRDS3C3+WyoHp6gOOjQ+p3Wib+duom9kIDED5JUcUZcqxIzbKpzGsUatHt+wg0BzpEfAL2FqcAqHWZ9tMIe4KUNaJ88ePAxFazCrueVXugOnoiwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv1PIfBrvizh+7zQvL6qb2UUU0edvwkTIQcYm0yQghc=;
 b=mc5F1U+lBF+ymMouAtU9omP9KitQAZUO9usHvNVH5UazvRBWW6O1a2xnDkmzYbZmIdAIIc5wA9TfZBZxDwe19heJ1mgXhVBVWhZo8aa+3/ufDzqinqohz+9IevvyO4i+9x+08QdQOfT06/KHto4mrKrGxEPO4Rmbzzc6V5WQQZyeZ9RV2DxcUqvtxzeFYYHg/fpn5kZu4KhQVsq5FI00HAl9qP7wr/ox9rvHffZEEtbUjBiekXtz+aT+/Tr7XjCH1Xe38pJO1NQgY0cbyotgcF+fpA0qKFyFS0y2OSqJDuOmO115M5noWnXBz7zMiS0BNFH+hTp6e0RIUdIn8xBsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv1PIfBrvizh+7zQvL6qb2UUU0edvwkTIQcYm0yQghc=;
 b=UaO/AFNExxK9lBBt0BlcpGS8IkcnvEJf+8E5Wmvw3XWzvK3id86hK3+O51CR/68RdahbljhrJNE9PWQTdoOfdiDso7wlAemnOL7KXWIfAHS7RdmVw/n7pN64Br6g+ctSIdmvkyFbtGOvgtrfr5AY/8+oIcFyYKRTs+iUVRZ6j34=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB3862.namprd04.prod.outlook.com (52.135.214.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 02:05:01 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2602.017; Thu, 9 Jan 2020
 02:05:01 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bob Liu <bob.liu@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "shirley.ma@oracle.com" <shirley.ma@oracle.com>
Subject: Re: [RFC PATCH] dm-zoned: extend the way of exposing zoned block
 device
Thread-Topic: [RFC PATCH] dm-zoned: extend the way of exposing zoned block
 device
Thread-Index: AQHVxfMPtnSx9ygQV0yw4PguyV00/g==
Date:   Thu, 9 Jan 2020 02:05:01 +0000
Message-ID: <BYAPR04MB5816DF518F723BE1A9776C62E7390@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200108071212.27230-1-Nobody@nobody.com>
 <BYAPR04MB5816BA749332D2FC6CE3993AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <9e7d2f84-6efa-7c44-2313-860d5e8ed067@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5c59a85-d275-4695-2bff-08d794a8560d
x-ms-traffictypediagnostic: BYAPR04MB3862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB386213559409BBBE1E93EA25E7390@BYAPR04MB3862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(189003)(199004)(81156014)(316002)(9686003)(8676002)(81166006)(33656002)(66556008)(66946007)(2906002)(76116006)(91956017)(54906003)(110136005)(66446008)(64756008)(66476007)(71200400001)(55016002)(4326008)(478600001)(6506007)(53546011)(7696005)(86362001)(26005)(52536014)(186003)(8936002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3862;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2oeDa6EhN6cqMKCwhMziFPjMyxossIjRqal9YeSyVE1WB4n5Bdzusaom2dz2OmX6RU/xgaRRCtFFLCdP3q+TWqMp6ncTCAnS80FotSIrQmpNz2Rm+3zh4uPDSHknoXKez3WfYrLmne+2UMz0ObZR3Fa/bNGFq0/X+3F/TBi3pa/B0eXnr52G+c5m9oLjQQqOtvmFyTfy/JOLIkluGW9/yCHjL49sD22E8bd23hEg2p8kUdpQdxX71Bo2JJCi4FHg7Su2g/vTHQYon+7aDFQ1Wc9C9cDopwZLz6yAesZSDp6vt2/Fn/6YxyJz+XwFttBGAyURr29Wb1GlIqs/hyp47/LrTJhPwepS6ofAT0Fu6jKtzB+fxxqAOsCk7hNH3KPKshEyf10CRCtYNIECNPWxtM3SKDif9geIJ+KS1AJqnsBkQMGxwv0LINo5XRSU62SR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c59a85-d275-4695-2bff-08d794a8560d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 02:05:01.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2iK0nFCD1KAUCXERz4zKiTeAdOdqfezl+lFZzpczvKDyqTDts6uSKvCeK+pGrKrz0qLP0y6njlHEhDlSPRPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3862
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/01/08 22:49, Bob Liu wrote:=0A=
> On 1/8/20 3:40 PM, Damien Le Moal wrote:=0A=
>> On 2020/01/08 16:13, Nobody wrote:=0A=
>>> From: Bob Liu <bob.liu@oracle.com>=0A=
>>>=0A=
>>> Motivation:=0A=
>>> Now the dm-zoned device mapper target exposes a zoned block device(ZBC)=
 as a=0A=
>>> regular block device by storing metadata and buffering random writes in=
=0A=
>>> conventional zones.=0A=
>>> This way is not very flexible, there must be enough conventional zones =
and the=0A=
>>> performance may be constrained.=0A=
>>> By putting metadata(also buffering random writes) in separated device w=
e can get=0A=
>>> more flexibility and potential performance improvement e.g by storing m=
etadata=0A=
>>> in faster device like persistent memory.=0A=
>>>=0A=
>>> This patch try to split the metadata of dm-zoned to an extra block=0A=
>>> device instead of zoned block device itself.=0A=
>>> (Buffering random writes also in the todo list.)=0A=
>>>=0A=
>>> Patch is at the very early stage, just want to receive some feedback ab=
out=0A=
>>> this extension.=0A=
>>> Another option is to create an new md-zoned device with separated metad=
ata=0A=
>>> device based on md framework.=0A=
>>=0A=
>> For metadata only, it should not be hard at all to move to another=0A=
>> conventional zone device. It will however be a little more tricky for=0A=
>> conventional zones used for data since dm-zoned assumes that this random=
=0A=
>> write space is also zoned. Moving this space to a conventional device=0A=
>> requires implementing a zone emulation (fake zones) for the regular=0A=
>> drive, using a zone size that matches the size of sequential zones.=0A=
>>=0A=
> =0A=
> Indeed.=0A=
> I'll try to implement zone emulation next version.=0A=
> =0A=
>> Beyond this, dm-zoned also needs to be changed to accept partial drives=
=0A=
>> and the dm core code to accept mixing of regular and zoned disks (that=
=0A=
>> is forbidden now).=0A=
>>=0A=
> =0A=
> Do you mean the check in device_area_is_invalid()? =0A=
> =0A=
>  320         /*=0A=
>  321          * If the target is mapped to zoned block device(s), check=
=0A=
>  322          * that the zones are not partially mapped.=0A=
>  323          */=0A=
>  324         if (bdev_zoned_model(bdev) !=3D BLK_ZONED_NONE) {=0A=
=0A=
This is only to check that the mapping are zone aligned for zoned block=0A=
devices. I was referring to the checks done using the=0A=
device_is_zoned_model() callback in dm_table_supports_zoned_model()=0A=
which restricts mappings to be *all* on top of zoned disks for targets=0A=
that have the DM_TARGET_ZONED_HM feature set. That code will prevent=0A=
using a regular SSD and an SMR disk for dm-zoned. A new feature (e.g.=0A=
DM_TARGET_MIXED_ZONED_HM or something) will be needed.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
