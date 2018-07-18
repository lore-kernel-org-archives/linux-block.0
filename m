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
Subject: [PATCH net-next 1/2] nbd: constify nla_policy
Date: Wed, 18 Jul 2018 09:32:43 -0700
Message-Id: <20180718163244.1590-2-sthemmin@microsoft.com>
In-Reply-To: <20180718163244.1590-1-sthemmin@microsoft.com>
References: <20180718163244.1590-1-sthemmin@microsoft.com>
List-ID: <linux-block@vger.kernel.org>

The netlink policy should be const like other drivers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/block/nbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 74a05561b620..e07401d3901d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1571,7 +1571,7 @@ static int find_free_cb(int id, void *ptr, void *data)
 }
 
 /* Netlink interface. */
-static struct nla_policy nbd_attr_policy[NBD_ATTR_MAX + 1] = {
+static const struct nla_policy nbd_attr_policy[NBD_ATTR_MAX + 1] = {
 	[NBD_ATTR_INDEX]		=	{ .type = NLA_U32 },
 	[NBD_ATTR_SIZE_BYTES]		=	{ .type = NLA_U64 },
 	[NBD_ATTR_BLOCK_SIZE_BYTES]	=	{ .type = NLA_U64 },
@@ -1583,14 +1583,14 @@ static struct nla_policy nbd_attr_policy[NBD_ATTR_MAX + 1] = {
 	[NBD_ATTR_DEVICE_LIST]		=	{ .type = NLA_NESTED},
 };
 
-static struct nla_policy nbd_sock_policy[NBD_SOCK_MAX + 1] = {
+static const struct nla_policy nbd_sock_policy[NBD_SOCK_MAX + 1] = {
 	[NBD_SOCK_FD]			=	{ .type = NLA_U32 },
 };
 
 /* We don't use this right now since we don't parse the incoming list, but we
  * still want it here so userspace knows what to expect.
  */
-static struct nla_policy __attribute__((unused))
+static const struct nla_policy __attribute__((unused))
 nbd_device_policy[NBD_DEVICE_ATTR_MAX + 1] = {
 	[NBD_DEVICE_INDEX]		=	{ .type = NLA_U32 },
 	[NBD_DEVICE_CONNECTED]		=	{ .type = NLA_U8 },
-- 
2.18.0
