Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF4E280CF8
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427002; cv=none; b=rquZZnF7IOJoV7BM70T4nN43W0ijXWJIe9eADR10UT/4FWhF6SHzAAVj3a2Qxpy/oCymZajRmn+eNyyUCRUNut5/t6iZqmQCSkoJiCu788VV1l6ZzabiM6LmHpWDuGQHkeSmzLvO/9M+ZnyT9cDFu6R7OGvQk8be9ghd5bJ4IWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427002; c=relaxed/simple;
	bh=Z1m/PU2hY956olAe1YOGTf/XalzrqqMHd4NU2/31BMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ff9qGunbjVXyO74DSUYaM8xNT8Z/Al/0EiItG/oR9ojDCWeVQ6mzWbkDT/Hl8gcZ0MlByvQvq/ebF/QUW0kkaPKvDTaa1lGTZFSVQoRqFsGsM+QWSGMJcM302IRvKsBjh6YjEIqrLbNeKkWH1EJQ5ZM9DVvryUycGVOlRx8/aog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J91+tXAI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J91+tXAI"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47666bd7026so63401cf.2
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745427000; x=1746031800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=34RjNwR8wpSYhrDbyQGJjUvc/aPNOKAfCSR8EYSOfYQ=;
        b=J91+tXAIZhWIhECeD5kQ+TV+6lbAnbgyJuYCTi+5qsLWEpfTYYioBYw8x/JwBqceVe
         LprsSE1xkLbYszUQRJItEA8WuJKLccoe193NHpM85A0IpKQPlJtXHlM8w3KR+Ec/iEgC
         yuXvgEXtEFzwdKnngPVYm6BQkbGnEMAxTt5OHJsPWEF2RWFkCQc6aiL8osIN/1kFqKAO
         ++/0yAZA+lpuZdnE3eA1T2EyK15guQrGy3yc6g8eWBB6uyFSaEpSXZnxNWOqf+TtRqmX
         bePihNGrN7NoMpU+mWYZizGcWe7/lCRTy4f9Sr5CtymNvL6dX2T39O151gubv06+e8OB
         KKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427000; x=1746031800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34RjNwR8wpSYhrDbyQGJjUvc/aPNOKAfCSR8EYSOfYQ=;
        b=X3pItRPEZEeEFw0EqZapAu7i73cEQ6Z0Cm1KA/t18KnI4NzbQf26pQe0A5rjgvZU5w
         7Wy+8gOpwLfluRyKcafFhyGWqnxqd1TIajWpW+9xWL8LjJFNkw5z16uNxoQ6ACOyY+2P
         KXIJlWFcD8O03O0No3zU76pspE8dv3Cz/LfZZJyWoSLp1YtvEuNLU2XBDWpLMZAPb9uo
         Fdn7uZfSZmF2i+IEuzSRL4ltR2njjUTZkPUisRFnIj6A0IBcQvZidHzvkxMjJQqU9LEW
         5SjR8xKtvdW9HpItYDuj5s0/iNcNUTKqC3qY3C09PAi7MtC6wDpPsSMTPKTz5ryDht3c
         MQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCW0plvw33KDCBTVUX7tuKdW4lDqfa7h56FlPdMT4L/eJrF7l9dpiGm5uAB/65fQFOeYpZRx9omKJVjy1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YywMvcep+Dsr6LbuM6N1m58tK5cjsaYHwPfF+ZCGJtto6qJVzFJ
	mmfJpJHav+ITlS8mwEkfNnPlz9EwrjmLHDx3NXvuiHlSSDT2U5vI
X-Gm-Gg: ASbGnct2KgVVRBImAMjEKhyjUeyPDzNm4NVv9uar0QqLVkXNnWzjXsGjEDlRmrXrKzy
	2eXXDGILB01y/El4R3uA2rmg6ZgRjzFcIy55N06iCp4FMr+eSD+o4ODzBGPLQrzSJvVWXDKmvu2
	Js7vTvh0xj5Ymqmwyl12dAxOBWVyhafQ98NgURedanyEq6PU8QtC78EB224BaYCB2wESc8kM/6x
	n5rUHlfIc0pOLW42CHqIlDypd6s0HMtI/U2bNMWfyvTPJX59PB9kWU9hNc5d1qhyPL9auxE6oO2
	MIKj0lXY8ApDz4iqZsWaBtpT0NBk7GtYIHp7SJ7mKt6QZX48wHcPoslEmfGf5cC9gktXVon1Ak/
	3JGPdL+Tz
X-Google-Smtp-Source: AGHT+IE2FYWO0M6glcgAeGw7XLBCKWyf2JU75wQSimzHYYgzYSX72p+RdgkCSTAu2CisNdfpCeDcig==
X-Received: by 2002:a05:622a:118c:b0:472:15be:54ad with SMTP id d75a77b69052e-47d1f119f63mr21345731cf.14.1745426999529;
        Wed, 23 Apr 2025 09:49:59 -0700 (PDT)
Received: from localhost (pool-108-48-176-137.washdc.fios.verizon.net. [108.48.176.137])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9c179f1sm70380351cf.16.2025.04.23.09.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 09:49:58 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH blktests] zbd/005: Limit block size to zone length
Date: Wed, 23 Apr 2025 12:49:57 -0400
Message-Id: <20250423164957.2293594-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block size must be smaller than the zone length, otherwise fio will
fail immediately.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 tests/zbd/005 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/zbd/005 b/tests/zbd/005
index 4aa1ab5..3e1ded9 100755
--- a/tests/zbd/005
+++ b/tests/zbd/005
@@ -29,6 +29,7 @@ test_device() {
 	local -i zone_idx
 	local -i offset
 	local -i moaz
+	local -i block_size
 	local -a zbdmode=()
 
 	echo "Running ${TEST_NAME}"
@@ -38,6 +39,8 @@ test_device() {
 	zone_idx=$(_find_first_sequential_zone) || return $?
 	offset=$((ZONE_STARTS[zone_idx] * 512))
 	moaz=$(_test_dev_max_open_active_zones)
+	block_size=$(((ZONE_LENGTHS[zone_idx] > 512 ? \
+		       512 : ZONE_LENGTHS[zone_idx]) * 512))
 
 	# If the test target zone has smaller zone capacity than zone size,
 	# or if the test target device has max open/active zones limit, enable
@@ -53,7 +56,7 @@ test_device() {
 	: "${TIMEOUT:=30}"
 	FIO_PERF_FIELDS=("write io" "write iops")
 	_fio_perf --filename="${TEST_DEV}" --name zbdwo --rw=write --direct=1 \
-		  --ioengine=libaio --iodepth=128 --bs=256k \
+		  --ioengine=libaio --iodepth=128 --bs="${block_size}" \
 		  --offset="${offset}" "${zbdmode[@]}"
 
 	_put_blkzone_report
-- 
2.37.1

