Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de,
	axboe@fb.com
Subject: [PATCH 07/13] pci: Provide sensible irq vector alloc/free routines
Date: Mon,  4 Jul 2016 17:39:28 +0900
Message-Id: <1467621574-8277-8-git-send-email-hch@lst.de>
In-Reply-To: <1467621574-8277-1-git-send-email-hch@lst.de>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org, agordeev@redhat.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Add a function to allocate a range of interrupt vectors, which will
transparently use MSI-X and MSI if available or fallback to legacy
vectors.  The interrupts are available in a core managed array in the
pci_dev structure, and can also be released using a similar function.
A new helper, __pci_enable_msix_range, is introduced to allow allocating
the array of msix descriptors in the core PCIe code at the exact number
of vectors supported by the PCI host complex, and to also help with the
automatic IRQ affinity assignment that will be added in the next commit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/PCI/MSI-HOWTO.txt | 437 ++++------------------------------------
 drivers/pci/msi.c               |  93 +++++++++
 include/linux/pci.h             |  39 ++++
 3 files changed, 170 insertions(+), 399 deletions(-)

diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
index 1179850..35d1326 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/MSI-HOWTO.txt
@@ -82,418 +82,57 @@ Most of the hard work is done for the driver in the PCI layer.  It simply
 has to request that the PCI layer set up the MSI capability for this
 device.
 
-4.2.1 pci_enable_msi
+To automatically use MSI or MSI-X interrupt vectors use the following
+function:
 
-int pci_enable_msi(struct pci_dev *dev)
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs, unsigned int flags)
 
-A successful call allocates ONE interrupt to the device, regardless
-of how many MSIs the device supports.  The device is switched from
-pin-based interrupt mode to MSI mode.  The dev->irq number is changed
-to a new number which represents the message signaled interrupt;
-consequently, this function should be called before the driver calls
-request_irq(), because an MSI is delivered via a vector that is
-different from the vector of a pin-based interrupt.
+Which allocates up to max_vecs interrupt vectors for a PCI devices.  Returns
+the number of vectors allocated or a negative error.  If the device has a
+requirements for a minimum number of vectors the driver can pass a min_vecs
+argument set to this limit, and the PCI core will return -ENOSPC if it can't
+meet the minimum number of vectors.
+The flags argument should normally be set to 0, but can be used to
+pass the PCI_IRQ_NOMSI and PCI_IRQ_NOMSIX flag in case a device claims
+to support MSI or MSI-X, but the support is broken.
 
-4.2.2 pci_enable_msi_range
+To get the Linux IRQ numbers passed to request_irq and free_irq
+and the vectors use the following function:
 
-int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
+int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 
-This function allows a device driver to request any number of MSI
-interrupts within specified range from 'minvec' to 'maxvec'.
+Any allocated resources should be freed before removing the device using the
+following function:
 
-If this function returns a positive number it indicates the number of
-MSI interrupts that have been successfully allocated.  In this case
-the device is switched from pin-based interrupt mode to MSI mode and
-updates dev->irq to be the lowest of the new interrupts assigned to it.
-The other interrupts assigned to the device are in the range dev->irq
-to dev->irq + returned value - 1.  Device driver can use the returned
-number of successfully allocated MSI interrupts to further allocate
-and initialize device resources.
+void pci_free_irq_vectors(struct pci_dev *dev)
 
-If this function returns a negative number, it indicates an error and
-the driver should not attempt to request any more MSI interrupts for
-this device.
+If a device supports both MSI-X and MSI capabilities, this API will use
+the MSI-X facilities in preference to the MSI facilities.   MSI-X
+supports any number of interrupts between 1 and 2048. In contrast, MSI
+is restricted to a maximum of 32 interrupts (and must be a power of two).
+In addition, the MSI interrupt vectors must be allocated consecutively,
+so the system might not be able to allocate as many vectors for MSI as
+it could for MSI-X.  On some platforms, MSI interrupts must all be
+targeted at the same set of CPUs whereas MSI-X interrupts can all be
+targeted at different CPUs.
 
