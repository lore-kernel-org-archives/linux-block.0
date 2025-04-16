Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7826AEC
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791409; cv=fail; b=TrOxtY6WpQiM0eURYAuRv8Zu88SG8SMwo5IJ47UfMrFkSma5Cpr3brJPv2QU+VlfwoCsU2aSYT+OzalkGjgBP6MBrIg1gun/xlBON0FWkBRoY2AoZWnN7YUzaSDRoD6XwG6VuLmtzzfDSILslP5amt4Tegd7AYVUvC8zHjUmxu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791409; c=relaxed/simple;
	bh=2tuA5i+qnTkveR7BhuTqjWYaXlmfwEhxKGY6fNGy8Uk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DxPjWMnJjllOp/XJyEG7BcVrC+NEGA/yegdrRvl++YuW03kAgJbGOXTgijJE3Ee2zS2XZTi8c4cgkepuicTvF1acINAU8H6NyTyBrktSmZAVEJGyaqhV4rUKipl8hOliGeOz3FYwsPXAQJHpW9j5dCUOBfo6geidVU81QNeYQTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jg7vHlFx; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jg7vHlFx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPHsvjj8Vf9SziO1gLctdmj3DcPhYRxitE+XJsNm401JdKkn+bZfly1ungiEaPfbcRF/T11C6fNGIo/ksScBDiqnwf7+8Ud0r0nitqFm5AKseVu8PPRAMmGWT4vbbF/LVVeL8qkftkYrngkVggLWISOrktljTB3toKqnNiZ1UVNk0/RUpWpWu8Tj8L7xEW4JFo2IjlHH2DgsHJVRr/raOf5AfM/x3BbXlOwk7p2BGTVOPgZqYT9HCCpI7Zzv26KMRz1qHjZEeuXFcZsw5vYprVIb1Oz55QheRKlq2MNXJIafNie8aUCE12dsT2APjs1amFEbqLu5m8IXwm9xApTVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tuA5i+qnTkveR7BhuTqjWYaXlmfwEhxKGY6fNGy8Uk=;
 b=vs4A32J45Ojx9KPXGs+U870kqLwnBAfKqzo8dHJ3XKZMCYdivPL/0JtWjF035omlC0jR8ydjvkd8I2/BAezHj6tgm03FhHHLGyj8GxEz0K/oKQElflY2ajCGfIg5ujUGaOH9kEYzYy9mJx1Err9GMTjIACn6b4yKpTu/5s9d9Ma9tzDZNJiafPZ9qpQLZYrJdxgv8yY4XYwhCzRPMOB5rpnErRayxN48Jh8oOOqkRe9CPENUbQozCjWjI9epjUJi1sPMQ9YlydePZfjL9PzjLTngf62ZSaaIgq4FfQ54OlytNjFXVah8l/nPbcLzf8wThLSz2pIZC/shI1iIlXipeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tuA5i+qnTkveR7BhuTqjWYaXlmfwEhxKGY6fNGy8Uk=;
 b=Jg7vHlFxoswK+WbT+vMI0y7lgLX6xxZNdm5pby/1lf8gvVdQoHL3SOQpkgrG79h6vW0SvYtUaKVcLutN6C5I7tLGaAzzg/t/JsUfg+15ZxR8G3xwfiMwKoc4uNrsrBc7pIlTvP5Yp+vWRHST8NGGRZl70EqbyZbhqTZS8yHnWOCiAhQtlziYF8nbBdelH7KlogJdFv47XQ5/Rg39IUWz5GPrIZpSR+K43nymiU3cXNNl7V1BdoUguHOKNyo9fzHmcjK4M0ti6Tkiqta6mQ53fpojzLIeiH13bKLefDm6lA58VTBcjZtiBZnBKVH8FpyaJnyczg/xZa8NX/L1jIW4gA==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 08:16:44 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:16:44 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Uday Shankar <ushankar@purestorage.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: ublk: Graceful Upgrade of ublk server application
Thread-Topic: ublk: Graceful Upgrade of ublk server application
Thread-Index: AQHbrd5cAekQDakHykq2J5wD805DDLOkkQSAgACQ35uAAFXigIAADS2AgABtzQc=
Date: Wed, 16 Apr 2025 08:16:44 +0000
Message-ID:
 <DM4PR12MB632890760804D06B3CBC357AA9BD2@DM4PR12MB6328.namprd12.prod.outlook.com>
