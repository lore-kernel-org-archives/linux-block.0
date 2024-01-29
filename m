Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA904F1EB
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515306; cv=fail; b=BQf60qvPDWq76+oOSxY51Za0C7agskHpyPacIvNjs/ihJwCzl8aOEcfZZ+8lJFEe9qit2/vmp2MMbwGiUTq74XdHNZ6mPyga/kvUvNBIKY2voXBNJycAG0OBKm871ZQ2XD80sDJqkwBOEUbrWSN9CJAZoD/QKW3UN9PG/A5cbQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515306; c=relaxed/simple;
	bh=3lTW5bvFoYVbrW7gkPHP3BbtIqdnlMbcQ5HNZk7Mdv0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RIobOS0jiwxV4pe/+fArrwR7JNUosjUqlGxUFdXOdaIXmFIAfg2lfO55dp5Wl+zVQJQDa0VJbElLHb+023hdbHY0LtYi6j7m8nMnn3reeshEi35zhvzvC7D5FOo5WUzOeGWLxahhe+HcM7bMhk2w8iWoMlkGNEL6W9szO8gQlQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QeglwU2k; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=N0wI/d7S; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QeglwU2k";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="N0wI/d7S"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706515304; x=1738051304;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=3lTW5bvFoYVbrW7gkPHP3BbtIqdnlMbcQ5HNZk7Mdv0=;
  b=QeglwU2kvGOq82m8YwDMLRUCoqiaHS92DUhdG18aABllp0c8AYDwp81n
   TYBd9XDyb7/GZeJcs168UYWF34AXitEZzTluVS5SiN/lpu+mDCH6Bn/FR
   7NEiXq7mL94NvUMo/7Z5Lt6FyT955nUjVeDIdiZf84rQm9vDF0BPMskF+
   eWTGYsoGBDeZn3m5XjdFgw8XOJ9sdXINEWZUgqv9V5h0CZUAZaF/cPKPS
   6o6FaRppwWYYyTk+o3gRr1ydqv98Rw0QsIJq6p4hud8u/ISzE9BH0BAMQ
   I7utNSmrlFL2AGTuwSo0Vbz1N1HO96Ej2DCBOFKmvKia5x9My4H937M52
   Q==;
X-CSE-ConnectionGUID: Nv+FLs30QXWn4dqjTz470g==
X-CSE-MsgGUID: xiTBGxM7QZ27CPk3Ha5gpA==
X-IronPort-AV: E=Sophos;i="6.05,226,1701100800"; 
   d="scan'208";a="8195376"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2024 16:01:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRLShx2/VHjNxb1nN88FKA4OKAs9Kfi8eKb6ogVmY14B7pd3//ytlYS6e9JGIq0Txz6j0TD7e8wO29a0jYCQB25zQlcj8+YEYdFg97rN1xazlWzo7oyToIgkWJNTY4uE5qz0lna1MQfZrhHVf1hYw64AAN9GBk28EBUL5d3wyZ893A/Pgobj1OGLdDmV2dNeJnIKvOiozHletVhdSknvyfFTyC8dRQWyYCUQz/N/7TcjqxqgZGFoxJnWhvslKMAG4/5RsLbM1SM50O4FwYTvLmufVXEeE+XbaJ5+hoD0k2Jj/XHuadhaCbHTyU+AoCPdgf400Vf5GSDCNNycQcpNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lTW5bvFoYVbrW7gkPHP3BbtIqdnlMbcQ5HNZk7Mdv0=;
 b=I/tak8GZf2P+TJsYtL6m/OLjufAay8ArSXvqBKDnLkxqnj+vZJH6ziJncnWXwIY6p/kE7fXD6I28vd8hR4iMJgM0atpbf5cDaNLgTZZ9ZEU23Q6ZckMJOUgJCJ5SFc2x2LaoEyglE00uvyz3sqjVu+SwHk4xd3pMbDI0SxG7bNG23iGV7P78FXnalaePywijvTRBcRCAQ2TcRZ6WP2T6WH0k5gtjJLG4Ceihe8Rm33ym/gUOas80/mTqpP4wz7CYIU5QJy4GBW8DgMTPNBjmhWhassJZ5H+fwv7KSwVZll14PROqvOcXWnCm/mBmDpRElM4gigqmniJ5+hpBk3UBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lTW5bvFoYVbrW7gkPHP3BbtIqdnlMbcQ5HNZk7Mdv0=;
 b=N0wI/d7S0IWl3OgWIuj1AxElEErGUCeHA2D2NnMJQZcwBTbpP0dEwHkVz5r7FKoPbsSe5USJGwOmK4fwf705KBINqEIAvdLG1dHo4JRXjjREG61bf6g4i31iyoz2Xh7HeUHu1ojmluUsezMtqZ+f9OpYnkd0za9wKbVBNCBa5CA=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ2PR04MB8895.namprd04.prod.outlook.com (2603:10b6:a03:547::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Mon, 29 Jan
 2024 08:01:41 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 08:01:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/4] block: update cached timestamp post
 schedule/preemption
