Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994008;
	b=20KXfqhEzZf7jtnpUT8Vuqdt1Ni4sSo9hdTh9pmze5D1t7TXd/9pl0/SjLEMJxf89ElL
	 K64WiH1yWfbRbBpOWtin7oZgrkemb/uD7jX01iJsz1+du6OH4xcuEFaKxSILNM+tPvNqh
	 8Z57q+Qjhi8Nz18C0TZQex9VCUjUGAjfZF7oznJBv3CSswVz0n5KFvzfFHWuqDFEU85wu
	 T7pscBkk6QB7kplijtP+iTcfW4cHfgR7mgEW6uya5O8DfcyvesrLUmkbPE6fA2IYCSmzx
	 PtWppRWcRDuqhc9AeuuIWuTLYAgnl6EPu6ReRbfn2jfRAjzQlN8T7W2ZkRkHbNwWA0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994008;
	h=DMARC-Filter:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Rspamd-Pre-Result:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action;
	bh=TYDkuLXuNbM0Eq7g9GiF+sYTX/4lUle7tlRjILJ4TQ8=;
	b=4UrKf4tdvk1wnemxzDKdSVgoZ7DcQz+oRIbmCeAyIxbpf0Gpbocj3/XcFUCjJLSvuJy4
	 JDOlVO6P1xdDIXfy9X1gqvRVD6bwY47Syt4rJj+scfsNLL+n2kc6LldbptcF9ylcpBEjZ
	 OBsCpD3yaZPogEFVRZaXXHhJNx0Nawi7JL/NCP0jwcue+LVcLXhG/jjQPdkCVG6n4K2Bh
	 y5l3tqXi7v6bqy59nbU9wpwDYjXj4Hlk7ljl+9L92Rf5Mizy+WjpYIju8+940Udccmhco
	 QfEhRPuB+aNKgwBhEEcNmeJyF4ub0ddvVO3g7twURTBG/cVBp25WtQOMPRR4lXasTsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1226606A332
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 09:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1226606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21468222DB;
	Wed, 18 Nov 2026 09:26:46 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D33CF1334C;
	Wed, 18 Nov 2026 09:26:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3k2DKlVv/Wo/fgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:45 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:41 +0100
Subject: [PATCH blktests v2 3/9] nvme/042, nvme/043: iterate over the
 DH-HMAC-CHAP hashes by name
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-nvme-target-control-v2-3-d191bbbf5dd6@suse.de>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 21468222DB
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

nvme/042 iterates over the numeric hash IDs nvme-cli takes, nvme/043
over the hash names of the nvmet configfs. Add a --hash option to
_nvme_gen_kxchap_secret which takes the hash name, and use the plain
names in both tests, and in nvme/063.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/nvme        | 18 ++++++++++++++++++
 tests/nvme/042     | 10 +++++-----
 tests/nvme/042.out |  8 ++++----
 tests/nvme/043     |  6 +++---
 tests/nvme/043.out |  6 +++---
 tests/nvme/063     |  4 ++--
 6 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/common/nvme b/common/nvme
index dfe85b6e281f..6fba3890b6ce 100644
--- a/common/nvme
+++ b/common/nvme
@@ -168,9 +168,27 @@ _nvme_run() {
 	nvme $(_nvme_cmd "$current") "$@"
 }
 
