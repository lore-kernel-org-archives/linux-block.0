Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A8C433DF
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 08:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3064C207E8
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 08:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QlN6qrHk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jJV/lK3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgESIfn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 04:35:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1274 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESIfn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 04:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589877342; x=1621413342;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=QlN6qrHk5rko4FdvvY4Csa3rjEK9lYct/0ajHNw39WpeXOyLxSzYA+Ak
   qKEuMHM/ylPlfLpNCwV+T/ZWIOqOHYuVgtZDP/obMjgbvlyAbAKTShVIQ
   cb5Ag4qr7K+c25xja+NZhahYcip7/7QqctxRroJnoWCaNb7TkXMZ2wt2n
   HHRtfhBZRl5fbUbY0MSeDFA+ZY7HpnnRa6aTzwUChCkXA8UWt/NA9vN3g
   IhjzCv2tPR8EfD+xXNgB4I87StvZ1l64OD38gLrzKtyzVI54pN2V3Ai8A
   jTev36IUDG8HHZv+LC9fSF03KZXQMiR4GQ9zQlZAIM1qWMsnrHrVZ11Gg
   A==;
IronPort-SDR: 3BXffMzSziARTJUKJqCoy6dcQCp3P79ALeLqL8gMuMKUDsDgC899EGTWSDWs9ClKv1zJNqXSEe
 pMoHOrGW/nlgPvm/mgtLcMrbI+3Ch+xHsLTlysu3MQdpOsr4kvaLHEbBNHxq/UNwp0pg+C90p6
 mRd9rTSvEEd5eHMw+/KEcwX2lTw0T24GvTalBJ5BKY/oC3hFDJxNtlnBuM1zjufvhA3ahYIwBj
 VxAlI7F707NISqQv1VPFoO8sw73o1JManK4dAD2idDrUkIkuQM4jtWRyQD/3r25f95mgw3AYfb
 ZwA=
X-IronPort-AV: E=Sophos;i="5.73,409,1583164800"; 
   d="scan'208";a="138022347"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 16:35:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiJVLbkpAG1e882dztFgN+gWASPABNTtJhk0VSweElfSuto1jR9IRgGrtQWC7DLuy2th0XpPA/hD25P9BjKPTES4S1IrCTL6guwBBokKgESnTUZYxqbu7H4Ai2lqvEaNZGSuPTSC/BkI12o+75OcytC02tkItDnmcpXLjz7yM9qmAGv70TKd5Zzh+AR+swRTnfj/J4lgZCcLvXIE3vOS6Ai+q7DoinYKfW86tj+pN+UeOLOzioiz2gMbIrEC/s28KodIGYfEkhTmbx0/qRewFZa+CBW6wEPkOoleDDv4DAIlEDnZ7RLV7i+/+m1udoL2tADheg6qz73yogtqtfWEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dM2vrqePeZKD5ilocs9AjsXbZJ3iemSoUol8L+Wm5CMh7SSyOoijCwrg3XB0MhY/DdpNXlP2dOMo/h4K5LP5Vdy/x6MYmIgBzZRHPLdkkRrSOuvepEsKSPqqIqi5LfGHetusshuTUt/5gQso93x220e950KjD0gbzCaXUuuK48URI/y29wng4l4fU6hVAmvpl+kzy0ac8mP80rGqMZOyqvMpCeUvj261++AwHuBfkZt3ErMZkQBPLhJm5vVisWKYmqvGc2t6NgsPiyFnywtM0FtZztCU7KFDtr93qnfasiVRKc4/S7fNOhML9LtbRXc/ey4fYWa5IjfEotXeqm8GYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jJV/lK3HHqVrHIw8UHm0me8qBh7MifsxwifrWBWTP8a11BCn4sI4/bfKOfunzn3HPMqqmn2Me4RiK19YlphXsaLDebqmyAK7sxP4r2WiSR5PPNz404VtDUNlztEBUrdCeBTqzpT5DWyHNpsj6ObG8zE9ZxXKicaVT1V0oM4nu28=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3567.namprd04.prod.outlook.com
 (2603:10b6:803:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 08:35:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 08:35:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v3 2/4] bio.h: Declare the arguments of the bio iteration
 functions const
