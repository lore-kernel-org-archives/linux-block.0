Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CB315AAA7
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095651; cv=fail; b=bRYFPPzeBNJKdO+wVxnMyhzPMZFgCCbQTGn2tbFINWAVCNgU82FnvpEvJ1g5lEr3xmrsHVwKZgrRF+4vJhDk2ibztRoFcQ8Z/ddX+tXY2IOMRZn2M1OmThbxifvvB6fqCfCbfqQvPwd2askl1xRtd7rEGC2b5f5kCs+OamOWZsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095651; c=relaxed/simple;
	bh=ng2alNZUfkIA2vUR4lY0okC6jdt1pQIu5gStDLxLy50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sCzYtpsyH/jfDo/3dIdX7TVEqrr/C+57LrG3gQAPN1M4GJG9tVKoqImcTYgem1yEZ0ZkOdU87nDfZgnvQR083dn40r01EdLsRbKRQ5IxTb+aQRITyucRdfY9AbXQ893d13Ylmh1ASzgtd8cRguKiW8BkHi5Dojs0LRpX3+MZMEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=npNO5l4j; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qt3U5NSR; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="npNO5l4j";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qt3U5NSR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712095649; x=1743631649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ng2alNZUfkIA2vUR4lY0okC6jdt1pQIu5gStDLxLy50=;
  b=npNO5l4jKn+Ppd/GWN5Zx6qyMxPhbKSxZpbgWCRATFUFuCYdlCcDHHi+
   I55DKuzHIH456abRoO7BMgdMMTM6Mhr5Lnkq0YLEQWgXbeYMsaNXecnbr
   dsWf3Gy3vK2ypkYdl6Ou213nBdfy10yN8nlBEXfqgG0NxJqOMWFfyBCum
   KzdRcEz+JDQuJFsFhVmi9dLCvVtEuS369o/u88/e6Vu+TMMlSJXih+eOd
   8bcLgMpLc6gOyPyFc1V0s3rVbPU+Tc1LA6NfcR55AKlLEEsx9k9GU9dzU
   XuKsFpArCVfmXVjlzuq3YOzt+/U0ll7LbguBgDsOE83Lvcit5S83hpyF9
   w==;
X-CSE-ConnectionGUID: 9CvmF6+VRHSszNQ/SgRZ0g==
X-CSE-MsgGUID: D0+TNpDDSzqX/UMXxUHM4Q==
X-IronPort-AV: E=Sophos;i="6.07,176,1708358400"; 
   d="scan'208";a="12574924"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2024 06:07:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAynnTQO7yx5b2B0HFYY3NbUKZMAePFYKfiBaV6s0ogtLNphKfIVjl43qYBTZv+5Rt1MujAc8AWwbii/+HtIlzxkBeO2n9zvIU437vUfI8vo61XeTMdGhA4CgXJQ1xOTDfkHZi1TvA3Ok95oLbSixgoRDN9S5Gr6bpzrbv9VJQG0XZpCOHwTUSsQpXibNf7HuOZ+ZPGMzE32exTdgOpagWr9RVvI4hLxFwBsrPJVcoc5Pk+aIC+ZZg4aA3PZ1W5Sa9eX5cq/5/4AXw5XOR+2vKnDIbbe/BvRmW5qr6NjrZnq3X0AP/CQpf43zHQ5/KMU8nd2AXqP/xYE1VP+L84bhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng2alNZUfkIA2vUR4lY0okC6jdt1pQIu5gStDLxLy50=;
 b=OAtJM6H6Y7CaGPP+BPl6TKufnAEIm2FKekTZk5ATc+sJTGaIr+Jk5IW13ZCwTTKtZ7hJOO9rozKR5L1ypy2uqBtOWXxKdl9Wr0L7omzt2VPMuSP33PMzKwAUqhL/q+BoscZQKtPUzCpX/iLaGVxwtGod2ztKST8cJxlCp9YKYTS3650e1K6d9kNShh4ZwC1w6yynpqhyFaOO1nTamF2g6JrON9ZNRxxOb+vfv1rPmH974t7sFZt1zFM9r+gZrWAaRcNjPWBLfKDFddeKhqgt0yiYnIA9ZI0ufA3dd2iooosUm+pqBj4N8JkAugb9uHdvNJYvRRjFHoFNX+tvRQHX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng2alNZUfkIA2vUR4lY0okC6jdt1pQIu5gStDLxLy50=;
 b=qt3U5NSRSSDzhD/LusazaEKkQYVgtgOpF2mfx18XF1fAJUumg5yhuudQZmTAIS2dXKJ57YsebR6GBM7R1Cpsussc/bcq6YDr9oJViz+oPtaXPJtGMk+BE26VosskWOE3uN8Waxqx1Ppnu9mb275l5l0LcmZE+Wpa2iJlyS9VkkI=
