Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33983 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdA1NVv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2017 08:21:51 -0500
Date: Sat, 28 Jan 2017 07:52:51 -0500
From: Tejun Heo <tj@kernel.org>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        linux-block@vger.kernel.org, stable@vger.kernel.org,
        Guilherme Piccoli <gpiccoli@br.ibm.com>
Subject: Re: [PATCH V3 1/1] percpu-refcount: fix reference leak during
 percpu-atomic transition
Message-ID: <20170128125251.GA5797@mtj.duckdns.org>
References: <1485607340-13728-1-git-send-email-dougmill@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485607340-13728-1-git-send-email-dougmill@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jan 28, 2017 at 06:42:20AM -0600, Douglas Miller wrote:
> percpu_ref_tryget() and percpu_ref_tryget_live() should return
> "true" IFF they acquire a reference. But the return value from
> atomic_long_inc_not_zero() is a long and may have high bits set,
> e.g. PERCPU_COUNT_BIAS, and the return value of the tryget routines
> is bool so the reference may actually be acquired but the routines
> return "false" which results in a reference leak since the caller
> assumes it does not need to do a corresponding percpu_ref_put().

Applied to percpu/for-4.10-fixes w/ stable cc'd.

Thanks!

-- 
tejun
