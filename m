Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F6BC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 22:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B768B2087C
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 22:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCMWC3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:02:29 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:48742 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbfCMWC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 18:02:29 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DLuaQZ018055;
        Wed, 13 Mar 2019 22:01:48 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2r769psu7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Mar 2019 22:01:48 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 455C174;
        Wed, 13 Mar 2019 22:01:46 +0000 (UTC)
Received: from G9W8670.americas.hpqcorp.net (16.220.49.29) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 13 Mar 2019 22:01:45 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G9W8670.americas.hpqcorp.net (2002:10dc:311d::10dc:311d) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 13 Mar 2019 22:01:45 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 13 Mar 2019 22:01:45 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.147) by
 AT5PR8401MB0578.NAMPRD84.PROD.OUTLOOK.COM (10.169.3.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Wed, 13 Mar 2019 22:01:43 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::44e3:e2c0:c9ba:c03a]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::44e3:e2c0:c9ba:c03a%9]) with mapi id 15.20.1709.011; Wed, 13 Mar 2019
 22:01:43 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] floppy: fix harmless clang build warning
Thread-Topic: [PATCH] floppy: fix harmless clang build warning
Thread-Index: AQHU2eM4YAW9rIQZhEK1X8gWSQpJeKYKG6bw
Date:   Wed, 13 Mar 2019 22:01:43 +0000
Message-ID: <AT5PR8401MB116964D0C90783A164834C2CAB4A0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20190313211433.4178148-1-arnd@arndb.de>
In-Reply-To: <20190313211433.4178148-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a8e2d4a-496d-45d9-1a88-08d6a7ff7ac9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0578;
x-ms-traffictypediagnostic: AT5PR8401MB0578:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AT5PR8401MB0578;23:oZmSSvtrWYOo0Wakx0UwclYnSHY9LW4Gg2UOAa3?=
 =?us-ascii?Q?zB8Rm8REO/mEAcvXJuV2S1tT9SniAAB3yvhOMTyUBT5T4PsDUDDLUyR1Qcii?=
 =?us-ascii?Q?xiSAzjZ5yBnCGiAQUVSlCZ0I8k0UnYrAX/hu3dEFVapSbVSjROBccF1Qr7w+?=
 =?us-ascii?Q?kNA/6QCPlvDOhtuP2f0P0DFEeHBvAMyGPoBTn9j48UjgiBRLHFb4TrRfpVEb?=
 =?us-ascii?Q?SJkZgOCyI97U51BF3FaTdw2XKHdIhX5ll8mIIICMO8e+ndIzL/evk+ulETlI?=
 =?us-ascii?Q?5u5kMaF2xL34isik8O4XcbgMxdxBughcx09g2v8ua7SxsNIUleCs8cpvDTop?=
 =?us-ascii?Q?D716ggvDUL8M7kxMweF4HQTdmK5BmQlmjvzYkbFa4XfzFuwRLyD4u8vMMXih?=
 =?us-ascii?Q?37M9QqGM1pZaIIIqLrrsxCWR1vERKY03cmUiSmfeD8B9cTVOaIj1f1/bZ9jw?=
 =?us-ascii?Q?lqa2CHJT78ssyCPCUu6khXCk7ys4R5YgUzLQe2YZNqSstkuCAfWbFYI2fjCj?=
 =?us-ascii?Q?hBlYnuo8u/Gifx0wK0Qk36HF3mgBsDnpC3cUVqMM00G6fD1XNV0Odiz7T/tL?=
 =?us-ascii?Q?s2WJbBuDpPduuqP+kh3BAMeMzRy6yQO3dZaaRsjdcopuFbjbFe/H8+zBf+Dq?=
 =?us-ascii?Q?5WmlKf5uu7YH5hypeuk03he7jsr1/tOtEPZY+6DDXM99frfNLTf5J06UFQku?=
 =?us-ascii?Q?wP2b/DaaNwhoXpkItT9aeomXdFfTPVAm3Xdz5lPMaMKj1HPCWrZNLoT85tOv?=
 =?us-ascii?Q?rponqMDUMG7ORthpQCb6pr3NGRcac51LXJce5kI74EJgrIYHLutkviv5pfs0?=
 =?us-ascii?Q?Z4kyidt1qboronodj64wRHDyVj+wYj/j3Aqvx4pXDTwAhjt6FWmLOVgkwAor?=
 =?us-ascii?Q?Km4q7Sg1RiUt1LIdSH5JU0eCPEMngQiNPxZHNXm5t2NuQl+94CLlYyvYECbh?=
 =?us-ascii?Q?wIXZYX8kjxM6qIgzsQg3dXm2mR0KAQB0LruNbe48RRmclehcF6Wi4I6FCa5a?=
 =?us-ascii?Q?ZVVnaaWYzBXpqDhgO6DeRse5cBJigM9h7NQND+A082jtKd4UyT94C5/pmn/j?=
 =?us-ascii?Q?FxoL3S+SM40aJrR9tAaTqaXXun3AZZUinseLDXAcLfqlzY9CIaC6+jpA4VLO?=
 =?us-ascii?Q?QBtOpYsjd8CXk8RJT/p6uljMdX/DcRYhoWDhQlYbQSKfNd4CJYj4dLbO+OB9?=
 =?us-ascii?Q?aI9uilQap9ZIHvDPE0tRV3xH70m3JRHoqXQ/9n8t4u8IksLqESnOF3PRRjcJ?=
 =?us-ascii?Q?LL7yJ3V/2EgP331OtxuFjHMmkILTsl7P5FeFRU1n9//PgSaMpX8faSOUhc0T?=
 =?us-ascii?Q?95Q=3D=3D?=
