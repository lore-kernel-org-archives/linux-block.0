Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:31645 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935842AbeFMPlT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 11:41:19 -0400
Date: Wed, 13 Jun 2018 09:44:15 -0600
From: Keith Busch <keith.busch@intel.com>
To: "Austin.Bolen@dell.com" <Austin.Bolen@dell.com>
Cc: "keith.busch@linux.intel.com" <keith.busch@linux.intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@osandov.com" <osandov@osandov.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: blktests block/019 lead system hang
Message-ID: <20180613154415.GC5574@localhost.localdomain>
References: <838678680.4693215.1527664726174.JavaMail.zimbra@redhat.com>
 <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
 <20180605161853.GB16899@localhost.localdomain>
 <5a3a2565a81543b5837672e01580a5b5@AUSX13MPC127.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5a3a2565a81543b5837672e01580a5b5@AUSX13MPC127.AMER.DELL.COM>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 12, 2018 at 04:41:54PM -0700, Austin.Bolen@dell.com wrote:
> It looks like the test is setting the Link Disable bit.  But this is not
> a good simulation for hot-plug surprise removal testing or surprise link
> down (SLD) testing, if that is the intent.  One reason is that Link
> Disable does not invoke SLD semantics per PCIe spec.  This is somewhat
> of a moot point in this case since the switch has Hot-Plug Surprise bit
> set which also masks the SLD semantics in PCIe.
> 
> Also, the Hot-Plug Capable + Surprise Hot-Plug bits set means the
> platform can tolerate the case where "an adapter present in this slot
> might be removed from the system without any prior notification".  It
> does not mean that a system can survive link down under any other
> circumstances such as setting Link Disable or generating a Secondary Bus
> Reset or a true surprise link down event.  To the earlier point, I also
> do not know of any way the OS can know a priori if the platform can
> handle surprise link down outside of surprise remove case.  We can look
> at standardizing a way to do that if OSes find it useful to know.
> 
> Relative to this particular error, Link Disable doesn't clear Presence
> Detect State which would happen on a real Surprise Hot-Plug removal
> event and this is probably why the system crashes.  What will happen is
> that after the link goes to disabled state, the ongoing I/O will cause
> MMIO accesses on the drive and that will cause a UR which is an
> uncorrectable PCIe error (ERR_FATAL on R730).  The BIOS on the R730 is
> surprise remove aware (Surprise Hot-Plug = 1) and so it will check if
> the device is still present by checking Presence Detect State.  If the
> device is not present it will mask the error and let the OS handle the
> device removal due to hot-plug interrupt(s).  If the device is present,
> as in this case, then the BIOS will escalate to OS as a fatal NMI
> (current R730 platform policy is to only mask errors due to removal).
> 
> For future, these servers may report these sort of errors as recoverable
> via the GHES structures in APEI which will allow the OS to recover from
> this non-surprise remove class of error as well.  In the (hopefully
> near) future, the industry will move to DPC as the framework for this
> sort of generic PCIe error handling/recovery but there are architectural
> changes needed that are currently being defined in the relevant
> standards bodies.  Once the architecture is defined it can be
> implemented and tested to verify these sort of test cases pass.

Thanks for the feedback!

This test does indeed toggle the Link Control Link Disable bit to simulate
the link failure. The PCIe specification specifically covers this case
in Section 3.2.1, Data Link Control and Management State Machine Rules:

  If the Link Disable bit has been Set by software, then the subsequent
  transition to DL_Inactive must not be considered an error.

So this test should suppress any Suprise Down Error events, but handling
that particular event wasn't the intent of the test (and as you mentioned,
it ought not occur anyway since the slot is HP Surprise capable).

The test should not suppress reporting the Data Link Layer State Changed
slot status. And while this doesn't trigger a Slot PDC status, triggering
a DLLSC should occur since the Link Status DLLLA should go to 0 when
state machine goes from DL_Active to DL_Down, regardless of if a Suprise
Down Error was detected.

The Linux PCIEHP driver handles a DLLSC link-down event the same as
a presence detect remove event, and that's part of what this test was
trying to cover.
