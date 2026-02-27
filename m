Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D425163
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184779; cv=fail; b=VOegGrWnJhmYI6gAIAQVNS5nLAy3AzEolMp5rPeaygygspP8bEf7uch+9Rhu4D7jtdKo0QC8QwQ0NDONlF2xwBmTkKPdVxNBuiZD4mASpCu8RXruZwpKURIoDv1jxY2uT85Mud0OWJKCnSw0GGxBs8ksVBx7sDj7fhmq0ym+kok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184779; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qxC+NkhUhmHpFgCF2A4fsx1H1cPJMwxtGK7DHSf0bO/CDS7FnXUl78urYRWKUFpFHCauPKWPjGAjVc/a/zq7vqU78eoKiQtxsIFHC+UHfdogYjMG7GLfqxNE7LNSfXtJQIGeC4gqG2IN9FgPz7w67kg8pfUh1UuwkA61+ACRldo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AQFE84a6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bTVkHbT6; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AQFE84a6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bTVkHbT6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772184778; x=1803720778;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=AQFE84a6xMda1QXjiNqwyP/2t9ifS895gXdfGeJr5yV/WO1D+UFMfGpZ
   uE+knDhkmTy2CQ7ghv2d0yK3fUZg/9A09oMCFqpGuQmMq1FofZtveLdqy
   I2Ib533eMQKPOPYeOPpzZ0YLSKw3WQvN6e49g5nHqncV90CRwOTpTIVkO
   l+AZgbokhSgp10KRmG08ls3aqWX7CG/7Bnb41sz41djVg7AUk4VYRYHbX
   MN+Uc/SHn/qMyHESqCKxK+jloJmpfgUl3Od934KbW8wDrhB/FhdZhZqxS
   zXOmAy1Te7YkLWPlL1MAotgEnAH5/q7OgYZA2qtAr7N5AbXj+5bXdlrDu
   A==;
X-CSE-ConnectionGUID: N5dzV3i2QGi71a/829m9qA==
X-CSE-MsgGUID: Cn6hKhhvSV+P3zc0jlTqCA==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; 
   d="scan'208";a="141191174"
Received: from mail-centralusazon11010017.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.17])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 17:32:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1fBF5JVnkAqtIMi/9QNR4p63r5zMckYXAIp4/VPwUzPC8iD44X/oGXd1EPteOzBnING1T8sol8h9PL6S3Q+WLl7CsVIdI7JeMYCn0xSIHcIVMo4kemllC2nytSW+M2t2VS6mjI2LsVx6UgEjERl0utxtsRmC6cokYKrVkFQ9Hs8a5au4An3G72SGMnurnsYMTI68i0j1vxjtDcYSnW8fbQdWD7pdsRZ2t05NLN+8Shsgn4la11d1o6+3y7P/0GowlJ7V+rwR0j1UbSHmyyg9FD2kuSYnF5zZJ51ryp6FAiZt6kGyhiiEuGwj7boty5fQvOzha2mWWX8MataZiRveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=lMjiBs/ZWoSpmGn4BQlPnHIHUBAMQtfON9gy7BcrkI2gqNBOm+dUd6IbeMRUEA4Nc3KdgeovjsejREyYCax0hTBIZnQLVhnmIqZYvDjdJmTGH26jmKhTcXpWfrzvyCLs9GK0dkKiO/ZITwE0Ntp8fBsFYoYNx6ABhnP5HSaLdsWcLhtzEXM7FSCh3+xHUbX5q9lKboUgqdLw6hBGCq0ZIajQ5gWVxyzy5EosWUp7h1CW9k6ZS/gtp3v/fPpuwCSbkdb2Sk7Z6UFMzcGz+T/JO9hRnoCirVJol413oqTTxOax1Lj6LBTpksyXGvbZZzBtH6Z5sGZ37/xvUviEKY+5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=bTVkHbT6crqm5Tqi5j0gqSyU2d6Igk20f7/HCKJu2IGJRVS8W3kIYHk0+pkQ2EGlEbX62OQCqDW1X0MvSkXVgGx2H8e9NCoNpXVn7fFYPhVtgXJVQlI/LhkuJg7yVgX1G+j3U7XUdTznxP5rN+Kk/VV9Um7CXeMb9bhl12heQNc=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CO6PR04MB7554.namprd04.prod.outlook.com (2603:10b6:303:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 09:32:55 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 09:32:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3 3/8] block: rename and simplify
 disk_get_and_lock_zone_wplug()
