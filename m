Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A617C6D
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089573; cv=fail; b=hNQZKAKWvdW4HS3/e0NSJItCh6iCjktzQEAPuJGd6qm6+gbtwuzjaQo5MImcfMP19fhoOhg1adnU1CSEo/6QaPRmJoOgTBE9bOdvX7sNdHh5LJxPQNxqHHRGqxrkjgP0UWzjo9Xowj/AWdYjMQucDOZccAOA/FgfKngN4+79N2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089573; c=relaxed/simple;
	bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kDMOZ1jCf7lGWGKz9MFQE3iLUoH4I9EaTu+/rHagb5j6IKB9j6P7vmkYcBfYgoGwOVucBLjqILpE4dVyb+tlofjYcALQNnsSl98uR/hyBGdIy7IrMzudfJPjnW/QQfl0VPRHFdfnMq2byGf38W+PWhQIpbz6110/irOIgN5G/pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RbTQuHpM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=P+qwvAy0; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RbTQuHpM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P+qwvAy0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706089572; x=1737625572;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
  b=RbTQuHpMkzAq3yTAiReVjxaJkQvYeworUOzHfD0Cyys6BsnjA/FnXPOV
   tJucwTuvr47wxi+X44RxPMrpOL4jlUbh6D6KG+T+O8cB+ZCOGwMbYuDg7
   Y04vSunSRH8ZgWFxq1GRA2BRqzIxbWwhqdIlOVwNmpqN1ZF4zUunTZt9J
   tQjW3+LG0JoYz8lWiqgBgGpOop7YVC45lJYf0VN/TnMQ/FsDzxQ+qe/OB
   S3rN6rPkqgMGKlOhGvLsQ4+wfSeBoci6RuLpKZqMUuND0zbVMR0VW1h7U
   C5xISZ0V5UxSqLYd1b0mY3UE4mztZto+7DpY4RyVkKyLM9mitaL7fOqGB
   g==;
X-CSE-ConnectionGUID: sjaPe4wVTW+O96Ik4AtRog==
X-CSE-MsgGUID: FguIC/apSgGI2GM/Myoa+g==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7557695"
Received: from mail-westus2azlp17011018.outbound.protection.outlook.com (HELO CO1PR02CU001.outbound.protection.outlook.com) ([40.93.10.18])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2024 17:46:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYzyCw5eaoiiwNABgHaX2gv4Rk6jw47y8c7URraWpCWZMHJ+Wwkqrf1oJVo5h8J8o2mrBt2lgWL4CS9Xw7CLy/1vguL0VaKOnrrlR1XgJCFHV6o90A/A/E8TPSKvwj3syHy+vtZgkfbjZWq681K6LhW93MhutDjCR9UNCAMympfhWjXgZA/rdwvZWveAFtnuCTp+P0NlOrftswhBXFR79uZeUjl/I+sIZSc51WbMckpcBm2u/rLi/u8Egjhx9De5zFXjQJE5mET61UwPJdqVZzliTxC0AN554Mbq6Bsnt0A650ugK3qzhsyEcecTHHz137KDSCR1GSjLmHvV50kt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=ZNMIioqwML7mHU8D5DL4MGMKhBypoY8vIuBdUGZClWhVAW8DaE4kJ4Ux3jEfyGIemueZUoB78B3WOrmaptagpcwqN0P2EWY68UOGd+ezyVLBxjskterX1AE2s8BS1ZTPSjwBot2eKHTL3apKyPvHR30j0R0CqO3nOWuYuRObBjO6D2oIDfNJi5dtjhgU7ly6o1J+29qxGLAqntUBGURpd4YjmZCou7bDAEW2HDZwuHuuZ1iNH4Qe+PS1V344GpDgBtULe/byM4txmWDfrNLGOq/c6eJVNEG6NNxf49Gkgs8yKXmzrn5/LEdrCp5UDZSawxhfx5PCsPkZcmcWoS0Ryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=P+qwvAy0OsQNxEUH3A/Xo7Cby9bvDbdDFV8ekjKZXxflR0I96oQLI81gJMXAg+dFsArXhTtXLYH5wT7eH8UhsHoHlvAVUak1Iirfrx5y2ZP63R9TU5yzlikiEmscujOpr+ARjZ/FwQ8LvA3tnNx5kHV2ISOfBmAMSr0oh+owL0k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7400.namprd04.prod.outlook.com (2603:10b6:510:13::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Wed, 24 Jan
 2024 09:46:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 09:46:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 5/8] block/bfq: pass in queue directly to
 bfq_insert_request()
