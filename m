Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iqYvptWh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CqBJYrW9"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883ED98
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 19:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700103804; x=1731639804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oSYyCE5mIvCx8oH5Nl2+VMca3l/O7PmTLxsTiG9qAK8=;
  b=iqYvptWhoVeMZ2Fyap2ktTBT03ojfLFrqAJffZ6lkVU1wydAqfKIVNUX
   K6oywT+74FbmxijOlIZxik2aFSf85WyW0KMUvFfjTTfU1IRQBH0tj3Vtc
   z1gag7KUZb5C45ZOUnwdt7xeIykp0o9A2OxkOevPRaH6eFzpMoqeM0uJL
   71sONSuY1k7tcQXGKqCuS/efL+vQNz912r04Ik8gDYdrVSbD8sVH7RBll
   +J6UjzruwtilJ9rPvXuA77wIsbJvzgRg3h9E6m/TWsdvfRO57sL3Ofs9a
   Hlvs9sxcamKRA5Naf3gn3qLaFBY8aOeIRNT22u+rHmyORPSxha+6GdwaY
   g==;
X-CSE-ConnectionGUID: ZkGhX99EQ/6gATnHkfPzgw==
X-CSE-MsgGUID: vWNnDEWERDi45afH/dCCeg==
X-IronPort-AV: E=Sophos;i="6.03,307,1694707200"; 
   d="scan'208";a="2402016"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2023 11:03:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifvxi7iSs9LmPdCvTPcI8Lk15hu45wWDrLNYv7kQbTsDaxqAsqXqEsE0KQOaoVhr7XWTKbz2YtiUUbLh7G0WRwKHGKQmXjQgn4GLp/0dyCdBC+tTnUmk/zAOtU5dnRkHma6L7f9GLUef5wyISFFIQbrawE8l+F1gU0rs6TAjC4nR2+u1QyOFOmSOqdAiI49bvaAA6d1dm1bp02emU43V8Zy9Hvkxt9wNkluRGDVU89oHW2r13iN7UYq5HokzLqudPgjY7Q8Ot0y1CBjr4/X6+6WM5/38KJAIE1NgFS4QsTuOFFZBsH6mmLN8sQj3RiiM5KRnBkHuVeC4ejERjDNVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+QQBt3UGon0N6zo/nFNtQEBCXeUUjnQ/pkdyTQxvzk=;
 b=B4a+bqSOydewykpT6pzfEPZ6BQ14zFSFOAOlWjRReEfos8qaBf6zYgMMqoaJpTh9xZGXKSz0s8eo771kvsMUhddCmu4x4el9a6Ua0d0012jNzQK7F5HVNFGLyL/6ZNv+KXZ8wRhKBsIkKUF2cXnTy9DtiT+2TuUEXNGFDpYF3g3o6a0TNoClf4jLvU84pfKZYu0nZh01GUJFB5J7DlXdioJqwIPbRXSOpMrsJDO6Rr1iNrvgO2MMJrDrTlJrbcSW6Dd9piknlG6E1nIt0CBBkzZk2rxwNZRCyn5Ng2r1MnmBenNZpdIDLVawWbadRud/6OHQmr48GaAZNJo/rHWLvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+QQBt3UGon0N6zo/nFNtQEBCXeUUjnQ/pkdyTQxvzk=;
 b=CqBJYrW9NbGgIC2Ts1NmLRMQPXS0lHtczL+RQrueSehBML3D+OnFTwp0Ee+/PN9Ld22AFR1Hk8+eIrIRwzhZKxRcPi6vCrxZf3Z/xekmxLvbFGG1PPcwbniySNz1kNQObVw9DW3dDvytZNmMzyN/D+nJltA3+iQDgMHagfwzF1s=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7891.namprd04.prod.outlook.com (2603:10b6:5:35b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Thu, 16 Nov 2023 03:03:21 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 03:03:21 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Daniel Wagner <dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Thread-Topic: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Thread-Index:
 AQHaF4fs31V751Pswky+3T/QxhjUILB64sUAgAAdzQCAAAmMAIAAZAsAgAAD/wCAAMKJAIAADycA
Date: Thu, 16 Nov 2023 03:03:20 +0000
Message-ID: <3c5daxlrkpyf6l3asotx7gqczqo32ffzjjvfoobchvwq56c4hv@r4llw3v2msvl>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
 <20231115055220.2656965-3-shinichiro.kawasaki@wdc.com>
 <447d68cc-91d1-4d17-aec6-0105d3b188c5@suse.de>
 <xikiwdcssvdc2dvozscny73e7pxcdf7b7qx7oys34ote4cv4qo@3msll2uqsz7y>
 <ebf8d5ed-1fe6-4962-a363-5b11cd01bd70@suse.de>
 <bkd22lp42ewpp6u7lws2alcbfzjzt6yp7m3ou2ugdukiyuwqt5@pjnxq5uqnjlc>
 <fd9a0f77-116d-4eb6-ab3b-8af08dda878e@suse.de>
 <6fwo7puujh4dgoppilxwtg6t2d3sf7l7jp7ifyjprgj5litjtt@b6qoyootcnnr>
In-Reply-To: <6fwo7puujh4dgoppilxwtg6t2d3sf7l7jp7ifyjprgj5litjtt@b6qoyootcnnr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7891:EE_
x-ms-office365-filtering-correlation-id: 0e0433e7-a25d-4cee-8da3-08dbe6509715
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ayx14xd7bFRZcfrxix/CbB/6arozGScCCS97EN/NLVNzVKW31lU2SmhzNmhZSsCNdbs5q5cj5ocEoXoTxw6UhN5JIXd+NWRjj3KPF2O1ToFzcLxCFEJsDCE6Y24ajX8Mt6ZwKVjqrPqJIb4uvxumZL156E8S62o3OB1kEScuhdHunLSP9SaEoihvPq7grscBe1DSJFPTxvqZbblPeJ8Vys7tcB2ApdWjaG8Y6lHhivoYzonacGQpOhbQfl0JK63Nr053DDYIzfIb59bzMF+UZwDdvqC7xIw4E89WRvZ5TCNLIxeLeqGFpLOK3MV7F+v4McvIeRNJ7DsAoUPfmYQLFfVv3rrv1ogva0+Y0148lNGRxgKWwcCbGYals2BaoVWWzRporLMz8BfoV6K+qL87XQ+xmpSsX4/Bjdf0I1r2XQkoW+sCIAQ91fNSFcA9GeSCYI+shyQE+G4Z5NMc3gisBa2XIFTPb/LMRta6kkp076FjL07ch1VVHAzmtSRKFgC4kPuDSkKIww++Og4E9WekHMFc/yqbByauS+vkV5r0ieCvkHwtPOu1BzOyTucim5TqLRvI3HW56LuyqIhKNQRSSjtWr97a0Q7J+mmZt/wO5osQKIwZCqUSTdhZ0ANOkv6Q
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(26005)(33716001)(6512007)(86362001)(66476007)(54906003)(64756008)(66556008)(66446008)(91956017)(6916009)(66946007)(122000001)(38070700009)(38100700002)(9686003)(83380400001)(82960400001)(71200400001)(53546011)(6486002)(316002)(2906002)(5660300002)(76116006)(478600001)(41300700001)(8936002)(8676002)(4326008)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+BO3vKY/MtDtO/pPTxpCHXgg0h6nzkQC08JZ7m2NadNsrX+T0hY1SDvwY5pZ?=
 =?us-ascii?Q?bOIuy35oHp3TCbusmRHUGwEt10doLo5flctewcxZbN1HwBCUjriHdgGeNisC?=
 =?us-ascii?Q?y8W/DwJFfYG23+QRlv8LKbSaMor79sttnzd1Gj0APfZYUX2rnu2ncnazAYjq?=
 =?us-ascii?Q?0zJjJNOw/XR6wfdVrvXXWAZw9TjxIEV0fymtyEsXCfetruJ6+qyeFk5gmkT/?=
 =?us-ascii?Q?8nF8tuN+9TjCk98dBmRM2/+EAGZ8YISHlBhEpTtKTYb9fLkO1cD0FqIXt+bJ?=
 =?us-ascii?Q?/ISRqVndRL+kDUp3uLpycTjznbkXkHj3/ft84xogo2MP1OYyOvHNPM7csMa4?=
 =?us-ascii?Q?+mqam9oOKMhLkPwfL41xbjtbF3o+UNqzZbJK/6Fp+JIBm1xz9caQ/HvCK8I5?=
 =?us-ascii?Q?Bjc5m41movskLk6TbJhSIzbUthLWH/BwlNmyk9S1fv1d2+OMH8wy4SZ8GKNk?=
 =?us-ascii?Q?Nk3OEc8svhq1rwmdUc/4oFudQM+A7XJISNuR+U3st2X7Cd3OcBSq/C+5lHA4?=
 =?us-ascii?Q?0GhqeNA4r0Nrx4vjTqWW6Wrc6IQaz9MUv3v4KBM7sk4KTJYJT2NWXn6E4p/E?=
 =?us-ascii?Q?cRLThyTl6sdoc5xq1tsECcGtj5/8J/P5rL4AMQMWfVKgjTl5JELR172eZNpT?=
 =?us-ascii?Q?cGFf6zCpZ1YdJhEECuA07O/Jvl4KL6zEYK41VPkodFgiv6jyKziesmAphM6u?=
 =?us-ascii?Q?0Ee0pG4ypt7OnTQiGp83RIVcIb0xwOpdO7F6qAU3wKSiE9XopymCyxU1gTYW?=
 =?us-ascii?Q?j3mdhXRvtU4BzKMZAe/WFXtwObyARtb1crFe0Q2koBS8aNweFeTInplbBnCL?=
 =?us-ascii?Q?zcGfWh456hRzqpG0AURmfzv/rMGQUxddADaapA0beqMhFuKFMp/BGutktjdn?=
 =?us-ascii?Q?xBYD1gdByYoR9FsSmcaEB5whkHl/8FnVgtkpDAsC8V9R5SH/0je5PsWOwi/U?=
 =?us-ascii?Q?claiRp4LEYen9wksP+DSzEI0eMXWGayzlNQW0HpBv8aX1MVfDTSr8ADdiCzR?=
 =?us-ascii?Q?TB9VgAEQv4xFjZNEkLrYYItnKXdVbabvHNZaHHRUb8Ejx1qlyeh5kY4il8gx?=
 =?us-ascii?Q?8FZfl5/nanTUFbjTdl7QyR3XN+28wN+NghYdPI1wygqZ7iCn+O9pRkUmvq2e?=
 =?us-ascii?Q?+jt3VZtbR4ngtvytvMOKDzMffV52EBxVdwO/up7UpnuPtsjetEaL4+xIK57n?=
 =?us-ascii?Q?ysUNqnV8H+tfsaysyY65REUWTPs4DYR2hyjbdsIjuzwOf6mSBtc1MQvFPHtu?=
 =?us-ascii?Q?FtDCX//1zcEIKaNFrXuLOPPBBpCIceVJgCvjDWjtNBjKEPuaBXS4hPMhCjHP?=
 =?us-ascii?Q?kgYAtxEdH0zcWq4i+K3qSbBlCVDRcEMPMRFXSdsFqezD0Wk1tF5n30nT34cz?=
 =?us-ascii?Q?KQnXOUHLNBo6dMeanNbEStxSAJfiyYIagZzdsD2/0+LVzMw1pGbz/JbnmSt3?=
 =?us-ascii?Q?aDrPxvOkLhPDBFRc5HhWs6gkFOh8H6ifzCNwVZJd4+NYw9qXOM13/CDRJp0q?=
 =?us-ascii?Q?gXXwmwuTzFtS6u0Pojy9MV7nEREyDshLQbj12lDjZp8YCsuXrnVMZxCQvpT2?=
 =?us-ascii?Q?NALeQhXedjgpjqpkvRVxZD69f1oK0Z/T/8GISKyXoogAuZKLWFcBMqvqHvS9?=
 =?us-ascii?Q?/YYNNF4QgKFB7u/IGtk0eFY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2CBDF29C5720284CB120A0996AC00F6E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	guWQrW+kne8FaBStYtrV1mp8W/6Xccg0JEU/YaUAG2EP3QWSR4CYajnAcSgD+l+Kg4GtX/Yykm7U0fJ9k/zsNTEJXUAAEEgO+HoCCw2Ft+Lb1YN9KYynd5NQR3D1x2h9f3H/idO/hklZoSBrHDUK1aQbH9J7uvObKXsC2GKFdnRPxZZoinJQM61X8hVOznanbMINA/dBUJvKjs4ZwETTxPrMQxHgkhagWLWLmZ+35dRg+C+rNcTN/Jmzu+xi8rPklm+oifKv0WqI548py24eYuwFEX3dzJbAwoeh2ZQZv+QMh++S6Ak8hY9S6qgzBefCby/1wTIdDSgt6uBmaFMfGJRFE2itwyGhYwz0j9o+eRgQL1y/o8/f8l9FFeGOLwijDsGBSqOvdStrvJQTjYM8zYKOa60Mr8m6dflrY7zHPOlBSwEDLRH5ugofvzhg2Il/52xe6SYDyZIaG+PoED4Nb5C5KnCnz2jpBjvlmEUPS6/UBhK8yNxz4HBnC4w5BoSH28s8NXdyllk7R0U7hhh1LbT9R4eaB/74zNnJIlpXZHBwyjGcnhRD8NTREq12t1IxER8O9lhoz0B8Dva+jNhZXoYSnqtZObyFRm2f5ixzUZ6CIg4uTueOz6Jsj8hA1PjiMcGsYyEu7GZCE4PKqQ1t1PT1wq8BHyEe/TikkTTCVEwh9kKjmiZ0SAgyvsHnuwOHIQwr3LLkBubqgqeuLXKtqrLDLAhHRHGiNUHByXI6o/RNoLotWRzMikRVUS6UCbfTDQ2BXpd5xYtBpN8gzL38/GeAYARWuMaWESS28X4kLQSsDbajRea2yz8jPwhv+y+RLzQVLSiZj1kcz34LsjMD3qau+OGQj5vgk60W2EP/2cPM1OqMzgDjMt0/sm82fNJU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0433e7-a25d-4cee-8da3-08dbe6509715
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 03:03:20.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dEdS/ZHK2+ShXZMKE65tvyRNJzfwiZATuvbNhwfIP7CgHqv2NyoorT9DzYaN8pFXhotllw8f7Yz7m91BzfG4LLQ/eJUg3ZHznxj7an4M6y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7891

On Nov 16, 2023 / 02:09, Shinichiro Kawasaki wrote:
> On Nov 15, 2023 / 15:32, Hannes Reinecke wrote:
> > On 11/15/23 15:18, Daniel Wagner wrote:
[...]
> > > diff --git a/tests/nvme/045 b/tests/nvme/045
> > > index 1eb1032a3b93..954f96bedd5a 100755
> > > --- a/tests/nvme/045
> > > +++ b/tests/nvme/045
> > > @@ -17,6 +17,7 @@ requires() {
> > >          _have_kernel_option NVME_TARGET_AUTH
> > >          _require_nvme_trtype_is_fabrics
> > >          _require_nvme_cli_auth
> > > +       _require_kernel_nvme_feature dhchap_ctrl_secret
>=20
> The idea looked good and I checked /dev/nvme-fabrics content on kernel v6=
.7-
> rc1. But unfortunately, I found that /dev/nvme-fabrics content is same
> regardless of the kernel config NVME_HOST_AUTH. I checked opt_tokens in
> drivers/nvme/host/fabrics.c, and saw that "dhchap_ctrl_secret=3D%s" is no=
t
> surrounded with #ifdef CONFIG_NVME_HOST_AUTH. Should we add the #ifdef?
>=20
> I tried to find out other differences that NVME_HOST_AUTH makes and visib=
le
> from userland. I found ctrl_dhchap_secret sysfs attribute of nvme devices=
 is
> in #ifdef CONFIG_HOST_AUTH. But to find the attribute, it looks "nvme con=
nect"
> needs to happen before-hand. So the attribute does not look usable. Hmm.

I rethought about the ctrl_dhchap_secret sysfs attribute, and came up with =
an
idea to set up nvme target without host key and do "nvme connect". (With ho=
st
key, nvme connect fails). Then check if the sysfs attributes exists or not.

I quickly created a patch below, and it looks working. The check creates a =
nvme
target and affects the test system, then I think it should be done in test(=
)
rather than requires(). If there is no better idea, we can take this soluti=
on.

diff --git a/tests/nvme/041 b/tests/nvme/041
index d23f10a..28322e4 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -27,6 +27,10 @@ test() {
 	local hostkey
 	local ctrldev
=20
+	if ! _nvme_host_supports_dhchap_ctrl_secret; then
+		return 1
+	fi
+
 	hostkey=3D"$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
 		echo "nvme gen-dhchap-key failed"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1cff522..9e77d7a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -1010,3 +1010,21 @@ _nvme_reset_ctrl() {
 _nvme_delete_ctrl() {
 	echo 1 > /sys/class/nvme/"$1"/delete_controller
 }
+
+# Set up nvme target without hostkey and see if dhchap_ctrl_secret exists.
+_nvme_host_supports_dhchap_ctrl_secret() {
+	local ctrldev
+	local ret=3D0
+
+	_nvmet_target_setup --hostkey ""
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	cdev=3D$(_find_nvme_dev "${def_subsysnqn}")
+	if [[ -z $cdev || ! -e "/sys/class/nvme/${cdev}/dhchap_ctrl_secret" ]]; t=
hen
+		ret=3D1
+		SKIP_REASONS+=3D("dhchap_ctrl_secret is not enabled (check CONFIG_NVME_H=
OST_AUTH)")
+	fi
+	_nvme_disconnect_subsys "${def_subsysnqn}" > /dev/null 2>&1
+	_nvmet_target_cleanup
+
+	return $ret
+}=