+# Generate a DH-HMAC-CHAP secret. --hash=HASH transforms the secret with HASH:
+# none, sha256, sha384 or sha512. The other arguments go to nvme-cli.
 _nvme_gen_kxchap_secret() {
+	local -a secret_args=()
+	local -A hmac_ids=([none]=0 [sha256]=1 [sha384]=2 [sha512]=3)
+
 	_nvme_cli_detect_version
 
+	while (($#)); do
+		case "$1" in
+		--hash=*)
+			secret_args+=("--hmac=${hmac_ids[${1#--hash=}]}")
+			;;
+		*)
+			secret_args+=("$1")
+			;;
+		esac
+		shift
+	done
+	set -- "${secret_args[@]}"
+
 	if ((!_is_nvme_cli_pre_v3)); then
 		local -a kxchap_args=()
 
diff --git a/tests/nvme/042 b/tests/nvme/042
index bddbd1bbfc28..7c558e287805 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -27,18 +27,18 @@ test() {
 
 	_setup_nvmet
 
-	local hmac
+	local hash
 	local key_len
 	local hostkey
 	local ctrldev
 
 	_nvmet_target_setup --blkdev file
 
-	for hmac in 0 1 2 3; do
-		echo "Testing hmac ${hmac}"
-		hostkey="$(_nvme_gen_kxchap_secret --hmac=${hmac} 2> /dev/null)"
+	for hash in none sha256 sha384 sha512; do
+		echo "Testing hash ${hash}"
+		hostkey="$(_nvme_gen_kxchap_secret --hash="${hash}" 2> /dev/null)"
 		if [ -z "$hostkey" ] ; then
-			echo "couldn't generate host key for hmac ${hmac}"
+			echo "couldn't generate host key for hash ${hash}"
 			return 1
 		fi
 		_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
diff --git a/tests/nvme/042.out b/tests/nvme/042.out
index 1c3fc6130696..9a9fc697b4f5 100644
--- a/tests/nvme/042.out
+++ b/tests/nvme/042.out
@@ -1,8 +1,8 @@
 Running nvme/042
-Testing hmac 0
-Testing hmac 1
-Testing hmac 2
-Testing hmac 3
+Testing hash none
+Testing hash sha256
+Testing hash sha384
+Testing hash sha512
 Testing key length 32
 Testing key length 48
 Testing key length 64
diff --git a/tests/nvme/043 b/tests/nvme/043
index ac25610a402b..f85916c842fe 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -41,18 +41,18 @@ test() {
 
 	_nvmet_target_setup --blkdev file --hostkey "${hostkey}"
 
-	for hash in "hmac(sha256)" "hmac(sha384)" "hmac(sha512)" ; do
+	for hash in sha256 sha384 sha512; do
 
 		echo "Testing hash ${hash}"
 
-		_set_nvmet_hash "${def_hostnqn}" "${hash}"
+		_set_nvmet_hash "${def_hostnqn}" "hmac(${hash})"
 
 		_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 		_nvme_disconnect_subsys
 	done
 
-	for dhgroup in "ffdhe2048" "ffdhe3072" "ffdhe4096" "ffdhe6144" "ffdhe8192" ; do
+	for dhgroup in ffdhe2048 ffdhe3072 ffdhe4096 ffdhe6144 ffdhe8192; do
 
 		echo "Testing DH group ${dhgroup}"
 
diff --git a/tests/nvme/043.out b/tests/nvme/043.out
index f3f55a4449b6..c99949489070 100644
--- a/tests/nvme/043.out
+++ b/tests/nvme/043.out
@@ -1,7 +1,7 @@
 Running nvme/043
-Testing hash hmac(sha256)
-Testing hash hmac(sha384)
-Testing hash hmac(sha512)
+Testing hash sha256
+Testing hash sha384
+Testing hash sha512
 Testing DH group ffdhe2048
 Testing DH group ffdhe3072
 Testing DH group ffdhe4096
diff --git a/tests/nvme/063 b/tests/nvme/063
index feb07bf3a06c..ff8e0ab90026 100755
--- a/tests/nvme/063
+++ b/tests/nvme/063
@@ -34,7 +34,7 @@ test() {
 
 	_systemctl_start tlshd
 
-	hostkey=$(_nvme_gen_kxchap_secret --hmac 1 2> /dev/null)
+	hostkey=$(_nvme_gen_kxchap_secret --hash=sha256 2> /dev/null)
 	if [ -z "$hostkey" ] ; then
 		echo "key generation failed"
 		_systemctl_stop
@@ -76,7 +76,7 @@ test() {
 
 	_nvme_disconnect_subsys
 
-	hostkey=$(_nvme_gen_kxchap_secret --hmac 2 2> /dev/null)
+	hostkey=$(_nvme_gen_kxchap_secret --hash=sha384 2> /dev/null)
 	if [ -z "$hostkey" ] ; then
 		echo "key generation failed"
 		_systemctl_stop

-- 
2.56.1