Received: from BYAPR04MB4151.namprd04.prod.outlook.com (2603:10b6:a02:ef::28)
 by SJ2PR04MB8849.namprd04.prod.outlook.com (2603:10b6:a03:53c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 22:07:25 +0000
Received: from BYAPR04MB4151.namprd04.prod.outlook.com
 ([fe80::3fff:8c2f:81ff:c80]) by BYAPR04MB4151.namprd04.prod.outlook.com
 ([fe80::3fff:8c2f:81ff:c80%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 22:07:25 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "axboe@fb.com"
	<axboe@fb.com>, Gregory Joyce <gjoyce@ibm.com>, Nilay Shroff
	<nilay@linux.ibm.com>
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node and
 print error
Thread-Topic: [Bug Report] nvme-cli commands fails to open head disk node and
 print error
Thread-Index: AQHagNmYyeiTj8p8fEeiO2lJ5Vj4zrFM1rwAgAiqCvw=
Date: Tue, 2 Apr 2024 22:07:25 +0000
Message-ID:
 <BYAPR04MB415105995F0F45BFCFE48FEBBC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
 <j37ytzci46pqr4n7juugxyykd3w6jlwegwhfduh6jlp3lgmud4@xhlvuquadge4>
In-Reply-To: <j37ytzci46pqr4n7juugxyykd3w6jlwegwhfduh6jlp3lgmud4@xhlvuquadge4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB4151:EE_|SJ2PR04MB8849:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WjnsNEuzyBwcnMskezWgKp7uCcVEWW6+xQ9NIPlq3h5TtXJ6O4/YXC5/a1NGmdEVrUfmSIGAM+EXJRxoxjLwbcXkL1YBOjJJlEnRgx886S23rZrDLCHOD1x5EBAuRA8PvndZSZPDlB4+LyjOVuD3aB6wKJohjJffQWm5vmKlJwMWiiFEkjNTu/PfG++l4uK9iKPF2uMI/CJGl38GBKqF5EJ/j81YtUBQkhdiIUkWspa5JlHaviX2SzPjjT0I4MH/TOv61yjYnBhWBKqonoXP+e4vjgejHI+sKWhFXErwTr4Vj5gnMExSb6y7g/9xOaQkEj1jR7q70jUCcJ5Xs0xMs38WqxLCh44RkCtbpHZHpa0vm+JPvmmficJyujwo4E4PC4JGN5meKpiTo+zCzLtvkGe6ryrooAIkbTawfiPrPn5B2FvGJP9XYUHYCZzWSeMeMnB13GJ4WJJyGh2d2lt0LY5Uvqck96ets0p5+kBr8j0kE4TYx1xQoY8UJVUsz3hHp84V8icUs7ZNZYdZo80gLlIMnql82OlNcQhIupqKp9CcWP2QziuSB/TiRG/qO7MNIHhvbKpM8kTCJZoJW9Lxlgoa7TFOwzWsgAi2ZW8DD0P3r+90HVDXP/px7LpJ3rUeaTMLZd+c7Bb+c76bB4Pey5Ndo6owElcLUnSOUyCpgO0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aO7oWOEBfZQZFShaGVpZRmHUfoKHU4yRP5kcqfXYCiavTH5p5gFSDnA1/0?=
 =?iso-8859-1?Q?2GhIfU2h/OMB/lXUV2xKifTW7qWM/rHKcvQQl/qvi5z4I4rLTSoHKQuamS?=
 =?iso-8859-1?Q?2TLjSwM+eM9Wy92n3SWl7rF0jpGgsRAI2b4I5ASndc+M/a99wyEu0PdvR2?=
 =?iso-8859-1?Q?yW39mdGWkdk6NImUPn95EfZ7lCZp/wbQxmORYbEnr3WHN4uBKA/8OLZuD/?=
 =?iso-8859-1?Q?rtW5tTKpTBdQ0KOBgUs+T8StVfd/MmDUuxrJC6wH4JEFhCl3ZWZjGCXsYD?=
 =?iso-8859-1?Q?uPQytRkZORf3wCGY2ZrxcU2siz2OZ9z+TfNxGKnm26SxfWy946sgEZDnmA?=
 =?iso-8859-1?Q?IxQKVmFBfA6rflRWBybqioggZGLfJsWgh4DKhSMWT+TXhmbaXnYYVvy5gp?=
 =?iso-8859-1?Q?Yrg4ilmI/eJhzTO6UI4nkKY3XAACEY22xSX3Ho8KJymlSoZrNxstE9uR9P?=
 =?iso-8859-1?Q?37DWfbTPECKFtmSjiYcw1f7e5WnFYPKFtR6EATH2xtXFtxCLkMhwWpXu0/?=
 =?iso-8859-1?Q?oyarcWVCIe/QgDuV9OhKZwhuBlDj6lKMpWjnr9wsqPAfuGs/zxTBZj9Ah6?=
 =?iso-8859-1?Q?IbKWUrVb0w31eeyb1E9kkFozsCC7rMyntyXt4tvMWcicZH6DP+9zkyc3B8?=
 =?iso-8859-1?Q?LpREHLQiOBjwBjXBkXzu+G53oIc+ZvYToUxJSa9CvyNJBJ0vkxxNfD1rna?=
 =?iso-8859-1?Q?RmpNj25zmbQ6db6PfqpO8RDODUSJgu2r/8pirs15rrrXalXFqsUS7O8VBo?=
 =?iso-8859-1?Q?AtjRWdm6AbMT/HesNwmeYFaheULbparY8yaa4o4qJW6Yq+Cc0+R63TSJIa?=
 =?iso-8859-1?Q?J9A+0i2viW2mCU78IMosSYH9KIp9h2QP5+bFeTfdomRH8j6sZn7oI5BqVA?=
 =?iso-8859-1?Q?R2k1S9Zz1bsNCflzthAiFuNGsNpcEFSx0wa+V+SG/IiD9rPIrC+44ncNZZ?=
 =?iso-8859-1?Q?gbdxug1gnfk5rdXB/w/Vmhg5s5b6GhkM89hWj1rOStnDqyc1uRpHAtbwky?=
 =?iso-8859-1?Q?5ICFp38oGqsabaZxYxCW/i0Q5YL+oFW8Be12UUithsZXTny2qkweEHLV3w?=
 =?iso-8859-1?Q?YU/eZzg8q0xZrsl1uI8qeq2zH+7XrYFkQbfWdu2fF90yF+3C746t3X7elw?=
 =?iso-8859-1?Q?x0PIO9vd1y+T60DX4/9QHYkYNQ+M8kL3eJqzOkR4lNfZgrHVZL0yOiAuYl?=
 =?iso-8859-1?Q?Wyu06D70jMdOHrh2a+JVY5Qpit20UF36Vn7QdsUA9Gy/LlOvP/VrFI8d+N?=
 =?iso-8859-1?Q?2LOouMICztkVQKWbbz3WVTlYLZBLlecuMA526IjL3P4MbQzBp4YIlnkZiV?=
 =?iso-8859-1?Q?e6+7SHtuhEViPiJ1Cq4aJifA41VGAW+Vd+X08WPZqcHT0YJekQxZFmJdZ7?=
 =?iso-8859-1?Q?5u+avQK9HWasNDNyeA/rhmfpJOCfHWvh/RIrY8cPcfKOd/ghBW7Xwdtp0r?=
 =?iso-8859-1?Q?KwuP/suhpHHHrq58nY+InQq6K+uIPiYSulqnOuR/ImeftKdluKNgKHcx0s?=
 =?iso-8859-1?Q?dSkLii0ktGJUJu3Y/JrkryXYj5ZCUZGK+2ZXpBtUIU7EpNDSLw1DhTfTS7?=
 =?iso-8859-1?Q?L0mG/i0/6ZZps5BZ3Uk1oz/3tT0V0yFnNalU5YJw82vFGE8hsX0+xGQ+Ha?=
 =?iso-8859-1?Q?11Ya2PALiFV++B36tVdDaaNNRmxezNwwM8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TmXrfHtwuQta3z+pz8CnQh1ldLfmL5fPKpzrbG9pXw0g6kbZ2ipXoOsiNPhApICIz6lt8MKNnRgFn9mEGm6ANQsaUSpPpScedAzkgNgYzUG2GrICftzoNSp4ONnVNS3cZMP80s5uuTCq8dqJO3AMtG2/BJzv9xvV1REAiMvXtZ9InMTuvbF1KSFdMeiqci/XwEXj0RXnSArnreCwEOuQ7p4x5ucLaiJmcpLgwkq/3NdLNApz5aloW/1VM3b6ioWxY+ac618lcMMrhroZQ5WYqPPSUf6ErHnEanFh4G/WURXRafR2WpKAutwZ/7Wl5ydGNsYg+Rqpd9qv50yNmpV0iKP/7rIQ3dTVw4a3fO9RlwixSldGt47zdSTjb6M92H/6XrQOKr1N9DNQQKOM36E+xc0elFWugwHqvjxFZ7n4GnSdgu2UH+sQYxSEcjco+/vZnvUhZN0Zra+S8j2tGgzqabTKq+5cQSAbJ/ReZv/ZcvteWE3blQtGdqy0jKVFXmfIvrGAJWmYSHW0ZuCzz8VwqulG73U/tv8ykRrklNdTgxg2+r/7dPOVGZxD2mCH67HHoC7wgYnWKCl615d5xQr/2ZVjGmsuwIy4W7khAajlvd8kmIj1CFwBTXWC3oGJd/po
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85e9671-cba2-45e0-4e5d-08dc5361475f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 22:07:25.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TaX0UncLokbxtBbKVYRVFn+iYFMoC+hw/I5l6fNODKpaXMj9S8nTFSNySFvYxQUPKXbFAw3AIgTGOQ4C0R8fBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8849

=0A=
Hi Daniel,=0A=
Your question about the nvme-cli version makes me wonder if there is a vers=
ion compatibility matrix (nvme-cli vs kernel) somewhere you could point me =
to? I didn't see such info in the nvme-cli release notes.=0A=
=0A=
For example, I've seen issues with newer than nvme-cli v1.16 on Ubuntu 22.0=
4 (stock & newer kernels). From a compatibility perspective I do wonder whe=
ther circumventing a distro's package manager and directly installing newer=
 nvme-cli versions might be a bad idea. This could possibly become dire if =
there were intentional version dependencies across the stack.=0A=
=A0=0A=
Thanks,=0A=
Kamaljit=0A=
=A0=0A=
=0A=
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Dani=
el Wagner <dwagner@suse.de>=0A=
Date: Thursday, March 28, 2024 at 01:46=0A=
To: Nilay Shroff <nilay@linux.ibm.com>=0A=
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, linux-=
nvme@lists.infradead.org <linux-nvme@lists.infradead.org>, linux-block@vger=
.kernel.org <linux-block@vger.kernel.org>, axboe@fb.com <axboe@fb.com>, Gre=
gory Joyce <gjoyce@ibm.com>=0A=
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node an=
d print error=0A=
CAUTION: This email originated from outside of Western Digital. Do not clic=
k on links or open attachments unless you recognize the sender and know tha=
t the content is safe.=0A=
=0A=
=0A=
On Thu, Mar 28, 2024 at 12:00:07PM +0530, Nilay Shroff wrote:=0A=
> From the above output it's evident that nvme-cli attempts to open the dis=
k node /dev/nvme0n3=0A=
> however that entry doesn't exist. Apparently, on 6.9-rc1 kernel though he=
ad disk node /dev/nvme0n3=0A=
> doesn't exit, the relevant entries /sys/block/nvme0c0n3 and /sys/block/nv=
me0n3 are present.=0A=
=0A=
I assume you are using not latest version of nvme-cli/libnvme. The=0A=
latest version does not try to open any block devices when scanning the=0A=
sysfs topology.=0A=
=0A=
What does `nvme version` say?=