References:
 <DM4PR12MB63282BE4C94D28AA2E1CACA0A9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z_49m8awtNFsY8pl@fedora>
 <DM4PR12MB63285A6617D8A9B9F22B912BA9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z/7/LTSxqLH7JgAl@dev-ushankar.dev.purestorage.com> <Z_8KO5uJfkB-SKvT@fedora>
In-Reply-To: <Z_8KO5uJfkB-SKvT@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|IA1PR12MB7615:EE_
x-ms-office365-filtering-correlation-id: 93b60298-94a1-422b-386f-08dd7cbf0641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3S8Kd/1xhgH6AnQ+wb/xz6r00Gs1DUz47g9vCr0CuhwMaaLIIA0QHsETIM?=
 =?iso-8859-1?Q?3fmgDDJN/sc3kQGTdZmXQYZiIsyr6r41o8Eh18qiOjsYBefJcOhjrSjaDc?=
 =?iso-8859-1?Q?6MB3HUDAwutNlmjiHOyUaYjNS66ZZRL0oQ7UJx2nuIb+1U/Qf5PUCKeMH9?=
 =?iso-8859-1?Q?J01H8h2sypvtOvWOy5r3SmTA0T3a8J4Rg92Hx1zDv+KlNINuOesd/wUgo7?=
 =?iso-8859-1?Q?/gOgZXsdW446Wf5ChAmQ9+A70J4dj3TXrXEfDc8ddkl3tIsJowpaSPxP6/?=
 =?iso-8859-1?Q?Y/jLXNqhuXLTywMPDCmr+9WWfIeUMpWqJMZXzGKyrzVANHepduFxSIqdyb?=
 =?iso-8859-1?Q?+Sc2AoYls4lbchJac0Kb+7FyOlrQa8pFniMmJJ5QDuU9Dvs8Bo29Eo8Wih?=
 =?iso-8859-1?Q?09Pk2cjioKMQBObit3HGCl63kkkzjTPDhXULgfMURISMyVj9lw4Ue6TI42?=
 =?iso-8859-1?Q?+Hr8GEVycxOk8dajxXnxzo1bu1EPdUrXFPo/vQLDV9cQWcOPl4vlFR5P5D?=
 =?iso-8859-1?Q?50dSxmMpz1vF4r4mEj2hPH2ehzV3sxVstiKQkxGBIXoOKT1DDOfZCYv4Tn?=
 =?iso-8859-1?Q?cqCqm+elb/Rq7Vx95gx5qAs/eb2lHsc4aR0pK9exuUdWB6mWvTp3kNwjTR?=
 =?iso-8859-1?Q?NA++w+3Kvl9Lf+5qcvbrxtn4Y+HKH7ZePLshwTMrpRHjdYkkv9HlIwxYtI?=
 =?iso-8859-1?Q?pUu9ed96cUHi/lClEERCjl4YDzMAcYy9KkzHsrJmWgjXqXuv/fZ0GTqbZb?=
 =?iso-8859-1?Q?E5Wu44RFfBFsTF4iRdC28E7USlNL9CCWg8YY2ybOmEsHqJacKW4ONqpuVC?=
 =?iso-8859-1?Q?UCAbbhsfSyO6lzFNp5A4qQN0nLjBYpSB+ugHhP7sm0DWOxC2xXwX36fTcu?=
 =?iso-8859-1?Q?fEUe4llfCbvCBSckmHyI4sdUXAq8qygNPe+yA4yALBwmc4WdhvCE5oMuAJ?=
 =?iso-8859-1?Q?LMm+E+B8+vLlB4jjseMSRhUDUKdkSYA78hkWMd2lUj28JQ29CLl/sIX9Nf?=
 =?iso-8859-1?Q?jIcUt0sqZOx/86tF3eRXyFCkkSqxZbfrM67O2XW9UQukg/8iye2YYC4Re+?=
 =?iso-8859-1?Q?AlyEI8pnI8Tm6tsvoDyPrIrIRI5twlUJOgmGRyXcHSo1k+RygN2wrTtPJ/?=
 =?iso-8859-1?Q?QCcq04gNUhGkmxeHJwhXJHQLJsa1dMc6O1LgKvf1F+yBPQFKqAyKfIPLgJ?=
 =?iso-8859-1?Q?azGVcbcMqH4ZXLF2QpoGSGKtIfFZ/22RpYpnZOmlVsLm4icNc1qLbiKJVY?=
 =?iso-8859-1?Q?7YLyFVEbHzdZ0LE2KK9xwpPJREw3G7t5SBZsO9kw+LkPywWJDrqrXoeUfm?=
 =?iso-8859-1?Q?SM5+f77wLoiZ/uCWAZ56rs00lGSqxt0mEvM0RYbr4pcZJ5k5R6wB0AWdd9?=
 =?iso-8859-1?Q?Dzefd3tjcKaqI/L7lre2mS1djlFhczMg8/T+IrMCuDc/9LMhj8tuEY6Dl1?=
 =?iso-8859-1?Q?PwDg0BgOi7T3+CETtTQZ+P8sYUYNyhYNwiHNO5u+wM1aFmSEGjXnv+0iwr?=
 =?iso-8859-1?Q?dmBjJAFoHH66dQus4fXrdeUcFB+p4RfR/i+GKC3cZMKX1SpT9mXEqeAcJP?=
 =?iso-8859-1?Q?fpDwlyg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aTzRepHt+psDo6Ct039Hi7NMiy8tI2YE17FUUCGKrwnz+x6j9VbOaXUEU8?=
 =?iso-8859-1?Q?acidu3Yx7JC41a/80bXEGw9KcO/QSfChOTLuWg7dr3LecU9KNLsKLNiSpO?=
 =?iso-8859-1?Q?ART3uDHryO2sNgLLFFPGTlqMCpyYtLvIfSAkfMTsNYNVv+MFZ6qd5KbftU?=
 =?iso-8859-1?Q?I56eDYqVic3Izo+lUHAbF7dNGPgr/aeRLzDDdKEG8IPjyL28kX6wE8gZcP?=
 =?iso-8859-1?Q?3PejD806NQNQ/WBtLRR5ZH8A+kkOrl6tGHj/PB9W8pWZYFN4AHIdpii/Mm?=
 =?iso-8859-1?Q?akmfvDJQGvgVjUjyDX4MuSVj9njyHOphnVDJqaULFS4D/Ihvgw290epDhV?=
 =?iso-8859-1?Q?HwkoJ89QoGY/5i2wkWRj3jX+Bo5BDvRuHf6JI9Z2FerE3wy7FUxXuSRybX?=
 =?iso-8859-1?Q?i+YIbIGZrP1JwkscJOaGodd8iF8PRd35VHlc3P7NPTnigyks2SIVCat7GK?=
 =?iso-8859-1?Q?N4IKSFpmvanT8slSDgZE76tLESd3laIrTE7nG1AuTfmB2AdDCkwu9nAsGP?=
 =?iso-8859-1?Q?3pjn5kYJqXWt5YUsxpbxgEnhfgLjLRbRPzcJdcGPAGOtvYxJJ8CYD/G6EI?=
 =?iso-8859-1?Q?aeoIUttVlJg1cPlxNQE4QeCfJ6HzBRfmlehlJHdDAAoI30RzoGwD+Otbj9?=
 =?iso-8859-1?Q?XoY18/cjh24rbxquEPQzZPH8TIvqORtmXshSQfifPD+D7SgalujaczyGgO?=
 =?iso-8859-1?Q?0L1CizMGps5TKF5Y3ezBcuBA4Pf2lR/zvG7dbj0yjheWWWJcj7c7pwZTkg?=
 =?iso-8859-1?Q?2hqmJCwYA75Xt8f1z2PEMWIJrsmXFwdt2p8b/F9DP7uDZk+mOX0Jlf4xRi?=
 =?iso-8859-1?Q?8dyWMKsJLd0VNkc7wJwZCDUG8ZhC9VVdp6qL4K1ewiJtDJ5+Y8FyGdfFiU?=
 =?iso-8859-1?Q?XbjeOHsmwGABPOqmPqJrWDUD36bqymHqM/lImji1SL1DbfgrjLRhDPqB3C?=
 =?iso-8859-1?Q?Ra4lBJ8kKhJezZVV7i0w3sg9N7XyJ1OOnhgz/SmQ7MVQXWnVyMGn5YflU1?=
 =?iso-8859-1?Q?FjWfqphdNKJSd3YHQtI4z2O1ZT6ugd1VQL2RoENcBbZUFH1uH2Cg1id3ee?=
 =?iso-8859-1?Q?Om4GgbVM7XFdl7BPrksWigvF6VnnIARp6moK2Ans55pFq3twfPYoBBCxUc?=
 =?iso-8859-1?Q?TVgiMo4eMdRjZDfoBtb1NrM1iGeZSMX1k6g8ThwRJbDBVrTkcOxz7+EdDt?=
 =?iso-8859-1?Q?54mk+F2k/6TMTBP410f9nMnMoq9s9bYwn4ZlGGuZ/SmsjU6aQc0gk385oG?=
 =?iso-8859-1?Q?KMmorld6Q9NYyhbuZzk52yREGdpeauJ9ddj2gkMRRM/6uyHQGVB1R/ui2G?=
 =?iso-8859-1?Q?qB6rPiz1zf7vYw2MIDePbTuFRmZsoP8mvfa2egH9gWsK/eDAD7CUkJFlw4?=
 =?iso-8859-1?Q?0gGlL9hkQE5o2yhMTPmswVsXOCpUee7oEHB6VZV/Z8YaGmyVzj7oagC+WU?=
 =?iso-8859-1?Q?0ZFA3Z1yMbJRsJwRlif64SXKVIoaMGXBoUD3PVP/gj+qOqL6f2gOltUZaY?=
 =?iso-8859-1?Q?zrzzLCvIGEHpsdQ8JIx/uYqfHKHX9ERkxD74LBxa55aw/kO4dc9qmwJifm?=
 =?iso-8859-1?Q?8K2ftMb9kHIEFI4tk2xfgzj09IyOJn0SqKTOzCe7EXwA/Vuci35AN8PYXW?=
 =?iso-8859-1?Q?D0fttG0FQQcxc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b60298-94a1-422b-386f-08dd7cbf0641
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 08:16:44.1540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6am9sNUbWd7OKEIvvA5nX5Rh4xsQKK5EjwU6pNXsPUOveJVgwMC4hukjLKM/ta+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615

