Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2105C433DF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 00:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642F02078D
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 00:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Taw7Ctb1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yxskC+QS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbgFYAQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:16:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55110 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388204AbgFYAQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 20:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593044197; x=1624580197;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=H2XU5wTkKvOYVh3rDudH0uSP9BpW7Jp0nVhA8OaV9dI=;
  b=Taw7Ctb1o10IjwoMXe7TZeC2/dDXcBfuNFy63UUZ16bRxh8DWg/ToVOe
   o8C3h6saTxSdiqZbk+jNjaYAugG1kBowyw23ik5/hx00E0d0+c1S/9k+2
   TKIu+v0PXzt7rYMBzF3TBUpJmS0WtoXLp7esPA/XnAgY8To8kp+BkKvUO
   PcK2Xmj04ZS2tEO0RAAC/ugdJrqpdOBJ1SHagyjvsgyQcTGCyeRqlpwDM
   JDua0GolUNs6VeE18L3oNIxc3rOpbg7Eh8PV0eWgBgDF2Q24ORwEqFC1l
   hFBtnMiEJywYak6CMtFZg5qc+lygKZpK25kFPJ7NJXeV8sMsHTen9uq36
   Q==;
IronPort-SDR: IrUBI9PX3IO+S1BmID/mw51tDoc/9AuF5rirK2uGMVmZMUTZ6UUfTrUh4dQ+4ycfnz6fTVH2n5
 ylmmRTEeyhvN921Gyex/afZ+aOPSo7szYiZf9vD7JQIsSejUW78d/tqGkKIx1KH40BlDm6gkk4
 Zo3LZoh4blzXjoXLwMtGoCpvCrwh2anrDe+Ju8iOTaTKBBdjun4GklCEWc5XXiUSVe5CvOURm2
 yzNLnfLbr94mE1ROVXlNcs49kpCRNPYEOJzhcNB1ZcJ0FxrqP+6kmPeZOmsBS2fB3TwUnNJGg3
 TOU=
