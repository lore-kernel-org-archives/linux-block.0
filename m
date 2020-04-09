Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90670C2BA2B
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 11:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE2820771
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 11:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WD/HTYzx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Yn3oTxxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDILaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:30:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21772 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDILaW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Apr 2020 07:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586431821; x=1617967821;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=revMY0xGup8Wqku2FK+lC7NaehjoPSrf9E5bPWdMmU4=;
  b=WD/HTYzxoUC+B63YwtB/OyJWUUWQCcryL2JdM3KV/ymVuggaiFbeQf4J
   rKkaocl3hMBtc4rdHt3zVyCriP1ZPf9N1q5dYUgfm95VUixobOwfkWqvQ
   rPJ3cftDhcB4LIOemSYqM6CXksiXR0oq4GT840ASsrhVQ/OTxN+H+h/tx
   2HaRKDY61+ligxnnEMr0BKyyM9gElb1lSV8dunkwdtWN1zHs0/qJ11lGH
   w3gQlbUwwcfzktOmZpOf4/kpub9uMcfDuzYPj+IF8EbMne+6dPoWK6+NW
   dphk7RjbUPTw8+anPBOWcASGWyzI7+qTlW/f4sYoZNEi2AMu8lJNb+mtQ
   g==;
IronPort-SDR: iOgl67pml6T7MbWmhj93PUUKgUkIRxQN2ClNq0euWAV+Wm3gcG3xl7s3zi1+1CkC137HbNKOjL
 1TrXvFRG/Ttw4N1hHUXZTFcCvPJjdr2XVJBDiCybUejO/ZfYVKCMsVMLaHLxR4YII4W0AIBEAP
 iqp6tFT6W501L4uP+bDpjIIIebAo5Wl2pvyY2OMlCR4A+aMeHhWzi0uHrGk1ywiyS3hwPmwMIF
 sFnWDkXjm0XUwy+Bkm4hI6GOe92cDr1b0wXoRlxuQAMZIjlcS6/PdFtGsLwEokE85brdZc2U63
 WaQ=
X-IronPort-AV: E=Sophos;i="5.72,362,1580745600"; 
   d="scan'208";a="134955381"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 19:30:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAj9j0TO+kEe0l9mnBoScoAfQQ2LTSmLHCrLaclgvH4TxsEKVG4WiAIf1xHv13Cfhm+hw4dQB6hbv9za3jUZpLdi0U1R5Tfu7XdhjY64PYTskwNE/ih1ZmKXamNcKtriZcT2BuUQcNAU+3xPdYkSWwgAScJNidGemZjy1LCPRF628WNkIfOpKZoxCBckkuORcRi03EwqLlDd+H1eXf6TJPC9NEpntWrC2hbHkRs17g2YdsIPpTVuCX3RCQ9V9oLdzLpWOk4/SgD3wvgtNANcZGIbLZKaSyo4ltTfLXk2tjYMcM+HZUyFWFbddr97bcV5n8ohgX3R99deVyKYAFIHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H+3lX6t7fp0eR5WJOcOkEsQqIQyP2WsJ+9AsHCvhW0=;
 b=kj7S7znFZfMdPlpBZER/9c8XipXrQeVz1rvZdC9+o5KFCurnj4qlAD8lYWFO1LiiCHcLMIHyZGuyAmkPxuMDUU2MnpCLzZeOwoTm7il6LL8+zQ8qH8Xkr2OQ0CR1Xwv1uVDXTuzMh2WVrKVNBRkwoMd3BGRXYDRxfz5XykfjOClGL9/deP2OUD6P3poOV26AUXP/RZgYHXfXd5UEgXhjwisoMAcHQz4ah2dmY7OaLOvNTbf0sKF67MGH3yP4O2maGz1dY99BKqoUxaYMyyeFvWYSMD9grzc8a9TUtvBqIYbxJAk//Ph/eJX1s2tdxe9irwWSF60SQa8xEhP16ewOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H+3lX6t7fp0eR5WJOcOkEsQqIQyP2WsJ+9AsHCvhW0=;
 b=Yn3oTxxIgaFUANcC/atK3LuNB2BPDNdp6A/oxcKTeOc3O/8g0xZJC6TMVWJTefMlAUZu1pIz3ZTxrCVrD6ikcVxazEnEB9cJIybyfU66CbZDGdhBIYSc1fAWFUwfPpULnGTUNBfcostoZHcNEeF/Pq4iYLfoJlcSQNq3oB5G8MI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3678.namprd04.prod.outlook.com
 (2603:10b6:803:47::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Thu, 9 Apr
 2020 11:30:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 11:30:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 03/10] block: cleanup hd_struct freeing
