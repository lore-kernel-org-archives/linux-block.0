Return-Path: <SRS0=lwW3=BS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419DFC433E0
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 01:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FEB2086A
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 01:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VvBB5J8W";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qRkJDrUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgHHBr6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 21:47:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27594 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHHBr6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 21:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596851276; x=1628387276;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rCegO9ukV37K8mwAmVygqH8R+MCPhOsv3aFR0UV6EkU=;
  b=VvBB5J8WoBVEBN5rNfuHC01Y9RLoYkTVMf+rqS6COH8q1vaBxw50zsSc
   Ku8YCWV5qIefMueQz3sf2mgjMwYwQ0hUKUgFHTIMs2PqDlsuBrEXc1GEt
   cVD/Nthk1f+PBoDNA0JVXZJox9t7LCyLrxEaWbUAWBG8yIRrdpbxtNNTs
   DpeWVHqzPT7nynmtgawdMIMzrc8Mbb64sEjin3XWOfF5r4YORFoQoHj9O
   4pfODvYHDmQ1ScMEcOytBlGC0gwPnij42DjgdnHUfoBSOBzDsIKdhQkxn
   BnShRGP6KCpl/+TheCyWlXE/jx78R9+Vgsa0XK1/Wd6J04ywDsttGtsiI
   A==;
IronPort-SDR: iwscVfPx/WempDnIFTedJPZW8c0jPyluoK6Jpy6AQ3MYanvDXcm9HwNyHQRqyMPu4r1YyCm/nY
 wR7dvZ/Sv42ahrX2+Jj40aD22XB+JKS0b+Rp+hurS5ciOQrvvFqWs3+PBwX6IJljUEhRQAy3IU
 uDPM61iqhPKUuOaAzF2G1WcGn4jzIne7Fd+gmbXihAIBA9xIvuM3Z8ZHKhFq8UWbGTwIde3Av5
 DQIHETKHQnQOFvSQni8fh/hxgQMBAC1qyIsj//SU9yJri6J42p5eOpkzeBMzM50tNJUKL2lPpw
 Lfg=
X-IronPort-AV: E=Sophos;i="5.75,447,1589212800"; 
   d="scan'208";a="144442908"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2020 09:47:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hg+UtL3Lkc74BNuS1n9sFszXNk+IqksxfC/9ysIx3TTD4/s/H/hOt2XgHoQCu4ouPm4CxrlrmDj+PA1RvaSH8Np7trvtlly876mm9+QlZdz1pXSyfZ1qz9pjV7X9i72FYiA93Tf0jBG1+dczBJJSyZA0TW81a45jLtzdibYCpgadQ8lFnNlRBB+eyEhU66PWeRqy0RfF1MPdRuXKBPTvUvWsfFE24duLRa3gwl7uR05Sf9ZX410XL3glFt6+muVRRCAf77PrTYChFMfXuZ72DsMDNHQYwLDLMqaL/51NYn2Ab2JY1GTU+2o6SnzYq2HtLn1zMYVmI1KcCB27SobMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCegO9ukV37K8mwAmVygqH8R+MCPhOsv3aFR0UV6EkU=;
 b=BaupdJuytRf3b1hPwfhXfTlTU5s/3kLf+5YSNa51WOqjUaKNyQ0dH4KR10kyB7AUdP8LMzNqoeAokhJTBp1EPxj3egKWXHyJyzDM597YHZn2Q6oLuN9HiEoQNZNX/Ej+KaAlBg5YFPxnCcuemLvWb04W91kA3S46eCaEpCuk2XhWLInZ8OTbN20kAX2jKS6d1ry2MiREZJHd9MR18pHaKW6CEUmquT+8Se3lGW8bcgDEDe6IyVBmXp7xKvvW1cTMBPfYKfWuS7ZXpEX7wLohKk8lkqdjxPJKYjWLBTDMDZRx1x9MEoi2fA8NRWWRSPkyEZ25vYXGk5XJqP5mkespWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCegO9ukV37K8mwAmVygqH8R+MCPhOsv3aFR0UV6EkU=;
 b=qRkJDrUI/Tdj2fYIRKx3tpnYqP9npGc/oSOxb1f8HhjiZyAlxO6tTbaJjv9NSPPq1HWHTa65Qb0uNRlIC5e0sCmcmEmS4JONbCxCu8AeaZyT4ErrQAy/OJMnZt222MEffwKD0o35HYMzOSJJvdaB2tPeh1T+zHQ0nE7SkpQ86Qc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4661.namprd04.prod.outlook.com (2603:10b6:a03:12::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sat, 8 Aug
 2020 01:47:54 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Sat, 8 Aug 2020
 01:47:54 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 2/7] nvme: consolidate some nvme-cli utility functions
