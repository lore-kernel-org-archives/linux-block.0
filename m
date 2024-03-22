Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A546199AD
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100116; cv=fail; b=XuGVn63a0f/PPyap4HuUQqXAWeI21Lus5IsHmJrzHoAVlnnrlig13ICtqGF9WRWx4TFuRezWTDlRnTSF72vgfEEJq2oa6RP0xe9mHEVRWTcwVKb7C1davmnfFOdjvBG7OOSWoAy9Y2PwCPEdNl6eXi5qrlDXqPSpDrLpk7OAXZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100116; c=relaxed/simple;
	bh=KzZtVzSJ8oHcHi6h+VyX0tHS9QYpu2ZjMrWXtkeiPZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lySIgRtDsS8UJboqp6Ju0yJMsQQ0iAdkNlP4w2RSPZypUCDrvpIP8V7eYMBk9N2S4pN74aBez9O8lCZWfZvQPyD+cBI5G7bdfcxkOha6SIu4FbZgjfngMYrVtM4Kl6gmB4wJSYKzcu6jzchOXVVMvkPFRBuPMvJGDmUsY3TUN9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qOnNyJ/7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=E6U7/Ue/; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qOnNyJ/7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E6U7/Ue/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711100113; x=1742636113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KzZtVzSJ8oHcHi6h+VyX0tHS9QYpu2ZjMrWXtkeiPZ4=;
  b=qOnNyJ/7/PbOuNKzE3KpALlh+VDjaPLM+kRijeyVozBD9m+VlH7Z06vt
   pdPJrIDpoCOmBI6dFvnPmV9J39sBHk4/Fe+DSCp1WcBjspi6FscK1D3vu
   ANSv7qH9E7ayxDTfQ4jFlv2iQzrXg1XK52pvNDspiGmvILZeQtJYNoJm+
   9Pjy6MyphIlbWM4MsyGg8HQPXgda9pmLa5+5Vjh+eYnRVQ3vIMvRFWMS3
   fYhp1NPFwnqf4fo3YPr+OiAeLxYr1pABEfB4c1PlGJ6qy2gHevNQBXSXU
   yPzSogYZWLN6Ql1PYzMMvU4uKhGV2/ITjHvdxCH2H4LrxfoCkfs/YfG8k
   Q==;
X-CSE-ConnectionGUID: 8cKhCR1xSV6CFv0evjOg6g==
X-CSE-MsgGUID: tHe7WEQxSfavilDRkQo7RQ==
X-IronPort-AV: E=Sophos;i="6.07,145,1708358400"; 
   d="scan'208";a="12478438"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2024 17:35:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT6w/anUcj0wvGNZMhfgINngZ3A5tCLM0zLt3ipJYFoVC1vDN2og5XtiBWY8NffLv9I0YlOjKjbbn/4g2gMQnSP1TbhYWq9ifOQ9TCOz6b8MB35rX+lLeKheM4ozrpEpiS8c1i1Nmfa6B3ri56m17Eikmlkmfca3qtZIDyCfQIuqrDMUxjPX+62DnWo2lSaa+m44aE3EFAVhBuB3407SVjN4ctwA9WHWPXDuMeuX2jaZITLXupd5YgKquNh6qKHkZiOcfDx+/DCp2ol6/DrcZ39k+RV0BBviqValMYhM2w3Z3PC43Q85hj1/PLDXTWAbhf4uvpsucXvby5mG3Hzmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lyf2ddMV2rQK3eKIjHkHDHNpwDU0VUpflYVWr4D2BU=;
 b=krS1jXfhC8A2gyUpsknU1w3Qj67LvMWHfyQsQb4YGf7m/Yuz2Iw7p9SGH6w4jv6qpRLRk41ddfp2Xv5ewGKFAtNnV4vK/8eXOw/XcuL3tNjlXHN/uLWnJkFqeO4s2HyEx4o/edmgO3PzSSUAGjJP5y9brNi4D1BTxbhDxYFv4updsO8i8/QV0eGXiV3ENr1eNcYew6Sq6wFikne5BV064KNqGBt9wOymMMyVFLYo9vjlJQ2QLr2oe6akstjmWQb0P8P54NU+92UJpN1GvOrbZ7Spf9Vq1dcSOvedpqTg2LxGhaaXxlH/6DEjQyzTWxulc3pAj3jha/H82JMSe3twAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lyf2ddMV2rQK3eKIjHkHDHNpwDU0VUpflYVWr4D2BU=;
 b=E6U7/Ue/CerQQVue3q+RutZ1tfJ3mkGNGSF4iSfd5adB95d/TjXyPrWruHuegkTXFs8Tae9/r7+VobKJsTtcdCub6+QM6u38ArB7NGzIaerLDl0IUkG52vVnzVqs0DFIl+GmFx+MduOcmEHU3oUjY26tBLitstt4fiZ5P0XW1Jg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7810.namprd04.prod.outlook.com (2603:10b6:5:358::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.24; Fri, 22 Mar 2024 09:35:05 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 09:35:05 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 17/18] nvme: don't assume namespace id
