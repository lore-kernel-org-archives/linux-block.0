Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8.2/8.4] block: sed-opal: unify retrieval of table columns
Date: Wed, 14 Mar 2018 07:15:43 +0100
Message-Id: <93a5d31c09c867546621b9a3f849cb2b9dd628d8.1521006596.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5> <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <b0b34fc0132312c09629c868d33b74fe5a19854e.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5>
List-ID: <linux-block@vger.kernel.org>

instead of having multiple places defining the same argument list to get
a specific column of a sed-opal table, provide a generic version and
call it from those functions.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/opal_proto.h |   2 +
 block/sed-opal.c   | 130 +++++++++++++++++++----------------------------------
 2 files changed, 49 insertions(+), 83 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index e20be8258854..b6e352cfe982 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -170,6 +170,8 @@ enum opal_token {
 	OPAL_READLOCKED = 0x07,
 	OPAL_WRITELOCKED = 0x08,
 	OPAL_ACTIVEKEY = 0x0A,
+	/* lockingsp table */
+	OPAL_LIFECYCLE = 0x06,
 	/* locking info table */
 	OPAL_MAXRANGES = 0x04,
 	 /* mbr control */
diff --git a/block/sed-opal.c b/block/sed-opal.c
index aa49fcc30462..ebee06aaadd6 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1075,6 +1075,37 @@ static int finalize_and_send(struct opal_dev *dev, cont_fn cont)
 	return opal_send_recv(dev, cont);
 }
 
+/*
+ * request @column from table @table on device @dev. On success, the column
+ * data will be available in dev->resp->tok[4]
+ */
+static int generic_get_column(struct opal_dev *dev, const u8 *table,
+			      u64 column)
+{
+	int err;
+
+	err = start_opal_cmd(dev, table, opalmethod[OPAL_GET]);
+
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_STARTCOLUMN);
+	add_token_u64(&err, dev, column);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_ENDCOLUMN);
+	add_token_u64(&err, dev, column);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err)
+		return err;
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
 static int gen_key(struct opal_dev *dev, void *data)
 {
 	u8 uid[OPAL_UID_LENGTH];
@@ -1129,23 +1160,11 @@ static int get_active_key(struct opal_dev *dev, void *data)
 	if (err)
 		return err;
 
-	err = start_opal_cmd(dev, uid, opalmethod[OPAL_GET]);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 3); /* startCloumn */
-	add_token_u8(&err, dev, 10); /* ActiveKey */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 4); /* endColumn */
-	add_token_u8(&err, dev, 10); /* ActiveKey */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
-	if (err) {
-		pr_debug("Error building get active key command\n");
+	err = generic_get_column(dev, uid, OPAL_ACTIVEKEY);
+	if (err)
 		return err;
-	}
 
-	return finalize_and_send(dev, get_active_key_cont);
+	return get_active_key_cont(dev);
 }
 
 static int generic_lr_enable_disable(struct opal_dev *dev,
@@ -1800,14 +1819,16 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int get_lsp_lifecycle_cont(struct opal_dev *dev)
+/* Determine if we're in the Manufactured Inactive or Active state */
+static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
 {
 	u8 lc_status;
-	int error = 0;
+	int err;
 
-	error = parse_and_check_status(dev);
-	if (error)
-		return error;
+	err = generic_get_column(dev, opaluid[OPAL_LOCKINGSP_UID],
+				 OPAL_LIFECYCLE);
+	if (err)
+		return err;
 
 	lc_status = response_get_u64(&dev->parsed, 4);
 	/* 0x08 is Manufacured Inactive */
@@ -1820,49 +1841,19 @@ static int get_lsp_lifecycle_cont(struct opal_dev *dev)
 	return 0;
 }
 
-/* Determine if we're in the Manufactured Inactive or Active state */
-static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
-{
-	int err;
-
-	err = start_opal_cmd(dev, opaluid[OPAL_LOCKINGSP_UID],
-			     opalmethod[OPAL_GET]);
-
-	add_token_u8(&err, dev, OPAL_STARTLIST);
-
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 3); /* Start Column */
-	add_token_u8(&err, dev, 6); /* Lifecycle Column */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 4); /* End Column */
-	add_token_u8(&err, dev, 6); /* Lifecycle Column */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-
-	add_token_u8(&err, dev, OPAL_ENDLIST);
-
-	if (err) {
-		pr_debug("Error Building GET Lifecycle Status command\n");
-		return err;
-	}
-
-	return finalize_and_send(dev, get_lsp_lifecycle_cont);
-}
-
-static int get_msid_cpin_pin_cont(struct opal_dev *dev)
+static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
 {
 	const char *msid_pin;
 	size_t strlen;
-	int error = 0;
+	int err;
 
-	error = parse_and_check_status(dev);
-	if (error)
-		return error;
+	err = generic_get_column(dev, opaluid[OPAL_C_PIN_MSID], OPAL_PIN);
+	if (err)
+		return err;
 
 	strlen = response_get_string(&dev->parsed, 4, &msid_pin);
 	if (!msid_pin) {
-		pr_debug("%s: Couldn't extract PIN from response\n", __func__);
+		pr_debug("Couldn't extract MSID_CPIN from response\n");
 		return OPAL_INVAL_PARAM;
 	}
 
@@ -1875,33 +1866,6 @@ static int get_msid_cpin_pin_cont(struct opal_dev *dev)
 	return 0;
 }
 
-static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
-{
-	int err;
-
-	err = start_opal_cmd(dev, opaluid[OPAL_C_PIN_MSID],
-			     opalmethod[OPAL_GET]);
-
-	add_token_u8(&err, dev, OPAL_STARTLIST);
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 3); /* Start Column */
-	add_token_u8(&err, dev, 3); /* PIN */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 4); /* End Column */
-	add_token_u8(&err, dev, 3); /* Lifecycle Column */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
-
-	if (err) {
-		pr_debug("Error building Get MSID CPIN PIN command.\n");
-		return err;
-	}
-
-	return finalize_and_send(dev, get_msid_cpin_pin_cont);
-}
-
 static int end_opal_session(struct opal_dev *dev, void *data)
 {
 	int err = 0;
-- 
2.16.1
