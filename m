Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B20360EEE
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931044; cv=none; b=bbQc8JCJNKXr1ytDjChBAjycQPJHCAsmCDuCy724+89YQ+HYx1GUd2oO7MFB+2oWJgFvWla1ojOYJ+dNgPwVt0DR/1aouLURjKAGyxqCIRklI90ZYZECX2EDk7bRjm4Nmt/etXeRi6KqzT6meGI341MVVbgXLVS2ztzx3VcyRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931044; c=relaxed/simple;
	bh=EviyQOEI6kDwLo3GU4A8RXcxFaHwsppKYQi4n08jW1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNsX4wDbxneCRvercmr6mljD2iLdomt2KQMig7AqmDih1x7E8URYTF66m60I+5DCYTXXNK8UT14JcMox8xKbWGewcFevkOrCTYMezqCWuqfNe/acAsksENnIkjKXOgiW2yhQkcqa416TaiULMmPYi/zg/Mo9+Muwr2C2H8Fuz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUpF35Rh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUpF35Rh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787931040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lx1CAIf6tsyVUQzXCCizsxM8XuTzINorxK0ajxMJa58=;
	b=aUpF35RhnGT45VTGOPuuyH4bUxR4pvzK7dCABHRzLOVj/o00+vvfWj1uk5p3KI489hxwtv
	jDJwwJmSEUSOcHS0Lg8E8yEzdPC+KxyL6OO62tYF0XBxaOJiBbUrSJHSFEx0/o4RSXcWhd
	0OMh8OkkLhS86+sOnaHi9y+h3QjNTek=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-3_h1g1a-Mla4clDmgM90iQ-1; Fri,
 28 Aug 2026 11:30:36 -0400
X-MC-Unique: 3_h1g1a-Mla4clDmgM90iQ-1
X-Mimecast-MFC-AGG-ID: 3_h1g1a-Mla4clDmgM90iQ_1787931035
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD02619774EB;
	Fri, 28 Aug 2026 15:30:35 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.80.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C7B018005B2;
	Fri, 28 Aug 2026 15:30:34 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [blktests v3 1/2] nvme: Add _setup_nvmet_port_marginal
Date: Fri, 28 Aug 2026 11:30:28 -0400
Message-ID: <20260828153029.853768-2-jtaubepe@redhat.com>
In-Reply-To: <20260828153029.853768-1-jtaubepe@redhat.com>
References: <20260828153029.853768-1-jtaubepe@redhat.com>
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
V2 -> V3:
 - No change
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

