Return-Path: <elliott@hpe.com>
From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To: Jack Wang <jinpu.wang@profitbricks.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] block: ratelimite pr_err on IO path
Date: Wed, 11 Apr 2018 17:07:30 +0000
Message-ID: <AT5PR8401MB1169413938950BBB0D30A24CABBD0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1523452889-16331-1-git-send-email-jinpu.wangl@profitbricks.com>
In-Reply-To: <1523452889-16331-1-git-send-email-jinpu.wangl@profitbricks.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Jack Wang
> Sent: Wednesday, April 11, 2018 8:21 AM
> Subject: [PATCH] block: ratelimite pr_err on IO path
>=20
> From: Jack Wang <jinpu.wang@profitbricks.com>
...
> -				pr_err("%s: ref tag error at location %llu " \
> -				       "(rcvd %u)\n", iter->disk_name,
> -				       (unsigned long long)
> -				       iter->seed, be32_to_cpu(pi->ref_tag));
> +				pr_err_ratelimited("%s: ref tag error at "
> +						   "location %llu (rcvd %u)\n",

Per process/coding-style.rst, you should keep a string like that on
one line even if that exceeds 80 columns:

  Statements longer than 80 columns will be broken into sensible chunks, un=
less
  exceeding 80 columns significantly increases readability and does not hid=
e
  information. ... However, never break user-visible strings such as
  printk messages, because that breaks the ability to grep for them.
