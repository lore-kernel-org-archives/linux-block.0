Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E4301465
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184137; cv=fail; b=U5PHkbNHH3h8jpNUPRY0QnHpgqE5TYfZVLqAYT4vfCy0muNmShIX9gsVnDZUi+uxbra3EcbkdoO82yLBBlyibjYBWiWIcZZU6l4Cp1fPoDeWbbxZtXWy4VeXXgZHHiUgvfW9CvDi+EOykiix2vAjpFIOV3E+9lfqGq5rE3kyYto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184137; c=relaxed/simple;
	bh=p1hd5U1nCu6c32yfCyCvyH+VhLmJiEYJ3r8xQRZgDhU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TwrqHLMa7m+ivpyuScpFRIBvXrw5UO9wn5h3BBQVrHEjXXIxZHtK9tlPq9OQG0IQsiETFYuiReet0lWzwC2pLEL2Uz8OU2c6xZJxywgKvsTv8748dw3viivgI98ODy6CWHuB9jx3fD/+1ASmfKCXtU/IbtBVHK5iiUaKiwppwtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ktvcTu8/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yl/q+Ygp; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ktvcTu8/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yl/q+Ygp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772184136; x=1803720136;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=p1hd5U1nCu6c32yfCyCvyH+VhLmJiEYJ3r8xQRZgDhU=;
  b=ktvcTu8/MCcNEHyvNc9LJutD3DOmv37lUc+lDWHWz1N047jCAU7B1ZML
   Sek72O59kal6LuhqGDPp+yU5Li40GZJUx8New4+hUBq///JDRsz10l+yJ
   Zx66vvIU1NgDHfAmk2KuNh30RfP5Gg5pJgbTEfH1aeS5NFlL06Go7Scoa
   8V/lAWEGhzRVWoithpZFSc+oLMFlfOKJKU7jceA8wjlIl9aC2wqNtKl0i
   lJ7snb4uCQIb1WDWS2p2RVd/wfZt5New7KtJwkfTP1l5RGXBHjxGr7K3+
   JBTa775MisIXhTUKqzoe5flG185vTVtifVUFVtQ1dia1gMrTKCUTRTLe0
   w==;
X-CSE-ConnectionGUID: 8i4Fby0zQE6B5Jy+wmPt1g==
X-CSE-MsgGUID: Y+ZawUvCT/aHgIAVcUKkEQ==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; 
   d="scan'208";a="141190734"
Received: from mail-southcentralusazon11011060.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.60])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 17:22:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoEPVUf+bcYCF6EKsIqSWkiM5j8U7ngMQIJLNvOY6wg0CxFKi8XI2k/PKiVa7OHDxraFRGxi1EfhSHd02jcidrUHpV5cPOEabBiMdifdS/qTC9UszcIYbFU3RIHL6mertUxFxnwS0iNYlYW6MCtNgrqVz7YMZ9cGPFK3lgf92/FZKjBzV6QmfD10TjU4uNtBhJADJUPEaUWpqdaGvw/K7VTsDFEP+IDz8FJkdJ//LIyG0VJv3dSO2foCNAs5glw8c9EQMbIJgGy8X+c8vRhghKG0fBFBOfXeB8pb/EY1FeGm9HcFHMIoKknZaVtUPgHZ1O0fbbIXMJLoCFWNBi6wVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1hd5U1nCu6c32yfCyCvyH+VhLmJiEYJ3r8xQRZgDhU=;
 b=k7aq1teOtuFgvuUh3zdH7gYQJ9im49zWPUWccLffnuefk9AXNQLSBziArvmm2d6YH5vpkMsb41K9O9b3yMYmX5e8JPvtr+jFENQW/7RYhEvJ1r+oFGIwiNDmI/IHXR4i0R3RgW4dtWxndrIyQ+EDzlWwWRPpLKxGBSou49KOszhPMzOycAKcSObT2qk9KyoDksLD3cFpwn2f+5C1L/TDgwksKxjNzPEp4m7XaLxuN9rXFYjv2Qw4EunfYnmXoaub3k5xG3on6H+TOj00leJ/VSi474c4AfZWQyCqh65YlcdLJKxNFkudy+ivjPPrz+/fNUBFkPwutpinc+Xd51aGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1hd5U1nCu6c32yfCyCvyH+VhLmJiEYJ3r8xQRZgDhU=;
 b=yl/q+Ygp0RGyz7jS5B6JRvPoF2K6vvfIqd8d/qXtmYT7lq0kTxX8cZ+z//zYQFGlcGWjvxwEtxrYitOEbP9ijr5nffx9SRiIllbSOyz9QCuhgq0PTZ6VULU1kzNwmriuYQk3NI5m9lmBzisbLCkWfLoFfHUXhcgp1y52WF3aXfA=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA1PR04MB9827.namprd04.prod.outlook.com (2603:10b6:806:4a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 09:22:08 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 09:22:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] block: fix zone write plug removal
