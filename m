Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61A3C2BA19
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 08:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A273F2074D
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 08:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bdHwU/YL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UfrzH/Iu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407030AbgDNIMW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:12:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64444 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407026AbgDNIMQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 04:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586851934; x=1618387934;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bdHwU/YLHeVjdV/s3mpWdnHCPROzUw8uyDiWnFAzKumVQA96VN2gNxje
   ThiNiDvN3oUSIzb/kifN0TY+h/tAJTaBfGzvMaxgRRIqp4JpRZaFcRy0u
   pMPwZLy+48tYHiT60Ff8MMfDd8BHJXIGzeG2/PDolxkVtnKhI7wKZatKM
   vZgRCTsO0/oQv/6sjRYx3ysdy+IUQ5V6x9j9zMPnl7bVD/pgCROpg3vhi
   TkVBQUd0WwqBAfblUY+5nMcIkMXtL1LKMlIB3Q9U4tQmAvaHcwn4Tdqe9
   U14Qv3DcJTqmX7pdo/iJ6/3VRLRjg7J1o2loSOLN1MlbDqNLoKhAtZyXR
   A==;
IronPort-SDR: kiVGRdVteFZAnyuZaS+arG5COgRI0mkk5RvrbDl3CxmH5VjQjgJKvbmouLKgY0vCwF3V2NK8k8
 8yjKljFKy7OZEejzdlYuGPQxG97payMe+AE3UBZoHKHXlBg/bsLRwThPM7uItqiZtc4OIwoXVg
 cJ0iwQEEj7nJmztP3F99o5+qa8Vh6JMGT72wPPfDYd0afHWQAS/dho938BGaOCM6lJwbuAECFF
 NcsE4ek1R39kx1lMyBglbzWX1ZdPmyO8/6uj82J6rOP2AZGvppjHqYfnfqmp1++Ae3zpBkR0sR
 2HQ=
X-IronPort-AV: E=Sophos;i="5.72,382,1580745600"; 
   d="scan'208";a="135286027"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2020 16:12:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jssfB+3c255uT+GJ7pUQ7JmiEgObqqkEBHAXdn/tBJ1HMbhSnKFGREzVqPM+hOps4GKOAJ2kK8b5Uj89zEXHscWhM9AtLDdO7AXtFehNKRYmgKGPxnhw8wUTl6lDFrDKqCP26oNasFSQuyhtGgqLV2/SKT3d9obvIJdupk3R7UdIOR7w15zgzUScG3gGmPvuUHbb5adPL25Lt64O7+ByEoh0l9ekaC7NyA+g823Vcg6BKqsSIjL+4pLooXnZda453aymFBncAj1AqRiv10OXqFp6Y6/EFRCqeieTZt+WKYBz7agKK+ojP/C78ugpZDrPVWPqL4EId8Y8ZA4pMXlYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=R0IAd8cqG7e+/5JvjMPruZ7DfOFMVy6QW/IpD/6BG5tIpmgg5vT8coPWzZezu64kbBmBhO038mdqyQgWJOKJS9D3AB0F1nigaT8vPCQ3TDB9OkynwVIm2oC7NdorZsuONh7e6uo2NQQc8Ga65MaJ3Isczfs77iZOnvRToPShutuIhp9ZrNE05rNcBo01BmZdubsWhVPvfA9thIwzjKKTAEllt2Kj/QElDZAvztLf7rwDdnwlCnOc8llM8XSKGRl2m2x1ul0OMtXPjABXie4Y+DsqEd0BwQ4WMTTardYGNCYaM8q1LQ8e7ZLzNEDkxdvdIMEYpRPhE9tVyhHcVmwjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UfrzH/IunfwvWi0wQNq7QBSh/4/cVxawpO4pnOr+byF35kUhxuW4L1crRPUraF6AFXAM528yyyiVDDh8eMsJzFqpxjr6SlgDJrEitL4K4ZnTycCSTMxLKvya+FxYyZM+aPLo0NbWPvkLP7eM4H2jSC6yWLp1jeIPALVhELv2xV4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3567.namprd04.prod.outlook.com
 (2603:10b6:803:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 08:12:12 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 08:12:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 07/10] block: don't call invalidate_partition from
 blk_drop_partitions
Thread-Topic: [PATCH 07/10] block: don't call invalidate_partition from
 blk_drop_partitions
Thread-Index: AQHWEi53JBndhotXIEKV74o+SiMNpQ==
Date:   Tue, 14 Apr 2020 08:12:12 +0000
Message-ID: <SN4PR0401MB3598938F35E3F588626B25D79BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200414072902.324936-1-hch@lst.de>
 <20200414072902.324936-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d31211c-fb01-497f-a6df-08d7e04b8976
x-ms-traffictypediagnostic: SN4PR0401MB3567:
x-microsoft-antispam-prvs: <SN4PR0401MB3567F348B9189C9B26D262ED9BDA0@SN4PR0401MB3567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(346002)(39850400004)(376002)(396003)(366004)(26005)(55016002)(5660300002)(9686003)(66476007)(8676002)(8936002)(81156014)(52536014)(4326008)(6506007)(7696005)(66446008)(71200400001)(4270600006)(66556008)(66946007)(76116006)(91956017)(33656002)(64756008)(110136005)(478600001)(54906003)(316002)(19618925003)(86362001)(186003)(2906002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ZqGx7IUTQpdnxxS6PLXVFoDb1eZyLKARgNHGr0fD7MwwY2zWHw5Q/U6DfHP8IBYh4B4H0xFFBCn6RzLFsyBwAekdOUnFFGwO14NvsDtr7hNlqNN3POtN+fSYmhaJWcGlTkWbDQdbVlr14W0ksjW7JnPwkr6z1ZFtTi/NkyZzsAwQ13Hxi9BCsK50mRDv1ol0jMBec4cHwKOTVCvNesPVxTuk8oGGwPCTreW43P2PrBchhzHbdF37l4/aAMVHMygoRgVrQL4triNDr7Rncaol5cDPPdOD3YetiSp7pBLut8I2OfvOOcMHhb7iD6EuTKvYmEesnoiyADO1/8irynetphNnn4JmI0U5vmc1MvHpxYFMSRe7A+RuNL/yf4rpeaviaUPTxP68P/NjH0F2a4MPndey3b6rHu/mi0GFaD7K8FP6v7W9MyCY75B6Oh/7O1C
x-ms-exchange-antispam-messagedata: 2K92bhuzY8Bw5jkRJi7JrAKv42h8Wq9bygl4fJzPiCoqJTlMkwxATMDlwYQy7YwZfebhvX7bTmHtxK2Kio6ZJXfSUQTX4aB3xOANLCMveJLyYiJEvCz+Cb2pLLdCDKzKEQiYVJipKmZAqC1mXngIxg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d31211c-fb01-497f-a6df-08d7e04b8976
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 08:12:12.8108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quhfmkiXGJXVIFbiEYmyBc30bX2Eztnuv1oPFKwE6CQm7HYAXSwwqqaDlbSVGNtk5WQLM3+QWFI+8Wfi51Tg8LWjEntPb9DdVI9S1UzHZS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