Thread-Topic: [PATCH blktests v1 17/18] nvme: don't assume namespace id
Thread-Index: AQHae3TXoW9edpWM9U+NnwuxlIRitbFDgYYA
Date: Fri, 22 Mar 2024 09:35:05 +0000
Message-ID: <trit4eelgig2vdlwq5zgpwqe3az3p7r3smbscrwvhnxx54fqr2@tlpme2knu4kj>
References: <20240321094727.6503-1-dwagner@suse.de>
 <20240321094727.6503-18-dwagner@suse.de>
In-Reply-To: <20240321094727.6503-18-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7810:EE_
x-ms-office365-filtering-correlation-id: f6b4848c-ce83-4c52-7644-08dc4a535b3f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1C/eG+TgfVOJ8bCw5yGsvglrrmdxjDp9ST8cH1DpIcCcVXVM3KbKwEz9efkGN/90mjDwvTI8KGG3Z+Y9cYj5UpBsWlVgv+AWsCjlZ1JaUczhw0MkM7Aj42sCA3a9F5dSqR8XdFa6OoNiHNEDtiZuSZZfiQBRO8/39GprHmVZNyPkY7KUz+rFYsAtjb0hlcSbjyZt/QltE6D1Jefyf06JsrNxx/zqIQndzM05h39bZlGRWZHjUGqFbwGVQcl1qclxVmdhmFxUW6yMZf1645toiDPOzbVn3aDmTEmjUjmD7xz9mTCkn/GEehxL2RM48XlHPYTQSiyrUjdGMW+JNflwAuo/Qk1klOYUzqd2G6r6glv4VSEQ36n3Gf+ebxN6qThn75Ln9k2qk/WWXfeE6T+RaEPyLgZHIuoBacoskMDkhuEZSJcCYC5m9OqhTS7I9aB1tDWPJgIZiCjiiYfQmCscdjl4yOdqKDOKGxR/aMJjVmlvpQeyCc6ZngEGQQttzuVbifk4zORoELmpN/+JKtFc59Qgvv6x705fIOP7t3PcmUkPHUbN9LIl8VYVOpHpw/Gsl4dcA4XXVnRdFe/QeTtv0x1h4lA0NreT/gL2+wXQ9TqL6rxPjukMC747h7T4kUhJzFBf0serreo6llWbXIg0ZPEMYtsj9DUOsFdxRtnMGm+wa3+xwenXcg2CEXJC+owMU4FyEY9hQQsbjBKvj+YoyRi7EKDU0xA7/qecGB4UGhc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LMO11MxfxBmNlT7YYsOvWmS2XR8vjcBf0KkdLMW7dpRtgvWO4mC+D2flBTlE?=
 =?us-ascii?Q?gCFbVVf+HAPpiKGxEeRz69ixYBZ060JYu0ZIl7+28mm0JRo3jR+aGTWwHo5T?=
 =?us-ascii?Q?pEYXcjTbwSYUnlE79+6+GmGfImcOPTlG8Gf1OAnBhlSolDfiNL5W1+F42Qv+?=
 =?us-ascii?Q?Cl5JVugxbml+Kh+pVGx858evNgnYJptIsJKizGz8wajVyqSeOcJSp30ueO5W?=
 =?us-ascii?Q?m+RfX6G8362m75hV7O8EE/+fkx7msbOcT0rJGcLUSSQdbJP07y96iMpwn1o2?=
 =?us-ascii?Q?kZkm1MCC98F5cumEcfu0I0DbLEO3NLSmPR+kOsZZmh8iKf+eL+cD/XBwiMsb?=
 =?us-ascii?Q?gz2CgOMZbB/uBRHN/rouNLWPewKA1JfhKF2INnkfRJQTtZCNo8BY5SgaCEzZ?=
 =?us-ascii?Q?KBH2vmw5OACumD9LtFIXhDXd5fuU64qvCdUdOIDtNitM7V16Uhf1yFegCgKQ?=
 =?us-ascii?Q?qAdq8uO5JP7eP+a+yLt+sH//9DHxlTsoo0xyHXr06HfuDNuMQfcxWXvUFfPf?=
 =?us-ascii?Q?g/ohD6d/smApOmpUll46Rqorxfs2Ll+/jxzlLwvcApas8AeoD0A5YSnBdjBE?=
 =?us-ascii?Q?qlKBq1Ks23Ha6+1G7HUqJ52nByat/94FTkhkVb9iOq0V9RZh+BK/WYroX2WA?=
 =?us-ascii?Q?umqWCAXzm7VnVcgNYI9qphnmgL5JC02YtjBLDKx8s2aHV9dE1JmDAW3htMh5?=
 =?us-ascii?Q?JjnZXaruxj6i7XdYqddU+saPSykODEEqX9texciDtcC2yinZcc5MW6U6X/wE?=
 =?us-ascii?Q?pFC+3A1ZDQ/WHrlHJQDPh2+SofwsrDE9Cvo/dZvLScOq++6imoLbxNfMnSAy?=
 =?us-ascii?Q?94volqW7D5tw6yaSL+IyDVyIGYemtdhadyCMnH/EIlxgnNeCFTC59NFlcdKL?=
 =?us-ascii?Q?QAma+EbFmhLwzEUWRvQaJzWWdAVAP9DvVNJ6A6V/LhKGYrxqMU1A8kLz+M7j?=
 =?us-ascii?Q?M4VjZE2h7WtstWZ8QeljHLByWJLaOxHOLiaUGNQB1u5U87oh6h3W2dYRMFxl?=
 =?us-ascii?Q?VYLCB7c1eBl9796FWWEqWmmCDZ7+iEX91Po8feVDzxIZ6hHUGyjDBjS4MQ4f?=
 =?us-ascii?Q?1DGIOkFeMjap9OF5/kD/MRlYLeETb3C78CBaEBTJ96uMC8y0oIP7fKoY/Oo1?=
 =?us-ascii?Q?z9R1uJCijzNkpDuME6kXRH8deSILU2Nl52a+fLHfSWG4vg0lYx5ZdY3aWdnb?=
 =?us-ascii?Q?tYcqytnOOQIhlz6Ea4sgUxXZ5fnu5VoGrD1g46rjG6nI4W+od1DhX1/FhJ57?=
 =?us-ascii?Q?5kcS7/me36IBq28j7FTjfyIxQuxbBZ8TisdAX2zcN4zdtppNeshiKWmwfGGU?=
 =?us-ascii?Q?Mwia9Plizd/c53FASrHg13iWaa43RhI+D2iHILCy9U3mVnZavjMGLqmYfHku?=
 =?us-ascii?Q?sSaXsfWEGP+S9shzVb0GjQEPSbabqRCp3iukLko//rERgrlWNSy6I4zife5R?=
 =?us-ascii?Q?Nu64a0CD3K57R0xz5pk4iqzh3dVeqUgKnIfAYamkvhw1xX5Gz6r3qQrF+6iA?=
 =?us-ascii?Q?xTK+eoGFjTqeax4NgLv70yLda83b/iLnZmL633q1kLww/rewnIHH+VwFB2su?=
 =?us-ascii?Q?IV/KVAbpverRYHIpDr5QfUfyEIEXQqXyR+bebJp5DZi2xkLMqGu1eket+Upk?=
 =?us-ascii?Q?uEcQASa8z5BzS09PpHUNWZw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <807352028D064B4DABB997BB6B323C59@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dNSC0V4+mB9kcLhEqsxUJpBJHChIXAm2O99ho5xhhFm17xKBc9ZS8TqXxNOVuaUz4JJUe3uEI14USlLYKk18lrfWy9q4ySxIO/Th3CRI26VBwA6KL0TNUdYUCcwGoA6ZD0cSW+nk5HkqnRFpIaxEJJkjLca4pxhBlPDQUIkdftbkKXW274CDsCrSa5hmmudM4IQvsdBcP9MbOaWP6ZXepoe9BKydvqNlCYlPvncYDk/iU9XH5TtBWWY4yQCFEh1/1HcDcn0/zc+6dMjflyxYCCJqgHuc9c/gfap0DlfzNsv7/oNE3y/0/4Lo8Vl+iybraVYHbp1L1CJ1VhKLnNhy7gyTcsG0Aav30XFIL9U71gmk7Yei5AeDlbJRYQ8gwsaTy77zfW3nUknAjWZvw1eRWVIhikpjqrkD3H+PxKmz/qREXLuNkh5PUhJ0nS5pDCGF6Rfskd+Dl+vqAQ/S/S8j2nQVV+FHGazI/+5Hu+Yh5J5KyW2KhmKEnHptNzBqKBfzu24roJhGdxorZD6ONJQ1BsoQpL5dL1ScnkC5AyaH58RskrBwO3Fj6VmO7399vtI60EM0+Ye69mA33AUwaaYcK++uMyi2KJUAPu/d34C8ElDx+IEtqG4MAVU+Pk+4SZcM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b4848c-ce83-4c52-7644-08dc4a535b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:35:05.3161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28OZTNT1tYtZsdiws/j84J496GSikd3R9WDZ+AiQIpK3Nau5VSrbF+pVlkdluEZ6+hJD5I52e4nMxQEsMxkO8v49fUAoLfFeVBobANuq61s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7810