Thread-Topic: [PATCH v3 1/8] block: fix zone write plug removal
Thread-Index: AQHcp4w3Dd/Xln2ymkGQmxW4JcDs2LWWRf4A
Date: Fri, 27 Feb 2026 09:22:08 +0000
Message-ID: <70f59d85-932a-45e3-840e-a38db192719c@wdc.com>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-2-dlemoal@kernel.org>
In-Reply-To: <20260227014951.2327711-2-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA1PR04MB9827:EE_
x-ms-office365-filtering-correlation-id: 7b91773c-7591-4674-b24a-08de75e1ae2c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 UPgoDkqbFaT6c8OX/8kaU0oo0cnsB0iswNIfJKfTVllvLxk+2VvZ0sVq269pLmnaUGV3FFYYBfJFjaIm46tCg3Gm0TUioBpe9HwXMZUi5E7luQBJIRNfcd3ZaPCMDVqhPxqyzj2vpb+JucMDpPpyi2JW8zupBalcZV/Y2yt/+rPKjQRyJnfUYcZd6Gxm58xZ0aHmtB4kdA01AVlEyiGbnXDS2ccdxtap1XzbZRz/pZDAuMxDkTMupDKOVHDcyvXHRsHpSkVIW9E/Gx+wc34eI20XdCROiGhUYo8Sh3rYgdvpT1Qww9L6Wsy14MsJNwsAdZE6jLygNjmq2o6CIlklBezFRjoTC6klttggO+8T0QbEdaGrvdoSyS78aP+OzSPtLf0k3fvBYLP9+yNXGTPU0Ebtq5iGX+6xeW92puO5aE2qDBy88eAtrd8tnYdQynDt8qIYFr101gyLWKL6dQwxxfp6QP1glP+vDFjIHlNLnr1O1i+axI+rreGM6BtLxgPzZDOiCeSotLmb5LJnwLFf/Brwt6eMr38D05IqQlEJhV1oWB885r+lis07qDvR3AtTYQE8PDPwYf7mmSuckmz0cAzAbu9EtFKmo1Uk6L/eHVMjBs12Y2eiZIT8MmEo7/mSDfeDYr8+myjGW0IvsQ0ghslTPccOsWm7pyrdE85/pTLcXFwp5j1JdwLQDm7E5QKFUX/rc++P92ULIGsOa75qr7cRcI4ZMiEH56ocYfE5/0cI7+HeRTB0NTDUStfAzw3eiVVi81/s6NaDl7rKDdSKBvsLJFt93/duI9vuQKUh704=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDdWdmRCM3dReFY0eGdpdDhMN0REUlBRaU9Id1R5Z3JLS2xpWW1ieDdWSWUz?=
 =?utf-8?B?dHZyOFl6MjdaQlhhclBWcjVSU0dJdW1BNUJFNVlVTG5LalUwTjRWY3NGVmZU?=
 =?utf-8?B?YllMWmRva1dlUy9CNCswMUJ0RWJyN082cTB2TXlWQUd1dXlNYXY4TEd4ZFVX?=
 =?utf-8?B?TjlNZE1HUytsUG0rUG14Mk8wRVJpc1l0clRjYXQwdW9xVzRqSVFDVmpINGRS?=
 =?utf-8?B?UEdwQk9tMXZrZVBxcVpLNjc5emtNRXF3T2NVclJjZTAvQUtxcXN3ZytjQXRI?=
 =?utf-8?B?TWMySmpDRU5HUm5PMjhaVG4yQkZwcngrT1UxVys1TkJ0NFhoY3lvdnhyS2lj?=
 =?utf-8?B?R1Nzbzc1SGcxY3VlbjluTWx5Mk11V2poSVNxc1Bnd2pRRisrZkVod01wT2VM?=
 =?utf-8?B?MEM4TXR0NldiRElTWGFDaUpHK1VRaFBSWDM0bGhRdEN5ZVZyVzdpa3JKL2lj?=
 =?utf-8?B?VWdLbGNLRzdBOGRkekROK0Q0RTNRR1I1alBGZzBYa3piLzNSdTVjR3dLbm5I?=
 =?utf-8?B?WTRRS1l1U05MTnFidkFlUU1xMlpPZ2NrSFAxcmF4dEwyaHUremZML05nN09n?=
 =?utf-8?B?TVp5aHVYVm9ObmF3U2pkcmlKckFvQzNiZTFFcE1pYmhkWVN1YjduZDBFdTBn?=
 =?utf-8?B?c2ZQWEFqS0wyZHBCb2wrbFlmZHhPMEM0blpibWxrdXJNNVc4MmxLWlBuTlky?=
 =?utf-8?B?aDlINkNqOHM3TmhueTkvM2ZMb1YzTmtSV3lEWko4N1JrQ0RHdWxDMS9zeXZx?=
 =?utf-8?B?MWNIY0RCSmpLU1FlQXNobFo2dCtFTlR2dUd3OVIvYzA5cWRtZVFKMitGNXlX?=
 =?utf-8?B?c212VFhrcUFGd0U4YVFKZ09QMmxmS1NPaytGOWxadnFBVUZITGFpNFRyMnlh?=
 =?utf-8?B?K0tIUit6RmhvRzhKQWJzcm4zTU10ZFoxcE1sWW9qVjJmblc5aWZzalBNYldG?=
 =?utf-8?B?MmdzTDJiRHN6V1I0S3V1ZDdzMWZoWGh1L2VyT25QdTVmd1JnTFFReEd2STgy?=
 =?utf-8?B?M21aWFVTSmJyMVlPYlN2Zzd1eHNpR3JTeEZmQzdjMjdMMHY0c0ZwR3FJdDZZ?=
 =?utf-8?B?c0JMT0xoMGUrNGtxNWxmNDNPTFpuV2JPaGJBRks4OVZHY0EzUitmOVRaS0ZR?=
 =?utf-8?B?QWYrVnFaYWQ0VVhVVm5sTTRyRnk3bExDUDQyYkRsRjI0NXdQbFJXTXAzNzEw?=
 =?utf-8?B?Z2NEOEFrMVlZbTl3S05xeWpwZGQrRlE0STNOclpoRTFWZ2lDeUxqQ3FFL01V?=
 =?utf-8?B?bWVRdndqQU13enlGMGZVeGRyenpsZTBDWmFMcWYyMDY0bzNXKy9EWkVKeXlM?=
 =?utf-8?B?Y0p5SVl2dGlGb1lJcExTRWZuS3UrbnZ5R3lCS0duaXF4VExZT0I5Zk1ET2NW?=
 =?utf-8?B?Ymt6ZjhEM2NqdUxzSFdxMmZPL09qdkRGWmYwY3FwSXpXUTdaaWlaU1RKWW1n?=
 =?utf-8?B?djVNaWtXRytlMjIrL205MlNLT3RIakljTHYyWk9vVVJ2T0dndnlBRU5Pa2FO?=
 =?utf-8?B?MTdDUThyekN1Y09XSTlRL214Q3IvVUVodmQvbHlqK0cxczczMWgyaUtWcnVq?=
 =?utf-8?B?dzUvSlpZc1BucUJsZEFyM254OXc3aDVSZ0Z4eEFzdXlYcks4ZGNMSUY5SHI1?=
 =?utf-8?B?N2V1dzB6NldPcWIyY2Y0V0Y3ZFlZcWdnbjEvWnkvVnQrZHJXSlpteHRiWERr?=
 =?utf-8?B?VDRKcnE1elIrZ1ZqUGo2dGlkYlN3MHd4U1N2dm4wRms1bCtndkVXeEpDRm15?=
 =?utf-8?B?aUFiQWRTc1E0NjFKMlNOMHZkQ1hNVUxnK1puUHplektPV1hkcUw3ckNLclVW?=
 =?utf-8?B?YXU3UVNqaC9VSWJCbnZORTlYMWNtNk1vdEJVRjhBRncyOWJvQU1YOC9MNkxy?=
 =?utf-8?B?Z3dKeFdJUzFhWFJmQnB5OUlkQk14U0ZqSmZpNnNTWUs5cWNHWkFCcUhxendI?=
 =?utf-8?B?RzI4dG43ZnhVTmlmVHJPcEJOMkxpNDZzWnJqQ0xWZ1ptTWs3SjJraFBOS0J5?=
 =?utf-8?B?ZzM3QnJ6RnZqNVNIejFFSklvOFJsNHhxMGMvZ3UyUXY2MW9zc0trNUpuZitI?=
 =?utf-8?B?NjlhTFFDQ2R4cm1PNlJPc21KcS9HTzMyQ0Y2aHVSaStyRG1UUW1XQ3Qzb1JF?=
 =?utf-8?B?RTRKQVNDd000R0FwbnFCL1VDTEtFVDY0VUFoYTR6aVhldy9vQStnSHZ6WHda?=
 =?utf-8?B?RkQ0bytyeDYweVF3ZkFEcmRnY0NTOFAxcmRXYlpsU0ZaVFdmM2Rxa2k5OUVU?=
 =?utf-8?B?T2Y1WjJBV0preVVibjJjakdJYUdJaFZBbkphVnpldFZScnRuTnJzeVRNN3lN?=
 =?utf-8?B?NXI2V3Z3TzJVN3ZoeFVnTXJiSVozTGRBeFI5aENxOE56QkMvVWhNRllGa0Z4?=
 =?utf-8?Q?PhQmpLDSouDRNpHPiOLE7NFRHERE9FJ+SD6UN2dYJN3kR?=
