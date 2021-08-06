Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759EEC4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 06:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C264611C6
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 06:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbhHFG5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 02:57:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37427 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhHFG5V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 02:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628233027; x=1659769027;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dHYXJv9MaKwYqHifuKfZtVKvkH9bD4nwkf9SX8hw95g=;
  b=HmZ5OowjbZzeRtaG5oCaxtAWZpMZmoa+4fDeJKFQYRiwsVdiuztEfhRZ
   +4zj/DVTHyPF0gm8qmGdooRZmtpF0Eda1h2sum7HFRSBnwpoxXWfenC1f
   v/c7dwgz5FBSGfZBPerAAixvIvxvF5G67J1N64xGnzvpyfwUD5Wuceoac
   Asmvxq7xufFn1ONgpjCwAEcXRgTVfyTm62ZRHgZxgCVn5EsTmmnGLohcT
   POwq37kRgE3wz9egZSXDzBjtZAN7+Jeh0n1HzA1LERwndCFToe0MVYZYn
   rJS59s8KbUZR26ywHYHhHa8F4r2S/DkHOiFztecou5tAhBpkZ19xRnUAM
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,299,1620662400"; 
   d="scan'208";a="177038675"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 14:57:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVaoG+UZ/C5qFtyDBa/A5bM5pwgrV1uLgjoQj0bMzKK/odnzGEOd/T35VIpjq/D8hQGCFDIJRBz6Pjl4+fXwa6SnzczDz9xg57FPdxzY/D3jaD2Ge+VYpQmz7YMjxcEHLFsSZHzehBz+O9VYG+4aJtxzaa1W8ueYWfYJxXKGNZbjX79zk1YuEvDybmEqa5b3R+3aNvDRBKWbqzmi3y4mYZP18Ndn2uZvLsBSuzKFufd2lzhdasPQVpbRxz1Jh4+W54eK+QP5fO7EkC24mi9wGr3DqOe5Qv+aifNmPfpcky9i8NAFHjb7XWHVCVdeXcbUDzO3Nx9MCyoZ4GAVLqoL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MItu2RV6qEoS5clwfIg+1ivrJ4e9b2voI63SVjpD4Sc=;
 b=Y733RTxpu5vfn+TlCsTiXaAy897hRVwItdDMCSuhiQm3MaXJfyi0XePDgBEjsFFejWk0UiN7OSzSUBk7Nl78BSPsgHatGwxW+X/cpvagHFMzGP7V0oPBqQtFjtxD+VtgVf7HfQEQ52Nfq7I9W0+enLy4OMzTjRgZ/na1BtINQ/DMu/DW/EmnrngHey1rnBpBn3JEgFz1b44gO/gyfuajzutgmVgO51cElxT+DAh798tD+hgtIzX81VkMgtNNKnheoJd9X/JstMork7cIf7ffQH56kU2RGswxdKBP6+yEay6Xrk8lykF37NnENB5xg71j2bVMVbSirMS0Y1HUuNNMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MItu2RV6qEoS5clwfIg+1ivrJ4e9b2voI63SVjpD4Sc=;
 b=HjaFrRVmdi7kqKiUD1Es226uZDaX8nBVsTDU128bylBW1cGPYz4lpyNyrj3CVRlfvphKqseYRNFDq/gww2O5gQ+PB6ifffQdBK+4U9b/r6Yk60WVSzpBmGsppZASQe6mNp4PD6xVmHByik3m5nOIWsiFzajkS9v+Mu4+NIDmYck=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0445.namprd04.prod.outlook.com (2603:10b6:3:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 06:57:04 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%7]) with mapi id 15.20.4394.018; Fri, 6 Aug 2021
 06:57:04 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 2/4] block: fix ioprio interface
Thread-Topic: [PATCH v2 2/4] block: fix ioprio interface
Thread-Index: AQHXioGTfTnhIFrRQ0G1e/BGt4xSlQ==
Date:   Fri, 6 Aug 2021 06:57:04 +0000
Message-ID: <DM6PR04MB70818B00518B40E671481E76E7F39@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210806051140.301127-1-damien.lemoal@wdc.com>
 <20210806051140.301127-3-damien.lemoal@wdc.com>
 <6fdc9b02-d03f-a63f-cefb-1d00ac42b885@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ccb00f6-4521-4ded-5d51-08d958a76645
