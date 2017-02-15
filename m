Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: 
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Scott Bauer <scott.bauer@intel.com>,
	Rafael Antognolli <rafael.antognolli@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv2 4/4] MAINTAINERS: Remove powerpc's opal match
Date: Wed, 15 Feb 2017 14:05:00 -0700
Message-Id: <1487192712-31120-5-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1487192712-31120-1-git-send-email-jonathan.derrick@intel.com>
References: <1487192712-31120-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-block@vger.kernel.org>

PPC's 'opal' match pattern also matches block/sed-opal.c, where it looks
like the 'arch/powerpc' file pattern should be enough to match powerpc
opal code by itself. Remove the opal regex pattern from powerpc.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b983b25..430dd02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7404,7 +7404,6 @@ F:	drivers/pci/hotplug/pnv_php.c
 F:	drivers/pci/hotplug/rpa*
 F:	drivers/scsi/ibmvscsi/
 F:	tools/testing/selftests/powerpc
-N:	opal
 N:	/pmac
 N:	powermac
 N:	powernv
-- 
1.8.3.1
