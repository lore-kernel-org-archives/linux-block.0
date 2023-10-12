Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A864CCDB465
	for <linux-block@archiver.kernel.org>; Thu, 12 Oct 2023 02:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbjJLCQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 22:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjJLCQP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 22:16:15 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3315B6
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 19:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697076973; x=1728612973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wIqKtifsql7HBxFiCUX1oi5s3wrxIPdnMRedZ7aH1Os=;
  b=ZVZdLnrpFUYS1XXrTkfTimjGZmv0t/mQjqduSOECld34JbTBg5y7Ql8A
   ZsmEzcO5IhF/qD8udtU0xXYy7WvD8oe5M8Ww/iED663SuBCchbJRs4Vf5
   o6qNpWgMz/MO6rA9HPfGKzxDPiePycfRlLwf90LrL+97Ur1YHwWR5GVR0
   Mmcpq6kg59I/C15ylBMJ5BA/cUgHkzsEZWOPHwDXL1Jqxb+s5u93CC7iN
   3wn+gnd3RHInJVlJUcvvaJuN+ON1BHn3fSZK+yj2dWHUhFDg3tm5dZKWY
   Jh26oTRAAnn9CCsDseTzrSV/qVqQU4v8aA7D56VMbc4/dVWI/GlfpLwAj
   Q==;
X-CSE-ConnectionGUID: +q+16d03TSCi5rak+oDozw==
X-CSE-MsgGUID: 2VM8ywceTjWbgHSQnuX1Eg==
X-IronPort-AV: E=Sophos;i="6.03,217,1694707200"; 
   d="scan'208";a="246344879"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2023 10:16:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYgCteHEegm9czTuSWWbBOdhsrX9iX+JzQWi69/1O4jhj2O3IqvIWDpKvLLv3yB5DICT7U1czD9EXHEs+k9eu5Bt1N8YR89EVvB/Py7/Am2BXFoE1Fxykm2QUXZuXeYNRGYNK8O+DzTzGezt5KnamxZCagGEm0R6JbL42Jmg0NhUDjgXGP9Ajph7JwHqzoYX6Q3iB5rbw7xhkJ83CcJ3zbnIB3AH/quwuxJIXNOqAQAaUxyL+02iOJooidbf8E5KQba9F5H72GdY0KRiap2N1OmXRhAk7NvxzMgPO+hJ0qjy4H+C+LVTHqUqprOv1nw119xJWUqsZVfusBNSRrEtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIqKtifsql7HBxFiCUX1oi5s3wrxIPdnMRedZ7aH1Os=;
 b=PYm0I3zdYipr4SwCgocjXGm7BkQAram1ZhEkASAiE1XZXV8Olgrro0RrKRIApJs+SzGYUuSE7cyr0jnVWHpgPSKO5w2M40vH5j004OqYJQL7RkGHOFURgUpbjig4tWEdPoH7V3EAogSd7XfIKDpj+p8RYZw265x3ud1CXCMF5VYyp3kY3jkSI56/15my8DWFFpgwCwJESSD17iSIBOF92sKn4rXyWg/rdPK43n+6P3uu/BOT9q0NvNNgT6Fgno5XZ2YdOFfxQ1iSwaSpzAkBRTNAYzjobxHCZ562MHmjrKU96vMeqQqWQgIxV5KCQetv92wHhcgWC0O9McrLsmaUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIqKtifsql7HBxFiCUX1oi5s3wrxIPdnMRedZ7aH1Os=;
 b=pzxGtj8RXnbkX/lRAYvXLNeSbDI394Y1EL7wuFI4H6K83H4cCBgOlkSmT9z2fBJSUR4qxxTkBej4E9iJddoWxySZ2NITXsCCRiUTUPV9MJoSRkOBQucVewAqGquhtXS3QhZZlK877Gpfyec7ho/dYPd25KIqy3ClZqk2YPJZD/4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7254.namprd04.prod.outlook.com (2603:10b6:510:1b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.17; Thu, 12 Oct 2023 02:16:10 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6886.016; Thu, 12 Oct 2023
 02:16:09 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests V2] check: define TMPDIR earlier in _run_group
Thread-Topic: [PATCH blktests V2] check: define TMPDIR earlier in _run_group
Thread-Index: AQHZ/BQuNTeNE6FHfkew+kse8OVtW7BEOU2AgABHwwCAAOrQgA==
Date:   Thu, 12 Oct 2023 02:16:08 +0000
Message-ID: <rkjw67rr7p4rhzsfaz7vw3gouy6bx5xfgstrcevxlyuanzofay@eqvkca2dcmeh>
References: <20231011072530.1659810-1-yi.zhang@redhat.com>
 <32utqb6baqrfphxoqczb66htxatocmq36yuwmkzib43g7jvjol@3uo7bvraemyl>
 <jx7js2zxcxvpdrzsf7dkca4ruiqr7luowytnxtbygbtefj2qwq@jcasd2evlpvp>