x-ms-traffictypediagnostic: DM5PR04MB0445:
x-microsoft-antispam-prvs: <DM5PR04MB0445B11C78703A060BBDD069E7F39@DM5PR04MB0445.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2sqK/mc7Z0xEep4iqjMvV/i82yTddl9h0WDHyRwC7mEDa+m1qpqH2GmnWI13j1UjMXhWI87l7yHp5Mlul8YCHjRQ3LQ0lfdnIEgHrpBkQKVqQ4apyBr1jNkHRakB7mqMDzEn/KrkAKOpc9tfX577ZcS1quFKN+klna2mwWULuLuL06T02Zz53nLHu8dPUQOahvRTf6qq63Bt0XK6VLscYTr+y1acRuokzXLcyPj4zi0EUrWCnzatlyzWEciIr4RQBVrVX3TY02IjDxZ9gb6DLPm5j7nxGmR0pL4RA7WWNrcj/GzCbXoXDkLYlCU2xpZDbB/fuUvfr0rDvnEbi2i1Zyyxtne6Ty6mUObJw312Xci0Bby5hfNmbvQe2ZmaqpF7ysoKUdXaVeE/ff5OpgaSlWWOxeK5P7s/1uskwIcggbF3tDJQXkliN/xIaJmZIfRc8PvE3e7s9RJipqYCPd2XIABoOcn9U9lW4f/M/kiZYJ6ZiPJMVKChFAfFN0WP3QKHF7gEysCELq2ASBLa4FsgwRatvfqXuzPuvzI157rY4ytgf2uStETOCg5dauNIP9WNYeSX2rNFiRh/1EN4GX1Cqyu7/AqXuTCmbeUiRzH+5Bwt22E/jSvOkV+IcFmd0imXxdfmiFO5M1wIlFAErAK9L3q6yG2J9td4gDJ535332Qv+MNoOI+dqANY12VfcMMxImmMF4v1pQRXVahn5eu8R/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(76116006)(478600001)(91956017)(186003)(2906002)(53546011)(6506007)(66556008)(33656002)(71200400001)(8676002)(122000001)(64756008)(38070700005)(66476007)(38100700002)(5660300002)(110136005)(8936002)(9686003)(55016002)(86362001)(66446008)(66946007)(316002)(7696005)(83380400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jKiHTnFXNLdyBCP9nmky7o+Bxqkh7ecFQOgufjNTOz5EYRw8DxjU0cTKgvNs?=
 =?us-ascii?Q?tAT1x1YHXaImMXfbkKT6f1MKVx+MayPFKHjeSvOXV+HlboQGuc1J/TOKZWWT?=
 =?us-ascii?Q?Srfnmm9pcj9Tum1LE3wQuL97s9b2w8LVwYtQFcnbv/qssrY/FT+6YG70FJF4?=
 =?us-ascii?Q?64VDNYZ8LtutLOqvQAKJRV/Yh8AiS929Bp1cK2pqQLm942uHMT1Mv6Zs8374?=
 =?us-ascii?Q?+IbmtUar9wkVwRs0DkO0iSKOWRRhPWnVV0kLaa1hOccqfo5TYG08+Ysui3sB?=
 =?us-ascii?Q?0r4+6eMNcElw7DO1ycfpyR6f/5d+yUsSNznmDmcQBUwfwiTtmMJzmkEkipD3?=
 =?us-ascii?Q?3V/gsjX/aX8lwo2dy314BrQvEX45z3R4+cU7vRWm3XPOyNkEWOSHlRuv8OM+?=
 =?us-ascii?Q?d+CumdXZ+lnGo9N8aiPzYdpGb3l57i56JwqzK/xK5WqQO80ywjgPvu4q8g6J?=
 =?us-ascii?Q?3mYFKJvXAhFW7b3qBkpc1kQ4mLVZRhHCL7oFjhQ2wvT/DeMuUmEeCyLYs8DD?=
 =?us-ascii?Q?kaPiOgdD+qY0KiAXAy4fvQqF5ysRv3onEZ4xLOJMoDTk8vFkUX+zqdlhaebw?=
 =?us-ascii?Q?lI3ZFMbriLiYtxEiiFlIkQIH2O+5AO+JvEp6ENuiddeG69zG2hN4fh34pDdc?=
 =?us-ascii?Q?aZV+h9m7MplivgvjAujyEs1oqNxihlN0X28UFerhqw31AX/hw4r8vCi++BMo?=
 =?us-ascii?Q?wr0yTDEo/M1RZSwzgYdSY5LErQpHpn9H/3WpGu8FAVCIhYaCoxS+RcmKPvjf?=
 =?us-ascii?Q?pGVYLYP423xAiJJjEhHwM/HnPQ+a0voqA1XkkiL7SenJS0m7cE1ZTB23HIeU?=
 =?us-ascii?Q?LmFF08zo0zyJTcvBKNyPAqoaZomi9EAZY82WzCmlpPcYMeLGza947qbWrmsb?=
 =?us-ascii?Q?XtHZF/sIEYVDQrXD90ObzqFIW4tywP0xoX3AONsJNXR+D3a8ClBBPbLNCa7U?=
 =?us-ascii?Q?2Gq9Kiwtcm+3QSy0/GbuKd3SF5w+NOZk0JlfqNDx55zbYpiOUb6XnAcGEFq8?=
 =?us-ascii?Q?i+x+nLswzoKTn3W3vaEcvaTDl63fEnEolU6GxawOdEo8HLP2oFfrICpgfZzB?=
 =?us-ascii?Q?zc+cAzastICEOrMuVCuUSxeD6fA0hIiTiQE7QxR+x0B5OzPEXQbbTD8MYWAL?=
 =?us-ascii?Q?K/GK0+5u192Nxu6mBXUd0rBk5Oalq8ljr74dQPoUETWFtUPa+RyYML9j9tNS?=
 =?us-ascii?Q?aERdBvLZhyd2K314d0cJuVySIksSdJftMMzkLMhcHzU6GKHh+SmYrxsaqApN?=
 =?us-ascii?Q?Vfd/38nuQuBYn7339F2w/1rBw9lGwMs7oPccTRogfeZMCIP/hTZD8SE7e3++?=
 =?us-ascii?Q?ufySNFutekIAYNikIU7ST/cuLCzH/ue9a2oLiAmm/ejjKOal4zZnKBQDz3pt?=
 =?us-ascii?Q?ilqS7FI0PTLth4iDVReBIiDp3SKx3CUlmr0NOYXpK9QPZ2vYEg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccb00f6-4521-4ded-5d51-08d958a76645
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 06:57:04.7802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ibYV+a7ht7bUOmToWePuFmSs0MP2XGUwI6AaFwxS+XWUspmfXLMt8eOyJglnhDVk1dYH9iAB4ajXStWUqrtXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0445
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/06 15:35, Hannes Reinecke wrote:=0A=
> On 8/6/21 7:11 AM, Damien Le Moal wrote:=0A=
>> An iocb aio_reqprio field is 16-bits (u16) but often handled as an int=
=0A=
>> in the block layer. E.g. ioprio_check_cap() takes an int as argument.=0A=
>> With such implicit int casting function calls, the upper 16-bits of the=
=0A=
>> int argument may be left uninitialized by the compiler, resulting in=0A=
>> invalid values for the IOPRIO_PRIO_CLASS() macro (garbage upper bits)=0A=
>> and in an error return for functions such as ioprio_check_cap().=0A=
>>=0A=
>> Fix this by masking the result of the shift by IOPRIO_CLASS_SHIFT bits=
=0A=
>> in the IOPRIO_PRIO_CLASS() macro. The new macro IOPRIO_CLASS_MASK=0A=
>> defines the 3-bits mask for the priority class.=0A=
>>=0A=
>> While at it, cleanup the following:=0A=
>> * Apply the mask IOPRIO_PRIO_MASK to the data argument of the=0A=
>>    IOPRIO_PRIO_VALUE() macro to ignore upper bits of the data value.=0A=
>> * Remove unnecessary parenthesis around fixed values in the macro=0A=
>>    definitions in include/uapi/linux/ioprio.h.=0A=
>> * Update the outdated mention of CFQ in the comment describing priority=
=0A=
>>    classes and instead mention BFQ and mq-deadline.=0A=
>> * Change the argument name of the IOPRIO_PRIO_CLASS() and=0A=
>>    IOPRIO_PRIO_DATA() macros from "mask" to "ioprio" to reflect the fact=
=0A=
>>    that an IO priority value should be passed rather than a mask.=0A=
>> * Change the ioprio_valid() macro into an inline function, adding a=0A=
>>    check on the maximum value of the class of a priority value as=0A=
>>    defined by the IOPRIO_CLASS_MAX enum value. Move this function to=0A=
>>    the kernel side in include/linux/ioprio.h.=0A=
>> * Remove the unnecessary "else" after the return statements in=0A=
>>    task_nice_ioclass().=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>   include/linux/ioprio.h      | 15 ++++++++++++---=0A=
>>   include/uapi/linux/ioprio.h | 19 +++++++++++--------=0A=
>>   2 files changed, 23 insertions(+), 11 deletions(-)=0A=
>>=0A=
>> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h=0A=
>> index ef9ad4fb245f..9b3a6d8172b4 100644=0A=
>> --- a/include/linux/ioprio.h=0A=
>> +++ b/include/linux/ioprio.h=0A=
>> @@ -8,6 +8,16 @@=0A=
>>   =0A=
>>   #include <uapi/linux/ioprio.h>=0A=
>>   =0A=
>> +/*=0A=
>> + * Check that a priority value has a valid class.=0A=
>> + */=0A=
>> +static inline bool ioprio_valid(unsigned short ioprio)=0A=
> =0A=
> Wouldn't it be better to use 'u16' here as type, as we're relying on the =
=0A=
> number of bits?=0A=
=0A=
Other functions in block/ioprio.c and in include/linux/ioprio.h use "unsign=
ed=0A=
short", so I followed. But many functions, if not most, use "int". This is =
all a=0A=
bit of a mess. I think we need a "typedef ioprio_t u16;" to clean things up=
. But=0A=
there are a lot of places to fix. I can add such patch... Worth it ?=0A=
=0A=
> =0A=
>> +{=0A=
>> +	unsigned short class =3D IOPRIO_PRIO_CLASS(ioprio);=0A=
>> +=0A=
>> +	return class > IOPRIO_CLASS_NONE && class < IOPRIO_CLASS_MAX;=0A=
>> +}=0A=
>> +=0A=
>>   /*=0A=
>>    * if process has set io priority explicitly, use that. if not, conver=
t=0A=
>>    * the cpu scheduler nice value to an io priority=0A=
>> @@ -25,10 +35,9 @@ static inline int task_nice_ioclass(struct task_struc=
t *task)=0A=
>>   {=0A=
>>   	if (task->policy =3D=3D SCHED_IDLE)=0A=
>>   		return IOPRIO_CLASS_IDLE;=0A=
>> -	else if (task_is_realtime(task))=0A=
>> +	if (task_is_realtime(task))=0A=
>>   		return IOPRIO_CLASS_RT;=0A=
>> -	else=0A=
>> -		return IOPRIO_CLASS_BE;=0A=
>> +	return IOPRIO_CLASS_BE;=0A=
>>   }=0A=
>>   =0A=
>>   /*=0A=
>> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h=
=0A=
>> index 77b17e08b0da..abc40965aa96 100644=0A=
>> --- a/include/uapi/linux/ioprio.h=0A=
>> +++ b/include/uapi/linux/ioprio.h=0A=
>> @@ -5,12 +5,15 @@=0A=
>>   /*=0A=
>>    * Gives us 8 prio classes with 13-bits of data for each class=0A=
>>    */=0A=
>> -#define IOPRIO_CLASS_SHIFT	(13)=0A=
>> +#define IOPRIO_CLASS_SHIFT	13=0A=
>> +#define IOPRIO_CLASS_MASK	0x07=0A=
>>   #define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)=0A=
>>   =0A=
>> -#define IOPRIO_PRIO_CLASS(mask)	((mask) >> IOPRIO_CLASS_SHIFT)=0A=
>> -#define IOPRIO_PRIO_DATA(mask)	((mask) & IOPRIO_PRIO_MASK)=0A=
>> -#define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT)=
 | data)=0A=
