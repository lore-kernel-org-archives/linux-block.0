Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2018.outbound.protection.outlook.com [40.92.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E6C1420A8;
	Tue, 25 Feb 2025 03:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453215; cv=fail; b=YjnEE+9nAKkmOmLcIPgjnUKr5C+6tvCdRjLErrm/dwWJ6L867lHp900VT+3yUfRD7+YiUT+mg2o+dOeaZFzseHaE+Nyqd+KFXimol8R2hRf5X8gCwW+yVbYAKSS/I+1Ai5fqXc109BrIhvT8L5tn6OhIKTLpWBwpQQdReEIsyaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453215; c=relaxed/simple;
	bh=LnlDj/dpIooRiaI7NveX1cugG4u6EYaj8FyXMKyzcH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIQF1Y0aZXJH1x8zTFdPumKQs8iLyoIm86vuh4rw//m4IsT5XbkC3kk2AkbV5hZ5OtBboh1HCR8Wo+d/04iL9+6t+7ydxBlP88Sq6Bl+7G/KfTuV2PhFllc3wDF0B729fsRf8rVGzgJ0rIdwk4NbcPq62NIM6PVllr1nYkhar/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QE1O+iUm; arc=fail smtp.client-ip=40.92.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QE1O+iUm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIkJ37/x9E/fPSliQw119seQ+HZkzt9EWsqDwxKAeeis4UC4xjfESbOTRI4z/c7w6FfDzPsfN/0/90B7P4QNdSKRljRb21SUiwZGA+3bsuXCfHWtKSPXfrpfZYKTd/4zce92Q4FAStPlu/v2O1Vfy/o9QIeC0Jj+iZEm8YDADgWdXtGqIV9wSQLY2OygUy8hEFndg+Nb1cZ9Xoo3ddzq8RVLTazc648RQ4nFjNOJSqDgSmzbxF61jDQp7nY9z5GH3GVaek6eGir26Zl9wPOdEXaSHTmZcNmUJi5GuNcLu9MDu3+CQM1SqYA/pTuWfX+U/E9Nz7X35sxHqL+fTJaIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RymGV05kngeUnK9wWZkFE7pu/LfEeajYXhXI/N0/hs=;
 b=M64yaDU3X4jLbbtvqGFi9apFBfBPeUyb6tgNnylwARe957a3gQtnM0y+FKLzkVq3bYpV5GfzJGRSbtwO9GrOUsOniuajXDH6UjuVF6/0NtG2EQxnruZ/oRgeHNLh7OLzXEdkAm31rzOFntOBYntf+D7e94jazr60S7R4uKh7V9P5ZyusafhLY3qb54cjSqmAE6uGZuisb6628P3fRbFxazUg57O0GJ07yOd0I7TIHdQwE1rrqeGvrAwBaA0XKOHJraXOxZLcVdajB/RZz7TI2UVDc/TWs6FOswxMSp3RCoMdgPAFFplqKRP0I9sOaJM0Avq+eJ9/ZFcmZzSZxnxWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RymGV05kngeUnK9wWZkFE7pu/LfEeajYXhXI/N0/hs=;
 b=QE1O+iUmjAcyJwQnVtSQsgKH1IkZm+hgTqGXnkKaNq62p+k8MdchuBAkPeDeoxclopT0Or3ZRXIe9yStiiti1HCVhaoBYfDCQQDc/d6bnvZPKyLjEBVG1t2brdtfMdNKZhznNqLr5gut8dmpi/5+hKaCsU7nHLG63AiUxCajDQ32QnbxPTLkwugG6mb71Zimi1hW7W/V78TXNI/wExZoAp8hUd7Bu0XQntnZeVS4QLpJBY2rmzjYhmGv4M1uW3h0pI/L13aB1fQzeGTG50hDjm+9O77IIo+C6YZN3LimI8BtzcAeelfBPn3/6Mnnuv7NrQAq134udPeqpUTeNsWXIA==
Received: from SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:297::10)
 by SY3PPFC6CF4E418.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::4ac) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Tue, 25 Feb
 2025 03:13:29 +0000
