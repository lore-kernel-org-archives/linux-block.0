Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 10/11] block: sed-opal: get metadata about opal-sed tables
Date: Mon, 19 Mar 2018 19:36:52 +0100
Message-Id: <623d80cb07538e630a12a1c925e9c87b8e14dd6b.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

Every opal-sed table is described in the OPAL_TABLE_TABLE. Provide a
function to get desired metadata information out of that table.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

diff --git a/block/opal_proto.h b/block/opal_proto.h
index b6e352cfe982..5e8df3245eb0 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -106,6 +106,7 @@ enum opal_uid {
 	OPAL_ENTERPRISE_BANDMASTER0_UID,
 	OPAL_ENTERPRISE_ERASEMASTER_UID,
 	/* tables */
+	OPAL_TABLE_TABLE,
 	OPAL_LOCKINGRANGE_GLOBAL,
 	OPAL_LOCKINGRANGE_ACE_RDLOCKED,
 	OPAL_LOCKINGRANGE_ACE_WRLOCKED,
@@ -160,6 +161,21 @@ enum opal_token {
 	OPAL_STARTCOLUMN = 0x03,
 	OPAL_ENDCOLUMN = 0x04,
 	OPAL_VALUES = 0x01,
+	/* table table */
+	OPAL_TABLE_UID = 0x00,
+	OPAL_TABLE_NAME = 0x01,
+	OPAL_TABLE_COMMON = 0x02,
+	OPAL_TABLE_TEMPLATE = 0x03,
+	OPAL_TABLE_KIND = 0x04,
+	OPAL_TABLE_COLUMN = 0x05,
+	OPAL_TABLE_COLUMNS = 0x06,
+	OPAL_TABLE_ROWS = 0x07,
+	OPAL_TABLE_ROWS_FREE = 0x08,
+	OPAL_TABLE_ROW_BYTES = 0x09,
+	OPAL_TABLE_LASTID = 0x0A,
+	OPAL_TABLE_MIN = 0x0B,
+	OPAL_TABLE_MAX = 0x0C,
+
 	/* authority table */
 	OPAL_PIN = 0x03,
 	/* locking tokens */
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 5b7b23cb95a4..51f8034edbf7 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -136,6 +136,8 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 
 	/* tables */
 
+	[OPAL_TABLE_TABLE]
+		{ 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_LOCKINGRANGE_GLOBAL] =
 		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_LOCKINGRANGE_ACE_RDLOCKED] =
@@ -1107,6 +1109,29 @@ static int generic_get_column(struct opal_dev *dev, const u8 *table,
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
+/*
+ * see TCG SAS 5.3.2.3 for a description of the available columns
+ *
+ * the result is provided in dev->resp->tok[4]
+ */
+static int generic_get_table_info(struct opal_dev *dev, enum opal_uid table,
+				  u64 column)
+{
+	u8 uid[OPAL_UID_LENGTH];
+	const unsigned int half = OPAL_UID_LENGTH/2;
+
+	/* sed-opal UIDs can be split in two halfs:
+	 *  first:  actual table index
+	 *  second: relative index in the table
+	 * so we have to get the first half of the OPAL_TABLE_TABLE and use the
+	 * first part of the target table as relative index into that table
+	 */
+	memcpy(uid, opaluid[OPAL_TABLE_TABLE], half);
+	memcpy(uid+half, opaluid[table], half);
+
+	return generic_get_column(dev, uid, column);
+}
+
 static int gen_key(struct opal_dev *dev, void *data)
 {
 	u8 uid[OPAL_UID_LENGTH];
-- 
2.16.1
