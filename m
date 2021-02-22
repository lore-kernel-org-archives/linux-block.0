Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEADC433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 03:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176C964EE6
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 03:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBVDyG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Feb 2021 22:54:06 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23160 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhBVDyF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Feb 2021 22:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613966044; x=1645502044;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ek/Mw+BcVLto1IISH7PGeL8j4YPl5syNFSPWSSsoNKo=;
  b=FYIzZX91513hP/VOavcEg0tm8jip79rvuccLE1c4RrGDc6mW88r7Hyly
   c1PQXpOCqK478ohTwGG9HpwR+epOqH4CrlkuI9Mmp2m78GkMpRnN4k5D7
   Eum5T2vL4QHRYZa9F7ALAEvcVEZWziKwK85L+L6LYhbn+RSI9/wAzA0Ch
   XLWf4HF/35+l6k9Ag2A7oCyf9UJDrLxcB7Eo7cSmNCnVg8cvmnvbiW8jf
   X774umbvIyrZ9WkckVInONks1qDSjGbooHzTABiUg56x23ydOfwYjFsFD
   16MrMy/ViN4+/yGuUxzcHXkUKl9xQkc3DF2EluEHc3Kk/QHYQOKpWO2q+
   w==;
IronPort-SDR: Sm12eyfOceYeInaJL3opAUCAZww4a685Cp4TDK8QtSgIS+Mn6gcCE6R3jJ6rRX2uMi/gU/2AnV
 tIW0tqUAXzkhRbxZaSgC5DGKqg9j0jxEs6DKirl8varQnsWmpHIDaZSnqxV0vJaYZ7x5HWtPPc
 GWsoJe8QVdg+UvB4qQWa436vXD6qo8GcOSYRgDVCfHpNuipQLkKsiDwBc/tjGpJzqcDCDmrKAb
 qeCAAOoVV8kOv/jyCtRNbRJcrOcocDWKuQbg7b534gHB5n2xecE+CmnVhpPIJKWlQiHeFbW2On
 vps=
X-IronPort-AV: E=Sophos;i="5.81,195,1610380800"; 
   d="scan'208";a="160482459"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2021 11:52:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAu9dpYCSYMc+KvRGZ/NeUkaVMB7FQL8/tD91RiYCYM4PeWBSaj+S6I9cyweahzudBJo2XoISBTjUOwMWkB7hY7br28bU9hze6UVgB53GzkjFQqwRfLluuYJUf574gkhQmGzYwK/4eM3lUVHbcxn0lwzl4tsUT6zbKkwf2TbjajqMRiU40I/Fh/QN3HfOR38BojUFCTCmrosgOM2RGZBoszXnXfh9ESpjRFpTk04weKx5wuDaQijE6JfrYtljk5BxauOqzXAXmekHw2F733aH4NAI92w88Of5WtdjKUKYj3DCsvQ7uIZhOaoQOaN9EzqKeXnE+BqBeELOuLfpnn6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek/Mw+BcVLto1IISH7PGeL8j4YPl5syNFSPWSSsoNKo=;
 b=SaMBU1h38Qawbq2ntC7CFeGXhAvvn2KOseZMUw0fStsqHvXZzPLWS01nE5pEeRjhZfMYYipgMyI8uKjg8lcqe7A/FprsEZEaeBkhpHn/06LroKQagXIlRV1aFZyb5K2pVAgKyRnnnHGzzDXmZbV+m4rXv5GZFE7AZpOP0aK5ax/NMoqd7zvt/oA2na6gnXnrWLQ+A2eVltFfdzZhcffVD4dIZmqtTr2URvYRGJXLU2oiwnEQPLjHV4vSywKEezWD7FRwj8+POOqazbvst5oy4UJB8iBrthHeJjKU9MfNuw8hEe7Es4T1QrStXiNAbKxxRTURzn8tnctOgngy+0Wrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek/Mw+BcVLto1IISH7PGeL8j4YPl5syNFSPWSSsoNKo=;
 b=AYR55JMnfbdpR5vyqF4v+FKfAtZXBRZ49JDR1ILvbnwsgWQL/iPj3kiUPJBOkRkY4WFc2n8L3xuGkpNeHueXJ2/pPjAMh4IcNFVj/2Ote6emMBdOvYdV3bRtD6ekn9RSE6qgCYiW0zKmpO/hdr6rRqCUnYmhjOlJNjV+oPnOmLo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4232.namprd04.prod.outlook.com (2603:10b6:a02:fd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 03:52:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 03:52:56 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] block: Remove unused blk_pm_*() function definitions
