Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48801C433ED
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 05:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4A2613AC
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 05:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbhEUFKr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 01:10:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44685 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbhEUFKq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 01:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621573764; x=1653109764;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=G/tZSV61Fvq+rkmRsBG79yE4pPqeU6iSfbBSOAwtSe8k8lizG31/VP4C
   wLxFXIxzJM5pMZDYn8f3SRGGmmAf9DTIyM7NS8rRTNw3WPNM3wcnMm+w9
   47s1MPoCGlfTtYMiaUZ7XKrgWfnQPE0ZlI5s/ORVX6CFjq0G/c2EMs09I
   IGf99+2SMl7VbA1am7qfxxhtGgv9hv5116Af6vO0ZzUsRKB2F/EvHXDfU
   8JticU4PbRQUvev4D3gWvatPWPFvWD9gvtOl0LTFCY6HeS1FCdWCG/Yl4
   WXh0Mx8yVED6jhei9J2hfq87FQvJMr2F4HLCDjz8GOxJJ1RCt/FsyD4ce
   g==;
IronPort-SDR: 0QYiyKJ6Ykp1EukksL56zrx8ywahc97C8SG07WQagfX78i4mO6fxJ6/EuMsSR5nOU4lUG9wlPI
 jm1J/KZgZbxUg3mvcZOVsJMf/SNMtUUgpBGN5xgkjN6NBfRtq5Tj1seveteVHykrEku6kcVMDh
 Y3AYKtzjg59NC+lEuWwGTcwSqokJNPHgRxchpnlZFpg3+7Ar3dc2O1vaQG7x7zcn/DJUSJDyEs
 Vr2YsCsb0A7gNGpmWu7qEQHzfcDjwnxxwXN/3DQVbHsTqXqVRKyBZzeCwzQwmsM9VW09Dtf4EB
 GmM=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168259071"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 13:09:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3AqsuvIbuUEuLaL++SA/zte9Rw4v3bkcZRVmZglKR7vI2OjrGqR3u+PI25dbOZL42t4MV1zVTaRWQRAl24Pbo8MqELCyRyKF0G4M1G69y9b8NwwONTp1jViiAnrOeiTIXuzoLrlJnpdm/rKPuCK+vQhcBhHUnK1qOtYZyN49nExbNZ9rEpORzydocriW0tTdhKJLqA2OMdiJOctBKOJ+yCRfgMRwuFRj+DmnLumTM4+gB6jkzI1z8JGiBT+XCD9HciwWa0jEnd2z9sNgypP3NH4h5MlmLkv3JId1ktwmtxhbi2tkjYizW7pKCb1O1R/NA8B279/vHwLVmwbJLMKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=cOdy3/+j3+Qf6ScYghjqfNgMX9OGlvyBs28Th61Jocba7UFruXA4HzcdEIrIK8dM1nL1yEZ9wwu7C9L+XeAzX4s7Y7htuopScmhBBakX+AD8W3J7pfiTj+KIe3V6u3NBR8RDq91xm9bxT6+zqvcF3o9RaISv+T6orlYImpqTb7UmxpVHBBupWJq2RhB3xu7F+6rvflRaHVDqe7RK/oSMXe8VRfyqBYvCLTS4PaJwVOOeCAXXtYs7SdweZD04/+UWjgoN07x+gx/wCUNTYBc3jrI6T+NMqlCeKv3VPJ8IIUWuEUz7aWhbSDD+fqFcZm/4F2smBRYPPFpNwk/qIQ+/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=rmQYBUJJzOTMTYqV5vnPRnfqPg+JYBiJXtaRNnYtPfNxxfqP+efuGdRwzSmYsyGCHxoGl42FpMvZ0JGaFBwm6a3ETmOlpFqxneQKd9t7OenMBbDlv1HsRwX/PU8vVz06sGG32Rgibf+q6n3OyRFhvCjWUnYqCdxYk7p/A4sHwoI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7687.namprd04.prod.outlook.com (2603:10b6:510:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 21 May
 2021 05:09:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 05:09:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 09/11] dm: rearrange core declarations
Thread-Topic: [PATCH v3 09/11] dm: rearrange core declarations
Thread-Index: AQHXTe2jwEKUsdZ0OEKCjUHa8KN/AQ==
Date:   Fri, 21 May 2021 05:09:22 +0000
Message-ID: <PH0PR04MB74165319D862AA1E15C3A5DC9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
 <20210521030119.1209035-10-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5a5dc51-dece-473a-1cba-08d91c1698a1