X-IronPort-AV: E=Sophos;i="5.75,277,1589212800"; 
   d="scan'208";a="142219400"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2020 08:16:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRcIn/+bG3kHl4ZmVcHTOY0wTuccx4IfaAniL3f5lDY71zABaJvW60h90/TbAKnP5VHfXuCW15Aa11nvAPAFWgDilXf+K+GAoDGkpiwHJHOkQMOuUrUxaL86FJI291DI4GyFf8V6lugn4TQFvqcuNlFsldSwWXmsRGFqmbxC25U9sfrLBO5cNTasVUGxd1o5osIHgJon+nIOFp45VJpKAhX+liusvOZ87ay2YznbdQ7SGFm7Inp7tUp6y2hlfm6mWvge4yimQKvqCA5yl+3lviJrzdS/c+VAWh2L/cQYSRlloUR80px/dv7tAwjVbMrrkYORg+aSeum2RVL7n+Gd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEQIT7up3sUFnsWpadmcW7HX1n3UjrwLq2mUNfjt/7M=;
 b=NgFEuU/7RrouY29iawD2uyp1+k1S5gdXM+xAgUDqLa6UMtB+7ZiCbin1x/jRD78OkBK3wpcZ4xVQanuQqEmVgbNluhjk+bEudkQCJK0c3D5EFlxMkCJOrLZFbYgMHjgmPgYXYD2dDDMeS9he9ZP6USbfdEwpCP6CAcp253SzfW+FCABtJ7a2pQk0X80aiAm/Rnkksc3yMxJnToLhE0knw4ngkDgaeCIzRGXL1oR0y44l7IylYz5w4zrRwqtccDN0ewzclluFFam1th059ZcTP/JnowrHcDUkTD8pQmEGZzwVX6M0SU7iIz3ZSchLriKhqnpGby1ezntkDUTmgNmMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEQIT7up3sUFnsWpadmcW7HX1n3UjrwLq2mUNfjt/7M=;
 b=yxskC+QSRdCGL/0aZgBNLQyMk/0LUXbYLElVS685t186ny1Mfcpewqw/AxDbdp+wj23QZDuuMxXtdvRp+P6alK49T0y7nFwPqHiP5BcUARjhSlOzYvVbjP2xNSpET+Jqjxq8vdjckJOmOGdfWUs7ZzeDaQK4O7iBCjw0kQEaOTA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5688.namprd04.prod.outlook.com (2603:10b6:a03:104::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 25 Jun
 2020 00:16:34 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 00:16:34 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Zheng Bin <zhengbin13@huawei.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>
CC:     "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH] nbd: Fix memory leak in nbd_add_socket
Thread-Topic: [PATCH] nbd: Fix memory leak in nbd_add_socket
Thread-Index: AQHWQJeM98l6P3mjQEyVy7uJBBSzVw==
Date:   Thu, 25 Jun 2020 00:16:33 +0000
Message-ID: <BYAPR04MB4965BCC5D59A22A417274A5486920@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200612090437.77977-1-zhengbin13@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 829d15ac-de8e-4857-84a7-08d8189d04ab
x-ms-traffictypediagnostic: BYAPR04MB5688:
x-microsoft-antispam-prvs: <BYAPR04MB56887A3258BCEC42BA68021886920@BYAPR04MB5688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2IjDf+UjW6ic6IACdNNyU3kKrrp/WrLibIh3zUUBirZU96vqbMWDQ1p4W2vMp3cwuIDh+wegyMY39r2lhGLkW55zDdhIkiyTVzTZEUVaN/A3vT6C3GnPb3yIrO9NZCpTE7ZPOslF9bpDla2GMkcw6itSGPVImSnuWJpAO6+V8nl4kCNTIpTrCVvrf4xYHlSmJ/lQAJGb5OMgFsFTMrqz0B023YWLKKHhnSFQ5Peg3HPCPNj1ZGWu5/csxRYTePG91cuV63iGWgVsEZG1GDKkhdvXLZKoTT7dQxMK1wt8bEssIxXraR45TBG5e9o6n/3A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(52536014)(6506007)(53546011)(186003)(86362001)(76116006)(5660300002)(26005)(83380400001)(66946007)(66476007)(66556008)(110136005)(2906002)(64756008)(33656002)(478600001)(66446008)(4326008)(8936002)(8676002)(9686003)(55016002)(7696005)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LgW3mLW39/0W5TI/nJOZhrUXspL+Kga5NrD6eZkPwDg/tryyggqQBxxT0tA47bQpzGGEmG6/oCqqeb6JcNpvqDUhUlTU/MCXj1Y8qi4qZgpmY87u2qKdVhPv99jXnOQYqFPyQTM4prTjLD66/JqCr3lbhqxOUMHmLtDVPeow57bmvZ6c6oaSEIKYCAJ+pVcbazfGo15S6rtLZyLGlh2guEXi/VnF25beR1x/NI7mChQDuuORW7ZLxvgOBJ6mxG5Ky5N0IQJIGGnrRD7Xg5ooJrzvSWVUjbdL6X4VKv9SYTsHBF6WFeMdo+dCo/rSDDMuzMdJ4M/RwHRCIYrjD9BNS1vNT/VeoqIqIQ4FD9Ua4vNUKzORBr2u6+4skEQ8MELve8hXS1JvNdecNlj1K80apQsDB07sh2cNc0VGQZIhWq/FXAJGqK9DbN7jqs36HQHs+5NVTvSFM8MuXIJhxFeeMzjl7Dq44NCHkFB41bXd15Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829d15ac-de8e-4857-84a7-08d8189d04ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 00:16:33.8917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvIgkF2Wqt8h0neD8Ugev81PPGv41wpYdT2FKJiYWdgdqFoFEPGiySBPZZMdbXvIszDV/ZLt9Vtz9j5dJDyEbrdz9h0ijvg+JmF6ZIZCP7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5688
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/12/20 1:57 AM, Zheng Bin wrote:=0A=
> nbd_add_socket=0A=
>    socks =3D krealloc(num_connections+1) -->if num_connections is 0, allo=
c 1=0A=
>    nsock =3D kzalloc                     -->If fail, will return=0A=
> =0A=
> nbd_config_put=0A=
>    if (config->num_connections)        -->0, not free=0A=
>      kfree(config->socks)=0A=
> =0A=
> Thus memleak happens, this patch fixes that.=0A=
> =0A=
> Signed-off-by: Zheng Bin<zhengbin13@huawei.com>=0A=
=0A=
Not an nbd expert but wouldn't it be easier use following which matches =0A=
the + 1 in the nbd_add_socket() :-=0A=
=0A=
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c=0A=
index 01794cd2b6ca..e67c790039c9 100644=0A=
--- a/drivers/block/nbd.c=0A=
+++ b/drivers/block/nbd.c=0A=
@@ -1209,9 +1209,9 @@ static void nbd_config_put(struct nbd_device *nbd)=0A=
                         device_remove_file(disk_to_dev(nbd->disk), =0A=
&pid_attr);=0A=
                 nbd->task_recv =3D NULL;=0A=
                 nbd_clear_sock(nbd);=0A=
-               if (config->num_connections) {=0A=
+               if (config->num_connections + 1) {=0A=
                         int i;=0A=
-                       for (i =3D 0; i < config->num_connections; i++) {=
=0A=
+                       for (i =3D 0; i < (config->num_connections + 1); =
=0A=
i++) {=0A=
                                 sockfd_put(config->socks[i]->sock);=0A=
                                 kfree(config->socks[i]);=0A=
                         }=0A=
