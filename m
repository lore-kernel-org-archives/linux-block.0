Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B911482DF
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568792; cv=none; b=O0l8sdfpAP7YIG8v84nf/JC4J8/mT+7hoCGgBumL+OdSAuqFaduAosrnl8pjt8iwmrH4NNjhYbcX4lTmVd7XBoDe+tdK0n5mnZ1giZNbn4pD/gObMjfboQzB/U1okQ2n8mk1DMuG1DPN6Uk04EPXPM3bkM2qO9snh5teVICGa3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568792; c=relaxed/simple;
	bh=aa79Ll025HQiq0/5SNE8/Bh6stG/qQCcoKDWY8HO9MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYHF8wOd3w0jymAkqoCR5u4J7xuPQbT6UR94jGRgbLDUxqkIOJOOxU3qbJz0uy0KNaM/IWr6MHWVRUX63tZO4RKRCz5VnRkw4XXa7O+xy6d6ZyzMdJc/UrVKFWMd28bO89YDpRkz0fa6KPEz/LL8EvQ9Qq05HsVxnIR7GfnqU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gOV2qGcW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BszQ/32u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gOV2qGcW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BszQ/32u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gOV2qGcW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BszQ/32u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gOV2qGcW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BszQ/32u"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 666191FD86;
	Mon,  4 Mar 2024 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYr10uhGwyJhv2Bn7zavFpYfS5IaeB3cAS6xVvgTdDo=;
	b=gOV2qGcW89d+1AGWnqB3UVmmKau9AgVQfy8CQ802t7Y5uyn5MDrz3YS1AQs7Mug/PSJJJ2
	TBZGApNww8wDtqWG1ccHz8mhcQ7lwBeBEAsMhqNpbXAg4YuxPfp5YEjQlC0PtfeIse23mW
	m6wmNdemGbj6lnWfbaGJDiI+lie+bqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYr10uhGwyJhv2Bn7zavFpYfS5IaeB3cAS6xVvgTdDo=;
	b=BszQ/32uH7xm81KT9QKPwFair1gE6Gds3QFAa9l+G3nP1wFO3q6Z6hySQPKyn6XfvCm8Ne
	DK3zWWn9ADyUPmBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYr10uhGwyJhv2Bn7zavFpYfS5IaeB3cAS6xVvgTdDo=;
	b=gOV2qGcW89d+1AGWnqB3UVmmKau9AgVQfy8CQ802t7Y5uyn5MDrz3YS1AQs7Mug/PSJJJ2
	TBZGApNww8wDtqWG1ccHz8mhcQ7lwBeBEAsMhqNpbXAg4YuxPfp5YEjQlC0PtfeIse23mW
	m6wmNdemGbj6lnWfbaGJDiI+lie+bqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYr10uhGwyJhv2Bn7zavFpYfS5IaeB3cAS6xVvgTdDo=;
	b=BszQ/32uH7xm81KT9QKPwFair1gE6Gds3QFAa9l+G3nP1wFO3q6Z6hySQPKyn6XfvCm8Ne
	DK3zWWn9ADyUPmBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 53BDB139C6;
	Mon,  4 Mar 2024 16:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VugDExXz5WUgewAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 16:13:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 2/2] nvme/048: add reconnect after ctrl key change
Date: Mon,  4 Mar 2024 17:13:03 +0100
Message-ID: <20240304161303.19681-3-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304161303.19681-1-dwagner@suse.de>
References: <20240304161303.19681-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

The re-authentication is a soft state, meaning unless the host has to
reconnect a key change on the target side is not observed. Extend the
current test with a forced reconnect after a key change. This
exercises the DNR handling code of the host.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/045     | 72 +++++++++++++++++++++++++++++++++++++++++++++-
 tests/nvme/045.out |  3 +-
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/045 b/tests/nvme/045
index be408b629771..b0527685f61f 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -21,6 +21,62 @@ requires() {
 	_have_driver dh_generic
 }
 
+nvmf_wait_for_state() {
+	local def_state_timeout=5
+	local subsys_name="$1"
+	local state="$2"
+	local timeout="${3:-$def_state_timeout}"
+	local nvmedev
+	local state_file
+	local start_time
+	local end_time
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+
+	start_time=$(date +%s)
+	while ! grep -q "${state}" "${state_file}"; do
+		sleep 1
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "expected state \"${state}\" not " \
+				"reached within ${timeout} seconds"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
+nvmf_wait_for_ctrl_delete() {
+	local def_state_timeout=5
+	local nvmedev="$1"
+	local timeout="${2:-$def_state_timeout}"
+	local ctrl="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+	local start_time
+	local end_time
+
+	start_time=$(date +%s)
+	while [ -f "${ctrl}" ]; do
+		sleep 1
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "controller \"${nvmedev}\" not deleted" \
+				"within ${timeout} seconds"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
+set_nvmet_attr_qid_max() {
+	local nvmet_subsystem="$1"
+	local qid_max="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	echo "${qid_max}" > "${cfs_path}/attr_qid_max"
+}
 
 test() {
 	echo "Running ${TEST_NAME}"
@@ -55,7 +111,11 @@ test() {
 			     --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
-			     --dhchap-ctrl-secret "${ctrlkey}"
+			     --dhchap-ctrl-secret "${ctrlkey}" \
+			     --reconnect-delay 1
+
+	nvmf_wait_for_state "${def_subsysnqn}" "live"
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	echo "Re-authenticate with original host key"
 
@@ -108,6 +168,16 @@ test() {
 	rand_io_size="$(_nvme_calc_rand_io_size 4m)"
 	_run_fio_rand_io --size="${rand_io_size}" --filename="/dev/${nvmedev}n1"
 
+	echo "Renew host key on the controller and force reconnect"
+
+	new_hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
+
+	_set_nvmet_hostkey "${def_hostnqn}" "${new_hostkey}"
+
+	# Force a reconnect
+	set_nvmet_attr_qid_max "${def_subsysnqn}" 1
+	nvmf_wait_for_ctrl_delete "${nvmedev}"
+
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
diff --git a/tests/nvme/045.out b/tests/nvme/045.out
index 84a69ef5c4c6..3331304ef71a 100644
--- a/tests/nvme/045.out
+++ b/tests/nvme/045.out
@@ -8,5 +8,6 @@ Change DH group to ffdhe8192
 Re-authenticate with changed DH group
 Change hash to hmac(sha512)
 Re-authenticate with changed hash
-disconnected 1 controller(s)
+Renew host key on the controller and force reconnect
+disconnected 0 controller(s)
 Test complete
-- 
2.44.0