Received: from SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
 ([fe80::14bc:d68f:122:f4f2]) by SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
 ([fe80::14bc:d68f:122:f4f2%7]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 03:13:29 +0000
From: Gui-Dong Han <hanguidong02@outlook.com>
To: Jens Axboe <axboe@kernel.dk>, "justin@coraid.com" <justin@coraid.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
Subject: Re: [PATCH] aoe: consolidate flags update to prevent race condition
Thread-Topic: [PATCH] aoe: consolidate flags update to prevent race condition
Thread-Index: AQHau7K/LFzsoYnPoEqfvzlvrpI2Q7HEWvuAgZSTnCY=
Date: Tue, 25 Feb 2025 03:13:29 +0000
Message-ID:
 <SY8P300MB046047D3CF98899A011F9AB5C0C32@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
References:
 <ME3P282MB3617DAD141ACDD21170355E0C0C72@ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM>
 <795edef9-2bd7-413f-bba2-04d569da63b6@kernel.dk>
In-Reply-To: <795edef9-2bd7-413f-bba2-04d569da63b6@kernel.dk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY8P300MB0460:EE_|SY3PPFC6CF4E418:EE_
x-ms-office365-filtering-correlation-id: 3e2e0fe2-d8b7-4bd9-3b4b-08dd554a608e
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15030799003|19110799003|8060799006|15080799006|8062599003|7092599003|440099028|3412199025|12071999003|21061999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?lSgkH3QgmluxUSeE7dhM+gzrgzHQ5fGqPNsOeHz5vAncoWcslEgi4aH60N?=
 =?iso-8859-1?Q?onGpEjg++mWzBxi+dReNU6csaIBnnzzDqRLiwAt4+u2dCCx7I0UPmq5Hlg?=
 =?iso-8859-1?Q?5Cl7M80/XkI86iByxxSybyWbRtTsOBbbc1eTTI1iSlBFztYT2MD6sLBMBO?=
 =?iso-8859-1?Q?xGyWz/bA+ufOm36gu6VjvSIUTXv0TTwXIcyx9C76EDNZT45FNvYCuM34EP?=
 =?iso-8859-1?Q?+1P7H+heO22U9YHEJs09VRYo2Scd27j85mKPiMhXhghWfVsQ9SpxpXXYsd?=
 =?iso-8859-1?Q?WmPk5Ir5Iu82WybM5Nh6xCCwoL7PRXqLH9z3LL/0IkKUFlZS2CNg4jmPvv?=
 =?iso-8859-1?Q?DS0blm7hPAs1iYuwpOr9XEXsi0l1odFvk3YaW5/Z2sma1YsD1lNU49naDa?=
 =?iso-8859-1?Q?q+p2btnwj+SfGFvPn4W5ZUndgshHi/cwsFC7ChalfQ5UOVhWGVbMDic9Pd?=
 =?iso-8859-1?Q?N612YktfZw2gkpHSpGF3uBiZJr7HSmvjLrOHMmcdhfrOoj2a09MNRK7HCM?=
 =?iso-8859-1?Q?1Fm1lzGdqBJRxNAQh8n9A/ambvS/Xv55UFLEujqso55NmPLszcZ9/C1qnU?=
 =?iso-8859-1?Q?Djah88RynlelTXGwqXf0nT1hgKsM6GSl3Z8vDL/NWr0Wm9+OyFaihp/fYT?=
 =?iso-8859-1?Q?G7b/rH1GSx1WTkjEemQxU3UJ2oG8SXp5ggYwCkBQPLC8oWNmIZTGjHcLkh?=
 =?iso-8859-1?Q?2mYZsTjwsp7draHRmH6ZR59SIXT//cfppNDxiCW8Slo/WBtcC3NLYLtU9E?=
 =?iso-8859-1?Q?YY900QX47Wu6F5n3lXITbJEm+KOdz4JhSQzGRIc+BJySNUASDKS7Kqr8l9?=
 =?iso-8859-1?Q?WGsKoXzV8d7eJDgEZrA/XwGoe8CW1jnxjtYhXKjlsAT8CcfQd7qSConA+8?=
 =?iso-8859-1?Q?7M72FJGL/FCYd2aJVQKXwtUu5tZCmiLolgssDFpNjBaFbZcXJDOwhlntq1?=
 =?iso-8859-1?Q?v0FJ9zJ6MEFi+ZoC4aaX3Kn6k1ucdWWd/I1W5Aq52CPjLIa4trJ0/wZVPt?=
 =?iso-8859-1?Q?sya38pXkHeW6unHf7JmNeZv5Rqw0MzlypHQE+TnJua6vFS4oHj7sO0OkU7?=
 =?iso-8859-1?Q?/uaXvfTd184appjzAxFdzjtn97iGWyRKQtDss2N1+JzIjCnf+y3hY8snTV?=
 =?iso-8859-1?Q?uR6SsGe2SYnN7dLzE8IzTrppywjfKykEYVTl26HMI0FIJEyeVXYJwEZUuQ?=
 =?iso-8859-1?Q?APSrVDewNndoVe8dJ494d/K1MUqOzN6v5DI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?x2ySzn8/1YuvHfqBMiF/OK9/5x3WbH4U9CJv04yL3l8ErU5l04YdZlZ7Mj?=
 =?iso-8859-1?Q?oC+R2TGraqRh92yc7MhJ0mz+2gyLtdjX4zxS2HP+/HgFq2A2thuB9dLJhV?=
 =?iso-8859-1?Q?a0XxBoyGXxFxeGjGnYAg52QLUUTmhYmH45PlKHINaqlpEUqCpnIeOm2Jgl?=
 =?iso-8859-1?Q?DFmy2gpe+TOQm3oEoLk5DX48U67X2b/fqSrW149TKndq1YktnrHjryvwcm?=
 =?iso-8859-1?Q?EdIQ5hQAgzOSb5AoGKXbA06qvgalkKt1qWgBh43sI5CVuf4MT6gBDt3Vss?=
 =?iso-8859-1?Q?T3BJXAsbz43Pf0wX19dKM2aTb0n4Xng/s8IEmDLNwQwfCMw6SvrKoi90Fe?=
 =?iso-8859-1?Q?b3uxMCUmXJXmENklOeUe42HEil6SBLqNUJYtrT0dI3QXL8Tjez/+epgciC?=
 =?iso-8859-1?Q?Vnb7ydKlqDDhGA7GkrjcPnWXk/jA5ldBG+j6mUr99wqOoXkDNOtl+HOLb3?=
 =?iso-8859-1?Q?MTAy7nnezBbv/Kc53TjMcQMdtqKI5Y9pCylqp6mG4Z+TT1DYxpheJOVgY5?=
 =?iso-8859-1?Q?9acXOX4jxax80rxMd55Qv8p3ObZLTPQSpTqFlUU5bxGaVAjAsEF9kJYQAt?=
 =?iso-8859-1?Q?0vkaytq4NCspN4qRdDSDPJstDEK1vO2bcc+HCK1JIXWFTuVI5ksEfbFbQ1?=
 =?iso-8859-1?Q?dNLQ9w+0ZDdGFGyghFbAZ2x8sOt95MjypPmJASUT8WNLrGO3va3e3H40Fe?=
 =?iso-8859-1?Q?3iRZGFKur4jhJsOAq8uxDFYTMzQtNZMR6p7wjxSQQjXLPcpH1iiixn/DE+?=
 =?iso-8859-1?Q?qj9Gdxg86bLmOlXA1AGauVIvEuOaXYpuC3oNfTv6mfFLuUo9UpOPDLa+iX?=
 =?iso-8859-1?Q?S2yUtl+FEpY87KXNS1/jOBnAFjRX6zYHixxCTDHYJBO6tqseYZ7BCbBxBa?=
 =?iso-8859-1?Q?vYaOzk2tLeLkxnJQ5fdpwyWVlcnbMbjvlhpIQhaUpZHgoDTJvB0CWD0vLs?=
 =?iso-8859-1?Q?jwmAsJLdhOlvS2C8ZyYXgJvRIR0jTG5pYQ54Or8JliZpZOgyrcmjk4hq7T?=
 =?iso-8859-1?Q?pZsaLUKQl+xrhRiYTj11c7OoTczdGMcBpkk0gyDwZYg6FU+I7vJ1kyPlsM?=
 =?iso-8859-1?Q?SxnuXeXyTHJ+WN+dMcwPSaOMIamqv6qY86JnTn+Mc4nYEzVq660f4KEtts?=
 =?iso-8859-1?Q?BveMwNCoHP0FGjkHMpG7VW3IvV/dxViw+D3LYPkK6Ig1/N27Nt7yPpjJ4O?=
 =?iso-8859-1?Q?VipzTcuoBqRk4C2hPg+epRXkiMKSyU+wEUaLhXNoBIOv78/OItP32NTVg0?=
 =?iso-8859-1?Q?z+X1ey8JgmzWwZe6H1dXrfj+Om9tTsLOoqPCbiW4U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2e0fe2-d8b7-4bd9-3b4b-08dd554a608e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 03:13:29.2140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPFC6CF4E418

Hi Jens,=0A=
=0A=
Thank you for your feedback. Let me clarify the rationale behind this chang=
e.=0A=
=0A=
On 2024-06-12 10:54, Jens Axboe wrote:=0A=
> It's modified under the lock, and any reader should do so as well. If=0A=
> not, there's a race regardless of your change or not.=0A=
=0A=
The existing implementation contains multiple unsynchronized reads of d->fl=
ags.=0A=
For example, in aoecmd_sleepwork() itself:=0A=
=0A=
void aoecmd_sleepwork(struct work_struct *work)=0A=
{=0A=
    struct aoedev *d =3D container_of(work, struct aoedev, work);=0A=
=0A=
    /* These flag checks are performed WITHOUT LOCKING: */=0A=
    if (d->flags & DEVFL_GDALLOC) <--- Unsynchronized read=0A=
        aoeblk_gdalloc(d);=0A=
    if (d->flags & DEVFL_NEWSIZE) {  <--- Unsynchronized read=0A=
        set_capacity_and_notify(d->gd, d->ssize);=0A=
        spin_lock_irq(&d->lock);=0A=
        d->flags |=3D DEVFL_UP;        <--- Two separate writes=0A=
        d->flags &=3D ~DEVFL_NEWSIZE;  <--- to flags under lock=0A=
        spin_unlock_irq(&d->lock);=0A=
    }=0A=
}=0A=
=0A=
The problematic sequence would be:=0A=
1. Thread A sets DEVFL_UP under lock=0A=
2. Thread B (or same thread) reads d->flags without lock, sees DEVFL_UP set=
 but=0A=
   DEVFL_NEWSIZE still present (before the second write clears it)=0A=
3. This could lead to unexpected behavior since DEVFL_NEWSIZE indicates a s=
tate=0A=
   transition that should be atomic with DEVFL_UP setting=0A=
=0A=
By consolidating the flag updates into a single atomic operation under lock=
:=0A=
=0A=
d->flags =3D (d->flags | DEVFL_UP) & ~DEVFL_NEWSIZE;=0A=
=0A=
We ensure any unsynchronized reader (like the DEVFL_NEWSIZE check in this s=
ame=0A=
function) will either see both changes or neither, avoiding intermediate st=
ates.=0A=
=0A=
Would you agree this provides stronger consistency guarantees for readers t=
hat=0A=
(per current code) don't take the lock when checking flags?=0A=
=0A=
Best regards,=0A=
Gui-Dong Han=
