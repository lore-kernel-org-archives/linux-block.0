Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4430404BC3
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006228; cv=none; b=lXBfGhard3q5INK33vow2HhVk0CtatMpAHoe/nrvC2TgAuf+2CSiBYNVfin0gHyUjB09mNfKdO87BTMv8LeH36kkvE6ZwIOhI2pgVf57sor0Lz0WY8ZL20mbhO6YUB6/RkvmHeL4OvDT7fjnmR0iF58vu0gseKzej5/lGXY9QwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006228; c=relaxed/simple;
	bh=idiuQJNN0GZ7hWFIbxqI9skHLKDG4DRE2a8a21vQ7TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcTZdc3zpr0sgpR1mSQV8HlCyKk2jYM1okkN/u3NeDE2555HDPKCfboJx5b/ilCJ1iHTbUR44GDAgPVfyspFsEmnX2Cz0lec2x9fE9zkphAdnfEqjUnAf3Ag9yg8Lla8bsKdoQ+eGSCjmUAC5Ncp/NkPPsPR+oCPIfAP05ZeS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LWLEMDA/; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LWLEMDA/"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso4773999a91.1
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 04:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006226; x=1781611026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cij0f7XK3gPTc98cKs5ll/gp5Fj5YlFQkChYuGOVaaM=;
        b=N946lZfo2u7I9pX5wiMvm3gEs1WnrJHj2fqmCrguq7zg67DZG9FcLokUm7cyVFzsRF
         xNqbC2WJuSNHI6zHqIzgUg3kKKmuaRLuOOAtzvtIsxjU/CL8I4yLq2XRwQ3PWEeYXfHI
         mdXOJeKTGdLjczL/W93f7uHGS1FCMYz2KbriKWmyekgg9xocDcwwGOu5++SEPy7A0I8T
         Tt1fcPFffcxQhzs5gsxpJhjftWysIfSyrw00aDUzFd/p28hudy3j8IJ5ANt7gjM4fjON
         +nVIIkVhhKec3GwqK+/5gp2M1QpLn1ZvSKjDr6f3tp8UOPu94QHMjAVOSo3s6KNgRw3b
         OiUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TJrLvUJzSRKsQEtyKNArFIawvg+Lo4SgPaeKTTgj258ri/F8p8LrN3jOn0hmEKKDJEBs0hy4uAoRPMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2wHYmuQ9ZDjuKrH/KLRoPjQ9U7CRu5P6/AMXptdhna1aOaMF
	8NEBXHopoNF3iCFjHyueEf625q+PndH8q8uPxStW3OoTqqX+8s6ESP9zA9Vy7H3x3JoVc/nkKob
	FS4gy56XEPMqX5aiuDAK4G/ls4TvweF2leIxBQ3XQjG3BCjRfOgJzfndbtLpcllotYOFL3Q6Oa6
	MhP2jrDDFQzU/et6xYgrqAbSIdsge8+BEjfJd17fITKm8xwX9qVBcqv/WH5IaJTJcCxHLbhfbuf
	wCervMPvk8V7mvyQQ==
X-Gm-Gg: Acq92OFfKEcUYEDkvuVJ5eI9Jvwsjeik5nlfrqIjWzz55zjYdtfJywTS0tlImGOHlkf
	HX6iVzrgEaJTDdXQkD8MLyhisQh18Z34E1a/4Hjy2qVT2X3OGLs43X0MbDPZVNHgmzRgj8B59CL
	0V2XkgM9fv6V6ZXKoxfo3FcSfMYDUS+s0K4Wtdz+dRP1Pb/Elrtg1hHA5LojndmotRPE0WaJqwr
	vSj5X3SfZXD8ngZ0dICVcseMUTHwQoXFIQiosV4pFuZWmCcuJFDLSnVpqpnUUA9OxmsoyRJ1TFf
	hZ7qWis7JGUBAiFkUj+2wXD+r4UL4uufix5bCmBBHUs2OEy7eR9vQ1mQ+w/5UvqB/lL4fQhQHJM
	od4zz/eVrtf38cG2ypnjbQXFT9TQ1My4YMqqYMlHf4HG80EwoKwHfuchO6bTBRF7f40Nm9oGd9/
	Rbg4+0Oj+Chse73IacbXNIOu7hgyeKX8JTY2frlsQEF1eVPKARpaVWk1ATiezObNIXhpaGJA==
