Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD9C433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DEE2076A
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YIUNNY6j";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Y339V7RK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgFHGqP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:46:15 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8085 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgFHGqO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 02:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591598774; x=1623134774;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FH++XitmomAzvB2Hk1GzMmeEFEmOae8HdJndApiCCBA=;
  b=YIUNNY6jAn/JnVGhZuBvwHKeTh1yXkzEAkY7pnFWjN2RFTg7P0X2Vsyf
   0IrDcfOGFKHLs/wnS+f+OIiM7fw7Y9SRp0xx5u8A/S14uLR7nOdGwe652
   LJcDt8umk226cV/Q8tNoHwIGzZvqdr+Pna851kzIFId+UQW3d3455g+Qw
   HlmA4ub8AOLKpP3HTVJM9hZLDA36XPGo2mEl7hEgT/ZGZyu+n/09KuPHC
   9vrl+7kOWIpPkgY8oe01E1L1QHNLCwpid2R5PIYTDNoIGJmkw5Gx98i8y
   Vuev4ROCkONaj2C3SKnYxL9KDt+FuthpOyCCfj8MPEad9swXvNC//C68+
   A==;
IronPort-SDR: bPYvfpd/5La2PVy+ZApbFhw1GZjoOqdNdP0JSLbcn8Q2LBc6ns574DemcmEO/JRYkn0asLdkdg
 LnCSl1Tmk2dUd+R4nQz4nvkFFpJSX12lcztSyzSfsm5B4MJfYpEQlN0s8Twac+8KWB3+vfxuhD
 pbsTG/PU+2qA0bmU2HNVbayTvstp4N4iQlx2+mONaPY/WrffyzxUY+g42NlC2JZXRyCCnQVbZs
 NdPOSCsY4sX42yiAUSoSmHZjYceAhdW++JAy5QSz2s2GkFEOuJgAfYv5G8jIM/dDlEsnVsBjq1
 9Bc=
X-IronPort-AV: E=Sophos;i="5.73,487,1583164800"; 
   d="scan'208";a="143749239"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2020 14:46:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP0zRV1FiCJ2/bPmFLAxr8Q7AnySs8ceXLvlpVSL8OL93QGewXZs8qGZRP+aeaIlFkGlV01b6gJuHLYcWn4N38MNc48cwq+oSps36XRJOJCTLBKotQiXxXrcHSKMdiQHAFd+hcfINddaX5RolbtoHpvIU/V+XW4xxtVC8l3lOKuVpv8dcG4Z79vbkDhUgZGFxvUyykbWlGgnrqbErNeba0mpfh7oVazMQY/0NxACCeLubi9KnbERpBEMKcTFOIXTjTWvT01LkMVOLjMDVPWXenXxau+OHOsAkR9XL4qH0uKPHI8ecxp3XDUddd35QPYDtfwWZ4EaChmWjHZuce56wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH++XitmomAzvB2Hk1GzMmeEFEmOae8HdJndApiCCBA=;
 b=gjENPSYMrE34IgvyFWMYln3TYPnkkCVVJ31HtqAwY1ih3XeiQfM492X48+wmKoj7IbzhF9A6lein77No6276Nzlnqn7Nrr6nMdCIzT/VXV5sm9WJqw6hfFGPfqluQGuJJCtwnAZzULXejkJ6P4VslIpnNX5+DEoLE1MxetrH3ffZXvfL9ohv9m4opacGJoUfEDTxOqMCQksUL0N2v42A+jXjBrgxAUhWwD6AWbpA7gy5/deLmbeUsLnrEVXf0UPzv5omX8T4sS+cTIc6vdvcB8muMqHtSWcZyzWIwG2MWuabfl+a8Gk5C5uTNwFo5ew7BzTpuN9yde6rO52v/UwdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH++XitmomAzvB2Hk1GzMmeEFEmOae8HdJndApiCCBA=;
 b=Y339V7RKkYFm5GohzHNFs3+BLMMnfASfQZZqRh3kNqX/hStsBJd+CMN4pFbq/xqW8/xsLrMYioQcyODE1E18rjeZ5anx/+C78unUZTkass3hdhuohaZmIwAKmJIUoXT/FOxjaIBDi8SIyIv54sxoKlsPkPeKL7aM6Vf28tzAtCw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6104.namprd04.prod.outlook.com (2603:10b6:a03:eb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 06:46:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 06:46:11 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 2/2] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Thread-Topic: [PATCH 2/2] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Thread-Index: AQHWO0nTVKpzok/CqEiqr6JtqYA4bQ==
