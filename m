Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712397;
	b=XcGDVO001z2Xe/m9l+Zq2DH3zz9lpEzN3Y6s0rMF1KLxK4TAf59SYkx+i+zylhlvGwVR
	 JvIRMwfggeUEEMU31KaOe5+i1rxdNZ3hTdgwt1sVGztZ+v4QTz/xLYJY73OMDugGTp6zE
	 aBIa20GtT3vHh+7AjM9b8Md8d1Vl56cLTn9xxhCdgoqGcs8eKbOKhkWKDyIXnma9efXRH
	 DngnPSstFFlgfuf7OFBYBcMNbNMlObqp1xvrBGSxuYDAVdrFD/N2dXpIeaTppmkcxkPel
	 DACJanDtkg5LMGtsV94QGikaTb27tzCkUYCqBE/H1Kr3uPq/U35S0oTVvf0mUnSLbQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712397;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8lMZMIQfgxM1Y1sLfd9pmLbFTG91TDyafPfpoX4xnzA=;
	b=fc3ZJiY2Dro/z2Dd2/2AoZsx+LhHmeAGGb1d9mvnIQNYb7t+/Vcf4H73V39Dr+AUaYbF
	 qgAeNlJVA0XqStsLRqsCW6RYnww+B7j3aCDyzTtkfV7L2RYhKOIjcDncndjMww4oVSW2P
	 eG+VxJrL7gvlobR4KIGX6koNNlqmKNpNRh8BelOkbJif+lZq9dr38WRxpc0TzkPfUK8AB
	 gLC/DG8hSyZCEMar3lt8Zo9HbABGCQ29/e25NGmibetAbEl88eIK+CO/JiL15s1lzi2gN
	 m84SyOsyRB4J1/x2oPP0frMSkaelH7QHQYLnj/WH2BIOjs5dVJBELyccOIjBz2qVMCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.12
Received: from mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105C606A339
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 13:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3105C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VwdILgRNSWIPkWDn3eJqPy63I1Bwv0LiB91pK15cOp4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793712391; v=1; x=1794317191;
 b=RKUEs0xXGMHXqpldvK6xKP9OgY/JkqJguHg9nwDITmPZYbZSfAdhCDOfLqEXbyxGkw5DOJg+
 sUpJMrY5rz4yDlReExV7mql76Heuw9veg2/T3jq7KFYQjb+PtZryeX40GnyotIZJX2ts1N6upNJ
 9H01i8xwDXIYfrtWX8KekVE4=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 223b7a157b0f36b3;
	Tue, 03 Nov 2026 13:26:31 +0000
X-Mizu-Trace-ID: 223b7a157b0f36b3
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	josef@toxicopanda.com,
	axboe@kernel.dk,
	alexei.starovoitov@gmail.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	linux-kselftest@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	ameryhung@gmail.com
Subject: [RFC PATCH v12 0/4] blk-iocost: BPF struct_ops cost model
Date: Tue,  3 Nov 2026 21:26:09 +0800
Message-ID: <20261103132613.1952975-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

This series lets a BPF program take over the cost model of one device.
The BPF model provides calc_cost() for charged IOs plus two transfer
coefficients for the completion-time sizing, io.cost.model selects
between the attached model and the builtin one, and enabling and
disabling the controller stays with io.cost.qos.

The builtin model is a linear formula derived from a handful of device
parameters, and the right formula is device specific.  A BPF model can
be adapted to the device and updated without rebuilding the kernel.

The series is based on next-20261030.

Patches:

  1/4 blk-iocost: add BPF struct_ops cost model support
  2/4 blk-iocost: add iocost_ioc_tick tracepoint for per-period
      device summary
  3/4 selftests/bpf: add iocost cost model test
  4/4 docs: cgroup-v2: document the iocost BPF cost model attachment

Changes since v11:

- dropped the cgroup callbacks (the models build their state in
  calc_cost() anyway)
- dropped the queue freeze from detach
- folded everything into blk-iocost.c
- the selftest now uses cgroup_helpers: the tests create their own
  cgroups and remove them on exit; io.cost.qos/io.cost.model are
  root-only cgroupfs files and the test reverts them on its exit
  paths

Tested on next-20261030 (qemu x86_64): the selftests pass, and the
2x example model doubles the charged cost over the builtin on a
rotational device (2.01x measured), returning to 1.00x after
"model=linear".

Link: https://lore.kernel.org/r/20261028143534.135968-1-cui.tao@linux.dev # v11
