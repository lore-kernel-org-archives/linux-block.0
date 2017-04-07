Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:33691 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933588AbdDGQS5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Apr 2017 12:18:57 -0400
From: Scott Bauer <scott.bauer@intel.com>
To: linux-block@vger.kernel.org
Cc: axboe@fb.com, jonathan.derrick@intel.com, hch@lst.de,
        Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH] block: sed-opal: Tone down all the pr_* to debugs
Date: Fri,  7 Apr 2017 10:06:57 -0600
Message-Id: <1491581217-7342-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Lets not flood the kernel log with messages unless
the user requests so.

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 block/sed-opal.c | 153 +++++++++++++++++++++++++++----------------------------
 1 file changed, 74 insertions(+), 79 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 14035f8..f10227e 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -275,8 +275,8 @@ static bool check_tper(const void *data)
 	u8 flags = tper->supported_features;
 
 	if (!(flags & TPER_SYNC_SUPPORTED)) {
-		pr_err("TPer sync not supported. flags = %d\n",
-		       tper->supported_features);
+		pr_debug("TPer sync not supported. flags = %d\n",
+			 tper->supported_features);
 		return false;
 	}
 
@@ -289,7 +289,7 @@ static bool check_sum(const void *data)
 	u32 nlo = be32_to_cpu(sum->num_locking_objects);
 
 	if (nlo == 0) {
-		pr_err("Need at least one locking object.\n");
+		pr_debug("Need at least one locking object.\n");
 		return false;
 	}
 
