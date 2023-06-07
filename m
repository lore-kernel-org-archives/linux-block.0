Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07377C7EE23
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 08:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbjFGIFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbjFGIFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 04:05:00 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A488E
        for <linux-block@vger.kernel.org>; Wed,  7 Jun 2023 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686125099; x=1717661099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OmVM3cGZu0LuPmTEVo5xf6g+9SLrSUuQ0brKXuMx0xg=;
  b=EqxQM9G3r/TU1TJtAPJjG304gZVNw4LWQDkS5ZGgqN4T8Cp8nC5svy6c
   qpre+oIazSkQtnbb1xeQDWtp/JLVuaqPDLidmQMr2piGwYcqIBoAvnVJl
   xklGSUjXn03JD5PlGOUQpQaatxCzYqk3MERqX8VcTvcPiYficzx9DAtSm
   jgPbcjz09nssrM3YNOQ+MvzWndMTM+C9crituX55lR+UlOuNi39HWFobX
   XawQOk9dXkiTgeDbTNIY1iGVYnCBM1opdTwJOwekzMsg3B0zUyY9zBBzF
   A5MIBQ/obOmGb05bG96CP+oKWsd1p1RH75Jlfdbfs7mt99usUCfxMt+40
   g==;
X-IronPort-AV: E=Sophos;i="6.00,223,1681142400"; 
   d="scan'208";a="337523763"
Received: from mail-dm6nam04lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2023 16:04:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxXCBekl/i7Z/QaxWhgqwe3jQRLSL/60D0jjNyszWfp/GzYft7s+MYPN6EC+o0gUj8rN5ypX5TBzQgWF4lQLOOAFsGZGjm6BxFiNf1qNWpHVpHN/lJn/yFRurzfO8eJciKnMP66OJS5TujuMS+Kc1XuWzd2m2ChBVsPWEoCb8mMfkmeqZ/iXqZm+atHEcjWNqVbgXLC4spOidO2wrRDrvBvuB7E4eR8Lcfy2eN+R2M7FoOxfz0tARoQ1rxx9JGgVSZOUq0YqdNGCx3CCCHwJFqAo0UX2t2pXZvqv4Le7IN8qGjIo3i0hlFLnATt5ps9NxRA8veR1ccimOPRqNbivIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9fET8R4xD1Da2BNB5TJMsuxtVpbk5rIbpeB1PibqCk=;
 b=jI+fXHimSFzUSvEQJqNbgo1UANdTF+h+WvwzSdZkOPC1opcs3bbjx/6qoje5ylcT+IBJnNn77DtBAiADjX2l/+UpnUXiSWN9oNccd6gwXIQ3KjnMW/Zjr13t9lD0sQeVcLZ3VJhMSx1Q3BfQuvnPmfuL5EmlzFWbePebM8nLTzCUQ8NPrqR6DrHZl3yREfH6SR8BfE+PUEznphEMvQQuHBUVOotnLPXj+LzMK35As+sQstCmpWFgMDrurDIg60QMEOwCG6KMOUUuTDOCYo8eMD9i8aBGpPfp9jINItFMwZXlcSmryUi39fyTfF6VyGWCv4H6o3n1TpF2j9x8agsezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9fET8R4xD1Da2BNB5TJMsuxtVpbk5rIbpeB1PibqCk=;
 b=kLFhhf4Uet2srr8UAUsI/FDUeD9tbzoxD7DaWkqD5aAmXDpgIH/rF+3HHth9uWPB3WcaEp+wlY9hmhfYVI/6jcSTkPHLY8CCYiOcU0hQYJHzaPZU8zTW2jtUjiHgw6Jj3T79DqEHf7VblSfPeqIBGCn/u6s+YinvsmSnxnCEAXU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB8201.namprd04.prod.outlook.com (2603:10b6:208:348::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:04:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%3]) with mapi id 15.20.6455.028; Wed, 7 Jun 2023
 08:04:55 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Topic: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Index: AQHZk1w9J1fvV9jcWESv88AeU5E84q9z3PqAgAkERoCAAEOxAIAAOVAAgAFGoACAABabAIAASzQA
