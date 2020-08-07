Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7DCC433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 02:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C2322CBB
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 02:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jcmlmY1X";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hPn82rRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGClz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:41:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54619 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHGCly (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 22:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596768114; x=1628304114;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hCmVDY56eCE3rqC5nDJaSHVjsMjCgPEn1uRcFW6bINU=;
  b=jcmlmY1XK8HG5zl99LZyeFQMh6ezcTW9yUeStcDDafVW5ksbvK8iAxI0
   NbxaUDVxSenl5Am7FFcsb8xn0IzbbNNZ+aJDlcuRFajQcxZlceblwtOa6
   4Df5F+ft1Y5fi/vDLCWbETbVIbdPAeAI6MJaajF3ZWbwJqtn9b7cwVqE1
   kqBlZ6EsTRzEBdG35fNb/ON9ZY3c/ouqszMxOuvM5rIl1poJGtUoY40we
   cjxQL5kU2G9iDPr7BAcea0mUCDGl3sqL05zXPlPdsKbY63uQmtgTpa1ZU
   25GC7wxtcS9poPndzci3fO+J3htq44e5gwPK5YdLVPQ516OmbrbJNvewG
   A==;
IronPort-SDR: bTvK3PZs2slOx11Hep3FUO5B4C+bUOgaizc1lsk6vMHv2v2dkF3s0aCdTCl5uFytNHNfzJ/lIn
 uZUny3OVchATQxgbVOkmbY04rv9fu9MJMrWXwfgAsZ4c8LTwlYVJJkUmQPRyqs9mkAxWZ+06Uc
 h1piXbKyDddpIsirJDSk7cH+6w+UiW/7i9t8qNPrxjY8u/pukbAOARYoKC6wQRv+3ZULs6uMye
 lmp0NHO4oiVLrmUekmzrnqthpZPIeZLm0xggdnvPNVRmcvoREJxMaj9/OP1PZoNbVW2F3OeFkR
 1dY=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; 
   d="scan'208";a="144357202"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 10:41:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWwUHRGL6rgM+Dq8E1gX5j6sRaMDhvVEyj0h0gRwD3S8Y+7LUYR9pJnkBcOSZS9p/37Q8fgEg+smNPoIy+e9Xl0aozC3S46zVdbyDs+LXS6D7A8/REnWBamnqj9v/xfJTQpP8wxfNZUIHA87e63rHLmuIHLeQDYwc2R3EHm8dW3HqOLM1ywYTytmJFPFXhm2UKUPP9gOG3y9aqUvHUi/ulYVxlYpyT2QR1V+emyF9Gl7tE88KQ7LeNoJvqWaNM9vj4Sr0ve99C72KmvjjYYYrgKOMYdonp6rC3CBHjuNQuAh1n393//O8KrUIv8gc5hLp/uUDXSowl0AinrAVtbMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4i+udeEHV4Rdjxo+GncffmE/pQc+wiphZHop3o6n8Xs=;
 b=Utor5rvmJC4lkk71AThGFYJDZkd1+X67dlsFE/Pegi+kp/8iIphNu7VFePcFiAwMlzwOEqOEXzOCozk++B0vSqynJFjispuDP281SR9k5ZGeeD/eEFui4Zhp/X4zUwQ9zmkM+VXJsQm8ywVqFHt4Xi2RFfWcieu495fTaEtAalasVJkybFFltVeEupUuR6uxco7pb0fFN3PvI202+LpdFn+x8RWCl32bXAGM3WCXrUpl6WyEfw+iMQH6omoGej492WBL4Fn4LS/LBpp0HNfbaGY41P4qy0C0IWqSKLNbhX5A/dAZIHqqic3qCExdT9pRCSZKw4LliCQEqDH2DhOeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4i+udeEHV4Rdjxo+GncffmE/pQc+wiphZHop3o6n8Xs=;
 b=hPn82rRJ9Q+UuukTJ56dsU7zEOkXHHqUHkP6GW7IuSBx4Q6uSSThNeH8DcadSM0Vf3ylRY5BG8GItesoiBSHvneGnvAor8XnNjJ/W5V3YhDQv8T0Gl9Yl6Ms1G9dcNyJN9l3uX4ai5/nfDuwg8YYQHt4cehVsbAzRKlnBTArupc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4871.namprd04.prod.outlook.com (2603:10b6:a03:4e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Fri, 7 Aug
 2020 02:41:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 02:41:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 1/7] nvme: consolidate nvme requirements based on
 transport type
Thread-Topic: [PATCH v2 1/7] nvme: consolidate nvme requirements based on
 transport type