@@ -385,9 +385,9 @@ static int next(struct opal_dev *dev)
 
 		error = step->fn(dev, step->data);
 		if (error) {
-			pr_err("Error on step function: %d with error %d: %s\n",
-			       state, error,
-			       opal_error_to_human(error));
+			pr_debug("Error on step function: %d with error %d: %s\n",
+				 state, error,
+				 opal_error_to_human(error));
 
 			/* For each OPAL command we do a discovery0 then we
 			 * start some sort of session.
@@ -419,8 +419,8 @@ static int opal_discovery0_end(struct opal_dev *dev)
 	print_buffer(dev->resp, hlen);
 
 	if (hlen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
-		pr_warn("Discovery length overflows buffer (%zu+%u)/%u\n",
-			sizeof(*hdr), hlen, IO_BUFFER_LENGTH);
+		pr_debug("Discovery length overflows buffer (%zu+%u)/%u\n",
+			 sizeof(*hdr), hlen, IO_BUFFER_LENGTH);
 		return -EFAULT;
 	}
 
@@ -503,7 +503,7 @@ static void add_token_u8(int *err, struct opal_dev *cmd, u8 tok)
 	if (*err)
 		return;
 	if (cmd->pos >= IO_BUFFER_LENGTH - 1) {
-		pr_err("Error adding u8: end of buffer.\n");
+		pr_debug("Error adding u8: end of buffer.\n");
 		*err = -ERANGE;
 		return;
 	}
@@ -553,7 +553,7 @@ static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 	len = DIV_ROUND_UP(msb, 4);
 
 	if (cmd->pos >= IO_BUFFER_LENGTH - len - 1) {
-		pr_err("Error adding u64: end of buffer.\n");
+		pr_debug("Error adding u64: end of buffer.\n");
 		*err = -ERANGE;
 		return;
 	}
@@ -579,7 +579,7 @@ static void add_token_bytestring(int *err, struct opal_dev *cmd,
 	}
 
 	if (len >= IO_BUFFER_LENGTH - cmd->pos - header_len) {
-		pr_err("Error adding bytestring: end of buffer.\n");
+		pr_debug("Error adding bytestring: end of buffer.\n");
 		*err = -ERANGE;
 		return;
 	}
@@ -597,7 +597,7 @@ static void add_token_bytestring(int *err, struct opal_dev *cmd,
 static int build_locking_range(u8 *buffer, size_t length, u8 lr)
 {
 	if (length > OPAL_UID_LENGTH) {
-		pr_err("Can't build locking range. Length OOB\n");
+		pr_debug("Can't build locking range. Length OOB\n");
 		return -ERANGE;
 	}
 
@@ -614,7 +614,7 @@ static int build_locking_range(u8 *buffer, size_t length, u8 lr)
 static int build_locking_user(u8 *buffer, size_t length, u8 lr)
 {
 	if (length > OPAL_UID_LENGTH) {
-		pr_err("Can't build locking range user, Length OOB\n");
+		pr_debug("Can't build locking range user, Length OOB\n");
 		return -ERANGE;
 	}
 
@@ -648,7 +648,7 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
 	add_token_u8(&err, cmd, OPAL_ENDLIST);
 
 	if (err) {
-		pr_err("Error finalizing command.\n");
+		pr_debug("Error finalizing command.\n");
 		return -EFAULT;
 	}
 
@@ -660,7 +660,7 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
 	hdr->subpkt.length = cpu_to_be32(cmd->pos - sizeof(*hdr));
 	while (cmd->pos % 4) {
 		if (cmd->pos >= IO_BUFFER_LENGTH) {
-			pr_err("Error: Buffer overrun\n");
+			pr_debug("Error: Buffer overrun\n");
 			return -ERANGE;
 		}
 		cmd->cmd[cmd->pos++] = 0;
@@ -679,14 +679,14 @@ static const struct opal_resp_tok *response_get_token(
 	const struct opal_resp_tok *tok;
 
 	if (n >= resp->num) {
-		pr_err("Token number doesn't exist: %d, resp: %d\n",
-		       n, resp->num);
+		pr_debug("Token number doesn't exist: %d, resp: %d\n",
+			 n, resp->num);
 		return ERR_PTR(-EINVAL);
 	}
 
 	tok = &resp->toks[n];
 	if (tok->len == 0) {
-		pr_err("Token length must be non-zero\n");
+		pr_debug("Token length must be non-zero\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -727,7 +727,7 @@ static ssize_t response_parse_short(struct opal_resp_tok *tok,
 
 		tok->type = OPAL_DTA_TOKENID_UINT;
 		if (tok->len > 9) {
-			pr_warn("uint64 with more than 8 bytes\n");
+			pr_debug("uint64 with more than 8 bytes\n");
 			return -EINVAL;
 		}
 		for (i = tok->len - 1; i > 0; i--) {
@@ -814,8 +814,8 @@ static int response_parse(const u8 *buf, size_t length,
 
 	if (clen == 0 || plen == 0 || slen == 0 ||
 	    slen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
-		pr_err("Bad header length. cp: %u, pkt: %u, subpkt: %u\n",
-		       clen, plen, slen);
+		pr_debug("Bad header length. cp: %u, pkt: %u, subpkt: %u\n",
+			 clen, plen, slen);
 		print_buffer(pos, sizeof(*hdr));
 		return -EINVAL;
 	}
@@ -848,7 +848,7 @@ static int response_parse(const u8 *buf, size_t length,
 	}
 
 	if (num_entries == 0) {
-		pr_err("Couldn't parse response.\n");
+		pr_debug("Couldn't parse response.\n");
 		return -EINVAL;
 	}
 	resp->num = num_entries;
@@ -861,18 +861,18 @@ static size_t response_get_string(const struct parsed_resp *resp, int n,
 {
 	*store = NULL;
 	if (!resp) {
-		pr_err("Response is NULL\n");
+		pr_debug("Response is NULL\n");
 		return 0;
 	}
 
 	if (n > resp->num) {
-		pr_err("Response has %d tokens. Can't access %d\n",
-		       resp->num, n);
+		pr_debug("Response has %d tokens. Can't access %d\n",
+			 resp->num, n);
 		return 0;
 	}
 
 	if (resp->toks[n].type != OPAL_DTA_TOKENID_BYTESTRING) {
-		pr_err("Token is not a byte string!\n");
+		pr_debug("Token is not a byte string!\n");
 		return 0;
 	}
 
@@ -883,26 +883,26 @@ static size_t response_get_string(const struct parsed_resp *resp, int n,
 static u64 response_get_u64(const struct parsed_resp *resp, int n)
 {
 	if (!resp) {
-		pr_err("Response is NULL\n");
+		pr_debug("Response is NULL\n");
 		return 0;
 	}
 
 	if (n > resp->num) {
-		pr_err("Response has %d tokens. Can't access %d\n",
-		       resp->num, n);
+		pr_debug("Response has %d tokens. Can't access %d\n",
+			 resp->num, n);
 		return 0;
 	}
 
 	if (resp->toks[n].type != OPAL_DTA_TOKENID_UINT) {
-		pr_err("Token is not unsigned it: %d\n",
-		       resp->toks[n].type);
+		pr_debug("Token is not unsigned it: %d\n",
+			 resp->toks[n].type);
 		return 0;
 	}
 
 	if (!(resp->toks[n].width == OPAL_WIDTH_TINY ||
 	      resp->toks[n].width == OPAL_WIDTH_SHORT)) {
-		pr_err("Atom is not short or tiny: %d\n",
-		       resp->toks[n].width);
+		pr_debug("Atom is not short or tiny: %d\n",
+			 resp->toks[n].width);
 		return 0;
 	}
 
@@ -949,7 +949,7 @@ static int parse_and_check_status(struct opal_dev *dev)
 
 	error = response_parse(dev->resp, IO_BUFFER_LENGTH, &dev->parsed);
 	if (error) {
-		pr_err("Couldn't parse response.\n");
+		pr_debug("Couldn't parse response.\n");
 		return error;
 	}
 
@@ -975,7 +975,7 @@ static int start_opal_session_cont(struct opal_dev *dev)
 	tsn = response_get_u64(&dev->parsed, 5);
 
 	if (hsn == 0 && tsn == 0) {
-		pr_err("Couldn't authenticate session\n");
+		pr_debug("Couldn't authenticate session\n");
 		return -EPERM;
 	}
 
@@ -1012,7 +1012,7 @@ static int finalize_and_send(struct opal_dev *dev, cont_fn cont)
 
 	ret = cmd_finalize(dev, dev->hsn, dev->tsn);
 	if (ret) {
-		pr_err("Error finalizing command buffer: %d\n", ret);
+		pr_debug("Error finalizing command buffer: %d\n", ret);
 		return ret;
 	}
 
@@ -1041,7 +1041,7 @@ static int gen_key(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-		pr_err("Error building gen key command\n");
+		pr_debug("Error building gen key command\n");
 		return err;
 
 	}
@@ -1059,8 +1059,8 @@ static int get_active_key_cont(struct opal_dev *dev)
 		return error;
 	keylen = response_get_string(&dev->parsed, 4, &activekey);
 	if (!activekey) {
-		pr_err("%s: Couldn't extract the Activekey from the response\n",
-		       __func__);
+		pr_debug("%s: Couldn't extract the Activekey from the response\n",
+			 __func__);
 		return OPAL_INVAL_PARAM;
 	}
 	dev->prev_data = kmemdup(activekey, keylen, GFP_KERNEL);
@@ -1103,7 +1103,7 @@ static int get_active_key(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	if (err) {
-		pr_err("Error building get active key command\n");
+		pr_debug("Error building get active key command\n");
 		return err;
 	}
 
@@ -1159,7 +1159,7 @@ static inline int enable_global_lr(struct opal_dev *dev, u8 *uid,
 	err = generic_lr_enable_disable(dev, uid, !!setup->RLE, !!setup->WLE,
 					0, 0);
 	if (err)
-		pr_err("Failed to create enable global lr command\n");
+		pr_debug("Failed to create enable global lr command\n");
 	return err;
 }
 
@@ -1217,7 +1217,7 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
 
 	}
 	if (err) {
-		pr_err("Error building Setup Locking range command.\n");
+		pr_debug("Error building Setup Locking range command.\n");
 		return err;
 
 	}
@@ -1234,11 +1234,8 @@ static int start_generic_opal_session(struct opal_dev *dev,
 	u32 hsn;
 	int err = 0;
 
-	if (key == NULL && auth != OPAL_ANYBODY_UID) {
-		pr_err("%s: Attempted to open ADMIN_SP Session without a Host" \
-		       "Challenge, and not as the Anybody UID\n", __func__);
+	if (key == NULL && auth != OPAL_ANYBODY_UID)
 		return OPAL_INVAL_PARAM;
-	}
 
 	clear_opal_cmd(dev);
 
@@ -1273,12 +1270,12 @@ static int start_generic_opal_session(struct opal_dev *dev,
 		add_token_u8(&err, dev, OPAL_ENDLIST);
 		break;
 	default:
-		pr_err("Cannot start Admin SP session with auth %d\n", auth);
+		pr_debug("Cannot start Admin SP session with auth %d\n", auth);
 		return OPAL_INVAL_PARAM;
 	}
 
 	if (err) {
-		pr_err("Error building start adminsp session command.\n");
+		pr_debug("Error building start adminsp session command.\n");
 		return err;
 	}
 
@@ -1369,7 +1366,7 @@ static int start_auth_opal_session(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-		pr_err("Error building STARTSESSION command.\n");
+		pr_debug("Error building STARTSESSION command.\n");
 		return err;
 	}
 
@@ -1391,7 +1388,7 @@ static int revert_tper(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	if (err) {
-		pr_err("Error building REVERT TPER command.\n");
+		pr_debug("Error building REVERT TPER command.\n");
 		return err;
 	}
 
@@ -1426,7 +1423,7 @@ static int internal_activate_user(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-		pr_err("Error building Activate UserN command.\n");
+		pr_debug("Error building Activate UserN command.\n");
 		return err;
 	}
 
@@ -1453,7 +1450,7 @@ static int erase_locking_range(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-		pr_err("Error building Erase Locking Range Command.\n");
+		pr_debug("Error building Erase Locking Range Command.\n");
 		return err;
 	}
 	return finalize_and_send(dev, parse_and_check_status);
@@ -1484,7 +1481,7 @@ static int set_mbr_done(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-		pr_err("Error Building set MBR Done command\n");
+		pr_debug("Error Building set MBR Done command\n");
 		return err;
 	}
 
@@ -1516,7 +1513,7 @@ static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-		pr_err("Error Building set MBR done command\n");
+		pr_debug("Error Building set MBR done command\n");
 		return err;
 	}
 
@@ -1567,7 +1564,7 @@ static int set_new_pw(struct opal_dev *dev, void *data)
 
 	if (generic_pw_cmd(usr->opal_key.key, usr->opal_key.key_len,
 			   cpin_uid, dev)) {
-		pr_err("Error building set password command.\n");
+		pr_debug("Error building set password command.\n");
 		return -ERANGE;
 	}
 
@@ -1582,7 +1579,7 @@ static int set_sid_cpin_pin(struct opal_dev *dev, void *data)
 	memcpy(cpin_uid, opaluid[OPAL_C_PIN_SID], OPAL_UID_LENGTH);
 
 	if (generic_pw_cmd(key->key, key->key_len, cpin_uid, dev)) {
-		pr_err("Error building Set SID cpin\n");
+		pr_debug("Error building Set SID cpin\n");
 		return -ERANGE;
 	}
 	return finalize_and_send(dev, parse_and_check_status);
@@ -1657,7 +1654,7 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-		pr_err("Error building add user to locking range command.\n");
+		pr_debug("Error building add user to locking range command.\n");
 		return err;
 	}
 
@@ -1691,7 +1688,7 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 		/* vars are initalized to locked */
 		break;
 	default:
-		pr_err("Tried to set an invalid locking state... returning to uland\n");
+		pr_debug("Tried to set an invalid locking state... returning to uland\n");
 		return OPAL_INVAL_PARAM;
 	}
 