Hi,=0A=
=0A=
The use case is as you say to replace the binary (update) without making th=
e bdev to disappear.=0A=
Currently I don't even use the user_copy(to avoid the 1 more system call) s=
o the io buffer is also part of the sqe which is prevent me from free it fr=
om userspace perspective.=0A=
So yes, even ABORT_URING_CMD by given tag can be enough.=0A=
What do you think?=0A=
=0A=
=0A=
Thank you=0A=
________________________________________=0A=
From: Ming Lei <ming.lei@redhat.com>=0A=
Sent: Wednesday, April 16, 2025 4:39 AM=0A=
To: Uday Shankar=0A=
Cc: Yoav Cohen; linux-block@vger.kernel.org; axboe@kernel.dk=0A=
Subject: Re: ublk: Graceful Upgrade of ublk server application=0A=
=0A=
External email: Use caution opening links or attachments=0A=
=0A=
=0A=
On Tue, Apr 15, 2025 at 06:51:57PM -0600, Uday Shankar wrote:=0A=
> On Tue, Apr 15, 2025 at 07:46:51PM +0000, Yoav Cohen wrote:=0A=
> > Hi Ming,=0A=
> >=0A=
> > Thank you for the fast reply.=0A=
=0A=
oops, looks I didn't get your reply, :-(=0A=
=0A=
> > To be clear, I don't want calling DELETE_DEV or STOP_DEV as I want the =
kernel bdev will be stay while upgrading the ublk server application.=0A=
=0A=
Can you explain a bit what is upgrading? Is it simple application binary=0A=
replacement?=0A=
=0A=
> > It would be nice to have a nice way to have something like FREEZE_DEV t=
hat we may use which will also make all the cmds back with ABORT result but=
 both block and char device will be stay until a new userspace application =
