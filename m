Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB4AC2D0A8
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 09:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79C7221EC
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 09:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eEuyMeg4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fOvKM+Jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1JNJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Sep 2020 05:13:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62364 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgI1JNJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 05:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601284389; x=1632820389;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UJGPf8BGtsZwFuarWNqJq17vJM3ze3cl/dICcPO4L38=;
  b=eEuyMeg49Z2i9f7vpwh6jCUNqQMaLowu4SLSNDUca4unj/qMLD6eR6VN
   JXh1DvJVSYOXTYGQXSEUnCrQeAguae1w/ijGFFQSOOh2L5ibN9dWOCTId
   LkUt3xQw8EMKuE9Q0KSP2v7/VaAnSe4RR/527ko6Z+TwjirONCVB3E9tz
   mxr/bHs4HoPRrTBOPx+xn+6CMp42QC5Hfr9sAu93amskvjDcdnnhvXzu6
   xYWJTS8/Rfn4aBm9N5mX1ZXZd0zE/VJBCifc3ck5QZY8VUHLuAIdDCobs
   7rRP+zfsl5DKsHyGH/g5PWVJss5JSINSiXYAfHhYIAiM9jaroUp6IX7PY
   w==;
IronPort-SDR: kj+IEJCZxfpyeemfXrriqgtZDrWQ8LQ69CFxnS/EdNmM3TG0TIVumHf/rkjVWDofS+UwlTdHaH
 ceEa0+d3FvF40CQ51M+kDGr+a9zbl4mOLfhuKKZvoMkPel0ue1kNZ7P9ctlrBkzsv+V2k2L2dV
 jeO8BaLXh1lyUl9COC7w6JO0rJGwP93WfvJsHduw+jbMXMIyq0OC9fv0iCIpyU09DCFAQV5Euw
 PCJdH2+rIlg3ppYi1empn70BA/pmjirY3cHVG132mY0Y7eG4G3fJ7elXty/6LykozmKx5RRWc+
 jWs=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; 
   d="scan'208";a="148345534"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 17:13:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdXFVIzXbtMl5yFMbfjyiUSqM09FNGoSJm4ozH/gfIfvGNZphGzMusxANtFW0Mcw/m0zR5bAa6TfCea54QniYx8bK0joy0Vf0XgH1gvEGUJHt49BImekztecMom5mgdX5OzfAP+OatArZC9atm7B34eweAulTjr7NRCjdJCnXN6inZvPLXX4uZg+ZCb6qjvZ4w8v4RMFl5vtbJ9SfR/asmxTWLzX8Qmk8OxpF7Pbo1vIPyNDtp1+9I+KMmJkG4p5h2nY2Zi0HEnuvg6YZEGKXQAUg3lSsS+hQMdyKxJthNI2xvGUxDa6C+hZEwISX9jqCbknkNniMP8rIJ6irSmhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyStwXpQ6o3bdDKlbBl5oPSHomXQVZqr3WBoVpumWxs=;
 b=J+Tmyry4FHiV7Qg3QLgZ8w+CQYF3+Z9O0O0EKYwMDA50bTgehJI/JFci5Rdmpj5S6zkKR8b+n+ZRsiDEisv/o+vk2YJXJuavO3aRQmlQI9vl+nF33W9u2Qtc5YqD+daYvoejNqKqaYdCTl0J4i0hyAAMNE1tJvxfpQylzs26Mf4B6v6a1XiSw9mSPLEepdX9PaO1LVqIkQSHK2SK9A5JIG7cFoAEx1nJVIYXXoWOk3VTYmzn7PDjZ7n1dgirjUt+ATFTs+04EO3zQIf+9jdVZtNsUJJRqwDC5EE650foiMinCNoPmhbmDR4ysyO2eIQc9Hr8ldXrOuPSwhtFCIo5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyStwXpQ6o3bdDKlbBl5oPSHomXQVZqr3WBoVpumWxs=;
 b=fOvKM+JdEipu8Hs9WzJ09nNgSQCqzCbxDblXeztXr/SwpHPjtSXtel49z0T8CwvEwow94vjeHncP15Xc6MkHWx9iCrPcPZi6JisxkGAK6b/SchMUIWLhLrTW9KBhvXmZtw/5yYwROaVxHVQPAkdMrOTLvSwj5CH3HL5kOWfuVEo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (10.172.142.14) by
 CY4PR04MB0345.namprd04.prod.outlook.com (10.168.169.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.25; Mon, 28 Sep 2020 09:13:07 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 09:13:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [GIT PULL] nvme updates for 5.10
Thread-Topic: [GIT PULL] nvme updates for 5.10
Thread-Index: AQHWlJ8pb2J1rHdCcEWtcKUFLcesqw==
Date:   Mon, 28 Sep 2020 09:13:07 +0000
Message-ID: <CY4PR04MB375113383F128C96A4CC8F01E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200927072343.GA381603@infradead.org>
 <CY4PR04MB3751593431168AD25F312A1CE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200928060333.GA7431@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dead56b2-3c94-49a6-cad3-08d8638eb685
x-ms-traffictypediagnostic: CY4PR04MB0345:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <CY4PR04MB0345E15CAC0BF5D74C39EAAFE7350@CY4PR04MB0345.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g6wIdkP/75h6M6vbMnCT5yeb1HPx3tyzicslCQ6JCt/HjVRL+a3xXHvnNgKXmrINenqv2mfUGKtithzFI/XCaw61i54FClera4K0ZHJIe4kmLKlUpK4lPiEdr7AAdNiKqUlT730e1wTj34/lVzRNalryz5aJ6LNqPPylmaH7E8OWvHUPRIV0FN8+TEWw2N42rHRR0ueygncdR+yN7VwDJZec2UsjKeoawkLfw3N9zFzXHjqwlGLLIeSRO+FxdJhOC9PblJkNv3zMklh57/Y1FcYN/Wjshfi8xDxvAXPDk66VRFp3FHQra5bPu1CS5l87Kebf0aXaSwi+nBTVRo0qC0VyiYrqb9eOh+ejDUnjNVPdpG1GTVFesccV1tUmQjCh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(8676002)(8936002)(316002)(4326008)(5660300002)(2906002)(6916009)(52536014)(9686003)(54906003)(55016002)(86362001)(6506007)(53546011)(478600001)(66476007)(66556008)(66946007)(186003)(4744005)(76116006)(91956017)(33656002)(7696005)(66446008)(71200400001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OKYMT6TG4iQ7u+gu/TTPY+x/dyk7/HGwstkJrxRwVO7X9wp6+EYGS5hvcVU/cozePF2zb9LEbSgnTJXyKK9xYZLJiZ46ge8Iq8G2L52EiHcLyY6sueR2SUdgL31fsFWgLum4QE83jxQN4Qj1zf2902/CsJxwI9gcCEl2d6VLD0jW31uD8U51bL09boZL9xyft428iXVbgGHyyGTCrXTmu1aHjQ315CHIzkB1GUq0FIHFyPdSQE7a3a9YPypQPojUiH0i69d5rkTnFUYlcwm5wBE1XYhgrll3V9+uHM61vVnmtTBOunUvT8MxGwU3DkYUi5auKhlK6J9klCxQ3zBq6byT1dVgspkRy10oEmMKxH87J/iiFz5n83NTisj3mFS1GzgCBuDE2UhRnv/o46GglLKhJrKSxkX5wxfwcZnXleh8D+nCz6pMBe5l09EcaToG9OMZ8kwnD1IAKPpYWtLGw16TzrLODppK99K3nFlw/CXT3Fv49iknRg4jlSz+zXnkfdUuvNFr8HzMYVmDxcYqxiSQLrAaWcLo25Z3gU6/jppvdCnUlcb1LI/HSXiOObvQih7C0m9McUDTc0i9Q8KjkDM3wJR9v8wHlIQqO5X2u2Xt5s39tZktVGyVAbKByZwB07LGNOJOl2jHutFOLWY76XOPFabWdJsibjZ9ZPCC9Q91dbUy0TQ6Au4R3nSpSMi0YvfiVh6xhA3wfcuaT24VNA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dead56b2-3c94-49a6-cad3-08d8638eb685
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 09:13:07.1022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+HtVdf3xtIrRXV3GpB4e7Bfo9FiWwDGO8+OhLFKspWM57iv0mrCxG+tpxvr5qHhXwr1VMvIL1cyMZEgwpOm5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0345
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/09/28 15:03, hch@infradead.org wrote:=0A=
> On Mon, Sep 28, 2020 at 01:53:46AM +0000, Damien Le Moal wrote:=0A=
>>>  - support ZNS in nvmet passthrough mode (Chaitanya Kulkarni)=0A=
>>>  - fix nvme_ns_report_zones (me)=0A=
>>=0A=
>> Shouldn't this one go into 5.9-rc7 as a fix ?=0A=
> =0A=
> It is a fix, but not a critical one given that ZNS has just shown up=0A=
> and does not have any real products yet.  I'd still go for 5.9 if we=0A=
> didn't have dependencies on it that are going to shop up for 5.10.=0A=
> =0A=
> So 5.10 for now. 5.9-stable pretty soon.=0A=
=0A=
OK. Thanks !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
