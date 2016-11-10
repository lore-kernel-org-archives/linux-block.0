Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 10 Nov 2016 11:16:37 -0500
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] block: cfq_cpd_alloc() should use @gfp
Message-ID: <20161110161637.GB26105@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Re: [bug report] blkcg: replace blkcg_policy->cpd_size with
 ->cpd_alloc/free_fn() methods
Reply-To: 
In-Reply-To: <20161110133426.GA30610@mwanda>

cfq_cpd_alloc() which is the cpd_alloc_fn implementation for cfq was
incorrectly hard coding GFP_KERNEL instead of using the mask specified
through the @gfp parameter.  This currently doesn't cause any actual
issues because all current callers specify GFP_KERNEL.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: e4a9bde9589f ("blkcg: replace blkcg_policy->cpd_size with ->cpd_alloc/free_fn() methods")
---
 block/cfq-iosched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 5e24d88..3ab6807 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -1596,7 +1596,7 @@ static struct blkcg_policy_data *cfq_cpd_alloc(gfp_t gfp)
 {
 	struct cfq_group_data *cgd;
 
-	cgd = kzalloc(sizeof(*cgd), GFP_KERNEL);
+	cgd = kzalloc(sizeof(*cgd), gfp);
 	if (!cgd)
 		return NULL;
 	return &cgd->cpd;