-This function should be called before the driver calls request_irq(),
-because MSI interrupts are delivered via vectors that are different
-from the vector of a pin-based interrupt.
+If a device supports neither MSI-X or MSI it will fall back to a single
+legacy IRQ vectors.
 
-It is ideal if drivers can cope with a variable number of MSI interrupts;
-there are many reasons why the platform may not be able to provide the
-exact number that a driver asks for.
+4.3 Legacy MSI / MSI-X APIs
 
-There could be devices that can not operate with just any number of MSI
-interrupts within a range.  See chapter 4.3.1.3 to get the idea how to
-handle such devices for MSI-X - the same logic applies to MSI.
+The old MSI or MSI-X specific APIs:
 
-4.2.1.1 Maximum possible number of MSI interrupts
+ pci_enable_msi, pci_enable_msi_range, pci_enable_msi_exact, pci_disable_msi,
+ pci_msi_vec_count, pci_enable_msix_range, pci_enable_msix_exact,
+ pci_disable_msix, pci_msix_vec_count
 
-The typical usage of MSI interrupts is to allocate as many vectors as
-possible, likely up to the limit returned by pci_msi_vec_count() function:
+should not be used in new code.
 
-static int foo_driver_enable_msi(struct pci_dev *pdev, int nvec)
-{
-	return pci_enable_msi_range(pdev, 1, nvec);
-}
+4.4 Considerations when using MSIs
 