Thread-Topic: [PATCH v3 3/8] block: rename and simplify
 disk_get_and_lock_zone_wplug()
Thread-Index: AQHcp4w5zDq6af1XkEisBmrlLUwJGrWWSQAA
Date: Fri, 27 Feb 2026 09:32:55 +0000
Message-ID: <03ca8d76-4c06-4bff-8442-6903cfe77a81@wdc.com>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-4-dlemoal@kernel.org>
In-Reply-To: <20260227014951.2327711-4-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CO6PR04MB7554:EE_
x-ms-office365-filtering-correlation-id: 8cb3fdc9-7fdc-4e75-3ac6-08de75e32fb1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 Tz0WMMd8hbPVHrcPiIs5gBdi3Lk24xSEqEKx4VIOiQzppakAUmglB01NbYyRdrfUiN/7j+1EQZk+E9/9QM0vVFB94doVpysX96XOL2vnapsKYhTRBs4y2SCNZom+mFm1YOAq9nnah/9rdkdiAsYKj2RaExdxxrGWcZ0KO2yUYxdcTKbJ99BTEFVe7tcZI4dT+gGq3VXQq4jwR0NTBMs/6Fkl66oZmb2df/RQeLo+jWL8q1cqnFmxF2H2zhWOdxr7SXzPCR1oqYTbSlHkaQ7/bk2PLfoRLk5N4i+jQuXncnZyJX7heTQUrzEqyorrBlf5YqECodkDlW1hxTo1nYM4UhBQShOSiWJAFelFAGoDBCqw1zi1GIgXwZRQSXTsEZzwvpIu90ZLeH+Ypv4TbWzYoEhD+/gCsTUEqHIuFN17z8FQzMIonbNZK9FOoIi7d1TMBT0CZKPc/aczI/Z9MvKLz7k/ZVHiP+wgJApHQL2cJ1m0CRp3IkqD6hDbSsxFxML9nxIeXZXEOy+pY+vyiXNOumUe61ZMCNXpncoqsiFeNTD3gfn080vQVvmbcrr00mfyXXkSY+EsC3NgsXHacMUT5zXYMS+wXUvXyfRwt2MJTmmRP3B5rA2JGOBECVVVAiu3/LeEaRUqQJrWa54Y5bkDqZBRHj5FTKbbrz7p6FDAgqO3SsvbbyykyksMr6YDPtA0t2pt8hFZTzD9VtvphyTpi3A7vph2Wy625uXnzXZxZy2D5h9EJYljEDc7c8MKtL+xkVIPlq/1USs91aNBejl7K1ay0Ec3EIXlGgq3ktiKpOc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3R5V1ZXL3JsVlhvV1RNVTQ2TlYyaC9TRFBaU0hlSFIxUVluVkhIUlBDRVpZ?=
 =?utf-8?B?MWkwSno0b3plTVp0LzZnTDJwcHk5TnZLZHR5SUIyUkE1RmgxbVR2MGovWWZX?=
 =?utf-8?B?Zk5xNU9lRGZ4Ukw0TXR6RXNYUFU1ejFQR0VBVEoza1hadXZ1TDZyd3JqUGN1?=
 =?utf-8?B?QWg2ZUtQNVJqM2V5Ri9BWWs1eFRkcktZSThKN1dicDZYUlJSQUxUM1VKWkV1?=
 =?utf-8?B?NUZPdVVYdDVhUmkwbmk1ekpYZUk1bGxnQmVnZnpXRlVicmI4cUxsYll4Z09I?=
 =?utf-8?B?RElwZTF4L1prTDlQcEhacmhpNFZxK280R2Fhb3dxM2tLeVpPaTdYWW9pSFBn?=
 =?utf-8?B?R2poRzNFdXgxUGJBNUpOelg0dUJKU2JSU21ROWVLWkpVbTZJRG5oNWZVRVZ1?=
 =?utf-8?B?ck5GdVo4b3BidUlBMDlZUnJ6V2RNVGVmUzlkMUxRSE1VV3h1QlBVUUZ4Lzl0?=
 =?utf-8?B?YWxPeTNPK0VVdEk3V0lqcThWVXUvdWNMdi8vMUxBL2ZCZGFoZlQrVTdiZy8x?=
 =?utf-8?B?KzBWNC9xcGZBR1dBTHJzVVh5ei9QazJFeVRBQjRZZUZqcURSSlhWYVBYd2hV?=
 =?utf-8?B?aTJuTHhyZHg4c2gzdXFWSXEwSmJUZjI3ay81OUVudkNqcnUveDlESS9tWTZX?=
 =?utf-8?B?N2ZjRGJESzcwN1RKMDVFWGozdmZVdmVySVlQODg1Q0hSV2RlZzJvcE51T0J5?=
 =?utf-8?B?UkpkL3lTVGJaSmlWRHlLdnlkVXRNU29NWTJKdm03Z2VybWxxSW9Ea1JZYlBp?=
 =?utf-8?B?enpBa1RSd2VXK1JTb3ZUTEdRODZsZjF4UnB1SXBCTzV0a1Vya1NJekJsZHpP?=
 =?utf-8?B?cm11eUVjZm1MN1djUzIxZXMvY3ovWFRlRzZ2RnFpVHhEWG5aMTBadldhV3ZL?=
 =?utf-8?B?RW1PSWRjWXZCdGlZVHUxTlFBR3pGVjVpbnFnQ0tmdjRIaGd1bWdPbXIwU2ln?=
 =?utf-8?B?NGh2S2x6NUN1SGY0aDNkMVBlZWtIQ204UHBMOGZBU1BhaU44SXpLOW95L3pu?=
 =?utf-8?B?bEJSaWZHK2lyZlYvZlBFQ2c3VUJiNWh4OFpTTVhrZUV0dER3TkJPYmIrOTQ5?=
 =?utf-8?B?TEtSOTQvVk9SaS8wdlp0OWlkK2FXR015SDM2L2pQVmFVZ2FIOVYwN1FlS3dn?=
 =?utf-8?B?YitQQjVDUkVvQXRQTlQ4eVhHOGlyc3VsL20xclp5TGRWOGt1WllhMURySVZL?=
 =?utf-8?B?NmVnVWJsNTNyck1xekoyZ0Z4Q3Y5MTB1WlVndWJaYU82VjN2NWFzY2h5V0Jq?=
 =?utf-8?B?NTNnRWhRejRJZkpyOEoxU2hqMEw2WnlhcjYveW44ZkxGb0k1Z0NCbCtzVita?=
 =?utf-8?B?eUFmaTJ4MHc0T3Y2Y1dKR2lwWFFmQmVoQlNpc1BHY1FZUmhmRHQzV0ZIeVh6?=
 =?utf-8?B?aWFOUmJKNzI5dnVaa1oxRU1PaEoxNC94bEhHY3R5aXJ2bHlkbVM4Wlp0a1FO?=
 =?utf-8?B?U3FOMWU0T2FYZ3ZHYy91RFR2bklIV2dzejJ0ZnNMZEI3K1o3MHkxakhRcnlM?=
 =?utf-8?B?VHZsU2RvUE4wNDZjTFFWaEdaWks1dFBmdXRPZnNxOUVtOGNTSWlYK2RRWjlQ?=
 =?utf-8?B?UEYvMmRkaTQ4WTk2cThtQmI1dTRFVk9xT2RnOFY0bU1oMlFIMi9TNWxEbS9Y?=
 =?utf-8?B?SXdzUXpheXJwT1ZRbUIzMjdTQXNPMFBlSDVHcmNDYU5JOUljRFFtYkY3TER5?=
 =?utf-8?B?M2VRdjF5Vnc0cHdLbGhTT3VPMEJySDQyOVFBM01EL0YvSUVwV2ZQMUxScUdV?=
 =?utf-8?B?NTdJTGI4YUZyVnltb214dnZmM1BPcHFzd2JZWmM0SHJtR256LzNudzUyY2lk?=
 =?utf-8?B?YjlOVHNMWTVkMzYxaGQ2SFUxb0RPZjZiT1BxVTJmOWxjdld2YUFOeEI3Tnc4?=
 =?utf-8?B?Q1N1a0lQall0LzFwdytqd21BcWZuWk5NZlhjakZNYi9GV2h3Q1V3SExaRzZO?=
 =?utf-8?B?UStSMVM2NldEWEJ4MUdjOUFMWWRINUR1WjUzVnVnT0dtampjYTRSZjBaQ3M1?=
 =?utf-8?B?TFNkTDdaMFV6VnlHd3A3L0ZEbFlMc2pzVXlwN0hwSkFLVXI3V0tuTXVUZW44?=
 =?utf-8?B?ejdFVksvVG1pbmZkcUZxajNhRmF3YTBoempBS0syMjZpdWNsQzd2OHBqRFhy?=
 =?utf-8?B?RlptOG10TFB6TmEyVFlZQWJjN0pFdW41VUFhMVhWbFVTZ3lMenhLN2EwRG03?=
 =?utf-8?B?Q1FIWE9PMWppenI2ZUgvQTZQV2JKUndkbXVXaUhXN1Znc2h3N2IwSTNUODN2?=
 =?utf-8?B?Y2dtNWY2WU8zdGs1TlBaM2dzZzR3YXJZRkZ0UXk2WXlkSGh6T0FIbS9zQVVX?=
 =?utf-8?B?aElUZnRjSDlla1Q0TFVCTUxwcjBJU2J3Q3p2VFcyK1VHeVZyVW5MN3locm84?=
 =?utf-8?Q?mMA2PXGuKDyKUWeB/N1RrFnqXygDUfjYJ3cWZ9dc5tnjx?=