@@ -1718,7 +1715,7 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-		pr_err("Error building SET command.\n");
+		pr_debug("Error building SET command.\n");
 		return err;
 	}
 	return finalize_and_send(dev, parse_and_check_status);
@@ -1752,14 +1749,14 @@ static int lock_unlock_locking_range_sum(struct opal_dev *dev, void *data)
 		/* vars are initalized to locked */
 		break;
 	default:
-		pr_err("Tried to set an invalid locking state.\n");
+		pr_debug("Tried to set an invalid locking state.\n");
 		return OPAL_INVAL_PARAM;
 	}
 	ret = generic_lr_enable_disable(dev, lr_buffer, 1, 1,
 					read_locked, write_locked);
 
 	if (ret < 0) {
-		pr_err("Error building SET command.\n");
+		pr_debug("Error building SET command.\n");
 		return ret;
 	}
 	return finalize_and_send(dev, parse_and_check_status);
@@ -1811,7 +1808,7 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 	}
 
 	if (err) {
-		pr_err("Error building Activate LockingSP command.\n");
+		pr_debug("Error building Activate LockingSP command.\n");
 		return err;
 	}
 
@@ -1831,7 +1828,7 @@ static int get_lsp_lifecycle_cont(struct opal_dev *dev)
 	/* 0x08 is Manufacured Inactive */
 	/* 0x09 is Manufactured */
 	if (lc_status != OPAL_MANUFACTURED_INACTIVE) {
-		pr_err("Couldn't determine the status of the Lifcycle state\n");
+		pr_debug("Couldn't determine the status of the Lifcycle state\n");
 		return -ENODEV;
 	}
 
