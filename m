Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8131E0B8A
	for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036537; cv=fail; b=jYr3FjHAjdBFrEBlhDDPDXtJYgfZ8cPI6MszFnY9N9ha2rxfdL3gB4wTmk0BgWE9dFIpJPgeK5KtQnpRAtc8cAirV7dyBZs0mfBvEo2+MrMf6MTnpyn3NTYH6W709dPgHaDwELVOBH/R/k6wdX+9EVdP7XSpUWYerWnPCtDIz2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036537; c=relaxed/simple;
	bh=qyWLhwUvab6mrn8ykwx/rQsCRoquCStj3NT3dwNJHxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R1M3gsiqDsimU35vJrq9JcedEJX39QZN2WAJMPOjrQeBlKhWd+R5aeKAD1BczBlVlWQGXGbVlLPLM2rU3JEUeXApkLEXyn70mG6Tgf/8p68tfpKuOwDPdGWfG+0QvTVMIrxuokhBqPpAH+Df1wUOw2SIFy1R1mn87vlpysNTjoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oTKehf5r; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gvQZMxQm; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oTKehf5r";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gvQZMxQm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740036536; x=1771572536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qyWLhwUvab6mrn8ykwx/rQsCRoquCStj3NT3dwNJHxY=;
  b=oTKehf5rg7O/N3Bs9dYsw9Xt5kGHhfeBjuuBpktSmTCx267i3kVpY7Kd
   ZGrdiB7mcxJpS66A9THem3DcaPPdENAcxHf2XZtkjdIS0k/qrQOseKd8A
   7vGEiTmgBC2MxjYYqFeE4JNnI2X6+75gaqMqxk1NFWO0vvzoUdC7UgOrR
   2fT8wVY6JcrBLoWB/pPsnSFqBmodGxBKbld1TSHtF60JIKw/sIBGvFWCN
   wQNRFEhThuniPNSSv4UwYig8izqsNG/qWmhKZt25fdbUx9b3jMqKuV2hK
   VnPiOHWLzEfwXZl5AB8TawfQEBAJ5JZGQlCp2JihkxqAIIaV/2jtTAPJG
   w==;
