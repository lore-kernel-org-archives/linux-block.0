Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0B4502F
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708870; cv=none; b=LRr+vWU+zfAvkUIdmH2ICDxpUEGQ16A+3IymihykAJaGUmKG3Hx91D/oHEHYQ201dad7iVnUiVpF6H0jaW/AvCXL+sqxtC/AbDiqZb+qY+yElr0cLeyNSypqqBEy79Cx+T+2LSzp4fy0Osdq0Wov0WVEjYwa+ErWSJOoQdRsl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708870; c=relaxed/simple;
	bh=vfsdEl5FbRFdZFUjb+YcVZe3zjDEJd+gUPrbLdMwf+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Hc9Nv/btLc/zBoaxRa49UmDKN1avonqpKUoApJLXtkYMe6QcPJvjoZWb6BwHM18VbW+NTG+5B89A6IkmQnD/0wrgLSDtm8q5h6OsOBvRYVbxaXVtayOAAS3OnQNqo3kMB5kp/DgwNpM9QV59TuCBdpZshLfVSp3a1j5RDG0eyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWzdXWtI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWzdXWtI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290c2b6a6c2so71370015ad.1
        for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 20:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761708868; x=1762313668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8pbkW4S9gYiGub9CIXDGqnMpe4qrnwi2UjI5+bnzrpk=;
        b=mWzdXWtIbpsxZvPRhlINb5xVy+2gEYds7Pje9uHJxmKuNdy0320VoqS/yMWD4hDKTx
         6xZP+PpdeflBmscndGdI4uuRTuwIzkMTaGXI6gde/JFf2mFnefJdpa+lBzMS0pDk1zAm
         gCceJz7xG+oeWhxyovqU3MzSp21hzzp4u6uM4x53j1lCh3gsJUXfGyjyzw5gYGY3NJzM
         8c+WMq9TR4DYJKIZhxdoo6RYaG0e4q/sZaaPZB/aIHG617F/wGgIXVTlVN/0nHsJoXFF
         WgSfqk3iWPkL4gFsHL1pW1atsPqGwIxIBdZGNsLtQ6vZpBy+dS6nfIHbJ4aJPWgidgf/
         fIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761708868; x=1762313668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pbkW4S9gYiGub9CIXDGqnMpe4qrnwi2UjI5+bnzrpk=;
        b=BSDS4IwUV1t/pQqXkVBdz43CvU0ogetbIFEd977x9xBbmoQNS3LCNt+dQy3hWLh9yI
         D/5UX2KwGcUZq+icoFe7jBsOGsFycawFdefoy9d66Gwzrb1TDBM6BODD2YkSNhbmPfIx
         SnOBS4gKE6V4dzVxpeLuhpt3hB4FX4K2m/lYI8ir6BaB+a4I8X5yUfs3aC8hqqSpyeYN
         ImGOOeYukirckCoU/Y1KXqXzJBvY8A8YpcUWuSXZ2kumS8b6mVAm/CVP2BxX8pu1Iu2b
         EqQraUAiAO14A/Uece9j88jUVRFnJfbv0e62vHWRCibVOp85hgYku9UxSRhBKWpQw5df
         lvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCGD1XU6POVn9J1U+WguiE34gxvBrbBkEids9HvaZrxxRD+5+03ejfA9w6v9zAj9T+6koyPfbx1Qe0dg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/lUbrAQ//z5cVCntrzZFW/Y0720jApod3XtYtLo5fjfEFL11J
	VRa55Zg0QaK66JtYD7HHlivoxcNj3s+gnTmcBo3M0Iatbgjp8i5AKle6
X-Gm-Gg: ASbGncv2Z/NdR0Fp+SIkXzBL92JtW5WBILdP9ZLHSK+oW0nVbExQlD7z/rpJDEOSZzw
	SBcrpW/SB58AksCJOrtk1kQdVV2AGxOM4lUu8mlBq99mIjTEOSmleCmHakiHivNRPQXIw7Fm1wh
	DjlzoXqVOas9sjugtickY9aOqgYwtKMGFhIjaW6nKQ0X3NkAXw5/7XhopbP8aPLfzYrSVqyDV1B
	HTyRgSa0b/GqJTf+G382ZIqn4aRiM0/HVkO3B/7gUhMT6km1aImBHLtG7aYAzMGEgRDTHIX2cVg
	FIfxmsPnPFgDYOLgygA82Aiu8cxd4PAk/1QIT0tXNzfeOVl5O28NMWsb1Z0b32Mz3koOC/ZdGTe
	ACeog6cbnuLI8qPRc9i/lJwAGkIBYpyvb4iK3vl6Vt+tfUJuo0or/b99R+PDk40JEcDAc74fWZD
	E=
