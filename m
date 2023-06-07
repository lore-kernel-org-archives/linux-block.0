Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE82C7EE29
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 02:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbjFGCPB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jun 2023 22:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbjFGCPA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2023 22:15:00 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02328D3
        for <linux-block@vger.kernel.org>; Tue,  6 Jun 2023 19:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686104098; x=1717640098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9AdQSZ/kIkRyJIKZZWWrNYsguM/iwGeOv0IvcUwDa78=;
  b=EkU8rF2HNk7rZVQrB9RMwhc0Q54wKVD3n2IOo1mC0amO0HeGCyuFyJY9
   M+XdTLF1jgqwxdIENcj5TWoAlhC4mwvkZcNjQxlUkrTXhg+9KdTScvyW3
   DewtZUKOtqoCFgdXTwOjqIbzh94hmFbRkcv+1mmPs2aAn9za4BqhJksrG
   3QISianaXvN/Yu1TNvLX5t3MfelDsA8KxNwATSNhAHy2fSiUoirdSwS8k
   4LaoIMwxyo86wFOFCdRDMmpECoyimq1bjY8ZTSNO1eLcNR7c39PKAMlhY
   BJVxlszPhTCWICUAQChgG51i3fjLgp4aRS1xzM6qmyEUhYY8ypONzG+pt
   w==;
X-IronPort-AV: E=Sophos;i="6.00,222,1681142400"; 
   d="scan'208";a="231073696"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2023 10:14:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcXYaB12tTlXgWWfJGaKmwb/Hia597S14U4izvyWx5pA1vI0mbv8bichUKdeJNxrWsv5/tg9WLexA6aDiDS115emfIjFpQ6uIuyAkY/+bpu9ze3dVlpu9fx97oiVcE5A6l2+4NjvZYLWRrI8mH5fb9wj/rz4utMANRj6XNARq9N+D1sdGp5GX7MCLxn9P11singqVR+f6CL41CR3mdY8K8CKQT9VqAwk7ouPOIiYjuajfA4b0a9V3RBDF/byx7hz3Nn2MaTb2sfZ3DVdagqH8HY6ecUOorwn03GDeag6+uUgZo9jmadHnQmzWyeYgmwAqsHdkpIhGp4u69KViDg+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM0JERZO3ES07e+gv0Mvnt4cwvWGgX1UGMDBkhWZSP4=;
 b=OesTCO5aNSxcNCMD1dlBCbavlKX6buQDrINDvdlefmupuE8bSqk0ZMR4xkiZHe9n1Fp3zdo7XTl5pPJgCwIaIMIUA3IsWsVqqnOpM+LOVmPijmHDp4Lg6X+7SaMOJrokrY212cw+/G9kUqAPbXRKvBkZRZe+dxCaiI+nxKqFXQZwFLvMxwlTNayyBEIHUSqCZGWWGbiFxSrYG11njBzOeQHd82Juo1br8YGkMalmx3MlUlvhNwUCiDCigazKBZ8625RolKU+dL3Wq06qkfBDZgGBzWrHsmTILV6WLxGGaxYcgUbTI9my7aKOUOS37sTWo9IZvkpwURKJ5MFQfOMJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM0JERZO3ES07e+gv0Mvnt4cwvWGgX1UGMDBkhWZSP4=;
 b=zJjacl0ESFs4Dmg5ONK3d7yQg/KSpDlFMQz8ZWsmYT4bjJYpvLrgFgswxZ5zqT7Md+XJr+71HURlgD6y1gWdlse/j7vgi04mcLKuZzzYPhX9ASAlRvYQ9AE9mLaE8nirkLYyonOA3FpjXzIfai4zRmPFhLPiB/jjx82fitVovb4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB8155.namprd04.prod.outlook.com (2603:10b6:208:34a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 02:14:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%3]) with mapi id 15.20.6455.028; Wed, 7 Jun 2023
 02:14:55 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Topic: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Index: AQHZk1w9J1fvV9jcWESv88AeU5E84q9z3PqAgAkERoCAAEOxAIAAOVAAgAFGoAA=