Thread-Topic: [PATCH 4/4] block: update cached timestamp post
 schedule/preemption
Thread-Index: AQHaUKAVqscq6cU+ck64RpbGM6WomLDwcYcA
Date: Mon, 29 Jan 2024 08:01:41 +0000
Message-ID: <9e13afd4-d073-4822-92ff-936788f0c2a1@wdc.com>
References: <20240126213827.2757115-1-axboe@kernel.dk>
 <20240126213827.2757115-5-axboe@kernel.dk>
In-Reply-To: <20240126213827.2757115-5-axboe@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ2PR04MB8895:EE_
x-ms-office365-filtering-correlation-id: 0ecb24f7-6845-43ad-fd08-08dc20a08700
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Wf4FWPcU0daCE97NvMgusurQ5rTELblncJ/MEz1U6sjcY66vdk9GZZaJaxBj3104znarwrgOciAxG7SyzxZrxjnsPV2ClXfpWMLtH5sdsZTCCJ/kozYUtSVrKPj6pUqV0WjEvsmjD53fadzlsXHHeuUSxgUEj/+LXj1J2Dz4rXuEIJPPtIs3qXhIkPKrOj77J4p2IEFanhv5fInX2MWFPBYV86xv+eh9qBzDQgyovLBfFbv5xgG8wJe8CdiGE3ZGlMqfQmi2W5BqIy/91JY4g8gtk/1JheXbreBIfyhs3FN0yCnFSXjcTA1Cexz7QjnSXmBuZsILep7A2UAGddBGjsKgH5tPT9BM8Xba2BrD1o7qbTpt0ePDvttD7iU8dYAYaPmiDijYs3QCohXVOTOVbQlGMcd/tcMDDgwvWc92nKPWT2EChRznB/K7qV3stge6+Ui6wEetCqATpv6w5eO10e9etlLqhbzSZrdaB80LHNOtTMIZbb7e/D1odCK/psvgITbuY04LoNFUGcEH5/9Joiu0sw8l1KYhfmq+p0c3JIOOIcv1LLj/td03fLTRMycWuDz3e3KzHarA/tmaVH0JXOZNDMIM1Fab5bXJwp3xAEp4yDOIGS2lVVZapgkld82Xo6cGCE8DOSyLAUtxfZqYbM0qEBu2WpAwtnlvnRPzcS27F3zz+9g2t3fXUXrG/iaG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(83380400001)(6512007)(6506007)(53546011)(36756003)(86362001)(31696002)(38070700009)(82960400001)(5660300002)(41300700001)(8676002)(8936002)(2616005)(38100700002)(122000001)(76116006)(66946007)(66556008)(66446008)(110136005)(66476007)(64756008)(91956017)(71200400001)(6486002)(2906002)(316002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1JRN1hoaFp4TW9aekpBZFQvSklJRk5xWmN5M3l0SWNnYWx5bUxRMU1FY0lM?=
 =?utf-8?B?alRlcWhIaW5kak1tUjBzREU1dHU5enBsOC9QNmJQZW5RSGpEZGp4SFJRYWFw?=
 =?utf-8?B?UjRvcEppYmh2bHlrWktqUjFmZmZlaWI0MGV4TCsxVSswQmRGcER3ck40M0k0?=
 =?utf-8?B?bXUzclB5bm5YWGZBS3NDN2p3czBYSUY3T1p4blpnL0lEbFRjRmpiak5IeVFW?=
 =?utf-8?B?TTBHdUZrb1ZZcGlBT1RENmV5STdGNHRLV2dKVUpCUytYNDM0QWZNa1NuUjdV?=
 =?utf-8?B?aGJDRThabkNiVTlFdmVnZmkwQ2c3dU1MNEU2Q3AwdzIxVStLZnlMcUZJSGhS?=
 =?utf-8?B?YmRVbzFYNm1EQytaTE1zRXcxUGtjb1ZtcGplSDhLenFvbURFbXpDaXZEQjl0?=
 =?utf-8?B?UExQTDQrNlpsbkUya2VKVllNWjlCUEpKeXBQTThIalduWmlKSE5TSGtJYTY4?=
 =?utf-8?B?WVBjN3B6UW1oLzV2SlRRSHJROUh2U1NpdlRzWjhWaGU2eGNqUzE5SHdxNnhF?=
 =?utf-8?B?SUVQL001TTZCbzR4WjRla2xodmp5QzB2WlhFOUZOWjl3VkxCSTlJUE93a3Jr?=
 =?utf-8?B?bVc2ckxPMFFGcHdpZFhmc3IrbFgvWTZGdVJsemJ5RXhVRzZGRUhQdEVGYzN2?=
 =?utf-8?B?cjlnTVdKUm5ZRTZ0d2JZeFRRMDBoR2FVem4yMTJrUVBuU1ZYcVZwQ1hxS3hi?=
 =?utf-8?B?dUkrbjgwT3JvUWcvNVJPRVlTcDVZUERXZm1zMXIxcTNlSGYyU0xJSUlxbktn?=
 =?utf-8?B?V3V2Yy9zSkZnUVVnbGN3eU8wSDFSSDFvRjZJUkhSNjdDMEh5SHpDU3dzSkRX?=
 =?utf-8?B?eUlkS2lXNWFTeXk4TlFJOExvMUNUMlRiZVRTZjlQYlZWWWVSYVdZNTFONFZR?=
 =?utf-8?B?V2U3QjV1RFZqWnkweXJvM3NQbFgybU9YQUhkNXpMQmIxUDlHKzBOZkpVL0t5?=
 =?utf-8?B?clZRLy9aV1FUeWNsM1BlTmRxTzFoeUVYS3dvaUFTUVZPcDZydEtZYXBBa0tu?=
 =?utf-8?B?SGNOQVV4dDROUXdvdjE2M1kxV2ZrNyswc0c4Q3dtS3dVKy92djRqd2lnWU1a?=
 =?utf-8?B?RWtlbTBvcGM1RzFuS2J3Y3FWWmI3ZTI0YzNRUVVKbGNicnQ4bnc5ditlZHZp?=
 =?utf-8?B?Z0lKMHJqZ1d2MVlhTzVMR2ExRkJnZUJNM1IyeHpwL2VsMXlRdGJUMzFzM3Q0?=
 =?utf-8?B?T3FaWi9qeWp5ZXZ6ZlBpRE9KckJJcTlPcitMcmpLTUlVM2lWa3cwQk10NUxF?=
 =?utf-8?B?QU1WcEhmenpMWnlSWm0zYWM2cHN1WTdIWG4vRllISjlPanAxMFU0UktUUFh3?=
 =?utf-8?B?OEVhSGVqWk9ZYjB6SUVlOWk0TE9QMWhrUlZWcjNVOXp0YXJMeFRxY1VneXln?=
 =?utf-8?B?azlidFUvNm93aW8raUJTMnNrTzIzVEtCY2poZk14eHNvT1N5b3NtZFhORVdj?=
 =?utf-8?B?b1dVZ3BZVjROS2VqN1ZnTmxUN2NlMUNuV3c2aDh5TEtJNXRmeVdGTG1nREJ0?=
 =?utf-8?B?ZWJ4MytoeGpxWmJRQ01jZ0xMV1RSeG1BSy80aUhaQm1RKzFLcTVmQ3hFNlYv?=
 =?utf-8?B?SVEwdkF3Wmh0R2l5VWtqTmFJVEJPelk2dVV2Yy9NdTlCSWVUenVoOFhXNng2?=
 =?utf-8?B?dEZaMmtaOEdkOWpOUXdmU2p1cmRtekhJb0ptOU80MDlSSUNmQnVtTlYxbVhX?=
 =?utf-8?B?ZktXVVpZVEdXMVBIRFgzdnMwMnVYS3ZzcUNDRU1oVU45MEg4L04wOUNXejZN?=
 =?utf-8?B?RFZuRlJ5NzRnSkdIRVJyT2FTL0JBVGkxYy9wUlFuTUswUk56eTY3WWEyZ3Q0?=
 =?utf-8?B?Z3NybTRJejJLOGJEUy9CYjFzOHhKTHYrZ1NucGEweWhvbHVTNzdyWmlZRVFm?=
 =?utf-8?B?cWhtalhjcUZMU1JkSVdqWXc2eEJyUXMvRWgxaVFvTnkwZFFnVFRLeVBnK3k1?=
 =?utf-8?B?ejEzeDJ3ZWlMNE85a3dvejVTSHZneTQxelRwMGtyaldMYjBkdEEvZnp6Znpv?=
 =?utf-8?B?V3FqMER6VndZUnE4SWpUTHNEZ0xXWHlybUdOd2lYR2RCWXpQemREY0ZQd2h3?=
 =?utf-8?B?ZkZPNEJYbXc4L3N3TkM4dG1lN0FSTlpDR2pKVjJYeFRRYzFObm1qdFZpWkxi?=
 =?utf-8?B?UkFKTVpqK1h6Q1hZb1VNSjRKTXNsUnFLU0hsb1FMR0lhWGdPT25Hd2ZKbVcx?=
 =?utf-8?B?RHJubHBCNzU0eDVwU01yeHBOYy9naGNqeHB4Q2dzazBULzdrN2orRDR0OU05?=
 =?utf-8?B?dGg5TTR1SUNGOEtVQ0I3K3M2dW93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4429D8A6262C0447906511B192A21DA3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	38a4OQeaObbtmJ1MrHucJMTjyHe0KA/bHT2vIl7T+woNTyo6Y6zjqTWEV4jH/CeP4t01eplK9P3DAzqNVyI7Kq6RMIz9kzJDQ/hNJ9FYZGAKFWaw0yOrjjuZN/S1b9VpbiEF0ZzMPbg1ksg5F2Kwv++mpvWeCSkZsVF7oX1+2CVRBlZuKGoPW4hartXEHi0OJqq3clRspmoOMwbAHBIdWXObo1OysJchgKLLPIBZfm4Rnx8KgDVvUShS1t42cfQ33kNPKT2ks3ny7u8CM8s43IuMmkE44O4DpqkfiRFW4p+nFJDbu+q1yPawG1HyFrDxYga4rPj7FdT07Paoxl/jKWhl8rRb4tJ0OnIx25M8Y0dVGIo7KO7l8dLnbQQFdlu2jGXXnUAjc+TKRL33HhsLvSvBrB4Au7fxjHdLMMfo/bqAmjZlazidGy6EFXTrhUeonnWuHiUIdZ5+PX1TaZB2a42W3UeoRrU8HSS1ZicWnL7qj8SVmvzu/uIkxqNRkY8kd1fqsMlKBW3lysTKFTj8pne+/saB/oR5kjN54PKHAVN8stzgu9ShceeW3UwkYUbKySH1LCqpG3+1AHxnNE/44ulv3TyvZZ3haU0YXwDhRHd6x6gZdGiHlz2kKG/uLiWQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecb24f7-6845-43ad-fd08-08dc20a08700
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 08:01:41.1115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWGXUNhju/PqUClr3dUKzzs7omaSUNO6xfzVx5aTTJRt093pZoVlpvTWnUQqtKua6ZLCFvBrhnM24xD+bI0z69lr0rWOEmKBV+WitiSxHIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8895

T24gMjYuMDEuMjQgMjI6MzksIEplbnMgQXhib2Ugd3JvdGU6DQo+ICAgc3RhdGljIHZvaWQgc2No
ZWRfdXBkYXRlX3dvcmtlcihzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaykNCj4gICB7DQo+IC0JaWYg
KHRzay0+ZmxhZ3MgJiAoUEZfV1FfV09SS0VSIHwgUEZfSU9fV09SS0VSKSkgew0KPiArCWlmICh0
c2stPmZsYWdzICYgKFBGX1dRX1dPUktFUiB8IFBGX0lPX1dPUktFUiB8IFBGX0JMT0NLX1RTKSkg
ew0KPiArCQlpZiAodHNrLT5mbGFncyAmIFBGX0JMT0NLX1RTKQ0KPiArCQkJYmxrX3BsdWdfaW52
YWxpZGF0ZV90cyh0c2spOw0KPiAgIAkJaWYgKHRzay0+ZmxhZ3MgJiBQRl9XUV9XT1JLRVIpDQo+
ICAgCQkJd3Ffd29ya2VyX3J1bm5pbmcodHNrKTsNCj4gLQkJZWxzZQ0KPiArCQllbHNlIGlmICh0
c2stPmZsYWdzICYgUEZfSU9fV09SS0VSKQ0KPiAgIAkJCWlvX3dxX3dvcmtlcl9ydW5uaW5nKHRz
ayk7DQo+ICAgCX0NCj4gICB9DQoNCg0KV2h5IHRoZSBuZXN0ZWQgaWY/IElzbid0IHRoYXQgbW9y
ZSByZWFkYWJsZToNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9jb3JlLmMgYi9rZXJuZWwv
c2NoZWQvY29yZS5jDQppbmRleCA5MTE2YmNjOTAzNDYuLjc0YmViMDEyNmRhNiAxMDA2NDQNCi0t
LSBhL2tlcm5lbC9zY2hlZC9jb3JlLmMNCisrKyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMNCkBAIC02
Nzg3LDEyICs2Nzg3LDEyIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBzY2hlZF9zdWJtaXRfd29yayhz
dHJ1Y3QgDQp0YXNrX3N0cnVjdCAqdHNrKQ0KDQogIHN0YXRpYyB2b2lkIHNjaGVkX3VwZGF0ZV93
b3JrZXIoc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQogIHsNCi0gICAgICAgaWYgKHRzay0+Zmxh
Z3MgJiAoUEZfV1FfV09SS0VSIHwgUEZfSU9fV09SS0VSKSkgew0KLSAgICAgICAgICAgICAgIGlm
ICh0c2stPmZsYWdzICYgUEZfV1FfV09SS0VSKQ0KLSAgICAgICAgICAgICAgICAgICAgICAgd3Ff
d29ya2VyX3J1bm5pbmcodHNrKTsNCi0gICAgICAgICAgICAgICBlbHNlDQotICAgICAgICAgICAg
ICAgICAgICAgICBpb193cV93b3JrZXJfcnVubmluZyh0c2spOw0KLSAgICAgICB9DQorICAgICAg
IGlmICh0c2stPmZsYWdzICYgUEZfQkxPQ0tfVFMpDQorICAgICAgICAgICAgICAgYmxrX3BsdWdf
aW52YWxpZGF0ZV90cyh0c2spOw0KKyAgICAgICBpZiAodHNrLT5mbGFncyAmIFBGX1dRX1dPUktF
UikNCisgICAgICAgICAgICAgICB3cV93b3JrZXJfcnVubmluZyh0c2spOw0KKyAgICAgICBlbHNl
IGlmICh0c2stPmZsYWdzICYgUEZfSU9fV09SS0VSKQ0KKyAgICAgICAgICAgICAgIGlvX3dxX3dv
cmtlcl9ydW5uaW5nKHRzayk7DQogIH0NCg0KICBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQg
X19zY2hlZHVsZV9sb29wKHVuc2lnbmVkIGludCBzY2hlZF9tb2RlKQ0KDQo=
