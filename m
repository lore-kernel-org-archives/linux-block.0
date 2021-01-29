Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73299C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 03:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FECB64E00
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 03:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhA2Dts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 22:49:48 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11302 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhA2Dtp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 22:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611892184; x=1643428184;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yFLTFcObKR9IwMWy+H1qILQLIUcVflTXP0SAzOqlmRE=;
  b=WscAPLme3qfetpWiPC9byZYsaibt7WUKFKJD9jj3mCk0Z8qLbB5aYRtv
   xMwznhLqIzp8uZbk9Jqv3WwVPakchXn3R6Ww4f3D+T9hVaO1Fi3csRtNz
   R8obbMMwbY0A2AkN1ktV4ioOZB76QxhNhkDqMXk/60LVIbu/0I12fkBnL
   VbSwUEFru5rtOr65PkhAno5u772LFIFVVpSf5faKwA2A1RxqSEECsLuGa
   gzkcD1kM/S85i1RUZoBZQeMfxKF0bSWfbcoSBQAnEtbzALJec2CkJ3KAN
   KUmP5oaFvhwj+FXHCROOVYo9aZqhYj8+/d9/mOrG1x0GlZnAUPA4iFKZQ
   A==;
IronPort-SDR: 4O2PgTxkVuYot5srRek53KhyFdyr+pN+/FC8i/6CBpXdSggfPOnMvusddtwtr3XY55391OSImx
 AgUYt0CliyTYDO8W6vTUipjMbhcr1qsEoOCrRYc0XjFW1bSxTBj5LZtj7poLhH3WJMyVmn4B6f
 OA+3GyW9YRBDhVMcdkZd/HyZonSoQxVq1s+kZTXC5NqlkBZuKxhm7zvyzFkfLUXKzffobGECjk
 8S5EsPHI5ZPIMkOhrZiK3OhQoUQCCgr03hg+uhrPMqMNl1o0OUt7BJWal3ysJ1peY790IsfwUZ
 PSk=
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="158602392"
Received: from mail-dm6nam08lp2044.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2021 11:48:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIniHA9BAOvuQRHjc6PSaSeDsfx/afMwEXMnWABxUxfBrhqSDlCaUhq0yzdSRIVnL/3biFSkLoiqCfn5nP+i58Lvd6zfCqE2Da36YMrVfVCFVrY7wBEHp85uOMMrsueEUXZrZeXdJhw1IelQTFDeNsjUCrDR+DAWbzWRHdFka03Z1v7a/NcVrb6DZkxxM98bRGSTTZAbd511k1m8KWlKmo2yDJ9a+wkFKTTRqIngIXQt33Isj7o4ithhXRaB0/jIMChIj3PnkQGIAgFO4bwtY0P2CU5rgslCSYrl+rRReEyL15aWRfylMCMl1GoMVuqyrXkzgaN8lDnQsWBCjheB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U13kbEIsmJ0T97c1PELQDmgS2SJgkQP5oOKwm0PXRRg=;
 b=EXslm1zeysz/3VBPE1qWAa1xAtlVdttXWVsL0ka4hIC3MyqA1JP4MBVHsXonWaGu6oQ/Hd9jxbZK7MX0EGmxuONMZ+85KuYfhMbNR2UutnmXVYwNwtBa+ncSTrx7kmLjOWnaT+gMsToj6rRUaBf8zjXj7iG2YC5C4rGBrHPysfhPeuxSFJuWALQkPhcf0zLXEHp9WWXN00A3I4PJzZvakQvgzl4XhzZeC7x2cvJ4CzjLQiQQ6bJ3m8ooLE5Z/xODjG/ctFoEgW3ozzMxXGO4Wo8L5OVFqODCj5pCDz2wy/GUgonTBGUtJyhbuL8FgATeRcAWTXsMGF4NK+AnjD77XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U13kbEIsmJ0T97c1PELQDmgS2SJgkQP5oOKwm0PXRRg=;
 b=FPKhMptu+1wWdAMZ5849NsH0EZZhThep1VibY7SKznvb46IzNHIuOCuu3OdqaPA0ctF7IPiE9KmldAk8JakLKJ5fiXXhYIeVDANYT/JLK8RXwyz8bnZUh8fAd47F0HP6cmPfxHzYPa2BUSgnnVRuuzQXzW4e/I6HASsNNvW16OE=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7048.namprd04.prod.outlook.com (2603:10b6:610:98::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Fri, 29 Jan
 2021 03:48:32 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::c55b:77e5:fa05:3db0]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::c55b:77e5:fa05:3db0%6]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 03:48:32 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] nvme: add tracing of zns commands
