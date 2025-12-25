Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4A314D28
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766664572; cv=none; b=aTomIKcQtVrTN037xUzF7qKwutVaOyPcJuds8g/xy8bjH6GVZvA4/EoTxyZZGBAFneHfvtngYPMfwgzIVRug89icEfOAvWZM+q61WDzlwUxwl0dBvL2VSCOsJlHz9TqvyFQJsoAm3yk1YeIN1mMQfgfcR33o6cxllZOTCkwqJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766664572; c=relaxed/simple;
	bh=NdDH9KT2oQPzct880XNFNYPjPMT3eW7QvQs1BqjC+Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5Slz18OhU60G4NBnNWmmTivm/GaLhZ9imW3zV+yoT7tOEl+kyvlo/PIHNFc56tPrYMFXT3/xaDSkYoz0N00gjZQodIwz4SwVolH+tHrozFxHdBTaYKYOgL5EI+XMyZU/8S7x4fePamkeVJ3Al/rcSZTeeKwHZudg3uzyCHH+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UDmtvqEM; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UDmtvqEM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766664570; x=1798200570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NdDH9KT2oQPzct880XNFNYPjPMT3eW7QvQs1BqjC+Ug=;
  b=UDmtvqEMBgUzqaPlAN2qwuFUZe7AcDVkvpVF45xwCtgBgUXNT32hf8Cr
   6C23pnahajhhm/ETBHRnkG0szjufo8huikPa8ObCaphl+rDNyFpfW8PhO
   cSmCQplcwKQ/E9kshlHtMaj/u5EP0CjJwaqHD2sv3GTETj3VEYU994+C7
   82CjlZ/otzij3wnwdsuLesTHNgkqJLp/1/+7HlNg0kyu0laOipi7qj4u1
   ekpBfw3uyhrjHNo2cldu+xQ11surdf+s0Tq+p1rGxClRH3f+Red4Is5ew
   1sI/UWZE5W36UGpHKSvg83Y2F0TZfcUbln8vKeFfEln9onJ7ms7EsHjGD
   A==;
X-CSE-ConnectionGUID: JxdASxW5RAWfoaK/RvoouA==
X-CSE-MsgGUID: w3GqtBXGS6GbgKX4i4ibmw==
X-IronPort-AV: E=Sophos;i="6.21,176,1763395200"; 
   d="scan'208";a="138971437"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2025 20:09:26 +0800
IronPort-SDR: 694d2976_86nfAsWxcPuqhE7RGjS/IH1iKMjwdKUszFhSUFZ0UZiLuvV
 jMEXxXzfQY7vGpGA6x6OgVfkun7DeWYk0UT5KZQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Dec 2025 04:09:26 -0800
WDCIronportException: Internal
Received: from 5cg217421y.ad.shared (HELO shinmob.wdc.com) ([10.224.105.42])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Dec 2025 04:09:25 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: mcgrof@kernel.org,
	sw.prabhu6@gmail.com,
	bvanassche@acm.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v5 2/4] srp/rc: replace module removal with patient module removal
Date: Thu, 25 Dec 2025 21:09:17 +0900
Message-ID: <20251225120919.1575005-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251225120919.1575005-1-shinichiro.kawasaki@wdc.com>
References: <20251225120919.1575005-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

Bart had put the remove_mpath_devs() call inside a loop because multipathd
keeps running while the loop is ongoing and hence can modify paths
while the loop is running. The races that multipathd can trigger with the
module refcnt is precisely the sort of races which patient module
removal is supposed to address.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
[Shin'ichiro: moved a hunk of srp/rc change from the previous patch]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/srp/rc | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index 47b9546..2d3d615 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -331,19 +331,10 @@ start_srp_ini() {
 
 # Unload the SRP initiator driver.
 stop_srp_ini() {
-	local i
-
 	log_out
-	for ((i=40;i>=0;i--)); do
-		remove_mpath_devs || return $?
-		_unload_module ib_srp >/dev/null 2>&1 && break
-		sleep 1
-	done
-	if [ -e /sys/module/ib_srp ]; then
-		echo "Error: unloading kernel module ib_srp failed"
-		return 1
-	fi
-	_unload_module scsi_transport_srp || return $?
+	remove_mpath_devs || return $?
+	_patient_rmmod ib_srp || return 1
+	_patient_rmmod scsi_transport_srp || return $?
 }
 
 # Associate the LIO device with name $1/$2 with file $3 and SCSI serial $4.
@@ -502,7 +493,7 @@ start_lio_srpt() {
 	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
 		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
 	fi
-	_unload_module ib_srpt
+	_patient_rmmod ib_srpt
 	modprobe ib_srpt "${opts[@]}" || return $?
 	i=0
 	for r in "${vdev_path[@]}"; do
@@ -564,7 +555,7 @@ stop_lio_srpt() {
 			 target_core_file target_core_stgt target_core_user \
 			 target_core_mod
 	do
-		_unload_module $m 10 || return $?
+		_patient_rmmod $m || return $?
 	done
 }
 
-- 
2.52.0

