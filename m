Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F2EC388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 15:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063B82053B
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 15:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ASX9gcyo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BWFIToa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgKKPNI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:13:08 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1569 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgKKPNH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 10:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605107587; x=1636643587;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ASX9gcyojMTlyJiRCTOWopTh9Qn+T9sc/tnL6pmvQkNEXq5n+SU1MmaH
   mXEDp20Rt3tc/p7rt04Cc++gZetjkybT5eBPoNtv7OAR3M/WriTSifnEg
   XNRPgJX3RowRNXP35ZsJcY2/sB6tz7Qjob0T7/xYTYCSBld3SAJ8Enl3b
   cSINOthgxFN+Q20JH8RUCbC57bGAeuZhCgFGahPFJZRA7jTMNbMJJS49p
   oNIF3hIY9//Z4RVXuYgpO3Q84Gol3g7GN6Plj+4AgIcipVNx4ajr+iyZq
   /Fmur/D4wL6rGFDu0+y2kaoRHLoWTMXIT4LFgq29w04mMcX3h660byl1t
   Q==;
IronPort-SDR: lKVj/d0yIcUEyKDwLYhJ4lt4r3GlSmor2jXu0HhKDn5HZHH25FEgNh313Mw9MSvqhAl3GwmRTW
 Ye5+ew0ni9LJgpf3bmiPGWzZ0NvmxtdOF2+gAY3Iqo6lDGIVEkYhUioen7NA7ru9zsnt/X2R87
 FUdsxM1x34fcMNeNNi8AomcTYvm50AgDYr4EG0rmhM083OxA7YcvAMnfteZgQzRxNWWqhKIZEt
 vbfOVNiLg0o2qrhZB7qH/sC4zLnwGQi6nOh5isporcFOZA/6eqZUoycp/TKk5VM7SVaMsw/A5D
 Rog=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="156875250"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 23:13:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+YeIsRmGWzFBhouC6CMWkOImd4WK7BSzWR7R5ksOjPzQpxwXgGm2KEJFF4F/GXiCYbgqQNiEyBP+5CNgC5fFDCJBAGU60Qo31FHge8DGlf1Jht0GOi2UyIR9rLZCxdeM1qE+Q3jHAcYasBZtUXP+SSGvuTSNP1QLCrdz+H3tilWJK+q/d4JX1kIwM29LB706U7Df+3sXRqDi96Elw4vqljv4e9tRT42+F81AtAhwgpJkiTup4oj5b2GPgf5qUk+nyK4Toa7utTNtq7ART+wVFAL9CE3KG4HgW1EijaosIO3KicREWbMgnXOFtBLs0MJ+yplJli6L5A4j8nJSp3sCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YJuWm87P6NG2tS/YbdLpJRqULEhAHfFe1BxkZFnUuVDbq/Q2/Tg+rnHx2S6EfOP8v6r4NTRLZegaxhRTZtUwSg/ygUq7Sh3W3ZaB8XBWs8om6zW5w1aQSPBC7vMS+mTpGz4uMbp4DYw3p6nO0nZM+C5M8B+RVyo2tUonE4tVCkKilw2eKN1KWJxL8nGYoLdepAPtP6aPxW1AeAhA5RcYR0qoJ9Ul/KvA7tBusKvnB69ft+BkTz83f/pvalu4JdPNmXSEU5xpWbQ+VdP06tbnd8zPXPf36EjKocSzVFYkLdmw1PZsn41wV/uBRX63FK0ndlfzSezhSrot3OiAbpuVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BWFIToa0MfUsH5vSR65v2vdHfIz/vgXASMdr7Z2osmABPCKnR3RG2EOh/zF64Fi3q9X4Zy4NkTf5ePs6UgC/2MS/lFFr9f3ayJ2J6wdn1iyUEUfMlKyL3jRu7zQFXF6j24gNsN9fwLz9NH+x0Mnhms/OzO4qodLJ/+hj9qfOGJA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5326.namprd04.prod.outlook.com
 (2603:10b6:805:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 15:13:04 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 15:13:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 9/9] null_blk: Move driver into its own directory