X-Google-Smtp-Source: AGHT+IGNTV+QIlEwvA2GOvl1DG00Ac9m6UEqh7t43dPuBjNCGgO/ah7gaPk21/docBdsIKcmKoPRFQ==
X-Received: by 2002:a17:903:1c2:b0:270:b6d5:f001 with SMTP id d9443c01a7336-294dee35246mr15229565ad.23.1761708867989;
        Tue, 28 Oct 2025 20:34:27 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d30030sm132085665ad.65.2025.10.28.20.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 20:34:27 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: johannes.thumshirn@wdc.com
Cc: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	martin.petersen@oracle.com,
	dlemoal@kernel.org,
	john.g.garry@oracle.com,
	ckulkarnilinux@gmail.com,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/1] blktrace: add support for REQ_OP_WRITE_ZEROES tracing
Date: Tue, 28 Oct 2025 20:34:23 -0700
Message-Id: <20251029033423.7656-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, REQ_OP_WRITE_ZEROES operations are not handled in the 
blktrace infrastructure, resulting in incorrect or missing operation
labels in ftrace blktrace output. This manifests as write-zeroes
operations appearing with incorrect labels like "N" instead of a
proper "WZ" designation.

This patch adds complete support for REQ_OP_WRITE_ZEROES across the
blktrace infrastructure:

Add BLK_TC_WRITE_ZEROES trace category in blktrace_api.h and update
BLK_TC_END_V2 marker accordingly
Map REQ_OP_WRITE_ZEROES to BLK_TC_WRITE_ZEROES in __blk_add_trace()
to ensure proper trace event categorization
Update fill_rwbs() to generate "WZ" label for write-zeroes operations
in ftrace output, making them easily identifiable
Add "write-zeroes" string mapping in act_to_str array for debugfs
filter interface
Update blk_fill_rwbs() to handle REQ_OP_WRITE_ZEROES for block layer
event tracing

With this fix, write-zeroes operations are now correctly traced and
displayed.

===========================================================
BEFORE THIS PATCH
===========================================================
blkdiscard -z -o 0 -l 40960 /dev/nvme0n1
   blkdiscard-3809 [030] .....  1212.253701: block_bio_queue: 259,0 NS 0 + 80 [blkdiscard]
   blkdiscard-3809 [030] .....  1212.253703: block_getrq: 259,0 NS 0 + 80 [blkdiscard]
   blkdiscard-3809 [030] .....  1212.253704: block_io_start: 259,0 NS 40960 () 0 + 80 be,0,4 [blkdiscard]
   blkdiscard-3809 [030] .....  1212.253704: block_plug: [blkdiscard]
   blkdiscard-3809 [030] .....  1212.253706: block_unplug: [blkdiscard] 1
   blkdiscard-3809 [030] .....  1212.253706: block_rq_insert: 259,0 NS 40960 () 0 + 80 be,0,4 [blkdiscard]
kworker/30:1H-566  [030] .....  1212.253726: block_rq_issue: 259,0 NS 40960 () 0 + 80 be,0,4 [kworker/30:1H]
       <idle>-0    [030] d.h1.  1212.253957: block_rq_complete: 259,0 NS () 0 + 80 be,0,4 [0]
       <idle>-0    [030] dNh1.  1212.253960: block_io_done: 259,0 NS 0 () 0 + 0 none,0,0 [swapper/30]

Trace Event Breakdown:
 Event             | Device | Op  | Sector | Sectors | Byte Size | Calculation          

 block_bio_queue   | 259,0  | NS  | 0      | 80      | -         | 80 × 512 = 40,960    
 block_getrq       | 259,0  | NS  | 0      | 80      | -         | 80 × 512 = 40,960    
 block_io_start    | 259,0  | NS  | 0      | 80      | 40960     | Direct from trace  
 block_rq_insert   | 259,0  | NS  | 0      | 80      | 40960     | Direct from trace  
 block_rq_issue    | 259,0  | NS  | 0      | 80      | 40960     | Direct from trace  
 block_rq_complete | 259,0  | NS  | 0      | 80      | -         | 80 × 512 = 40,960    
 block_io_done     | 259,0  | NS  | 0      | 0       | 0         | Completion (no data) 

  Total Bytes Transferred: Sectors: 80 Bytes: 80 × 512 = 40,960 bytes