Thread-Topic: [PATCH v3 2/4] bio.h: Declare the arguments of the bio iteration
 functions const
Thread-Index: AQHWLZMT+Ex/2pkSqEaJzoVehYMZog==
Date:   Tue, 19 May 2020 08:35:40 +0000
Message-ID: <SN4PR0401MB3598FD37B5263FF2EF25C8CC9BB90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200519040737.4531-1-bvanassche@acm.org>
 <20200519040737.4531-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d784986-38a0-483f-1091-08d7fbcf9cc9
x-ms-traffictypediagnostic: SN4PR0401MB3567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3567B34CAE46289ACE1025109BB90@SN4PR0401MB3567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xjcf9xM3EwkrDv/wL5hg9IkKLAUePLd/lb9BYEnhl3SMw4tQPRPCbVyhjp4F+3yRE8EpGUd+VbgOZrLXEypu6SBhitfRou5AYqxOinCsicdhnCnq5Ff0ttibW9uFyFBwjsbPU4C+GfnbmipUnPCzrG0WeGGFONUPDghvXz49XmRgE8L3KV2tPt6eLsTsn/oLqTD8eLZoEu/mavpDj72uKRpLynYV+tPtOlj2A02c8Azk0aYcMlme5BmwPY2xjYmp4HRakeCxPpozMU+bX5fYAcyX1B9U0QILciqIho1HxkRRoPx1Mv4bRe0zuK9v9hZGCkryvXBe52C0PMlNstuv1Ky9wy4UjWovktHaJ35gYFbla2U5rtwzNKgykeHbZVDyNd7i8X9rUZXRPJY3TeZcqHCwEugrTXY9WD3X2dI717lkTqvDYQekZhOXvD4q9elh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(33656002)(478600001)(2906002)(52536014)(86362001)(4270600006)(55016002)(66476007)(66946007)(9686003)(66446008)(64756008)(66556008)(4326008)(91956017)(76116006)(19618925003)(71200400001)(26005)(8676002)(316002)(8936002)(186003)(5660300002)(54906003)(7696005)(110136005)(558084003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pehK58t7KGZ1YCFfm4q8637WxtWG2rWy+NxsfrStkNbvoCEaQV+dHqpcpc3n1d7BavkthkUxVhJetYBTEha5Ba5JBQ3D46cKfg8NUD1+2urLMzqOmicGzz/On51wlboLaNonEodQYIXcgkyNfJ+03SNJbOxZXOKdWYM5jMSgIinCjq+j7DDXgAJIGv19WgCOrnVocn2LCd2N6V5CpwgL7+88lX7pmg2f+u7+UID9wyK1cIUa+pOfUyelDyPoIN5vu/+Mot1oHzDiNAR3EhHjJdPVEZkgJFRw0lyQdglVy7iD2yCQVJHLUke+yPuls0XMz2xFO0G59Ql6yz9+uere3UZdhjAOZ0gny3JwFo2Wi46i/GvyB+prmpbWn8KRBHJEIYSOZgpTBFd7lKS9aPjXh8SqrVnTyLTvQcQLXmiKhY8Yn/915TIjwyX7We0gOFoCmA/04CmEoFvtLxwR3Ssr2yOW5GOMyf1IhkWGy3TSpDTuoMX0UCfCqvADku6jTGjl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d784986-38a0-483f-1091-08d7fbcf9cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 08:35:40.1720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcs2lAHlmTXelEecHqPatAgChH/+ScP0p+aQe6seIVaocibDb0zCl+/N0poF6UCV0Epsr8xj3rBkZe4OE7YPyqCwpiqjwzUcu6U3fESebHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
