Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96571C8FC1;
	Thu, 10 Oct 2024 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564016; cv=none; b=IJm1gcxxSb9cf7/4FOmhHCEweQJAMsFPhPkm4y+uo2xHzcDv1u3InttGIVTbhY0NfMxyx6j6aDW4JyKSoG8m/6zsK/LvBAE18g8M0XY01t1xtJwGwLeXP+1sZCiZAVm7X8zpV8T4Yix5x6CMawe+cPxmMQg4BQJjabWhL8wTTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564016; c=relaxed/simple;
	bh=PqwtCXIgMDrVsRzZYnWN9LXv0fEJIqOZ5OIMaw68NSY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAKfHU0tf3FjBtOjY+8OoBgMqNoAhw7dwQ94WgSNBnWKAgL54GkO6/J9Vcmp4RiNRLVoMUMVnWdrn26IsSE2jwduhYFkfvixxba7uAvX3DV01Vl3Xxh+5Y98Ay1t23GiCTrDWTLrpfOkaBLxMuZ21DYiWNVJRx6nQN40feYkoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=WhyxmuK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E7T/+dHV; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="WhyxmuK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E7T/+dHV"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 51730138051E;
	Thu, 10 Oct 2024 08:40:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 10 Oct 2024 08:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1728564013; x=
	1728650413; bh=NpQ83Cm6m9Kae+D/sw7o70rVWHM4GZz758JqV0xhvig=; b=W
	hyxmuK1UDlXLvuIxcbCwx14OLUzPvvxk/6s71X1Oha3Lml0/mvMgeiP1R2q3D4Wr
	LFb9QQ5xjedM5SK1JjRRwFJWNZTggOCYG0TkbT2zCgAGAj5cF5uhOCnJt6H4ZaVc
	S0IcWrDOuqNpnVNMeYSdwLaQTxx4Inkw+q/rTgQugzHLoexPls236y3XNT6wuYGh
	eUhc7BHLR40WqeLH5jouOP4N4Tl2cTHQ3IC+EoLrSlU0Ju6WYqWDB8QHQx+7PDU+
	6Xzax0eRy0Pds4KiKH5Fc/cY86az13H0oy/rqsfZCusPiOgvLoq6PytDO1RILn0g
	B6V834m8/kmCTXqhcnJ9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1728564013; x=1728650413; bh=NpQ83Cm6m9Kae
	+D/sw7o70rVWHM4GZz758JqV0xhvig=; b=E7T/+dHVxI4wqmRSSvzsCYDvv/pem
	kt/8j7/urklRqSiblgY+Eq9/YrCIOxj0tUVLHDyG1GlFUXsmEX66gJ0crV0q3OSp
	Qo9E0YCPbQpbehWiZpT97wZmIYAi+y62LdT3YqA1mLa0cQ5jE5XuQdjJU0hH2rE9
	6Y0OSdKfY6bfZEE334i/aNbKdsVL8CRM2Pgf7D7A+xalHdpQShsG7409XVx9pXQM
	JujD920cdJTrsDFPpat4UNC+lO2WMldIsKqGjBPpH/Mkmv9vCscGE2AfzgEsE04X
	0MdvLIrIRJ2a6jU/qWBKVXGD2EGGdbWVEBAboKA0eD2gxhta0De6jqeKA==
X-ME-Sender: <xms:LcsHZ6gsJC0Uec_IJg_gHgHAefdRWfkHLhJVLmwCPV3LEOkDPZcvxA>
    <xme:LcsHZ7APXNuArHpX0JwrzPyDDskNA11qzQr5DblNtMMJF-zi3ZmWwUJpqqsTy_dKh
    8hhtXJS2paGxjyLf8c>
X-ME-Received: <xmr:LcsHZyEm6ykYLlMGAzSUP3613KXGelnmQTR2VnxIPIrFiwendPs2zV1YXw5C_DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkofgjfhgggfestdekredtredtjeenucfhrhhomhepofgrthhirghsuceujhpprhhlihhn
    ghcuoehmsegsjhhorhhlihhnghdrmhgvqeenucggtffrrghtthgvrhhnpeegtefhheelge
    duleetteeffefhledtudduudfggfevudejudfgiefftdfghedtfeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsegsjhhorhhlihhnghdrmh
    gvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    khgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvg
    dprhgtphhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    rghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvse
    hlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghl
    ohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifrghnghihuhhg
    uhhisegvudeiqdhtvggthhdrtghomhdprhgtphhtthhopehmrghrthhinhdrphgvthgvrh
    hsvghnsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:LcsHZzROsCaw9bEGf31HOOXnQPdLFvXw5VvWBkddpgFsiFFqmMD9pg>
    <xmx:LcsHZ3zIh0viHEupLXuvsPaTOM-2-Ms7ICeRIP6QMQ4e4jVznFb4CA>
    <xmx:LcsHZx5hJgJcQ_UpCTPHd5D-vd4xNBtJ3NKfsKPYDW2EHNt2PB7RdA>
    <xmx:LcsHZ0zf3WM3TV-lJysSUZrH9CjgUU46Lnqa7YaxlX2Pn-bdWcbSEg>
    <xmx:LcsHZ8pxoSVA3ACS9j4uJCyz_3aZta_cVSIoQSRuvR8Vvd8Y8qX8rFJj>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 08:40:11 -0400 (EDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: kbusch@kernel.org,
	hch@lst.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyugui@e16-tech.com,
	martin.petersen@oracle.com,
	hare@suse.de
Subject: [PATCH 3/3 v2] nvmet: add rotational support
Date: Thu, 10 Oct 2024 14:39:51 +0200
Message-ID: <20241010123951.1226105-4-m@bjorling.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241010123951.1226105-1-m@bjorling.me>
References: <20241010123951.1226105-1-m@bjorling.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

Rotational block devices can be detected in NVMe through the rotational
attribute in the independent namespace identify data structure.

Extend nvmet with support for the independent namespace identify data
structure and expose the rotational support of the backend device.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f7e1156ac7ec..f08f1226c897 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -675,6 +675,35 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
 		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
 }
 
+static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
+{
+	struct nvme_id_ns_cs_indep *id;
+	u16 status;
+
+	status = nvmet_req_find_ns(req);
+	if (status)
+		goto out;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	id->nstat = NVME_NSTAT_NRDY;
+	id->anagrpid = req->ns->anagrpid;
+	id->nmic = NVME_NS_NMIC_SHARED;
+	if (req->ns->readonly)
+		id->nsattr |= NVME_NS_ATTR_RO;
+	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
+		id->nsfeat |= NVME_NS_ROTATIONAL;
+
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+	kfree(id);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -719,6 +748,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 			break;
 		}
 		break;
+	case NVME_ID_CNS_NS_CS_INDEP:
+		nvmet_execute_id_cs_indep(req);
+		return;
 	}
 
 	pr_debug("unhandled identify cns %d on qid %d\n",
-- 
2.46.0