x-ms-exchange-antispam-messagedata-1: ZskH9nA6nT50aQmhJU8XY7j21UA9MejituE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F769D1F7B81F71469F6EC4AAFA476851@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3P2iYTpx5VeqDC+1QtBOcSvLaFv5XpNJGpi7jaT9KpvG4GykmEd3PN7ZVUg+OoUWsJYsK5udwylHOCTdlt6Cl0EYGkwVEVnrU8DLo7MyADQb+iq2vF323tmucGxjEFwPWKiSk0ZOel2XgyF04b+LJubDigN2OsaES2H0tEapMLQ8mCmwMoHdOylToSttVQJ1M12qOUJnGo0MYW0arhiKZ8jGO/z2oPnqiEgyddsln013nHBJ7e45epDayP7tfVyslZzT4ZwWfA4dWjSjS9NGj2kmvjXrKbLq4wANBn1B6nnSi0nGpFGrXTjkD9tsB8b1mTaL8EvETsKFdCrPjLtrRDwE4/zSUpKcGbCE77iimle9R/xHRrYct9tiKsJKZ+0TQf7DTmFJxsZKDusMJCDYQSIr6C2AM7cqCrA3pzdT1g6khLkPqMBpoTdrOsJeEuNr5wY/naODLnIDXOE6Eel304dsGgc9lFiSmrNrYJtoDayBxDwO7B0sCXdRj7Hozm44O/uZgIll1TFH1PgU4rpUxHtm0SmznECwP1ZZZFpdTwb0MeoBAz9eb0+0tpgUOK9xn3/aBtkYJ2anW+O4LYdJGsWzLgQf3ubfmr13UZdpEpLCQvGXigNAGnbi0SUburE7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b91773c-7591-4674-b24a-08de75e1ae2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:22:08.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8baoyStcNhvgJPPVzj63b7gqM7B1TKx7p9dIMKlyzHRr4bWwRJYdlwS305nnIbZS+F56fG0FSb3wCA7morC04hbZ2kDSDMhu2zzOk2/zdso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB9827

