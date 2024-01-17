Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A612B6C
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478523; cv=fail; b=YlLky3tpAMtWXk5stT57nxaCDFeReXQVUgxVK7wYGOQvgk6fvtYnsjRsDqdZDZbuXlQdF3qD8ZKobh47dCAQqMlN4PY4adtrOkq+hqJ2GaHfMPIA1KCQXk28+kl2n09cU4CwSxI3tmmL91RlnvKCvlcDzG85Y2bdzeD5aWOXibM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478523; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:user-agent:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 wdcipoutbound:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=IjjOMfR7HEzpX1UJ61/VtCOAXfM39E9EjJCkj3S9oXTjci4qXcApHMzCDEEtcLeA0jda2w3Umuqyxs3zcT9BkNBUdUjqHefc9C+iamJFgEF2j+9/Sie3Gu1sjztbJRRYSkuvcgbGwSXyu3Gg7OpbavC3A4r6MPogZ2rjxY+T1kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JbslVtAY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oZppJxew; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JbslVtAY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oZppJxew"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705478521; x=1737014521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=JbslVtAYxA1l3iLaUIWiW51hlismrYQA72tu3dCC4OZ3rG1+zeG6uSsK
   KsLycwoxztk7FPapsNfNSFz7bybClY/gcFpXrvOBlUiYowmRX1qojaE//
   7Dd4A80aTVB2TvI1K9h+2rGQOO8VgIFChbDDg0+RukmyK5wiJ4UEYpGHQ
   hZkeM579XB8S9eruCz45E8xhOq6Ftb6/ehfiQF89717j7VyXVWHe2jhX8
   pfy6ga6fAy7DXGed14LNNyxeBoO5JZ6YxoyRg5T5BvLiCmmvSVyFtIyT9
   o+i4K5PeSsllLqVCm+HqULQ+6UeyrYamqYgDB8UMOvF4HPeozbdAYVbyp
   w==;