x-ms-exchange-antispam-messagedata-1: yRagjMFytOAsh2apE9JiOAbk753givQqSqE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D19AE6BF06A5B498F7114820DF4F328@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6xJMXTtUNo3oYgoGot34PyIBmLYGgQ8qoFrTXCWUsU92FXT9hJcskI+/FWEf4AhioNI0iUUnsvxR1yvPbPQ5jkyZ7Zig+uguWQ9rDeA8f8s2ExvR89K4m9o/3IaEZhvFA1eyALhDnKpbQkDLxvvU0Q2R1nCAEtq0a+ruKWXRKGg2ceN0fyN4+TX6RtyQm4x0DgumwOSyZPAjXPxAQvisQ2mkJUjFq6AZz/TWzn9OwA+vf1iLHo13gq2TdqdD4ohTLGOJlr/rEbjO/0s4crlYW629Y2P1ZRtKebmqWYvyeZNHSs9RkF03eppHh4m4qWgMOKm0ewg/l//CdxmrEEY38DcvptOd8eEPXki0REy/2FZ9cBLaL/mAzYyeq6o0Wmv4F7x0+RDl35scmoq3EsdPRAfERzJVQ1Rh/+LKO3u3DpL//b4jRHVtv7+UDdcb0bQXDW6b16XOpauK5dXrrY1RJYNN1+k5adfQRKmfgzxhRsntjcGcd39H61EMr7OCBTon76ksLqbBPGakTNgu4DiLQH3rXbCeGZ1eDfLV41I21crRgcSNmSd3RQqZ3gjdCurV0eTXXFkrLqNXmmcjS2J7qpazOiVAz9lNHFJNTmrVby9F7wUVTutqIL4FVYw4uoK/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb3fdc9-7fdc-4e75-3ac6-08de75e32fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:32:55.1301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tx3pzXOwSlqQTVEziGjsI2Q9yIuKt6F0DZshzFerxq0EmMrwvgMUqEozJe9VIgORIydLgOAwrF0GAvxS6H+2fNOP2X4guMCuYUw9oMFQUn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7554

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