T24gMi8yNy8yNiAyOjU1IEFNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gK3N0YXRpYyBpbmxp
bmUgdm9pZCBkaXNrX3B1dF96b25lX3dwbHVnKHN0cnVjdCBibGtfem9uZV93cGx1ZyAqendwbHVn
KQ0KPiArew0KPiArCWlmIChyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJnp3cGx1Zy0+cmVmKSkNCj4g
KwkJZGlza19mcmVlX3pvbmVfd3BsdWcoendwbHVnKTsNCj4gK30NCg0KRHVtYiBxdWVzdGlvbiwg
d2hhdCBwcmV2ZW50cyB0aGUgcmVmY291bnQgZnJvbSBpbmNyZWFzaW5nIGJldHdlZW4gDQpyZWZj
b3VudF9kZWNfYW5kX3Rlc3QoKSBhbmQgZGlza19mcmVlX3pvbmVfd3BsdWcoKT8gDQpkaXNrX21h
cmtfem9uZV93cGx1Z19kZWFkKCkgaXMgaG9sZGluZyB0aGUgendwbHVnLT5sb2NrLCBzbyB3ZSdy
ZSBzYWZlLiANCmRpc2tfZ2V0X2hhc2hlZF96b25lX3dwbHVnKCkgaXMgZG9pbmcgYSByZWZjb3Vu
dF9pbmNfbm90X3plcm8oKSwgc28gc2FmZSANCmFzIHdlbGwuIGRpc2tfem9uZV93cGx1Z19zY2hl
ZHVsZV9iaW9fd29yaygpIGhvbGRzIHRoZSBsb2NrLCBzbyBzYWZlLiANCmRpc2tfZGVzdHJveV96
b25lX3dwbHVnc19oYXNoX3RhYmxlKCkgbmVpdGhlciBob2xkcyB0aGUgbG9jayBub3IgZG9lcyBp
dCANCmRvIGEgcmVmY291bnRfaW5jX25vdF96ZXJvKCkgc28gcG90ZW50aWFsbHkgdW5zYWZlLCBi
dXQgaXQncyBjYWxsZWQgDQphZnRlciB0aGUgd29ya3F1ZXVlIGdvdCBkZXN0cm95ZWQuDQoNCkNh
biB3ZSBtYXliZSBkb2N1bWVudCB3aHkgdGhpcyBpcyBzYWZlPw0KDQoNCg==
