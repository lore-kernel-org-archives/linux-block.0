Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806703290AD
	for <linux-block@vger.kernel.org>; Thu, 18 Jun 2026 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763648; cv=fail; b=cFFJcnudz1T8N45ukRgNwns3BZedSStbDDzICGnSR1UTZJMzP1oFQyiY/Is3/0tNIOY7Fle4jnKtSK1/bWIvMQAYMZ1vFKKlwipl9cCLaeXsrx5XkCD21fwdOMDxi594sk4icfmcXJQGLbbV5q+bCTyKyS/QEUO7Uj+ehYR4iL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763648; c=relaxed/simple;
	bh=1xV+4IVKGnKW6Iu91Xtfx8dM0aQRVB76q1DgNliMV9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q+NKIeK6/9llxgkxbziA8D1vbcKy2maB1P+9/7FxkM5kexWkb7E6PH7Tlb82awL4ahN+KaFIEtcVw0vwywff+d5mwxIBUWu1mIhgXosdMF3lslz+2310OBn+o3Txt2kxOYJ3TjKO1201CPNwic52Hg2JIk9rzB5P8u8tJUdnsPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Yz2gFSLw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LVXeCgKI; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yz2gFSLw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LVXeCgKI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781763647; x=1813299647;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1xV+4IVKGnKW6Iu91Xtfx8dM0aQRVB76q1DgNliMV9M=;
  b=Yz2gFSLwEK5wjJB+V2G7iyOOlXJUrboZt2mpt769oyw+FEdV2xh+yUds
   u92uQ2ISnjChONWgf5CftNuZKZEDPma891Ewb+vvzjH+4QrQXujG+ZraQ
   RpZaGL9kZCb9nk+BYMhT5xWiVllc9ric3X5Rs+V/gSI7fiUs3GA2JqHg/
   o7FDZ3E2+/TJuHzZcU/EFb3WPnflKRunfb7gDReMrrjEsuyhvY9WYZ6EH
   1WcSW6U4kyYzPLhmHjshE3jDCpHKGypz7uzaC4o8KA+CQz/ilTSWX7FIK
   dc/4x73vuDW4PL4RxOnOQwAhuytT1heAnRKaaoxGTambFBnSyT5zXXcuF
   Q==;
X-CSE-ConnectionGUID: HNwNujv0RxejjC+yFco3pw==
X-CSE-MsgGUID: znTYlezESEWIsMfIRvfi4g==
X-IronPort-AV: E=Sophos;i="6.24,211,1774281600"; 
   d="scan'208";a="145249675"