On Mar 21, 2024 / 10:47, Daniel Wagner wrote:
> The tests assume that the namespace id is always 1. This might not be
> correct in future (e.g. running real targets), thus harden the test by
> using the uuid to lookup the correct namespace id.
>=20
> The passthru test already do this, so it makes also sense to update the
> other tests as well.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/010 |  7 +++----
>  tests/nvme/011 |  7 +++----
>  tests/nvme/012 |  7 +++----
>  tests/nvme/013 |  7 +++----
>  tests/nvme/014 | 13 ++++++-------
>  tests/nvme/015 | 13 ++++++-------
>  tests/nvme/018 | 15 +++++++--------
>  tests/nvme/019 |  8 +++-----
>  tests/nvme/020 |  7 +++----
>  tests/nvme/021 |  7 +++----
>  tests/nvme/023 |  8 +++-----
>  tests/nvme/024 |  9 ++++-----
>  tests/nvme/025 |  7 +++----
>  tests/nvme/026 |  8 +++-----
>  tests/nvme/029 |  6 +-----
>  tests/nvme/040 |  4 +++-
>  tests/nvme/045 |  5 +++--
>  tests/nvme/047 | 10 +++++-----
>  tests/nvme/rc  | 18 ++++++++++++++++++
>  19 files changed, 83 insertions(+), 83 deletions(-)
>=20
> diff --git a/tests/nvme/010 b/tests/nvme/010
> index 7d875989a01c..6feb39153e99 100755
> --- a/tests/nvme/010
> +++ b/tests/nvme/010
> @@ -20,17 +20,16 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local nvmedev
> +	local ns
> =20
>  	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys
> =20
> -	nvmedev=3D$(_find_nvme_dev "${def_subsysnqn}")
> -	_check_uuid "${nvmedev}"
> +	ns=3D$(_find_nvme_ns "${def_subsys_uuid}")