Date:   Wed, 7 Jun 2023 02:14:55 +0000
Message-ID: <zcko3ff67h3tilz6smfqhy6cxwihzzl74kdap52aoo3pm6an6v@4fxn2ymekely>
References: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
 <446c46d8-fbc7-ecd2-8efa-1c9497e16851@grimberg.me>
 <eadb2514-f06d-7cb2-2cdb-04a6226edac8@nvidia.com>
 <18855542-e07b-70c0-ccd9-2fa0f0d2df86@grimberg.me>
In-Reply-To: <18855542-e07b-70c0-ccd9-2fa0f0d2df86@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB8155:EE_
x-ms-office365-filtering-correlation-id: e80e9490-3f91-4909-e9d4-08db66fcfc2a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JqP0wCYvLHex0qSdxA97URlDiIxs+q42SZMKsM++yUkbFRGZXtutmfIsOFVoewK8T2BWv+Vo5m3vFlsQtxZB3gulAEgh779dvP56gOqDNudtBBHyEt6snaPktcmvjAfPBSk+tZvuAp3polqniUUJJipYmt5JPughn/na3A58Fgi4hOB+RjSvpa2u5d8/z/DbNB9mhCxYhdhC5IU2d3r+8EIGR/zd+FTftelUL4bJjbDh5T0UpnDL8e5mkDqeN/SnpgK+gAqg/cUsHka4Z2AFyWD3bz0d5O18Jpj7P7B4n6A6C20s3TCiwzMXJntw6MQf1xvCwMY5ivmaqfHV49odAZ1ta7oJOHEwRfQC1VzmQb2KKg1N1vhNxMEsaHatbf+RouML1lSISc3piIr+nykDWSzNm3qVTPnGzFNP5Jley9BFgATRbtABIECvHuJDv+RBQ38ytgtUM1YqnUCK+RVs+/BLSqvwZsj1tsIDer3O5ZZvrMB9hSTkb7Bx12vNNs/X6iyhaPIj0nEP2W+6VBPYcXLneJGRMsl8uxPw7NoRviSX9yXEuxGsyeCGS5CmjT2KC37wsku2YFhriIVhu4dPo+wfzKNVUyWN2KiMJNcQGMA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(86362001)(83380400001)(478600001)(44832011)(54906003)(82960400001)(5660300002)(8936002)(8676002)(316002)(122000001)(38070700005)(66446008)(66946007)(66476007)(76116006)(66556008)(91956017)(4326008)(38100700002)(6916009)(41300700001)(64756008)(6486002)(71200400001)(2906002)(6506007)(6512007)(26005)(9686003)(33716001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zSwDqoJ6V7t/a4eVl1nyqDtQZuW6zgmXC+BsMNBFeoELLBGD+p03aD+bwXxc?=
 =?us-ascii?Q?B2bGkzRccOcFyPpLpPm21vVoExiJ5vigorGPLpMbxNABWWtWeUS8BQoBbwGd?=
 =?us-ascii?Q?jB+XwU2If5aUbrz/pgvRD7qOFBdn0WBhdf70hPMki21h07gjUttAoPZDrK7R?=
 =?us-ascii?Q?zS2iQmm1pbCo3vMFWQqawBcHL+23v8box5sPXR9H5eQGMGzRkd+HCxot9nji?=
 =?us-ascii?Q?UDD3Ug4U3dLB1Q/XtumfGsYWJ1yKWk9ulVm1A/3Xy8yUPojdG6W77Jh0gmuE?=
 =?us-ascii?Q?I4vKHbi+uz/xqLzNXSGOLzQyRtL86kt7J6Ko0raAOFjOr9aAFF8BdLdTTwwz?=
 =?us-ascii?Q?slXKrTyU+8dFCm9num3Dd4xsjT+na+Sq79BVQFlEAsc4M/bd3Z/7K/0LBHYV?=
 =?us-ascii?Q?y6phO42CMyuuhsxdWjFpSULcRdNm/0EzT+sVW3qGvISW3yqyosRawgE6JVyy?=
 =?us-ascii?Q?1SAi8oGJDLmVB8HAV2TrolbL3D+cvFcW4KkQZwA9NQVKC75A7fPjXhANygTu?=
 =?us-ascii?Q?6StKZ0zCBNJOGzdLPIehgOCQm/+lWynClCuOroY8J5IC4wuge/MVvrSnyxeQ?=
 =?us-ascii?Q?szz5AW+GQn9K2UjZndyK6gNzYxOSMxbFELIuq1R0+CUXaWRPZpcrDvakf1ir?=
 =?us-ascii?Q?vzD6MN1jiEh7Kb3lj7o6+NdTU88BfW076KjXSslUqnL5bF5/qlLFwdW+C25Z?=
 =?us-ascii?Q?x9hgHbV1EUXCyR0sIcP3roHw8zv4KgyN1U8gkohuGR5Jd3dyp2jmnICF66kT?=
 =?us-ascii?Q?a3tQ8VZX/WBDJ3BP+HfIikB8pn+P2VE0Hdf+Ln4xlVRm/Hdeoeq7q3mKQZyA?=
 =?us-ascii?Q?ABrZ8e1l+fl39+rWrKgs24lEz2iQh7JceR98vLHEmvt+Gp+ta5RHylsMH7ls?=
 =?us-ascii?Q?rdTg0yJqiToydXyo4vmT/ou/XU1z80CoAXm/qzYC9fgmKQ+WJT66UYo6Cm4x?=
 =?us-ascii?Q?dyDjtgsEBKA2avJAbN7z+e1unhDUzP+E1DaAvlYtaixLl+W4IRsROEaN2e51?=
 =?us-ascii?Q?7u6/gf7Y6/b1Sei1LixgCTq+QQHqvdTDJDdbxLm/Q8rEpsCdD2tZeOVF65i8?=
 =?us-ascii?Q?UO8zzNczXqhrUGz5b3sdFf/dV1SZGqOT8Oo69Amm43jJP3fxVMAE8PU5t1O7?=
 =?us-ascii?Q?u4uaHadW6mpJZX0JAqqPxiGMpje6kh12pC8sj5O+Spd7dB7AJI9hDxfplLv7?=
 =?us-ascii?Q?Zprp81jbqVus369Bj5TwzGVBcAu8VwofpLJ2/1oSfLddgRbmJq4jI9YfF8w6?=
 =?us-ascii?Q?2aFv4gvSjewNlXYNDjmJCzVPILstAOut1NN/SOFeXXzw985DMwuHVNnO8lVV?=
 =?us-ascii?Q?bI/3M9nIhAh0IkUt/h1RaguNSwrRWxq+cluaLQYyz7k/cjyy6H151+Bh5+0E?=
 =?us-ascii?Q?RMWC1M2nzjJz8PT6yx04SkBLLo3SM3GJihsSS2znLN+4TWsT8H+b+d6E8N53?=
 =?us-ascii?Q?cBHnW+ZK9gZa69zamwFOTQ4HzolTQlZQU4CHQp5V7MHR2yPh5vKPkmGic80D?=
 =?us-ascii?Q?ua9BLCTMuKGS/XLI2BqtNqENpl5foFpDuTu2i8A3GKM1JpJ12oNn0YVIH45Z?=
 =?us-ascii?Q?84f1ff/DZ24UYKcQ1oq96ZYHwv09FJW1MR2gtjoh3PdtWX1SBE//FFt/q9CT?=
 =?us-ascii?Q?pc95pK1QScjSuHZGrylIQQ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38289B5CE886D342865409E3778C21AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jCctYoPx3acKMPRFYl0+2wDD+UqOrIa4QTMGOUQW8Ab4UXkltptu4aNwxTrxi4v8LRRr9T5GA/GAlEMOk587jCUWQJ39zVmNdaaCsK0V5rPUDR8aduIicpysMychAlY792mvm/8QFHbncgtMiSAvy98nhcVgiA1cexhTTznAj6kTUeO0dsQ429B+eCpt1Vh9GS8gT9iL4YOSS641taCHgXIWgB0yrSEky7iY56X9JtS6csNB7vga1tHkHn3vJUlpjpN0rOJGi5l1iNtrc+4LVPaWKL2qnRWLmZAaix0TGZU1+rav4bor0DpF6MgyZPqOA/VlGFcI7gEAMKrQTLzF0VxNnRuMuIv0n8hkusu+DjosZol8EsMRh5HJE/ZDfqkZDPv4WrB0WuMJ7d2swX621wvhSbJG2syb6oPng4Pesr2zwSphikjJhesoWa6JI+JnBRBHIcaqgEl6QCc4hChXngoXS+MaAgnDTyNMD6Q4qeQ/Go/6SROHoWmnzEkc+qNXZ50In79cp42PrxbU6fGYJkU51oNN3/udnWXCagd+hWhVDjVupK4j5XAqJQd4CNEx198IZCwP6nCO0XCixauB9rRbNPo2HB4DRLNR4wkKDqo46Do2khN9ZKye+O7dLYzCL6ugd6uNc/TMvGGEHXtHRf5rQdaQzXIj9tAXSfCugKhECk0jrJUGRBAb8ijTRCSZx6YRelMqCJfnH4B8Yaj5xvqjExSZRdRkPJlInOSmbS1GtqBJWG3wINxzEtXdlp29y37Gr/cnwK6AkjhAddrE5nmd58Lb+bwiPUlnS48OCq2CEIGmFfsmG9HLp5+9j5XHx4SbtSN4UrwIG0F7lHYcc8WCf2a21YN5ihwwynvdoKXxNEaEFOBICAtxTbfYPKedP3By3xIRt3lTVpSDaL3RTbQegN7F/8FPJvNi/FWujYg=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80e9490-3f91-4909-e9d4-08db66fcfc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 02:14:55.1502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6DxoYen2OoeZiHrGROwWq5QNQEMmbFZieYiJplBO2Ej76uOb8JAt8lm2eZtU/YFqmUrwi6wbCi8qCHZMGw1AjVwHIQZlBsqqZP/upcCM1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8155
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 06, 2023 / 09:45, Sagi Grimberg wrote:
>=20
> > > > On May 31, 2023 / 09:07, Yang Xu wrote:
> > > > > Since commit 328943e3 ("Update tests for discovery log page chang=
es"),
> > > > > blktests also include the discovery subsystem itself. But it
> > > > > will lead these cases fails on older nvme-cli system.
> > > >=20
> > > > Thanks for this report. What is the nvme-cli version with the issue=
?
> > > >=20
> > > > >=20
> > > > > To avoid this, like nvme/002, use _check_genctr to check instead =
of
> > > > > comparing many discovery Log Entry output.
> > > > >=20
> > > > > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > > >=20
> > > > The change looks fine to me, but I'd wait for comments by nvme
> > > > developers.
> > >=20
> > > I'm ok with this change, but IIRC Chaitanya wanted that we keep check=
ing
> > > the full log-page output...
> >=20
> > the original testcase was designed to validate the log page internals
> > and  that correctness cannot be established without looking into the lo=
g
> > page.

I think nvme/016 and 017 still have value even without the log-page output
checks. They exercise namespace creations and deletions which other test
cases don't.

> >=20
> > but given that how much churn this is generating eveytime something
> > changes in nvme-cli or in kernel implementation I'm really wondering is
> > that worth everyone's time ?
> >=20
> > Sagi/Shinichiro any thoughts ?
>=20
> Also back then I thought it'd create churn because the log page output
> is not an interface.

So, we should drop the log page output check, and it means that Yang's patc=
h is
the choice.

Chaitanya, is it ok for you?=