===========================================================
AFTER THIS PATCH
===========================================================
blkdiscard -z -o 0 -l 40960 /dev/nvme0n1

   blkdiscard-2477 [020] .....   960.989131: block_bio_queue: 259,0 WZS 0 + 80 [blkdiscard]
   blkdiscard-2477 [020] .....   960.989134: block_getrq: 259,0 WZS 0 + 80 [blkdiscard]
   blkdiscard-2477 [020] .....   960.989135: block_io_start: 259,0 WZS 40960 () 0 + 80 be,0,4 [blkdiscard]
   blkdiscard-2477 [020] .....   960.989138: block_plug: [blkdiscard]
   blkdiscard-2477 [020] .....   960.989140: block_unplug: [blkdiscard] 1
   blkdiscard-2477 [020] .....   960.989141: block_rq_insert: 259,0 WZS 40960 () 0 + 80 be,0,4 [blkdiscard]
kworker/20:1H-736  [020] .....   960.989166: block_rq_issue: 259,0 WZS 40960 () 0 + 80 be,0,4 [kworker/20:1H]
       <idle>-0    [020] d.h1.   960.989476: block_rq_complete: 259,0 WZS () 0 + 80 be,0,4 [0]
       <idle>-0    [020] dNh1.   960.989482: block_io_done: 259,0 WZS 0 () 0 + 0 none,0,0 [swapper/20]

Trace Event Breakdown:
 Event             | Device | Op  | Sector | Sectors | Byte Size | Calculation          

 block_bio_queue   | 259,0  | WZS | 0      | 80      | -         | 80 × 512 = 40,960    
 block_getrq       | 259,0  | WZS | 0      | 80      | -         | 80 × 512 = 40,960    
 block_io_start    | 259,0  | WZS | 0      | 80      | 40960     | Direct from trace  
 block_rq_insert   | 259,0  | WZS | 0      | 80      | 40960     | Direct from trace  
 block_rq_issue    | 259,0  | WZS | 0      | 80      | 40960     | Direct from trace  
 block_rq_complete | 259,0  | WZS | 0      | 80      | -         | 80 × 512 = 40,960    
 block_io_done     | 259,0  | WZS | 0      | 0       | 0         | Completion (no data) 

  Total Bytes Transferred: Sectors: 80 Bytes: 80 × 512 = 40,960 bytes

Tested with ftrace blktrace on NVMe devices using blkdiscard with
the -z (write-zeroes) flag.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 include/uapi/linux/blktrace_api.h |  4 +++-
 kernel/trace/blktrace.c           | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 30f3d2589365..7c092d9f3aa4 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -35,7 +35,9 @@ enum blktrace_cat {
 	BLK_TC_ZONE_OPEN	= 1ull << 20,	/* zone open */
 	BLK_TC_ZONE_CLOSE	= 1ull << 21,	/* zone close */
 
-	BLK_TC_END_V2		= 1ull << 21,
+	BLK_TC_WRITE_ZEROES	= 1ull << 22,	/* write-zeroes */
+
+	BLK_TC_END_V2		= 1ull << 22,
 };
 
 #define BLK_TC_SHIFT		(16)
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 4a37d9aa0481..1dd3b6a71649 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -360,6 +360,9 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	case REQ_OP_ZONE_CLOSE:
 		what |= BLK_TC_ACT(BLK_TC_ZONE_CLOSE);
 		break;
+	case REQ_OP_WRITE_ZEROES:
+		what |= BLK_TC_ACT(BLK_TC_WRITE_ZEROES);
+		break;
 	default:
 		break;
 	}
@@ -1414,7 +1417,10 @@ static void fill_rwbs(char *rwbs, const struct blk_io_trace2 *t)
 
 	if (tc & BLK_TC_DISCARD)
 		rwbs[i++] = 'D';
-	else if (tc & BLK_TC_WRITE)
+	else if (tc & BLK_TC_WRITE_ZEROES) {
+		rwbs[i++] = 'W';
+		rwbs[i++] = 'Z';
+	} else if (tc & BLK_TC_WRITE)
 		rwbs[i++] = 'W';
 	else if (t->bytes)
 		rwbs[i++] = 'R';
@@ -1957,6 +1963,7 @@ static const struct {
 	{ BLK_TC_DISCARD,	"discard"	},
 	{ BLK_TC_DRV_DATA,	"drv_data"	},
 	{ BLK_TC_FUA,		"fua"		},
+	{ BLK_TC_WRITE_ZEROES,	"write-zeroes"	},
 };
 
 static int blk_trace_str2mask(const char *str)
@@ -2170,6 +2177,10 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
 		rwbs[i++] = 'Z';
 		rwbs[i++] = 'C';
 		break;
+	case REQ_OP_WRITE_ZEROES:
+		rwbs[i++] = 'W';
+		rwbs[i++] = 'Z';
+		break;
 	default:
 		rwbs[i++] = 'N';
 	}
-- 
2.40.0