Thread-Topic: [PATCH] block: Remove unused blk_pm_*() function definitions
Thread-Index: AQHXCMKEvGxnSlEXakevH+itZZSA1Q==
Date:   Mon, 22 Feb 2021 03:52:56 +0000
Message-ID: <BYAPR04MB4965BB91BBE47BB21C2543BD86819@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210222022805.18196-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99fe89ab-84e7-48e9-36a4-08d8d6e556ed
x-ms-traffictypediagnostic: BYAPR04MB4232:
x-microsoft-antispam-prvs: <BYAPR04MB4232B90B2FD3677B02825E1886819@BYAPR04MB4232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:248;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9HRjDOxstviJoBJvM1QVRzqF6l4wy17G0f8Uw3zC1yE0D0JIVz7WIKaCKVKgQjoWWZK/Gs9otWudHw25M+Jj3iLZNAX9zzEuWPNV+ac2Oz3opdNSDRtbVsQQwVnz8p6x62FOlAMIVz+OBQ18kqvk5sh7hteN8FwyCTV8K99l/0hUZn4TSjZC4N9/D+LD+furoVftTZlvDaGB9pM+ejdjHe7SxFw7CdI63Eb4t7tNtJVjEK6iuY9r60DzuKyW4CTlM7skkjWVIMlJ1BEg1kRmRcxMQrrvaJB0uhe2wa4Bj2Mw4WYFZPdNDjtqw4tHs52BU9VkqmqnP6YdVbBlzR95kBhCptrYrd/ZigQGwepu1lSmWXMnnLvtHI+DpndMsNnu3XZ4E1+1g6AJn5NaKaPYSfueR8jhDG4wS4A7SlJw0KQVzIK3JEWXWetJuVeItKgGegF3Zu+S3bEnd8UcXGA2xMp7hyYVU43Dm0yv/XG9gNwqb7UpeHOMSu4tPZRm9WRTV7qrNih8c0Jx248fDwvkgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(83380400001)(478600001)(4744005)(2906002)(71200400001)(53546011)(316002)(7696005)(54906003)(8936002)(86362001)(5660300002)(66946007)(64756008)(66556008)(91956017)(66476007)(8676002)(66446008)(76116006)(33656002)(26005)(6506007)(9686003)(186003)(4326008)(110136005)(55016002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ggLG1UBnUjDO1PJ5bZ//yBWLZLcAOD1wEqNOx9teh2BaJtucen5S7h7e8OZ5?=
 =?us-ascii?Q?lUdk2JxY+oo1vUojIqFp6nwsSt8lzBo3wl61QyKf+FJeXaP2plqEevCe3aT/?=
 =?us-ascii?Q?A8/OXMEdH2CTWFDvCjXlhTEoEHVMqVrKTModWou8Cgm3sv4Iz8uDgepWbVoH?=
 =?us-ascii?Q?3SD2watU4GoKjR0kdXbR0ETV4c7jtVzuaw8cQZPxV6DQ5S+FC2KVDj9afsaR?=
 =?us-ascii?Q?ZKqYL8MqYC6JUbRh9z1DbELWL3r7Iw098CRVBXzMlkO717N6iUc1Qi2gDaUC?=
 =?us-ascii?Q?MN2GFZxRausYtcUEAD0ME8GNgcsI6nCW1Z1C3YAM9tcHGqkmvDumZsYMpuI8?=
 =?us-ascii?Q?5fUfEEsIcqycBGMM5cb3bh2J+5pK95Wq5wQShp+2IZfTENpWZplMUKpnBEJB?=
 =?us-ascii?Q?hDg3dE+zLkcdwbe/obBAUc+eMjNHOhiieixnTFPtb+sYHN6Zi5k/x4NwpBf/?=
 =?us-ascii?Q?vS2NU3zP1/dAFkwDnsBtG7jj+S7CAfqVEcNxEIDtx4JnKp5SYeK8ZGCoUJUL?=
 =?us-ascii?Q?DQUBgKzKQ+RFdZU4FGaOwgRu9RdEwQJn84QJTjuR+dLfSUkEwRtmJULwHT8p?=
 =?us-ascii?Q?ptMObRLqoju6TjHMiW2IJWiwUYuyMxXsK8dN4i5n0pJmdXDMoAqr/gJ9yBLU?=
 =?us-ascii?Q?VWlCJVfYAZDrNuM3vZC4tVu2ol2xi81P9Qr8pjeiVji5NFDI4duJWyJ4R1+Y?=
 =?us-ascii?Q?gXIewtG5hfJrLle432Li+xNVlSSeVeKoMJDKiAvQ/CxJpQdKiju43Oza87Fz?=
 =?us-ascii?Q?3MUAkAvTDPy8sx7OEZc2+nksgljzNmJIKXJWUQZIYK1ZGeFHTmn+vaBFHXpd?=
 =?us-ascii?Q?fdYgz5PEDfK6oa+vsCdz8VcZjjGnZXM99daZlUYMs7IFev6Y4/bU4X0c0CTB?=
 =?us-ascii?Q?L0XoPh5bLq3Oz8X2YgkKgfBsGe/1pp0H5Uoska/ArHPdGKkI5Jqrbfm1mgbh?=
 =?us-ascii?Q?+qPMMAXJiGEJKgFxwuCgNUvEfSwW1tpXd5UftoJzUpwHK6C6J8BFFFetdFaH?=
 =?us-ascii?Q?ThXbjjS4vwmK3dAm8njDt8jgv+pUBjnkUyRySfjy14D/Gkg/81kaCcQscFqz?=
 =?us-ascii?Q?WXohva1gHvUGJFQJSr4W3owmmbIpn5lSaV7e7LsLUhwPEOm6FjXLCk/MpGY5?=
 =?us-ascii?Q?gyU0DeKNN+wvhCCzpfXNHyVW2sGFfvtjzRyDyfVGlutepMlvt/sWWEf3cV3t?=
 =?us-ascii?Q?swoHk+vGCJTvwD0OLg4CTYon9Zo1aDhgqHPFqUuwd+WL2Bf6EZnN3gLwoozd?=
 =?us-ascii?Q?um80pOImtrSK6XDp8rFAFmW0hkrrjcv+DypqPDMqeOqxE95zfm/E19z5fncg?=
 =?us-ascii?Q?vzUgPiJCXaMD8gaYeK41F5It?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fe89ab-84e7-48e9-36a4-08d8d6e556ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 03:52:56.5967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Em3P0km1147Igamt/8gfbG0ZCdlZLIXMXXvKBxHXF+iUzOFk4E8DXuxlKQN0wuREhNpQt/VGutFJsh2fXta4zy274KHnXQVnTT8j3N4Zue0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4232
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/21 18:29, Bart Van Assche wrote:=0A=
> Commit a1ce35fa4985 ("block: remove dead elevator code") removed the last=
=0A=
> callers of blk_pm_requeue_request(), blk_pm_add_request() and=0A=
> blk_pm_put_request(). Hence remove the definitions of these functions.=0A=
> Removing these functions removes all users of the struct request nr_pendi=
ng=0A=
> member. Hence also remove 'nr_pending'. Note: 'nr_pending' is no longer=
=0A=
> used since commit 7cedffec8e75 ("block: Make blk_get_request() block for=
=0A=
> non-PM requests while suspended").=0A=
>=0A=
> Cc: Alan Stern <stern@rowland.harvard.edu>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