@@ -1868,7 +1865,7 @@ static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-		pr_err("Error Building GET Lifecycle Status command\n");
+		pr_debug("Error Building GET Lifecycle Status command\n");
 		return err;
 	}
 
@@ -1887,7 +1884,7 @@ static int get_msid_cpin_pin_cont(struct opal_dev *dev)
 
 	strlen = response_get_string(&dev->parsed, 4, &msid_pin);
 	if (!msid_pin) {
-		pr_err("%s: Couldn't extract PIN from response\n", __func__);
+		pr_debug("%s: Couldn't extract PIN from response\n", __func__);
 		return OPAL_INVAL_PARAM;
 	}
 
@@ -1929,7 +1926,7 @@ static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-		pr_err("Error building Get MSID CPIN PIN command.\n");
+		pr_debug("Error building Get MSID CPIN PIN command.\n");
 		return err;
 	}
 
@@ -2124,18 +2121,18 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 
 	if (lk_unlk->l_state != OPAL_RO &&
 	    lk_unlk->l_state != OPAL_RW) {
-		pr_err("Locking state was not RO or RW\n");
+		pr_debug("Locking state was not RO or RW\n");
 		return -EINVAL;
 	}
 	if (lk_unlk->session.who < OPAL_USER1 ||
 	    lk_unlk->session.who > OPAL_USER9) {
-		pr_err("Authority was not within the range of users: %d\n",
-		       lk_unlk->session.who);
+		pr_debug("Authority was not within the range of users: %d\n",
+			 lk_unlk->session.who);
 		return -EINVAL;
 	}
 	if (lk_unlk->session.sum) {
-		pr_err("%s not supported in sum. Use setup locking range\n",
-		       __func__);
+		pr_debug("%s not supported in sum. Use setup locking range\n",
+			 __func__);
 		return -EINVAL;
 	}
 
