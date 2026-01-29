Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2366C2741C0;
	Thu, 29 Jan 2026 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665244; cv=none; b=ZTwOPON+W/vNBMfl7umGnNACTuxd/0Rw5QNAuOw10i2RK0Xug4Im16fR03s/qIuZ8FEQYC9/GhfdwKf0OHIQ5HIzu+FYRuvqqC0XSKNwOaeOdbY0nRbxpVXFakDyLmKnoV47WQmYB1GXhM9TXlsquzLa5P8IQv04WVVB9QEfafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665244; c=relaxed/simple;
	bh=70sTjwi6oA/dnqe8i9Y+rkZLzAq6nfQvpkl7GSjTT8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WM0sk6swcwXUAfgqXkgSOo9zhLp0639wk7Px8/b87LIcMyVhtb45635Pf4hw9KPNyVO3IwLv53E8nNozuV2gFvv6LU5gApLWrGGb+5hHy4QL5Wy2H8IDy05PUf2Ikw1ZfYBsQztpVO8qDmj3qlFFOr/1oRn04SIRRT5KT/Q9jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=ul8SDwIm; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="ul8SDwIm"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769665233; bh=70sTjwi6oA/dnqe8i9Y+rkZLzAq6nfQvpkl7GSjTT8E=;
	h=From:To:Cc:Subject;
	b=ul8SDwImA8qTKz96Vj9rczAAMQs8xUoPLxSfd2gWK9v3MgpkJJu3Ei8kAQBPkMShp
	 s5dJUGbVaAQGS3ziitBUcXbUZ/4RBxJ/VcfDtwhDO+sZHvEvdvEwfcftVYZxRsGcFU
	 +B4x86tkBj4nEUBrtWc9/54og38/iN7nV7dtsUiBZMRAUAKh3NLfszuj6h5AEGs8YL
	 PPjMnRGetdg/t0s1B925Z665mEV35yIYfHo5Ga6ZRX6Zzc49krbnH/N0ixMVYoH709
	 4lvkVWasq2ufl370HfTdBpY7AN+slXFDn2omdqd/XqA1/rHoo1v3jixqXwf4hs1dsn
	 HV19kW4Gn/sZdhwTleR4ul2T0JAplHSNiiErTOhY3C5ZzVBL7Nvlrz0+zQUIDqa23T
	 r/AgXdh8Qw45b3K2St1C7iCrsjTecoxM43srCGYgRt8JAccdE+8QhfLc4IslXPrt1e
	 GE7I9TVltLk7H4HdwtSirhyGVj7TCtaru2uOSaijGjODbN4bECv93V0FcR87EFpqo1
	 n1MamSpkRFwT+mxkZRyZI2OmkXdOOC6rC0Okm3UM0MckEFPsvVRh0boKf0qaV2BUZN
	 I+dy3gY3NDKO+Cyqv5+mRj7cNtdqB391TOoCdATHJpz1HGUpTACRlncz0VaDTksHbQ
	 iIUy4YTZN/hdgsacI8HuEl5k=
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Alexander Atanasov <alex@zazolabs.com>,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: ublk: move test temp files into a sub directory
Date: Thu, 29 Jan 2026 05:40:25 +0000
Message-ID: <20260129054026.227828-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 7ff6ce79d62c..46983ccf5c1a 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -43,7 +43,7 @@ _create_backfile() {
 	old_file="${UBLK_BACKFILES[$index]}"
 	[ -f "$old_file" ] && rm -f "$old_file"
 
-	new_file=$(mktemp ublk_file_"${new_size}"_XXXXX)
+	new_file=$(mktemp ${UBLK_TEST_DIR}/ublk_file_"${new_size}"_XXXXX)
 	truncate -s "${new_size}" "${new_file}"
 	UBLK_BACKFILES["$index"]="$new_file"
 }
@@ -60,7 +60,7 @@ _remove_files() {
 _create_tmp_dir() {
 	local my_file;
 
-	my_file=$(mktemp -d ublk_dir_XXXXX)
+	my_file=$(mktemp -d ${UBLK_TEST_DIR}/ublk_dir_XXXXX)
 	echo "$my_file"
 }
 
@@ -119,7 +119,9 @@ _prep_test() {
 	local type=$1
 	shift 1
 	modprobe ublk_drv > /dev/null 2>&1
-	UBLK_TMP=$(mktemp ublk_test_XXXXX)
+	TDIR=$(mktemp -d ${TMPDIR:-.}/ublktest-dir.XXXXXX)
+	export UBLK_TEST_DIR=${TDIR}
+	UBLK_TMP=$(mktemp ${UBLK_TEST_DIR}/ublk_test_XXXXX)
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
 }
 
@@ -165,6 +167,7 @@ _cleanup_test() {
 	"${UBLK_PROG}" del -a
 
 	_remove_files
+	rmdir ${UBLK_TEST_DIR}
 }
 
 _have_feature()
@@ -398,6 +401,8 @@ UBLK_PROG=$(_ublk_test_top_dir)/kublk
 UBLK_TEST_QUIET=1
 UBLK_TEST_SHOW_RESULT=1
 UBLK_BACKFILES=()
+UBLK_TEST_DIR=${TMPDIR:-.}
 export UBLK_PROG
 export UBLK_TEST_QUIET
 export UBLK_TEST_SHOW_RESULT
+export UBLK_TEST_DIR

base-commit: f46ebb910989a1db244f95bd1f937907591aa2ee
-- 
2.43.0

