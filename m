Return-Path: <stephen@networkplumber.org>
Return-Path: <stephen@networkplumber.org>
From: Stephen Hemminger <stephen@networkplumber.org>
To: josef@toxicpanda.com,
	axboe@kernel.dk,
	pablo@netfilter.org,
	laforge@gnumonks.org
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH net-next 0/2] constify nla_policy
Date: Wed, 18 Jul 2018 09:32:42 -0700
Message-Id: <20180718163244.1590-1-sthemmin@microsoft.com>
List-ID: <linux-block@vger.kernel.org>

Almost all places that use nla_policy declare it const.
A couple of drivers didn't but that is fixable.

Stephen Hemminger (2):
  nbd: constify nla_policy
  gtp: constify nla_policy

 drivers/block/nbd.c | 6 +++---
 drivers/net/gtp.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.18.0