@@ -2312,7 +2309,7 @@ static int opal_activate_user(struct opal_dev *dev,
 	/* We can't activate Admin1 it's active as manufactured */
 	if (opal_session->who < OPAL_USER1 ||
 	    opal_session->who > OPAL_USER9) {
-		pr_err("Who was not a valid user: %d\n", opal_session->who);
+		pr_debug("Who was not a valid user: %d\n", opal_session->who);
 		return -EINVAL;
 	}
 
@@ -2343,9 +2340,9 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 
 		ret = __opal_lock_unlock(dev, &suspend->unlk);
 		if (ret) {
-			pr_warn("Failed to unlock LR %hhu with sum %d\n",
-				suspend->unlk.session.opal_key.lr,
-				suspend->unlk.session.sum);
+			pr_debug("Failed to unlock LR %hhu with sum %d\n",
+				 suspend->unlk.session.opal_key.lr,
+				 suspend->unlk.session.sum);
 			was_failure = true;
 		}
 	}
@@ -2363,10 +2360,8 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 		return -EACCES;
 	if (!dev)
 		return -ENOTSUPP;
-	if (!dev->supported) {
-		pr_err("Not supported\n");
+	if (!dev->supported)
 		return -ENOTSUPP;
-	}
 
 	p = memdup_user(arg, _IOC_SIZE(cmd));
 	if (IS_ERR(p))
@@ -2410,7 +2405,7 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 		ret = opal_secure_erase_locking_range(dev, p);
 		break;
 	default:
-		pr_warn("No such Opal Ioctl %u\n", cmd);
+		break;
 	}
 
 	kfree(p);
-- 
2.7.4
