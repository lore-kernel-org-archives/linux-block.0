Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D949DBAA;
	Tue, 15 Sep 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474242; cv=fail; b=DlddDQG8XDymLui+zro2c4V8mRdQsmgUW1u2SMEDv7bM8odHpWlTIqqS4fb3smvm2vJVyQboI0VdV98J1Fa+QLHI/hUDgjqltSwcRRYHoPmz+tXBT1j7F6+0QRY0jS5JAgXku/gC9McJZ91xqnnt5hHjab/8Rr+hAT/8/K1W31o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474242; c=relaxed/simple;
	bh=yawfY1nvn02XzaGyda2urTzmL195pXH7Xe+GldLasMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dFyuwEB2jeWubaIdOnj+74l7G74BnJDwCzvDJ+xcwFcIQUa1kgvc2JaoFvS/JXKVlk79lcvS0yuw/b9DkqriE/K0FdxeoslSYVazmZfftqsLDQ5OUw494vawY5lPiE0QlJeN6sDgkdfHOc1u4ase5qTPYpHF41ee0567WYncTlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QlC6cAIB; dkim=fail (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IxNuemk3 reason="signature verification failed"; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QlC6cAIB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IxNuemk3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1789474240; x=1821010240;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=yawfY1nvn02XzaGyda2urTzmL195pXH7Xe+GldLasMQ=;
  b=QlC6cAIBviVut/DtMvjdpgmNuJ2/Y2hXGdhRwiV1DhydajgjlLrnlBrb
   hDCTfYA85Bii/A5dfmRXTH5jOtmfCo3l2CJbNV0cCB8bdBRIcFlzwSOO3
   /ZiFFMa+WFz4wpCljaPOt3gv+zVTTo5QuUzPblATAbO41KsMRYyKdFFjf
   KTQmGqHUi+a3OXd4p7QTFtkU7ybP+YPIc8YX7AJDiT+P5PrmsDwkMExiF
   KSpEcbgqnD/eulioX6sn4dDJl14Jlye0OHFqKB5ZCIQf2PadzJUDoUPrm
   2edAXFkPs7zqjPDMwElmgLofvIYDYuja9ZjkABjMkU9j4o+9tCInojWTd
   g==;
X-CSE-ConnectionGUID: eaNQAjDdSzCsCvvF9xr5jQ==
X-CSE-MsgGUID: HAQqAjdlSmaOYoWe9S09EQ==
X-IronPort-AV: E=Sophos;i="6.27,103,1786982400"; 
   d="scan'208";a="156639352"
Received: from mail-westcentralusazon11010050.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.50])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2026 20:10:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUn/T4YEU4beEBaV+vKWX3ciPOGRsGzBx8SvEzBK/IhOxf9gm1FZCXBLUVVxV39orkiW0R1OgW3mHD+R+dVmcOKOxcdQeQMfm4kqbAWzoNCNAobEXcnnV2FoYLXi6k74Og11INZ1Bd5DL7Ar9Kxmc/YwomCxHWDKYKjQ+B64XaPohQlwCJDvZzxxUgaM/Y/C5fbDDeeOhwm/ORPO8keAza6Z+5hO6KBw7yhXk7NvVWxCTK2sOvfQVCKNU+BCMGzgdnac6OCyt77I0shgyNicvyDlxrkmb5ipqedA/Xsx1fze7A7SIoTiVUSdKwRw43ZHjYDrT0h534Mfx5lPxGxJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJdtsqbjguDE7jIR0UzpTyjUOqi7BmkZ+KROWWHD4ps=;
 b=cb3CIqX0gSDk/Of0Rd5G0thiHPqOkQzIxpDjfwlS7pl6DqOdAR9FZyYJujj4WoNpOqSlbQ6oytYuC0oP1hB6Q8YHinLJIYL91rkFGigJH6Y8V8aDcs574iL5v53uueNA87+QhIhq1v7ucATqh10AYZiR0ZTWnRaTiRm4ufR9rEsQfMg0Cm7XIUyHR96M9w2dTXftH0F0lda4DwiFBq5OzhtS1JvSC1mgeSDhI2zDJcOjzjkV+4BD6CtTPCqBw4BqN2iPveEbxthIIJ53+7ZKtC3XSmWACG6Zq28oetNwbwLRDPnhK06yWU56cvD78s5zaV47i3ZfNwVjcVr8dW2kWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJdtsqbjguDE7jIR0UzpTyjUOqi7BmkZ+KROWWHD4ps=;
 b=IxNuemk3suHxj0tUlnbfBZxOnQXN0JzA4XWAlYQHIA2bdfZhAjcKaMfrjQSS1bo7PsC86Q59LcFbV5+xMvaNBmevpFWie1gd6VPUgPgOxwJjG5ewDA+cQoo+yKftEojcGwsnH6W9y1qEFE6QCabVeQqnOhVHSlE1Ghjs3PYzOSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by LV0PR04MB9837.namprd04.prod.outlook.com
 (2603:10b6:408:333::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 12:10:31 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 12:10:30 +0000
Date: Tue, 15 Sep 2026 21:10:25 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: =?utf-8?B?SXbDoW4=?= Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] block: brd/loop error-path cleanup
Message-ID: <aqk007eB0RIUuP6D@shinmob>
References: <20260831152044.166353-1-ivanrwcm25@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831152044.166353-1-ivanrwcm25@gmail.com>
X-ClientProxiedBy: TYCP286CA0257.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|LV0PR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: b20e32ca-5620-468c-31d1-08df13225654
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|19092799006|366016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+zNTq0oPs+SKR/z6/518j4b03FTTr92Pde26MHY37vqcgP9CpXQFjSqHrSVymktn6T/C/chGEMnVzvwkW0zPG7NcqCXGTIVrLtusvbFErUFP9T8TREUdQMy5U2W6NqOwr8pqTma+WdviMIxjNuucMTqiI4hnyWN/F0ksGSCkmLBk1LAx3HAr6kGwzRjnD3C/IZ6aUFcLr7H5/tgP1NWs7I94bnpfoWRhQ1wBvdP0lfzuO9fGOzdqzwZ7axowg/pYBWS7Dt2pGu0MXMmZssoBK7pfHkmT2JhFxtovuOl3I8WByD8QQ9Baj6+cGdj8oJhOkdoyV8cPQMR3Boly85BXBy1DklD+Krz6Gv0Sx7I+Skk1jfqG8mTFFHYun/0FWaGP2u/CROQrClTkdafyBWVkrsbsZbKBocvKHaSL5GzU18muF///le6gi/Feimol4cb7hWn6XWFAAoR2Z2b25fKwe3e6O9dYfQBsjeqzTHbxCOxrJuc4hmfAf/8ZjspQgLbgsZM/gs4hcRkVXR5Wa6+UM+2LhyASNw7KbPfasqtg9OVzqHqprpwrdk4zliuCgPuvzGOOg4slB8RZUk1BfhmaLg+oj+0AkY6X55AJDDUUxutYEBLRqxyeFnnXoYDIs1fZoopASsUqmmrycUu+tMc7Z+82PxdXYacOTSE1swnrhLo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(19092799006)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?tt/PlbXGPMgXCvs8hIcdYdmBGQfCECBJ5PJaXQVcBrHZK7KE4R31d4dkd+?=
 =?iso-8859-1?Q?ckh9+e7kTd6YfFZqC4wEN2p9Djdm9wxAtK3SCAKMFWs+xjsi+5SM6mSrpg?=
 =?iso-8859-1?Q?1/4et56lyv8Ude0mRApc5IhIK1Wu19zk0m0oIzJN9bCtTTfs7ef3psfnJC?=
 =?iso-8859-1?Q?wzjnhBJouUyof8M+EIAAnFygismX80f9MqME8Ge/0f1qGGQK6DXqk/OpvN?=
 =?iso-8859-1?Q?YH0/vCJPzI8B/LNDrl/WSyqlQufZ+PhqZsk6gB0jed+UlS4lZ8QtHR761C?=
 =?iso-8859-1?Q?Wm4PN/4fsJnl4hKsQphcW04nIbzhl4pT08ni8m7OZ+Axah39HM0ursV7rA?=
 =?iso-8859-1?Q?PNG0Gz/mJ1wLnbRgRW+t3FSSnxV1p9Yqpa1Az5ET9+AmsQJyzLrtabYD96?=
 =?iso-8859-1?Q?xR+x8D96MyhQsSNfFOt58a1Jf2a9ymCV6H16d2kKB1EdKZ2E7lUGF+xBJx?=
 =?iso-8859-1?Q?5CLJ046CwLXPFQBtS6VG5w7t4scvCVompTG3hsUJ/tD6p5v4mB4uhCT0Ul?=
 =?iso-8859-1?Q?aN5RnnNUCRhJqC0+F76I9tqXC4+R6ICQAlOdNJqutrmy1ohH3byq9biUwF?=
 =?iso-8859-1?Q?bCuS42LtJw8ngVEX/eEFzAWASf1Mxwst/q3TyFNHviJ5qKaApQk6ngtrLT?=
 =?iso-8859-1?Q?2RWVQMOuLfjrPXV6kXfHyl6GJuAQ3G37f3lejMqXvji/Az3hs2SDXhhNfN?=
 =?iso-8859-1?Q?lICP92m0S1fY1GJcFASMWB13uzKy+6NQ/IN3XDYTlnmqNZeLEitzhkpxpJ?=
 =?iso-8859-1?Q?fkQHECZKzYZeDGjLXXXt9cZPOnHZo2Jzv8eSXn1sgT986Qj5Ak58JejxHX?=
 =?iso-8859-1?Q?cWspF6itqKwlkWElTLlyLcEzGy7mT0W532kceEQvTgS3/Oe24SkTSTupOZ?=
 =?iso-8859-1?Q?Oo/MmhYwzegebaB31HyuXzkRqB1YpiDu4x0g1yNHENbMwGckEZtcwopy0h?=
 =?iso-8859-1?Q?OikeWytALkEBRXZhJTQ/htOTgZ1YOLO58hxelU+qZNqNEj9WvSocLqVBNR?=
 =?iso-8859-1?Q?Qj9NEXPhJX21C10mDoyX7c2NLUu6kEj2mi6CKOMvL9pyuP/pJ+KMf89oF8?=
 =?iso-8859-1?Q?ja4r5ZWjyiIPWKk4U1DKdvAItgv7slPg5mkamcbHfATyO+7MzHRMFiOi/U?=
 =?iso-8859-1?Q?d6wUkoRKef4heclaqllf6dGB8guu3K2qlgvgDVdwk9pDsmAyZeAnCBkpQf?=
 =?iso-8859-1?Q?LWEBISiGxLK/sdJQWprdGe2aMHwMtuxM+TBvVgfccAerNNmB+oDwmBuzkU?=
 =?iso-8859-1?Q?aSm6goEfLHUH1C2Xo+VTODaACF9PGw9+VMBBNlsnkxM26JCgPYfia+GBFo?=
 =?iso-8859-1?Q?OUSvTxfrc8af817dhKybF6YszYne4/zdRJrzgSBpSSNecPArtGwvH9YMu6?=
 =?iso-8859-1?Q?Kb1L1zPL8Ldy/oGlPyPNdEfpHbtr5aXdc130TkplmScIxHOVn8rCu6FmNF?=
 =?iso-8859-1?Q?bd8fc3IQx16mimsLiizIuiHvYV0AosOsGA6O9Yjtf0qDJ00mzbu+CbjnZC?=
 =?iso-8859-1?Q?z9kWTN4C5ixsumC61pfcV8Xxelsj1s6o/A1sua8QSeSL2Yx6rj21s8NMen?=
 =?iso-8859-1?Q?RvCcrbkFt5AIVNf6JRUxHWc2WeDjpvFYpJe/H8NnmzuvDFDbzfcIj6kzIy?=
 =?iso-8859-1?Q?YrMR+KbA1tLmVhH6qS08DypUEd7ASxqDu2sGpCi0y2DsC58k0vYmNnEvhT?=
 =?iso-8859-1?Q?QPOBVe1DXN8MgggR7RbPrR81KUX3PHePYVXClMaQWU7AZJT+ZiEG15F/a2?=
 =?iso-8859-1?Q?GTUQKU6P+eJPKj3LyGPR3xr/GvQNb7plugUW1dYaCFrTXuwl8XkmJ8C2bM?=
 =?iso-8859-1?Q?6kAaf49t6hWtNpvBqfLBmwlXYW3/kzE=3D?=