>> +#define IOPRIO_PRIO_CLASS(ioprio)	\=0A=
>> +	(((ioprio) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)=0A=
>> +#define IOPRIO_PRIO_DATA(ioprio)	((ioprio) & IOPRIO_PRIO_MASK)=0A=
>> +#define IOPRIO_PRIO_VALUE(class, data)	\=0A=
>> +	(((class) << IOPRIO_CLASS_SHIFT) | ((data) & IOPRIO_PRIO_MASK))=0A=
>>   =0A=
>>   /*=0A=
>>    * These are the io priority groups as implemented by CFQ. RT is the r=
ealtime=0A=
>> @@ -23,14 +26,14 @@ enum {=0A=
>>   	IOPRIO_CLASS_RT,=0A=
>>   	IOPRIO_CLASS_BE,=0A=
>>   	IOPRIO_CLASS_IDLE,=0A=
>> -};=0A=
>>   =0A=
>> -#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) !=3D IOPRIO_CLASS=
_NONE)=0A=
>> +	IOPRIO_CLASS_MAX,=0A=
>> +};=0A=
>>   =0A=
>>   /*=0A=
>>    * 8 best effort priority levels are supported=0A=
>>    */=0A=
>> -#define IOPRIO_BE_NR	(8)=0A=
>> +#define IOPRIO_BE_NR	8=0A=
>>   =0A=
>>   enum {=0A=
>>   	IOPRIO_WHO_PROCESS =3D 1,=0A=
>> @@ -41,6 +44,6 @@ enum {=0A=
>>   /*=0A=
>>    * Fallback BE prioritye@su=0A=
>>    */=0A=
>> -#define IOPRIO_NORM	(4)=0A=
>> +#define IOPRIO_NORM	4=0A=
>>   =0A=
>>   #endif /* _UAPI_LINUX_IOPRIO_H */=0A=
>>=0A=
> Other than that:=0A=
> =0A=
> Reviewed-by: Hannes Reinecke <hare@suse.de>=0A=
> =0A=
> Cheers,=0A=
> =0A=
> Hannes=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
