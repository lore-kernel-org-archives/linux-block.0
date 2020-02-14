Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FF0C352A3
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 01:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7349217F4
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 01:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CXqqI9Kx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cAqnBKL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBNBLM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:11:12 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7692 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbgBNBLL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 20:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581642671; x=1613178671;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uRgnNF37Jq70Je/AhZCAMvP8ODcn+kojEAUKt+gASfQ=;
  b=CXqqI9Kx4YtHudzeYcl+UlIjxIkt3ftH8st7JF36atxhVfrP/hmVBzeA
   EgKuF3C/8dZViFxtX7zSyygxHSB5cyctdY0VLY6TjUWeSoE9sGhPzGYnZ
   1NTGrFeUoZSdw20xLzH59VR8t9l3qQVQxjrf4HoVA9Pg6l067KjbZXfp6
   yejMGdMQjJ2hLD3slCxX5h6YreC4AYk85TiL+QMz765vVoA16fnmyy7vi
   Lufo1dYCDiY4NyvCMVJCpof2//uRHsqNjAKYai4wOjE9E53JvUieIUpl6
   45xUsYN+xVJMmw95GNMNpf3QKCYN6A+FYhQI0G7DKTvzOE8LPguRVGd/+
   w==;
IronPort-SDR: Afa8bnSlpE5jqpJBzqqXEoJAPzJhl0AV9O2gk8G8Kgol6JbE6W/iC/2TPdgsLPgd6xRJv/NmcQ
 fs8OEDnUyV8lHVtmg07EdnGFUKgLj4w080+n/qGiivsWHZnOX1w27wSq8gbcH0Vfm3nmAmaXUS
 SnN25/KCyRBZB01t3ssAeIapHRxlDlK6H3QPN2RDO4DA0+Yisqv2Um6OiR08jklXA+FL9BZ38R
 LPpW8D5ohyqp3hWgdxPGfIMfj6RokassQ6CFL9xSjXmvBnW3LT4zAOm+eUAtjhoqfEmQv+9ksf
 1RU=
X-IronPort-AV: E=Sophos;i="5.70,438,1574092800"; 
   d="scan'208";a="237851796"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2020 09:11:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgGUapend04GgVJ4NBQAbwYuoCmWbNp21NPN6L/In1NWdjgcb0q1Y/gg2EzQwAwLIw44ooHHQPOH5JgO0my6CfyQ+oBR4oNgoJVX8I2luHdWM3WDmZPfylnsrzj0jbTcSAJd4vfHuciT3O4eXw96/lJPEEK3OVNRVTy3yCf/BrrQ2qpFNdO97BAcQ67rwPu3Qseq8sGbUVK555iuF8lj15KxCnA2jiHpS5SusVNgRnbo9hleYMJZURTaxCAKuvIBylsIHSe7LHPhC/xJjwh4gMjB9wKKt10LHeFJl69r7pwUH7IROpssqy22l6HSfAXhb5AYHgyEINGYEHFK24glbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDuNs1F40h4i7pLACZA52/gT/yzuIshOg3whM3eD9gE=;
 b=hxRYo8OuC39/G82VhIr2zgAoNNMIWE+Wl2XO3nzz9YzaktlW5qDOwsIBA63zTDF/Pa2wjfuwtw5sXIZ4UnJttFldP/6rZK8d+/EwvncOKw7MwW3BSvepBRDrfEd8LmEiEwodsxQp6RTyJvV/jyJ6k/d+BGQulx9FS82HnLaSv1zua12DNZsFvkB5Uw1uQ5ZdnvkbscZel4hQI09SSwQWsCa6azRz6OaGj44RzJrAZBgtwBIqYrpqFj9hijuZy2X/T3qI4vz8JflPKkfvkrpcuWkSzwD86dUWyBBIoCduLNL5+T77tVbRhELWkzXwK+MKjbyWQ3fqkM5A7d11r2TsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDuNs1F40h4i7pLACZA52/gT/yzuIshOg3whM3eD9gE=;
 b=cAqnBKL/p0jQP1mC7gJ3ftwVID+WtiJA8AY4jbTmG0eLPRsNRUG3e7SUw4MKsJmwSV1CaLpaOhIsZVbDcP8das1RHukOseAVYQslZCMea6+vAHNxS19mUxsm0WrJyUI5jfAGPETKClTVmt/2TzCkxVBvLVngUlXFY/qSUT6MOa4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB3848.namprd04.prod.outlook.com (52.135.215.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 01:11:08 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 01:11:08 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/5 blktests] nvme: allow target subsys set model