Thread-Topic: [PATCH 5/8] block/bfq: pass in queue directly to
 bfq_insert_request()
Thread-Index: AQHaTiNT1xyObz+fg0ia+VD+Q5iLBbDot/8A
Date: Wed, 24 Jan 2024 09:46:00 +0000
Message-ID: <0788d523-0b8f-4a64-bb27-b8292e9c8ad9@wdc.com>
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-6-axboe@kernel.dk>
In-Reply-To: <20240123174021.1967461-6-axboe@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7400:EE_
x-ms-office365-filtering-correlation-id: 6b52b817-d8cf-4f7d-3517-08dc1cc145fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mZOlGQ/nC1KSxkPhHH9R5KsZ7lbtE40anIVPcIwo6av5UpSUrHHhOUyzVlMHAqaOwCoJmUfhbs4nQJMRNK5q+5jajnYv1UmSyB2L3jCq5UdLWxprl7nvvrocm1ojKptBTGKD9vsxsnulPS3MJEm5IY4nMOAoATl119HPE4u7ExjhEzS/57qqbGUlj0OBL+R9Gqkjg8aQFOSlBbGPcfOTkKt/LLq0v1oUbcu8pNjP1Rheke828zmqfemsGv0CqdS0RDb7n+yOndAoeYCl/rcwl1uDkjZcqvpaWuvJWq8IifkNcj3X0FzwG8Q5lY1i48K/5wEUvU58WONE5pVE3tWwciMN4p0zCZNmE9cQ2XBCQaCUmMvN7PTzsVvcTrG71rr8iY73ckmMVFhPmWXBw6H4JZSlhEO/JX/7gjPg2YksNl/rA3/RXH68GHp1AY+l38Sa8wRkhKYdi0lKxsZMY22R5DnquomHPF2KHwun4nvbfwJ6e4HFNmNLG8tZ93vBkhtthobv01uDCdw8mV2jAW6Tb6syQtNA01BJoViFePzYnfveab8GmZFjBdCfaFqiXozmY8md3VfF3sBb2JjshCBcKc4ZmT7Igr93UDkrYReyc95ezwWSx4wYQWvoz5vf6yw18J4JXR8k3bJ0GHaNr+SK6uKvw12INuolsBELtnM5D1/uheVWHsgEnwA8ZZPvSk8J
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(4270600006)(38100700002)(6512007)(6506007)(2616005)(71200400001)(66446008)(122000001)(41300700001)(316002)(19618925003)(2906002)(86362001)(8676002)(91956017)(110136005)(64756008)(66946007)(76116006)(66556008)(66476007)(478600001)(8936002)(36756003)(82960400001)(31696002)(38070700009)(558084003)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWtXaTFUYmRMWDB6NytTZUlDRGhHT2JoSDByVTJxYVZ4eFlOVVBUWG8wMXRq?=
 =?utf-8?B?UHMxTldBankzQkcxeVEzTVVsRmxnTXA5ZzFUYkVJZHJtSEVSVHVQQUMyT0RX?=
 =?utf-8?B?VnRtdWhjU2g4QXc5UXY4R08rbjZVMkw5enRucFJDcGNSQ1padHBDTG5RM0xw?=
 =?utf-8?B?T2NSQ0JPUWJ0ZmowRWd5S05ZbGFsbDdNQWRlUkJjQkNmZFByRVZtTk5HcTcx?=
 =?utf-8?B?KzdRL3pYd0FQbG9kdHJvY2hCMEVSemNwQ0dpRWEyOWFwNkRIdG9XWmdWWE9a?=
 =?utf-8?B?YVNnbEJNdDJIRmZBTHZEcS92YXVGdWpRa0NodjZnZXJSQXlFVGtNUGl4VGhk?=
 =?utf-8?B?OVpiNWM1cWN3TGppS2xnR0FrSmhvRWlES0cwU3Bsd1FiZ1c4QmpmTjQ3SFVF?=
 =?utf-8?B?dGZselZTYVhhaTJGR3pzQ2FYRUpWUkgyY0NjYzV3WHJPd0JLNEdRd28zcnRr?=
 =?utf-8?B?Lys3b1BWYnBtazBhcnR6bXdFTnMvZk5ETlhESzNVQmFoSkhHTkpIclFuRTNq?=
 =?utf-8?B?KzZlVXh4NEtlenNST2JCS1Jzem4zZTVPRHdwUmFSYXNoRExVbzIxWlVaeFNj?=
 =?utf-8?B?Y0lkWjNGS00zSlgvMGF0WXIwd3h6TDlLNkovVHNLYVc5NUZOcWFtUmJIeXBP?=
 =?utf-8?B?Yi81M2hhdm1kVmhadDNPUkxSNE5aYThnY3F1d2tkWmpvSlVEQk04RExFV1Bh?=
 =?utf-8?B?d1ZYQW5nQmhYelF2b2hzWnl0bGZXTC9GUmFSU2ZXcWVnOHNHd29uRjJDRnkw?=
 =?utf-8?B?NGJnM1AwaUludXVOUmY0QUdBVTgzU0NUNmJJWlVxTVcrcldlSkZCb0lOQVY0?=
 =?utf-8?B?WFh3VmtqWHlVeGhEcDFXZUpZVVpnZUtqcEVOazJwZE9TYnYyOEtJQ0p6Y2sy?=
 =?utf-8?B?SndyM2o1QzdUUFk4U1BhdkZQcU4vZ3A1ajczM2pYcGxSaFhlNW9xMTRwMm1k?=
 =?utf-8?B?c09tVVdvOFBtWVVWZWhCaU1Ua2ZCOHdTeW1HVTMrbWdVbThrVjE1NlNWMUlB?=
 =?utf-8?B?NFpCYU9POEJpaFliUDg5UTNzbkRURXV1ZGZuYTJHZVZCTlVWZkJGRUZZRkNj?=
 =?utf-8?B?cXpwZlVtRmhRVUxqS2tya3J0OWk1TXpTdGxqOEVUMXpMUDl0OWNmaXNlV1RB?=
 =?utf-8?B?ZHhXSDEzY2hwNHREV1FFUWNzMUpVb1A0c25URGhmTHp5VmFZZ291L3dZUFl4?=
 =?utf-8?B?cVE3OFl0S3FQbVFjdUxtdkJrNjFEUlB4OGJwQVFDdWVIMnNRQk9mV1NyVHhx?=
 =?utf-8?B?Z1ZFRUhNZ2tSdEluSUpzZ3lKdTd6Z1ova0R0Rkd6czU5dERqTy9yckZwMFVx?=
 =?utf-8?B?UU9FMXZWWTFWQXd2VWlIL3FISFFpWGFvNnZNbUNmOUZKRG5ZMzkrK2pDNWZU?=
 =?utf-8?B?NndUNE5VUE13TXRpRmhkSXkrb1ZhRjV0YmhDeU5MeGdMR1BFb3RiQTFLV3V4?=
 =?utf-8?B?cXVwMXd5cnpOd1ZlVitWR1cvVmx4RjV6SzNBQ1QrbmlZNloyRGkvVnBUVE9E?=
 =?utf-8?B?MGpROFNyYXhqUmRWTnhxYWU1UktENGxNUU1zYlorYWkvVWhqTFNFMHlJbk9Y?=
 =?utf-8?B?cVkxcVVCclhWdGU2N0J1NDRSYVlOcHdYMFFjRDZTZ040bzZsTGtZelBGUnky?=
 =?utf-8?B?ODRoTnROeEVwdUFacFRkWDdhUUtPTHV5bnZDeXFNZFBJSlBXcWVIdk5tOFJP?=
 =?utf-8?B?eGZYbWVPVUNwbTZ1UUpadytiZExmSDAvTjRxbnA0OXRJcEFYMVAvNWVDYktx?=
 =?utf-8?B?Y0JhRDV4R1NFVVBDNTVmMVlHMkZTV2xzWlBaaUlwV2pGS1RXbFdPOUljUitO?=
 =?utf-8?B?V29BUlM4M2dHMWJEUU4xTEM2MUhhU2Y5VlZaVitacjNxOEN1QWQ1VnRaeDdx?=
 =?utf-8?B?dm1tL3FiS1NPKzcrTGFRaXhndmQxV0JYWGlYMmdvU0NpQ001VGFKYjJNemR0?=
 =?utf-8?B?NXJxSGs2enhVWW9NbEpDNFd6bnRHTVdFUGdJNGttdGVvWFRtZ0llN2NGWHZD?=
 =?utf-8?B?cHhwNkw4YnpzODRRcllpdjRQUmdTdk8zS2pwRjhubzFmK2hWcjR3VWwzWjdl?=
 =?utf-8?B?NWkzamJDVU5UU3JWMHlEZzNESTBRZDdnL1R4TWxwYSs1dk9BQzdpbG9yd21R?=
 =?utf-8?B?RHlFWjRBVW9yVi9CNTVXWThaemovN3lST1VHczF1L1cyaWgyTWdoa0QvTWRC?=
 =?utf-8?B?V2E2VEpQdjhUR21PRTB5S2hNSkNFbGtFY3JjUHp4MWFaZ0tYWUpJUU5xRERG?=
 =?utf-8?B?K0JTMTh0cFh3VmppWVQzMi84eCtnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97161E45799EC54DB54DAFC74E0D3C86@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rtFy+GP06jzFWwVj23pfdrcDNbSNslSP6ukbwiFns2TS4B1U/7LE/e2qL3xDk+PzryId7/fJJTjfzPkwAMX1pR75U6xgLRany5AKgRTzZMi8IVDeFkKgjLe5eLr6Q4K5CTwFds11EvVB6VqABubX7gwKxzHb8WxER6hLrdqbQkSZ2BatFUWf2/VAuNWvFAdFuTuW1cpdDbC1em5hNvtz4JoTj2Ctn/aON3gnnuwDzZErx/VIH8uLB+A5ZltENFjJ/8dQSwiw4NXsai4T8oxugRb2jV416UVccQoX80kuHDg6MDFXKhOlKu/tI8o5Mm6f9RuvNbOPZ47N3aKi8obZ0gtwBaOh57p8gSEqdKMKw4DFTJVGuxL8yQlQJVw1Rf9mzLqWTiFUrjTmf4ZPV27Uw6jQW4XAyX0+P4l0RScWgzDy5JxwI9CRCig+u+8QbnHJ1Dkwg4nGqidoDWbBVquGk8rY03HheFDgUxQpMZL1I6UEH6GsrQ7H5DhV6SR78D/d+iBqZZ1cE8xd+qR6Jid697f+SydDlkT9FUroGtjWdvrZ2uZS5yH7qBLwjj923yOSSSPUEqT0+hFMPCMEvPjtVP5ttuB+YmEd7XhkZ3+lRPFsC4xVNV78HqXUftsns3Tt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b52b817-d8cf-4f7d-3517-08dc1cc145fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 09:46:00.7994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ID0PztY5uAn0faR1mExdcxlWjkpxETvRVKpX5frnOJJBDIebGZXldNgrPqRcP6hdj1BWt5Y0s1vN3E2TO0PBeHLT3fphFtjHQn5Dyu2y/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7400

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=