x-ms-traffictypediagnostic: PH0PR04MB7687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7687019A22FAE93E1A82FBE49B299@PH0PR04MB7687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gfT+4FSMHX8fd6vNWFAn09o17Og7VDadccDjFpzNIw5bSIJQGvHxbejXPoB/7zTY+E/aI6ei9rpv29+XFH1D3xU3/Q+OkROIb/jRNhecdgX34W7VNyaIkSqwyMD3TTCqrJ4670o0mzGedYEYafUScvj96mrkKI2GeFmY+ix6ZiMB4K9wi1wY9pNbjC8Dtj9UQut1MB+Um+6CUqn/jKx2jMGE1GNnaVAdEpPYZ/THGXhohAduFel4GrIJQhTh8vlUt3NZGTH8X2JeRoVYg8U9iQCAncdkq1o+SjsAbKFgUAabPWDrPwBo0avJfuVanK5JYVOylp30JioPRSvcjubOFgh8avS1TB4qBAz1JhCKGPlBzcPTPszrZKz+0ZCjUjkOCW3bgeDQnnezUDkA0vfllIB1fI9zsh5lZ+M2oAZRqoAVCgGAfV9SXif5PEFfL7Ch2aPBnB9yqcsQtnNeFtvTnQa46jeB0vZYe5MaERt9TXsHfglBs1fq1pibudH6toh04y4JdClZD8CjXX1GDGh0Vz5nuNBVGJqp0JfvphoaS+RkZRJ4H7365yDLxPINm6Oed9z6jsmUOdy4nCLN96vtH+sXM0y7WBfhumewRKbJSuM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(4270600006)(38100700002)(19618925003)(110136005)(55016002)(558084003)(2906002)(8676002)(186003)(8936002)(9686003)(122000001)(6506007)(316002)(7696005)(5660300002)(66556008)(66446008)(71200400001)(33656002)(76116006)(478600001)(86362001)(52536014)(66946007)(66476007)(64756008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xE5Qd9N+FsEXqMosC4d4Sx6xhuimLe0sIT39u+5Z+nte7Y/r9F4c04luSRjh?=
 =?us-ascii?Q?PZs4Qk7DkBxVdm0bytFYnDrUv1/MmdltgajvhVROY+5HA+CzsQt5VYctYlft?=
 =?us-ascii?Q?J7+2Rov3o5ygTtc6gM4r3YkK/fMg8Mk/N2YpI6i+GbJb6GFpSe13+Om9tOHV?=
 =?us-ascii?Q?JqPx1uapPUB2vJFffHzkGwNJUIMhZoHe8aZKNPx+1A3dIml56RWo10VIM8cQ?=
 =?us-ascii?Q?KfGMEQB4iTCeX94i4jzqIgo3Qr1POmteEpzMPusnt/DCKgPN1OHYmvvWiH7T?=
 =?us-ascii?Q?Wu1iUcurTwVEtbaDW1pJBEYXa3UPXgrR0pkzIHmKPUERCFcEzMtJdygOv+88?=
 =?us-ascii?Q?ilKr7+nwoFXh0ASDaZtLBjllWZPdXq6QpBI/l8UHfNtJuZ/QCHTsJTsJNv35?=
 =?us-ascii?Q?jlfMfOE/Ekr7HNq6TDTNg7wCjGb4wxgVf1NHPhRKYnNuHEolcnQAPz6SLJOx?=
 =?us-ascii?Q?s71RLnhg3/uWkyz6LRnUaE+fViGJSygZqs1rtfkHVuDHi5QE78BmSHZv0XG2?=
 =?us-ascii?Q?15vdtzmjXJbF+Wx6eAmyZqm1ZNdCGsJJwEtUe+/ONYm9KkPehb0Af6QeIecI?=
 =?us-ascii?Q?chmE4ZbozsxLPUuL/Dpx0zM+T/Tl04vHtBqURE9FrBzKo+tCMbrg9iP+Zm9j?=
 =?us-ascii?Q?9bEUAuD9LzQVfxss02U5abtMdZoqoNDdx/R4dYsMN+saWNm3ZLdMtecBRhJ3?=
 =?us-ascii?Q?a3MzJ/I+8IqvspV00W54z728scYOKxK0fA4H8da6s0/MTgI8JusvCwNiBJuU?=
 =?us-ascii?Q?sAwf/ek0zEh5gQBUDdvNVjlAuk5C5YbPWhgO0S/GrGNVRukSOI9Wa7owWh5N?=
 =?us-ascii?Q?0DOInKZfX8/VgQGhbWTZbkIQCpU8aucPQYLmpb7u78rrvWeRCnkkppL7Xabs?=
 =?us-ascii?Q?YLv3jJ1iCLL/bGAnxuD9Z4Lf4BKeVAfLhtYIzwRDXIvasPVgnBHdouEoDHWw?=
 =?us-ascii?Q?N904h/BGV2M2CgVvvJ5l66qFxcDUd5ygsC9xH4Whb7+aT6HholAgaZAiUPg2?=
 =?us-ascii?Q?sixTItmEvcd9olUbWoqVzONpQV/Lb+/k/FXmwAVLJLUocEbHtbXXDzr+oueL?=
 =?us-ascii?Q?zZpvTlz5yg3TXqwq6O8w2SQmeuTzgh+Pk6eFucIcRUxJVfM3qnoLyDo767Io?=
 =?us-ascii?Q?bKAdg1eOx3JkmIVHAEhBV51zCVO6VYrsscMmy8GZqEWdPhqqUCMY/R6+og0F?=
 =?us-ascii?Q?lkfTi/ZNnq36dED++oD8x+Hqs1M/RP8X+KNrkydZIabOVYCDyWWeGBda1rhm?=
 =?us-ascii?Q?BH9G0Zmo7h0QypkytsLxiO/WeWuGi26uKU0gpjkOSXtfiyWiN7G6S4Psph+Q?=
 =?us-ascii?Q?IP+yj+T9oArEoZUQhKGfCRXtlrAvqo2iUEIS1j1VTWluS1lw5UOPQ9XTFNvn?=
 =?us-ascii?Q?BSdT7j3kve1n3eXHgbTaTQCfkMcQ005+HCdCKSsekrlz2JuOKQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a5dc51-dece-473a-1cba-08d91c1698a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 05:09:22.3447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20qcMT75JYKKwRiryDLy+2Q2KH1V7Wy3IsUhJmhepfuKGxbKZhSWUs/9Flp6895aZSZAaL+3hWcSMkKp3OqAfFqB9OMLOKGbqg3CEFT7i5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7687
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