Thread-Topic: [PATCH 03/10] block: cleanup hd_struct freeing
Thread-Index: AQHWDd5DPQ0fMg98V0eqFtmGzBHrLQ==
Date:   Thu, 9 Apr 2020 11:30:19 +0000
Message-ID: <SN4PR0401MB3598FDA8DB67BE8337A4C16B9BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5b42606-8600-4ed9-9b8b-08d7dc7962aa
x-ms-traffictypediagnostic: SN4PR0401MB3678:
x-microsoft-antispam-prvs: <SN4PR0401MB3678D9338B0E5F17222B7EDF9BC10@SN4PR0401MB3678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(26005)(2906002)(8676002)(66476007)(52536014)(66946007)(91956017)(5660300002)(316002)(81156014)(4744005)(64756008)(6506007)(66556008)(7696005)(66446008)(54906003)(76116006)(8936002)(478600001)(55016002)(9686003)(110136005)(71200400001)(186003)(81166007)(53546011)(4326008)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pEKcOvPbKi+5rs2+UaQu+Y9bBU8vYsI8v+ExO7b+ysDlWdMLl2k0vX+6LQUU0FtT7nM6PW+2jPZmhQwXroPXx4vzBtnHI8Ad/Nh6GN23hpTPJdinRBA3Cb8RGbH/3mLG01JBnjpLHkhqhm0+1sJ3Ly+ldTUKyHCC5ickVSFyKml8D/OcsmQa45naXyGiJCeazEgVMVy32jecNNPj+i7Fi/mCz27escFAUWBcNfyclYh9dy+IIwtfKVmSV2cJYpeZGqIorXL+TOPzPtpBsUUlKDe6x8IANV5iD/zUc1Hn/0x4xAZb/yZdWiqH443JrDa2RKoeKYloHWvIpTmA6EdxPmDWUJ/+0mDKTwRJ3SY4HhZTTB4BFa0czAk72VH4KVrCX07ETefAPbyoy7i6HT2UToomlJGzRV9T3kIwFidE0+L3sBtgArfOduMscjXiMnRM
x-ms-exchange-antispam-messagedata: E6RtKSWWZ/SCHz+Vjcss3/5UeTulbiRBH0kgJ1zJA0l/sXIqkSSCM/aglwWsjKrEWAhXpuG1Nui4x7YttMKCkwcj83CfpX0VqocHYgUxdGGdc7+8mF8BSbIzIr48JmGbrqGNGsJLI+Trvh75Zs+kZg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b42606-8600-4ed9-9b8b-08d7dc7962aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 11:30:19.8757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPhuXQT7/39sHVX5ZWMpBT+bGRffkxOOorMEXxCTwV14GYpIknktV41CB6fhd2hoGn4StH8ss8pqaD8fo1QKYzWq+v2oqYvta4MOqzLcFDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3678
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/04/2020 21:45, Christoph Hellwig wrote:=0A=
> -	struct hd_struct *part =3D container_of(to_rcu_work(work), struct hd_st=
ruct,=0A=
> -					rcu_work);=0A=
> +	struct hd_struct *part =3D=0A=
> +		container_of(to_rcu_work(work), struct hd_struct, rcu_work);=0A=
=0A=
That looks like an unneeded white space only change=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
