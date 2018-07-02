Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Tim Waugh <tim@cyberelk.net>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] paride: remove redundant variable n
Date: Mon,  2 Jul 2018 09:14:19 +0100
Message-Id: <20180702081419.12207-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Variable n is being assigned but is never used hence it is redundant
and can be removed. Also put spacing between variables in declaration
to clean up checkpatch warnings.

Cleans up clang warning:
warning: variable 'n' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/paride/bpck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/paride/bpck.c b/drivers/block/paride/bpck.c
index 4f27e7392e38..89a96786f6ae 100644
--- a/drivers/block/paride/bpck.c
+++ b/drivers/block/paride/bpck.c
@@ -347,7 +347,7 @@ static int bpck_test_proto( PIA *pi, char * scratch, int verbose )
 
 static void bpck_read_eeprom ( PIA *pi, char * buf )
 
-{       int i,j,k,n,p,v,f, om, od;
+{       int i, j, k, p, v, f, om, od;
 
 	bpck_force_spp(pi);
 
@@ -356,7 +356,6 @@ static void bpck_read_eeprom ( PIA *pi, char * buf )
 
 	bpck_connect(pi);
 	
-	n = 0;
 	WR(4,0);
 	for (i=0;i<64;i++) {
 	    WR(6,8);  
-- 
2.17.1