X-Received: by 2002:a17:903:1a06:b0:2bf:379b:53d2 with SMTP id d9443c01a7336-2c1e7e866dcmr234603145ad.15.1781006225817;
        Tue, 09 Jun 2026 04:57:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c16619e213sm19468015ad.40.2026.06.09.04.57.05
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:57:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36bc54005a7so7354173a91.0
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781006224; x=1781611024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cij0f7XK3gPTc98cKs5ll/gp5Fj5YlFQkChYuGOVaaM=;
        b=LWLEMDA/wpB8g4YGBvdZyqk8TWktUJJCc5zunrGSLy7YscTMU28NwW4zzXhL7DLtIs
         2GDWi11jn/XBQI5zThidPET9WMKuWQHQTXbvIzLOMHEQDayxapLIMo2sem/EU2QjJrmP
         EE8uHLdYlQq4KFuAn8ISaByLi4SyR3bTaOhOE=
X-Forwarded-Encrypted: i=1; AFNElJ9NZ7QO4RfHtgrMqptyAsxEq6GtgTZnZeDnLH9hRCaGnIgSbQ6a1DsdXBoMbJkbvHSnZvsv5EeIMInggA==@vger.kernel.org
X-Received: by 2002:a17:90b:5787:b0:36b:8824:d7cc with SMTP id 98e67ed59e1d1-370f057a115mr22377750a91.20.1781005739354;
        Tue, 09 Jun 2026 04:48:59 -0700 (PDT)
X-Received: by 2002:a17:90b:5787:b0:36b:8824:d7cc with SMTP id 98e67ed59e1d1-370f057a115mr22377714a91.20.1781005738858;
        Tue, 09 Jun 2026 04:48:58 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf903fasm18898075a91.2.2026.06.09.04.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:48:57 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Khalid Aziz <khalid@gonehiking.org>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.com>,
	"Juergen E . Fischer" <fischer@norbit.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	Oliver Neukum <oliver@neukum.org>,
	Ali Akcaagac <aliakc@web.de>,
	Jamie Lenehan <lenehan@twibble.org>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	target-devel@vger.kernel.org,
	Bradley Grove <linuxdrivers@attotech.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Yihang Li <liyihang9@h-partners.com>,
	Don Brace <don.brace@microchip.com>,
	storagedev@microchip.com,
	HighPoint Linux Team <linux@highpoint-tech.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Brian King <brking@us.ibm.com>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	open-iscsi@googlegroups.com,
	Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
	megaraidlinux.pdl@broadcom.com,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	Daniel Palmer <daniel@thingy.jp>,
	GOTO Masanori <gotom@debian.or.jp>,
	YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Geoff Levand <geoff@infradead.org>,
	Michael Reed <mdr@sgi.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Narsimhulu Musini <nmusini@cisco.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Vishal Bhakta <vishal.bhakta@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	James Rizzo <james.rizzo@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH v3 1/4] scsi: scan: allocate sdev and starget on the NUMA node of the host adapter
Date: Tue,  9 Jun 2026 17:48:00 +0530
Message-ID: <20260609121806.2121755-2-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: James Rizzo <james.rizzo@broadcom.com>

When a host adapter is attached to a specific NUMA node, allocating
scsi_device and scsi_target via kzalloc() may place them on a remote
node.  All hot-path I/O accesses to these structures then cross the NUMA
interconnect, adding latency and consuming inter-node bandwidth.

Use kzalloc_node() with dev_to_node(shost->dma_dev) so allocations land
on the same node as the HBA, reducing cross-node traffic and improving
I/O performance on NUMA systems.

Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/scsi_scan.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index e27da038603a..121a14d5fdb8 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -34,6 +34,7 @@
 #include <linux/kthread.h>
 #include <linux/spinlock.h>
 #include <linux/async.h>
+#include <linux/topology.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 
@@ -287,8 +288,8 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	struct queue_limits lim;
 
-	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
-		       GFP_KERNEL);
+	sdev = kzalloc_node(sizeof(*sdev) + shost->transportt->device_size,
+		       GFP_KERNEL, dev_to_node(shost->dma_dev));
 	if (!sdev)
 		goto out;
 
@@ -502,7 +503,7 @@ static struct scsi_target *scsi_alloc_target(struct device *parent,
 	struct scsi_target *found_target;
 	int error, ref_got;
 
-	starget = kzalloc(size, GFP_KERNEL);
+	starget = kzalloc_node(size, GFP_KERNEL, dev_to_node(shost->dma_dev));
 	if (!starget) {
 		printk(KERN_ERR "%s: allocation failure\n", __func__);
 		return NULL;
-- 
2.43.7