Received: from mail-eastusazon11012017.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.17])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2026 14:20:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoEYM3WCSMcOqeN5BmAaU0jGUqAnLXcUvtl46g1MDAgu1GQuRr5nClhnoZyPxZwzp+KCJpa859JXPigtOyZmANUhkMaXqLPKtr5GZ/cS87yAk4dPh1hsBJUN1GEVGfqEjCIvymck5CzM0KTSQK0rq5TG3t9hczUozj5YevTevSIIeSc9Sq0c0UMeEfwToQcadGz+lSwyM1JkbDwiwmzQRlacVOBgO5WnlxK5TWBe0DcXRQTADXQqTOW5bktG3v/sWXBOOeE5qe2h5QBPUT06pZuFKfQkEH8VQ1y4orAnz8Lv9e9f5/E+FIyjiTcKhRhmCCVBWbiaA3MZ0T3004QQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xV+4IVKGnKW6Iu91Xtfx8dM0aQRVB76q1DgNliMV9M=;
 b=uOc6htnEOmq1YVSwi9cqjv4JC5wug2j1dLbS9Uch12shKkGlAjDFy5V+F+mrcn1OVMPZUrGJA3GGn/oJfHVuQOLZRhTIOoTU9cc9ppYR2GpGL68IbPgP/6Zaq4wagXEr7lEBzxFSxLsR21ZVh5+s8RcwrTv3CcCQBH2dXVy7ndGkf+4nIzXMtUIoVc/i4CemWZfIlRqhv3EZTJ5qz78+qwqXnRgTqBp0ss2RmRQFVAM5tA27m5XgAT1KDyMv+jdKN1VepDFhoVB31hOZFDB/Ei+1KUnuGom7vIdkSPghOKJiQdWISM6uoto/optxdGtsKptDreDrQfjIwdfomp9IxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xV+4IVKGnKW6Iu91Xtfx8dM0aQRVB76q1DgNliMV9M=;
 b=LVXeCgKIhViJqaK6CdzMvmrMyyr28FtdUbNKX9lgJHqhixH91fwnSMA22ZryE+8G9vT9F8iVUkTLJtxEnMFyCelnKJleiuhLqBb9XiRJnaHevnse6VCslrU3ZMEgCpwQ77Xqs+7JrjLKzrLb8gowrhlBwoiiXSVSvuhi/1aT1tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB10191.namprd04.prod.outlook.com
 (2603:10b6:510:3be::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 06:20:39 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 06:20:39 +0000
Date: Thu, 18 Jun 2026 15:20:33 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-block@vger.kernel.org, 
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH blktests] ublk: mark all tests as QUICK
Message-ID: <ajOOHDmLhnrF3l7M@shinmob>
References: <20260615094144.13060-1-sebastian.chlad@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615094144.13060-1-sebastian.chlad@suse.com>
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB10191:EE_
X-MS-Office365-Filtering-Correlation-Id: 30437475-dca5-4d32-4bab-08decd01b78c
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Nfnl9JipgaC2M/Zb609w0/TOxYn8VS5YwjOu5jmm9CKDW8bz24FcHI/4Jvulyw4O7WYee6wuH9iKi3cBvNUA7T1JeXe1OCs7NUBrFpCvymbHZaWeyWg0mkXChJprzq9QMzHPSWjE++JwBrIwAy6axvwfFhsQAnnARGJKtQZc/RaCAhZKnA+vzANTWErdrMNR6Q0vya99Ou8KW1h/xuH1ZtPV8M3/5a2ZT6Zp0AbW0eFqsKOEzNnjAcUosEARFIsjSwAdwYEaSNjIIq1WZ9BVcIdYj7n0irjTq3ueJiEEhLnkbuJvly5LVcFAv8Ym91qKwWIP5SjxsTSy/x4kFyijduVlUjVjoAnm8dTDr3R68PkfVIuHAHzxOSoNBddODhF5uibXmkOrC9YWv27vYosXtUNM2DBdxRxRRM6HnrHUYE5ZLgkw2I+2uFL8pSmGPwsctKD8Eamcpud1iIH4/TnJK2qNKKDdJ5ShsNQ6CQW1DTaTkLM4yQ78Pxy5FMsMmahwVtnS8nNARozKkF456FEGZqv9xeCJczUolTRXX3SKiKGiujVStk8vcmplTS6/+dG86Nf9/Lw4HFuuqyFmHk7NQ3Qx1XkJ/9eqk5cVayhZdb56qxWhzZXYA3zrjLYy+tJmFQbOJjWJq5UN4ILRqiSn5VXHpC0M7Xck8QjG4EvhsM9iPQQLia9ZlddeF00bxklp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Og+oG5smXOi67ms+ReYseR7xzVVpJbT4HGyRWjG1XWfq6JfNBxiEZtNAWyA?=
 =?us-ascii?Q?x5ZWOM/ViZ+b5BK4QJlS7oWp5xOMeh2Vrr4/BZjvIYPiJK/WxncyLiXuF5lP?=
 =?us-ascii?Q?YKwLkhahjItsAePZn25tSLfHrtZ9Edhq0jrbct7kl36k5XGB4O12R4b9XJja?=
 =?us-ascii?Q?VNlxotluWqdX8rLNSh0D4hqypfbKoo4/3fYza/ALkJEix4KKLDdBifJmXofK?=
 =?us-ascii?Q?8sC9IGjDj3hIYT9DR78aFi7Lw9CtputUc67FQFgEKy2FidaKc2HZoNb6yeqL?=
 =?us-ascii?Q?J6Rdi75yNfBa9mMMOXncv+6p/2b7Vvwv+MV54QhdYYTPZgFeIsZdbEm9RLRw?=
 =?us-ascii?Q?9u66FIpUyKgpnAjLwrlHElJSjYcDvaLHvTZOQgnBeU4q81j3+KA5wzALOW7v?=
 =?us-ascii?Q?mPYuTiwEc+yC0Fv/moKeOuV8Q+EGRgwHCe0p3+w8phtGuuiRWpB3ioVRYOYN?=
 =?us-ascii?Q?is4SDvVHrjwNrIAofdxO9UzKVA/5WHNYADfwyAOnh8Imgig8UPK5tbrhGsFZ?=
 =?us-ascii?Q?9cQ47TO0QVF3TC4lRR0sN4zrXqaGaGuX1V8KMhVWSx6x9mU9YnlmKEeavB90?=
 =?us-ascii?Q?sdMecXQ+XDfNc7mCtRZCh5Hw3I2K2qs5a6RNnuT8nprfiaQ6Aj5i7bs3UD7X?=
 =?us-ascii?Q?doDZJNe+L/89QPKjio6TdqQgvDdaGgogzBy/cRXPX59rpsoVZ60zIohA/OPg?=
 =?us-ascii?Q?unMdh0TQ960PUf6ZDmCqtbIP2MMPp57JzEKwggI0q5H6Pu+frC7XYcgZbGTA?=
 =?us-ascii?Q?5/Mz/BwznCnFEenmqMx6dBqhTutbVhcHQJdy+qQqMs7D/HAwzIBwwJIsr2/a?=
 =?us-ascii?Q?fmSlq9YRDkW461L5AUyiErgNxWoU4RgMdccVe7XInG+9E43mB9ryBKZr6qH/?=
 =?us-ascii?Q?0vae+QyHUK0jecPeUY63dCeGvsQ/SZZEnxnIPNo+S5AK7zDB+gzGAgyL1wFT?=
 =?us-ascii?Q?WnUGtVcIzxB6g3/RuUac34+6uxO5RwVRm9xvWMc1O/LaxQhzRjUJDmVoKikt?=
 =?us-ascii?Q?XvpfHWcTgLhTaYcFr4/lDg+GOlhdkt7E+PqK4wIBt/GGpncFIAHC9izpnpY5?=
 =?us-ascii?Q?DxzU8eaNHDHXN9DKQ9G/P6dBsshyOQ8BtZUmVO4XEJq6fk8OMjEVwP/0Z5zv?=
 =?us-ascii?Q?L85OfC0UIswFS0Jya4I6Iuj9Uv72FGWJGsAysyfbB5L6bDu1p/DxKJKsuTB/?=
 =?us-ascii?Q?FYBvTygCLPtFDWd8A+BPUwg9YOpBPFHBjlkN3Hl1Ff3zmqzJqZMw0JQKEy2Z?=
 =?us-ascii?Q?2NbhCY/La2N7DTc6y/QFqY8IiqnIL77KGp/tK+6EyBeCr+p0e/e/xMHIklfg?=
 =?us-ascii?Q?Hb/xRoRbuAQ/8Yk3stbLfW+4P3dCogJ5MWPtlZOhDy7Z9RfKPMWk8/J9stwh?=
 =?us-ascii?Q?l7Vg9oq+tvsuJ3t7gEuWIaECI3HXTeOHa8Q4aO1Vyux5Xf+i0uYmUfh1Y8QV?=
 =?us-ascii?Q?VlWyNbOdYB0FlIL69N/N6WOp8NOeRZI3mGPyxi6HFm0eoq6FBuN5TTK+BcSS?=
 =?us-ascii?Q?L7IlhKNbOoXdaebCH19BcJdeZJdmhl1s3WpPWeXK+fob7wW2fWHjpexbeS1w?=
 =?us-ascii?Q?nigc2FMbrSitW+u2yGNMNocV0510GotNAzVtpozKxvXWciz62ZPxys56FgvX?=
 =?us-ascii?Q?96L6lKZ9NxmtNud+/dVpMMA2dZ5w0sGqekabzCtkvDvUDAP+NEDSnQq801IQ?=
 =?us-ascii?Q?NRIuLp83gQR0fWup3CL1L9LVK5K8t9aAMp7J3MUAtmd6CY46ZrXL+VixhHmp?=
 =?us-ascii?Q?OXv9Priv20KOofZsXneUep/YmfbuZmY=3D?=