Thread-Topic: [PATCH 3/5 blktests] nvme: allow target subsys set model
Thread-Index: AQHV1vv4m7siuAMmZkO3eWJXbxBdSQ==
Date:   Fri, 14 Feb 2020 01:11:08 +0000
Message-ID: <BYAPR04MB57490C8BCDC4A7828807C01986150@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-4-chaitanya.kulkarni@wdc.com>
 <20200211220003.GD100751@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 801a3c4a-4528-4c43-d96e-08d7b0eac622
x-ms-traffictypediagnostic: BYAPR04MB3848:
x-microsoft-antispam-prvs: <BYAPR04MB38485FECF06A15E2DCD5BF7686150@BYAPR04MB3848.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(199004)(189003)(5660300002)(8936002)(52536014)(55016002)(8676002)(4326008)(478600001)(81156014)(9686003)(81166006)(2906002)(4744005)(6916009)(7696005)(316002)(54906003)(53546011)(6506007)(186003)(26005)(86362001)(66556008)(66476007)(33656002)(66946007)(66446008)(76116006)(71200400001)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3848;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4niQ71YXCsy+nu+lxKOq7WMkLlIOWNVfKTIPdEUmtdwV/cn3Kqt0stjAs+TEi9TLHCznpz0uzQdqbfXKjiks7vHGuM3f+LuTgEzeJBfx4lRhd1PR6UHLa+q1TREhgz+l69WkoyqNiJQyO8sC5mvg8gcn9x5wOU8r7aEIPnEfNdZ8k9OcG4mUhK27X4DfIJjNkLrKwkVWL/zcNLuP4de9H4xQ2xQtMhPbCYZaIm5yUOXaKdhpXZdWSGD7e79VLMurp3It7qxgE7P9wI32UjYWy8RGqSHWi4sWTRHcqEsX2digdWekPMnrca+S765nSMV1hijcRcKzF+eM3puWoMD8UhP2TmJ8707lzv05A+oz4C0jdLh1PA/kW+bYBWQDkeH87dhdgdOtDLx0cND5vjnZYXYgCS6Jp+uXlVzsGajS/66dbRBZqv3ZFOqiSdakOeqU
x-ms-exchange-antispam-messagedata: 3F9ngH6msxKlevbPIiRpxU799RhH4KIke1M2xqd6UmYHQsC+h6LtJIUqdFcysOMPKKo2dGWiFHdNy32+EufQzEFKLgZ/mwDGr7LYAiYS9l/CPZOP4YNg6UcXYIdQVG/jlz1274OyjQbWvBQBujVfKA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801a3c4a-4528-4c43-d96e-08d7b0eac622
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 01:11:08.8173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbu2uZHTbJdHZmTh8Ysth4MQN4e+mtthjsjIF68c955s1ZybvavsgbRv9SqiCxnFBVddjXQDJu1pBlSXVH3D1QQghxSF7Kfee0U2NpVE7xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3848
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/11/2020 02:00 PM, Omar Sandoval wrote:=0A=
>>   	fi=0A=
> It's not in the git diff context, but the line above is=0A=
>=0A=
> 	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then=0A=
>=0A=
> So if we pass 6 arguments, the cntlid arguments are ignored? These=0A=
> checks should probably be -ge=0A=
>=0A=
=0A=
With the -ge change it will also print wrong skip reason for 034=0A=
I remember now I think that is the reason why kept it -eq :-=0A=
=0A=
Here is with -ge :-=0A=
=0A=
blktests (master) # ./check tests/nvme/033=0A=
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]=0A=
     attr_cntlid_[min|max] not found=0A=
blktests (master) # ./check tests/nvme/034=0A=
nvme/034 (Test NVMeOF target model attribute)                [not run]=0A=
     attr_cntlid_[min|max] not found=0A=
=0A=
With -eq :-=0A=
=0A=
blktests (master) # ./check tests/nvme/033=0A=
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]=0A=
     attr_cntlid_[min|max] not found=0A=
blktests (master) # ./check tests/nvme/034=0A=
nvme/034 (Test NVMeOF target model attribute)                [not run]=0A=
     attr_model not found=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