X-CSE-ConnectionGUID: cChLr0UVSyOFfI2fmTEaQA==
X-CSE-MsgGUID: EfH26jsWQqi8ecr36hBsmA==
X-IronPort-AV: E=Sophos;i="6.05,200,1701100800"; 
   d="scan'208";a="7288323"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2024 16:01:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRQkLDub0dT6rUm6QdJat6diOiaDpLVF+gEG7y/ZyIG4ruvNMwySS23e0qzx/opOaa5KU2jCU8GInapEeVta0OmIbhMsZHaUdFL39it9U1opoA+hqLTvgoFRBwstKQJ0pY4K5rjaatE45GaLEeZkh7Y5MIC0uSSHVMFFrtUp3Zp4rBOBWpQHcHmRaF4YbCIsVe1m/EBkFXT4yjEn877nA3AACtdMLAvI4TIxsTxnOo7psletaa7krppSw00i284U4mxFooQDwABe1uxhbAaT9Hs3Z1rbQl7wTz/vVj07Z5bC7VT1IVkHNLYYMr/1mVrVe0iVpNhDIZ9BkRU3ZDHZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=NZPa92PLE2QVa/lhfuh/F9vEpP9uGgEH0solaFCCqFevjxM5lS5EvCw8ySJNOnmDeaQVPF8SRBtQbzQ61JjPccUI9xNA/fYwCEOGQGQGDM15Kow6iXk/qc62FS3pjxz5dxgpvI8+Dbaeb2NvbHeqLTyNXHhPYvlUMeG/wgkWvjq5ZWpclTPSS2GIQSngy0vhnGAlKndJtd7imI7kjilBP4T1Y6T/XUFjG34r6CfepaOlgej5NadiX26775j6JpKr4C3L2MG91qgJYeBrm2CquoI3K9HaifrnOGvP4bxjC0Xp2HW8PKSmF1uHHO059b7EO4rbfBVDyArXj/22Y4hb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=oZppJxewYWTH5vY5GlbRDKd0+a/eg+i/JnEmi3vIUIrslHxQxe+SlhSnqSn5UGVeP5GGhwlYrha2+SZtRhbLayl0J7eTP9B1rZYgrroqF8NNTt+9a6kfTRl/nm8rznfZ6QpHTKRY50k9UUmKXi7fgT+uOH11U9yvNgULp2HX2Z4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7178.namprd04.prod.outlook.com (2603:10b6:806:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 08:01:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 08:01:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "joshi.k@samsung.com"
	<joshi.k@samsung.com>
Subject: Re: [PATCH 1/5] block: add blk_time_get_ns() helper
Thread-Topic: [PATCH 1/5] block: add blk_time_get_ns() helper
Thread-Index: AQHaSJ1MugpbqE0U0EGzRIxfubRYIbDdpaCA
Date: Wed, 17 Jan 2024 08:01:52 +0000
Message-ID: <f97660a9-7cc4-43d3-a1eb-59f878c799ef@wdc.com>
References: <20240116165814.236767-1-axboe@kernel.dk>
 <20240116165814.236767-2-axboe@kernel.dk>
In-Reply-To: <20240116165814.236767-2-axboe@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7178:EE_
x-ms-office365-filtering-correlation-id: c4923d75-0e3e-4c58-8c6e-08dc17329095
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PriZqr3SzXKcjx0IPhU/naYxzsNHioN67KF4CO9Y0RfHbUUIY2RBRTEn6YxXzgYdZnRoTJ2mi4FjxfKrsuYeUF2kD2d00YqEADlGpDxMXnc7lYLUzFhQ4FlgS9G8TJ5MPYd0+eTcegsqE+UmHYm2S9/lQV0i52h/uoDjpOr751siGmRpt8aRFKIs2fomjhBO8MtNhC+eHC1CMXDBfBfvmiH1neTEEz2jF2ybBHjlF3wslMBrQ9cDPJ9usl4sY5q9KaBO7saZ3Nh697I+j7bzl2QNEvwMNd33qJ6nQhvo/IK5dHY2FOPtUjbcPSOjKzbmmD+gYeRT9ifa7A30E3UIclR5nMiO/IaeLxRyg0+P1ogf1I2CZfc9h5RpldpYHn6Lpupxra6r+Y2fFlKOTVwvD3ZTI4x9wsBukzSju+haSY8tYLy5AuERoSzvwVEhbF3fs63wmFLNWgd3SJVot84g2CU0FXtwbBBiU/AAZ74gYTtMYAzEkN0CAbUGvI+ic+h/Ge+Ib77diwxZ/Gl9/KhSXhufOyGqRHHlR49mEvFXjSbxq+ifdPnEH832O+D1OwKeQ1BwhIyXHkSkbQdjwkwRIulNenkOi4zHOeRG2sU9qUAaVxhEG6D8RMy6gkhCdlucYMvLmPJ2SH75mpLUB180Iva90kk1AHyuxUHHmrJKVXkMHm6q85sqK2fUQfOiZQ5i
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(8676002)(4326008)(5660300002)(66556008)(66476007)(66446008)(8936002)(54906003)(316002)(19618925003)(2906002)(71200400001)(26005)(2616005)(4270600006)(558084003)(36756003)(86362001)(31696002)(66946007)(64756008)(110136005)(91956017)(76116006)(6486002)(82960400001)(31686004)(6512007)(6506007)(478600001)(41300700001)(38100700002)(122000001)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2Y4QlFjVkhZaHBUdng3clphcHJsV0JnQlNmdGdiZ3orMjAraDBkTlNLOTlu?=
 =?utf-8?B?RmZSQlh5MmVYOTlwakVHcWZVQTNWekpSYU8wYUVsRlZOM29YRUxRSDg4cCt3?=
 =?utf-8?B?VHZEM3hacldJdEZQTjZqZzNkZlRpdFdlZjZ6aFlIL1dYTkx5MGhlL0ZhQ1pI?=
 =?utf-8?B?bjYwYVkzL0pkUHF0TnkvVkxsZjgwcUNMRXh6UGVUM3VLS1ViRVNnOFZKbDZm?=
 =?utf-8?B?TkM3RTNXRVFPR1J4c0dLYWZZaXM5eFUxQ3ZhZmpJQU42Z1dSZkFjaWkvUjFj?=
 =?utf-8?B?VHNiRk9PQlArTlg0Zm8zeTdiQ21VZ2lpSlR4VGhscVNSb2lkeEFoWHNkeXkw?=
 =?utf-8?B?Z3l4aXdWVVUrT3hSQXl0QmxNSGdXVW4xb2NPMTF2alljMFUzYVhnK0k5WHVM?=
 =?utf-8?B?Tkx2ZEFNS0RRdU5XYzE4MVNOeDZzUHhJZDFHYmF6UzIrdFZmQjZxeGFKUVpi?=
 =?utf-8?B?YzRkaGgwQUF2aEdKZ2laeHpWSTVrRDFNWXBORTZ0eHF4OWVMTFFSOENNZ2x0?=
 =?utf-8?B?dTdLay9oOUdYQ0JMLzRycHJicURwMURtcnFoUS9IYVRXcDBTZHpDRjhYQVE1?=
 =?utf-8?B?UU1zQXBnZVJ0UjF0L1hWcTJqTmF2cDd6R2EvcFZhNHlTZ2ljb0FjUVNsd25J?=
 =?utf-8?B?Uld4blI3dnVoQ3ZCUTBvSW5FZkhTWm5ZWHM4aXhzTEpyUjZuVDJCczBtUG43?=
 =?utf-8?B?aGcyZzZXNnREblJ4ZmxuYjVZQ1UzcG9DNEVKeXEza3ZWZWJaN28zTnNFcjcz?=
 =?utf-8?B?ZlZZd01ZWmdFVXhaVWxYSXU5ajZKbWFPMTBWTEtBTW1MeXFuMlI1d1lacEhn?=
 =?utf-8?B?R1lrNWpmcG1DNHVxUHBmUElsdlRGOVd2TGxGeWtHOUdxeGhVVzNueS9wWGRu?=
 =?utf-8?B?RjV4WXdrTjQzRHlIYXZWN0laUDRmeEQ4TllRZ1JLNVNLWSs4TnZZYnQ1dklh?=
 =?utf-8?B?MzFVM09kSWhCeDJZbDBzbUhsdkF1Y1FTZ1BiS01wRUpYOGRPMk1KNXdMWlJG?=
 =?utf-8?B?K2xhd1hHaDRJZ2FmaUFrZXc5RkIwZFdmTVFkd1NwZUppdnRGcmsvVjdnRUY0?=
 =?utf-8?B?cDBXZjcyOTVoUDJLZ3B0WTczYldITFc4OHNTb2xsLzBqajRqM0hmTlZRaWxD?=
 =?utf-8?B?TTBDUlJmUlMvc0o0MGxPaTFTMFFIdFlueWZuUkhCMG80aWhyeEQzQ2NWUEZM?=
 =?utf-8?B?RiswTzVwWnF0ZFJSSjNmK0FGQ2JGNDFIYWlwakx5Y0VGNXRUcDlCR3NheUl0?=
 =?utf-8?B?MS9lK2FtM1hCUDg3K25ZWjI2WExoUTk2WThwZGZSQjd6OVMvd0tkWEJDT1dE?=
 =?utf-8?B?MlRWQS9Cb2JMdnRtZFZSWklQdkdQa0FUOHQwMC9iSVdmUVZBbkNuekFHa0d4?=
 =?utf-8?B?UTFkdmRGVXZiV3lRaEp3VFpqcGNONTl1b09oOGdHblB0S01WY0l1TVRoSUVl?=
 =?utf-8?B?VmNMNHRCL0ZNNU9Rc3ZOS250L0MyaWM0Wm1hWDJ0ZGRvMFF5VG9HcWFPUERN?=
 =?utf-8?B?U2F5dkpIV0hKRTdzNmpLQnZFTFR3OW1WYzdUK1IxTnAydGlpWDI2dE1rQlVn?=
 =?utf-8?B?U29IUGIzWmZNaUNPd0tsVnM2bjN3N1NiOXBEYXk2aDlsV0FUVnI4QlJlYkN2?=
 =?utf-8?B?MzUrWEJCSDF3SWltUUJJaXl1QW1HVFFoVnBHV2dLZmg4YmN6bmhvUkNyamtq?=
 =?utf-8?B?ajJZZ0RGYTZIVlR0eEd5bXo1ZlVGUmh3OGIwbnBqWlFLKzdXZlZML1dZM1dx?=
 =?utf-8?B?ZTJXYndQaVhDV2s0eTlIWGxyL2JkWG9FdUVDWHRXWlphR2tTTmF1N3R0VjRu?=
 =?utf-8?B?Sm9lV082c1FjNFg4MHFPS0M2VElJQm5vblk1cGxqc0dqZkYrU2xiWEhXdG0y?=
 =?utf-8?B?VlZydS9sYnd5WFRyQSthdXNHbFdXL0VTMFcyS2FJR3JoRU1uQjJScXk2ZzVJ?=
 =?utf-8?B?Q0RQRG1KRnJiV2FhVE5ONERLa28vSXp4WlNSL3p4MUFOQW1aZ2E4a1NsbjJD?=
 =?utf-8?B?YjdKL2M2cnE0TDRRTjVJeDNvWnZUUkJYaG03cm51ZVBYWmdCcjJnellrVGc4?=
 =?utf-8?B?OXA5WFJKODFZbHdxS1htaUk1M0E4OWZEMjk2dVlNOXAyVG5CRURLdnpTNU85?=
 =?utf-8?B?b0FFcUIzUzhWc0lrRWlmaGhrbGt2OVMzWGxmeExsYmtIUHhNVGp3M0NjK3E1?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2ABEA24755C454091024A2F3DF6FB55@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0TOZVcw8lZPQ7/xFwb+jjdUz3Pm7e/wSFbzHbf5C8EQ6ngePrLyTn0xiWRmMrO5nO3eTxpgmbxXSressDmF0dVmcL1VQ5MsEHYVrzFkvhWe+BHdJLWiXTHkZtk2pJ8+1wddVcJB3aZQIod8dyQeyvEF9IpE9j5d/EjqKxitQ/LecSzPsY5Fhw4t86ZHv9FuYgsPWpR2AZ3tLh041WnROBqgoqogkAiJ2+YTaPIJJ15hN0TXi3yDVWeSTMKb4fXEVZvj11MchaJTWjmKOacXb9KDcIZvtYCnrRrqVEBVonVb5VKv7uMYnfaqpqCe9hDF7FvHlq+h2aA8WGQutXncVXdHWuqoORhzhNo+AsIb3Fl9tvuoGCknNaD9q6XOnWYsVqfe4OymxoFBCnrxrJhVmpzv4yEVCjXKfxDAmIDJbVFxXG7ZopkrJmI0g3xIdcm5eu8lYOtdr8y2+tkrz7uLNkYekVP9NtmqyMq4CW4BbHIP1qx2N00IhLrZd0z4HT/SQFJdyZB7aJH8+iGlCzvWoKF03PzzmQOtcDkZi5b59inU6sj5arNJDsS5laG2waNsnjsd7XVpp5CQag7CR/IVlbIqAYyUzxiI7rlXFUpAsBoiOF19jKsghSmA31PE4yghR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4923d75-0e3e-4c58-8c6e-08dc17329095
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 08:01:52.1139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: up9HRL2oDDUQiw4Trds/aA2JLWh18NKI39ex9eMS2GMQdyYmea4L+FuOaLtfFaCNDHRUD4uE9bULV9iiVpq/beTnuXnJXESifZIseE3Yexk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7178

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