X-CSE-ConnectionGUID: R6v8c7yAT1e7IcamQPlDnQ==
X-CSE-MsgGUID: NBEeGlGpTP2c8t3ugT9CEA==
X-IronPort-AV: E=Sophos;i="6.13,301,1732550400"; 
   d="scan'208";a="38947295"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.8])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2025 15:28:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGAjkNZMo6uWCtf60BtH3upsrp9dphugVuH5WBd39VUqvv5Xl3qHRAjVSvjteEPpYYZ7t7kapdxDA1FC3OgVEeerjZtkmWE3chdoOEw9DX6s+fs0e4vsatAd+PUFDMnmms39D1GSNvQzCiYTv0xmgtkeH2SZ+iYYxnWjAgJhhcVEz1/Mr99wu/2A5FL3HVL72dhU/Fqc7yokpogoMK1r+EHgMPX0vePd+hccPEXK6WtVc4c4LaZFTMIpfVB1HkqjyX9F4gE07pt4SvRqdWofUuztqwTgrXzeoH9Y14S9kHUX/uXvhY/T5kl4cTMhH1nRXA/8nMiMqRbSA/aUTiIj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsFc9H6iQynPJDpUJPxrT5aRxHZErprwGCXlO1bQWJs=;
 b=djxI7q9AsTK+PeuPqG0BMrID6lh4tvAkxUdnImfsUilA0bEADD5YPepG5oUs0sAlUWFtaPoy0aU+VdsPPleqe3Rzts96EJxV0g4QNxE9ww9AkIfQg6CjgPnCeu7C2XsKe5sZaVY46T2jUKfNsP+4xb5sr0wck6CgKhPL0Pg24C8wpCu0XOiESvTQ4BxVWLn2W4phnSWZ4ptrYtHkRtqsytVA6YGka9UkUwzBA3uCNJz+610tJhVbRFF0gUjMlVmnA5Vw/iHcWH7hYvvbSxckKvU4UcZGonA8uneWN6DunmXqFSyGF7sfS7x7Cy1+faR1IVlXJ7sus2L9h5FmxQTOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsFc9H6iQynPJDpUJPxrT5aRxHZErprwGCXlO1bQWJs=;
 b=gvQZMxQm49/sQ1S2HIrLTUv6TTvyn6iLydWKcMPLeg/laCfQSwJAmS+XlZXRpwPV2IX+IlD9ZlFa+PPKFPtXjrFZZwmpiM0y43x0j0TihqZ5bVP2u72cG3FFtIXLR0YCNGGzCg3BDahkXMP/2Aww1Kbc77BZNZrIVvNNy22tOBM=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by DS0PR04MB8600.namprd04.prod.outlook.com (2603:10b6:8:123::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 07:28:53 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 07:28:52 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
Thread-Topic: [PATCH] block: cleanup and fix batch completion adding
 conditions
Thread-Index: AQHbgp+SxXMtnOmsDUuYlfs8n/vnWrNPAJaAgABg5gCAAGtxgA==
Date: Thu, 20 Feb 2025 07:28:52 +0000
Message-ID: <3hg36tdzaaqlelfk3rfa2hgpxbkfvq7qdumdeci6evvz5c2hfb@laahu7iiwknd>
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
 <y7m5kyk5r2eboyfsfprdvhmoo27ur46pz3r2kwb4puhxjhbvt6@zgh4dg3ewya3>
 <92239c7c-e7e8-494c-9bf9-59a855d70952@oracle.com>
 <b31cff79-cb81-4792-b700-b55a83637aad@oracle.com>
In-Reply-To: <b31cff79-cb81-4792-b700-b55a83637aad@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|DS0PR04MB8600:EE_
x-ms-office365-filtering-correlation-id: 85ffe4fa-7afc-45d0-d566-08dd51803a1d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2SGbk3XsqjGpylryyvJJWSsQkK1B3YwOwuRwtkeFe9GxMtQ8EGYwBd1H5Z?=
 =?iso-8859-1?Q?3Qp/NH1jABxUchGcn2K8ZqPc4uwknzdt3nxfrlTNrqbdxsgTAGJuONeXsD?=
 =?iso-8859-1?Q?pNjAcXP7t4vf0fEPUZ+7+H+bzDb6U4rW57o08E29Olw6w9i6pda6KW9IpD?=
 =?iso-8859-1?Q?1P+SkgbNS3/jDIQ3a6JK3wDjP5cWkd4uMxs2fHzMBVOHXX5xXo5CQHoxbQ?=
 =?iso-8859-1?Q?7JYqXig5kFd4yF6RZkkHmLkMLZIQsNOfQl4/VzCkchSrcAzfqM3indgfh1?=
 =?iso-8859-1?Q?XUlfNM1qrXpReBrsEMdSwSnYb12n11xCb0gUcV8ZBx/MpuVgQ0Axx3Q6bs?=
 =?iso-8859-1?Q?vhScDalSYlejEsP5xbsrAHOfJyHgStPznXx/KK5l7dF2AEItwFJ0M9KAEb?=
 =?iso-8859-1?Q?al8qelGtlWO2O5J9qvtNBl95KIe02QiUKiIFNmUENGtClGgo2gLvveU2j5?=
 =?iso-8859-1?Q?eQH9yP5sFm+moGvsbfM1boG0gC2OYac1PuFv5oT2ehMTAkflw0N+P6Krkt?=
 =?iso-8859-1?Q?cXB+HHxT7kx+LeNAfgmJ9PKvLLGbhKkc4C+iOAy3ncOhaFqURW92Ixy+o8?=
 =?iso-8859-1?Q?yI+6RdsXG2shMQdShYjGgJ9SiS040whUaEbPVfAnVBf/HNOI47jV5U5qtu?=
 =?iso-8859-1?Q?YNDhw3wbCCw2yu28gY0iPQbonXu2sB1p9rY7fnFQfWBJf0M23GO49my6PR?=
 =?iso-8859-1?Q?AxdZ+Fp5XKZugET5bgpncbRldb4zsaBtA0CNoadXqKm2GPAKbZoYH/2k9F?=
 =?iso-8859-1?Q?jMK4oBpPRJnYHlf9sObTIdHzcwEW/g/q9+beVXyn11CzfQxdjNWOz1KZiV?=
 =?iso-8859-1?Q?L/MDTNUvR6O8fK/eeNmcfZAKzUbd+J4DDHlyqOsxo46DWm309eOzWZaAdN?=
 =?iso-8859-1?Q?qolyQfxmpwK6hbKzeO4imvLF7DQs3FpPaMAtM7NDpwlpR+4dEhrteRhrZT?=
 =?iso-8859-1?Q?FsY347J/lyiKUqdbkU8ZGmmytLtanCozsdth6/ML+wdnLGC5khUAyX9eLk?=
 =?iso-8859-1?Q?VewFtCCTtNgXdkReAQjMo79AMo54E/A++fKKMHtQbUhndOksnb92tI6h2B?=
 =?iso-8859-1?Q?SVxDBMVKkSnBHWrgQTijYtfyvIN1gcqk7Rya8CPxE9uWGHV8990xl3rOiH?=
 =?iso-8859-1?Q?dcWiIhistix1vo50Yjy/iel58L1ubKMXVIhP4mGEI3efr3pwzgyEHVXdep?=
 =?iso-8859-1?Q?x1m3fYGA5Ur9kvaqXyBfVKtSG2eaAkJ2cfzUQDFsAdayrNIm+MgQ/DnJfN?=
 =?iso-8859-1?Q?M4PhJwWhByWbh3l1NarIFRlZTHov87Tj9OSVAnO/Bo9D7/gIIxX15x1WZj?=
 =?iso-8859-1?Q?Q7UL/7AhRJCicUr1NKCmUKf6pTOTntY5oYqHIRkCjL4oeA273LTqwU3h9u?=
 =?iso-8859-1?Q?L4+25YRLAAOHSpzBZFGf0Ej+X3i9yyZn8EZdb1CWLCkJQsbjubGtF355gw?=
 =?iso-8859-1?Q?TTp8WCRSPDR9C5BeXb21LyimYdbRY7sQDY9mlMNwRnBfM+nSHS7EIO6TKG?=
 =?iso-8859-1?Q?tq0eKrzUdVmHE/ucStIOym?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?QmCNJgnDGR935oNxfXwUgvJ2p81CvaGTXoo08FtDkGsVhStf5mM93H69h1?=
 =?iso-8859-1?Q?SBI3ZhIR16FTEHB3ITZiWOfT2+JFfcSOA2clcr39BMuCL446If8P6wV+zw?=
 =?iso-8859-1?Q?9ozzQ6BY3aL5KqafCd30vcxjOuhcu48W7qZiW/yFU+3JCSUf3AUY8RLGtD?=
 =?iso-8859-1?Q?VwKL34Prb9SQIGAN5maiSPDhOSpOiS/JaTY0SHLh3tshtjoQV8BvLaR0Nl?=
 =?iso-8859-1?Q?6X7FnBmSTKfXCyaJzw59w7bOHg/lzOMVr7dpTd5+zYpwLzWhTDgDAtM8nP?=
 =?iso-8859-1?Q?sTyiQmp31MbcrT9MUQpAfjGDYoFaUxZeaa/JuZFqc0lBhWAi+A5MLUhbU4?=
 =?iso-8859-1?Q?LEMi79BwaLmbpJae1a1h3//Jc3ELqC53SdeO4o0qG1mx/zh49XmzTa8oWQ?=
 =?iso-8859-1?Q?ltTxiaPq+C0xlpU6kSKt1goautANJvPlyhRVAr/mJSBDyqp1Nuk2K7k8la?=
 =?iso-8859-1?Q?QnN8DtSnOJ6LTcTiYnpH4b4w5LrBFLar12BRYR6Rc+5gmUxUMoio9zNx8U?=
 =?iso-8859-1?Q?vWMpPzvWF2Ji6EK8L6XPP45+QAEEN0oasbgl/0Ri/ht1k6/EhGJLcnPhoA?=
 =?iso-8859-1?Q?35/G042cYjeQdmQqPQ6JjPgnjcaKj+LWq9t/MwXYw1ZcKPJWqaPEKxmTDv?=
 =?iso-8859-1?Q?UgeRWd6peIn/sumiJyC1eBvzmWd3gBe01+CaekxpFuvdA5hiJP/7TGRkuf?=
 =?iso-8859-1?Q?iJ4bcPMToQ23atCjqncH4Fua6irqGO7mr78Btf1YY4n+WwxiN0mJSbjT7U?=
 =?iso-8859-1?Q?VD3fdHb5HVgpg4NvR/wSYmdJ72qbZ59SkqqLdKv9hS8D4tdtrwW8sOKFfc?=
 =?iso-8859-1?Q?GVsXf/k5FGQbZuDyl1Ka55O1JAO0ij9a0yZ8/RBOQEFMnYAUDAidL+88R5?=
 =?iso-8859-1?Q?PAEYvt9zFfbLnfd0Z9WIgsEyhdHu36GqEqwqCAnbHiSoLmLf4+alvXyNLP?=
 =?iso-8859-1?Q?7Lq2HxUz6x3qkP+ki6XWPh7TJGBfvjv+qNtgXrgo+IL5Dvl7w+m6NLBs1g?=
 =?iso-8859-1?Q?vy3vJ0z3SVKEIYYmcSvdlfBRZEShOqR9vjLU9UBtwUYhKXK4zfpDbRcs9x?=
 =?iso-8859-1?Q?Wt+e+Y59zkdZB8LQlCZa8Pj3d/qz74MMoRqAjcJaTVDXCW+NsKowwLBPv/?=
 =?iso-8859-1?Q?dOsIS710YLDEQBaZrFRcqsK3XAVYG1Zay9Z5kE7+3NYOgyZvxO+E5zHsv/?=
 =?iso-8859-1?Q?oFvHvDGHXAyKPb9mW7L2oNJBNWzt7ZeKU8KnGy1oRoKJK6Z7zWPKyqpX0p?=
 =?iso-8859-1?Q?SZ3+qXdPNG5tGMQZL9nFAlqApvwZuR47yZLat4h6VJrzSYp/Dkg/9L824F?=
 =?iso-8859-1?Q?kAqVpvpc+EQgqblR8/NaZuwuA8+AYhptxRMze4uh9Zih49EHETJ5WUiTwS?=
 =?iso-8859-1?Q?Ukl5uibBRqGU5P7Kqp6vXVIHSFIMhSnOw/oLUWdlo6DEp2OMq38G5bpHb8?=
 =?iso-8859-1?Q?Z2qmRTkTi3g66QXiOeJ6SETFNIyy68syCJ3y5wVaARHxQvTCEnbFjs7nVE?=
 =?iso-8859-1?Q?V/FOAw/a0RbRTWsGocSbwzf+9d43sF8O+7woZmkLM6egi3iBSJhb4/CzXl?=
 =?iso-8859-1?Q?25Ncbhf00E2zE1/WnIMWBdDrDJm8TalGDLDt6VChq3jojmn/CyWKTWsOTT?=
 =?iso-8859-1?Q?orBXvAlbMTBRDJ0AF2PdUAkELDTxdQsm1DLjZaJMNLEQRTm/ZV+dE8klUf?=
 =?iso-8859-1?Q?eC+REn5771TfY5TwZhs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9F500ACA990DFE46B0EEA7BA1DB17E9B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vGFrmZI4AE9m+Ofo0EF54JgwN8SmIMaWmk0GLRfrz6Qiazq317e3WGc5e+Ay7m5sDjpMCc7TnOktsT2s8SGhDdtFBurJXh1L5mzgET9E0Ejr+kV5LqwVF7XuSVDmd2XyiwcJg/o9GMoh6cOkUUvYZXM6eco9dDP/5fvX3/EWraZLV+4y6d7ixfVq0AD8W5sMzAf9x9uS6+hKUugDcXGVMn9/TY0aWk/MW3fCaTPY0J2DNUyLgSjZuyjAsUYR+ubRrNAxWX3SAcseAXPtJK9aClcBrYVCuNoafJqUc7F+wGVv/kx39/Ny0ohTNS+h6I+IXaJOgDL/V3cUvkei117epOlS/58nE4v4ElVMNdp5OhzGarFu02eF+yQJSXizX4cel3v+/vXL8wxmmnKw/mg8wjAefJ667BXGpy+S7N8ExvS8YAEKQuI/mnNGTWvqC9jnuMzykrl6Oy8UcqkMi8+o430pX1L/pEOpuCKvTBqiBKTOpE8m3DQwD140SumOxL5DYjauTb6Wr4LbQLHXJ7y6lOIMa3gs4g8RmQWMwA6+YqP8xPWBkRMgNH/jIDXOnJPR4hAopg2UXbqAlkQLQkbUdg4wz2/FFpoxIspfZoKVQKhdfY/y3LO0ctN3beNLfCxy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ffe4fa-7afc-45d0-d566-08dd51803a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 07:28:52.8636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yxr4kexnAF8MQftcFbdTqI4oESb5JWZCL9d/wiE8Pr10rmMJepEiKqw8SBZDkdn0dOjPkIIJcd6W/fBz6tbZASKsi6D801d3SglODwjFLTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8600

On Feb 19, 2025 / 17:04, alan.adamson@oracle.com wrote:
>=20
> On 2/19/25 11:17 AM, alan.adamson@oracle.com wrote:
> >=20
> > On 2/18/25 11:26 PM, Shinichiro Kawasaki wrote:
> > > CC+: Alan,
> > >=20
> > > On Feb 13, 2025 / 08:18, Jens Axboe wrote:
> > > > The conditions for whether or not a request is allowed adding to a
> > > > completion batch are a bit hard to read, and they also have a few
> > > > issues. One is that ioerror may indeed be a random value on
> > > > passthrough,
> > > > and it's being checked unconditionally of whether or not the given
> > > > request is a passthrough request or not.
> > > >=20
> > > > Rewrite the conditions to be separate for easier reading, and
> > > > only check
> > > > ioerror for non-passthrough requests. This fixes an issue with bio
> > > > unmapping on passthrough, where it fails getting added to a batch. =
This
> > > > both leads to suboptimal performance, and may trigger a potential
> > > > schedule-under-atomic condition for polled passthrough IO.
> > > >=20
> > > > Fixes: f794f3351f26 ("block: add support for
> > > > blk_mq_end_request_batch()")
> > > > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > > I observed the blktests test case nvme/039 failure with v6.14-rc3
> > > kernel. I
> > > bisected and found that this patch in the v6.14-rc3 is the trigger.
> > >=20
> > > The test run output is as follows:
> > >=20
> > > nvme/039 =3D> nvme0n1 (test error logging) [failed]
> > > =A0=A0=A0=A0 runtime=A0 5.378s=A0 ...=A0 5.354s
> > > =A0=A0=A0=A0 --- tests/nvme/039.out=A0=A0=A0=A0=A0 2024-09-20 11:20:2=
6.405380875 +0900
> > > =A0=A0=A0=A0 +++
> > > /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad
> > > 2025-02-19 16:13:05.061387179 +0900
> > > =A0=A0=A0=A0 @@ -1,7 +1,3 @@
> > > =A0=A0=A0=A0=A0 Running nvme/039
> > > =A0=A0=A0=A0 - Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (s=
ct 0x2
> > > / sc 0x81) DNR
> > > =A0=A0=A0=A0 - Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x7=
5) DNR
> > > =A0=A0=A0=A0 - Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / s=
c 0x80) DNR
> > > =A0=A0=A0=A0=A0=A0 Identify(0x6), Access Denied (sct 0x2 / sc 0x86) D=
NR
> > > cdw10=3D0x1 cdw11=3D0x0 cdw12=3D0x0 cdw13=3D0x0 cdw14=3D0x0 cdw15=3D0=
x0
> > > =A0=A0=A0=A0 - Read(0x2), Invalid Command Opcode (sct 0x0 / sc 0x1) D=
NR
> > > cdw10=3D0x0 cdw11=3D0x0 cdw12=3D0x1 cdw13=3D0x0 cdw14=3D0x0 cdw15=3D0=
x0
> > > =A0=A0=A0=A0=A0 Test complete
> > >=20
> > >=20
> > > The test case does error injection. Test method requires
> > > reconsideration to
> > > adjust to this kernel change, probably. Help for fix will be
> > > appreciated.
> >=20
> > Not really an issue with the test, rather the error injector is broken.
> > I'll investigate.

