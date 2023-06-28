Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9FFEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 08:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjF1I1d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:27:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5505 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjF1IZa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 04:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687940731; x=1719476731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3792IPmVS4sbl/G41hqW2YFLHTqwJHjS8xt/SUGzvKU=;
  b=FnsCCY5kWLhFG8lNzYsdEyp+kFcpUpeA715C9wp9S94qfghiy/mIlzFl
   c0RklRAkR2xWOcjOT+Tcqf7ZtFfG+rAsCECeq67zCqtyq9jHQsBXWWhuJ
   3DqnJTsYGmioyRYQLp3VC6Ez8UTWu3RNb3m/InVq6OHPVICbzJPnGqWXt
   HmmISjm/IL5mgJv2rWaPB19uC3IXeIKuzDcNbKZ2VBoUHvGSnHmY6Ipki
   dBucaE611dne95q1iWFkCxG/Aqg+WZuux5F4Wm06vkWuPGYlClMz0Fjso
   ofiIhDjw6eNYCayLDksHRaCyElhy1MGQKdDOQhMp0n8tQzgm12gXLASlV
   A==;
X-IronPort-AV: E=Sophos;i="6.01,165,1684771200"; 
   d="scan'208";a="236426016"
Received: from mail-dm6nam04lp2046.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.46])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2023 16:25:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be7fQ6jrtyZ/kZUQELseTVpwUkHveJpDdBdg/ojjWYHB25Gt9rOMKLA/yf2360/QUc8WOUX1gMWXDCWAmCcXWuD2jpKmxsCV/qj2pGsQ8DO1c4119H5cd9+KCcZdB66baOM/7KprZmRY/6USgRJT+o/DHxRpFJlZKo+yUI6wTqhJJLxDove62WKAkW9298ac/lz28H665NxsvvURtG9eIS8Y4wr0G+sfBG4y46EyA+pKf66RdOZ4O/A0ZPNnYTmnvd6T4poKfT1+IdTpRM9vIzmU66qoDDNh82xdXvUchPYZguhFlFI5ptio6L2hUOH9FktfuT49p5sSTxBMLladuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESm6Fcguyshb+5bOo++Yv79YzByfqgf/Pbe8NeBHCB8=;
 b=Gl2787d1UlrwrbY55T+PMhUYqUzU8Qsk4uru1CRg+rIBHujV+MchKlEajyA1bw/MuNjpHodXEP0N7NL36W8YpLyfAYjpbMQIKS1Vpv4GX8BwyO7QrmqO4EgXZ3AOuvwA1C3OE+A2tvWb4NC04Bl+bWOQJnRJW73tHwXwDLG/9xTnzgL0M0VsGLL4Sd2VpTN0t5CL1k0lrpzBYP2au4FBh64a7jKjNx3O1qE2WMFLutV/3U7CIulPvVTfbSIeBkKQIhede9Ldm6kdK5sO3GXrRzT1MKYJFIa/1D2EEfyUopPWzveTXI4TsZNQNDwJhsmU0yWIVsAEdzpioET827vaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESm6Fcguyshb+5bOo++Yv79YzByfqgf/Pbe8NeBHCB8=;
 b=APc+IyPfLWRuw70ksVKHf+FkSohF1jEBCYLP2KuTp5LjzmMkcDtsS1rCqWTp5bJ3RbRnzJB99+c9oPfvqw6MOOiXQcmpEl8uMf2hESuR8/3bVqTlSuGbltKc5NHyHfUP3cgskwzwf/SosEa7gsx1Fizq1MCz2PIzyZqF5FfSRkI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8439.namprd04.prod.outlook.com (2603:10b6:a03:3de::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Wed, 28 Jun 2023 08:25:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 08:25:24 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Thread-Topic: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Thread-Index: AQHZqZoWAREYOa2JLUG7L6op2T/M7A==
Date:   Wed, 28 Jun 2023 08:25:24 +0000
Message-ID: <lfwwdbrtexufmsjbrw5j36jay2m56kdnuzwcrmcwnickzmgb4i@b5d32kl3oaps>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
In-Reply-To: <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8439:EE_
x-ms-office365-filtering-correlation-id: 6197e504-5cc3-4aec-6a63-08db77b138a4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvGpOa+8kcIBX/0tOZ3odFUnz1eNbCeNeZnyiEmmB5wHWgI/1ExAUgl3ahBiEKnvO202P2MbqBtqei60ULYNW289jN418OzLk6/v7ifuBNvPUvZGtErc+KBr95mjpG+mthD7pohB0AwGBqRlzC1gee/DDQR5huyp0W0CFhOcKiZVo13FXna3cIILgrpYpwc7uXzirAucqb3oYVMKMQ4rjn75QqC4bLB7Gn+1zpDUWilBlf7hIYRfxNnjIadSjWRPtNKJvriseTKm2NXDJ9+RazbsA8sOT4pduNWn6Bv32p12ysmgjLWdE9lWJQ3mDnj7+cc0+Ib+S0/54TqxLtxiDWm0YYaoW+PKh2zSv63idOupt/Lt4+xaRjX4pYoUjZSsUcqKFVRsWinynDjTK9NundiYs9gB07jo85y5hW9BO4jd/q36wsLAVTxz6pEJw5bom5Fag3Wrtb+rgoWDrlIKErg7HzdU9M10KkOwwZ3fA8SRUAV9d11PZHuKgiHzqMDSkTYt5T36JgyOMKPXtMepOBTnQWPZK4gF/3Mg0cWwjtZ0cFMGDfwoesdpG8teA8i5Ss6Ub4P+Hzb7hC2PJN24CnR1tyTteHou1D7Vo5/Ggy5VTe1ei/JyQy3Xud9tM6Wc4Wto+sl0aC+CACBKON/rxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(8676002)(41300700001)(66446008)(64756008)(66476007)(66556008)(4326008)(66946007)(76116006)(8936002)(91956017)(316002)(6506007)(6512007)(33716001)(6916009)(26005)(186003)(9686003)(54906003)(478600001)(6486002)(71200400001)(5660300002)(2906002)(44832011)(38070700005)(38100700002)(122000001)(82960400001)(86362001)(83380400001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?djufASDYhjNBtDWTOYP3DQe1KbI8XCieBopB20HjBNdIZqjRenHpbk4yOyDt?=
 =?us-ascii?Q?eIjDYft5KkcS5GdTDYnQu24PLaPdPqI2sdtxJ0iJzz3dRG7huaDDlbfwtq7x?=
 =?us-ascii?Q?GluNf9dgKzG9l5tIYJtIv4LEVVqY6PVMqlF/zzX/DH0SSC5R29dfyLh5x/y5?=
 =?us-ascii?Q?J7Pecz5h/UilpIxrtc+hnysTLLNNpGVythWAA/zHV1DgS78zlsF0s6uDUdvc?=
 =?us-ascii?Q?KBJ2W4K4HRz7s/7tPu02w7uYqn+7j3ld2DSJ+vXXbiObvL4QuChvOZyBThpd?=
 =?us-ascii?Q?r6NkIuuzSSxyl2Kgrbsza3Ti2/kR8houWlfLWBluy/q2bMhOdQ5GMW8DXfs/?=
 =?us-ascii?Q?atR6K1j424MVFbRYbG2NhHuwezBy61PMq6G1dkO+edRHYV9Hlir7ZpfRLN9h?=
 =?us-ascii?Q?nGlbQBycD6BjVX9VJrAFeoeGpaKRMlnNZ8+poVlAlBDVQR2+RAedcglo1Vwn?=
 =?us-ascii?Q?ZI6W0EIW5B5gpr/l/Zq1kriLuveQffB19Xg5q7XMr5SmYsDahevfEXXVHv8o?=
 =?us-ascii?Q?59pkba9nJn88BW31qqdPc86fO7V2cxQFDa8LM/+xQjtkw7y3vrfG/m+yFReX?=
 =?us-ascii?Q?cB1zIOBiFr9vJN2TyGuidAiWdflVxsy8MkOwbye5hK054BRpD6R/pEHDgmaz?=
 =?us-ascii?Q?o0Cl0hXstNLfsHW1jMZrV5Ru0qlIEo+xlP9Kth2OfOur2PRe0GuqSv/pbjRx?=
 =?us-ascii?Q?yhiMo1tR/yvCinTter0xmjVwvCSsKFf0kHncWhHk/hVHLZyH4S2cnMTLBFzh?=
 =?us-ascii?Q?3DhHj3SX4T+XWSp3MOiBqXsCHaiKs9whznZ7gJH8uznPTZh02HjnD6Xur9ef?=
 =?us-ascii?Q?NVmfNHuH2wgkEm0hRXrnp0PGfrlnIl8wQ9kpKBchb5Jobj3ZAD+AMyQWFilJ?=
 =?us-ascii?Q?2eXnq1TfHxiVkO0cD6MrbQKayE8E0ypE+0e86EglfR1lgIorJCtMoHCgJCHR?=
 =?us-ascii?Q?kOePRrmcq0rQRkX+aGJQNA98lLD2qYXZwC19pd4T6PvzvO65qaXHmxmWJhJy?=
 =?us-ascii?Q?GrUiIgUxWkRRMe2pk6CLAZk0EmW9CQeO1AzIkuCUpaYYl9EBLd2nxS8fIX1g?=
 =?us-ascii?Q?aL+qzXcJulfHt9rG5oBVGb8HcULdu7C7axayUjYMPd8mPYA/s4KrwBaUSHoE?=
 =?us-ascii?Q?Voq8L9nDE3xwGk33yG07eJ2XSHe8ukXx62cmDNgrjEWdC/uEJ0bMZgiZ0WmV?=
 =?us-ascii?Q?Xga3PHdEkXcpZpTN3+y0VWAm56uz+bKUIvfy9/FVlZofYT81GvOxvhJ4MuyU?=
 =?us-ascii?Q?5OQmFFxhuYSuzAPKjn4Fw2VSl7L0wFTBdad0oZhSObpaNB+J/Fm52LM7L0x4?=
 =?us-ascii?Q?xL3jevQq6QgjFihbXDMBCCUE1//TDIF1PH7Pt0QBitU9a2XetkX4ZRw1APum?=
 =?us-ascii?Q?9b2XDHjIGR0mZcR8hlRBCggKYkUWN8qvYdN9OMUMMPDck5l8cSy33hru399V?=
 =?us-ascii?Q?+JLrPrvT7wOm0XZz/qXiA68U9hmxAO+G0ZKQYEip1TSVjDJ1X2DbfmPlVkuy?=
 =?us-ascii?Q?MZ/ET6qUXt7MAekp0GCxhxoIZqSPIj2YsMdd2JbTOeRFTfu/JifKYnk68kCY?=
 =?us-ascii?Q?7Uss69WWB0I2I9msPHFyCZh85XJgWgEysm/aNz6X7bD1EL9OnXq7RFJ/XzIV?=
 =?us-ascii?Q?1RzMzLbvnFX1ExoyWZwNSTI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D497DD1194BFF54A91896210D64093D0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IRpEGkUxBPSxrbbHbeJ4vXABKhkna1uaCRr943eSL0Q9K48DTJwAJjIxz/3aaKQVuDws7BsJhgxgmj1cMSBkc0KGZZYFYvh929upQmiko1gymUjriaJDEG6sNVMjcUclpn/row59UolCIHaU+ZpXbC+7cuRcQL3iLW+1uaw6xghCGkwhq3b7mj7QJ71H98mWfnPRhwsxdz3LnbLlAcQK7RjZL4f5HO6w+30aRrOziuUzlZ3Gm4aZLZxMn+ePh73gmDETU+2pYVDAYTJ7EI+loabMkql/UzjDZ9YqesgdiVPdADxsOjJMbE3HScuAYzKbasqKjW0KpV7g+rHs9ZsCqjaXkB7iWVNxo6/Pj3cBPwjYVobKJRwZ1wQV2aMXR4Gajj1mUpTFDTKGiKahN44B5FMF8dxR7QPwkFfDbVNlNMx8l1C7YDW30ZzzhcNu3lZlQEDsuUwxSnIAmPkbjIls+Um4jNTM5OGXljQPLJz0zYSSzzCA70rMrZHg8ypIJVH2pOD430KT+QFarn2b54GGqo5S3mdNPWwsg0vckE7A1GQyxWYRZ+QY4NGIXej/o/KcR/HkYdWU5AD6mtNV14y+XzQ/iiO1AL61/rfYVZqxHiRhD8YrJsaha4THI9ICNR4d7mlhUf9GCtihkBQd3WiOxHV3tC0gDwFe7KBK+h/XmKe40LHZ8pv6nJC5LJJU72IdrVMSPJiWyGlUKDahq+6JyYsB14srPC2LznxigeJL4piCAsv6D4UynNZ+HR4KydqTTnLLXufMwpZD2yc53X8wYkj3dT/baUl2aLAPgBO0GLK5m7sAXh3PkzBWFQhgQH18GkJ7Aq6p2w+5vDC1YQa0I4hlCPBYOEwg/3ikMimx++1a/OMQgqf4Je7c4GG/mqKFbhRNcQQYTcYFxQsq7wqgqgqMtcbVV31ELqo+ZW9fqEc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6197e504-5cc3-4aec-6a63-08db77b138a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 08:25:24.5678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNCI8T3pqqGkdATnqSJhVx26TI7tcARAez5KMgXAO0FrqHUELV7VuT0sln5A3dA/1KwSy2bxaNolc4bCPRs9OWaLJJhoHVVWt7xr6I6LS/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8439
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 28, 2023 / 10:24, Sagi Grimberg wrote:
>=20
> > > Yi,
> > >=20
> > > Do you have hostnqn and hostid files in your /etc/nvme directory?
> > >=20
> >=20
> > No, only one discovery.conf there.
> >=20
> > # ls /etc/nvme/
> > discovery.conf
>=20
> So the hostid is generated every time if it is not passed.
> We should probably revert the patch and add it back when
> blktests are passing.

I also observe the many failures of blktests nvme test group test cases usi=
ng
kernel on the nvme-6.5 branch at git hash 99160af413b4. I see many kernel
messages "nvme_fabrics: found same hostid XXX but different hostnqn YYY". S=
o the
commit ae8bd606e09b ("nvme-fabrics: prevent overriding of existing host") l=
ooks
the trigger.

I looked in nvme-cli code. When it generates hostnqn, it does not set hosti=
d.
A quick dirty patch below for nvme-cli avoided the failures for nvme_trtype=
=3Dloop
condition. If this is the fix approach, the kernel commit will need
corresponding change in the nvme-cli side.


diff --git a/fabrics.c b/fabrics.c
index ac240cad..f1981206 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -753,8 +753,13 @@ int nvmf_discover(const char *desc, int argc, char **a=
rgv, bool connect)
 	hostid_arg =3D hostid;
 	if (!hostnqn)
 		hostnqn =3D hnqn =3D nvmf_hostnqn_from_file();
-	if (!hostnqn)
+	if (!hostnqn) {
+		char *uuid;
 		hostnqn =3D hnqn =3D nvmf_hostnqn_generate();
+		uuid =3D strstr(hostnqn, "uuid:");
+		if (uuid)
+			hostid =3D hid =3D strdup(uuid + strlen("uuid:"));
+	}
 	if (!hostid)
 		hostid =3D hid =3D nvmf_hostid_from_file();
 	h =3D nvme_lookup_host(r, hostnqn, hostid);
@@ -966,8 +971,13 @@ int nvmf_connect(const char *desc, int argc, char **ar=
gv)
=20
 	if (!hostnqn)
 		hostnqn =3D hnqn =3D nvmf_hostnqn_from_file();
-	if (!hostnqn)
+	if (!hostnqn) {
+		char *uuid;
 		hostnqn =3D hnqn =3D nvmf_hostnqn_generate();
+		uuid =3D strstr(hostnqn, "uuid:");
+		if (uuid)
+			hostid =3D hid =3D strdup(uuid + strlen("uuid:"));
+	}
 	if (!hostid)
 		hostid =3D hid =3D nvmf_hostid_from_file();
 	h =3D nvme_lookup_host(r, hostnqn, hostid);



