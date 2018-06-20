Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 20 Jun 2018 13:41:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Scott Bauer <scott.bauer@intel.com>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] block: sed-opal: Fix a couple off by one bugs
Message-ID: <20180620104151.yhvcgbcbkkwj4cuk@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

resp->num is the number of tokens in resp->tok[].  It gets set in
response_parse().  So if n == resp->num then we're reading beyond the
end of the data.

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static analysis.  Not tested.  This matches the checking in
response_get_token().

My other concern is that there isn't checking in response_parse() to
ensure that we don't go over MAX_TOKS (64) entries.  If the firmware
is buggy we're probably very screwed already, so it doesn't necessarily
make a lot of difference at runtime but it might make static analysis
easier if we knew the value of resp->num was in the 1-64 range.

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 945f4b8610e0..e0de4dd448b3 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -877,7 +877,7 @@ static size_t response_get_string(const struct parsed_resp *resp, int n,
 		return 0;
 	}
 
-	if (n > resp->num) {
+	if (n >= resp->num) {
 		pr_debug("Response has %d tokens. Can't access %d\n",
 			 resp->num, n);
 		return 0;
@@ -916,7 +916,7 @@ static u64 response_get_u64(const struct parsed_resp *resp, int n)
 		return 0;
 	}
 
-	if (n > resp->num) {
+	if (n >= resp->num) {
 		pr_debug("Response has %d tokens. Can't access %d\n",
 			 resp->num, n);
 		return 0;