Thread-Index: AQHWbCXx6BGxwB51RUuDED18RBEkOg==
Date:   Fri, 7 Aug 2020 02:41:51 +0000
Message-ID: <BYAPR04MB496546CB79B5F7D4F4B0A54186490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92b32610-50bd-4a04-0552-08d83a7b708d
x-ms-traffictypediagnostic: BYAPR04MB4871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB487166AD95F433BC9895B1CA86490@BYAPR04MB4871.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XX0tl6y9RjhNcGAvLCYctq+g3NPx/6u0prCAMmS+PK3xPDtqtIciqLkPfWEmQ0WtXdSEbsQlZxH1lnVEt1vP42HhlX4rX0D0ia24hrRvaoYRBlcIY3mngwhElEWcypWGHEtuAWUJGdk+cEOwfKXsBDIhHbEftRjP11q3eh1estZkF2MCzx8qebjrvz3/7WkLBJJ34rEV1bc0B4phxFnFafQDio9IHgV3yWI7Em6cHZvXVoh9qjQ2TYtirtgxHHBwssp+ktv8nSiNzuX/yQk4eO5pFx7lWQi6/FUWEw4a48KuF8OfqIp8QYGnInmlFFBnZmS5ytMNvK4nzirpj5OZIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(2906002)(53546011)(26005)(186003)(5660300002)(4326008)(66476007)(64756008)(8936002)(8676002)(478600001)(71200400001)(6506007)(66556008)(4744005)(54906003)(110136005)(52536014)(86362001)(55016002)(33656002)(7696005)(9686003)(316002)(76116006)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oDgFUFMCohzPQLp63Jw4CpvxBUhbEhB3LWV81snqJJZb3ZS9Ua/19oJZvWSymJ2SNZqHztOwnAaNAbEt562wTzi/5jB3bENDE7XX6npfna8XO3lANXauBZ1wOySX4ZjwDd1ul/PN+0JxxQ+PfFS9Hefye9L2LCOzH+iSAWEQttNov1xp6YXMTozROLx0jsRy3Lt/RmXTq8xcf+j3NlVpGaPdfVnFU6ka88NuMT2J/TDPACx6hU/spo00DEJkYuZryHpcBROAkT3DR0ari04Nu3MnqJG9Slkh31UXgHFwgyXo39S2TTryvu+1AO0AP3u/j2LuekctjmbsTeKigfKFIFqVfLfFZo04XD+FQHtJEf8BG3stBVph4BGF5tTEWZu43epU4ymlIDd4cGmTn7WPXFpvVCbdoazDcqeyU1SZ7C42b+5Myc/EbURnKkjQurOC7kBz45xwrDevRHQNbYAybz5Cxuo9ghJMDrezcixcS/80LdN7YJxOb2SsN+bIMJJh0b8hICs2Ax45wEOnq41vb3YBf9gqZm5uwbyLr+Bt8jS/IrGfV0yTqcgeSl+a1Hz/F0LKQd35PXkQXxxZfJngdQ0z4w2arxnLhjfbxmAHmzOdRNPbXJHYLegUlelCglDMGAIZ4dGsd1+pAZCmVVnEew==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b32610-50bd-4a04-0552-08d83a7b708d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 02:41:51.4814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kadBh8QPlzDXTN0ESfojfbaqZI8KXVN8onB7D5tszROTjmuS6dYMiChTgg0dUodiy3Fs6IftekXUgOvMXi1y9ZgpQs7Z7j2wgPsd5GgVrTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4871
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/20 12:15, Sagi Grimberg wrote:=0A=
>   =0A=
> diff --git a/tests/nvme/rc b/tests/nvme/rc=0A=
> index 6ffa971b4308..320aa4b2b475 100644=0A=
> --- a/tests/nvme/rc=0A=
> +++ b/tests/nvme/rc=0A=
> @@ -6,6 +6,25 @@=0A=
>   =0A=
>   . common/rc=0A=
>   =0A=
> +nvme_trtype=3D${nvme_trtype:-"loop"}=0A=
> +=0A=
> +_nvme_requires() {=0A=
> +	_have_program nvme=0A=
> +	case ${nvme_trtype} in=0A=
> +	loop)=0A=
> +		_have_modules nvmet nvme-core nvme-loop=0A=
> +		_have_configfs=0A=
We should just move nvmet nvme-core configfs _have_nvme_fabrics_common=0A=
which are common for all the transports to avoid the duplication.=0A=
> +		;;=0A=
> +	pci)=0A=
> +		_have_modules nvme nvme-core=0A=
> +		;;=0A=
> +	*)=0A=
> +		SKIP_REASON=3D"unsupported nvme_trtype=3D${nvme_trtype}"=0A=
> +		return 1=0A=
> +	esac=0A=
> +	return 0=0A=
> +}=0A=
> +=0A=
>   group_requires() {=0A=
>   	_have_root=0A=
>   }=0A=
> -- 2.25.1=0A=
=0A=
Apart from that it looks good to me, I've not tested this yet though.=0A=