Alan, thank you for looking into this. Then it sounds that a fix is needed =
in
kernel side.

>=20
> The following change allows the test to pass.
>=20
> - The check of (ioerror < 0) should be (ioerror !=3D 0)
>=20
> - passthroughs can also have ioerror set, so false needs to be returned.
> This needs to be resolved.
>=20
>=20
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index fa2a76cc2f73..b2bd2ac40441 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -865,17 +865,17 @@ static inline bool blk_mq_add_to_batch(struct reque=
st
> *req,
> =A0=A0=A0=A0=A0=A0=A0=A0 * 1) No batch container
> =A0=A0=A0=A0=A0=A0=A0=A0 * 2) Has scheduler data attached
> =A0=A0=A0=A0=A0=A0=A0=A0 * 3) Not a passthrough request and end_io set
> -=A0=A0=A0=A0=A0=A0=A0 * 4) Not a passthrough request and an ioerror
> +=A0=A0=A0=A0=A0=A0=A0 * 4) An ioerror
> =A0=A0=A0=A0=A0=A0=A0=A0 */
> =A0=A0=A0=A0=A0=A0=A0 if (!iob)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;
> =A0=A0=A0=A0=A0=A0=A0 if (req->rq_flags & RQF_SCHED_TAGS)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;
> +=A0=A0=A0=A0=A0=A0 if (ioerror)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;
> =A0=A0=A0=A0=A0=A0=A0 if (!blk_rq_is_passthrough(req)) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (req->end_io)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret=
urn false;
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ioerror < 0)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retur=
n false;
> =A0=A0=A0=A0=A0=A0=A0 }

