Return-Path: <davem@davemloft.net>
Date: Fri, 20 Jul 2018 12:34:06 -0700 (PDT)
Message-Id: <20180720.123406.875158375180351251.davem@davemloft.net>
To: stephen@networkplumber.org
Cc: josef@toxicpanda.com, axboe@kernel.dk, pablo@netfilter.org,
 laforge@gnumonks.org, linux-block@vger.kernel.org, nbd@other.debian.org,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 sthemmin@microsoft.com
Subject: Re: [PATCH net-next 0/2] constify nla_policy
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180718163244.1590-1-sthemmin@microsoft.com>
References: <20180718163244.1590-1-sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 18 Jul 2018 09:32:42 -0700

> Almost all places that use nla_policy declare it const.
> A couple of drivers didn't but that is fixable.

Series applied, thanks Stephen.
