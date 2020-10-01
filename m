Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6D4C4727C
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04AA20848
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BzosTm90";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b6iWcEB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgJAKZ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 06:25:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7412 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAKZ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 06:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601547928; x=1633083928;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WOVkjGXHFk+v7SlOBVaub/ruBY7dgaKvhG9nBVKtB+0=;
  b=BzosTm904TCOvwR17sNsdyNQxxM5WFR+r6tAPVtHAm/PYKoPsUYNXV+a
   0ILC+kp0Q5uYMexgXCg3owBnW2kYqOlNLm1NCUFFirNaWNf6tHV9OddeI
   wQgsm4JQNKMvlApYlzctgq4bFOS1YkJZY8gKJqcvJB+7JPeWx3V2RBDYy
   TDSH3jRXlDlUXXMZAbthJzctC3HEapuibhDoMwWO5U2DQ7tKQLBzPYWHa
   VwskESpyarsnWJAS+3CJ9xIp1gm74zwuZFmFcgpXIWRUKZs771IFBv7sE
   V7WepU/eCTIgsJEE5wWZLWB5mHHwL3pk9M7gNMvxJSSV06RyvcRnfq0uE
   A==;
IronPort-SDR: r2SNJdK/3edEK3a9JGnfBQODQRPBYcSkCmGNmYnfytmX93E3tTZRvtQLXvTwiKHrTRDkdr/dQW
 ig+NNGzOIW4mZGAwm6mxQgadm6k7bho3iIYp4iDoFrF/0g9n2Xl3p/KYaRPosNDrHM3HHUtnRw
 O6IQzzPNtKRvxiWzHXp5SY5FCPD3f5eaCvUKMOHrPWCmTfVmHOj+spmaliJFcdn89P4SOMa6Hr
 LWVsiFqTa0mLPUutmDl0IpWSbOpeMBsjlsdVmE0IAigIok81VJXGw3FdpkWUClm0syT4chQJEk
 ZD4=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; 
   d="scan'208";a="149982474"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 18:25:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVnr8/aBedqPmTxcy90DHMfxhjxglkUIPtCPD+kg8wpSMvQCHRYxfNWRAEWStfcD6j98DbCeBXYt3iiQ0bgifKrQXZd+DPL/yy0+0HY98FKPamw2A+kDkqffm4WERDMwYLtKN6091kPy2EzEu9EiSJ1nthIpOS3TUnyzOPYxqYhFIzRRfAhKH54ZHWSTfhFOwMdR026SKKlpXxO9hsWjgV0fsvT2ghgjahgF0C9uN/6LSORPVOMyNo5MNjo0AOwQ09w89zgB1ir6D/C4tmcl5WuhjvEVPsaEyCiF/tsYgRjEYA1API9hsv4QWzwMDYn64SOGRAr76cJ1fkHpQCTqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOVkjGXHFk+v7SlOBVaub/ruBY7dgaKvhG9nBVKtB+0=;
 b=VlIYKM5iVlid2qxQ7kmqHxPbd12h6j1zAdR+mlup0uFIpkh+6CfJ7ZWrdt31UinnmJJBsBJ8EL6/JXy4ZJZ999E5jidObgAWFsVBRo6yCvSfWk4uB1AXRAvjXT+ipQPDv4c4UqjRfFQ9rpr2mh7kKYvislX2iXejR9mHhCfr8i/KNIq9Gsg/KZPNdmEyWwunSyqvYv9B4tNq9GRSIg9jS/tQC+gM34Oexr5sKm8vrQQQSFW3kxh0EiVyjlor97jObICIZFASWKricdG7ZPGdDjZqkDZUJuTchtR5/u0P3jiqMj/a+Ir8XjZRB31kp+PhYbkHJ8n6eP+XN1i53wzyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOVkjGXHFk+v7SlOBVaub/ruBY7dgaKvhG9nBVKtB+0=;
 b=b6iWcEB9OrxXkw8ihM0cItu9GJqiGPyUXYvMXG6CdcxNyd8XRWrkCwSIj9k86vSoJkhLWL5hl6JTejyAIzftk7qgtaobfEu1jz1+8tqJwoLpfZuIflnvtVUfN0T5bbRPQyf+FVjSGRva27HeFTaMu+Cu34tIJ+XzsrOzCVN8N3Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4464.namprd04.prod.outlook.com
 (2603:10b6:805:b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 10:25:17 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3412.029; Thu, 1 Oct 2020
 10:25:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 2/3] block/004: Provide max_active_zones to fio
 command