will reconnect.=0A=
>=0A=
=0A=
Looks one reasonable requirement, maybe SUSPEND_DEV and RESUME_DEV command,=
=0A=
which exists on RAID/DM too.=0A=
=0A=
Also when device is in (new)suspended state, parameter can be re-configured=
.=0A=
=0A=
Most of recover code can be reused, in theory it shouldn't be hard to=0A=
support, but one trouble could be what if both uring exiting and SUSPEND_DE=
V=0A=
happen at the same time? This corner case need to be take into account.=0A=
=0A=
I'd suggest to cover more requirements given it should be one generic=0A=
interface.=0A=
=0A=
> Have you taken a look at the recovery flags? These offer slightly=0A=
> different behaviors around how I/O is handled while the ublk server is=0A=
> dying/when it is dead, but they all keep the block device up even after=
=0A=
> the ublk server exits.=0A=
>=0A=
> The flags are documented at https://docs.kernel.org/block/ublk.html=0A=
=0A=
The recovery mechanism is triggered passively, and here the upgrading=0A=
needs to suspend device voluntarily & gracefully.=0A=
=0A=
Maybe add one control command of COOP_CANCEL_FOR_RECOVERY or ABORT_URING_CM=
D=0A=
to abort active uring_cmd for triggering recovery from userspace? Which loo=
ks=0A=
much easier. But it need cooperation between ublk driver and server.=0A=
=0A=
=0A=
Thanks,=0A=
Ming=0A=
=0A=