X-Exchange-RoutingPolicyChecked:
	bAOnJOjWbMu+ynSqLLTjL7oZZ0pWGtF7jpNlvlfPWOt+HRNqoUMATF9m4DwNl8soBv1+BqFi3C+1uPvHBonDKaiXS6KL0iC7eskqULfbXypFwdRJBUdwzj76TXRlTAbb8S6MLM/ffUtsXiX9r1Q7CB5sdkUSLs2oCzNYT/wiAmok7sIOYUbSMZkbGRXNltQSgPi5795ggOIjX3VqXKUk5VD7jW5WmnG0s2WwpD09VirD4p0q0dBAm8ijji7KxFzf7qzZgQxCGdd8iubEz4Kr++Eu9glHyCaKfcNnKvzZJyNXoF5nlvC0JxX/iokvbHcDixjLCo+pQJUT8g9XBLWBqg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W5YufcPALJM0r5Aixy0BigqTeVyeeXK4hOTqT0IjW2/7PQZx50XrKTB6Oj4ze6IFMCBUz8cGkuJUFTDDAQnuQPoo8FVkm+Btvv3W2VHaFGkI8ktv9CIqy+LysJIfax62uqHqGcjylgVdvKg050LSZj8dbx6Cg9f1YE+Y4D0yu1lRqUmxmMZakh1+pgb7CH6Ma6viv5LqWFwcQKUxEGGPuZ5hF7mxikPkw5NZIJFUy3GrYzR8PyGKf8ris4gEpponzW54hitpRleXFKAshP8Q2no8VMxitcBMqIzq6iNe236ODv+tqogWRaDIEZEPRdGxAB2R3Q8v2/1GTf5rlVPfw14VlECNtmOj3kYQtdmxfcJSVLm/W/XZkt0wMBBJeczEwiU0ksSMqMLdUL59S3H22NnGaUAuIGdPudGB3rQY+nzfieMsrHglO8Ixy7WSAngYquX8/UXzbHq1f2k2FhMXeljUK7ejVM1lo6scRAdEe+2QJfw3xsaIkIjvp2vnGEImxfFisuOlkbatlZP93L1s3HppUfc7JVVU4/K/O+BAwb2hNdm8Z12tVmq3RKxzQuDuudm5dVr7KDzFZdCdkLxF8BKno5t9kmOkX1rXD/P9b6NJnnDdIi1fmvE2BYnESOqC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30437475-dca5-4d32-4bab-08decd01b78c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 06:20:39.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIgDJFrjVb9LdN4yYWcGCAhAR0QfEVVngtnr66/tFawkPUYybzC9D1rkSIyPdJRb+B2O3uORyzgKjTde9Bi2FCFL+Bv3EohIqpb4Qlhm7YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB10191

On Jun 15, 2026 / 11:41, Sebastian Chlad wrote:
> These tests are quick to run so mark them accordingly to ensure
> they are included in quick runs.

Thanks, I applied it.