Date:   Wed, 7 Jun 2023 08:04:55 +0000
Message-ID: <shqr7uwow6jwzoroy7oxgmpoklm3onap7u4rdstjo5scwrekxx@lnizg3awgv3w>
References: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
 <446c46d8-fbc7-ecd2-8efa-1c9497e16851@grimberg.me>
 <eadb2514-f06d-7cb2-2cdb-04a6226edac8@nvidia.com>
 <18855542-e07b-70c0-ccd9-2fa0f0d2df86@grimberg.me>
 <zcko3ff67h3tilz6smfqhy6cxwihzzl74kdap52aoo3pm6an6v@4fxn2ymekely>
 <bfcfb409-e124-0a74-4c22-bdfd44f10f10@nvidia.com>
In-Reply-To: <bfcfb409-e124-0a74-4c22-bdfd44f10f10@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB8201:EE_
x-ms-office365-filtering-correlation-id: 27be178e-8e7f-4baa-eba3-08db672de19f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbLLXJMwABsXF1SBeQMEgL9jqT65anEYHWNcr5e7lxrlFQtVIjiv0PnHTvglX4RvAqlCl6IpUgqtoZiQk8pD7VwSpocD+xDpQhmsUuM0eNZ371Mh1OcRrSnXSvYP0DWq19I8Nb4PMsD/Xr+EyY5IyG7LP+d0dXO1r1YOuH1x+oxqH1m8CQHmzoMv0TZBHMOUFgMHdBXdtT9DMpP9Yo763IPyU32tU/MPncR2z6r6o0zMLdjMBoeHpK1VPY6OPPyDJHRgqjEU5R646hvexkIeOzKoJvcOLjEZs76lRa5ImWg+3azBa8ePXyOFgrY4iNFOaOlnrVivSOHQB0JI3s4vLUDGelDRTTirU+zXP4ll/mEjUimxPEoATA9R12+flIJ7XQBRuTqNCgVg5or+l2QKEdsXyiSBzHlwtJsmXVPFibPgg02EWKmA2zRT+liqPTaTLaC1DxzDYWKRb2Dfi7onDJu1KjbqDkNm5lZRrW3rtLGHachhObTVgJS5AcV/P1tz1iuljsLLkoYuMzili1uTeKErlbgaJOr/pVznyZWE3r15ISr0KIWrZRERQVTIZUUe8Q8TOATFkRxFOmBywUwu0480FApljDDS3+SyIuGFpxPBAj+a4fPumQ0Q66byOfO9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(54906003)(71200400001)(478600001)(6916009)(66556008)(44832011)(8936002)(8676002)(2906002)(33716001)(5660300002)(38070700005)(86362001)(4326008)(64756008)(122000001)(66446008)(76116006)(91956017)(66476007)(66946007)(316002)(82960400001)(38100700002)(6506007)(41300700001)(53546011)(6512007)(9686003)(26005)(83380400001)(186003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?31l6Hf5nO3PhE65gGCADrR7xFNWoTH4RbieMUHMZaFkPCK8wYEs5WYgHuEuf?=
 =?us-ascii?Q?x3HeaxRb3jyiQsgl9IqnvOPfdKZzviWYHgsx18OVy0DR1FDwcBB9wBzXSi4h?=
 =?us-ascii?Q?lfFM2o8IvNc9BPT+p+OYQnF1aubwplApc3VYvDnzR8iRS1O/FlgN0eR7cNjj?=
 =?us-ascii?Q?5JcUz7QDQXHFWqIEa2ea82mcy2UQnKURzvvoGLHMnsCnBPn2mAMMA+ocI1W/?=
 =?us-ascii?Q?Swqcf5ti6iY2jPg6XgY0HM5E/SzPbOc/OmXZNOliq4tUakgFrOmwFfcnczfg?=
 =?us-ascii?Q?ZOXhjL5wpFKBbfCjI709hhgLF+Oz5ktrDxzxgI46vpRpscQgUrbDxyaqxLtd?=
 =?us-ascii?Q?8K36PeM+1aycCzktZ5+d7JWV3zqcpUUJmg9yRhv/h2TC39HoHHpCWqMwSLSW?=
 =?us-ascii?Q?7Ki9zIWAvTe6Lu7hACX6YkVsMa45Si26e+dMcM+N4mFLHHCnajzY+4sIF2bA?=
 =?us-ascii?Q?EL3m926C23oYFXaOZLSa458DjAMW8zyBf9FDyyYYO1W9AVT3tQhdhHrGa4Op?=
 =?us-ascii?Q?aCW/8Iww4XSNkajyDjcqK/maGtggqE9unNmPcNb/Opij0nvL+RyLTRCgZZgT?=
 =?us-ascii?Q?V+rJKHVwHNeBOVKR4WzBUGJZ3fzXj1/DNGOfEZAdLqg2gm0iG4gjl2sctjcX?=
 =?us-ascii?Q?RWY5kwDte/Pf8/gcr/X7HwGIUU2Y7UpIZi2Ab1aSan/9IrIuh86eXOKp/ajE?=
 =?us-ascii?Q?0gLyRsxKUluzJGmeF1jj8cDrWet2ojji55OhAsHffVNU9ekbCutb8wkf5O8h?=
 =?us-ascii?Q?i6+bZYmuQNWdYmRXyyT37L96RYw4a6LdwI2s1tcoAuVXYSfmEzZbespN8HXf?=
 =?us-ascii?Q?5KihQWIe9uyZZ40aJAApenX3HofFJcQQ53VyEn3T4TECGuq5lJNM895sJiRT?=
 =?us-ascii?Q?//7woVQYjjKxmUM2MimQDbHrcHWhZ4SBrG83flgGEHffbwG5qmBLjRnSSXrr?=
 =?us-ascii?Q?lgeeboz1sPIM71yGaIBma85If04tOb+hTDcaVwYb1LR3tZTxxl7halGwyt08?=
 =?us-ascii?Q?yPaLccEMb8K9Ss/BWFEmi3DY0hNezijhp1mHiSmgDWCSmgmj7+72xwkf1ccQ?=
 =?us-ascii?Q?yjYEQOGyTaCIo8Xw2Yq3bdpxCtC0pORZIeD5vCYJtXlwfVynj8RlvqYBQxAT?=
 =?us-ascii?Q?cAKufw4lu76MHgvUYE3KquZe0Pzu48Vg9ffr9vuOSHeQruxY0hX2VzbntKGo?=
 =?us-ascii?Q?89EHqE014Bj//DuzifBeZVz17OAy+i8flVNkqP9gik/7XHfts1Pslj4A9pml?=
 =?us-ascii?Q?G1Kc91CeNCOgej9SKUerWmqKq4VxosfBH/Uvtep1iSRh5IrsFq11OOlqFCgr?=
 =?us-ascii?Q?fgr8nQqv62H4SD7G42ykAR/t/flnDwpuYNC6xsjcrscbI5EJ5jL0O/ZngyTd?=
 =?us-ascii?Q?YDx3D8IwsFDdaCNoQKkI6gPMvD/G9iBlWCADagPMxkyP8Heu92VgQ4rbIciI?=
 =?us-ascii?Q?jB5F54/3dII7lKswPe5Pl58xR5oU7nf6BBzu61mhusCLhzKCZofZ664E8ZML?=
 =?us-ascii?Q?FzGeTTAZJmA3ggjYdzdWWHTWjKOSb3FE5ZuNwFggw8qjdJKQPx/VWnPMZVZz?=
 =?us-ascii?Q?sqcXa9EUbPFeM5cgiRs2gbirMGrW2tCrtozyCS3SdSr9v4v/rZVJ8zIdCpYk?=
 =?us-ascii?Q?xvTw2ATAa+GG53lxF2pG5mw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8E93CBB13FC574CB871EB7E900F789D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1jFmurR/uxqDpkPLiQjV1qBKDML7v0N78+36wnAZpqPruDH9xwNAfqAirMcB2Taf1FC67y8HG2QERyUkn7Cnm5NQhGPcqsrBKOLkflQ8onN3V+k12TNqvKJiFQNU2Ny0xdQH/ss4nHEZbLN+gi/iah5aU+ESLVUbTAquWFpcE1q/643F7V5wfgmMiLg3cE5fLetJrViJf/5JR8+VLI7kezqwgBt3JjghjLgcCW2nJT9WtxjT6Cqxy6NQm5khzNOacT/cUiiKpQUwAcB7goYTNofXJpsIk5XrsYHl27OGuHVVLwd7wng8xD6HEtKibGS5W/wMXQbVje+3irM2pex5JssiEMd1393iJNCTlUN4nrpF9dW8rnLGITUkl/wLxGfCGg8pFcLSHRBdxNTNNx7wiC3vufMIF0rO+hu+ym9FlcMIX2DlfLlRdreAJ8bxlIEVL7C/pNOXnmheod+67OCso0Jmb/X4vKvNuFWoYO9ODv6jOB+YW6HSteYjsCBb3eIa8QTiZLmsiOWfxNkGhUF3zh6bYjc9KInsVV8vyEYlpryLCTvv9xgPjle9+7qkSV9kITSPF/g8qnghbdflOFJ9+OrvqPsvSH5/7+4YiPkv6L5FJCVKfMQ52C+yBvZ0oKacpHkq/tdBYRm4u5wFtyyginVAZL19QmrCIATB6KCHlRLcq9CuT0X2o2j24C40Rtpubje44wCw76wPyDLxg995Yt/xikNgVPrDdOohbCV8XuLv4Xx35HQBR/Rfr6aaurfhlmaZx3XB5kXZPT6mc6a5nEAiOozxNcbw4qzfGCQN2on2PmuU9SZHNsUcO2lbaQwj1NvSfC38WynEU47TCyCxClu+utk/sUybzfLxfacV1VV7Rm48Um+ZL0h7bxvnYEqESLnMvxg3ATS7wxE9m/9E+ot5ypn/Skx9ciDQtjd4i7U=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27be178e-8e7f-4baa-eba3-08db672de19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 08:04:55.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HR7QzwMqtCD292owdghc83abjvSkaA4CdXYKgTFEyVsfUZse7B4wNrBW2vG+kpTF6v0IJ+YoaJt/Zr8PQPev/ukFznpP+Ur5PVioXpKchSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8201
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 07, 2023 / 03:35, Chaitanya Kulkarni wrote:
> On 6/6/2023 7:14 PM, Shinichiro Kawasaki wrote:
> > On Jun 06, 2023 / 09:45, Sagi Grimberg wrote:
> >>
> >>>>> On May 31, 2023 / 09:07, Yang Xu wrote:
> >>>>>> Since commit 328943e3 ("Update tests for discovery log page change=
s"),
> >>>>>> blktests also include the discovery subsystem itself. But it
> >>>>>> will lead these cases fails on older nvme-cli system.
> >>>>>
> >>>>> Thanks for this report. What is the nvme-cli version with the issue=
?
> >>>>>
> >>>>>>
> >>>>>> To avoid this, like nvme/002, use _check_genctr to check instead o=
f
> >>>>>> comparing many discovery Log Entry output.
> >>>>>>
> >>>>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> >>>>>
> >>>>> The change looks fine to me, but I'd wait for comments by nvme
> >>>>> developers.
> >>>>
> >>>> I'm ok with this change, but IIRC Chaitanya wanted that we keep chec=
king
> >>>> the full log-page output...
> >>>
> >>> the original testcase was designed to validate the log page internals
> >>> and  that correctness cannot be established without looking into the =
log
> >>> page.
> >=20
> > I think nvme/016 and 017 still have value even without the log-page out=
put
> > checks. They exercise namespace creations and deletions which other tes=
t
> > cases don't.
> >=20
> >>>
> >>> but given that how much churn this is generating eveytime something
> >>> changes in nvme-cli or in kernel implementation I'm really wondering =
is
> >>> that worth everyone's time ?
> >>>
> >>> Sagi/Shinichiro any thoughts ?
> >>
> >> Also back then I thought it'd create churn because the log page output
> >> is not an interface.
> >=20
> > So, we should drop the log page output check, and it means that Yang's =
patch is
> > the choice.
> >=20
> > Chaitanya, is it ok for you?
>=20
> I think it is reasonable to drop this check,

Okay, I have applied Yang's patch (Thanks Yang!). And I also added a follow=
-up
commit to remove the helper fucntion _filter_discovery, which is no longer =
used.

> also it will be great if
> can we can drop any other such checks in the nvme test category to save
> everyone's time.

Another commit 93ae757d4ca2("nvme/{002,030}: Move discovery generation coun=
ter
code to rc") removed the check from nvme/002. So, there is no check for
Discovery Log Page outputs in the nvme group at this moment. As far as I se=
e,
there seems no other Log Page checks.