X-Exchange-RoutingPolicyChecked:
	G2DJkawyUM8mT/2IQ9/oNStAjakSZZs/cY3ecaZW4w6/Ty89eIo8RXOGYTx8Vt0K4mDJDB+b1AympnlM+LWbsT52+NexcetpV8LTFT1YNBDmHCxW86mPztHuyDCk3h0Kg4WK0kNbEbCUaHvu35+hFKx+80A40tbBXyXhJN18Wkq8lJsD8K+yHSBG/QxAy6LgCKIiTUIp4bCe9uE2XarVBP8pDA9mrbnYMoNHpH/8wJvg6bk1v29My1EW6VqL3cdk6SUJCvmo12or+RQqvh4OQ6VRZtRqHYfhDjitJ0u/O5HRC6nZhQ4+lPfbquBUpNBMc1T+JhSr5NvepZGCvpbs2w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qQJ+YWB1mCx8e0BCqEn0dPpc3V/cXqidC10VnLbXIJc+swkCKtj/LGTKGxwIdWy9/1fNuE71LwG34u56nYiTpf2iBewdUpdZTUx5ddLb6miG9mNFRDOX2jLOYR6+Ez/fBze6Itb7BNDtWxfPtM2RkD79KAAqUZ9bSj7PrNTp1qed6/5JSKhlm3+L2jfrBXXE1Vyn4pT3G+WNcj56CMF18HfOAELUI8ww7Umno0Z5+iJC0F15A7gWdJVl2o0rnMjmagZ17cBh3qwrCiOnnnNG8q1+X0lJAt4WzeHblAq7DYGGAnIvWuNsDocXGz9aKS8gFUOm8EgQyvh7W5aSms3RxVppsCu3z7MGnXL2uzoutuITn5d8fAILxIzlH8xubyCzYgTAqMiqBDbSI18zGtwL7LTwbLvtelN8Zt5CK+3fDKurYTabh+5njaEY+bQnFx+iEFAsDQEkr8VWDqUFMyJo3NW2UfWn5t0ZYoKoOqg5fW3F3OdLzs5nUlWuNvzPNW9tgrV5OTdEBt6usFTZnYU2vSsGsvTYODwZV+LALifuJDP/OirHoJeh/pjMCC6TXilpSYPzmxG1AOEL8lZAxk3xvYnkxL9zUvdZeQ5Or3H9zpnooeFtVFYMM2u+mLcgaNqm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20e32ca-5620-468c-31d1-08df13225654
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:10:30.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64/5EOEWDpRVY4bx/YvDflt1kLN7Tf+XXEFprOLw9UH75bVX6DmmnQXBYsUBjKD6W+J4QCOyId8vfxB9TJDqv7oIhCIPmcf6J1A5E2HGAf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR04MB9837

