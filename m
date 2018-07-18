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
	Stephen Hemminger <sthemmin@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next 2/2] gtp: constify nla_policy
Date: Wed, 18 Jul 2018 09:32:44 -0700
Message-Id: <20180718163244.1590-3-sthemmin@microsoft.com>
In-Reply-To: <20180718163244.1590-1-sthemmin@microsoft.com>
References: <20180718163244.1590-1-sthemmin@microsoft.com>
List-ID: <linux-block@vger.kernel.org>

The netlink policy structure can be constant like other
drivers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/gtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index ec629a730005..7a145172d503 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1255,7 +1255,7 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 	return skb->len;
 }
 
-static struct nla_policy gtp_genl_policy[GTPA_MAX + 1] = {
+static const struct nla_policy gtp_genl_policy[GTPA_MAX + 1] = {
 	[GTPA_LINK]		= { .type = NLA_U32, },
 	[GTPA_VERSION]		= { .type = NLA_U32, },
 	[GTPA_TID]		= { .type = NLA_U64, },
-- 
2.18.0