In-Reply-To: <jx7js2zxcxvpdrzsf7dkca4ruiqr7luowytnxtbygbtefj2qwq@jcasd2evlpvp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7254:EE_
x-ms-office365-filtering-correlation-id: c1a9daeb-66e4-4406-102a-08dbcac932b0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vyux4p2icBAh2b1PBYT/610WrFuQsBzLIWBjZ8zAx3H08OT0RSZyQ8jJ6VafMoypl9eNULhS3+/h4S8ld8VA0A+kylzT0Gl+U6D9RBQ9PEs2IuaOrj5m0I4Qe98/WTNM6J5CMtfYkej3zRK7j432gN0IobjYMgNpTx78UN1b8zZRHgls3HYWcA84H2x5B7eG+L3utzXnJfiipGlLaJjzpVaXY/lYZbhA4V2ERLP1dg0+iKLta2ReFl1JzCh0Z0q8Ybe78CXXDzQJftwFJvMnjGUI1Wf5sfUx+BGRl6pqOBqy14yREQw70g3d+ZTQrjvWh54tNuIzi8CDPmzmriql4EC3cZptmRHI8hhTWMvwPQuOLpgGqAIKCToEFcToJzgXrwyiY1+WqoHvfE+plOgI1kojxeIOIr6oDiD7Hm2sj89O4qoxEsPIzEDYQSRgOzFBjhckiad9eGDGKhYTIOH/38lnOnrTq5UM8ZuG+fzTTONN2x5gb+dXKDaJRrkH1o70I104YPxr+eiJ2U1jUjwp9NaMueqpLQ7CvzjN7C7/II9s3gYlGqrRCHHdf1AJB4dxz9lm3gnj356m1mirG3Lfnw3IUuiwW+/i2mTzcmI/PCJqBgt82ZSKGlak1Q/t/aqr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(66899024)(9686003)(6512007)(38070700005)(6916009)(54906003)(44832011)(5660300002)(66556008)(66476007)(66446008)(316002)(64756008)(4326008)(122000001)(71200400001)(82960400001)(8676002)(4744005)(8936002)(76116006)(2906002)(91956017)(66946007)(38100700002)(41300700001)(478600001)(33716001)(6506007)(86362001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mBH/OKyhXzmnF+NHIcnyigy1SC2jqEQeuEFkmvNIK6cEVArjSruqGPMFExpk?=
 =?us-ascii?Q?UO8uYxxVKW355higwomBEJiDhzsi2F0yBRmWcik6GKdHAFvvQ7L+CSsJigFr?=
 =?us-ascii?Q?K78Cb+UDG26cKfXD3iOHiqFy+X35iPXaj2Bv+b1kF1FHST8xeHrHo4CSSPez?=
 =?us-ascii?Q?P5MmwxktPUprrSujL402Yq9autyivbhw3ypoZsknJlofhllaKieZI5VB9gMh?=
 =?us-ascii?Q?N2f33apZMSiUcR1jzNOmit2+dJ6jtXM0s3pWQDJRjzu89RpqMSJrOmlDqcf2?=
 =?us-ascii?Q?p10+An4fPHaNNcuFP/khwZtCdcckSU1aTzhPKYSps8/LddAFVzWjs7iOM6oU?=
 =?us-ascii?Q?U89S15jTzUMeeMS1obwcv2wso2cE1TPLvK34AdEnOAYl8d7sESSVf/6H1S0K?=
 =?us-ascii?Q?sjc28Sbp3GeIll+f+sM27XSnN513YC814ZD5t/5M2/CCMRftsu31i+4iK3BK?=
 =?us-ascii?Q?+KULHE1kC5GUxWhoXAdPHsYNF9W7eCCfn/tOodecKtKJEd3CLKwNgf2xPCGf?=
 =?us-ascii?Q?eUDWpTAYMw6DRDeQomu6X8pTeWUH2huhKIH+A3+jxU//pEtHbVjwzazAO1o/?=
 =?us-ascii?Q?cFQeoGjwdHCUgwHV95gwC4D4o1csQ2qOjibtnb6O7fV1PnnOHJG3GAg3EGrq?=
 =?us-ascii?Q?6cZY9eALwPCuKmLpiHxCCLiAM5wAKVfxsUtXbqeWjXLrWqZ9pyrS/i8XH94+?=
 =?us-ascii?Q?j2tSwlJUHnh4Qu7SDk0K6ylECeoI911LPdHIR0m9I9TarqFziVRgUX0kqsZm?=
 =?us-ascii?Q?dCl6TK/3eQj7hQm2yafGoX9UlLoybvd42PzXZ0PD+9aPTtT7N2gOJ60jWPm5?=
 =?us-ascii?Q?wce4d/D++Mp18p09pMflFiVMWHHf4VXAmPKj6qxnW91ez4t4nGT3HqxzlwbV?=
 =?us-ascii?Q?YFEIOEER4QXmE3d+W78l/0avQrOyHDCOy8CmjKqtVybdtjvECJyLKW4gwMBT?=
 =?us-ascii?Q?vBi4cUXc88WScsKSTgVOFam4M4o8tezzN0xbszPnT2q8mPEROXhMP/7nOECz?=
 =?us-ascii?Q?QJTulaS7oa+3yIV3qvOOv7MCmFbHLECZie3IfEZ8qiZAal/OLRp2pl8wBpmm?=
 =?us-ascii?Q?PYxIysmxPfMbd3ifuc0jkY3ibrwjZ33xyuw3+Ru61k5JcOnEFce4rYpZQeuh?=
 =?us-ascii?Q?5KTUUHRRWepe6JDcZMOStmjh/V4DbKYobi7StpCL8F2DcDhEEfNZacDa6hdy?=
 =?us-ascii?Q?K383RBuQHuNfZit6ZQayCBo7S+Zg5+bN8RTJeXgoRwXx0HWFTboBIAXcrl6Q?=
 =?us-ascii?Q?f8tC5jGHif2BboKqZvqj+E66JjrH1Lw6bYHMwl4HXB6qhDT0O1QD5uLV5y0+?=
 =?us-ascii?Q?mqwHZwx3R0kr6Q9YCmQV6KrzDOFoWD7H6ZAbRlxI1Ee4s5VzNnA5ZYPWuPzS?=
 =?us-ascii?Q?WmKhcMEJ2IlrK8eLNDhm5YUCMaAKLyaxUloRVoOfR0EEu6aKbU4SvigMuCkW?=
 =?us-ascii?Q?7WSOAARnKiLc+ZqIomNGjFph16csovYKrFfgzpCyQqBO+KcrWEub0AucRLIg?=
 =?us-ascii?Q?thGjLcwmkRWnzhOyLQSyPuVgTTgAb7cJ6f2+H6U3V4hfRPnOqTr1uzhd8NT1?=
 =?us-ascii?Q?H5V7chF5Wgvj3T6JUKtIYxMe91k6kVHnKF9vh4utDrbcaYg9uhYrjxJZLTTv?=
 =?us-ascii?Q?YYL2/z7pybV01TdMYCx0+ew=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D943EBEEBBB924F81F7DCF4B026F48A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pfXMrmK+yfU0WFu5fji7uOxyf/ER82IpgZObMGkNZv4T+vTY7f6S0B0K4Etg2eONVh+hNQQBkJsl9b0kYWEEttR85woFlU/XwuCnV9rFOKFFxbnPaZwqgh/HUGeh5badJ7sabd6MfKsHfJLdW2m4S9uCCrEKessOFlvfVmRPnYyuiBu9fqee8hGG2Ak/ZOWdLxlC0D3NIk1BBEYVtDHIMczTKqICADLdAN4qpsm520JxgIO2HlcYt7bsXSuvFWrByNsCRmfCy73wOXzqsvCZPJxZvkKw72XmlSeRONKC5lVlv+csO/qmGAPY2on6i5E4MuKf01xt3L9hWYvpQht3SgpbEm/XAR29luHRxKzEZjeYCg9wgMGaDPDX2F3vuBKvvcTFBUXsKhikkn0Odhzv4JSxHtULPOQxqIDJKkb0HPcLfIy/dRjh1yGj8xqg/D/eyl0mZZ+AfdPvjwSeWgTXRlI3jESkV7GEN+ya+Jpi0QetyNp8Z34Pc2EqpI0RhMJbtnqR5SMWUpQX9afWaNdhp6Ptr79aZq5SNSgG6GxM0AB73KLJ+eU5zBJJXWQTeXeUdkPNBFuYz0rM3RglMdr24xwP8QeHTw8zubWWSEr6lwnTAsssfgiN/yKEeraH3GnjqRS96viFGMU7l1RxIZ+t8/821yrMf1ex2LUDCnNREcPCiDvIWKQ2IMWkCVOfZZrb+xxeZZhXxyZFrJzuViWpAF+v31pPpigQbS9OQu43INoV+UH1kHt9tt0T9wpt8g5qSLOWlCmNJ5Bw1Fh5A2YAs6FeXAuULAg12RKHhDIz55nbb3haTJMAw0HbJUV4/ixIpin0viz+VvwgyekrndzJWA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a9daeb-66e4-4406-102a-08dbcac932b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 02:16:09.0089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJmZg9DY2xSS4hH1q+TCDtEcbv42tIo9xEmOkLTYX8tfNL1d9By+xxIkaCVV1lkOY/qoIf8XOxnnlyOKJ+f/6Z8RnCkrNNEOVi2mE9pPtvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7254
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 11, 2023 / 21:15, Shin'ichiro Kawasaki wrote:
[...]
> _nvme_requires() is called from _run_test() via requires(). This is befor=
e
> _call_test() which prepares TMPDIR. I think _setup_nvmet() could be the g=
ood
> place to set def_file_path. All nvme test cases call it in test(), except
> nvme/039.

I rethought my comment above. Now it does not look good to have the excepti=
on
for nvme/039. As another idea, I suggest to replace the global variable
def_file_path with a helper function so that the TMPDIR reference happens i=
n
test() or test_device() context. I posted this idea as a patch (the first p=
atch
in the two patches series). Comments on the patch will be welcome.=
