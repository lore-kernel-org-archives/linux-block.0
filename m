Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block/DAC960.c: make some arrays static const, shrinks object size
Date: Tue, 21 Aug 2018 10:12:48 +0100
Message-Id: <20180821091248.8669-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Don't populate the arrays ReadCacheStatus, WriteCacheStatus and
SenseErrors on the stack but instead make them static const. Makes
the object code smaller by 47 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
 160974	  34628	    832	 196434	  2ff52	drivers/block/DAC960.o

After:
   text	   data	    bss	    dec	    hex	filename
 160671	  34884	    832	 196387	  2ff23	drivers/block/DAC960.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/DAC960.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index f99e5c883368..581312ac375f 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -2428,16 +2428,20 @@ static bool DAC960_V2_ReportDeviceConfiguration(DAC960_Controller_T
     {
       DAC960_V2_LogicalDeviceInfo_T *LogicalDeviceInfo =
 	Controller->V2.LogicalDeviceInformation[LogicalDriveNumber];
-      unsigned char *ReadCacheStatus[] = { "Read Cache Disabled",
-					   "Read Cache Enabled",
-					   "Read Ahead Enabled",
-					   "Intelligent Read Ahead Enabled",
-					   "-", "-", "-", "-" };
-      unsigned char *WriteCacheStatus[] = { "Write Cache Disabled",
-					    "Logical Device Read Only",
-					    "Write Cache Enabled",
-					    "Intelligent Write Cache Enabled",
-					    "-", "-", "-", "-" };
+      static const unsigned char *ReadCacheStatus[] = {
+        "Read Cache Disabled",
+        "Read Cache Enabled",
+        "Read Ahead Enabled",
+        "Intelligent Read Ahead Enabled",
+        "-", "-", "-", "-"
+      };
+      static const unsigned char *WriteCacheStatus[] = {
+        "Write Cache Disabled",
+        "Logical Device Read Only",
+        "Write Cache Enabled",
+        "Intelligent Write Cache Enabled",
+        "-", "-", "-", "-"
+      };
       unsigned char *GeometryTranslation;
       if (LogicalDeviceInfo == NULL) continue;
       switch (LogicalDeviceInfo->DriveGeometry)
@@ -4339,14 +4343,16 @@ static void DAC960_V1_ProcessCompletedCommand(DAC960_Command_T *Command)
 static void DAC960_V2_ReadWriteError(DAC960_Command_T *Command)
 {
   DAC960_Controller_T *Controller = Command->Controller;
-  unsigned char *SenseErrors[] = { "NO SENSE", "RECOVERED ERROR",
-				   "NOT READY", "MEDIUM ERROR",
-				   "HARDWARE ERROR", "ILLEGAL REQUEST",
-				   "UNIT ATTENTION", "DATA PROTECT",
-				   "BLANK CHECK", "VENDOR-SPECIFIC",
-				   "COPY ABORTED", "ABORTED COMMAND",
-				   "EQUAL", "VOLUME OVERFLOW",
-				   "MISCOMPARE", "RESERVED" };
+  static const unsigned char *SenseErrors[] = {
+    "NO SENSE", "RECOVERED ERROR",
+    "NOT READY", "MEDIUM ERROR",
+    "HARDWARE ERROR", "ILLEGAL REQUEST",
+    "UNIT ATTENTION", "DATA PROTECT",
+    "BLANK CHECK", "VENDOR-SPECIFIC",
+    "COPY ABORTED", "ABORTED COMMAND",
+    "EQUAL", "VOLUME OVERFLOW",
+    "MISCOMPARE", "RESERVED"
+  };
   unsigned char *CommandName = "UNKNOWN";
   switch (Command->CommandType)
     {
-- 
2.17.1