Thread-Topic: [PATCH v3 9/9] null_blk: Move driver into its own directory
Thread-Index: AQHWuCrM/Qght2Yi9EKZ2QUzwmUMmA==
Date:   Wed, 11 Nov 2020 15:13:03 +0000
Message-ID: <SN4PR0401MB359812759145CB6F195D79209BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
 <20201111130049.967902-10-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e9b5d53-60ed-435b-5e81-08d886544974
x-ms-traffictypediagnostic: SN6PR04MB5326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5326BB9AED10C3E7212F275F9BE80@SN6PR04MB5326.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6QaDZ5sQ9ZT6GSbVVaVcfWX/x+bXVu1XrHw5ecoT9uo5QMLFA65tMbcTkBIdWBrVfu6dxTD14/7sZ5pzB9Q0Fn9DrpIttjy0L6A2EflJH8CgbhcnhmRI60UWT8uAicfpQ75XsGo5MQWjVqlCMpL5/LeovfgMfOBUCT5xzow04iPM5ZsQoM0vsrdnms6tzy03k6tJcbmGxNre9mQv0ivZYX1sgNwqt4o9RMM2xQu0HudLn6jABelOcXwsJY8ke6l7iyBBF7sS7IkXBqtlJWwkKVEgl6DHrAogr9wEHj5KIJFhGlslLaoy6IS7gXRQkC35UuL7jyuu+jCA4O40msooeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(316002)(91956017)(86362001)(26005)(8936002)(33656002)(55016002)(66946007)(71200400001)(4270600006)(52536014)(5660300002)(6506007)(7696005)(8676002)(186003)(76116006)(64756008)(9686003)(478600001)(66446008)(66556008)(66476007)(19618925003)(2906002)(558084003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VrBODLXyBQGDCE/oMiGr0B1YWVZenn48jih4w9fsjLMxqbyvJPP560ashr6Ie1h3DCC1/uTh7L5D0+exnAD+NdQ+Oqg3mLzKIxH4xscRb8tUbMGI3eG08kHt3OS40GkH20cNd4hRvlU8esDMzBU0hmk5Kwav/PVw+cUeQsOR8IqS4Qy/8awQtLJjTpjAaSuKnzo0wTapce/MKhwApgOdafhJNOYmN9jtR4qZy42Q1SDDTjDyIZpz1DUQCxX5t3UPXQJkHf0fqV7pUR3QYzSVQZmqon0cZmcVHGUPr4FdKhAcrjYGgJlHYwV6Bbj8nivH5ZVtq0QHkW9loxu0H0I8pMrpV/pKMDToUMQamN0ZF46+Uq/0Q0Irv9/bLpQDwn7kndWDd/uWAzJhUmD15vSt4UOaAcrO3EZWIne0T1FlOOBoq6lbqlRFAA8OsQJQWE3SbOQH+STcmZ7vqmyHLQwPhgxhWLWozm4gG3/M2svBqJN7EMAoi2THbhukolPrApmHYmnlZ77gNPuOYF+di5l0W5qR+qsfsJe1KYBoRiQgg0Q2c/CTk6tNV5C/IteinJKeokqgkEmbOQaBm6+MFHc8FhrYhZ8hpJsAAmefCj3mlT8PeQTwJPsageeLi8zAkJfAWmmhx8GXyqAiKivlpnxSNw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9b5d53-60ed-435b-5e81-08d886544974
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 15:13:03.9595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y13Di2lh2ktlK0z/ur/4mY4pS797vSrGqM9Fv7XgcmX93stFY0wGVlxYJRltz9K7STmnIIK1eyHLF2g8qOgmKzDG1PCoUtIIlbcQ2HVsXPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5326
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