-Note the value of 'minvec' parameter is 1.  As 'minvec' is inclusive,
-the value of 0 would be meaningless and could result in error.
-
-Some devices have a minimal limit on number of MSI interrupts.
-In this case the function could look like this:
-
-static int foo_driver_enable_msi(struct pci_dev *pdev, int nvec)
-{
-	return pci_enable_msi_range(pdev, FOO_DRIVER_MINIMUM_NVEC, nvec);
-}
-
-4.2.1.2 Exact number of MSI interrupts
-
-If a driver is unable or unwilling to deal with a variable number of MSI
-interrupts it could request a particular number of interrupts by passing
-that number to pci_enable_msi_range() function as both 'minvec' and 'maxvec'
-parameters:
-
-static int foo_driver_enable_msi(struct pci_dev *pdev, int nvec)
-{
-	return pci_enable_msi_range(pdev, nvec, nvec);
-}
-
-Note, unlike pci_enable_msi_exact() function, which could be also used to
-enable a particular number of MSI-X interrupts, pci_enable_msi_range()
-returns either a negative errno or 'nvec' (not negative errno or 0 - as
-pci_enable_msi_exact() does).
-
-4.2.1.3 Single MSI mode
-
-The most notorious example of the request type described above is
-enabling the single MSI mode for a device.  It could be done by passing
-two 1s as 'minvec' and 'maxvec':
-
-static int foo_driver_enable_single_msi(struct pci_dev *pdev)
-{
-	return pci_enable_msi_range(pdev, 1, 1);
-}
-
-Note, unlike pci_enable_msi() function, which could be also used to
-enable the single MSI mode, pci_enable_msi_range() returns either a
-negative errno or 1 (not negative errno or 0 - as pci_enable_msi()
-does).
-
-4.2.3 pci_enable_msi_exact
-
-int pci_enable_msi_exact(struct pci_dev *dev, int nvec)
-
-This variation on pci_enable_msi_range() call allows a device driver to
-request exactly 'nvec' MSIs.
-
-If this function returns a negative number, it indicates an error and
-the driver should not attempt to request any more MSI interrupts for
-this device.
-
-By contrast with pci_enable_msi_range() function, pci_enable_msi_exact()
-returns zero in case of success, which indicates MSI interrupts have been
-successfully allocated.
-
-4.2.4 pci_disable_msi
-
-void pci_disable_msi(struct pci_dev *dev)
-
-This function should be used to undo the effect of pci_enable_msi_range().
-Calling it restores dev->irq to the pin-based interrupt number and frees
-the previously allocated MSIs.  The interrupts may subsequently be assigned
-to another device, so drivers should not cache the value of dev->irq.
-
-Before calling this function, a device driver must always call free_irq()
-on any interrupt for which it previously called request_irq().
-Failure to do so results in a BUG_ON(), leaving the device with
-MSI enabled and thus leaking its vector.
-
-4.2.4 pci_msi_vec_count
-
-int pci_msi_vec_count(struct pci_dev *dev)
-
-This function could be used to retrieve the number of MSI vectors the
-device requested (via the Multiple Message Capable register). The MSI
-specification only allows the returned value to be a power of two,
-up to a maximum of 2^5 (32).
-
-If this function returns a negative number, it indicates the device is
-not capable of sending MSIs.
-
-If this function returns a positive number, it indicates the maximum
-number of MSI interrupt vectors that could be allocated.
-
-4.3 Using MSI-X
-
-The MSI-X capability is much more flexible than the MSI capability.
-It supports up to 2048 interrupts, each of which can be controlled
-independently.  To support this flexibility, drivers must use an array of
-`struct msix_entry':
-
-struct msix_entry {
-	u16 	vector; /* kernel uses to write alloc vector */
-	u16	entry; /* driver uses to specify entry */
-};
-
-This allows for the device to use these interrupts in a sparse fashion;
-for example, it could use interrupts 3 and 1027 and yet allocate only a
-two-element array.  The driver is expected to fill in the 'entry' value
-in each element of the array to indicate for which entries the kernel
-should assign interrupts; it is invalid to fill in two entries with the
-same number.
-
-4.3.1 pci_enable_msix_range
-
-int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
-			  int minvec, int maxvec)
-
-Calling this function asks the PCI subsystem to allocate any number of
-MSI-X interrupts within specified range from 'minvec' to 'maxvec'.
-The 'entries' argument is a pointer to an array of msix_entry structs
-which should be at least 'maxvec' entries in size.
-
-On success, the device is switched into MSI-X mode and the function
-returns the number of MSI-X interrupts that have been successfully
-allocated.  In this case the 'vector' member in entries numbered from
-0 to the returned value - 1 is populated with the interrupt number;
-the driver should then call request_irq() for each 'vector' that it
-decides to use.  The device driver is responsible for keeping track of the
-interrupts assigned to the MSI-X vectors so it can free them again later.
-Device driver can use the returned number of successfully allocated MSI-X
-interrupts to further allocate and initialize device resources.
-
-If this function returns a negative number, it indicates an error and
-the driver should not attempt to allocate any more MSI-X interrupts for
-this device.
-
-This function, in contrast with pci_enable_msi_range(), does not adjust
-dev->irq.  The device will not generate interrupts for this interrupt
-number once MSI-X is enabled.
-
-Device drivers should normally call this function once per device
-during the initialization phase.
-
-It is ideal if drivers can cope with a variable number of MSI-X interrupts;
-there are many reasons why the platform may not be able to provide the
-exact number that a driver asks for.
-
-There could be devices that can not operate with just any number of MSI-X
-interrupts within a range.  E.g., an network adapter might need let's say
-four vectors per each queue it provides.  Therefore, a number of MSI-X
-interrupts allocated should be a multiple of four.  In this case interface
-pci_enable_msix_range() can not be used alone to request MSI-X interrupts
-(since it can allocate any number within the range, without any notion of
-the multiple of four) and the device driver should master a custom logic
-to request the required number of MSI-X interrupts.
-
-4.3.1.1 Maximum possible number of MSI-X interrupts
-
-The typical usage of MSI-X interrupts is to allocate as many vectors as
-possible, likely up to the limit returned by pci_msix_vec_count() function:
-
-static int foo_driver_enable_msix(struct foo_adapter *adapter, int nvec)
-{
-	return pci_enable_msix_range(adapter->pdev, adapter->msix_entries,
-				     1, nvec);
-}
-
-Note the value of 'minvec' parameter is 1.  As 'minvec' is inclusive,
-the value of 0 would be meaningless and could result in error.
-
-Some devices have a minimal limit on number of MSI-X interrupts.
-In this case the function could look like this:
-
-static int foo_driver_enable_msix(struct foo_adapter *adapter, int nvec)
-{
-	return pci_enable_msix_range(adapter->pdev, adapter->msix_entries,
-				     FOO_DRIVER_MINIMUM_NVEC, nvec);
-}
-
-4.3.1.2 Exact number of MSI-X interrupts
-
-If a driver is unable or unwilling to deal with a variable number of MSI-X
-interrupts it could request a particular number of interrupts by passing
-that number to pci_enable_msix_range() function as both 'minvec' and 'maxvec'
-parameters:
-
-static int foo_driver_enable_msix(struct foo_adapter *adapter, int nvec)
-{
-	return pci_enable_msix_range(adapter->pdev, adapter->msix_entries,
-				     nvec, nvec);
-}
-
-Note, unlike pci_enable_msix_exact() function, which could be also used to
-enable a particular number of MSI-X interrupts, pci_enable_msix_range()
-returns either a negative errno or 'nvec' (not negative errno or 0 - as
-pci_enable_msix_exact() does).
-
-4.3.1.3 Specific requirements to the number of MSI-X interrupts
-
-As noted above, there could be devices that can not operate with just any
-number of MSI-X interrupts within a range.  E.g., let's assume a device that
-is only capable sending the number of MSI-X interrupts which is a power of
-two.  A routine that enables MSI-X mode for such device might look like this:
-
-/*
- * Assume 'minvec' and 'maxvec' are non-zero
- */
-static int foo_driver_enable_msix(struct foo_adapter *adapter,
-				  int minvec, int maxvec)
-{
-	int rc;
-
-	minvec = roundup_pow_of_two(minvec);
-	maxvec = rounddown_pow_of_two(maxvec);
-
-	if (minvec > maxvec)
-		return -ERANGE;
-
-retry:
-	rc = pci_enable_msix_range(adapter->pdev, adapter->msix_entries,
-				   maxvec, maxvec);
-	/*
-	 * -ENOSPC is the only error code allowed to be analyzed
-	 */
-	if (rc == -ENOSPC) {
-		if (maxvec == 1)
-			return -ENOSPC;
-
-		maxvec /= 2;
-
-		if (minvec > maxvec)
-			return -ENOSPC;
-
-		goto retry;
-	}
-
-	return rc;
-}
-
-Note how pci_enable_msix_range() return value is analyzed for a fallback -
-any error code other than -ENOSPC indicates a fatal error and should not
-be retried.
-
-4.3.2 pci_enable_msix_exact
-
-int pci_enable_msix_exact(struct pci_dev *dev,
-			  struct msix_entry *entries, int nvec)
-
-This variation on pci_enable_msix_range() call allows a device driver to
-request exactly 'nvec' MSI-Xs.
-
-If this function returns a negative number, it indicates an error and
-the driver should not attempt to allocate any more MSI-X interrupts for
-this device.
-
-By contrast with pci_enable_msix_range() function, pci_enable_msix_exact()
-returns zero in case of success, which indicates MSI-X interrupts have been
-successfully allocated.
-
-Another version of a routine that enables MSI-X mode for a device with
-specific requirements described in chapter 4.3.1.3 might look like this:
-
-/*
- * Assume 'minvec' and 'maxvec' are non-zero
- */
-static int foo_driver_enable_msix(struct foo_adapter *adapter,
-				  int minvec, int maxvec)
-{
-	int rc;
-
-	minvec = roundup_pow_of_two(minvec);
-	maxvec = rounddown_pow_of_two(maxvec);
-
-	if (minvec > maxvec)
-		return -ERANGE;
-
-retry:
-	rc = pci_enable_msix_exact(adapter->pdev,
-				   adapter->msix_entries, maxvec);
-
-	/*
-	 * -ENOSPC is the only error code allowed to be analyzed
-	 */
-	if (rc == -ENOSPC) {
-		if (maxvec == 1)
-			return -ENOSPC;
-
-		maxvec /= 2;
-
-		if (minvec > maxvec)
-			return -ENOSPC;
-
-		goto retry;
-	} else if (rc < 0) {
-		return rc;
-	}
-
-	return maxvec;
-}
-
-4.3.3 pci_disable_msix
-
-void pci_disable_msix(struct pci_dev *dev)
-
-This function should be used to undo the effect of pci_enable_msix_range().
-It frees the previously allocated MSI-X interrupts. The interrupts may
-subsequently be assigned to another device, so drivers should not cache
-the value of the 'vector' elements over a call to pci_disable_msix().
-
-Before calling this function, a device driver must always call free_irq()
-on any interrupt for which it previously called request_irq().
-Failure to do so results in a BUG_ON(), leaving the device with
-MSI-X enabled and thus leaking its vector.
-
-4.3.3 The MSI-X Table
-
-The MSI-X capability specifies a BAR and offset within that BAR for the
-MSI-X Table.  This address is mapped by the PCI subsystem, and should not
-be accessed directly by the device driver.  If the driver wishes to
-mask or unmask an interrupt, it should call disable_irq() / enable_irq().
-
-4.3.4 pci_msix_vec_count
-
-int pci_msix_vec_count(struct pci_dev *dev)
-
-This function could be used to retrieve number of entries in the device
-MSI-X table.
-
-If this function returns a negative number, it indicates the device is
-not capable of sending MSI-Xs.
-
-If this function returns a positive number, it indicates the maximum
-number of MSI-X interrupt vectors that could be allocated.
-
-4.4 Handling devices implementing both MSI and MSI-X capabilities
-
-If a device implements both MSI and MSI-X capabilities, it can
-run in either MSI mode or MSI-X mode, but not both simultaneously.
-This is a requirement of the PCI spec, and it is enforced by the
-PCI layer.  Calling pci_enable_msi_range() when MSI-X is already
-enabled or pci_enable_msix_range() when MSI is already enabled
-results in an error.  If a device driver wishes to switch between MSI
-and MSI-X at runtime, it must first quiesce the device, then switch
-it back to pin-interrupt mode, before calling pci_enable_msi_range()
-or pci_enable_msix_range() and resuming operation.  This is not expected
-to be a common operation but may be useful for debugging or testing
-during development.
-
-4.5 Considerations when using MSIs
-
-4.5.1 Choosing between MSI-X and MSI
-
-If your device supports both MSI-X and MSI capabilities, you should use
-the MSI-X facilities in preference to the MSI facilities.  As mentioned
-above, MSI-X supports any number of interrupts between 1 and 2048.
-In contrast, MSI is restricted to a maximum of 32 interrupts (and
-must be a power of two).  In addition, the MSI interrupt vectors must
-be allocated consecutively, so the system might not be able to allocate
-as many vectors for MSI as it could for MSI-X.  On some platforms, MSI
-interrupts must all be targeted at the same set of CPUs whereas MSI-X
-interrupts can all be targeted at different CPUs.
-
-4.5.2 Spinlocks
+4.4.1 Spinlocks
 
 Most device drivers have a per-device spinlock which is taken in the
 interrupt handler.  With pin-based interrupts or a single MSI, it is not
@@ -505,7 +144,7 @@ acquire the spinlock.  Such deadlocks can be avoided by using
 spin_lock_irqsave() or spin_lock_irq() which disable local interrupts
 and acquire the lock (see Documentation/DocBook/kernel-locking).
 
-4.6 How to tell whether MSI/MSI-X is enabled on a device
+4.5 How to tell whether MSI/MSI-X is enabled on a device
 
 Using 'lspci -v' (as root) may show some devices with "MSI", "Message
 Signalled Interrupts" or "MSI-X" capabilities.  Each of these capabilities
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f44..6b0834d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2003-2004 Intel
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ * Copyright (C) 2016 Christoph Hellwig.
  */
 
 #include <linux/err.h>
@@ -1120,6 +1121,98 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
+static int __pci_enable_msix_range(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs)
+{
+	int vecs = max_vecs, ret, i;
+
+retry:
+	if (vecs < min_vecs)
+		return -ENOSPC;
+
+	dev->msix_vectors = kmalloc_array(vecs, sizeof(struct msix_entry),
+				GFP_KERNEL);
+	if (!dev->msix_vectors)
+		return -ENOMEM;
+
+	for (i = 0; i < vecs; i++)
+		dev->msix_vectors[i].entry = i;
+
+	ret = pci_enable_msix(dev, dev->msix_vectors, vecs);
+	if (ret)
+		goto out_fail;
+
+	return vecs;
+
+out_fail:
+	kfree(dev->msix_vectors);
+	dev->msix_vectors = NULL;
+
+	if (ret >= 0) {
+		/* retry with the actually supported number of vectors */
+		vecs = ret;
+		goto retry;
+	}
+
+	return ret;
+}
+
+/**
+ * pci_alloc_irq_vectors - allocate multiple IRQs for a device
+ * @dev:		PCI device to operate on
+ * @min_vecs:		minimum number of vectors required (must be >= 1)
+ * @max_vecs:		maximum (desired) number of vectors
+ * @flags:		flags or quirks for the allocation
+ *
+ * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
+ * vectors if available, and fall back to a single legacy vector
+ * if neither is available.  Return the number of vectors allocated,
+ * (which might be smaller than @max_vecs) if successful, or a negative
+ * error code on error. If less than @min_vecs interrupt vectors are
+ * available for @dev the function will fail with -ENOSPC.
+ *
+ * To get the Linux irq number used for a vector that can be passed to
+ * request_irq use the pci_irq_vector() helper.
+ */
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs, unsigned int flags)
+{
+	int vecs;
+
+	if (!(flags & PCI_IRQ_NOMSIX)) {
+		vecs = __pci_enable_msix_range(dev, min_vecs, max_vecs);
+		if (vecs > 0)
+			return vecs;
+	}
+
+	if (!(flags & PCI_IRQ_NOMSI)) {
+		vecs = pci_enable_msi_range(dev, min_vecs, max_vecs);
+		if (vecs > 0)
+			return vecs;
+	}
+
+	/* use legacy irq if allowed */
+	if (min_vecs == 1)
+		return 1;
+	return -ENOSPC;
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors);
+
+/**
+ * pci_free_irq_vectors - free previously allocated IRQs for a device
+ * @dev:		PCI device to operate on
+ *
+ * Undoes the allocations and enabling in pci_alloc_irq_vectors().
+ */
+void pci_free_irq_vectors(struct pci_dev *dev)
+{
+	if (dev->msix_enabled)
+		kfree(dev->msix_vectors);
+	pci_disable_msix(dev);
+	pci_disable_msi(dev);
+}
+EXPORT_SYMBOL(pci_free_irq_vectors);
+
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b67e4df..129871f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -320,6 +320,7 @@ struct pci_dev {
 	 * directly, use the values stored here. They might be different!
 	 */
 	unsigned int	irq;
+	struct msix_entry *msix_vectors;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 
 	bool match_driver;		/* Skip attaching driver */
@@ -1237,6 +1238,9 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
 
+#define PCI_IRQ_NOMSI		(1 << 0) /* don't try to use MSI interrupts */
+#define PCI_IRQ_NOMSIX		(1 << 1) /* don't try to use MSI-X interrupts */
+
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
 #include <linux/pci-dma.h>
@@ -1284,6 +1288,24 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		return rc;
 	return 0;
 }
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs, unsigned int flags);
+void pci_free_irq_vectors(struct pci_dev *dev);
+
+
+/**
+ * pci_irq_vector - return Linux IRQ number of a device vector
+ * @dev: PCI device to operate on
+ * @nr: device-relative interrupt vector index (0-based).
+ */
+static inline unsigned int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
+{
+	if (dev->msix_enabled)
+		return dev->msix_vectors[nr].vector;
+
+	WARN_ON_ONCE(!dev->msi_enabled && nr > 0);
+	return dev->irq + nr;
+}
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline void pci_msi_shutdown(struct pci_dev *dev) { }
@@ -1307,6 +1329,23 @@ static inline int pci_enable_msix_range(struct pci_dev *dev,
 static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		      struct msix_entry *entries, int nvec)
 { return -ENOSYS; }
+static inline int pci_alloc_irq_vectors(struct pci_dev *dev,
+		unsigned int min_vecs, unsigned int max_vecs,
+		unsigned int flags)
+{
+	if (min_vecs > 1)
+		return -ENOSPC;
+	return 1;
+}
+static inline void pci_free_irq_vectors(struct pci_dev *dev)
+{
+}
+
+static inline unsigned int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
+{
+	WARN_ON_ONCE(nr > 0);
+	return dev->irq;
+}
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
-- 
2.1.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
