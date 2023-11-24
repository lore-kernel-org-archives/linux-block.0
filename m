Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X8e7wTmw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jYCpbWp/"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202C610DB
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 17:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700790589; x=1732326589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=45GBciuhPtn+bfBg0jKNiSIjQdjckwoAs3fTDjFolrY=;
  b=X8e7wTmwpxAS4kuXlthFbBL7H9jzvzwXR9jO1cjgHBkG1y5utcjC49Me
   ZVnvA0iBz7h5OIzVMKTjZeh3DI2UAH+/hBm4EPoWcWyIELuLEU57MZ+H5
   lyJXCLGkp/HcDBdDO5M+b7lreJOwPL8OtjTem8Zz8gxzsIP5KIOfekfIx
   xnQe9VWAT2ZK/weftp3skpRDloC4QKdMvg7qM04cJ5xwMn4Qn71KEXcfc
   bRMI/K8E6HgdFcp3xQ53Zt9HApI7AWVX05d1R5n0sj4oWNtJyFKyfXCPM
   MSrkJSlFG1ph6RvDv/+j8CCJxrT+n9Xldq6vjOZlUDcTCKbW/g/qKOiXd
   Q==;
X-CSE-ConnectionGUID: nwnkPOSYQqaLCSw6o6QHQA==
X-CSE-MsgGUID: f/0VGD5HQpSpnXjAfxrTow==
X-IronPort-AV: E=Sophos;i="6.04,223,1695657600"; 
   d="scan'208";a="3054256"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2023 09:49:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTp/gbUEwNimm/LjGoaMu92Sop1ftHCEybSyqWv4EYvMgRoqiit+N9dIB8PGqHEgW037KfEhDhrgumKrbtcEQChXHOr63t5PRWzdAftkpn54LpXKQVUftKr0OOMLtPzgdqQFu05DF/wNWMd3Hf3raU7kWynfwH4wKz9Ym/6vwOfRIaH+l5rJIAycSr8JTNTvBFZEQRqzRf+9FxkPtwc8mheN2g3fxXpszlR999L2fwc46hcjFKhVt+5aFFhx5vvmplAQ12liiXk9ueMFYt1XT+DHBkSF3zDylDM4gprcZZqUE0mJXo4xad5fGW6o9EnssWmuW2Zlx/d+ToVGJVCLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IXGPuXsfE5GPn3fVSVBxaS0TM48KF0cpp07ITnziI0=;
 b=iyuFKohxCtJmG7sldHQqeI6KCWfF2wGI6Tu7Pnqyn4SAE8SZunpYi6zhFpnduxatGj34peWmNZroi18DfxN3oX8U85YPXV8i8aY0vZ6q4/sjzfK2c3Lxd/1+3zYUWDobr1CIzVj27gHo+tXPcGmDFrYS7cHnjTbfjfLieE1ts6W6MfL7HfqImFoLqM1jKosgThMXjukzrVL8QWk6iIoLbOvuVVZKzYkATS99y+JzeukS3tVKJajuryWRP6A4Dkse6bmkrZCbsISU6O7KSYGXf2nClyWd4AWJIrar8poHuy94+KES30JyrK5kKDpzSy54AJNoK8wQlKvrosSFM1Dzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IXGPuXsfE5GPn3fVSVBxaS0TM48KF0cpp07ITnziI0=;
 b=jYCpbWp/6Yi7GpJ/pp7m9JJZcHbIMf+ubo/91NvXtm+geTNTR6zC4l6557+1e4j6Yl++MBLNjE3i9r0iGoXdFaV2tAe8RkknxnyD6JUxjfWTa7IijHSoqCpKpD7AprbaNTme3jWjkofauo3UbIteL5Yn/dXq2b15ETwe3f2X+EI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB8185.namprd04.prod.outlook.com (2603:10b6:208:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 01:49:45 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 01:49:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagern@suse.de>
Subject: Re: [PATCH blktests v2 0/2] nvme: Allow for pre-defined UUID and
 subsystem NQN
Thread-Topic: [PATCH blktests v2 0/2] nvme: Allow for pre-defined UUID and
 subsystem NQN
Thread-Index: AQHaGU5s5pFxTsmg5Uq+A9PHsLgNI7CIvk+A
Date: Fri, 24 Nov 2023 01:49:45 +0000
Message-ID: <u5cuywj53ajm4of47vg4w4m73ms643xq32qjxsq4hjegxtsvso@fhfq6pjzkgvk>
References: <20231117120550.2993743-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20231117120550.2993743-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB8185:EE_
x-ms-office365-filtering-correlation-id: 849e4818-39ef-4573-6cec-08dbec8fa281
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2c+qJiVfJDKFXNCYzgQA+D61ZNxl6wLKLjl2/kaPfM03mPFAlqXJf4rzBeYnW9/xoimZLGXXPPyfk1Oh6LaiK3HUjo2DnrLiEn6EwVsrA3qJC7FZ6HT8ba+ho4G2lXOfyLxckgbxVXdFRqe/CvkUqB24D0vTDv0wcK4Ac02cexhNZ8jKaydSwbGKvv+clLke/gzwg5LgRhd6mJFoOITHUSKtnsdRenkDVbTRjOh2qd+xlsVbIJ8ofJpGLPyCcw2GmC8+OHrZn5DT+iybUU2qaPIP4sLhO2gxTiuWSahGaoEDBjAkZVTVKO0Pli/JTHLshSG+sdpSQCUU7cQIbbh9BbctkYRH/UPh3iGjmZZUbIIPralZDGKll+1OL/zrBAyOmyZyx0TNGr07rNqqYFtKzvD6j1SGftDDmwcFCjayufnvn0x4EWcr4d6zrMCl3PDR0Eb+2L2P/XgREUYriduOdaDYtKD+NhYNMTVz3ogUoLR5B6tAWDS+pzpgL+KC9714IMarNASkR4vXA/wjyGdooB3wLxdMElGwiaVgV9gUAovzR7BNr6BysRvWaq5akFYZIA9zeRl0kMsiw6BfQ+uwc/fD2Xd4KErZTb9k4RWQJUw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(110136005)(91956017)(76116006)(38100700002)(83380400001)(966005)(6486002)(478600001)(71200400001)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(9686003)(6512007)(6506007)(82960400001)(4326008)(8676002)(8936002)(5660300002)(2906002)(122000001)(44832011)(4744005)(26005)(41300700001)(86362001)(38070700009)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dp5wz+0xtpl9OdkjLk58Qbszm3JBOK5vVFyq9bBXdFpxiHbVvR/AwjMfL6tK?=
 =?us-ascii?Q?9iwKrhr9OxPPql2nyVjRteuPC5HCBCD4j67mkrgwylq44wztUhmdiBzQtIA3?=
 =?us-ascii?Q?5p8txiwgpNlO7MHOv5EsttJDvFHb5qj4jg4UTaMkzAoKlo+dpbFrqJl4qZGH?=
 =?us-ascii?Q?drbooQfiv3XJwbHT6IM/YmOSUy5gaZRJIiOy7vaq0PWmGjGDYKtCreE9ytZC?=
 =?us-ascii?Q?z5Nu6lPu+wh0V+TGyeNg6CxzQxGegeOfYJl5Y8jvDMJvPhTXAK3fBUf1c4bY?=
 =?us-ascii?Q?qjaWNcapPaTr1iiOsgGX5haIM865Fqs5wp/mF1vpmwgOqiz9CuWA6G2aPMN4?=
 =?us-ascii?Q?Ulfk8uI1GxcgmX5Kp4mVEjbPYqrvzENexuhKkdwa4DZLxpb+wli/mTPi5oWy?=
 =?us-ascii?Q?TTYnmSY0DmM3Fmsg9s/K9KBsWp21zKWXGJgtvGjL+yqdhp13nL0U2PW31DXu?=
 =?us-ascii?Q?BJmVpl7Z7Bs6vflg5H2sc0zh4EFnxP2TR9FW7H2KE8r3K6y4vB+rj6mXX7IQ?=
 =?us-ascii?Q?v5+v1URaUr6sizcw1PjaEf0l+QmfB8X6XCSnm1UhGxxsBf//0gcm8CO+blaJ?=
 =?us-ascii?Q?LNstDsU+i1li1eUxpmFcO3AOKQIdwFh5Yffx1hcuLV7QXdF+08U+QpSGbreI?=
 =?us-ascii?Q?tHBrFR7L29qfQVozVVC7E9KIvE+8U1u4K8hIKp2vecgrqRkr2PcYc22jHmxn?=
 =?us-ascii?Q?vAsXwepl8x9gKvEmTPHgkqA1PCrCwXsB5NPmGgDAxm98IOtdRD7HJkLor5sN?=
 =?us-ascii?Q?G2wDutwFPii8nArvg91p0tAyn+j+FuWPFbIGckK+4AId9rV2bT7yjtuF1t7B?=
 =?us-ascii?Q?8rK3qB9zk8D6DIDqT+/Mykxzm8yHLsc0qUNYqNzJ+TdMOALHCVGbBbcy7v0e?=
 =?us-ascii?Q?wxhy30xdCwGhaxWebRQIk6Zq2CtYj387LUFLoQ+dmHUJkdCIvrYQs4YeUD63?=
 =?us-ascii?Q?f+zrgnW0tPUvqJ+TJ8Vvkr0pl96/1ghEG1RFS1ZoFZxSCHsWau+k4VF5swRZ?=
 =?us-ascii?Q?dL38FVunRoDs9+vmAY/tilVBFv3JN3ugdizP3yM5UoS6gp6F7Q6Pwafwy23j?=
 =?us-ascii?Q?4vfhGtj8tBf40U6OG29SO5kNIRgG4HEZIGk0ZAXgMsRFEhplj3LdApLHcKnk?=
 =?us-ascii?Q?uLkRKulSSlNiE/6hFCz9vwDp9z5PyQMg3DthuYI1Wv045QqrLzGOhI7mMEEr?=
 =?us-ascii?Q?f3Ff852GOU19kP8yrUucu4hZXpD5tWwCI8xjTGs3HOV7b43B/b4l6Rnp0j5c?=
 =?us-ascii?Q?ZiNl6iixYG404E0o0FKufb+6xGWB0IagO9hp0lE9yQzRZLG6iib39D4OpuQO?=
 =?us-ascii?Q?PoFVfDOrUtzUQT0vT1ONZXcM+eBNcplqUJgfj0q/uNRNsGLsvracO7Mie/0y?=
 =?us-ascii?Q?gG5y5QdGjsPnw5nfQPABV/DA2hI1YJ6MNDyu2n261jqBADoLPy8rN8lQhE8u?=
 =?us-ascii?Q?dZqPURyGqDyGAXDy+r3Xf6JwWGVGEJga1tvOLckBv5GORNdx6nSFncDwqMro?=
 =?us-ascii?Q?TPAjvU2QdQcL4TZsxeWztR0cEP2xihhUGMVIExqtoyEVcStTX2aalDUlHmPV?=
 =?us-ascii?Q?tGopzlv5g2SSTR1wL1w3AWCWOgi8yFkqC+D3NwTwjINVnmwBrg4x3lMaNQuj?=
 =?us-ascii?Q?G1i21rcqXrh55nzsu2wuck4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A73C54B2BBF9D49A1BD0B59AB5093AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hRXZHUZza8bACMt6QZL55mSwOW6vVt04Il08/bdb+BT+Geh+p65ui+FWnJo7CpSvuxlG2VUWq35f40rJ44c9RQ1NtE7VhVFXaC6PLo+yziWXz5E2ADccP2Y7waTRHPAp09hsp8ue7/je/p8HOJeRlBGHLVqFm5R8OJIWzLW1UgylJC5DfFc8+qcs/ye8i3Wkh58Z66LENBCWYHC5m64ZQjQGqXNHDcZvZoHKRD2av62r46I7QIORDlI/KSTfZzmrkejPTR8i0EbjzSVcFvcUoAUwgkfQ/CKPZIaYgdKC2EHjsOvwiOU3h7uf5wgu9wyuEMvcoXDWv6plVI0cAf7LOqqhNoeKbumLVLp423qnuY7frkEXy2shaICRWexq10pY64gTsmGV6qoNQjDihhePRrMbFPRzN+KXHoAKOkepo5bkObPJmnzP0N/UUA6eZyW/N4LNObcW2uj/9aOtPii/Ptf/1WAwMFnAAVp1RVycm+LJ4D//ZuafxSsa/l/uCSZPeYwul3bmFaMN1CvEorjJnn7Os0fdzLZEEMU1T/yC+RvAPIldkq3PWf1rCMer1bca0EQLhRtwaTrFVcgBCo3QGHSiyO9ycPdKFTCRkukZNXxC/qn4DuiqidxFY8PmRX7/C7E+VxwH1+AY2lauXXdDHq1O7m7tEvxR6NpuYAvcR/vWVpybqNiluY2alePaXZ2Sm3aefGgYXk9fyWkBFg3LrEgnlGCxPaNLl9iqm6SWlE9VSZ9QqlgnQjXWIzZH/y+chcjeb9Kppoih3HYZsYat+hstHapKPNHZqRW30PJs/3dk4u5ZXA+hB1HIh5VLIrUwbDU8JWaOgeql8mMsJbXmxBI+q9HGCvwyWBnulkZor0Q=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849e4818-39ef-4573-6cec-08dbec8fa281
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 01:49:45.3739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pR/9n+5JHNrst1qAutQRifz8kwA4UyQbOKWQw+avfSewV6b16NkP07sbtTXdOISeVb2Vl9sQnpZFYXL98gax9CkJe1u7h358B+V1pVXakxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8185

On Nov 17, 2023 / 21:05, Shin'ichiro Kawasaki wrote:
> In the discussion to run nvme test group with real RDMA hardware, Hannes =
pointed
> out that pre-defined UUID and subsystem NQN will be obstacles. To address=
 them,
> he created two patches in a PR [1]. I post the patches here for review by=
 linux-
> nvme and linux-block members.
>=20
> [1] https://github.com/osandov/blktests/pull/127
>=20
> Changes from v1:
> * 2nd patch: remove only subsystem NQN part from the "nvme disconnect" ou=
tput
>=20
> Hannes Reinecke (2):
>   nvme: do not print UUID to log files
>   nvme: do not print subsystem NQN to stdout

FYI, I've applied this series. Thanks!=