Currently, _check_uuid() compares the uuid with wwid. On the other hand, th=
e
modified _find_nvme_ns() does not refer wwid. This looks a relax of test
condition. Do you think this relax is fine?

> =20
>  	_run_fio_verify_io --size=3D"${nvme_img_size}" \
> -		--filename=3D"/dev/${nvmedev}n1"
> +		--filename=3D"/dev/${ns}"
> =20
>  	_nvme_disconnect_subsys
>

[...]

> diff --git a/tests/nvme/047 b/tests/nvme/047
> index 7a2432a769e5..9bbe84d4f145 100755
> --- a/tests/nvme/047
> +++ b/tests/nvme/047
> @@ -22,7 +22,7 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local nvmedev
> +	local ns
>  	local rand_io_size
> =20
>  	_nvmet_target_setup
> @@ -30,18 +30,18 @@ test() {
>  	_nvme_connect_subsys \
>  		--nr-write-queues 1 || echo FAIL
> =20
> -	nvmedev=3D$(_find_nvme_dev "${def_subsysnqn}")
> +	ns=3D$(_find_nvme_ns "${def_subsys_uuid}")
> =20
>  	rand_io_size=3D"$(_nvme_calc_rand_io_size 4M)"
> -	_run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D"${rand_io_s=
ize}"
> +	_run_fio_rand_io --filename=3D"/dev/${ns}" --size=3D"${rand_io_size}"
> =20
> -	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> +	_nvme_disconnect_subsys >> "$FULL" 2>&1

This change above looks different from the purpose of this patch. It should=
 move
to one of the previous patches, probably.=
