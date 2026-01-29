Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D633EB07
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703653; cv=none; b=sV7kTaonu5ZfXDGMSOd2QemyRkXiLViSbzr2p+yo/Thj8w62AkcMu1xBNh+G4XBlm3CSbMCfOdNY0vBVMdVRZFyEVFym9cBV5WBjLjYsdlqQQqkwQx0J9FydIphCa5KftqrWZvYJ54yrkV5UGTvrD/AkJjWGK3U0qDnVwUIk228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703653; c=relaxed/simple;
	bh=H8cu+SJ+zQ6yhDtEr1rsVuEXslbBKKbcnHxVgzTvbrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krrO+rcwgC9kx6R3HDWyIr88D/FnM9uMOsP/Ysbb38XreY45dLaeDQAC4xL+sKQkDHohq+EKaSwkywUTtjkYi4E6F//Pb5SCDJIIzv8L1pIrfcXdSg4MYaml9C9OmhgS3UnILF/vOhtCSpPSnnzbz2G9rmT14N1OcJBbCLjhbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GtQ85mDx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtQ85mDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ECg2gi4CD8k5yDt4nW8JY+m838f6VWz7/YpKJ1clCE=;
	b=GtQ85mDxVkWJdVXM09Qb0AjHM140BMf0+PXC6bMgLAhsr72+IEv5olCCZPRmP6GwciR4hD
	4c2eeH4/Fn7BW5OCE7PmzphEVER0m/bA/aQMeKkCiDxWUQePcjBcdJz687gGd084SGdWDM
	sBilWA9xbsTkMQ5VF8EUL9O8G7tJPus=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-ATuKmNsCMpKiZSqVwogUGw-1; Thu,
 29 Jan 2026 11:20:46 -0500
X-MC-Unique: ATuKmNsCMpKiZSqVwogUGw-1
X-Mimecast-MFC-AGG-ID: ATuKmNsCMpKiZSqVwogUGw_1769703645
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E981F1956061;
	Thu, 29 Jan 2026 16:20:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15BA21800995;
	Thu, 29 Jan 2026 16:20:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH V2 9/9] selftests: ublk: move test temp files into a sub directory
Date: Fri, 30 Jan 2026 00:19:58 +0800
Message-ID: <20260129162001.3532311-10-ming.lei@redhat.com>
In-Reply-To: <20260129162001.3532311-1-ming.lei@redhat.com>
References: <20260129162001.3532311-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Alexander Atanasov <alex@zazolabs.com>

Create and use a temporary directory for the files created during
test runs. If TMPDIR environment variable is set use it as a base
for the temporary directory path.
TMPDIR=/mnt/scratch make run_tests
and
TMPDIR=/mnt/scratch ./test_generic_01.sh
will place test directory under /mnt/scratch

Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 tools/testing/selftests/ublk/test_common.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index dd4eff97610a..21ba51fcc7d7 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -48,7 +48,7 @@ _create_backfile() {
 	old_file="${UBLK_BACKFILES[$index]}"
 	[ -f "$old_file" ] && rm -f "$old_file"
 
-	new_file=$(mktemp ublk_file_"${new_size}"_XXXXX)
+	new_file=$(mktemp ${UBLK_TEST_DIR}/ublk_file_"${new_size}"_XXXXX)
 	truncate -s "${new_size}" "${new_file}"
 	UBLK_BACKFILES["$index"]="$new_file"
 }
@@ -65,7 +65,7 @@ _remove_files() {
 _create_tmp_dir() {
 	local my_file;
 
-	my_file=$(mktemp -d ublk_dir_XXXXX)
+	my_file=$(mktemp -d ${UBLK_TEST_DIR}/ublk_dir_XXXXX)
 	echo "$my_file"
 }
 
@@ -124,7 +124,9 @@ _prep_test() {
 	local type=$1
 	shift 1
 	modprobe ublk_drv > /dev/null 2>&1
-	UBLK_TMP=$(mktemp ublk_test_XXXXX)
+	TDIR=$(mktemp -d ${TMPDIR:-.}/ublktest-dir.XXXXXX)
+	export UBLK_TEST_DIR=${TDIR}
+	UBLK_TMP=$(mktemp ${UBLK_TEST_DIR}/ublk_test_XXXXX)
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
 	echo "ublk selftest: $TID starting at $(date '+%F %T')" | tee /dev/kmsg
 }
@@ -171,6 +173,7 @@ _cleanup_test() {
 	"${UBLK_PROG}" del -a
 
 	_remove_files
+	rmdir ${UBLK_TEST_DIR}
 	echo "ublk selftest: $TID done at $(date '+%F %T')" | tee /dev/kmsg
 }
 
@@ -405,6 +408,8 @@ UBLK_PROG=$(_ublk_test_top_dir)/kublk
 UBLK_TEST_QUIET=1
 UBLK_TEST_SHOW_RESULT=1
 UBLK_BACKFILES=()
+UBLK_TEST_DIR=${TMPDIR:-.}
 export UBLK_PROG
 export UBLK_TEST_QUIET
 export UBLK_TEST_SHOW_RESULT
+export UBLK_TEST_DIR
-- 
2.47.0

