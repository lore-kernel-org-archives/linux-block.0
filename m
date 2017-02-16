Return-Path: <stewart@linux.vnet.ibm.com>
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3 4/4] MAINTAINERS: Remove powerpc's opal match
In-Reply-To: <1487187731-10293-5-git-send-email-jonathan.derrick@intel.com>
References: <1487187731-10293-1-git-send-email-jonathan.derrick@intel.com> <1487187731-10293-5-git-send-email-jonathan.derrick@intel.com>
Date: Thu, 16 Feb 2017 11:37:15 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h93v7yys.fsf@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Jon Derrick <jonathan.derrick@intel.com> writes:
> PPC's 'opal' match pattern also matches block/sed-opal.c, where it looks
> like the 'arch/powerpc' file pattern should be enough to match powerpc
> opal code by itself. Remove the opal regex pattern from powerpc.

This patch will end up missing some code, what about this instead:


Remove OPAL regex in powerpc to avoid false match

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>

---
 MAINTAINERS |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3960e7f..25ed25a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7393,18 +7393,24 @@ L:	linuxppc-dev@lists.ozlabs.org
 Q:	http://patchwork.ozlabs.org/project/linuxppc-dev/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 S:	Supported
+F:	Documentation/ABI/stable/sysfs-firmware-opal-*
+F:	Documentation/devicetree/bindings/powerpc/opal/
+F:	Documentation/devicetree/bindings/rtc/rtc-opal.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-opal.txt
 F:	Documentation/powerpc/
 F:	arch/powerpc/
 F:	drivers/char/tpm/tpm_ibmvtpm*
 F:	drivers/crypto/nx/
 F:	drivers/crypto/vmx/
+F:	drivers/i2c/busses/ic2-opal.c
 F:	drivers/net/ethernet/ibm/ibmveth.*
 F:	drivers/net/ethernet/ibm/ibmvnic.*
 F:	drivers/pci/hotplug/pnv_php.c
 F:	drivers/pci/hotplug/rpa*
+F:	drivers/rtc/rtc-opal.c
 F:	drivers/scsi/ibmvscsi/
+F:	drivers/tty/hvc/hvc_opal.c
 F:	tools/testing/selftests/powerpc
-N:	opal
 N:	/pmac
 N:	powermac
 N:	powernv


-- 
Stewart Smith
OPAL Architect, IBM.