On Aug 31, 2026 / 12:20, Iván Ezequiel Rodriguez wrote:
> Hi,
> 
> Two small error-path cleanups in brd and loop.
> 
> Patch 1 destroys the brd xarray on allocation failure after xa_init().
> Patch 2 restores backing-file GFP mask, clears lo_backing_file /
> lo_device, and re-enables uevents when loop_configure() fails after
> loop_assign_backing_file().
> 
> Base: v7.3-rc1
> 
> Tested: built bzImage with CONFIG_BLK_DEV_RAM=y and CONFIG_BLK_DEV_LOOP=y;
> booted QEMU initramfs smoke (ram0 present + LOOP_CONFIGURE happy path).

FYI, blktests CI trial run caught loop/012 failure for this patch series. The
kernel reported KASAN null-ptr-deref as below:

2026-09-14T17:55:39Z {detected_level="unknown"} [ 3622.477316] run blktests loop/012 at 2026-09-14 17:55:39
2026-09-14T17:55:40Z {detected_level="unknown"} [ 3623.520634] loop0: detected capacity change from 0 to 6144
2026-09-14T17:55:40Z {detected_level="unknown"} [ 3623.530439]  loop0: p1
2026-09-14T17:55:40Z {detected_level="unknown"} [ 3623.633046] loop0: detected capacity change from 0 to 6144
2026-09-14T17:55:40Z {detected_level="unknown"} [ 3623.643002]  loop0: p1
2026-09-14T17:55:40Z {detected_level="unknown"} [ 3623.693612] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] SMP KASAN NOPTI
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.695495] KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.696865] CPU: 0 UID: 0 PID: 28463 Comm: kworker/u16:27 Tainted: G            E       7.3.0-rc2 #1 PREEMPT(lazy)
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.698871] Tainted: [E]=UNSIGNED_MODULE
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.699766] Hardware name: KubeVirt None/RHEL, BIOS 1.16.3-4.el9 04/01/2014
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.701145] Workqueue: loop0 loop_rootcg_workfn [loop]
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.702235] RIP: 0010:lo_rw_aio.isra.0+0x61c/0xe00 [loop]
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.703357] Code: 00 0f 85 fa 06 00 00 4c 89 63 30 41 83 ff 01 0f 84 f6 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7d 48 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d7 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.706843] RSP: 0018:ffff888132667a48 EFLAGS: 00010216
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.707993] RAX: dffffc0000000000 RBX: ffff888133df8090 RCX: ffffffffc0c78e40
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.709446] RDX: 0000000000000009 RSI: 0000000000000004 RDI: 0000000000000048
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.710897] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed10267bf014
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.712355] R10: ffff888133df80a7 R11: ffff8881474e6468 R12: 0000000000000000
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.713813] R13: 0000000000000000 R14: ffff888133df80b0 R15: 0000000000000000
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.715280] FS:  0000000000000000(0000) GS:ffff8882ac2cb000(0000) knlGS:0000000000000000
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.716901] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.718158] CR2: 000056307edcb0a8 CR3: 00000001487b0006 CR4: 0000000000770ef0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.719640] PKRU: 55555554
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.720439] Call Trace:
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.721189]  <TASK>
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.721888]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.723020]  ? __lock_acquire+0x677/0xc90
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.724034]  ? __pfx_lo_rw_aio.isra.0+0x10/0x10 [loop]
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.725232]  ? lock_acquire.part.0+0xc7/0x240
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.726304]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.727445]  ? mark_held_locks+0x40/0x70
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.728464]  ? _raw_spin_unlock_irq+0x28/0x50
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.729555]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.730706]  ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.732002]  loop_process_work+0x692/0xe80 [loop]
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.733169]  process_one_work+0x916/0x16b0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.734234]  ? __pfx_process_one_work+0x10/0x10
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.735361]  ? lock_acquire.part.0+0xc7/0x240
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.736485]  ? lock_is_held_type+0x9a/0x110
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.737564]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.738745]  worker_thread+0x60b/0x1000
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.739781]  ? __pfx_worker_thread+0x10/0x10
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.740900]  kthread+0x35f/0x460
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.741842]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.743050]  ? __pfx_kthread+0x10/0x10
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.744095]  ret_from_fork+0x558/0x850
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.745129]  ? __pfx_ret_from_fork+0x10/0x10
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.746235]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.747411]  ? __switch_to+0x479/0xd60
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.748422]  ? __switch_to_asm+0x39/0x70
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.749445]  ? __pfx_kthread+0x10/0x10
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.750437]  ret_from_fork_asm+0x1a/0x30
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.751462]  </TASK>
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.752218] Modules linked in: vsock_loopback(E) vmw_vsock_virtio_transport_common(E) vmw_vsock_vmci_transport(E) vsock(E) vmw_vmci(E) dm_dust(E) loop(E) iw_cm(E) ib_cm(E) ib_core(E) xfs(E) tun(E) iTCO_wdt(E) nvme(E) intel_pmc_bxt(E) nvme_core(E) intel_rapl_msr(E) intel_rapl_common(E) i2c_i801(E) nvme_keyring(E) pcspkr(E) nvme_auth(E) i2c_smbus(E) virtio_balloon(E) lpc_ich(E) virtio_scsi(E) bochs(E) serio_raw(E) qemu_fw_cfg(E)
2026-09-14T17:55:41Z {detected_level="debug"}   [ 3623.752350] Unloaded tainted modules: nvme_tcp(E):2 rdma_cm(E):63 nvme_rdma(E):63 nvmet_rdma(E):63 siw(E):63 nvmet(E):126 nvme_fabrics(E):126 nvme_loop(E):63 loop(E):28 ublk_drv(E):2 null_blk(E):47 scsi_debug(E):56 amd_atl(E):1 edac_mce_amd(E):1 bpf_preload(E):1 [last unloaded: scsi_debug(E)]
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.764501] ---[ end trace 0000000000000000 ]---
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.766235] RIP: 0010:lo_rw_aio.isra.0+0x61c/0xe00 [loop]
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.768862] Code: 00 0f 85 fa 06 00 00 4c 89 63 30 41 83 ff 01 0f 84 f6 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7d 48 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d7 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.772272] RSP: 0018:ffff888132667a48 EFLAGS: 00010216
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.773285] RAX: dffffc0000000000 RBX: ffff888133df8090 RCX: ffffffffc0c78e40
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.774121] RDX: 0000000000000009 RSI: 0000000000000004 RDI: 0000000000000048
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.774942] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed10267bf014
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.775743] R10: ffff888133df80a7 R11: ffff8881474e6468 R12: 0000000000000000
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.776634] R13: 0000000000000000 R14: ffff888133df80b0 R15: 0000000000000000
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.777789] FS:  0000000000000000(0000) GS:ffff8882ac3cb000(0000) knlGS:0000000000000000
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.778601] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.779448] CR2: 0000555d8efd7d5c CR3: 000000011ecad006 CR4: 0000000000770ef0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.780308] PKRU: 55555554
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.807921] ------------[ cut here ]------------
2026-09-14T17:55:41Z {detected_level="warn"}    [ 3623.808875] WARNING: kernel/kthread.c:134 at free_kthread_struct+0x10e/0x150, CPU#2: swapper/2/0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.812044] Modules linked in: vsock_loopback(E) vmw_vsock_virtio_transport_common(E) vmw_vsock_vmci_transport(E) vsock(E) vmw_vmci(E) dm_dust(E) loop(E) iw_cm(E) ib_cm(E) ib_core(E) xfs(E) tun(E) iTCO_wdt(E) nvme(E) intel_pmc_bxt(E) nvme_core(E) intel_rapl_msr(E) intel_rapl_common(E) i2c_i801(E) nvme_keyring(E) pcspkr(E) nvme_auth(E) i2c_smbus(E) virtio_balloon(E) lpc_ich(E) virtio_scsi(E) bochs(E) serio_raw(E) qemu_fw_cfg(E)
2026-09-14T17:55:41Z {detected_level="debug"}   [ 3623.812233] Unloaded tainted modules: nvme_tcp(E):2 rdma_cm(E):63 nvme_rdma(E):63 nvmet_rdma(E):63 siw(E):63 nvmet(E):126 nvme_fabrics(E):126 nvme_loop(E):63 loop(E):28 ublk_drv(E):2 null_blk(E):47 scsi_debug(E):56 amd_atl(E):1 edac_mce_amd(E):1 bpf_preload(E):1 [last unloaded: scsi_debug(E)]
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.827023] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Tainted: G      D     E       7.3.0-rc2 #1 PREEMPT(lazy)
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.829334] Tainted: [D]=DIE, [E]=UNSIGNED_MODULE
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.830574] Hardware name: KubeVirt None/RHEL, BIOS 1.16.3-4.el9 04/01/2014
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.832140] RIP: 0010:free_kthread_struct+0x10e/0x150
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.833455] Code: 75 57 48 8b bd e0 00 00 00 e8 ae e6 a0 00 48 89 ef 5b 5d 41 5c e9 a2 e6 a0 00 5b 5d 41 5c e9 d4 7c aa ff 0f 0b e9 3a ff ff ff <0f> 0b eb 94 e8 09 ae aa 00 e9 22 ff ff ff 4c 89 e7 e8 2c ae aa 00
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.837259] RSP: 0018:ffff888235108d30 EFLAGS: 00010282
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.838625] RAX: dffffc0000000000 RBX: ffff8881474e35c0 RCX: ffffffff815b9352
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.840298] RDX: 1ffff1102950ff1b RSI: 0000000000000000 RDI: ffff88814a87f8d8
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.841983] RBP: ffff88814a87f800 R08: 0000000000000000 R09: ffffed1028e9cca1
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.843626] R10: ffff8881474e650b R11: ffff88810012bcd8 R12: ffff8881474e40d0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.845291] R13: 0000000000000000 R14: ffff888100bf0000 R15: ffff8881474e64a0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.846965] FS:  0000000000000000(0000) GS:ffff8882ac3cb000(0000) knlGS:0000000000000000
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.848762] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.850254] CR2: 0000555d93a66788 CR3: 00000000066a6001 CR4: 0000000000770ef0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.851935] PKRU: 55555554
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.852983] Call Trace:
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.853983]  <IRQ>
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.854922]  free_task+0x12d/0x170
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.856064]  ? rcu_do_batch+0x349/0x1980
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.857284]  rcu_do_batch+0x34e/0x1980
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.858477]  ? __pfx_rcu_do_batch+0x10/0x10
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.859728]  ? _raw_spin_unlock_irqrestore+0x45/0x60
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.861194]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.862512]  ? trace_hardirqs_on+0x18/0x160
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.863746]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.865062]  ? _raw_spin_unlock_irqrestore+0x45/0x60
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.866372]  rcu_core+0x475/0x7d0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.867446]  ? __pfx_rcu_core+0x10/0x10
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.868589]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.869867]  handle_softirqs+0x1e0/0x880
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.870995]  ? __pfx_handle_softirqs+0x10/0x10
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.872158]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.873376]  __irq_exit_rcu+0x15f/0x290
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.874451]  irq_exit_rcu+0xe/0x20
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.875464]  sysvec_apic_timer_interrupt+0x71/0x90
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.876684]  </IRQ>
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.877505]  <TASK>
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.878318]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.879560] RIP: 0010:pv_native_safe_halt+0xf/0x20
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.880766] Code: 20 d0 e9 7f a4 13 fc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d d3 72 2c 00 fb f4 <e9> 57 a4 13 fc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.884461] RSP: 0018:ffff888100c37df0 EFLAGS: 00000246
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.885747] RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffffffff84fcb57f
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.887308] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff8173ec01
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.888869] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed1046a27cbd
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.890360] R10: ffff88823513e5eb R11: 0000000000000002 R12: 1ffff11020186fc1
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.891937] R13: ffff888100bf0000 R14: dffffc0000000000 R15: 0000000000000000
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.893633]  ? ct_kernel_exit.isra.0+0xbf/0xf0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.894752]  ? cpuidle_idle_call+0x251/0x310
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.895868]  default_idle+0x9/0x20
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.896872]  default_idle_call+0x6a/0xb0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.897917]  cpuidle_idle_call+0x251/0x310
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.898958]  ? __pfx_cpuidle_idle_call+0x10/0x10
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.900053]  ? mark_tsc_async_resets+0x1/0x20
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.901105]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.902195]  ? trace_hardirqs_on+0x18/0x160
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.903207]  do_idle+0xf8/0x1f0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.904069]  cpu_startup_entry+0x54/0x60
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.905039]  start_secondary+0x21f/0x2c0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.906004]  ? __pfx_start_secondary+0x10/0x10
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.907040]  common_startup_64+0x13e/0x151
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.908037]  </TASK>
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.908740] irq event stamp: 37826328
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.909658] hardirqs last  enabled at (37826327): [<ffffffff81917ba3>] tick_nohz_idle_exit+0x113/0x320
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.911373] hardirqs last disabled at (37826328): [<ffffffff84fd759a>] __schedule+0x10ea/0x1ac0
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.913026] softirqs last  enabled at (37826310): [<ffffffff815df2c8>] handle_softirqs+0x638/0x880
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.914697] softirqs last disabled at (37826297): [<ffffffff815df67f>] __irq_exit_rcu+0x15f/0x290
2026-09-14T17:55:41Z {detected_level="unknown"} [ 3623.916365] ---[ end trace 0000000000000000 ]--