Date:   Mon, 8 Jun 2020 06:46:11 +0000
Message-ID: <BYAPR04MB49650821AB97788DE838E37086850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200605145349.18454-1-jack@suse.cz>
 <20200605145840.1145-2-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c63b311-fe9a-4b0e-5bde-08d80b77a1e0
x-ms-traffictypediagnostic: BYAPR04MB6104:
x-microsoft-antispam-prvs: <BYAPR04MB6104A8655C1C81B11DCF96D586850@BYAPR04MB6104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:67;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SiiwYp6NQ/v1oaVSnlDuzTwdkAnJAsdm+TZyDkOhnOphXehFUUANYBsGec68X5V8wmOgCNDjfGhYwhHJ36cAUF4q/JoSG0I2qZyVH7vZ+XJA0leFZbV8FuWzZXpO/5+BUcc/Vsh0ybq7aDTehxp4Vh5B9FYh+zgq28q4FMKRCpRh0tHCdIq0So22MIZ03V2NI6AYpYGSz7emoIV4NYeE00EFfkMD1bZIWqGHL16aGy52+5CC9a46aWek3oRV/i2Jn3ekBnYAGXzAqL/DlNsv0hicBVC3aOIwj/h1jQX6rAK2mhBAXH0B27CjNkfnnxZgV4TRvnURsfcoGLrB3DzmSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(52536014)(26005)(8936002)(8676002)(4326008)(4744005)(478600001)(54906003)(5660300002)(66446008)(66946007)(64756008)(71200400001)(66556008)(186003)(7696005)(66476007)(110136005)(86362001)(55016002)(76116006)(33656002)(83380400001)(2906002)(9686003)(316002)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: F2n6FOQ/6F8AUUxTMiRUyW8WcPASK+mFptNr1i+qAzi9mJszYZ22/HXI0tYTFeDuzpPSUy2YEQqUWy0BarYGGvP1sRUcR+nk3wjfuURoMEeSPtnQOcfoxmWY/UiNylQehc63TEmomwuCnnhjzovk02noQx4kqpxDnhNsMsjkrqFZPKnZnUXOuhxrkN+bGsnsMf3Qusq0lqN33XGOr31Hg/pxZ1lTdPP5tyajxnjJ2923rQgun0IV3tGco2N6+3VnPGqF6f8T2YyaRQIvfIzwnIxmsklHNYcVUzw8kVaLaJNhiWXey6P+nWU7QzjckI/OY54zSPuvShjgkmueCAPUiLxJIp/ALbq0aFcTufPglM2418MXl+rhfGnpMPW0sxetBml0cE5Uw/cSYRQodD/9b6hukLAHJpLNydFaVYixOa7BW3gHlXLAI7qmXQ/UyHr/lFg6vKKv03w3bknZYxPKf2xA6RsxPU+4iCoM5pyYobM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c63b311-fe9a-4b0e-5bde-08d80b77a1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 06:46:11.6904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOdHyhcUKfd1HTZtgYQyMGRbbVmb1dTJczs7Z42J9yjbEuaP2IxO6cmuyVKwN1QudBQkOv955UQY35KaLL4jilQIj0PyOPZxrmAAf6J3RBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6104
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/5/20 7:58 AM, Jan Kara wrote:=0A=
> Mostly for historical reasons, q->blk_trace is assigned through xchg()=0A=
> and cmpxchg() atomic operations. Although this is correct, sparse=0A=
> complains about this because it violates rcu annotations since commit=0A=
> c780e86dd48e ("blktrace: Protect q->blk_trace with RCU") which started=0A=
> to use rcu for accessing q->blk_trace. Furthermore there's no real need=
=0A=
> for atomic operations anymore since all changes to q->blk_trace happen=0A=
> under q->blk_trace_mutex and since it also makes more sense to check if=
=0A=
> q->blk_trace is set with the mutex held earlier.=0A=
> =0A=
> So let's just replace xchg() with rcu_replace_pointer() and cmpxchg()=0A=
> with explicit check and rcu_assign_pointer(). This makes the code more=0A=
> efficient and sparse happy.=0A=
> =0A=
> Reported-by: kbuild test robot<lkp@intel.com>=0A=
> Signed-off-by: Jan Kara<jack@suse.cz>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