Thread-Topic: [PATCH] nvme: add tracing of zns commands
Thread-Index: AQHW9DCXC9spI5mGakSiCzTf3P6Y9g==
Date:   Fri, 29 Jan 2021 03:48:32 +0000
Message-ID: <CH2PR04MB6522315BC122D9F1CFE645C1E7B99@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <46eeed2fcf2530d02fe5727a0a91a6e4675f6edd.1611683161.git.johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:ac6f:3863:44b0:5059]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10449df0-96b6-4e94-b373-08d8c408bf64
x-ms-traffictypediagnostic: CH2PR04MB7048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB70485AF27A2BE2481A557725E7B99@CH2PR04MB7048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m5/CKdaUlC420pPqsQtCmjwE8etKoqC45uqzxLsqOQwzqT4qIgGb7EimFjIdNVDkMh4tu4G9YQmNPWoQ8StqwhevlSnw6iVOlUfWwxS3jBHrh5TnY5ffAKrfxgsCouCjlZ7E1PkiK8BStO4zEuKFqN/O938k0VxFNAHjhw+zkAtVRpz/zmzwENI+tWiHx2Zt0IYceqf+HNVUUCZwTlRvHahB779c4dZZIaLAoOC8h5dQFqTVHl0U0y8S+fMsE8oj6uwBVdBCnC6WqOPqWVtD+F7kqYdt11+zFFnKqMaKLX/J/fe0I3Y+KHKbajQlRIPvYCZYAyo9/CAyEJzmAG6t+ff/9M2s5GPKl2EemB1ZOX8SQPws0daY3crAA0BQQEyRZevzW1/rYfvJJ9H5GeG/wmVtC3drLW3jHLqnu0OgVkp9kkzZa8s8wd23YgJtzTiY07fB+rZ/nqe7HMMSt4W1q/WDI7dieEcqiCoMlrxFNoo4BNMKOek3jSyCZH1I7D5Kl8aCyN30ciJsWhNJ8BmiDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(8936002)(478600001)(66946007)(4326008)(110136005)(316002)(5660300002)(9686003)(66446008)(71200400001)(33656002)(8676002)(76116006)(52536014)(55016002)(66556008)(7696005)(66476007)(2906002)(91956017)(6506007)(186003)(54906003)(86362001)(53546011)(64756008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XBUrZA0FpDoj14loydfggfs7vUJOA2pWLIDGym9XsvsuC04ids6/JCna2PAA?=
 =?us-ascii?Q?Dz1Bjb/OFyDRkZfkC9USmyEjOzDjcCs5hQy9VuVtItLuejrK5au51OfuGBet?=
 =?us-ascii?Q?T+nItl1lGQcpytRnBP6ai4wDn9CVMagwb8vOEinOm4ig/ZgbkAh0K+48FzO5?=
 =?us-ascii?Q?IpveamEWhn9saKxpdwYYpSWO/w/j0B+C3mUK7mA64byun/o/zSxCKZxioxLH?=
 =?us-ascii?Q?sjbakeoMQMl7G1ILpMGIMmQJgUtsJKqPL9nbtYCeaX/WOVlbxzURiHb8wVLP?=
 =?us-ascii?Q?zt6x9h7gs1XFG4HM4vSJR9KETaJ12HzFpIVxx2xTCQPcJDxDE/Cv4K0g5F7s?=
 =?us-ascii?Q?tddkoTy1m7GtH0qLQLkBAfp/5Pl4EhXiqQYhR33lzCc4ThmLXuLO1COaAM9u?=
 =?us-ascii?Q?9/U13Q73W/zqwQdKSy+7YX5AgZC4Ap5pSFNsJtPTSvR9G/Fjfpd1QdnxlJrY?=
 =?us-ascii?Q?gg8CPnH2yjpNOhhRLvr5Ee96s5qmq8O4hUQz7qRHQsnltNdmqBv27DtHP6Y5?=
 =?us-ascii?Q?WqRTDpSjtlGFB48j8xk6rkuRjD6XnDJkMyPOy42rWn/FzsrrW5N+49aKqd7m?=
 =?us-ascii?Q?YkVHDfXmkbho1CetRkmmISUueevabsveSZB2gW7oYbzXD9j/PSXcoG83af7G?=
 =?us-ascii?Q?ejsRmgGpSYvmOM7lfse52I6KodgNC00rWMgemVbeOBz3jFwcJVwlSEkPUg+l?=
 =?us-ascii?Q?99oSFojQ+vla15t7aAsvhx0RRuotEbukNagHGuFYY3vbx4Jtx3sVWGdx8+OM?=
 =?us-ascii?Q?W24ubFBqxGdprKnbvGwXCYf6aieVo/+wvlCg8s6oUuwpJgju2k4CYTHYH3Eu?=
 =?us-ascii?Q?+qD4ne7pbHoDsIk1TU/NbkxBndaNX5ruTDcCI410Zr24DLWY/pYyKOExSs3f?=
 =?us-ascii?Q?K6ODPBEgYFM1WpfnyhfOACSB265YH6UG3sivJrAjEJxslmPH/ewc1pQgTMK0?=
 =?us-ascii?Q?mOvBdty7oxY6D5CU08d9dleIGqpN5S6ve1Gt/Gb8AIEzfnhemMitIZVgh7hi?=
 =?us-ascii?Q?wQIk1dgSDbA9N9ZqB6c8nPy6aTK7SBNFl1FSiYw2jJp+/X6q4YgD+/Rth7wX?=
 =?us-ascii?Q?M7nVsz64a0S8t62Q2boTG70bChFdXcot9hvf1nVjBcpgTn1EoLJw7jYSwL2x?=
 =?us-ascii?Q?ean0cMrXxT+27ekNNi9nDkvl/i5TAqQ53g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10449df0-96b6-4e94-b373-08d8c408bf64
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 03:48:32.1680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwRe8vZNPyEhD7leIuOkSLvMsFYUORfBZse4UJKeuuYVgzJfN39EF4vQC2ol5C8+ZjSS2TBr7IpcgToRgJab1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7048
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/27 7:14, Johannes Thumshirn wrote:=0A=
> When support for the NVMe ZNS commands was merged, tracing of these has=
=0A=
> been omitted.=0A=
> =0A=
> Add nvme_cmd_zone_mgmt_send, nvme_cmd_zone_mgmt_recv as well as=0A=
> nvme_cmd_zone_append to the nvme driver's tracing facility.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  drivers/nvme/host/trace.c | 34 ++++++++++++++++++++++++++++++++++=0A=
>  include/linux/nvme.h      |  6 +++++-=0A=
>  2 files changed, 39 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c=0A=
> index 5c3cb6928f3c..9f9b6108de7d 100644=0A=
> --- a/drivers/nvme/host/trace.c=0A=
> +++ b/drivers/nvme/host/trace.c=0A=
> @@ -131,6 +131,35 @@ static const char *nvme_trace_dsm(struct trace_seq *=
p, u8 *cdw10)=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +static const char *nvme_trace_zone_mgmt_send(struct trace_seq *p, u8 *cd=
w10)=0A=
> +{=0A=
> +	const char *ret =3D trace_seq_buffer_ptr(p);=0A=
> +	u64 slba =3D get_unaligned_le64(cdw10);=0A=
> +	u8 zsa =3D cdw10[12];=0A=
> +	u8 all =3D cdw10[13];=0A=
> +=0A=
> +	trace_seq_printf(p, "slba=3D%llu, zsa=3D%u, all=3D%u", slba, zsa, all);=
=0A=
> +	trace_seq_putc(p, 0);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static const char *nvme_trace_zone_mgmt_recv(struct trace_seq *p, u8 *cd=
w10)=0A=
> +{=0A=
> +	const char *ret =3D trace_seq_buffer_ptr(p);=0A=
> +	u64 slba =3D get_unaligned_le64(cdw10);=0A=
> +	u32 numd =3D get_unaligned_le32(cdw10 + 8);=0A=
> +	u8 zra =3D cdw10[12];=0A=
> +	u8 zrasf =3D cdw10[13];=0A=
> +	u8 pr =3D cdw10[14];=0A=
> +=0A=
> +	trace_seq_printf(p, "slba=3D%llu, numd=3D%u, zra=3D%u, zrasf=3D%u, pr=
=3D%u",=0A=
> +			 slba, numd, zra, zrasf, pr);=0A=
> +	trace_seq_putc(p, 0);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  static const char *nvme_trace_common(struct trace_seq *p, u8 *cdw10)=0A=
>  {=0A=
>  	const char *ret =3D trace_seq_buffer_ptr(p);=0A=
> @@ -171,9 +200,14 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_se=
q *p,=0A=
>  	case nvme_cmd_read:=0A=
>  	case nvme_cmd_write:=0A=
>  	case nvme_cmd_write_zeroes:=0A=
> +	case nvme_cmd_zone_append:=0A=
>  		return nvme_trace_read_write(p, cdw10);=0A=
>  	case nvme_cmd_dsm:=0A=
>  		return nvme_trace_dsm(p, cdw10);=0A=
> +	case nvme_cmd_zone_mgmt_send:=0A=
> +		return nvme_trace_zone_mgmt_send(p, cdw10);=0A=
> +	case nvme_cmd_zone_mgmt_recv:=0A=
> +		return nvme_trace_zone_mgmt_recv(p, cdw10);=0A=
>  	default:=0A=
>  		return nvme_trace_common(p, cdw10);=0A=
>  	}=0A=
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h=0A=
> index bfed36e342cc..325dcdd221de 100644=0A=
> --- a/include/linux/nvme.h=0A=
> +++ b/include/linux/nvme.h=0A=
> @@ -697,7 +697,11 @@ enum nvme_opcode {=0A=
>  		nvme_opcode_name(nvme_cmd_resv_register),	\=0A=
>  		nvme_opcode_name(nvme_cmd_resv_report),		\=0A=
>  		nvme_opcode_name(nvme_cmd_resv_acquire),	\=0A=
> -		nvme_opcode_name(nvme_cmd_resv_release))=0A=
> +		nvme_opcode_name(nvme_cmd_resv_release),	\=0A=
> +		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\=0A=
> +		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\=0A=
> +		nvme_opcode_name(nvme_cmd_zone_append))=0A=
> +=0A=
>  =0A=
>  =0A=
>  /*=0A=
> =0A=
=0A=
Looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