I think the modification above essentially reverts the trigger commit, so i=
t
means that we can not achieve what the commit aimed at.

I took a look in the call chain. Before the commit, the call chain was
like this for passthrough commands:

nvme_handle_cqe()
 blk_mq_add_to_batch() ... false is returned, then call nvme_pci_complete_r=
q()
 nvme_pci_complete_rq()
  nvme_complete_rq()
   nvme_end_req()
    nvme_log_err_passthrough() ... log is printed
    __nvme_end_req()           ... the nvme command ends

After the commit, it looks like this:

nvme_handle_cqe()
 blk_mq_add_to_batch() ... true is returned. Set nvme_pci_complete_batch()
nvme_pci_complete_batch()
 nvme_complete_batch()
  nvme_complete_batch()
   nvme_complete_batch_req()
    __nvme_end_req()         ... log is not printed but the command ends,
                                 then nvme/039 failed

Assuming the change by the trigger commit is required, I guess adding
nvme_log_err_passthrough() call in nvme_complete_batch_req() will restore
the log print feature for the passthrough case.

As a trial, I created a patch below [*]. I confirmed it avoids the nvme/039
failure. (As Alan noted, still I also find the check for "ioerror !=3D 0" i=
s
required for non-passthrough case, to make the test case pass.)


Jens, if you have comments, please share.


[*]

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 818d4e49aab5..33030dd9b76a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -496,6 +496,9 @@ void nvme_complete_batch_req(struct request *req)
 {
 	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
+	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET) &&
+		     blk_rq_is_passthrough(req)))
+		nvme_log_err_passthru(req);
 	__nvme_end_req(req);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fa2a76cc2f73..b891ed113306 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -874,7 +874,7 @@ static inline bool blk_mq_add_to_batch(struct request *=
req,
 	if (!blk_rq_is_passthrough(req)) {
 		if (req->end_io)
 			return false;
-		if (ioerror < 0)
+		if (ioerror)
 			return false;
 	}
 =