Thread-Topic: [PATCH v2 2/7] nvme: consolidate some nvme-cli utility functions
Thread-Index: AQHWbCXyfk97HUGSg0KKD45yS5/FoA==
Date:   Sat, 8 Aug 2020 01:47:54 +0000
Message-ID: <BYAPR04MB496552B8C73A602C25AA67AA86460@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-3-sagi@grimberg.me>
 <BYAPR04MB49654E81437918F224CDD26486490@BYAPR04MB4965.namprd04.prod.outlook.com>
 <aef21d09-e31a-de7a-54dc-974c0d65756d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d48370c-aa99-49c6-7c89-08d83b3d11ae
x-ms-traffictypediagnostic: BYAPR04MB4661:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4661D14009C171CA4266333586460@BYAPR04MB4661.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1dCHB78ZBoLZaEJDDXgH15jSFHC6fISEiziqAg52ACHaAe9f77NL+R8VOEM/P1f21BUQisX96StHCifCQCDZxv0wbbRG3o2MZcoWua2/ztdAj5O1a+Jrl9pR2jB65y81IP1QzjgxdC1wdVptv+8Gq/JGidsH35mBkz7TxUCjKtbJ9LchInem2Gw/reeCPm6mOfegUfpE6bf8KnTEZp5dmEEMAMpe01UxzWSNAU2T9Xw1Hyf/E6umqSPN1rTeOVNoQLNBNa4Lb0rFwD4TrcXfdSVbbGUt2lAp8khfpTxG8rIuu1AX+UQkR2NiAI7qSmN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(5660300002)(66946007)(66476007)(76116006)(83380400001)(55016002)(66446008)(52536014)(9686003)(8936002)(66556008)(64756008)(2906002)(4744005)(478600001)(110136005)(316002)(86362001)(54906003)(7696005)(4326008)(26005)(186003)(53546011)(6506007)(71200400001)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Z1fxvmtsutb/FONkstRpzx1hvJUSmpevhs1JK+ap4Az1pYNcyOncWNOcnEwqeZaBvLt2CxvhMKVl0Io4zcneB2Ho6yInLy8N1cDfxLdv8jO9RO9R6DwdYW2DPtvqqwI0lVs/FMpcsDGpxKES9yOuBJA20ApKWyrJvvFCiKjDRFR0rrY1OF53irUwxWoTO68gpo+ikzoEW5J+2BJuQa8VhXNKUKq7aetNZ7rFNc8nQRNaXALTjPP16CTHZ1dq87xMH+FscxjLLZxgGVReuVXwF7neJBXjitJkDL41JMlHzXE64RwAx2gyxTKaZ6UyEJj2sSbQOXF+H4oPP+L/nTTUhjGqW1wkSrY1iuxdIyyMiDFbVPDWTD4pKefWeLKMMz3KjrtciArk04sQtWTIW27KAUoRLtfee+QoogUf7OR0YPbB4L2hjrbRRIOMZxA3Rn9qOdjUt0Ki4muXgz1t0qeHkHzIxeel0zlaG4EpAIWubajQXqPACpoGrp4UDUG+imLC8UMnKyJH1Jhy4xxsl2NmRmY2shvaneJILpuINrTxAR/A1hQY36hpPMiWMbelkkEUlu8Bxv1U62sYXPZ4fzWXrrYuc8EJwUBjPNBLm1gxgisonjuV+2LlTSjnpVhVaBShkkpZBAJU3EDqApcEI9mh5w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d48370c-aa99-49c6-7c89-08d83b3d11ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2020 01:47:54.6857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uocRtmPxrlfXqBuTSZX8E2p+58tPUCpR7xpH8dEBFcdnjpeyadmIY1OFKZNc2cDso3bqvrRNVZvJNRAbHnMtHGKbsb/BVUQh1dJrggR+3y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4661
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/20 10:15, Sagi Grimberg wrote:=0A=
>> I'm okay with having a wrapper for disconnect but for connect and=0A=
>> discover command it can have many arguments having a call in the=0A=
>> test-case might loose the readability.=0A=
> That's why these has default values.=0A=
Okay.=0A=
> =0A=
>> The downside is it will need argument count handling in the future=0A=
>> and makes things not easier when user want to skip certain=0A=
>> parameters, closest example would be _create_nvmet_ns().=0A=
>>=0A=
>> Also if we are adding wrappers why not move $FULL 2>&1 to avoid=0A=
>> duplication ?=0A=
> Not exactly sure what you meant=0A=
> =0A=
Leave it for now.=0A=
=0A=