Thread-Topic: [PATCH blktests 2/3] block/004: Provide max_active_zones to fio
 command
Thread-Index: AQHWl9vSwdbuppVm70Sx2ne+wZj2Nw==
Date:   Thu, 1 Oct 2020 10:25:17 +0000
Message-ID: <SN4PR0401MB3598A42EB801A3797A7B8C799B300@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201001101531.333879-1-shinichiro.kawasaki@wdc.com>
 <20201001101531.333879-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:a4b7:4173:7208:fe59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87832be0-322d-4d4f-4272-08d865f44ac6
x-ms-traffictypediagnostic: SN6PR04MB4464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB44642D4641C7C2D33809EDF89B300@SN6PR04MB4464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dsYkP+1cZSjjHZasjSUg+XanWzZpKK6pl4EI8CXgr21LueuZvrOgPPGl9jlGjZ8boOqOI9MN3Xahdrpl52Tj9AdQFOpuZvn3mbpfaq7KQTDS+lERgIr19/DqbrsXCGy/ZcDiHZRX31b8mXmbjcRwo3C6TnudBt+6jrC6RRBAwH567A29xai9qsX5kAKkpNUoPLh/HI1eLGzrcR+PggAdrS3mQsY8XABbJMDqct5z3gg8d7A3rLJiBg3Iy7ybKomb+Rdsfdb9tVQPXuUWB0VifETzpFJBikw93lAPQmJ/OtUMc39+wsQGOgJdXVFTpDiPLBtw5qoXkOAazGpputDKmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(316002)(71200400001)(186003)(54906003)(83380400001)(53546011)(7696005)(6506007)(110136005)(91956017)(2906002)(478600001)(33656002)(76116006)(55016002)(4744005)(86362001)(9686003)(5660300002)(66446008)(8936002)(8676002)(66476007)(52536014)(64756008)(66556008)(4326008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gJNO3FAWSfVho0RmphNVSfTKsZve7BFBuLS07PhMrJrdUARO80wF8mocJ6+cfeXzFZNHhpQx3nGOzwkehF1GHi0I1wQb+Xene+HtN0+Se/8SyyufY47rFDBz2agNLwb9mlz0jSgnIPbLiqi0PlkWkZi2L78AeDttjmPqiPlBnNEckXrZmND7y17LmiClkDCK3OCcc7F7MUzyEJ4z4Jm62V4KgJUeel937zR8vFIGZ7X/m+ICBPnbECN4Bg5R3RaWYrzcGvgx4E1TB1PGx1jQG1KGT3VManQ/f/kIuP4dsFNJ+uNPDXqA1M9mQCcHGAGd2eAZUKxv0aUfwmRpDx1oEISCk6rnlyNKALQMHoGt3IdbtZxxsaQbWYEe+lfVkz9mqkMsvHXIo91O7zY13cNfj5fH42Cvb71DhQ0yDMIrRc+0IcP7jGM39qszyjyocWa3JAvgiz7gfsoJmtGkFuUWaMXjKjvP+5Jpk0Za2SkvBK+RFRn3XzbZtDDWkutP+/P5ZP6R7EBMS0AteW1PcvHMQWEI1eA6CDRcYMi2j+KYbsGKJIV8qw+C3UvEOfQ5QYOKxVYOz5ShSxgBRdUspoe48JonhA9TZevDyuiBxbURM3Qqa26Rw5V6L0V5Tkc6wryxrYncLaJ8zgW+VoHqwjkfomslZrsdIzN2PBhANPSO6etbcnBQsw1viG4Deyy6jvqrwFM/pr2yHNVdHnNRpLX1JQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87832be0-322d-4d4f-4272-08d865f44ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 10:25:17.1849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1PQLofJo7CwOnlRlHHk2lzzEKgyJ/Cr05Y9pI5GwkeHkpvHRVADRP4DgQ8fYpHrX8PGFivRdk8oksmuYHmNhwU7P1i8cNZoflJAImRAUMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4464
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/10/2020 12:15, Shin'ichiro Kawasaki wrote:=0A=
> If the test target devices is a zoned block device with max_active_zones=
=0A=
> limit, the fio command in block/004 opens zones beyond the limit and=0A=
> fails with I/O errors.=0A=
> =0A=
> To avoid the failure, pass the limit value to fio using --max_open_zones=
=0A=
> option. This option, which was introduced to fio together with=0A=
> zonemode=3Dzbd, keeps the number of open zones within the specified value=
.=0A=
=0A=
What happens if I use a fio version that does not have the --max_open_zones=
 =0A=
option defined?=0A=