x-microsoft-antispam-prvs: <AT5PR8401MB057897DC92B80E620E9D37B9AB4A0@AT5PR8401MB0578.NAMPRD84.PROD.OUTLOOK.COM>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(13464003)(52314003)(189003)(229853002)(14454004)(8936002)(4326008)(71190400001)(305945005)(25786009)(33656002)(74316002)(3846002)(6116002)(316002)(81156014)(7696005)(7736002)(81166006)(76176011)(8676002)(71200400001)(478600001)(110136005)(256004)(54906003)(97736004)(14444005)(99286004)(66066001)(26005)(68736007)(53936002)(446003)(9686003)(6246003)(55016002)(476003)(186003)(105586002)(11346002)(86362001)(6506007)(53546011)(2906002)(106356001)(6436002)(5660300002)(102836004)(486006)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0578;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2xt6/DvfhAjg0jqakc2jU+ybqeUx9aS2NYg9/r/88YsJkqP+ObeAoRAoXHKhp9do7lUhrhW2XF8PXGXRnIMVx2DE5GuDP9oSvUzOg9U6WErst10fItBHW27cxgWUyEcUiQb4ldFqgCdP55pKR/qLf6xkPesiwalhOewApBJbMZQRSZKWicdo26G89AA3EcoTDZNfadpy/F8LASszsLDObtqVyTNiJ+Gb3Zg+NJ+xJF5k/Zdpn9yMImdWFHnGf+UpOlwiXdpAv8x+aFpo1j3QJtRHDi9D+tE+VJEI3GP4l3pTBePQrB6+UeWjYNagFkcD4ffPkhRm9pOf6gQMo4UVX8OomL9mUlVmzFM5lYjlYBaPN6wLtqIEqzt+Ru3p9U9MwpEX6+7zAFHZolkKMC8En1odeQ6dH4NuIdNXnYJHKYY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8e2d4a-496d-45d9-1a88-08d6a7ff7ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 22:01:43.6111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0578
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130149
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Arnd
> Bergmann
> Sent: Wednesday, March 13, 2019 4:11 PM
> To: Jiri Kosina <jikos@kernel.org>; Jens Axboe <axboe@kernel.dk>
> Cc: Arnd Bergmann <arnd@arndb.de>; Omar Sandoval <osandov@fb.com>; Hannes Reinecke <hare@suse.de>;
> linux-block@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] floppy: fix harmless clang build warning
> 
> clang warns about unusual code in floppy.c that looks like it
> was intended to be a bit mask operation, checking for a specific
> bit in the UDP->cmos variable (FLOPPY1_TYPE expands to '4' on
> ARM):
> 
> drivers/block/floppy.c:3902:17: error: use of logical '&&' with constant operand [-Werror,-Wconstant-
> logical-operand]
>         if (!UDP->cmos && FLOPPY1_TYPE)
>                        ^  ~~~~~~~~~~~~
> drivers/block/floppy.c:3902:17: note: use '&' for a bitwise operation
>         if (!UDP->cmos && FLOPPY1_TYPE)
> 
> The check here is redundant anyway, if FLOPPY1_TYPE is zero, then
> assigning it to a zero UDP->cmos field does not change anything,
> so removing the extra check here has no effect other than shutting
> up the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/floppy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 95f608d1a098..56815446ed85 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3899,7 +3899,7 @@ static void __init config_types(void)
>  	if (!UDP->cmos)
>  		UDP->cmos = FLOPPY0_TYPE;
>  	drive = 1;
> -	if (!UDP->cmos && FLOPPY1_TYPE)
> +	if (!UDP->cmos)
>  		UDP->cmos = FLOPPY1_TYPE;
> 
>  	/* FIXME: additional physical CMOS drive detection should go here */
> --
> 2.20.0

On x86 it expands to a hardware read, so this would change the control flow.

#define FLOPPY1_TYPE                                    \
({                                                      \
        unsigned long flags;                            \
        unsigned char val;                              \
        spin_lock_irqsave(&rtc_lock, flags);            \
        val = CMOS_READ(0x10) & 15;                     \
        spin_unlock_irqrestore(&rtc_lock, flags);       \
        val;                                            \
})

