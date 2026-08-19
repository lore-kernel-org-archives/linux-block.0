Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7689369997
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169882; cv=none; b=NGPewmCoReHNdf0Ub5GI0qRJuCeCjGMybn9Floow+D0GOESRVrYwXbgWrwv0CLfLDs4AqUFBvLeM5Y5Vbh/qLu5r7s6yviHGLj4cyZCARelBK33GN2oJ/OV/cR7Pq/9ppvVkKd/QWP4ZOX6htarJXvvt9tD7Bo2S9q1PB3Vc3IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169882; c=relaxed/simple;
	bh=0dvk4nk5gpsKMIq8BEv5Po7+q6RDympHso3neZQkkas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0ZNC9i48uWIZol1wf6VnDFcdNrk7aBmnEZZ98tR+Zpn58cs+nQr9wf94CWWGXeHBRI548p5X360lgHlK373p0eTUgDksY60pJXptV0TBoIXkfON8Lx/xIr7CJBRfofdTB+7vwtGkQwJVSas6c6SRpN81aU3pxaofZVEBGiVIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/xzzQQh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/xzzQQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787169879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IARjiBP/HesLaf/M73N36h/GTjovCKkTmivEOztlIIc=;
	b=L/xzzQQhdVTd1t1UQCf95C1KC8qvOuMcLwG5IdNq3UMHiJZHlKtIp7Hl5ZOe/ldMv5w+3G
	tQpls0ZmyWL1Dh6JC9MPHQ/MusLNZ0dy/eY9uTE7150Q1w5aZoLxRXAQngv1oU/e2vloTN
	7iGDkiMSYPZHDRaPX3dnjlhCHcbNXz0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-xbWcBtjCOnicHS6lRgetfA-1; Wed,
 19 Aug 2026 16:04:33 -0400
X-MC-Unique: xbWcBtjCOnicHS6lRgetfA-1
X-Mimecast-MFC-AGG-ID: xbWcBtjCOnicHS6lRgetfA_1787169871
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED04B195609F;
	Wed, 19 Aug 2026 20:04:30 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.17.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90EDE1800347;
	Wed, 19 Aug 2026 20:04:29 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [PATCH v2 1/2] nvme: Add _setup_nvmet_port_marginal
Date: Wed, 19 Aug 2026 16:04:24 -0400
Message-ID: <20260819200425.194743-2-jtaubepe@redhat.com>
In-Reply-To: <20260819200425.194743-1-jtaubepe@redhat.com>
References: <20260819200425.194743-1-jtaubepe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Adds functionality to set up a NVME port in marginal state.
This is useful for testing the behavior of the NVME driver when a port
is in a marginal state.

Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
---
V1 -> V2:
 - Added john's review and test-by tags
 - Use != instead of ! ==
 - Wrap lines over 80col
---
 common/nvme | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/common/nvme b/common/nvme
index f399937..a6d6b28 100644
--- a/common/nvme
+++ b/common/nvme
@@ -153,6 +153,16 @@ _nvme_fcloop_add_tport() {
 	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
 }
 
+_nvme_fcloop_set_rport_marginal() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local marginal="$3"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn},marginal=${marginal}" \
+	     > ${loopctl}/set_marginal_rport
+}
+
 _nvme_fcloop_del_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
@@ -763,6 +773,27 @@ _create_nvmet_port() {
 	echo "${port}"
 }
 
+_setup_nvmet_port_marginal() {
+	local -i port="$1"
+	local state="${2}"
+
+	if [[ "${nvme_trtype}" != "fc" ]]; then
+		echo "FAIL _setup_nvmet_port_marginal() only supports fc transport"
+		exit 1
+	fi
+
+	if [[ "${state}" == "live" ]]; then
+		_nvme_fcloop_set_rport_marginal "$(_remote_wwnn $port)" \
+					"$(_remote_wwpn $port)" 0
+	elif [[ "${state}" == "marginal" ]]; then
+		_nvme_fcloop_set_rport_marginal "$(_remote_wwnn $port)" \
+					"$(_remote_wwpn $port)" 1
+	else
+		echo "FAIL _setup_nvmet_port_marginal() invalid state: ${state}"
+		exit 1
+	fi
+}
+
 _setup_nvmet_port_ana() {
 	local port="$1"
 	local anagrpid="${2:-$def_anagrpid}"
-- 
2.54.0

